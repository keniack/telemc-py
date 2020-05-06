import os

import setuptools

with open("README.md", "r") as fh:
    long_description = fh.read()

with open("requirements-dev.txt", "r") as fh:
    tests_require = [line for line in fh.read().split(os.linesep) if line]

with open("requirements.txt", "r") as fh:
    install_requires = [line for line in fh.read().split(os.linesep) if line]

setuptools.setup(
    name="symmetry-py-telemc",
    version="0.1.0.dev1",
    author="Thomas Rausch",
    author_email="t.rausch@dsg.tuwien.ac.at",
    description="A Symmetry Telemetry Client Library",
    long_description=long_description,
    long_description_content_type="text/markdown",
    url="https://git.dsg.tuwien.ac.at/mc2/py-telemc",
    packages=setuptools.find_packages(),
    setup_requires=['wheel'],
    test_suite="tests",
    tests_require=tests_require,
    install_requires=install_requires,
    pyton_requires='>=3.6',
    classifiers=[
        "Programming Language :: Python :: 3",
        "Operating System :: OS Independent",
    ],
)

