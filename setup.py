#!/usr/bin/env python

from setuptools import setup, find_packages

requirements = []

setup(
    package_dir={'': 'src'},
    install_requires=requirements,
    include_package_data=True,
    keywords='img2table',
    name='img2table',
    packages=find_packages(include=['img2table', 'img2table.*']),
    test_suite='tests',
    version='0.1.2',
    zip_safe=False,
)
