# chkmdstat

This script detects mdraid disk array degraded and notify via chat tool.

このスクリプトは mdraid ディスクアレイの縮退を検知し、チャットツールで通知します。

How to detect degrade
---------------------

1. cat /proc/mdstat
2. grep "_"(underscore)

Install
-------

This is bash script. You may save and execute any directory.
You must configure webhook or LINE Notify on chat services, get token text and append some token into script.

これは bash　スクリプトですので、任意のディレクトリに保存・実行できます。
スクリプトにチャットツールの webhook トークン (LINEの場合は LINE Notify のトークン) を取得し追記する必要があります。

Usage
-----

/path/to/chkmdstat.sh [boot]
- boot: initialize option.
