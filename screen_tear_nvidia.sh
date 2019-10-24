#!/bin/bash

#usually named screen_tear.sh

#
# Fix screen tearing in nvidia
#

LOG=screentearlog.log

if [ -f "screentearlog.log" ]; then
  nvidia-settings --assign CurrentMetaMode="nvidia-auto-select +0+0 { ForceFullCompositionPipeline = On }"

  echo "screen tear fixed" >> ${LOG}

  date | tee -a ${LOG}

  echo "---------------------------" >> ${LOG}
else
  touch ${LOG}

  nvidia-settings --assign CurrentMetaMode="nvidia-auto-select +0+0 { ForceFullCompositionPipeline = On }"

  echo "screen tear fixed" >> ${LOG}

  date | tee -a ${LOG}

  echo "---------------------------" >> ${LOG}

fi
