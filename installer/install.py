# All binary code is extracted into a large folder that exceeds file limit

# TODO Cannot access private object from private config.

import os

# Compress files
print("[INFO] Upgrade to a professional installer.")
# TODO Professional TKINTER installer

if os.path.exists("agreement.txt"):
    with open("agreement.txt", "r") as f:
        for line in f.readlines():
            if line.startswith("agree="):
                agree_var = line.split("=")[1]
                if agree_var == "true" or "yes":
                    print("[INFO] Thanks for agreeing to the agreement. You may delete the")
                    print("[INFO] agreement file now.")
                    print("[INFO] [File Operation] Failed to delete 1 file(s)")
                    print("[INFO] [Installation] Starting installer...")
                    from . import downloader
                else:
                    print("[ERROR] Edit agreement.txt so agree=false becomes agree=true.")
else:
    with open("agreement.txt", "w") as f:
        file_txt = """==== AGREEMENT ====
This Python software is not licensed under any possible license and any copy of the software will not be punished.
By installing this software you are supporting the developers. You are promising not to share any personal inform
ation to other people through the clients, including informal and disrespective content.

By setting the above to true, you agree to the above info.
agree=false

# END OF FILE"""
        f.write(file_txt)
