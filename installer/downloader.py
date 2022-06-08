import os
from . import download

print("[INFO] Welcome to EUtil installer!")
install_user = input("[INFO] Install the software? [Y/n] ")
install_bool = True if install_user.lower() == "y" else False

if install_bool:
    print("[INFO] Tip: The installation won't take longer than 20 seconds, trust me!")
    download.download(path="EasyUtil_Windows/", url="https://github.com/heewoonkim2020/EasyUtil/archive/refs/heads/main.zip")
else:
    print("[INFO] Ok, cancelling installation")
    print("[INFO] Thank You And Goodbye")
