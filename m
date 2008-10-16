From: "Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>
Subject: [PATCH 12/28] [OMAPZOOM] OMAP3430: SDP: CAM: Fix Capture mem
 boundary
Date: Wed, 15 Oct 2008 20:25:18 -0500
Message-ID: <A24693684029E5489D1D202277BE894412568843@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:36618 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753059AbYJPBZZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 15 Oct 2008 21:25:25 -0400
Received: from dlep95.itg.ti.com ([157.170.170.107])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id m9G1PJBK027818
	for <linux-omap@vger.kernel.org>; Wed, 15 Oct 2008 20:25:24 -0500
Received: from dlee75.ent.ti.com (localhost [127.0.0.1])
	by dlep95.itg.ti.com (8.13.8/8.13.8) with ESMTP id m9G1PJjD011525
	for <linux-omap@vger.kernel.org>; Wed, 15 Oct 2008 20:25:19 -0500 (CDT)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Pandita, Vikram" <vikram.pandita@ti.com>

From: Sergio Aguirre <saaguirre@ti.com>

OMAP3430: SDP: CAM: Fix Capture mem boundary

This patch specifies the capture_mem boundary in sensor hw info
struct, cleans up the I2C buffer registration, and removes the
v4l2_ifparm, as we don't longer need it.

Signed-off-by: Sergio Aguirre <saaguirre@ti.com>
---
 arch/arm/mach-omap2/board-3430sdp.c |   60 ++++++++++++------------------------
 1 file changed, 20 insertions(+), 40 deletions(-)

Index: omapkernel/arch/arm/mach-omap2/board-3430sdp.c
===================================================================
--- omapkernel.orig/arch/arm/mach-omap2/board-3430sdp.c 2008-10-13 16:50:30.000000000 -0500
+++ omapkernel/arch/arm/mach-omap2/board-3430sdp.c      2008-10-14 12:07:27.000000000 -0500
@@ -23,6 +23,7 @@
 #include <linux/spi/spi.h>
 #include <linux/spi/ads7846.h>
 #include <linux/i2c/twl4030.h>
+#include <linux/mm.h>

 #include <mach/hardware.h>
 #include <asm/mach-types.h>
@@ -552,6 +553,7 @@
 static struct omap34xxcam_sensor_config cam_hwc = {
        .sensor_isp = 0,
        .xclk = OMAP34XXCAM_XCLK_A,
+       .capture_mem = PAGE_ALIGN(2592 * 1944 * 2) * 4,
 };

 static void enable_fpga_vio_1v8(u8 enable)
@@ -587,6 +589,7 @@

        hwc->u.sensor.xclk = cam_hwc.xclk;
        hwc->u.sensor.sensor_isp = cam_hwc.sensor_isp;
+       hwc->u.sensor.capture_mem = cam_hwc.capture_mem;
        hwc->dev_index = 0;
        hwc->dev_minor = 0;
        hwc->dev_type = OMAP34XXCAM_SLAVE_SENSOR;
@@ -689,44 +692,10 @@
        return 0;
 }

-static struct v4l2_ifparm ifparm = {
-       .if_type = V4L2_IF_TYPE_BT656,
-       .u = {
-               .bt656 = {
-                       .frame_start_on_rising_vs = 1,
-                       .latch_clk_inv = 0,
-                       .mode = V4L2_IF_TYPE_BT656_MODE_NOBT_10BIT,
-                       .clock_min = MT9P012_XCLK_MIN,
-                       .clock_max = MT9P012_XCLK_MAX,
-               },
-       },
-};
-
-static int mt9p012_ifparm(struct v4l2_ifparm *p)
-{
-       *p = ifparm;
-       return 0;
-}
-
 static struct mt9p012_platform_data sdp3430_mt9p012_platform_data = {
        .power_set      = mt9p012_sensor_power_set,
        .priv_data_set  = mt9p012_sensor_set_prv_data,
        .default_regs   = NULL,
-       .ifparm         = mt9p012_ifparm,
-};
-
-
-static struct i2c_board_info __initdata sdp3430_i2c2_boardinfo[] = {
-#ifdef CONFIG_VIDEO_DW9710
-       {
-               I2C_BOARD_INFO(DW9710_NAME,  DW9710_AF_I2C_ADDR),
-               .platform_data = &sdp3430_dw9710_platform_data,
-       },
-#endif
-       {
-               I2C_BOARD_INFO("mt9p012", MT9P012_I2C_ADDR),
-               .platform_data = &sdp3430_mt9p012_platform_data,
-       },
 };

 #endif
@@ -847,16 +816,27 @@
        },
 };

+static struct i2c_board_info __initdata sdp3430_i2c_boardinfo_2[] = {
+#if defined(CONFIG_VIDEO_MT9P012) || defined(CONFIG_VIDEO_MT9P012_MODULE)
+       {
+               I2C_BOARD_INFO("mt9p012", MT9P012_I2C_ADDR),
+               .platform_data = &sdp3430_mt9p012_platform_data,
+       },
+#ifdef CONFIG_VIDEO_DW9710
+       {
+               I2C_BOARD_INFO(DW9710_NAME,  DW9710_AF_I2C_ADDR),
+               .platform_data = &sdp3430_dw9710_platform_data,
+       },
+#endif
+#endif
+};
+
 static int __init omap3430_i2c_init(void)
 {
        omap_register_i2c_bus(1, 2600, sdp3430_i2c_boardinfo,
                        ARRAY_SIZE(sdp3430_i2c_boardinfo));
-#if defined(CONFIG_VIDEO_MT9P012) || defined(CONFIG_VIDEO_MT9P012_MODULE)
-       omap_register_i2c_bus(2, 400, sdp3430_i2c2_boardinfo,
-                             ARRAY_SIZE(sdp3430_i2c2_boardinfo));
-#else
-       omap_register_i2c_bus(2, 400, NULL, 0);
-#endif
+       omap_register_i2c_bus(2, 400, sdp3430_i2c_boardinfo_2,
+                       ARRAY_SIZE(sdp3430_i2c_boardinfo_2));
        omap_register_i2c_bus(3, 400, NULL, 0);
        return 0;
 }
