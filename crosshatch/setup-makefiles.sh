#!/bin/bash
#
# Copyright (C) 2017-2019 The LineageOS Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

set -e

VENDOR=google
DEVICE=crosshatch

INITIAL_COPYRIGHT_YEAR=2018

# Load extractutils and do some sanity checks
MY_DIR="${BASH_SOURCE%/*}"
if [[ ! -d "$MY_DIR" ]]; then MY_DIR="$PWD"; fi

GZOSP_ROOT="$MY_DIR"/../../../..

HELPER="$GZOSP_ROOT"/vendor/gzosp/build/tools/extract_utils.sh
if [ ! -f "$HELPER" ]; then
    echo "Unable to find helper script at $HELPER"
    exit 1
fi
. "$HELPER"

# Initialize the helper
setup_vendor "$DEVICE" "$VENDOR" "$GZOSP_ROOT"

# Copyright headers and guards
write_headers

# The standard blobs
write_makefiles "$MY_DIR"/proprietary-files.txt
write_makefiles "$MY_DIR"/proprietary-files-vendor.txt true

# Finish
write_footers
