#!/usr/bin/env python
# -*- coding: utf-8 -*-
from setuptools import setup, find_packages
import os
import glob
from distutils.core import setup
import sys

# http://pythonhosted.org/setuptools/setuptools.html#new-and-changed-setup-keywords

def read(fname):
    return open(os.path.join(os.path.dirname(__file__), fname)).read().rstrip()
    
setup(
	name='hethio-server',
	version=read('VERSION.txt'),
	install_requires = [], #['paho-mqtt','mysql-connector-python'],  # python dependencies
	
	packages = find_packages(),
	py_modules = ['hethio-server'],
	scripts=glob.glob('bin/*'),
	data_files = [
		('share/hethio-server', glob.glob('data/*')),
		('/etc/init.d', ['hethio-server-servicefile']),
		('/usr/share/man/man8', glob.glob('man/*.gz'))
		],
	include_package_data = True, 
    zip_safe = True,


	author='Daniel Moran',
	author_email='danielheth@hotmail.com',
	url='https://heth.io',
	description='Internet monitoring server',
	long_description=read('README.rst'),
	license='GPLv3',
)