#!/usr/bin/env python
# -*- coding: utf-8 -*-
try:
    from setuptools import setup, find_packages
except ImportError:
    from ez_setup import use_setuptools
    use_setuptools()
    from setuptools import setup, find_packages

import os
import glob
import sys

# http://pythonhosted.org/setuptools/setuptools.html#new-and-changed-setup-keywords

def read(fname):
    return open(os.path.join(os.path.dirname(__file__), fname)).read().rstrip()
    
setup(
	name='hethio-server',
	version=read('VERSION.txt'),
	install_requires = [], #['paho-mqtt','mysql-connector-python'],  # python dependencies
	setup_requires = [],
	packages = find_packages(exclude=['ez_setup']),
	py_modules = ['hethio-server'],
	scripts=[
		'usr-bin/hethio-server'
		],
	data_files = [
		('share/hethio-server/', glob.glob('hethio_data/*')),
		('/etc/init.d/', glob.glob('etc-init.d/*')),
		('/usr/share/man/man8/', glob.glob('usr-share-man-man8/*.gz'))
		],
	package_data = {  # Files moved into /usr/share/hethio/
        'hethio_data': ['*.png'],
        'etc-init.d': ['*']
    	},
    include_package_data = True, 
    zip_safe = True,


	author='Daniel Moran',
	author_email='danielheth@hotmail.com',
	url='https://heth.io',
	description='Internet monitoring server',
	long_description=read('README.rst'),
	license='GPLv3',
)