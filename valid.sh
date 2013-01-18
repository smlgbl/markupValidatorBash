#!/bin/bash

if [ -z "$URLS" ]; then
	echo "Please provide some URLs to check in the environment variable URLS"
	exit 1
fi

if [ -z "$DIFF_OPTIONS" ]; then
	DIFF_OPTIONS="-q -I '[[:digit:]]\+'"
fi

RETURN_VAL=0
VALIDATOR_URL="http://validator.w3.org/check?uri="

mkdir -p checked
mkdir -p changed
rm -f changed/*

for url in $URLS;
do  
    filename=`echo $url | sed -e 's#/#-#g'`
    echo "Checking ${url}"
    if [ -e ./checked/${filename} ]; then
        mv ./checked/${filename} ./checked/${filename}.old;
    fi

    wget -O ./checked/${filename} ${VALIDATOR_URL}${url}

    if [ -e ./checked/${filename}.old ]; then
        echo "Old file exists"
        if [ -e ./checked/${filename} ]; then
                echo "New file exists as well. Diffing ..."
                diff $DIFF_OPTIONS ./checked/${filename}.old ./checked/${filename}
                if [ $? == 1 ]; then
                	cp ./checked/${filename} ./changed/;
					RETURN_VAL=1
				else
					echo "Same difference"
        		fi
		else
			echo "New file doesn't exist"
    	fi
	else
		echo "Old file doesn't exitst"
	fi
done

exit $RETURN_VAL
