#!/system/bin/sh
# set some props, depending on device

setdevicespecs() {
    resetprop "ro.product.name" "$1"
    resetprop "ro.build.product" "$1"
    resetprop "ro.vendor.product.device" "$1"
    resetprop "ro.system.product.device" "$1"
    resetprop "ro.system_ext.product.device" "$1"
    resetprop "ro.odm.product.device" "$1"
    resetprop "ro.product.device" "$1"
    resetprop "ro.product.product.device" "$1"
}

load_CN()
{
    resetprop "ro.product.model" "Mi 11 LE"
    resetprop "ro.product.odm.model" "Mi 11 LE"
    resetprop "ro.product.system.model" "Mi 11 LE"
    resetprop "ro.product.vendor.model" "Mi 11 LE"
    resetprop "ro.product.system_ext.model" "Mi 11 LE"
    resetprop "ro.product.product.model" "Mi 11 LE"
    resetprop "ro.product.brand" "Xiaomi"
    resetprop "ro.product.odm.brand" "Xiaomi"
    resetprop "ro.product.system.brand" "Xiaomi"
    resetprop "ro.product.system_ext.brand" "Xiaomi"
    resetprop "ro.product.product.brand" "Xiaomi"
    resetprop "ro.product.vendor.brand" "Xiaomi"
    setdevicespecs "lisa"
}

load_global()
{
    resetprop "ro.product.model" "Xiaomi 11 Lite 5G NE"
    resetprop "ro.product.odm.model" "Xiaomi 11 Lite 5G NE"
    resetprop "ro.product.system.model" "Xiaomi 11 Lite 5G NE"
    resetprop "ro.product.vendor.model" "Xiaomi 11 Lite 5G NE"
    resetprop "ro.product.system_ext.model" "Xiaomi 11 Lite 5G NE"
    resetprop "ro.product.product.model" "Xiaomi 11 Lite 5G NE"
    resetprop "ro.product.brand" "Xiaomi"
    resetprop "ro.product.odm.brand" "Xiaomi"
    resetprop "ro.product.system.brand" "Xiaomi"
    resetprop "ro.product.system_ext.brand" "Xiaomi"
    resetprop "ro.product.product.brand" "Xiaomi"
    resetprop "ro.product.vendor.brand" "Xiaomi"
    setdevicespecs "lisa"
}

variant=$(getprop ro.boot.hwc)
echo $variant

case $variant in
    "CN")
        load_CN;
        ;;
    *)
        load_global;
        ;;
esac

exit 0
#
