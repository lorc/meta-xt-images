# Prevent installing optee-os binaries into the image rootfs
ALLOW_EMPTY_${PN} = "1"

SRC_URI = " git://github.com/xen-troops/optee_os.git"
PV = "git${SRCPV}"

LIC_FILES_CHKSUM = "file://${S}/LICENSE;md5=c1f21c4f72f372ef38a5a4aee55ec173"

SRCREV = "master"

OPTEEMACHINE = "rcar"

OPTEEFLAVOR_salvator-xs-m3n-xt = "salvator_m3n"

OPTEEFLAVOR_m3ulcb-xt = "salvator_m3"
OPTEEFLAVOR_salvator-x-m3-xt = "salvator_m3"

OPTEEFLAVOR_h3ulcb-xt = "salvator_h3"
OPTEEFLAVOR_salvator-x-h3-xt = "salvator_h3"
OPTEEFLAVOR_salvator-xs-h3-xt = "salvator_h3"

OPTEEFLAVOR_salvator-x-h3-4x2g-xt = "salvator_h3_4x2g"
OPTEEFLAVOR_salvator-xs-h3-4x2g-xt = "salvator_h3_4x2g"
OPTEEFLAVOR_h3ulcb-4x2g-xt = "salvator_h3_4x2g"
OPTEEFLAVOR_h3ulcb-4x2g-kf-xt = "salvator_h3_4x2g"

EXTRA_OEMAKE = "PLATFORM=rcar \
	       PLATFORM_FLAVOR=${OPTEEFLAVOR} \
	       CFG_ARM64_core=y \
	       CFG_VIRTUALIZATION=y \
	       CROSS_COMPILE_core=${HOST_PREFIX} \
	       CROSS_COMPILE_ta_arm64=${HOST_PREFIX} \
	       ta-targets=ta_arm64 \
	       CFLAGS64=--sysroot=${STAGING_DIR_HOST} \
	       CFG_SYSTEM_PTA=y \
	       CFG_ASN1_PARSER=y \
	       CFG_CORE_MBEDTLS_MPI=n \
	       CFG_RPMB_FS=y \
	       CFG_RPMB_WRITE_KEY=y \
	       CFG_EARLY_TA=y \
	       CFG_IN_TREE_EARLY_TAS=avb/023f8f1a-292a-432b-8fc4-de8471358067 \
	       "

do_configure() {
}

do_compile() {
	oe_runmake
}

do_deploy_append() {
	install -m 0644 ${S}/out/arm-plat-${PLATFORM}/core/tee_raw.bin ${DEPLOYDIR}/tee_raw-${MACHINE}.bin
}
