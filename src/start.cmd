@ECHO OFF
PUSHD "%~dp0"
set _arch=x86_64
PUSHD "%_arch%"

start "" goodbyedpi.exe -5 --dns-addr 77.88.8.8 --dns-port 1253 --dnsv6-addr 2a02:6b8::feed:0ff --dnsv6-port 1253 --blacklist ..\discord.txt

POPD
POPD
