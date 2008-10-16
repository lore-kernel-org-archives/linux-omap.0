From: "Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>
Subject: [PATCH 28/28] [OMAPZOOM] OMAP3430: Enable Camera on 3430sdp and ldp
 defconfigs
Date: Wed, 15 Oct 2008 20:37:50 -0500
Message-ID: <A24693684029E5489D1D202277BE89441256885F@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:50653 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753361AbYJPBh5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 15 Oct 2008 21:37:57 -0400
Received: from dlep95.itg.ti.com ([157.170.170.107])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id m9G1bpqU017213
	for <linux-omap@vger.kernel.org>; Wed, 15 Oct 2008 20:37:56 -0500
Received: from dlee75.ent.ti.com (localhost [127.0.0.1])
	by dlep95.itg.ti.com (8.13.8/8.13.8) with ESMTP id m9G1bpXX023558
	for <linux-omap@vger.kernel.org>; Wed, 15 Oct 2008 20:37:51 -0500 (CDT)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Pandita, Vikram" <vikram.pandita@ti.com>

From: Sergio Aguirre <saaguirre@ti.com>

OMAP3430: Enable Camera on 3430sdp and ldp defconfigs

This patch adds both camera sensors into omap_3430sdp_defconfig file,
as well as the OMAP3 camera and ISP modules.

Signed-off-by: Sergio Aguirre <saaguirre@ti.com>
---
 arch/arm/configs/omap_3430sdp_defconfig |   75 +++++++++++++++++++++++---
 arch/arm/configs/omap_ldp_defconfig     |   91 ++++++++++++++++++++++++--------
 2 files changed, 137 insertions(+), 29 deletions(-)

Index: omapkernel/arch/arm/configs/omap_3430sdp_defconfig
===================================================================
--- omapkernel.orig/arch/arm/configs/omap_3430sdp_defconfig     2008-10-15 20:11:31.000000000 -0500
+++ omapkernel/arch/arm/configs/omap_3430sdp_defconfig  2008-10-15 20:12:41.000000000 -0500
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.27-rc9-omap1
-# Wed Oct  8 19:52:56 2008
+# Linux kernel version: 2.6.27-omap1
+# Wed Oct 15 19:20:48 2008
 #
 CONFIG_ARM=y
 CONFIG_SYS_SUPPORTS_APM_EMULATION=y
@@ -219,8 +219,8 @@
 CONFIG_MACH_OMAP_3430SDP=y
 # CONFIG_MACH_OMAP3EVM is not set
 # CONFIG_MACH_OMAP3_BEAGLE is not set
-# CONFIG_OMAP3_PM is not set
 # CONFIG_MACH_OVERO is not set
+# CONFIG_OMAP3_PM is not set
 CONFIG_OMAP_TICK_GPTIMER=1

 #
@@ -868,6 +868,10 @@
 CONFIG_GPIO_TWL4030=y

 #
+# PCI GPIO expanders:
+#
+
+#
 # SPI GPIO expanders:
 #
 # CONFIG_GPIO_MAX7301 is not set
@@ -966,7 +970,64 @@
 CONFIG_VIDEOBUF_DMA_SG=y
 CONFIG_VIDEO_CAPTURE_DRIVERS=y
 # CONFIG_VIDEO_ADV_DEBUG is not set
-CONFIG_VIDEO_HELPER_CHIPS_AUTO=y
+# CONFIG_VIDEO_HELPER_CHIPS_AUTO is not set
+
+#
+# Encoders/decoders and other helper chips
+#
+
+#
+# Audio decoders
+#
+# CONFIG_VIDEO_TVAUDIO is not set
+# CONFIG_VIDEO_TDA7432 is not set
+# CONFIG_VIDEO_TDA9840 is not set
+# CONFIG_VIDEO_TDA9875 is not set
+# CONFIG_VIDEO_TEA6415C is not set
+# CONFIG_VIDEO_TEA6420 is not set
+# CONFIG_VIDEO_MSP3400 is not set
+# CONFIG_VIDEO_CS5345 is not set
+# CONFIG_VIDEO_CS53L32A is not set
+# CONFIG_VIDEO_M52790 is not set
+# CONFIG_VIDEO_TLV320AIC23B is not set
+# CONFIG_VIDEO_WM8775 is not set
+# CONFIG_VIDEO_WM8739 is not set
+# CONFIG_VIDEO_VP27SMPX is not set
+
+#
+# Video decoders
+#
+# CONFIG_VIDEO_OV7670 is not set
+# CONFIG_VIDEO_TCM825X is not set
+# CONFIG_VIDEO_OV9640 is not set
+CONFIG_VIDEO_MT9P012=y
+CONFIG_VIDEO_DW9710=y
+CONFIG_VIDEO_OV3640=y
+CONFIG_VIDEO_OV3640_CSI2=y
+# CONFIG_VIDEO_SAA711X is not set
+# CONFIG_VIDEO_SAA717X is not set
+# CONFIG_VIDEO_TVP5150 is not set
+
+#
+# Video and audio decoders
+#
+# CONFIG_VIDEO_CX25840 is not set
+
+#
+# MPEG video encoders
+#
+# CONFIG_VIDEO_CX2341X is not set
+
+#
+# Video encoders
+#
+# CONFIG_VIDEO_SAA7127 is not set
+
+#
+# Video improvement chips
+#
+# CONFIG_VIDEO_UPD64031A is not set
+# CONFIG_VIDEO_UPD64083 is not set
 # CONFIG_VIDEO_VIVI is not set
 # CONFIG_VIDEO_SAA5246A is not set
 # CONFIG_VIDEO_SAA5249 is not set
@@ -977,9 +1038,9 @@
 CONFIG_VIDEO_OMAP24XX_VIDEOLIB=y
 CONFIG_VIDEO_OMAP24XX_VIDEOOUT=y
 CONFIG_VIDEO_OMAP24XX_TVOUT=y
-# CONFIG_VIDEO_OMAP3 is not set
-# CONFIG_VIDEO_OMAP34XX_ISP_PREVIEWER is not set
-# CONFIG_VIDEO_OMAP34XX_ISP_RESIZER is not set
+CONFIG_VIDEO_OMAP3=y
+CONFIG_VIDEO_OMAP34XX_ISP_PREVIEWER=y
+CONFIG_VIDEO_OMAP34XX_ISP_RESIZER=y
 # CONFIG_VIDEO_OMAP2 is not set
 # CONFIG_V4L_USB_DRIVERS is not set
 # CONFIG_SOC_CAMERA is not set
Index: omapkernel/arch/arm/configs/omap_ldp_defconfig
===================================================================
--- omapkernel.orig/arch/arm/configs/omap_ldp_defconfig 2008-10-15 20:11:31.000000000 -0500
+++ omapkernel/arch/arm/configs/omap_ldp_defconfig      2008-10-15 20:12:41.000000000 -0500
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.27-rc9-omap1
-# Wed Oct  8 20:00:38 2008
+# Linux kernel version: 2.6.27-omap1
+# Wed Oct 15 20:10:58 2008
 #
 CONFIG_ARM=y
 CONFIG_SYS_SUPPORTS_APM_EMULATION=y
@@ -218,8 +218,8 @@
 # CONFIG_MACH_OMAP_3430SDP is not set
 # CONFIG_MACH_OMAP3EVM is not set
 # CONFIG_MACH_OMAP3_BEAGLE is not set
-# CONFIG_OMAP3_PM is not set
 # CONFIG_MACH_OVERO is not set
+# CONFIG_OMAP3_PM is not set
 CONFIG_OMAP_TICK_GPTIMER=1

 #
@@ -823,6 +823,10 @@
 CONFIG_GPIO_TWL4030=y

 #
+# PCI GPIO expanders:
+#
+
+#
 # SPI GPIO expanders:
 #
 # CONFIG_GPIO_MAX7301 is not set
@@ -896,7 +900,7 @@
 #
 CONFIG_VIDEO_DEV=y
 CONFIG_VIDEO_V4L2_COMMON=y
-CONFIG_VIDEO_ALLOW_V4L1=y
+# CONFIG_VIDEO_ALLOW_V4L1 is not set
 CONFIG_VIDEO_V4L1_COMPAT=y
 # CONFIG_DVB_CORE is not set
 CONFIG_VIDEO_MEDIA=y
@@ -916,18 +920,71 @@
 CONFIG_MEDIA_TUNER_XC2028=y
 CONFIG_MEDIA_TUNER_XC5000=y
 CONFIG_VIDEO_V4L2=y
-CONFIG_VIDEO_V4L1=y
 CONFIG_VIDEOBUF_GEN=y
 CONFIG_VIDEOBUF_DMA_SG=y
 CONFIG_VIDEO_CAPTURE_DRIVERS=y
 # CONFIG_VIDEO_ADV_DEBUG is not set
-CONFIG_VIDEO_HELPER_CHIPS_AUTO=y
+# CONFIG_VIDEO_HELPER_CHIPS_AUTO is not set
+
+#
+# Encoders/decoders and other helper chips
+#
+
+#
+# Audio decoders
+#
+# CONFIG_VIDEO_TVAUDIO is not set
+# CONFIG_VIDEO_TDA7432 is not set
+# CONFIG_VIDEO_TDA9840 is not set
+# CONFIG_VIDEO_TDA9875 is not set
+# CONFIG_VIDEO_TEA6415C is not set
+# CONFIG_VIDEO_TEA6420 is not set
+# CONFIG_VIDEO_MSP3400 is not set
+# CONFIG_VIDEO_CS5345 is not set
+# CONFIG_VIDEO_CS53L32A is not set
+# CONFIG_VIDEO_M52790 is not set
+# CONFIG_VIDEO_TLV320AIC23B is not set
+# CONFIG_VIDEO_WM8775 is not set
+# CONFIG_VIDEO_WM8739 is not set
+# CONFIG_VIDEO_VP27SMPX is not set
+
+#
+# Video decoders
+#
+# CONFIG_VIDEO_OV7670 is not set
+# CONFIG_VIDEO_TCM825X is not set
+# CONFIG_VIDEO_OV9640 is not set
+# CONFIG_VIDEO_MT9P012 is not set
+# CONFIG_VIDEO_DW9710 is not set
+CONFIG_VIDEO_OV3640=y
+CONFIG_VIDEO_OV3640_CSI2=y
+# CONFIG_VIDEO_SAA711X is not set
+# CONFIG_VIDEO_SAA717X is not set
+# CONFIG_VIDEO_TVP5150 is not set
+
+#
+# Video and audio decoders
+#
+# CONFIG_VIDEO_CX25840 is not set
+
+#
+# MPEG video encoders
+#
+# CONFIG_VIDEO_CX2341X is not set
+
+#
+# Video encoders
+#
+# CONFIG_VIDEO_SAA7127 is not set
+
+#
+# Video improvement chips
+#
+# CONFIG_VIDEO_UPD64031A is not set
+# CONFIG_VIDEO_UPD64083 is not set
 # CONFIG_VIDEO_VIVI is not set
-# CONFIG_VIDEO_CPIA is not set
-# CONFIG_VIDEO_CPIA2 is not set
 # CONFIG_VIDEO_SAA5246A is not set
 # CONFIG_VIDEO_SAA5249 is not set
-# CONFIG_TUNER_3036 is not set

 #
 # OMAP2/OMAP3 V4L2 drivers
@@ -935,9 +992,9 @@
 CONFIG_VIDEO_OMAP24XX_VIDEOLIB=y
 CONFIG_VIDEO_OMAP24XX_VIDEOOUT=y
 CONFIG_VIDEO_OMAP24XX_TVOUT=y
-# CONFIG_VIDEO_OMAP3 is not set
-# CONFIG_VIDEO_OMAP34XX_ISP_PREVIEWER is not set
-# CONFIG_VIDEO_OMAP34XX_ISP_RESIZER is not set
+CONFIG_VIDEO_OMAP3=y
+CONFIG_VIDEO_OMAP34XX_ISP_PREVIEWER=y
+CONFIG_VIDEO_OMAP34XX_ISP_RESIZER=y
 # CONFIG_VIDEO_OMAP2 is not set
 CONFIG_V4L_USB_DRIVERS=y
 # CONFIG_USB_VIDEO_CLASS is not set
@@ -945,19 +1002,9 @@
 # CONFIG_VIDEO_PVRUSB2 is not set
 # CONFIG_VIDEO_EM28XX is not set
 # CONFIG_VIDEO_USBVISION is not set
-# CONFIG_USB_VICAM is not set
-# CONFIG_USB_IBMCAM is not set
-# CONFIG_USB_KONICAWC is not set
-# CONFIG_USB_QUICKCAM_MESSENGER is not set
 # CONFIG_USB_ET61X251 is not set
-# CONFIG_VIDEO_OVCAMCHIP is not set
-# CONFIG_USB_W9968CF is not set
-# CONFIG_USB_OV511 is not set
-# CONFIG_USB_SE401 is not set
 # CONFIG_USB_SN9C102 is not set
-# CONFIG_USB_STV680 is not set
 # CONFIG_USB_ZC0301 is not set
-# CONFIG_USB_PWC is not set
 # CONFIG_USB_ZR364XX is not set
 # CONFIG_USB_STKWEBCAM is not set
 # CONFIG_USB_S2255 is not set
