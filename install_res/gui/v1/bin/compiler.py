class exceptions:
    class PluginLoadException(Exception): pass
    class TickingEntityException(Exception): pass
    class PluginMethodException(Exception): pass
    class NonePointerException(Exception): pass

class PluginMethod:
    def __init__(self, method_name: str, method_action):
        self.name = method_name
        self.action = method_action
        if method_name == "onClientConnect":
            print("[INFO] Loaded 3 plugins for `onClientConnect`")
        else:
            raise exceptions.PluginMethodException("Unknown or invalid method.")


class PyPlugin:
    def __init__(self, plugin_name: str, plugin_version: str, init_run: bool = False, inherit_top: bool = True,
                 methods: tuple = []):
        self.name = plugin_name
        self.version = plugin_version
        self.inherit = "topper" if inherit_top else "lower"
        if init_run:
            self.run()
        for method in methods:
            if type(method) is PluginMethod:
                print("[INFO] Loaded method.")
            else:
                raise exceptions.PluginMethodException("Auto method object is not a method")

    def run(self):
        print("[INFO] Loading {} v{}".format(self.name, self.version))
        if self.inherit == "topper":
            raise exceptions.PluginLoadException("Plugin layer is not set")
        print("[INFO] Enabling {} v{}".format(self.name, self.version))

    def add_method(self, method: PluginMethod):
        print("[INFO] Init method: method `{}`".format(method.name))
        if type(method) is PluginMethod:
            print("[INFO] Auto method is not set")
