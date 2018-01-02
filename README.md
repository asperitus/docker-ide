#GUI in a docker

https://stackoverflow.com/questions/16296753/can-you-run-gui-apps-in-a-docker-container/25280523#25280523
https://virtualizationreview.com/articles/2017/02/08/graphical-programs-on-windows-subsystem-on-linux.aspx

#Mac OSX

ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

X Server:

https://www.xquartz.org/
or brew cask install xquartz

open -a XQuartz

brew install socat  

socat TCP-LISTEN:6000,reuseaddr,fork UNIX-CLIENT:\"$DISPLAY\"

Docker (CE):

https://docs.docker.com/docker-for-mac/install/

#Windows 10

X Server:

http://www.straightrunning.com/XmingNotes/
http://sourceforge.net/projects/xming/files/Xming/6.9.0.31/Xming-6-9-0-31-setup.exe/download

Docker (CE):

Pro (Hyper-V): 
https://docs.docker.com/docker-for-windows/install/#download-docker-for-windows

Home / Pro (no Hyper-V): 
https://docs.docker.com/toolbox/overview/
https://www.virtualbox.org/wiki/Downloads

C:\Users\<user>\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Docker

WSL (Windows Subsystem for Linux)

https://docs.microsoft.com/en-us/windows/wsl/interop
https://nickjanetakis.com/blog/setting-up-docker-for-windows-and-wsl-to-work-flawlessly
https://github.com/qiangli/docker.git


#Ubuntu (Linux)

##
