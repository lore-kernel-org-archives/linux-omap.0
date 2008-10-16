From: "Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>
Subject: [PATCH 27/28] [OMAPZOOM] OMAP34XX: CAM: Add OV3640 Sensor Support
Date: Wed, 15 Oct 2008 20:37:18 -0500
Message-ID: <A24693684029E5489D1D202277BE89441256885E@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:37180 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753358AbYJPBhZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 15 Oct 2008 21:37:25 -0400
Received: from dlep95.itg.ti.com ([157.170.170.107])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id m9G1bJAD002289
	for <linux-omap@vger.kernel.org>; Wed, 15 Oct 2008 20:37:24 -0500
Received: from dlee74.ent.ti.com (localhost [127.0.0.1])
	by dlep95.itg.ti.com (8.13.8/8.13.8) with ESMTP id m9G1bJ6U023057
	for <linux-omap@vger.kernel.org>; Wed, 15 Oct 2008 20:37:19 -0500 (CDT)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Pandita, Vikram" <vikram.pandita@ti.com>

From: Sergio Aguirre <saaguirre@ti.com>

OMAP34XX: CAM: Add OV3640 Sensor Support

This adds support in OMAP34xx SDP board file for OV3640 Sensor driver.

Signed-off-by: Sergio Aguirre <saaguirre@ti.com>
---
 arch/arm/mach-omap2/board-3430sdp.c |  217 ++++++++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/board-ldp.c     |  213 +++++++++++++++++++++++++++++++++++
 2 files changed, 429 insertions(+), 1 deletion(-)

Index: omapkernel/arch/arm/mach-omap2/board-3430sdp.c
===================================================================
--- omapkernel.orig/arch/arm/mach-omap2/board-3430sdp.c 2008-10-14 19:10:49.000000000 -0500
+++ omapkernel/arch/arm/mach-omap2/board-3430sdp.c      2008-10-14 19:12:25.000000000 -0500
@@ -48,9 +48,29 @@
 #include <media/v4l2-int-device.h>
 #include <../drivers/media/video/omap34xxcam.h>
 #include <../drivers/media/video/isp/ispreg.h>
+#define REG_SDP3430_FPGA_GPIO_2 (0x50)
+#define FPGA_SPR_GPIO1_3v3     (0x1 << 14)
+#define FPGA_GPIO6_DIR_CTRL    (0x1 << 6)
+static void __iomem *fpga_map_addr;
 #if defined(CONFIG_VIDEO_MT9P012) || defined(CONFIG_VIDEO_MT9P012_MODULE)
 #include <../drivers/media/video/mt9p012.h>
 #endif
+#if defined(CONFIG_VIDEO_OV3640) || defined(CONFIG_VIDEO_OV3640_MODULE)
+#include <../drivers/media/video/ov3640.h>
+#include <../drivers/media/video/isp/ispcsi2.h>
+static struct omap34xxcam_hw_config *hwc;
+#define OV3640_CSI2_CLOCK_POLARITY     0       /* +/- pin order */
+#define OV3640_CSI2_DATA0_POLARITY     0       /* +/- pin order */
+#define OV3640_CSI2_DATA1_POLARITY     0       /* +/- pin order */
+#define OV3640_CSI2_CLOCK_LANE         1        /* Clock lane position: 1 */
+#define OV3640_CSI2_DATA0_LANE         2        /* Data0 lane position: 2 */
+#define OV3640_CSI2_DATA1_LANE         3        /* Data1 lane position: 3 */
+#define OV3640_CSI2_PHY_THS_TERM       4
+#define OV3640_CSI2_PHY_THS_SETTLE     14
+#define OV3640_CSI2_PHY_TCLK_TERM      0
+#define OV3640_CSI2_PHY_TCLK_MISS      1
+#define OV3640_CSI2_PHY_TCLK_SETTLE    14
+#endif
 #endif

 #ifdef CONFIG_VIDEO_DW9710
@@ -76,6 +96,8 @@
 #define ENABLE_VAUX3_DEDICATED 0x03
 #define ENABLE_VAUX3_DEV_GRP   0x20

+#define TWL4030_VAUX4_DEV_GRP  0x23
+#define TWL4030_VAUX4_DEDICATED        0x26

 #define TWL4030_MSECURE_GPIO 22

@@ -593,6 +615,7 @@
        hwc->dev_index = 0;
        hwc->dev_minor = 0;
        hwc->dev_type = OMAP34XXCAM_SLAVE_SENSOR;
+       hwc->interface_type = ISP_PARLL;
        return 0;
 }

@@ -605,6 +628,9 @@
        .strobe = 0x0,
        .prestrobe = 0x0,
        .shutter = 0x0,
+       .prev_sph = 2,
+       .prev_slv = 0,
+       .wenlog = ISPCCDC_CFG_WENLOG_OR,
        .u.par.par_bridge = 0x0,
        .u.par.par_clk_pol = 0x0,
 };
@@ -704,6 +730,191 @@

 #endif

+#if defined(CONFIG_VIDEO_OV3640) || defined(CONFIG_VIDEO_OV3640_MODULE)
+
+static struct omap34xxcam_sensor_config ov3640_hwc = {
+       .sensor_isp = 0,
+#if defined(CONFIG_VIDEO_OV3640_CSI2)
+       .xclk = OMAP34XXCAM_XCLK_B,
+#else
+       .xclk = OMAP34XXCAM_XCLK_A,
+#endif
+       .capture_mem = PAGE_ALIGN(2048 * 1536 * 2) * 2,
+};
+
+static struct isp_interface_config ov3640_if_config = {
+       .ccdc_par_ser = ISP_CSIA,
+       .dataline_shift = 0x0,
+       .hsvs_syncdetect = ISPCTRL_SYNC_DETECT_VSRISE,
+       .vdint0_timing = 0x0,
+       .vdint1_timing = 0x0,
+       .strobe = 0x0,
+       .prestrobe = 0x0,
+       .shutter = 0x0,
+       .prev_sph = 2,
+       .prev_slv = 1,
+       .wenlog = ISPCCDC_CFG_WENLOG_AND,
+       .u.csi.crc = 0x0,
+       .u.csi.mode = 0x0,
+       .u.csi.edge = 0x0,
+       .u.csi.signalling = 0x0,
+       .u.csi.strobe_clock_inv = 0x0,
+       .u.csi.vs_edge = 0x0,
+       .u.csi.channel = 0x1,
+       .u.csi.vpclk = 0x1,
+       .u.csi.data_start = 0x0,
+       .u.csi.data_size = 0x0,
+       .u.csi.format = V4L2_PIX_FMT_SGRBG10,
+};
+
+static int ov3640_sensor_set_prv_data(void *priv)
+{
+
+       hwc = priv;
+       hwc->u.sensor.xclk = ov3640_hwc.xclk;
+       hwc->u.sensor.sensor_isp = ov3640_hwc.sensor_isp;
+       hwc->u.sensor.capture_mem = ov3640_hwc.capture_mem;
+       hwc->dev_index = 1;
+       hwc->dev_minor = 4;
+       hwc->dev_type = OMAP34XXCAM_SLAVE_SENSOR;
+       hwc->interface_type = ISP_CSIA;
+
+#if defined(CONFIG_VIDEO_OV3640_CSI2)
+       hwc->csi2.hw_csi2.lanes.clock.polarity = OV3640_CSI2_CLOCK_POLARITY;
+       hwc->csi2.hw_csi2.lanes.clock.position = OV3640_CSI2_CLOCK_LANE;
+       hwc->csi2.hw_csi2.lanes.data[0].polarity = OV3640_CSI2_DATA0_POLARITY;
+       hwc->csi2.hw_csi2.lanes.data[0].position = OV3640_CSI2_DATA0_LANE;
+       hwc->csi2.hw_csi2.lanes.data[1].polarity = OV3640_CSI2_DATA1_POLARITY;
+       hwc->csi2.hw_csi2.lanes.data[1].position = OV3640_CSI2_DATA1_LANE;
+       hwc->csi2.hw_csi2.phy.ths_term = OV3640_CSI2_PHY_THS_TERM;
+       hwc->csi2.hw_csi2.phy.ths_settle = OV3640_CSI2_PHY_THS_SETTLE;
+       hwc->csi2.hw_csi2.phy.tclk_term = OV3640_CSI2_PHY_TCLK_TERM;
+       hwc->csi2.hw_csi2.phy.tclk_miss = OV3640_CSI2_PHY_TCLK_MISS;
+       hwc->csi2.hw_csi2.phy.tclk_settle = OV3640_CSI2_PHY_TCLK_SETTLE;
+#endif
+
+       return 0;
+}
+
+static int ov3640_sensor_power_set(enum v4l2_power power)
+{
+       struct isp_csi2_lanes_cfg lanecfg;
+       struct isp_csi2_phy_cfg phyconfig;
+       static enum v4l2_power previous_power = V4L2_POWER_OFF;
+       switch (power) {
+       case V4L2_POWER_ON:
+               printk(KERN_DEBUG "ov3640_sensor_power_set(ON)\n");
+               if (previous_power == V4L2_POWER_OFF)
+                       isp_csi2_reset();
+
+               lanecfg.clk.pol = OV3640_CSI2_CLOCK_POLARITY;
+               lanecfg.clk.pos = OV3640_CSI2_CLOCK_LANE;
+               lanecfg.data[0].pol = OV3640_CSI2_DATA0_POLARITY;
+               lanecfg.data[0].pos = OV3640_CSI2_DATA0_LANE;
+               lanecfg.data[1].pol = OV3640_CSI2_DATA1_POLARITY;
+               lanecfg.data[1].pos = OV3640_CSI2_DATA1_LANE;
+               lanecfg.data[2].pol = 0;
+               lanecfg.data[2].pos = 0;
+               lanecfg.data[3].pol = 0;
+               lanecfg.data[3].pos = 0;
+               isp_csi2_complexio_lanes_config(&lanecfg);
+               isp_csi2_complexio_lanes_update(true);
+
+               phyconfig.ths_term = OV3640_CSI2_PHY_THS_TERM;
+               phyconfig.ths_settle = OV3640_CSI2_PHY_THS_SETTLE;
+               phyconfig.tclk_term = OV3640_CSI2_PHY_TCLK_TERM;
+               phyconfig.tclk_miss = OV3640_CSI2_PHY_TCLK_MISS;
+               phyconfig.tclk_settle = OV3640_CSI2_PHY_TCLK_SETTLE;
+               isp_csi2_phy_config(&phyconfig);
+               isp_csi2_phy_update(true);
+
+               isp_configure_interface(&ov3640_if_config);
+
+               if (previous_power == V4L2_POWER_OFF) {
+
+#ifdef CONFIG_TWL4030_CORE
+                       /* turn on analog power */
+#if defined(CONFIG_VIDEO_OV3640_CSI2)
+                       twl4030_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER,
+                                       VAUX_1_8_V, TWL4030_VAUX4_DEDICATED);
+                       twl4030_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER,
+                                       VAUX_DEV_GRP_P1, TWL4030_VAUX4_DEV_GRP);
+#else
+                       twl4030_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER,
+                                       VAUX_2_8_V, TWL4030_VAUX2_DEDICATED);
+                       twl4030_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER,
+                                       VAUX_DEV_GRP_P1, TWL4030_VAUX2_DEV_GRP);
+#endif
+                       udelay(100);
+#else
+#error "no power companion board defined!"
+#endif
+                       /* Request and configure gpio pins */
+                       if (omap_request_gpio(OV3640_RESET_GPIO) != 0) {
+                               printk(KERN_ERR "Could not request GPIO %d",
+                                       OV3640_RESET_GPIO);
+                               return -EIO;
+                       }
+                       if (omap_request_gpio(OV3640_STANDBY_GPIO) != 0) {
+                               printk(KERN_ERR "Could not request GPIO %d",
+                                       OV3640_STANDBY_GPIO);
+                               return -EIO;
+                       }
+                       /* set to output mode */
+                       omap_set_gpio_direction(OV3640_RESET_GPIO, 0);
+                       omap_set_gpio_direction(OV3640_STANDBY_GPIO, 0);
+
+                       /* Turn ON Omnivision sensor */
+                       omap_set_gpio_dataout(OV3640_RESET_GPIO, 1);
+                       omap_set_gpio_dataout(OV3640_STANDBY_GPIO, 0);
+                       udelay(100);
+
+                       /* RESET Omnivision sensor */
+                       omap_set_gpio_dataout(OV3640_RESET_GPIO, 0);
+                       udelay(100);
+                       omap_set_gpio_dataout(OV3640_RESET_GPIO, 1);
+
+                       /* Wait 10 ms */
+                       mdelay(10);
+                       enable_fpga_vio_1v8(1);
+                       udelay(100);
+               }
+               break;
+       case V4L2_POWER_OFF:
+               printk(KERN_DEBUG "ov3640_sensor_power_set(OFF)\n");
+               /* Power Down Sequence */
+
+#ifdef CONFIG_TWL4030_CORE
+#if defined(CONFIG_VIDEO_OV3640_CSI2)
+               twl4030_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER,
+                               VAUX_DEV_GRP_NONE, TWL4030_VAUX4_DEV_GRP);
+#else
+               twl4030_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER,
+                               VAUX_DEV_GRP_NONE, TWL4030_VAUX2_DEV_GRP);
+#endif
+#else
+#error "no power companion board defined!"
+#endif
+               enable_fpga_vio_1v8(0);
+               omap_free_gpio(OV3640_RESET_GPIO);
+               iounmap(fpga_map_addr);
+               omap_free_gpio(OV3640_STANDBY_GPIO);
+               break;
+       case V4L2_POWER_STANDBY:
+               printk(KERN_DEBUG "ov3640_sensor_power_set(STANDBY)\n");
+               break;
+       }
+       previous_power = power;
+       return 0;
+}
+
+static struct ov3640_platform_data sdp3430_ov3640_platform_data = {
+       .power_set       = ov3640_sensor_power_set,
+       .priv_data_set   = ov3640_sensor_set_prv_data,
+       .default_regs    = ov3640_common[0],
+};
+
+#endif

 static struct platform_device sdp3430_lcd_device = {
        .name           = "sdp2430_lcd",
@@ -833,6 +1044,12 @@
        },
 #endif
 #endif
+#if defined(CONFIG_VIDEO_OV3640) || defined(CONFIG_VIDEO_OV3640_MODULE)
+       {
+               I2C_BOARD_INFO("ov3640", OV3640_I2C_ADDR),
+               .platform_data = &sdp3430_ov3640_platform_data,
+       },
+#endif
 };

 static int __init omap3430_i2c_init(void)
Index: omapkernel/arch/arm/mach-omap2/board-ldp.c
===================================================================
--- omapkernel.orig/arch/arm/mach-omap2/board-ldp.c     2008-10-14 18:52:47.000000000 -0500
+++ omapkernel/arch/arm/mach-omap2/board-ldp.c  2008-10-14 19:12:25.000000000 -0500
@@ -47,6 +47,28 @@
 #include <mach/prcm_34xx.h>
 #endif

+#ifdef CONFIG_VIDEO_OMAP3
+#include <media/v4l2-int-device.h>
+#include <../drivers/media/video/omap34xxcam.h>
+#include <../drivers/media/video/isp/ispreg.h>
+#if defined(CONFIG_VIDEO_OV3640) || defined(CONFIG_VIDEO_OV3640_MODULE)
+#include <../drivers/media/video/ov3640.h>
+#include <../drivers/media/video/isp/ispcsi2.h>
+static struct omap34xxcam_hw_config *hwc;
+#define OV3640_CSI2_CLOCK_POLARITY     0       /* +/- pin order */
+#define OV3640_CSI2_DATA0_POLARITY     0       /* +/- pin order */
+#define OV3640_CSI2_DATA1_POLARITY     0       /* +/- pin order */
+#define OV3640_CSI2_CLOCK_LANE         1        /* Clock lane position: 1 */
+#define OV3640_CSI2_DATA0_LANE         2        /* Data0 lane position: 2 */
+#define OV3640_CSI2_DATA1_LANE         3        /* Data1 lane position: 3 */
+#define OV3640_CSI2_PHY_THS_TERM       4
+#define OV3640_CSI2_PHY_THS_SETTLE     14
+#define OV3640_CSI2_PHY_TCLK_TERM      0
+#define OV3640_CSI2_PHY_TCLK_MISS      1
+#define OV3640_CSI2_PHY_TCLK_SETTLE    14
+#endif
+#endif
+
 #define       SDP3430_SMC91X_CS        3
 #define ENABLE_VAUX1_DEDICATED         0x03
 #define ENABLE_VAUX1_DEV_GRP           0x20
@@ -55,6 +77,9 @@
 #define ENABLE_VAUX3_DEV_GRP           0x20
 #define TWL4030_MSECURE_GPIO           22

+#define TWL4030_VAUX4_DEV_GRP          0x23
+#define TWL4030_VAUX4_DEDICATED                0x26
+
 #ifdef CONFIG_OMAP3_PM
 #define CONTROL_SYSC_SMARTIDLE         (0x2 << 3)
 #define CONTROL_SYSC_AUTOIDLE          (0x1)
@@ -539,6 +564,182 @@
        //.keypad         = &sdp3430_kp_data,
 };

+#if defined(CONFIG_VIDEO_OV3640) || defined(CONFIG_VIDEO_OV3640_MODULE)
+
+static struct omap34xxcam_sensor_config ov3640_hwc = {
+       .sensor_isp = 0,
+#if defined(CONFIG_VIDEO_OV3640_CSI2)
+       .xclk = OMAP34XXCAM_XCLK_B,
+#else
+       .xclk = OMAP34XXCAM_XCLK_A,
+#endif
+       .capture_mem = 2592 * 1944 * 2 * 2,
+};
+
+static struct isp_interface_config ov3640_if_config = {
+       .ccdc_par_ser = ISP_CSIA,
+       .dataline_shift = 0x0,
+       .hsvs_syncdetect = ISPCTRL_SYNC_DETECT_VSRISE,
+       .vdint0_timing = 0x0,
+       .vdint1_timing = 0x0,
+       .strobe = 0x0,
+       .prestrobe = 0x0,
+       .shutter = 0x0,
+       .prev_sph = 2,
+       .prev_slv = 1,
+       .wenlog = ISPCCDC_CFG_WENLOG_AND,
+       .u.csi.crc = 0x0,
+       .u.csi.mode = 0x0,
+       .u.csi.edge = 0x0,
+       .u.csi.signalling = 0x0,
+       .u.csi.strobe_clock_inv = 0x0,
+       .u.csi.vs_edge = 0x0,
+       .u.csi.channel = 0x1,
+       .u.csi.vpclk = 0x1,
+       .u.csi.data_start = 0x0,
+       .u.csi.data_size = 0x0,
+       .u.csi.format = V4L2_PIX_FMT_SGRBG10,
+};
+
+static int ov3640_sensor_set_prv_data(void *priv)
+{
+
+       hwc = priv;
+       hwc->u.sensor.xclk = ov3640_hwc.xclk;
+       hwc->u.sensor.sensor_isp = ov3640_hwc.sensor_isp;
+       hwc->dev_index = 1;
+       hwc->dev_minor = 4;
+       hwc->dev_type = OMAP34XXCAM_SLAVE_SENSOR;
+       hwc->interface_type = ISP_CSIA;
+
+#if defined(CONFIG_VIDEO_OV3640_CSI2)
+       hwc->csi2.hw_csi2.lanes.clock.polarity = OV3640_CSI2_CLOCK_POLARITY;
+       hwc->csi2.hw_csi2.lanes.clock.position = OV3640_CSI2_CLOCK_LANE;
+       hwc->csi2.hw_csi2.lanes.data[0].polarity = OV3640_CSI2_DATA0_POLARITY;
+       hwc->csi2.hw_csi2.lanes.data[0].position = OV3640_CSI2_DATA0_LANE;
+       hwc->csi2.hw_csi2.lanes.data[1].polarity = OV3640_CSI2_DATA1_POLARITY;
+       hwc->csi2.hw_csi2.lanes.data[1].position = OV3640_CSI2_DATA1_LANE;
+       hwc->csi2.hw_csi2.phy.ths_term = OV3640_CSI2_PHY_THS_TERM;
+       hwc->csi2.hw_csi2.phy.ths_settle = OV3640_CSI2_PHY_THS_SETTLE;
+       hwc->csi2.hw_csi2.phy.tclk_term = OV3640_CSI2_PHY_TCLK_TERM;
+       hwc->csi2.hw_csi2.phy.tclk_miss = OV3640_CSI2_PHY_TCLK_MISS;
+       hwc->csi2.hw_csi2.phy.tclk_settle = OV3640_CSI2_PHY_TCLK_SETTLE;
+#endif
+
+       return 0;
+}
+
+static int ov3640_sensor_power_set(enum v4l2_power power)
+{
+       struct isp_csi2_lanes_cfg lanecfg;
+       struct isp_csi2_phy_cfg phyconfig;
+       static enum v4l2_power previous_power = V4L2_POWER_OFF;
+       switch (power) {
+       case V4L2_POWER_ON:
+               printk(KERN_DEBUG "ov3640_sensor_power_set(ON)\n");
+               if (previous_power == V4L2_POWER_OFF)
+                       isp_csi2_reset();
+               lanecfg.clk.pol = OV3640_CSI2_CLOCK_POLARITY;
+               lanecfg.clk.pos = OV3640_CSI2_CLOCK_LANE;
+               lanecfg.data[0].pol = OV3640_CSI2_DATA0_POLARITY;
+               lanecfg.data[0].pos = OV3640_CSI2_DATA0_LANE;
+               lanecfg.data[1].pol = OV3640_CSI2_DATA1_POLARITY;
+               lanecfg.data[1].pos = OV3640_CSI2_DATA1_LANE;
+               lanecfg.data[2].pol = 0;
+               lanecfg.data[2].pos = 0;
+               lanecfg.data[3].pol = 0;
+               lanecfg.data[3].pos = 0;
+               isp_csi2_complexio_lanes_config(&lanecfg);
+               isp_csi2_complexio_lanes_update(true);
+
+               phyconfig.ths_term = OV3640_CSI2_PHY_THS_TERM;
+               phyconfig.ths_settle = OV3640_CSI2_PHY_THS_SETTLE;
+               phyconfig.tclk_term = OV3640_CSI2_PHY_TCLK_TERM;
+               phyconfig.tclk_miss = OV3640_CSI2_PHY_TCLK_MISS;
+               phyconfig.tclk_settle = OV3640_CSI2_PHY_TCLK_SETTLE;
+               isp_csi2_phy_config(&phyconfig);
+               isp_csi2_phy_update(true);
+
+               isp_configure_interface(&ov3640_if_config);
+
+               if (previous_power == V4L2_POWER_OFF) {
+#ifdef CONFIG_TWL4030_CORE
+                       /* turn on analog power */
+#if defined(CONFIG_VIDEO_OV3640_CSI2)
+                       twl4030_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER,
+                                       VAUX_1_8_V, TWL4030_VAUX4_DEDICATED);
+                       twl4030_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER,
+                                       VAUX_DEV_GRP_P1, TWL4030_VAUX4_DEV_GRP);
+#else
+                       twl4030_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER,
+                                       VAUX_2_8_V, TWL4030_VAUX2_DEDICATED);
+                       twl4030_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER,
+                                       VAUX_DEV_GRP_P1, TWL4030_VAUX2_DEV_GRP);
+#endif
+                       udelay(100);
+#else
+#error "no power companion board defined!"
+#endif
+                       /* Request and configure gpio pins */
+                       if (omap_request_gpio(OV3640_RESET_GPIO) != 0) {
+                               printk(KERN_ERR "Could not request GPIO %d",
+                                       OV3640_RESET_GPIO);
+                               return -EIO;
+                       }
+                       if (omap_request_gpio(OV3640_STANDBY_GPIO) != 0) {
+                               printk(KERN_ERR "Could not request GPIO %d",
+                                       OV3640_STANDBY_GPIO);
+                               return -EIO;
+                       }
+                       /* set to output mode */
+                       omap_set_gpio_direction(OV3640_RESET_GPIO, 0);
+                       omap_set_gpio_direction(OV3640_STANDBY_GPIO, 0);
+
+                       /* Turn ON Omnivision sensor */
+                       omap_set_gpio_dataout(OV3640_RESET_GPIO, 1);
+                       omap_set_gpio_dataout(OV3640_STANDBY_GPIO, 0);
+                       udelay(100);
+
+                       /* RESET Omnivision sensor */
+                       omap_set_gpio_dataout(OV3640_RESET_GPIO, 0);
+                       udelay(100);
+                       omap_set_gpio_dataout(OV3640_RESET_GPIO, 1);
+               }
+               break;
+       case V4L2_POWER_OFF:
+               printk(KERN_DEBUG "ov3640_sensor_power_set(OFF)\n");
+               /* Power Down Sequence */
+
+#ifdef CONFIG_TWL4030_CORE
+#if defined(CONFIG_VIDEO_OV3640_CSI2)
+               twl4030_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER,
+                               VAUX_DEV_GRP_NONE, TWL4030_VAUX4_DEV_GRP);
+#else
+               twl4030_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER,
+                               VAUX_DEV_GRP_NONE, TWL4030_VAUX2_DEV_GRP);
+#endif
+#else
+#error "no power companion board defined!"
+#endif
+               omap_free_gpio(OV3640_RESET_GPIO);
+               omap_free_gpio(OV3640_STANDBY_GPIO);
+               break;
+       case V4L2_POWER_STANDBY:
+               printk(KERN_DEBUG "ov3640_sensor_power_set(STANDBY)\n");
+               break;
+       }
+       previous_power = power;
+       return 0;
+}
+
+static struct ov3640_platform_data sdp3430_ov3640_platform_data = {
+       .power_set      = ov3640_sensor_power_set,
+       .priv_data_set  = ov3640_sensor_set_prv_data,
+       .default_regs   = ov3640_common[0],
+};
+
+#endif
+
 static struct i2c_board_info __initdata ldp_i2c_boardinfo[] = {
        {
                I2C_BOARD_INFO("twl4030", 0x48),
@@ -548,12 +749,22 @@
        },
 };

+static struct i2c_board_info __initdata ldp_i2c_boardinfo_2[] = {
+#if defined(CONFIG_VIDEO_OV3640) || defined(CONFIG_VIDEO_OV3640_MODULE)
+       {
+               I2C_BOARD_INFO("ov3640", OV3640_I2C_ADDR),
+               .platform_data = &sdp3430_ov3640_platform_data,
+       },
+#endif
+};
+
 static int __init omap_i2c_init(void)
 {
        /* FIXME-TI: may need  i2c-freq = 100 */
        omap_register_i2c_bus(1, 100, ldp_i2c_boardinfo,
                        ARRAY_SIZE(ldp_i2c_boardinfo));
-       omap_register_i2c_bus(2, 400, NULL, 0);
+       omap_register_i2c_bus(2, 100, ldp_i2c_boardinfo_2,
+                       ARRAY_SIZE(ldp_i2c_boardinfo_2));
        omap_register_i2c_bus(3, 400, NULL, 0);
        return 0;
 }
