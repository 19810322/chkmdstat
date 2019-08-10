# chkmdstat

This script detects mdraid disk array degraded and notify via chat tool.

How to detect degrade
---------------------

1. cat /proc/mdstat
2. grep "_"(underscore)

Install
-------

This is bash script. You may save and execute any directory.
You must configure webhook or LINE Notify on chat services, get token text and append some token into script.

Usage
-----

/path/to/chkmdstat.sh [boot]
- boot: initialize option.
