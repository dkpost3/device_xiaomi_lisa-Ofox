#
# Copyright (C) 2021 The TWRP Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

DEVICE_PATH=device/xiaomi/lisa

# Inherit some common Omni stuff.
$(call inherit-product, vendor/twrp/config/common.mk)

# Inherit from taoyao device
$(call inherit-product, device/xiaomi/lisa/device.mk)

# Release name
PRODUCT_RELEASE_NAME := lisa

PRODUCT_DEVICE := lisa
PRODUCT_NAME := twrp_lisa
PRODUCT_BRAND := Xiaomi
PRODUCT_MODEL := Mi 11 Lite 5G NE
PRODUCT_MANUFACTURER := Xiaomi

PRODUCT_GMS_CLIENTID_BASE := android-xiaomi
#
