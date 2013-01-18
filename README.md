markupValidatorBash
===================

Check URLs for changes in errors returned from W3Cs markup validator

Provide a space-separated list of URLs to check as variable URLS
e. g. in bash:  $ URLS="http://www.google.com http://www.google.com/search/"

It will check and save w3's html output for the validation. If you run it again, it will compare the output and if there's a change, e. g. more or less errors than the last time, exit status is 1. When there are no changes, exit status is 0.

This is useful as a Jenkins job, for example. Some of the stuff you include on your website might not be under your control and therefore you tolerate errors the w3 validator finds. But whenever the output changes you will be notified.

See http://validator.w3.org
