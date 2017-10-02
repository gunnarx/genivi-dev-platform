# There's a permissions problem that I have not found the true root cause
# for: qtbase installed the environment-setup.d dir and it ended up having
# 775 permissions, whereas others (cmake) installed it with 755.  This
# caused a conflict when the filesystem is populated from the cmake and
# qtbase RPMs. (The transaction check step will claim there is a conflict
# between two packages installing environment-setup.d but won't specify
# that it is a permissions difference.  I have learned now that if the
# conflict is for a directory, then it's reasonable to infer that the cause
# is a difference in permissions/ownership).
#
# WORKAROUND HACK: Create the directory here, in case it has not been, and
# make sure it has the right permissions.
#
# NOTE carefully that nativesdk-qtbase in meta-qt5 has a custom python
# function running *after* install:
#
#    nativesdk-qtbase:   addtask generate_qt_environment_file after
#                        do_install before do_package
#
# So....  It
# is where the directory is normally created but since it already exist
# hopefully the dir permissions won't be screwed up.
# (Otherwise, that function seems suspect in creating the problem)


do_install_append_class-nativesdk() {
   # Test, and workaround for permission mismatch on directory
   mkdir -p ${D}${SDKPATHNATIVE}/environment-setup.d
   ls -al ${D}${SDKPATHNATIVE} | fgrep environment-setup.d | fgrep "drwxr-xr-x"
   if [ $? -eq 0 ] ; then
      echo "nativesdk-qtbase.bbappend:do_install NOTE: environment-setup.d seems to have the right permissions:"
      ls -al ${D}${SDKPATHNATIVE} | fgrep environment-setup.d
   else
      echo "nativesdk-qtbase.bbappend:do_install NOTE: environment-setup.d did not have expected 755 permissions -- fixing!"
      ls -al ${D}${SDKPATHNATIVE} | fgrep environment-setup.d
      chmod 755 ${D}${SDKPATHNATIVE}/environment-setup.d
      ls -al ${D}${SDKPATHNATIVE} | fgrep environment-setup.d
   fi
   ls -al ${D}${SDKPATHNATIVE}/environment-setup.d | fgrep "drwxr-xr-x" || {
      echo "Permissions still not fixed?"
      ls -al ${D}${SDKPATHNATIVE}
   }
}

