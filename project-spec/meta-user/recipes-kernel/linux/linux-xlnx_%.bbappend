FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI_append = " file://bsp.cfg"
KERNEL_FEATURES_append = " bsp.cfg"
SRC_URI += "file://user_2022-02-15-08-44-00.cfg \
            file://user_2022-02-16-05-17-00.cfg \
            file://0001-Add-2nd-HDMI-support-by-adding-a-dummy-driver.patch \
            file://user_2022-06-17-09-55-00.cfg \
            file://user_2022-06-20-06-04-00.cfg \
            "

