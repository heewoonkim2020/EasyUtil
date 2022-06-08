from . import exceptions

class PyPlugin:
    def __init__(self, plugin_name: str, plugin_version: str, inherit_top: bool = True):
        self.name = plugin_name
        self.version = plugin_version
        self.inherit = "topper" if inherit_top else "lower"

    def run(self):
        print("[INFO] Loading {} v{}".format(self.name, self.version))
        if self.inherit == "topper":
            raise exceptions.PluginLoadException("Plugin layer is not set")
        print("[INFO] Enabling {} v{}".format(self.name, self.version))
