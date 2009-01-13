From: "Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>
Subject: [OMAPZOOM][PATCH 1/2] OMAP3430SDP: CAM: Cleanup ifdef dependencies
Date: Tue, 13 Jan 2009 11:02:11 -0600
Message-ID: <A24693684029E5489D1D202277BE8944164DF4A8@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:55768 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754970AbZAMRCS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 13 Jan 2009 12:02:18 -0500
Received: from dlep95.itg.ti.com ([157.170.170.107])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id n0DH2Cta006946
	for <linux-omap@vger.kernel.org>; Tue, 13 Jan 2009 11:02:17 -0600
Received: from dlee74.ent.ti.com (localhost [127.0.0.1])
	by dlep95.itg.ti.com (8.13.8/8.13.8) with ESMTP id n0DH2CE4008610
	for <linux-omap@vger.kernel.org>; Tue, 13 Jan 2009 11:02:12 -0600 (CST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Pandita, Vikram" <vikram.pandita@ti.com>

>From 5f3e48e0ef21f62d3f062b596428009ff32740cd Mon Sep 17 00:00:00 2001
From: Sergio Aguirre <saaguirre@ti.com>
Date: Tue, 13 Jan 2009 10:45:41 -0600
Subject: [PATCH 1/2] OMAP3430SDP: CAM: Cleanup ifdef dependencies

This patch cleans up the camera code dependencies for
3430SDP boardfile.

Signed-off-by: Sergio Aguirre <saaguirre@ti.com>
Reported-by: Anand Gadiyar <gadiyar@ti.com>
---
 arch/arm/mach-omap2/board-3430sdp.c |   79 ++++++++++++++++++-----------------
 1 files changed, 40 insertions(+), 39 deletions(-)

diff --git a/arch/arm/mach-omap2/board-3430sdp.c b/arch/arm/mach-omap2/board-3430sdp.c
index c34184d..ede1ca5 100644
--- a/arch/arm/mach-omap2/board-3430sdp.c
+++ b/arch/arm/mach-omap2/board-3430sdp.c
@@ -54,6 +54,9 @@
 static void __iomem *fpga_map_addr;
 #if defined(CONFIG_VIDEO_MT9P012) || defined(CONFIG_VIDEO_MT9P012_MODULE)
 #include <../drivers/media/video/mt9p012.h>
+#ifdef CONFIG_VIDEO_DW9710
+#include <../drivers/media/video/dw9710.h>
+#endif
 #endif
 #if defined(CONFIG_VIDEO_OV3640) || defined(CONFIG_VIDEO_OV3640_MODULE)
 #include <../drivers/media/video/ov3640.h>
@@ -73,10 +76,6 @@ static	struct omap34xxcam_hw_config *hwc;
 #endif
 #endif
 
-#ifdef CONFIG_VIDEO_DW9710
-#include <../drivers/media/video/dw9710.h>
-#endif
-
 #ifdef CONFIG_OMAP3_PM
 #include "prcm-regs.h"
 #include <mach/prcm_34xx.h>
@@ -553,7 +552,36 @@ static struct spi_board_info sdp3430_spi_board_info[] __initdata = {
 	},
 };
 
-#ifdef CONFIG_VIDEO_DW9710
+#ifdef CONFIG_VIDEO_OMAP3
+static void enable_fpga_vio_1v8(u8 enable)
+{
+	u16 reg_val;
+
+	fpga_map_addr = ioremap(DEBUG_BASE, 4096);
+	reg_val = readw(fpga_map_addr + REG_SDP3430_FPGA_GPIO_2);
+
+	/* Ensure that the SPR_GPIO1_3v3 is 0 - powered off.. 1 is on */
+	if (reg_val & FPGA_SPR_GPIO1_3v3) {
+		reg_val |= FPGA_SPR_GPIO1_3v3;
+		reg_val |= FPGA_GPIO6_DIR_CTRL; /* output mode */
+		writew(reg_val, fpga_map_addr + REG_SDP3430_FPGA_GPIO_2);
+		/* give a few milli sec to settle down
+		 * Let the sensor also settle down.. if required..
+		 */
+		if (enable)
+			mdelay(10);
+	}
+
+	if (enable) {
+		reg_val |= FPGA_SPR_GPIO1_3v3 | FPGA_GPIO6_DIR_CTRL;
+		writew(reg_val, fpga_map_addr + REG_SDP3430_FPGA_GPIO_2);
+	}
+	/* Vrise time for the voltage - should be less than 1 ms */
+	mdelay(1);
+}
+
+#if defined(CONFIG_VIDEO_MT9P012) || defined(CONFIG_VIDEO_MT9P012_MODULE)
+#if defined(CONFIG_VIDEO_DW9710) && defined(CONFIG_VIDEO_OMAP3)
 static int dw9710_lens_power_set(enum v4l2_power power)
 {
 
@@ -577,8 +605,6 @@ static struct dw9710_platform_data sdp3430_dw9710_platform_data = {
 };
 #endif
 
-#if defined(CONFIG_VIDEO_MT9P012) || defined(CONFIG_VIDEO_MT9P012_MODULE)
-static void __iomem *fpga_map_addr;
 
 static struct omap34xxcam_sensor_config cam_hwc = {
 	.sensor_isp = 0,
@@ -586,33 +612,6 @@ static struct omap34xxcam_sensor_config cam_hwc = {
 	.capture_mem = PAGE_ALIGN(2592 * 1944 * 2) * 4,
 };
 
-static void enable_fpga_vio_1v8(u8 enable)
-{
-	u16 reg_val;
-
-	fpga_map_addr = ioremap(DEBUG_BASE, 4096);
-	reg_val = readw(fpga_map_addr + REG_SDP3430_FPGA_GPIO_2);
-
-	/* Ensure that the SPR_GPIO1_3v3 is 0 - powered off.. 1 is on */
-	if (reg_val & FPGA_SPR_GPIO1_3v3) {
-		reg_val |= FPGA_SPR_GPIO1_3v3;
-		reg_val |= FPGA_GPIO6_DIR_CTRL; /* output mode */
-		writew(reg_val, fpga_map_addr + REG_SDP3430_FPGA_GPIO_2);
-		/* give a few milli sec to settle down
-		 * Let the sensor also settle down.. if required..
-		 */
-		if (enable)
-			mdelay(10);
-	}
-
-	if (enable) {
-		reg_val |= FPGA_SPR_GPIO1_3v3 | FPGA_GPIO6_DIR_CTRL;
-		writew(reg_val, fpga_map_addr + REG_SDP3430_FPGA_GPIO_2);
-	}
-	/* Vrise time for the voltage - should be less than 1 ms */
-	mdelay(1);
-}
-
 static int mt9p012_sensor_set_prv_data(void *priv)
 {
 	struct omap34xxcam_hw_config *hwc = priv;
@@ -923,8 +922,8 @@ static struct ov3640_platform_data sdp3430_ov3640_platform_data = {
 	.priv_data_set	 = ov3640_sensor_set_prv_data,
 	.default_regs	 = ov3640_common[0],
 };
-
-#endif
+#endif /* CONFIG_VIDEO_OV3640 || CONFIG_VIDEO_OV3640_MODULE */
+#endif /* CONFIG_VIDEO_OMAP3 */
 
 static struct platform_device sdp3430_lcd_device = {
 	.name		= "sdp2430_lcd",
@@ -1045,6 +1044,7 @@ static struct i2c_board_info __initdata sdp3430_i2c_boardinfo[] = {
 };
 
 static struct i2c_board_info __initdata sdp3430_i2c_boardinfo_2[] = {
+#ifdef CONFIG_VIDEO_OMAP3
 #if defined(CONFIG_VIDEO_MT9P012) || defined(CONFIG_VIDEO_MT9P012_MODULE)
 	{
 		I2C_BOARD_INFO("mt9p012", MT9P012_I2C_ADDR),
@@ -1055,14 +1055,15 @@ static struct i2c_board_info __initdata sdp3430_i2c_boardinfo_2[] = {
 		I2C_BOARD_INFO(DW9710_NAME,  DW9710_AF_I2C_ADDR),
 		.platform_data = &sdp3430_dw9710_platform_data,
 	},
-#endif
-#endif
+#endif /* CONFIG_VIDEO_DW9710 */
+#endif /* CONFIG_VIDEO_MT9P012 || CONFIG_VIDEO_MT9P012_MODULE */
 #if defined(CONFIG_VIDEO_OV3640) || defined(CONFIG_VIDEO_OV3640_MODULE)
 	{
 		I2C_BOARD_INFO("ov3640", OV3640_I2C_ADDR),
 		.platform_data = &sdp3430_ov3640_platform_data,
 	},
-#endif
+#endif /* CONFIG_VIDEO_OV3640 || CONFIG_VIDEO_OV3640_MODULE */
+#endif /* CONFIG_VIDEO_OMAP3 */
 };
 
 static int __init omap3430_i2c_init(void)
-- 
1.5.6.5

