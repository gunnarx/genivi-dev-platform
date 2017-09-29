FILESEXTRAPATHS_append := ":${THISDIR}/${PN}"

SRC_URI_append = "\
    file://genivi-bluetooth-startup.service \
    file://genivi-bluetooth-startup.sh \
    "

do_install_append() {
	install -d ${D}${libdir}/systemd/user
	install -m 0444 ${WORKDIR}/genivi-bluetooth-startup.service \
	                ${D}${libdir}/systemd/user
	install -m 0755 ${WORKDIR}/genivi-bluetooth-startup.sh \
	                ${D}${bindir}
}

FILES_${PN}_append = "\
    ${libdir}/systemd/user \
    ${bindir} \
"
