#!/bin/sh

# This script will look through the console log for the text
# "(log file is located at..."
# This is message printed by bitbake when an error is reported and refers to
# the full log of that bitbake step for that component (e.g.
# log.do_compile.8790). To complement the console-log, these detailed logs are
# often necessary for evaluating what actually happened during that step for
# that component.  We therefore extract (only) those that are mentioned in an
# error, and place them where the CI system can find and publish them separately.
#
# As you can see it assumes to be in the GDP project root, i.e. should be
# run as scripts/publish_error_log_files.sh

console_log=$(readlink -f gdp-src-build/tmp/log/cooker/*/console-latest.log)
echo "Looking for any error logs from: $console_log"
publish_dir=artifacts/error_logs
combined_file="$publish_dir/all_logs_combined.txt"

# There should only be one console log but just in case, let's loop:
err_log_files=
for f in $console_log ; do 
  err_log_files="$err_log_files $(egrep 'ERROR:.*\(log file' < "$f" | sed 's!.*(log file is located at \([^)]*\))!\1!')"
done


write() {
  echo "$1" >>$combined_file
}

# debug
echo "$err_log_files" | wc -c

# Creating this dir should be done unconditionally, because the CI system
# otherwise reports failure because the expected artifact does not exist.
mkdir -p $publish_dir

if [ $(echo "$err_log_files" | wc -c) -gt 2 ] ; then
  echo Found error log files: $err_log_files
  cp -L $err_log_files $publish_dir/
  for f in $console_log $err_log_files ; do
    write "==========================================================================="
    write " $(basename $f)"
    write "==========================================================================="
    write
    cat $f >>"$combined_file"
    write
  done
  cd "$publish_dir"
  for f in $err_log_files ; do
    f=$(basename $f)
    mv $f $f.txt
  done
  echo Copied error logs:
  ls -al $publish_dir
fi

