# GENIVI Development Platform
The GENIVI Development Platform integrates software components developed by GENIVI into a release that can be downloaded and run on popular hardware development boards.
Quick development of new software components for automotive products is easy on GENIVI Development Platform, and the results can be tested on typical automotive hardware architectures, and then taken further into production systems.

## Download
You might download a released image for your platform below. Most people however choose to set up a build environment and build it from source code, which requires a minimal of setup.

[Download page](https://at.projects.genivi.org/wiki/display/GDP/GENIVI+Demo+Platform+%28GDP%29+Download+page)

### More information on the GDP is below;
* GDP [project home page](https://projects.genivi.org/gdp)
* GDP Master - start at the [GDP page](https://at.projects.genivi.org/wiki/display/GDP) and build the GDP from sources using Yocto
* GDP [releases](https://at.projects.genivi.org/wiki/display/GDP-Releases): information about GDP releases, target boards and peripherals.

Contributing to GDP
----------------------------
Please see the  [MAINTAINERS](https://github.com/genivi/meta-genivi-dev/blob/master/MAINTAINERS) file for information on contacting them as well as instructions for submitting patches.

The GENIVI Development Platform project welcomes contributions:
* Subscribe to the mailing list [here](https://lists.genivi.org/mailman/listinfo/genivi-projects).
* IRC Channel: #automotive in freenode.net
* View or Report bugs: [GENIVI uses JIRA as bug tracker and task management tool](https://at.projects.genivi.org/jira/projects/GDP/issues).

For information about the Yocto Project, check the [Yocto Project website](https://www.yoctoproject.org).  

For information about the Yocto GENIVI Baseline, see [Yocto GENIVI Baseline website](http://at.projects.genivi.org/display/Meta-IVI).

genivi-dev-platform.git usage
------------------------------------
This project uses git submodules to pull in all layer dependencies, which
makes it very easy to get started.  You can use the --recursive option for
the intial clone to automatically download all submodules.  (And
even if you don't, the init script for the build will populate (only) the
layers you need for the chosen target.)

Tag and Branching strategy
------------------

[Semantic versioning](https://semver.org)) based tags are created for each major and minor release.

Previous release 'maintenance' branches are available, named <NN>.x, e.g. 14.x for maintenance of release 14, etc.

Note that older versions may require a different set of usage instructions, please refer to the README stored with that version.

Building
--------

```
    git clone <thisrepo> -b <branch>
```

To initiate the build environment:

```
    source init.sh <target>
```

The current supported targets are qemux86-64, porter, raspberrypi2, raspberrypi3,
minnowboard, silk, r-car-m3-starter-kit and r-car-h3-starter-kit.
Dragonboard (Qualcomm) can be built but is only community supported.

The `init.sh` script (run with bash) handles the the `$target` specific
bitbake configuration. The `$target` templates can be found in
gdp-src-build/templates, as well as common configuration `.inc` files.
`init.sh` also handles the relevant git submodule initiation.

Only two instructions needed for a standard build:

```
    source ./init.sh <target>
    bitbake genivi-dev-platform
```

For a full featured script with a lot of options for tweaking the build,
you might also look into scripts/ci-build.sh


