require genivi-dev-platform.bb

DESCRIPTION = "GENIVI Development Platform image that includes everything within \
genivi-dev-platform plus meta-toolchain, development headers and libraries \
to form a standalone SDK."

inherit populate_sdk populate_sdk_qt5

IMAGE_FEATURES_append = "\
	debug-tweaks         \
	dev-pkgs             \
	eclipse-debug        \
	qtcreator-debug      \
	tools-debug          \
	tools-profile        \
	tools-sdk            \
	tools-testapps       \
	"

IMAGE_INSTALL_append  = "\
	kernel-dev           \
	"

# These do not build with gcc7 and we do not really have the resources
# to try and fix this with backports and what not.
#
# Simply remove from the SDK as we do not rely on these components

RRECOMMENDS_packagegroup-qt5-toolchain-target_remove = "\
	qtwebkit-dev \
	qtwebkit-mkspecs \
	qtwebkit-qmlplugins \
	qtcreator \
"


RDEPENDS_packagegroup-qt5-toolchain-target_remove = "\
	qtwebkit-dev \
	qtwebkit-mkspecs \
	qtwebkit-qmlplugins \
	qtcreator \
"

DEPENDS_packagegroup-qt5-toolchain-target_remove = "\
qtcreator \
"

