#
#	This file is part of the OrangeFox Recovery Project
# 	Copyright (C) 2018-2020 The OrangeFox Recovery Project
#	
#	OrangeFox is free software: you can redistribute it and/or modify
#	it under the terms of the GNU General Public License as published by
#	the Free Software Foundation, either version 3 of the License, or
#	any later version.
#
#	OrangeFox is distributed in the hope that it will be useful,
#	but WITHOUT ANY WARRANTY; without even the implied warranty of
#	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#	GNU General Public License for more details.
#
# 	This software is released under GPL version 3 or any later version.
#	See <http://www.gnu.org/licenses/>.
# 	
# 	Please maintain this if you use this script or any part of it
#

#set -o xtrace
fox_get_target_device() {
local F="$BASH_ARGV"
   [ -z "$F" ] && F="$BASH_SOURCE"
   if [ -n "$F" ]; then
      local D1=$(dirname "$F")
      local D2=$(basename "$D1")
      [ -n "$D2" ] && echo "$D2"
   fi
}

if [ -z "$1" -a -z "$FOX_BUILD_DEVICE" ]; then
   FOX_BUILD_DEVICE=$(fox_get_target_device)
fi

FDEVICE="santoni"

if [ "$1" = "$FDEVICE" -o "$FOX_BUILD_DEVICE" = "$FDEVICE" ]; then
        export PLATFORM_VERSION="16.1.0"
   	export PLATFORM_SECURITY_PATCH="2099-12-31"
   	export TW_DEFAULT_LANGUAGE="en"
   	export OF_DONT_PATCH_ENCRYPTED_DEVICE="1"
   	export FOX_USE_BASH_SHELL="1"
   	export FOX_ASH_IS_BASH="1"
   	export FOX_USE_NANO_EDITOR="1"
	export FOX_USE_TAR_BINARY="1"
	export FOX_USE_ZIP_BINARY="1"
   	export FOX_REPLACE_BUSYBOX_PS="1"
   	# export OF_DISABLE_DM_VERITY_FORCED_ENCRYPTION="1"; # disabling dm-verity causes stability issues with some kernel 4.9 ROMs; but is needed for MIUI
	# export OF_DISABLE_FORCED_ENCRYPTION=1
   	export FOX_USE_TWRP_RECOVERY_IMAGE_BUILDER="1"
   	export OF_CHECK_OVERWRITE_ATTEMPTS="1"
   	export OF_USE_MAGISKBOOT_FOR_ALL_PATCHES="1"
   	export OF_USE_MAGISKBOOT="1"
    export OF_USE_LOCKSCREEN_BUTTON="1"
	export OF_FORCE_MAGISKBOOT_BOOT_PATCH_MIUI="1"
   	export OF_NO_MIUI_OTA_VENDOR_BACKUP="1"
   	export OF_NO_TREBLE_COMPATIBILITY_CHECK="1"
    export OF_MAINTAINER=Jabiyeff
    export OF_SKIP_MULTIUSER_FOLDERS_BACKUP="1"
    export OF_SKIP_FBE_DECRYPTION="1"


	# OTA for custom ROMs
        export OF_SUPPORT_ALL_BLOCK_OTA_UPDATES="1"
        export OF_FIX_OTA_UPDATE_MANUAL_FLASH_ERROR="1"

        # -- add settings for R11 --
        export FOX_R11="1"
        export OF_USE_TWRP_SAR_DETECT="1"
        export OF_DISABLE_MIUI_OTA_BY_DEFAULT="1"
        export OF_QUICK_BACKUP_LIST="/system_root;/vendor;/data;/persist;/boot;"
        # -- end R11 settings --

	# let's log what are the build VARs that we used
	if [ -n "$FOX_BUILD_LOG_FILE" -a -f "$FOX_BUILD_LOG_FILE" ]; then
  	   export | grep "FOX" >> $FOX_BUILD_LOG_FILE
  	   export | grep "OF_" >> $FOX_BUILD_LOG_FILE
  	   export | grep "TW_" >> $FOX_BUILD_LOG_FILE
  	   export | grep "TARGET_" >> $FOX_BUILD_LOG_FILE
  	   export | grep "PLATFORM_" >> $FOX_BUILD_LOG_FILE
  	fi

	add_lunch_combo omni_"$FDEVICE"-eng
	add_lunch_combo omni_"$FDEVICE"-userdebug
fi
#
