#
# Copyright 2014 JCROM Project
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

# Sample: This is where we'd set a backup provider if we had one
# $(call inherit-product, device/sample/products/backup_overlay.mk)

#JCROM
$(call inherit-product-if-exists, jcrom/lge/hammerhead/device-common.mk)

# Inherit from the common Open Source product configuration
$(call inherit-product, $(SRC_TARGET_DIR)/product/aosp_base_telephony.mk)

PRODUCT_BUILD_PROP_OVERRIDES += PRODUCT_NAME=hammerhead TARGET_DEVICE=hammerhead BUILD_FINGERPRINT=google/hammerhead/hammerhead:4.4.4/KTU84Q/1253334:user/release-keys PRIVATE_BUILD_DESC="hammerhead-user 4.4.4 KTU84Q 1253334 release-keys"

PRODUCT_NAME := jcrom_hammerhead
PRODUCT_DEVICE := hammerhead
PRODUCT_BRAND := google
PRODUCT_MODEL := Nexus 5
PRODUCT_MANUFACTURER := LGE
PRODUCT_RESTRICT_VENDOR_FILES := true

$(call inherit-product, device/lge/hammerhead/device.mk)
$(call inherit-product-if-exists, vendor/lge/hammerhead/device-vendor.mk)
$(call inherit-product-if-exists, vendor/lge/hammerhead-ext/hammerhead-ext-vendor.mk)
$(call inherit-product-if-exists, jcrom/lge/hammerhead/device-hammerhead.mk)

