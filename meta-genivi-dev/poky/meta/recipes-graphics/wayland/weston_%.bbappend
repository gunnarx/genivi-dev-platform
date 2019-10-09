FILESEXTRAPATHS_append := ":${THISDIR}/${PN}"

SRC_URI_append = "\
    file://GDP_AM_Button.png \
    file://GDP_Background.png \
    file://GDP_Browser_Button.png \
    file://start_am-poc.sh \
"

inherit systemd
DEPENDS_append = " systemd"

RDEPENDS_${PN}_append_qemux86 = " mesa-megadriver"
RDEPENDS_${PN}_append_qemux86-64 = " mesa-megadriver"
RDEPENDS_${PN}_append_vexpressa9 = " mesa-megadriver"

EXTRA_OECONF_remove_qemux86-64 = "\
    WESTON_NATIVE_BACKEND=fbdev-backend.so \
"

EXTRA_OECONF_append_qemux86-64 = "\
    WESTON_NATIVE_BACKEND=drm-backend.so \
"

EXTRA_OECONF_append_vexpressa9 = " WESTON_NATIVE_BACKEND=fbdev-backend.so"

EXTRA_OECONF_append_rpi = "\
    WESTON_NATIVE_BACKEND=drm-backend.so \
    --disable-static \
"

CFLAGS_append_rpi ="\
    -I${STAGING_DIR_TARGET}/usr/include/interface/vcos/pthreads \
    -I${STAGING_DIR_TARGET}/usr/include/interface/vmcs_host/linux \
"

do_install_append() {
    install -m644 ${WORKDIR}/GDP*.png ${D}/usr/share/weston
    mkdir -p ${D}/${bindir}/
    cp ${WORKDIR}/start_am-poc.sh ${D}/${bindir}
    mkdir -p ${D}${systemd_unitdir}/system/
    cp ${WORKDIR}/weston.service ${D}${systemd_unitdir}/system/
    mkdir -p ${D}${systemd_unitdir}/system/multi-user.target.wants/
    ln -sf /lib/systemd/system/weston.service ${D}/${systemd_unitdir}/system/multi-user.target.wants/weston.service

}

