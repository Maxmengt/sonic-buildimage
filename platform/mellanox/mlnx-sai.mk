# Mellanox SAI

MLNX_SAI_VERSION = SAIRel1.12.3-master
MLNX_SAI_REVISION = bbc4fc48e81cb4062f59b79e54b44871f608f54e

export MLNX_SAI_VERSION MLNX_SAI_REVISION

MLNX_SAI = mlnx-sai_1.mlnx.$(MLNX_SAI_VERSION)_amd64.deb
$(MLNX_SAI)_SRC_PATH = $(PLATFORM_PATH)/mlnx-sai
$(MLNX_SAI)_DEPENDS += $(MLNX_SDK_DEBS)
$(MLNX_SAI)_RDEPENDS += $(MLNX_SDK_RDEBS) $(MLNX_SDK_DEBS)
SONIC_MAKE_DEBS += $(MLNX_SAI)
