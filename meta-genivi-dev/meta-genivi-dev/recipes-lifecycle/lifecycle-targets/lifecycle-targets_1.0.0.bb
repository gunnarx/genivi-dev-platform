#
# Install basic system files for booting and lifecycle states.
#
SUMMARY = "Platform definition for System Boot, Lifecycle, etc."
DESCRIPTION = "Configuration files and systemd units that define our \
Lifecycle states and possibly other platform-specific definitions"
SECTION = "base"
LICENSE = "MPL-2.0"

DEPENDS = "systemd"

# FIXME CHECK
HOMEPAGE = "https://at.projects.genivi.org/GENIVI+Dev+Platform"

FILESEXTRAPATHS_append := ":${THISDIR}/files"

SRC_URI= " \
    file://system.conf \
    file://focused.target \
    file://unfocused.target \
    file://lazy.target \
    "

S = "${WORKDIR}/git"

do_install() {
    install -d ${D}${sysconfdir}
    install -m 0644 ${WORKDIR}/system.conf ${D}${sysconfdir}/systemd/system.conf
    install -m 0644 ${WORKDIR}/focused.target   ${D}${systemd_system_unitdir}/focused.target
    install -m 0644 ${WORKDIR}/unfocused.target ${D}${systemd_system_unitdir}/unfocused.target
    install -m 0644 ${WORKDIR}/lazy.target      ${D}${systemd_system_unitdir}/lazy.target
}

