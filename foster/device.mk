# NVIDIA Tegra TK1 "Jetson" development system
#
# Copyright (c) 2016 NVIDIA Corporation.  All rights reserved.
#
# Copyright (C) 2016 The CyanogenMod Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

PRODUCT_AAPT_CONFIG := normal large xlarge hdpi xhdpi
PRODUCT_AAPT_PREF_CONFIG := xhdpi

## Common packages
$(call inherit-product-if-exists, vendor/nvidia/tegra/core/nvidia-tegra-vendor.mk)
$(call inherit-product-if-exists, vendor/nvidia/tegra/core/android/t124/full.mk)


# Need AppWidget permission to prevent from Launcher's crash.
# TODO(pattjin): Remove this when the TV Launcher is used, which does not support AppWidget.
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.software.app_widgets.xml:system/etc/permissions/android.software.app_widgets.xml

$(call inherit-product, frameworks/native/build/tablet-10in-xhdpi-2048-dalvik-heap.mk)

# Boot Animation
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/bootanimation.zip:system/media/bootanimation.zip

# Atheros Wifi Loader
$(LOCAL_PATH)/ath9k_loader.sh:system/bin/ath9k_loader.sh

# Keylayouts
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/keylayouts/AliTV_Remote_V1_Airmouse.idc:system/usr/idc/AliTV_Remote_V1_Airmouse.idc \
    $(LOCAL_PATH)/keylayouts/AliTV_Remote_V1_Airmouse.kl:system/usr/keylayout/AliTV_Remote_V1_Airmouse.kl \
    $(LOCAL_PATH)/keylayouts/ADT-1_Remote.kl:system/usr/keylayout/ADT-1_Remote.kl \
    $(LOCAL_PATH)/keylayouts/Nexus_Remote.kl:system/usr/keylayout/Nexus_Remote.kl \
    $(LOCAL_PATH)/keylayouts/Vendor_20a0_Product_0001.kl:system/usr/keylayout/Vendor_20a0_Product_0001.kl \
    $(LOCAL_PATH)/keylayouts/Vendor_18d1_Product_2c40.kl:system/usr/keylayout/Vendor_18d1_Product_2c40.kl

# Permissions
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.bluetooth_le.xml:system/etc/permissions/android.hardware.bluetooth_le.xml \
    frameworks/native/data/etc/android.hardware.bluetooth.xml:system/etc/permissions/android.hardware.bluetooth.xml \
    frameworks/native/data/etc/android.hardware.ethernet.xml:system/etc/permissions/android.hardware.ethernet.xml \
    frameworks/native/data/etc/android.hardware.hdmi.cec.xml:system/etc/permissions/android.hardware.hdmi.cec.xml \
    frameworks/native/data/etc/android.hardware.location.xml:system/etc/permissions/android.hardware.location.xml \
    frameworks/native/data/etc/android.hardware.usb.accessory.xml:system/etc/permissions/android.hardware.usb.accessory.xml \
    frameworks/native/data/etc/android.hardware.usb.host.xml:system/etc/permissions/android.hardware.usb.host.xml \
    frameworks/native/data/etc/android.hardware.wifi.direct.xml:system/etc/permissions/android.hardware.wifi.direct.xml \
    frameworks/native/data/etc/android.hardware.wifi.xml:system/etc/permissions/android.hardware.wifi.xml \
    $(LOCAL_PATH)/permissions/com.nvidia.nvsi.xml:system/etc/permissions/com.nvidia.nvsi.xml \
    $(LOCAL_PATH)/permissions/jetson_hardware.xml:system/etc/permissions/jetson_hardware.xml \
    $(LOCAL_PATH)/permissions/tv_core_hardware.xml:system/etc/permissions/tv_core_hardware.xml \
    $(LOCAL_PATH)/permissions/com.google.android.tv.installed.xml:system/etc/permissions/com.google.android.tv.installed.xml

# NVIDIA
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/permissions/com.nvidia.feature.xml:system/etc/permissions/com.nvidia.feature.xml

# HDMI
PRODUCT_PROPERTY_OVERRIDES += ro.hdmi.device_type=4

# TWRP Recovery fstab
PRODUCT_COPY_FILES += \
     device/nvidia/foster/recovery/etc/twrp.fstab:recovery/root/etc/twrp.fstab

# Codec Configs
PRODUCT_COPY_FILES += \
    frameworks/av/media/libstagefright/data/media_codecs_google_audio.xml:system/etc/media_codecs_google_audio.xml \
    frameworks/av/media/libstagefright/data/media_codecs_google_video.xml:system/etc/media_codecs_google_video.xml \
    $(LOCAL_PATH)/media/media_codecs.xml:system/etc/media_codecs.xml \
    $(LOCAL_PATH)/media/media_profiles.xml:system/etc/media_profiles.xml

# wifi
PRODUCT_PACKAGES += \
    libwpa_client \
    hostapd \
    dhcp.conf \
    wpa_supplicant \
    wpa_supplicant.conf
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/wifi/wpa_supplicant_overlay.conf:system/etc/wifi/wpa_supplicant_overlay.conf \
    $(LOCAL_PATH)/wifi/wpa_supplicant.conf:system/etc/wifi/wpa_supplicant.conf
PRODUCT_PROPERTY_OVERRIDES += \
    wifi.interface=wlan0

$(call inherit-product-if-exists, hardware/broadcom/wlan/bcmdhd/config/config-bcm.mk)

LOCAL_FSTAB := $(LOCAL_PATH)/fstab.jetson-tk1
TARGET_RECOVERY_FSTAB = $(LOCAL_FSTAB)


# Paragon filesystem solution binaries
PRODUCT_PACKAGES += \
    mount.ufsd \
    chkufsd \
    mkexfat \
    chkexfat \
    mkhfs \
    chkhfs \
    mkntfs \
    chkntfs

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/init.bt.sh:system/etc/init.bt.sh \
    $(LOCAL_PATH)/init.bluetooth.rc:root/init.bluetooth.rc

## REFERENCE_DEVICE
REFERENCE_DEVICE := ardbeg

PRODUCT_PACKAGES += \
    AppDrawer \
    LeanbackCustomizer \
    LeanbackLauncher \
    LeanbackIme \
    Settings \
    TvProvider \
    TvSettings \
    tv_input.default \
    TV

PRODUCT_PACKAGES += \
    librs_jni \
    com.android.future.usb.accessory \
    com.android.location.provider

RRODUCT_PACKAGES += \
    setup_fs \
    e2fsck \
    drmserver \
    libdrmframework_jni

ENABLE_WIDEVINE_DRM := true
ifeq ($(ENABLE_WIDEVINE_DRM),true)
#enable Widevine DRM
PRODUCT_PACKAGES += \
    com.google.widevine.software.drm \
    libwvdrmengine \
    libwvm \
    libWVStreamControlAPI_L1 \
    libwvdrm_L1
endif

# vendor HALs
PRODUCT_PACKAGES += \
    power.tegra

# Basic lights HAL
PRODUCT_PACKAGES += \
    lights.jetson

# Audio
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/audio/audio_policy.conf:system/etc/audio_policy.conf \
    $(LOCAL_PATH)/audio/nvaudio_fx.xml:system/etc/nvaudio_fx.xml \
    $(LOCAL_PATH)/audio/nvaudio_conf.xml:system/etc/nvaudio_conf.xml

PRODUCT_PACKAGES += \
    audio.primary.tegra \
    audio.a2dp.default \
    audio.usb.default \
    audio.r_submix.default \
    tinycap \
    tinymix \
    tinyplay

# Add props used in stock
PRODUCT_PROPERTY_OVERRIDES += \
    ro.vold.wipe_on_crypt_fail=1 \
    ro.com.widevine.cachesize=16777216 \
    drm.service.enabled=true \
    media.stagefright.cache-params=10240/20480/15 \
    media.aac_51_output_enabled=true \
    dalvik.vm.implicit_checks=none

PRODUCT_PROPERTY_OVERRIDES += \
    ro.opengles.version=196609

# NVIDIA hardware support
#PRODUCT_COPY_FILES += \
#    $(LOCAL_PATH)/ussrd.conf:system/etc/ussrd.conf \
#    $(LOCAL_PATH)/set_hwui_params.sh:system/bin/set_hwui_params.sh \
#    $(LOCAL_PATH)/nvcms/device.cfg:system/lib/nvcms/device.cfg \
#    $(LOCAL_PATH)/graphics/com.nvidia.graphics.xml:system/etc/permissions/com.nvidia.graphics.xml \
#    $(LOCAL_PATH)/graphics/com.nvidia.miracast.xml:system/etc/permissions/com.nvidia.miracast.xml

PRODUCT_PACKAGES += \
    lbh_images

WITH_EXFAT ?= true
ifeq ($(WITH_EXFAT),true)
TARGET_USES_EXFAT := true
PRODUCT_PACKAGES += \
    mount.exfat \
    fsck.exfat \
    mkfs.exfat
endif

# we have enough storage space to hold precise GC data
PRODUCT_TAGS += dalvik.gc.type-precise

PRODUCT_CHARACTERISTICS := tv

# set default USB configuration
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += \
    persist.sys.usb.config=mtp \
    ro.adb.secure=0

# Set up tv device overlay
DEVICE_PACKAGE_OVERLAYS += $(LOCAL_PATH)/overlay

$(call inherit-product-if-exists, hardware/nvidia/tegra124/tegra124.mk)
$(call inherit-product-if-exists, vendor/nvidia/proprietary-tegra124/tegra124-vendor.mk)
$(call inherit-product-if-exists, vendor/nvidia/shield_common/blake32-blobs.mk)
$(call inherit-product, vendor/nvidia/jetson/jetson-vendor.mk)
$(call inherit-product-if-exists, vendor/google/atv/atv-vendor.mk)
$(call inherit-product-if-exists, vendor/widevine/jetsontk1/device-partial.mk)
