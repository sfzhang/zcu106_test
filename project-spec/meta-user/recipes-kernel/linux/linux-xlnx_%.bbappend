FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI_append = " file://bsp.cfg"
KERNEL_FEATURES_append = " bsp.cfg"
SRC_URI += "file://user_2022-02-15-08-44-00.cfg \
            file://user_2022-02-16-05-17-00.cfg \
            "

