From: Dominic Curran <dcurran@ti.com>
Subject: [OMAPZOOM][PATCH] Testing for TWL4030 in board file change.
Date: Mon, 16 Feb 2009 18:15:12 -0600
Message-ID: <200902161815.13645.dcurran@ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:57354 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753511AbZBQAPU (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 16 Feb 2009 19:15:20 -0500
Received: from dlep36.itg.ti.com ([157.170.170.91])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id n1H0FEQl029522
	for <linux-omap@vger.kernel.org>; Mon, 16 Feb 2009 18:15:20 -0600
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: saaguirre@ti.com

From: Dominic Curran <dcurran@ti.com>
Subject: [OMAPZOOM][PATCH] Testing for TWL4030 in board file change.

This patch changes the method of testing for TWL4030 in the sensor portion of the 
board file.
Previously, if TWL4030 was not built into kernel then the build would be stopped 
by code in the board file simular to:
 #ifndef CONFIG_TWL4030_CORE
 #error "no power companion board defined!"
 #endif

However for debugging purposes it maybe required to build without TWL4030.
Therefore this patch allows the kernel to be compiled without a build error when 
TWL4030 is not present.
In such a case the sensor power function will build, but when called immediately 
return a -ENODEV error (so initilization of sensor will go no further).

This change is targeted at all camera sensors within the board files for SDP, 
Zoom1 & Zoom2.

Alternative fixes to this problem like changes to Kconfig were considered, but 
rejected as inappropriate solutions.

Signed-off-by: Dominic Curran <dcurran@ti.com>
---
 arch/arm/mach-omap2/board-3430sdp.c |   32 ++++++++++++++++++++------------
 arch/arm/mach-omap2/board-ldp.c     |    9 +++++----
 arch/arm/mach-omap2/board-zoom2.c   |   13 ++++++++-----
 3 files changed, 33 insertions(+), 21 deletions(-)

Index: omapzoom04/arch/arm/mach-omap2/board-3430sdp.c
===================================================================
--- omapzoom04.orig/arch/arm/mach-omap2/board-3430sdp.c
+++ omapzoom04/arch/arm/mach-omap2/board-3430sdp.c
@@ -45,9 +45,6 @@
 #include "ti-compat.h"
 
 #ifdef CONFIG_VIDEO_OMAP3
-#ifndef CONFIG_TWL4030_CORE
-#error "no power companion board defined!"
-#endif
 #include <media/v4l2-int-device.h>
 #include <../drivers/media/video/omap34xxcam.h>
 #include <../drivers/media/video/isp/ispreg.h>
@@ -668,14 +665,17 @@ static struct isp_interface_config mt9p0
 static int mt9p012_sensor_power_set(enum v4l2_power power)
 {
 	static enum v4l2_power previous_power = V4L2_POWER_OFF;
+
+#ifndef CONFIG_TWL4030_CORE
+	return -ENODEV;
+#endif
+
 	switch (power) {
 	case V4L2_POWER_OFF:
 		/* Power Down Sequence */
 #ifdef CONFIG_TWL4030_CORE
 		twl4030_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER,
 				VAUX_DEV_GRP_NONE, TWL4030_VAUX2_DEV_GRP);
-#else
-#error "no power companion board defined!"
 #endif
 		enable_fpga_vio_1v8(0);
 		omap_free_gpio(MT9P012_RESET_GPIO);
@@ -718,8 +718,6 @@ static int mt9p012_sensor_power_set(enum
 					VAUX_2_8_V, TWL4030_VAUX2_DEDICATED);
 			twl4030_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER,
 					VAUX_DEV_GRP_P1, TWL4030_VAUX2_DEV_GRP);
-#else
-#error "no power companion board defined!"
 #endif
 		}
 
@@ -832,6 +830,11 @@ static int ov3640_sensor_power_set(enum 
 	struct isp_csi2_lanes_cfg lanecfg;
 	struct isp_csi2_phy_cfg phyconfig;
 	static enum v4l2_power previous_power = V4L2_POWER_OFF;
+
+#ifndef CONFIG_TWL4030_CORE
+	return -ENODEV;
+#endif
+
 	switch (power) {
 	case V4L2_POWER_ON:
 		printk(KERN_DEBUG "ov3640_sensor_power_set(ON)\n");
@@ -876,10 +879,9 @@ static int ov3640_sensor_power_set(enum 
 			twl4030_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER,
 					VAUX_DEV_GRP_P1, TWL4030_VAUX2_DEV_GRP);
 #endif
-			udelay(100);
-#else
-#error "no power companion board defined!"
 #endif
+			udelay(100);
+
 			/* Request and configure gpio pins */
 			if (omap_request_gpio(OV3640_RESET_GPIO) != 0) {
 				printk(KERN_ERR "Could not request GPIO %d",
@@ -923,8 +925,6 @@ static int ov3640_sensor_power_set(enum 
 		twl4030_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER,
 				VAUX_DEV_GRP_NONE, TWL4030_VAUX2_DEV_GRP);
 #endif
-#else
-#error "no power companion board defined!"
 #endif
 		enable_fpga_vio_1v8(0);
 		omap_free_gpio(OV3640_RESET_GPIO);
@@ -1015,6 +1015,10 @@ static int imx046_sensor_power_set(enum 
 	static enum v4l2_power previous_power = V4L2_POWER_OFF;
 	int err = 0;
 
+#ifndef CONFIG_TWL4030_CORE
+	return -ENODEV;
+#endif
+
 	switch (power) {
 	case V4L2_POWER_ON:
 		/* Power Up Sequence */
@@ -1059,6 +1063,7 @@ static int imx046_sensor_power_set(enum 
 			omap_set_gpio_direction(IMX046_RESET_GPIO,
 				GPIO_DIR_OUTPUT);
 
+#ifdef CONFIG_TWL4030_CORE
 			/* turn on analog power */
 			twl4030_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER,
 					VAUX_2_8_V, TWL4030_VAUX2_DEDICATED);
@@ -1069,6 +1074,7 @@ static int imx046_sensor_power_set(enum 
 					VAUX_1_8_V, TWL4030_VAUX4_DEDICATED);
 			twl4030_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER,
 					VAUX_DEV_GRP_P1, TWL4030_VAUX4_DEV_GRP);
+#endif
 			udelay(100);
 
 			/* have to put sensor to reset to guarantee detection */
@@ -1085,10 +1091,12 @@ static int imx046_sensor_power_set(enum 
 		/* Power Down Sequence */
 		isp_csi2_complexio_power(ISP_CSI2_POWER_OFF);
 
+#ifdef CONFIG_TWL4030_CORE
 		twl4030_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER,
 				VAUX_DEV_GRP_NONE, TWL4030_VAUX4_DEV_GRP);
 		twl4030_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER,
 				VAUX_DEV_GRP_NONE, TWL4030_VAUX2_DEV_GRP);
+#endif
 		omap_free_gpio(IMX046_RESET_GPIO);
 		break;
 	case V4L2_POWER_STANDBY:
Index: omapzoom04/arch/arm/mach-omap2/board-ldp.c
===================================================================
--- omapzoom04.orig/arch/arm/mach-omap2/board-ldp.c
+++ omapzoom04/arch/arm/mach-omap2/board-ldp.c
@@ -672,6 +672,11 @@ static int ov3640_sensor_power_set(enum 
 	struct isp_csi2_lanes_cfg lanecfg;
 	struct isp_csi2_phy_cfg phyconfig;
 	static enum v4l2_power previous_power = V4L2_POWER_OFF;
+
+#ifndef CONFIG_TWL4030_CORE
+	return -ENODEV;
+#endif
+
 	switch (power) {
 	case V4L2_POWER_ON:
 		printk(KERN_DEBUG "ov3640_sensor_power_set(ON)\n");
@@ -715,8 +720,6 @@ static int ov3640_sensor_power_set(enum 
 					VAUX_DEV_GRP_P1, TWL4030_VAUX2_DEV_GRP);
 #endif
 			udelay(100);
-#else
-#error "no power companion board defined!"
 #endif
 			/* Request and configure gpio pins */
 			if (omap_request_gpio(OV3640_RESET_GPIO) != 0) {
@@ -756,8 +759,6 @@ static int ov3640_sensor_power_set(enum 
 		twl4030_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER,
 				VAUX_DEV_GRP_NONE, TWL4030_VAUX2_DEV_GRP);
 #endif
-#else
-#error "no power companion board defined!"
 #endif
 		omap_free_gpio(OV3640_RESET_GPIO);
 		omap_free_gpio(OV3640_STANDBY_GPIO);
Index: omapzoom04/arch/arm/mach-omap2/board-zoom2.c
===================================================================
--- omapzoom04.orig/arch/arm/mach-omap2/board-zoom2.c
+++ omapzoom04/arch/arm/mach-omap2/board-zoom2.c
@@ -69,9 +69,6 @@
 #define IMX046_CSI2_PHY_TCLK_TERM	0
 #define IMX046_CSI2_PHY_TCLK_MISS	1
 #define IMX046_CSI2_PHY_TCLK_SETTLE	14
-#ifndef CONFIG_TWL4030_CORE
-#error "no power companion board defined!"
-#endif
 #endif
 #endif
 
@@ -393,6 +390,10 @@ static int imx046_sensor_power_set(enum 
 	static enum v4l2_power previous_power = V4L2_POWER_OFF;
 	int err = 0;
 
+#ifndef CONFIG_TWL4030_CORE
+	return -ENODEV;
+#endif
+
 	switch (power) {
 	case V4L2_POWER_ON:
 		/* Power Up Sequence */
@@ -436,7 +437,7 @@ static int imx046_sensor_power_set(enum 
 			/* set to output mode */
 			omap_set_gpio_direction(IMX046_RESET_GPIO,
 				GPIO_DIR_OUTPUT);
-
+#ifdef CONFIG_TWL4030_CORE
 			/* turn on analog power */
 			twl4030_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER,
 					VAUX_2_8_V, TWL4030_VAUX2_DEDICATED);
@@ -447,6 +448,7 @@ static int imx046_sensor_power_set(enum 
 					VAUX_1_8_V, TWL4030_VAUX4_DEDICATED);
 			twl4030_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER,
 					VAUX_DEV_GRP_P1, TWL4030_VAUX4_DEV_GRP);
+#endif
 			udelay(100);
 
 			/* have to put sensor to reset to guarantee detection */
@@ -462,11 +464,12 @@ static int imx046_sensor_power_set(enum 
 		printk(KERN_DEBUG "imx046_sensor_power_set(OFF)\n");
 		/* Power Down Sequence */
 		isp_csi2_complexio_power(ISP_CSI2_POWER_OFF);
-
+#ifdef CONFIG_TWL4030_CORE
 		twl4030_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER,
 				VAUX_DEV_GRP_NONE, TWL4030_VAUX4_DEV_GRP);
 		twl4030_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER,
 				VAUX_DEV_GRP_NONE, TWL4030_VAUX2_DEV_GRP);
+#endif
 		omap_free_gpio(IMX046_RESET_GPIO);
 		break;
 	case V4L2_POWER_STANDBY:
