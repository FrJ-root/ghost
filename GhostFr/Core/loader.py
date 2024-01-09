"""
MIT License

Copyright (c) 2020-2024 EntySec

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
"""

import importlib.util
import os

from typing import Any


class Loader(object):
    """ Subclass of ghost.core module.

    This subclass of ghost.core module is intended for providing
    Ghost Framework loader.
    """

    def __init__(self) -> None:
        super().__init__()

    @staticmethod
    def import_modules(path: str, device: Any) -> dict:
        """ Import modules for the specified device.

        :param str path: path to import modules from
        :param Any device: device to import modules for
        :return dict: dict of modules
        """

        modules = {}

        for mod in os.listdir(path):
            if mod == '__init__.py' or mod[-3:] != '.py':
                continue
            else:
                try:
                    spec = importlib.util.spec_from_file_location(path + '/' + mod, path + '/' + mod)
                    module = importlib.util.module_from_spec(spec)
                    spec.loader.exec_module(module)
                    module = module.GhostModule()

                    module.device = device
                    modules[module.details['Name']] = module
                except Exception:
                    pass

        return modules

    def load_modules(self, device) -> dict:
        """ Load modules for the specified device and get their commands.

        :param Device device: device to load modules for
        :return dict: dict of modules commands
        """

        return self.import_modules(f'{os.path.dirname(os.path.dirname(__file__))}/modules', device)
