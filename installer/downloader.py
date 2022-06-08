import os
from . import download

print("[INFO] Welcome to EUtil installer!")
install_user = input("[INFO] Install the software? [Y/n] ")
install_bool = True if install_user.lower() == "y" else False

if install_bool:
    print("[INFO] Abort installation using Ctrl + C (no-gui installer)")
    download.download(path="EasyUtil_Windows/", url="https://github.com/heewoonkim2020/EasyUtil/raw/main/installer_archives/archive1.zip", replace=True, kind="zip")
else:
    print("[INFO] Ok, cancelling installation")
    print("[INFO] Thank You And Goodbye")
