import sys
import time

print("[INFO] Starting PyPlugin compiler.")
print("[INFO] Importing modules, PLEASE WAIT")

import compiler as cc

try:
    testPlugin = cc.PyPlugin("Test", "1.0", init_run=False, inherit_top=True)
    testPlugin.run()
except:
    print("[ERROR] Error while loading TestPlugin v1.0")
    while True:
        time.sleep(0.5)
        print("java.nio.IOException (Unknown object)")
        print("  at java.newVPS.ServerRun().SendHeartBeat.schecker")
        print("  at java.newVPS.nio.ns.ServerCheck")
        print("  at java.newVPS.nio.sun.nio.IOException")
        print("  at org.easyutil.serverportrun")
        print("  at org.bukkit.LivingEntity.SendThreadBeat")
        print("  at java.nio.unkownChecks.threadHeartBeat.send")

print("[INFO] Test plugin has successfully been enabled!")