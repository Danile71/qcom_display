#Common headers
common_includes := hardware/qcom/display/libgralloc
common_includes += hardware/qcom/display/libgenlock
common_includes += hardware/qcom/display/liboverlay
common_includes += hardware/qcom/display/libcopybit
common_includes += hardware/qcom/display/libqdutils
common_includes += hardware/qcom/display/libhwcomposer
common_includes += hardware/qcom/display/libexternal
common_includes += hardware/qcom/display/libqservice

ifeq ($(TARGET_USES_POST_PROCESSING),true)
    common_flags     += -DUSES_POST_PROCESSING
    common_includes += $(TARGET_OUT_HEADERS)/pp/inc
endif

common_header_export_path := qcom/display

#Common libraries external to display HAL
common_libs := liblog libutils libcutils libhardware

#Common C flags
common_flags := -DDEBUG_CALC_FPS -Wno-missing-field-initializers
common_flags += -Werror

#TODO
#ifeq ($(call is-vendor-board-platform,QCOM),true)
ifeq ($(TARGET_BOARD_PLATFORM), msm8960)
    common_flags += -DUSE_FENCE_SYNC
endif

ifeq ($(TARGET_USES_ION),true)
    common_flags += -DUSE_ION
endif

ifeq ($(ARCH_ARM_HAVE_NEON),true)
    common_flags += -D__ARM_HAVE_NEON
endif

ifeq ($(TARGET_BOARD_PLATFORM), msm8974)
    common_flags += -DVENUS_COLOR_FORMAT
endif

ifeq ($(TARGET_QCOM_HDMI_RESOLUTION_AUTO),true)
    common_flags += -DFORCE_AUTO_RESOLUTION
endif

common_deps :=
kernel_includes :=

ifneq ($(TARGET_KERNEL_SOURCE),)
    common_deps += $(TARGET_OUT_INTERMEDIATES)/KERNEL_OBJ/usr/
    kernel_includes += $(TARGET_OUT_INTERMEDIATES)/KERNEL_OBJ/usr/include
endif
