From: Felipe Balbi <me@felipebalbi.com>
Subject: [PATCH 31/33] add several omap lcd drivers
Date: Sat, 30 Aug 2008 20:16:31 +0300
Message-ID: <1220116593-862-32-git-send-email-me@felipebalbi.com>
References: <1220116593-862-1-git-send-email-me@felipebalbi.com>
 <1220116593-862-2-git-send-email-me@felipebalbi.com>
 <1220116593-862-3-git-send-email-me@felipebalbi.com>
 <1220116593-862-4-git-send-email-me@felipebalbi.com>
 <1220116593-862-5-git-send-email-me@felipebalbi.com>
 <1220116593-862-6-git-send-email-me@felipebalbi.com>
 <1220116593-862-7-git-send-email-me@felipebalbi.com>
 <1220116593-862-8-git-send-email-me@felipebalbi.com>
 <1220116593-862-9-git-send-email-me@felipebalbi.com>
 <1220116593-862-10-git-send-email-me@felipebalbi.com>
 <1220116593-862-11-git-send-email-me@felipebalbi.com>
 <1220116593-862-12-git-send-email-me@felipebalbi.com>
 <1220116593-862-13-git-send-email-me@felipebalbi.com>
 <1220116593-862-14-git-send-email-me@felipebalbi.com>
 <1220116593-862-15-git-send-email-me@felipebalbi.com>
 <1220116593-862-16-git-send-email-me@felipebalbi.com>
 <1220116593-862-17-git-send-email-me@felipebalbi.com>
 <1220116593-862-18-git-send-email-me@felipebalbi.com>
 <1220116593-862-19-git-send-email-me@felipebalbi.com>
 <1220116593-862-20-git-send-email-me@felipebalbi.com>
 <1220116593-862-21-git-send-email-me@felipebalbi.com>
 <1220116593-862-22-git-send-email-me@felipebalbi.com>
 <1220116593-862-23-git-send-email-me@felipebalbi.com>
 <1220116593-862-24-git-send-email-me@felipebalbi.com>
 <1220116593-862-25-git-send-email-me@felipebalbi.com>
 <1220116593-862-26-git-send-email-me@felipebalbi.com>
 <1220116593-862-27-git-send-email-me@felipebalbi.com>
 <1220116593-862-28-git-send-email-me@felipebalbi.com>
 <1220116593-862-29-git-send-email-me@felipebalbi.com>
 <1220116593-862-30-git-send-email-me@felipebalbi.com>
 <1220116593-862-31-git-send-email-me@felipebalbi.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:36887 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755299AbYH3RX6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 30 Aug 2008 13:23:58 -0400
In-Reply-To: <1220116593-862-31-git-send-email-me@felipebalbi.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Felipe Balbi <felipe.balbi@nokia.com>

From: Felipe Balbi <felipe.balbi@nokia.com>

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 drivers/video/omap/Kconfig           |   18 +
 drivers/video/omap/Makefile          |   11 +
 drivers/video/omap/lcd_2430sdp.c     |  182 ++++++++++
 drivers/video/omap/lcd_ams_delta.c   |  140 ++++++++
 drivers/video/omap/lcd_apollon.c     |  137 ++++++++
 drivers/video/omap/lcd_h2.c          |  155 +++++++++
 drivers/video/omap/lcd_mipid.c       |  617 ++++++++++++++++++++++++++++++++++
 drivers/video/omap/lcd_omap2evm.c    |  195 +++++++++++
 drivers/video/omap/lcd_omap3beagle.c |  133 ++++++++
 drivers/video/omap/lcd_omap3evm.c    |  197 +++++++++++
 drivers/video/omap/lcd_p2.c          |  342 +++++++++++++++++++
 11 files changed, 2127 insertions(+), 0 deletions(-)
 create mode 100644 drivers/video/omap/lcd_2430sdp.c
 create mode 100644 drivers/video/omap/lcd_ams_delta.c
 create mode 100644 drivers/video/omap/lcd_apollon.c
 create mode 100644 drivers/video/omap/lcd_h2.c
 create mode 100644 drivers/video/omap/lcd_mipid.c
 create mode 100644 drivers/video/omap/lcd_omap2evm.c
 create mode 100644 drivers/video/omap/lcd_omap3beagle.c
 create mode 100644 drivers/video/omap/lcd_omap3evm.c
 create mode 100644 drivers/video/omap/lcd_p2.c

diff --git a/drivers/video/omap/Kconfig b/drivers/video/omap/Kconfig
index 4440885..8f4c27b 100644
--- a/drivers/video/omap/Kconfig
+++ b/drivers/video/omap/Kconfig
@@ -56,3 +56,21 @@ config FB_OMAP_LCDC_BLIZZARD
 	help
 	  Say Y here if you want to have support for the external
 	  Epson Blizzard LCD controller.
+
+config FB_OMAP_MANUAL_UPDATE
+	bool "Default to manual update mode"
+	depends on FB_OMAP && FB_OMAP_LCDC_EXTERNAL
+	help
+	  Say Y here, if your user-space applications are capable of
+	  notifying the frame buffer driver when a change has occured in
+          the frame buffer content and thus a reload of the image data to
+	  the external frame buffer is required. If unsure, say N.
+
+config FB_OMAP_LCD_MIPID
+	bool "MIPI DBI-C/DCS compatible LCD support"
+	depends on FB_OMAP && SPI_MASTER && CBUS_TAHVO
+	help
+	  Say Y here if you want to have support for LCDs compatible with
+	  the Mobile Industry Processor Interface DBI-C/DCS
+	  specification. (Supported LCDs: Philips LPH8923, Sharp LS041Y3)
+
diff --git a/drivers/video/omap/Makefile b/drivers/video/omap/Makefile
index 99da8b6..f9b5cd4 100644
--- a/drivers/video/omap/Makefile
+++ b/drivers/video/omap/Makefile
@@ -8,6 +8,7 @@ objs-yy := omapfb_main.o
 
 objs-y$(CONFIG_ARCH_OMAP1) += lcdc.o
 objs-y$(CONFIG_ARCH_OMAP2) += dispc.o
+objs-y$(CONFIG_ARCH_OMAP3) += dispc.o
 
 objs-$(CONFIG_ARCH_OMAP1)$(CONFIG_FB_OMAP_LCDC_EXTERNAL) += sossi.o
 objs-$(CONFIG_ARCH_OMAP2)$(CONFIG_FB_OMAP_LCDC_EXTERNAL) += rfbi.o
@@ -15,8 +16,10 @@ objs-$(CONFIG_ARCH_OMAP2)$(CONFIG_FB_OMAP_LCDC_EXTERNAL) += rfbi.o
 objs-y$(CONFIG_FB_OMAP_LCDC_HWA742) += hwa742.o
 objs-y$(CONFIG_FB_OMAP_LCDC_BLIZZARD) += blizzard.o
 
+objs-y$(CONFIG_MACH_AMS_DELTA) += lcd_ams_delta.o
 objs-y$(CONFIG_MACH_OMAP_H4) += lcd_h4.o
 objs-y$(CONFIG_MACH_OMAP_H3) += lcd_h3.o
+objs-y$(CONFIG_MACH_OMAP_H2) += lcd_h2.o
 objs-y$(CONFIG_MACH_OMAP_PALMTE) += lcd_palmte.o
 objs-y$(CONFIG_MACH_OMAP_PALMTT) += lcd_palmtt.o
 objs-y$(CONFIG_MACH_OMAP_PALMZ71) += lcd_palmz71.o
@@ -25,5 +28,13 @@ objs-$(CONFIG_ARCH_OMAP15XX)$(CONFIG_MACH_OMAP_INNOVATOR) += lcd_inn1510.o
 objs-y$(CONFIG_MACH_OMAP_OSK) += lcd_osk.o
 objs-y$(CONFIG_MACH_SX1) += lcd_sx1.o
 
+objs-y$(CONFIG_MACH_OMAP_APOLLON) += lcd_apollon.o
+objs-y$(CONFIG_MACH_OMAP_2430SDP) += lcd_2430sdp.o
+objs-y$(CONFIG_MACH_OMAP_3430SDP) += lcd_2430sdp.o
+objs-y$(CONFIG_MACH_OMAP2EVM) += lcd_omap2evm.o
+objs-y$(CONFIG_MACH_OMAP3EVM) += lcd_omap3evm.o
+objs-y$(CONFIG_MACH_OMAP3_BEAGLE) += lcd_omap3beagle.o
+objs-y$(CONFIG_FB_OMAP_LCD_MIPID) += lcd_mipid.o
+
 omapfb-objs := $(objs-yy)
 
diff --git a/drivers/video/omap/lcd_2430sdp.c b/drivers/video/omap/lcd_2430sdp.c
new file mode 100644
index 0000000..9af6cd0
--- /dev/null
+++ b/drivers/video/omap/lcd_2430sdp.c
@@ -0,0 +1,182 @@
+/*
+ * LCD panel support for the TI 2430SDP board
+ *
+ * Copyright (C) 2007 MontaVista
+ * Author: Hunyue Yau <hyau@mvista.com>
+ *
+ * Derived from drivers/video/omap/lcd-apollon.c
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2 of the License, or (at your
+ * option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write to the Free Software Foundation, Inc.,
+ * 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
+ */
+
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/i2c/twl4030.h>
+
+#include <mach/gpio.h>
+#include <mach/mux.h>
+#include <mach/omapfb.h>
+#include <asm/mach-types.h>
+
+#define SDP2430_LCD_PANEL_BACKLIGHT_GPIO	91
+#define SDP2430_LCD_PANEL_ENABLE_GPIO		154
+#define SDP3430_LCD_PANEL_BACKLIGHT_GPIO 	24
+#define SDP3430_LCD_PANEL_ENABLE_GPIO 		28
+
+static unsigned backlight_gpio;
+static unsigned enable_gpio;
+
+#define LCD_PIXCLOCK_MAX		5400 /* freq 5.4 MHz */
+#define PM_RECEIVER             TWL4030_MODULE_PM_RECEIVER
+#define ENABLE_VAUX2_DEDICATED  0x09
+#define ENABLE_VAUX2_DEV_GRP    0x20
+#define ENABLE_VAUX3_DEDICATED	0x03
+#define ENABLE_VAUX3_DEV_GRP	0x20
+
+
+#define t2_out(c, r, v) twl4030_i2c_write_u8(c, r, v)
+
+
+static int sdp2430_panel_init(struct lcd_panel *panel,
+				struct omapfb_device *fbdev)
+{
+	if (machine_is_omap_3430sdp()) {
+		enable_gpio    = SDP3430_LCD_PANEL_ENABLE_GPIO;
+		backlight_gpio = SDP3430_LCD_PANEL_BACKLIGHT_GPIO;
+	} else {
+		enable_gpio    = SDP2430_LCD_PANEL_ENABLE_GPIO;
+		backlight_gpio = SDP2430_LCD_PANEL_BACKLIGHT_GPIO;
+	}
+
+	omap_request_gpio(enable_gpio);			/* LCD panel */
+	omap_request_gpio(backlight_gpio);		/* LCD backlight */
+	omap_set_gpio_direction(enable_gpio, 0);	/* output */
+	omap_set_gpio_direction(backlight_gpio, 0);	/* output */
+
+	return 0;
+}
+
+static void sdp2430_panel_cleanup(struct lcd_panel *panel)
+{
+}
+
+static int sdp2430_panel_enable(struct lcd_panel *panel)
+{
+	u8 ded_val, ded_reg;
+	u8 grp_val, grp_reg;
+
+	if (machine_is_omap_3430sdp()) {
+		ded_reg = TWL4030_VAUX3_DEDICATED;
+		ded_val = ENABLE_VAUX3_DEDICATED;
+		grp_reg = TWL4030_VAUX3_DEV_GRP;
+		grp_val = ENABLE_VAUX3_DEV_GRP;
+	} else {
+		ded_reg = TWL4030_VAUX2_DEDICATED;
+		ded_val = ENABLE_VAUX2_DEDICATED;
+		grp_reg = TWL4030_VAUX2_DEV_GRP;
+		grp_val = ENABLE_VAUX2_DEV_GRP;
+	}
+		
+	omap_set_gpio_dataout(enable_gpio, 1);
+	omap_set_gpio_dataout(backlight_gpio, 1);
+
+	if (0 != t2_out(PM_RECEIVER, ded_val, ded_reg))
+		return -EIO;
+	if (0 != t2_out(PM_RECEIVER, grp_val, grp_reg))
+		return -EIO;
+
+	return 0;
+}
+
+static void sdp2430_panel_disable(struct lcd_panel *panel)
+{
+	omap_set_gpio_dataout(enable_gpio, 0);
+	omap_set_gpio_dataout(backlight_gpio, 0);
+}
+
+static unsigned long sdp2430_panel_get_caps(struct lcd_panel *panel)
+{
+	return 0;
+}
+
+struct lcd_panel sdp2430_panel = {
+	.name		= "sdp2430",
+	.config		= OMAP_LCDC_PANEL_TFT | OMAP_LCDC_INV_VSYNC |
+			  OMAP_LCDC_INV_HSYNC,
+
+	.bpp		= 16,
+	.data_lines	= 16,
+	.x_res		= 240,
+	.y_res		= 320,
+	.hsw		= 3,		/* hsync_len (4) - 1 */
+	.hfp		= 3,		/* right_margin (4) - 1 */
+	.hbp		= 39,		/* left_margin (40) - 1 */
+	.vsw		= 1,		/* vsync_len (2) - 1 */
+	.vfp		= 2,		/* lower_margin */
+	.vbp		= 7,		/* upper_margin (8) - 1 */
+
+	.pixel_clock	= LCD_PIXCLOCK_MAX,
+
+	.init		= sdp2430_panel_init,
+	.cleanup	= sdp2430_panel_cleanup,
+	.enable		= sdp2430_panel_enable,
+	.disable	= sdp2430_panel_disable,
+	.get_caps	= sdp2430_panel_get_caps,
+};
+
+static int sdp2430_panel_probe(struct platform_device *pdev)
+{
+	omapfb_register_panel(&sdp2430_panel);
+	return 0;
+}
+
+static int sdp2430_panel_remove(struct platform_device *pdev)
+{
+	return 0;
+}
+
+static int sdp2430_panel_suspend(struct platform_device *pdev, pm_message_t mesg)
+{
+	return 0;
+}
+
+static int sdp2430_panel_resume(struct platform_device *pdev)
+{
+	return 0;
+}
+
+struct platform_driver sdp2430_panel_driver = {
+	.probe		= sdp2430_panel_probe,
+	.remove		= sdp2430_panel_remove,
+	.suspend	= sdp2430_panel_suspend,
+	.resume		= sdp2430_panel_resume,
+	.driver		= {
+		.name	= "sdp2430_lcd",
+		.owner	= THIS_MODULE,
+	},
+};
+
+static int __init sdp2430_panel_drv_init(void)
+{
+	return platform_driver_register(&sdp2430_panel_driver);
+}
+
+static void __exit sdp2430_panel_drv_exit(void)
+{
+	platform_driver_unregister(&sdp2430_panel_driver);
+}
+
+module_init(sdp2430_panel_drv_init);
+module_exit(sdp2430_panel_drv_exit);
diff --git a/drivers/video/omap/lcd_ams_delta.c b/drivers/video/omap/lcd_ams_delta.c
new file mode 100644
index 0000000..3fd5342
--- /dev/null
+++ b/drivers/video/omap/lcd_ams_delta.c
@@ -0,0 +1,140 @@
+/*
+ * File: drivers/video/omap/lcd_ams_delta.c
+ *
+ * Based on drivers/video/omap/lcd_inn1510.c
+ *
+ * LCD panel support for the Amstrad E3 (Delta) videophone.
+ *
+ * Copyright (C) 2006 Jonathan McDowell <noodles@earth.li>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2 of the License, or (at your
+ * option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write to the Free Software Foundation, Inc.,
+ * 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
+ */
+
+#include <linux/module.h>
+#include <linux/platform_device.h>
+
+#include <asm/delay.h>
+#include <asm/io.h>
+
+#include <mach/board-ams-delta.h>
+#include <mach/hardware.h>
+#include <mach/omapfb.h>
+
+#define AMS_DELTA_DEFAULT_CONTRAST	112
+
+static int ams_delta_panel_init(struct lcd_panel *panel,
+		struct omapfb_device *fbdev)
+{
+	return 0;
+}
+
+static void ams_delta_panel_cleanup(struct lcd_panel *panel)
+{
+}
+
+static int ams_delta_panel_enable(struct lcd_panel *panel)
+{
+	ams_delta_latch2_write(AMS_DELTA_LATCH2_LCD_NDISP,
+			AMS_DELTA_LATCH2_LCD_NDISP);
+	ams_delta_latch2_write(AMS_DELTA_LATCH2_LCD_VBLEN,
+			AMS_DELTA_LATCH2_LCD_VBLEN);
+
+	omap_writeb(1, OMAP_PWL_CLK_ENABLE);
+	omap_writeb(AMS_DELTA_DEFAULT_CONTRAST, OMAP_PWL_ENABLE);
+
+	return 0;
+}
+
+static void ams_delta_panel_disable(struct lcd_panel *panel)
+{
+	ams_delta_latch2_write(AMS_DELTA_LATCH2_LCD_VBLEN, 0);
+	ams_delta_latch2_write(AMS_DELTA_LATCH2_LCD_NDISP, 0);
+}
+
+static unsigned long ams_delta_panel_get_caps(struct lcd_panel *panel)
+{
+	return 0;
+}
+
+static struct lcd_panel ams_delta_panel = {
+	.name		= "ams-delta",
+	.config		= 0,
+
+	.bpp		= 12,
+	.data_lines	= 16,
+	.x_res		= 480,
+	.y_res		= 320,
+	.pixel_clock	= 4687,
+	.hsw		= 3,
+	.hfp		= 1,
+	.hbp		= 1,
+	.vsw		= 1,
+	.vfp		= 0,
+	.vbp		= 0,
+	.pcd		= 0,
+	.acb		= 37,
+
+	.init		= ams_delta_panel_init,
+	.cleanup	= ams_delta_panel_cleanup,
+	.enable		= ams_delta_panel_enable,
+	.disable	= ams_delta_panel_disable,
+	.get_caps	= ams_delta_panel_get_caps,
+};
+
+static int ams_delta_panel_probe(struct platform_device *pdev)
+{
+	omapfb_register_panel(&ams_delta_panel);
+	return 0;
+}
+
+static int ams_delta_panel_remove(struct platform_device *pdev)
+{
+	return 0;
+}
+
+static int ams_delta_panel_suspend(struct platform_device *pdev,
+		pm_message_t mesg)
+{
+	return 0;
+}
+
+static int ams_delta_panel_resume(struct platform_device *pdev)
+{
+	return 0;
+}
+
+struct platform_driver ams_delta_panel_driver = {
+	.probe		= ams_delta_panel_probe,
+	.remove		= ams_delta_panel_remove,
+	.suspend	= ams_delta_panel_suspend,
+	.resume		= ams_delta_panel_resume,
+	.driver		= {
+		.name	= "lcd_ams_delta",
+		.owner	= THIS_MODULE,
+	},
+};
+
+static int ams_delta_panel_drv_init(void)
+{
+	return platform_driver_register(&ams_delta_panel_driver);
+}
+
+static void ams_delta_panel_drv_cleanup(void)
+{
+	platform_driver_unregister(&ams_delta_panel_driver);
+}
+
+module_init(ams_delta_panel_drv_init);
+module_exit(ams_delta_panel_drv_cleanup);
diff --git a/drivers/video/omap/lcd_apollon.c b/drivers/video/omap/lcd_apollon.c
new file mode 100644
index 0000000..beae5d9
--- /dev/null
+++ b/drivers/video/omap/lcd_apollon.c
@@ -0,0 +1,137 @@
+/*
+ * LCD panel support for the Samsung OMAP2 Apollon board
+ *
+ * Copyright (C) 2005,2006 Samsung Electronics
+ * Author: Kyungmin Park <kyungmin.park@samsung.com>
+ *
+ * Derived from drivers/video/omap/lcd-h4.c
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2 of the License, or (at your
+ * option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write to the Free Software Foundation, Inc.,
+ * 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
+ */
+
+#include <linux/module.h>
+#include <linux/platform_device.h>
+
+#include <mach/gpio.h>
+#include <mach/mux.h>
+#include <mach/omapfb.h>
+
+/* #define USE_35INCH_LCD 1 */
+
+static int apollon_panel_init(struct lcd_panel *panel,
+				struct omapfb_device *fbdev)
+{
+	/* configure LCD PWR_EN */
+	omap_cfg_reg(M21_242X_GPIO11);
+	return 0;
+}
+
+static void apollon_panel_cleanup(struct lcd_panel *panel)
+{
+}
+
+static int apollon_panel_enable(struct lcd_panel *panel)
+{
+	return 0;
+}
+
+static void apollon_panel_disable(struct lcd_panel *panel)
+{
+}
+
+static unsigned long apollon_panel_get_caps(struct lcd_panel *panel)
+{
+	return 0;
+}
+
+struct lcd_panel apollon_panel = {
+	.name		= "apollon",
+	.config		= OMAP_LCDC_PANEL_TFT | OMAP_LCDC_INV_VSYNC |
+			  OMAP_LCDC_INV_HSYNC,
+
+	.bpp		= 16,
+	.data_lines	= 18,
+#ifdef USE_35INCH_LCD
+	.x_res		= 240,
+	.y_res		= 320,
+	.hsw		= 2,
+	.hfp		= 3,
+	.hbp		= 9,
+	.vsw		= 4,
+	.vfp		= 3,
+	.vbp		= 5,
+#else
+	.x_res		= 480,
+	.y_res		= 272,
+	.hsw		= 41,
+	.hfp		= 2,
+	.hbp		= 2,
+	.vsw		= 10,
+	.vfp		= 2,
+	.vbp		= 2,
+#endif
+	.pixel_clock	= 6250,
+
+	.init		= apollon_panel_init,
+	.cleanup	= apollon_panel_cleanup,
+	.enable		= apollon_panel_enable,
+	.disable	= apollon_panel_disable,
+	.get_caps	= apollon_panel_get_caps,
+};
+
+static int apollon_panel_probe(struct platform_device *pdev)
+{
+	omapfb_register_panel(&apollon_panel);
+	return 0;
+}
+
+static int apollon_panel_remove(struct platform_device *pdev)
+{
+	return 0;
+}
+
+static int apollon_panel_suspend(struct platform_device *pdev, pm_message_t mesg)
+{
+	return 0;
+}
+
+static int apollon_panel_resume(struct platform_device *pdev)
+{
+	return 0;
+}
+
+struct platform_driver apollon_panel_driver = {
+	.probe		= apollon_panel_probe,
+	.remove		= apollon_panel_remove,
+	.suspend	= apollon_panel_suspend,
+	.resume		= apollon_panel_resume,
+	.driver		= {
+		.name	= "apollon_lcd",
+		.owner	= THIS_MODULE,
+	},
+};
+
+static int __init apollon_panel_drv_init(void)
+{
+	return platform_driver_register(&apollon_panel_driver);
+}
+
+static void __exit apollon_panel_drv_exit(void)
+{
+	platform_driver_unregister(&apollon_panel_driver);
+}
+
+module_init(apollon_panel_drv_init);
+module_exit(apollon_panel_drv_exit);
diff --git a/drivers/video/omap/lcd_h2.c b/drivers/video/omap/lcd_h2.c
new file mode 100644
index 0000000..96b4816
--- /dev/null
+++ b/drivers/video/omap/lcd_h2.c
@@ -0,0 +1,155 @@
+/*
+ * LCD panel support for the TI OMAP H2 board
+ *
+ * Copyright (C) 2004 Nokia Corporation
+ * Author: Imre Deak <imre.deak@nokia.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2 of the License, or (at your
+ * option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write to the Free Software Foundation, Inc.,
+ * 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
+ */
+
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/spi/tsc2101.h>
+
+#include <mach/mux.h>
+#include <mach/omapfb.h>
+
+static struct {
+	struct platform_device	*lcd_dev;
+	struct spi_device	*tsc2101_dev;
+} h2_panel_dev;
+
+static int h2_panel_init(struct lcd_panel *panel, struct omapfb_device *fbdev)
+{
+	return 0;
+}
+
+static void h2_panel_cleanup(struct lcd_panel *panel)
+{
+}
+
+static int h2_panel_enable(struct lcd_panel *panel)
+{
+	int r;
+
+	/*
+	 * Assert LCD_EN, BKLIGHT_EN pins on LCD panel
+	 * page2, GPIO config reg, GPIO(0,1) to out and asserted
+	 */
+	r = tsc2101_write_sync(h2_panel_dev.tsc2101_dev, 2, 0x23, 0xcc00);
+	if (r < 0)
+		dev_err(&h2_panel_dev.lcd_dev->dev,
+			"failed to enable LCD panel\n");
+
+	return r;
+}
+
+static void h2_panel_disable(struct lcd_panel *panel)
+{
+	/*
+	 * Deassert LCD_EN and BKLIGHT_EN pins on LCD panel
+	 * page2, GPIO config reg, GPIO(0,1) to out and deasserted
+	 */
+	if (tsc2101_write_sync(h2_panel_dev.tsc2101_dev, 2, 0x23, 0x8800))
+		dev_err(&h2_panel_dev.lcd_dev->dev,
+			"failed to disable LCD panel\n");
+}
+
+static unsigned long h2_panel_get_caps(struct lcd_panel *panel)
+{
+	return 0;
+}
+
+struct lcd_panel h2_panel = {
+	.name		= "h2",
+	.config		= OMAP_LCDC_PANEL_TFT,
+
+	.bpp		= 16,
+	.data_lines	= 16,
+	.x_res		= 240,
+	.y_res		= 320,
+	.pixel_clock	= 5000,
+	.hsw		= 12,
+	.hfp		= 12,
+	.hbp		= 46,
+	.vsw		= 1,
+	.vfp		= 1,
+	.vbp		= 0,
+
+	.init		= h2_panel_init,
+	.cleanup	= h2_panel_cleanup,
+	.enable		= h2_panel_enable,
+	.disable	= h2_panel_disable,
+	.get_caps	= h2_panel_get_caps,
+};
+
+static int h2_panel_probe(struct platform_device *pdev)
+{
+	struct spi_device *tsc2101;
+
+	tsc2101 = pdev->dev.platform_data;
+	if (tsc2101 == NULL) {
+		dev_err(&pdev->dev, "no platform data\n");
+		return -ENODEV;
+	}
+	if (strncmp(tsc2101->modalias, "tsc2101", 8) != 0) {
+		dev_err(&pdev->dev, "tsc2101 not found\n");
+		return -EINVAL;
+	}
+	h2_panel_dev.lcd_dev = pdev;
+	h2_panel_dev.tsc2101_dev = tsc2101;
+	omapfb_register_panel(&h2_panel);
+	return 0;
+}
+
+static int h2_panel_remove(struct platform_device *pdev)
+{
+	return 0;
+}
+
+static int h2_panel_suspend(struct platform_device *pdev, pm_message_t mesg)
+{
+	return 0;
+}
+
+static int h2_panel_resume(struct platform_device *pdev)
+{
+	return 0;
+}
+
+struct platform_driver h2_panel_driver = {
+	.probe		= h2_panel_probe,
+	.remove		= h2_panel_remove,
+	.suspend	= h2_panel_suspend,
+	.resume		= h2_panel_resume,
+	.driver		= {
+		.name	= "lcd_h2",
+		.owner	= THIS_MODULE,
+	},
+};
+
+static int h2_panel_drv_init(void)
+{
+	return platform_driver_register(&h2_panel_driver);
+}
+
+static void h2_panel_drv_cleanup(void)
+{
+	platform_driver_unregister(&h2_panel_driver);
+}
+
+module_init(h2_panel_drv_init);
+module_exit(h2_panel_drv_cleanup);
+
diff --git a/drivers/video/omap/lcd_mipid.c b/drivers/video/omap/lcd_mipid.c
new file mode 100644
index 0000000..1895997
--- /dev/null
+++ b/drivers/video/omap/lcd_mipid.c
@@ -0,0 +1,617 @@
+/*
+ * LCD driver for MIPI DBI-C / DCS compatible LCDs
+ *
+ * Copyright (C) 2006 Nokia Corporation
+ * Author: Imre Deak <imre.deak@nokia.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2 of the License, or (at your
+ * option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write to the Free Software Foundation, Inc.,
+ * 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
+ */
+#include <linux/device.h>
+#include <linux/delay.h>
+#include <linux/workqueue.h>
+#include <linux/spi/spi.h>
+
+#include <mach/omapfb.h>
+#include <mach/lcd_mipid.h>
+
+#include "../../cbus/tahvo.h"
+
+#define MIPID_MODULE_NAME		"lcd_mipid"
+
+#define MIPID_CMD_READ_DISP_ID		0x04
+#define MIPID_CMD_READ_RED		0x06
+#define MIPID_CMD_READ_GREEN		0x07
+#define MIPID_CMD_READ_BLUE		0x08
+#define MIPID_CMD_READ_DISP_STATUS	0x09
+#define MIPID_CMD_RDDSDR		0x0F
+#define MIPID_CMD_SLEEP_IN		0x10
+#define MIPID_CMD_SLEEP_OUT		0x11
+#define MIPID_CMD_DISP_OFF		0x28
+#define MIPID_CMD_DISP_ON		0x29
+
+#define MIPID_VER_LPH8923		3
+#define MIPID_VER_LS041Y3		4
+
+#define MIPID_ESD_CHECK_PERIOD		msecs_to_jiffies(5000)
+
+#define to_mipid_device(p)		container_of(p, struct mipid_device, \
+						panel)
+struct mipid_device {
+	int		enabled;
+	int		model;
+	int		revision;
+	u8		display_id[3];
+	unsigned int	saved_bklight_level;
+	unsigned long	hw_guard_end;		/* next value of jiffies
+						   when we can issue the
+						   next sleep in/out command */
+	unsigned long	hw_guard_wait;		/* max guard time in jiffies */
+
+	struct omapfb_device	*fbdev;
+	struct spi_device	*spi;
+	struct mutex		mutex;
+	struct lcd_panel	panel;
+
+	struct workqueue_struct	*esd_wq;
+	struct delayed_work	esd_work;
+	void			(*esd_check)(struct mipid_device *m);
+};
+
+static void mipid_transfer(struct mipid_device *md, int cmd, const u8 *wbuf,
+			   int wlen, u8 *rbuf, int rlen)
+{
+	struct spi_message	m;
+	struct spi_transfer	*x, xfer[4];
+	u16			w;
+	int			r;
+
+	BUG_ON(md->spi == NULL);
+
+	spi_message_init(&m);
+
+	memset(xfer, 0, sizeof(xfer));
+	x = &xfer[0];
+
+	cmd &=  0xff;
+	x->tx_buf	= &cmd;
+	x->bits_per_word= 9;
+	x->len		= 2;
+	spi_message_add_tail(x, &m);
+
+	if (wlen) {
+		x++;
+		x->tx_buf	= wbuf;
+		x->len		= wlen;
+		x->bits_per_word= 9;
+		spi_message_add_tail(x, &m);
+	}
+
+	if (rlen) {
+		x++;
+		x->rx_buf	= &w;
+		x->len		= 1;
+		spi_message_add_tail(x, &m);
+
+		if (rlen > 1) {
+			/* Arrange for the extra clock before the first
+			 * data bit.
+			 */
+			x->bits_per_word = 9;
+			x->len		 = 2;
+
+			x++;
+			x->rx_buf	 = &rbuf[1];
+			x->len		 = rlen - 1;
+			spi_message_add_tail(x, &m);
+		}
+	}
+
+	r = spi_sync(md->spi, &m);
+	if (r < 0)
+		dev_dbg(&md->spi->dev, "spi_sync %d\n", r);
+
+	if (rlen)
+		rbuf[0] = w & 0xff;
+}
+
+static inline void mipid_cmd(struct mipid_device *md, int cmd)
+{
+	mipid_transfer(md, cmd, NULL, 0, NULL, 0);
+}
+
+static inline void mipid_write(struct mipid_device *md,
+			       int reg, const u8 *buf, int len)
+{
+	mipid_transfer(md, reg, buf, len, NULL, 0);
+}
+
+static inline void mipid_read(struct mipid_device *md,
+			      int reg, u8 *buf, int len)
+{
+	mipid_transfer(md, reg, NULL, 0, buf, len);
+}
+
+static void set_data_lines(struct mipid_device *md, int data_lines)
+{
+	u16 par;
+
+	switch (data_lines) {
+	case 16:
+		par = 0x150;
+		break;
+	case 18:
+		par = 0x160;
+		break;
+	case 24:
+		par = 0x170;
+		break;
+	}
+	mipid_write(md, 0x3a, (u8 *)&par, 2);
+}
+
+static void send_init_string(struct mipid_device *md)
+{
+	u16 initpar[] = { 0x0102, 0x0100, 0x0100 };
+
+	mipid_write(md, 0xc2, (u8 *)initpar, sizeof(initpar));
+	set_data_lines(md, md->panel.data_lines);
+}
+
+static void hw_guard_start(struct mipid_device *md, int guard_msec)
+{
+	md->hw_guard_wait = msecs_to_jiffies(guard_msec);
+	md->hw_guard_end = jiffies + md->hw_guard_wait;
+}
+
+static void hw_guard_wait(struct mipid_device *md)
+{
+	unsigned long wait = md->hw_guard_end - jiffies;
+
+	if ((long)wait > 0 && wait <= md->hw_guard_wait) {
+		set_current_state(TASK_UNINTERRUPTIBLE);
+		schedule_timeout(wait);
+	}
+}
+
+static void set_sleep_mode(struct mipid_device *md, int on)
+{
+	int cmd, sleep_time = 50;
+
+	if (on)
+		cmd = MIPID_CMD_SLEEP_IN;
+	else
+		cmd = MIPID_CMD_SLEEP_OUT;
+	hw_guard_wait(md);
+	mipid_cmd(md, cmd);
+	hw_guard_start(md, 120);
+	/*
+	 * When we enable the panel, it seems we _have_ to sleep
+	 * 120 ms before sending the init string. When disabling the
+	 * panel we'll sleep for the duration of 2 frames, so that the
+	 * controller can still provide the PCLK,HS,VS signals. */
+	if (!on)
+		sleep_time = 120;
+	msleep(sleep_time);
+}
+
+static void set_display_state(struct mipid_device *md, int enabled)
+{
+	int cmd = enabled ? MIPID_CMD_DISP_ON : MIPID_CMD_DISP_OFF;
+
+	mipid_cmd(md, cmd);
+}
+
+static int mipid_set_bklight_level(struct lcd_panel *panel, unsigned int level)
+{
+	struct mipid_device *md = to_mipid_device(panel);
+
+	if (level > tahvo_get_max_backlight_level())
+		return -EINVAL;
+	if (!md->enabled) {
+		md->saved_bklight_level = level;
+		return 0;
+	}
+	tahvo_set_backlight_level(level);
+
+	return 0;
+}
+
+static unsigned int mipid_get_bklight_level(struct lcd_panel *panel)
+{
+	return tahvo_get_backlight_level();
+}
+
+static unsigned int mipid_get_bklight_max(struct lcd_panel *panel)
+{
+	return tahvo_get_max_backlight_level();
+}
+
+
+static unsigned long mipid_get_caps(struct lcd_panel *panel)
+{
+	return OMAPFB_CAPS_SET_BACKLIGHT;
+}
+
+static u16 read_first_pixel(struct mipid_device *md)
+{
+	u16 pixel;
+	u8 red, green, blue;
+
+	mutex_lock(&md->mutex);
+	mipid_read(md, MIPID_CMD_READ_RED, &red, 1);
+	mipid_read(md, MIPID_CMD_READ_GREEN, &green, 1);
+	mipid_read(md, MIPID_CMD_READ_BLUE, &blue, 1);
+	mutex_unlock(&md->mutex);
+
+	switch (md->panel.data_lines) {
+	case 16:
+		pixel = ((red >> 1) << 11) | (green << 5) | (blue >> 1);
+		break;
+	case 24:
+		/* 24 bit -> 16 bit */
+		pixel = ((red >> 3) << 11) | ((green >> 2) << 5) |
+			(blue >> 3);
+		break;
+	default:
+		BUG();
+	}
+
+	return pixel;
+}
+
+static int mipid_run_test(struct lcd_panel *panel, int test_num)
+{
+	struct mipid_device *md = to_mipid_device(panel);
+	static const u16 test_values[4] = {
+		0x0000, 0xffff, 0xaaaa, 0x5555,
+	};
+	int i;
+
+	if (test_num != MIPID_TEST_RGB_LINES)
+		return MIPID_TEST_INVALID;
+
+	for (i = 0; i < ARRAY_SIZE(test_values); i++) {
+		int delay;
+		unsigned long tmo;
+
+		omapfb_write_first_pixel(md->fbdev, test_values[i]);
+		tmo = jiffies + msecs_to_jiffies(100);
+		delay = 25;
+		while (1) {
+			u16 pixel;
+
+			msleep(delay);
+			pixel = read_first_pixel(md);
+			if (pixel == test_values[i])
+				break;
+			if (time_after(jiffies, tmo)) {
+				dev_err(&md->spi->dev,
+					"MIPI LCD RGB I/F test failed: "
+					"expecting %04x, got %04x\n",
+					test_values[i], pixel);
+				return MIPID_TEST_FAILED;
+			}
+			delay = 10;
+		}
+	}
+
+	return 0;
+}
+
+static void ls041y3_esd_recover(struct mipid_device *md)
+{
+	dev_err(&md->spi->dev, "performing LCD ESD recovery\n");
+	set_sleep_mode(md, 1);
+	set_sleep_mode(md, 0);
+}
+
+static void ls041y3_esd_check_mode1(struct mipid_device *md)
+{
+	u8 state1, state2;
+
+	mipid_read(md, MIPID_CMD_RDDSDR, &state1, 1);
+	set_sleep_mode(md, 0);
+	mipid_read(md, MIPID_CMD_RDDSDR, &state2, 1);
+	dev_dbg(&md->spi->dev, "ESD mode 1 state1 %02x state2 %02x\n",
+		state1, state2);
+	/* Each sleep out command will trigger a self diagnostic and flip
+	* Bit6 if the test passes.
+	*/
+	if (!((state1 ^ state2) & (1 << 6)))
+		ls041y3_esd_recover(md);
+}
+
+static void ls041y3_esd_check_mode2(struct mipid_device *md)
+{
+	int i;
+	u8 rbuf[2];
+	static const struct {
+		int	cmd;
+		int	wlen;
+		u16	wbuf[3];
+	} *rd, rd_ctrl[7] = {
+		{ 0xb0, 4, { 0x0101, 0x01fe, } },
+		{ 0xb1, 4, { 0x01de, 0x0121, } },
+		{ 0xc2, 4, { 0x0100, 0x0100, } },
+		{ 0xbd, 2, { 0x0100, } },
+		{ 0xc2, 4, { 0x01fc, 0x0103, } },
+		{ 0xb4, 0, },
+		{ 0x00, 0, },
+	};
+
+	rd = rd_ctrl;
+	for (i = 0; i < 3; i++, rd++)
+		mipid_write(md, rd->cmd, (u8 *)rd->wbuf, rd->wlen);
+
+	udelay(10);
+	mipid_read(md, rd->cmd, rbuf, 2);
+	rd++;
+
+	for (i = 0; i < 3; i++, rd++) {
+		udelay(10);
+		mipid_write(md, rd->cmd, (u8 *)rd->wbuf, rd->wlen);
+	}
+
+	dev_dbg(&md->spi->dev, "ESD mode 2 state %02x\n", rbuf[1]);
+	if (rbuf[1] == 0x00)
+		ls041y3_esd_recover(md);
+}
+
+static void ls041y3_esd_check(struct mipid_device *md)
+{
+	ls041y3_esd_check_mode1(md);
+	if (md->revision >= 0x88)
+		ls041y3_esd_check_mode2(md);
+}
+
+static void mipid_esd_start_check(struct mipid_device *md)
+{
+	if (md->esd_check != NULL)
+		queue_delayed_work(md->esd_wq, &md->esd_work,
+				   MIPID_ESD_CHECK_PERIOD);
+}
+
+static void mipid_esd_stop_check(struct mipid_device *md)
+{
+	if (md->esd_check != NULL)
+		cancel_rearming_delayed_workqueue(md->esd_wq, &md->esd_work);
+}
+
+static void mipid_esd_work(struct work_struct *work)
+{
+	struct mipid_device *md = container_of(work, struct mipid_device, esd_work.work);
+
+	mutex_lock(&md->mutex);
+	md->esd_check(md);
+	mutex_unlock(&md->mutex);
+	mipid_esd_start_check(md);
+}
+
+static int mipid_enable(struct lcd_panel *panel)
+{
+	struct mipid_device *md = to_mipid_device(panel);
+
+	mutex_lock(&md->mutex);
+
+	if (md->enabled) {
+		mutex_unlock(&md->mutex);
+		return 0;
+	}
+	set_sleep_mode(md, 0);
+	md->enabled = 1;
+	send_init_string(md);
+	set_display_state(md, 1);
+	mipid_set_bklight_level(panel, md->saved_bklight_level);
+	mipid_esd_start_check(md);
+
+	mutex_unlock(&md->mutex);
+	return 0;
+}
+
+static void mipid_disable(struct lcd_panel *panel)
+{
+	struct mipid_device *md = to_mipid_device(panel);
+
+	/*
+	 * A final ESD work might be called before returning,
+	 * so do this without holding the lock.
+	 */
+	mipid_esd_stop_check(md);
+	mutex_lock(&md->mutex);
+
+	if (!md->enabled) {
+		mutex_unlock(&md->mutex);
+		return;
+	}
+	md->saved_bklight_level = mipid_get_bklight_level(panel);
+	mipid_set_bklight_level(panel, 0);
+	set_display_state(md, 0);
+	set_sleep_mode(md, 1);
+	md->enabled = 0;
+
+	mutex_unlock(&md->mutex);
+}
+
+static int panel_enabled(struct mipid_device *md)
+{
+	u32 disp_status;
+	int enabled;
+
+	mipid_read(md, MIPID_CMD_READ_DISP_STATUS, (u8 *)&disp_status, 4);
+	disp_status = __be32_to_cpu(disp_status);
+	enabled = (disp_status & (1 << 17)) && (disp_status & (1 << 10));
+	dev_dbg(&md->spi->dev,
+		"LCD panel %senabled by bootloader (status 0x%04x)\n",
+		enabled ? "" : "not ", disp_status);
+	return enabled;
+}
+
+static int mipid_init(struct lcd_panel *panel,
+			    struct omapfb_device *fbdev)
+{
+	struct mipid_device *md = to_mipid_device(panel);
+
+	md->fbdev = fbdev;
+	md->esd_wq = create_singlethread_workqueue("mipid_esd");
+	if (md->esd_wq == NULL) {
+		dev_err(&md->spi->dev, "can't create ESD workqueue\n");
+		return -ENOMEM;
+	}
+	INIT_DELAYED_WORK(&md->esd_work, mipid_esd_work);
+	mutex_init(&md->mutex);
+
+	md->enabled = panel_enabled(md);
+
+	if (md->enabled)
+		mipid_esd_start_check(md);
+	else
+		md->saved_bklight_level = mipid_get_bklight_level(panel);
+
+	return 0;
+}
+
+static void mipid_cleanup(struct lcd_panel *panel)
+{
+	struct mipid_device *md = to_mipid_device(panel);
+
+	if (md->enabled)
+		mipid_esd_stop_check(md);
+	destroy_workqueue(md->esd_wq);
+}
+
+static struct lcd_panel mipid_panel = {
+	.config		= OMAP_LCDC_PANEL_TFT,
+
+	.bpp		= 16,
+	.x_res		= 800,
+	.y_res		= 480,
+	.pixel_clock	= 21940,
+	.hsw		= 50,
+	.hfp		= 20,
+	.hbp		= 15,
+	.vsw		= 2,
+	.vfp		= 1,
+	.vbp		= 3,
+
+	.init		= mipid_init,
+	.cleanup	= mipid_cleanup,
+	.enable		= mipid_enable,
+	.disable	= mipid_disable,
+	.get_caps	= mipid_get_caps,
+	.set_bklight_level= mipid_set_bklight_level,
+	.get_bklight_level= mipid_get_bklight_level,
+	.get_bklight_max= mipid_get_bklight_max,
+	.run_test	= mipid_run_test,
+};
+
+static int mipid_detect(struct mipid_device *md)
+{
+	struct mipid_platform_data *pdata;
+
+	pdata = md->spi->dev.platform_data;
+	if (pdata == NULL) {
+		dev_err(&md->spi->dev, "missing platform data\n");
+		return -ENOENT;
+	}
+
+	mipid_read(md, MIPID_CMD_READ_DISP_ID, md->display_id, 3);
+	dev_dbg(&md->spi->dev, "MIPI display ID: %02x%02x%02x\n",
+		md->display_id[0], md->display_id[1], md->display_id[2]);
+
+	switch (md->display_id[0]) {
+	case 0x45:
+		md->model = MIPID_VER_LPH8923;
+		md->panel.name = "lph8923";
+		break;
+	case 0x83:
+		md->model = MIPID_VER_LS041Y3;
+		md->panel.name = "ls041y3";
+		md->esd_check = ls041y3_esd_check;
+		break;
+	default:
+		md->panel.name = "unknown";
+		dev_err(&md->spi->dev, "invalid display ID\n");
+		return -ENODEV;
+	}
+
+	md->revision = md->display_id[1];
+	md->panel.data_lines = pdata->data_lines;
+	pr_info("omapfb: %s rev %02x LCD detected\n",
+			md->panel.name, md->revision);
+
+	return 0;
+}
+
+static int mipid_spi_probe(struct spi_device *spi)
+{
+	struct mipid_device *md;
+	int r;
+
+	md = kzalloc(sizeof(*md), GFP_KERNEL);
+	if (md == NULL) {
+		dev_err(&spi->dev, "out of memory\n");
+		return -ENOMEM;
+	}
+
+	spi->mode = SPI_MODE_0;
+	md->spi = spi;
+	dev_set_drvdata(&spi->dev, md);
+	md->panel = mipid_panel;
+
+	r = mipid_detect(md);
+	if (r < 0)
+		return r;
+
+	omapfb_register_panel(&md->panel);
+
+	return 0;
+}
+
+static int mipid_spi_remove(struct spi_device *spi)
+{
+	struct mipid_device *md = dev_get_drvdata(&spi->dev);
+
+	mipid_disable(&md->panel);
+	kfree(md);
+
+	return 0;
+}
+
+static struct spi_driver mipid_spi_driver = {
+	.driver = {
+		.name	= MIPID_MODULE_NAME,
+		.bus	= &spi_bus_type,
+		.owner	= THIS_MODULE,
+	},
+	.probe	= mipid_spi_probe,
+	.remove	= __devexit_p(mipid_spi_remove),
+};
+
+static int mipid_drv_init(void)
+{
+	spi_register_driver(&mipid_spi_driver);
+
+	return 0;
+}
+module_init(mipid_drv_init);
+
+static void mipid_drv_cleanup(void)
+{
+	spi_unregister_driver(&mipid_spi_driver);
+}
+module_exit(mipid_drv_cleanup);
+
+MODULE_DESCRIPTION("MIPI display driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/video/omap/lcd_omap2evm.c b/drivers/video/omap/lcd_omap2evm.c
new file mode 100644
index 0000000..8a0105e
--- /dev/null
+++ b/drivers/video/omap/lcd_omap2evm.c
@@ -0,0 +1,195 @@
+/*
+ * LCD panel support for the MISTRAL OMAP2EVM board
+ *
+ * Author: Arun C <arunedarath@mistralsolutions.com>
+ *
+ * Derived from drivers/video/omap/lcd_omap3evm.c
+ * Derived from drivers/video/omap/lcd-apollon.c
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2 of the License, or (at your
+ * option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write to the Free Software Foundation, Inc.,
+ * 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
+ */
+
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/i2c/twl4030.h>
+
+#include <mach/gpio.h>
+#include <mach/mux.h>
+#include <mach/omapfb.h>
+#include <asm/mach-types.h>
+
+#define LCD_PANEL_ENABLE_GPIO	154
+#define LCD_PANEL_LR		128
+#define LCD_PANEL_UD		129
+#define LCD_PANEL_INI		152
+#define LCD_PANEL_QVGA		148
+#define LCD_PANEL_RESB		153
+
+#define LCD_XRES		480
+#define LCD_YRES		640
+#define LCD_PIXCLOCK_MAX	20000 /* in kHz */
+
+#define TWL_LED_LEDEN		0x00
+#define TWL_PWMA_PWMAON		0x00
+#define TWL_PWMA_PWMAOFF	0x01
+
+static unsigned int bklight_level;
+
+static int omap2evm_panel_init(struct lcd_panel *panel,
+				struct omapfb_device *fbdev)
+{
+	omap_request_gpio(LCD_PANEL_ENABLE_GPIO);
+	omap_request_gpio(LCD_PANEL_LR);
+	omap_request_gpio(LCD_PANEL_UD);
+	omap_request_gpio(LCD_PANEL_INI);
+	omap_request_gpio(LCD_PANEL_QVGA);
+	omap_request_gpio(LCD_PANEL_RESB);
+
+	omap_set_gpio_direction(LCD_PANEL_ENABLE_GPIO, 0);
+	omap_set_gpio_direction(LCD_PANEL_LR, 0);
+	omap_set_gpio_direction(LCD_PANEL_UD, 0);
+	omap_set_gpio_direction(LCD_PANEL_INI, 0);
+	omap_set_gpio_direction(LCD_PANEL_QVGA, 0);
+	omap_set_gpio_direction(LCD_PANEL_RESB, 0);
+
+	omap_set_gpio_dataout(LCD_PANEL_RESB, 1);
+	omap_set_gpio_dataout(LCD_PANEL_INI, 1);
+	omap_set_gpio_dataout(LCD_PANEL_QVGA, 0);
+	omap_set_gpio_dataout(LCD_PANEL_LR, 1);
+	omap_set_gpio_dataout(LCD_PANEL_UD, 1);
+
+	twl4030_i2c_write_u8(TWL4030_MODULE_LED, 0x11, TWL_LED_LEDEN);
+	twl4030_i2c_write_u8(TWL4030_MODULE_PWMA, 0x01, TWL_PWMA_PWMAON);
+	twl4030_i2c_write_u8(TWL4030_MODULE_PWMA, 0x02, TWL_PWMA_PWMAOFF);
+	bklight_level = 100;
+
+	return 0;
+}
+
+static void omap2evm_panel_cleanup(struct lcd_panel *panel)
+{
+}
+
+static int omap2evm_panel_enable(struct lcd_panel *panel)
+{
+	omap_set_gpio_dataout(LCD_PANEL_ENABLE_GPIO, 0);
+	return 0;
+}
+
+static void omap2evm_panel_disable(struct lcd_panel *panel)
+{
+	omap_set_gpio_dataout(LCD_PANEL_ENABLE_GPIO, 1);
+}
+
+static unsigned long omap2evm_panel_get_caps(struct lcd_panel *panel)
+{
+	return 0;
+}
+
+static int omap2evm_bklight_setlevel(struct lcd_panel *panel,
+						unsigned int level)
+{
+	u8 c;
+	if ((level >= 0) && (level <= 100)) {
+		c = (125 * (100 - level)) / 100 + 2;
+		twl4030_i2c_write_u8(TWL4030_MODULE_PWMA, c, TWL_PWMA_PWMAOFF);
+		bklight_level = level;
+	}
+	return 0;
+}
+
+static unsigned int omap2evm_bklight_getlevel(struct lcd_panel *panel)
+{
+	return bklight_level;
+}
+
+static unsigned int omap2evm_bklight_getmaxlevel(struct lcd_panel *panel)
+{
+	return 100;
+}
+
+struct lcd_panel omap2evm_panel = {
+	.name		= "omap2evm",
+	.config		= OMAP_LCDC_PANEL_TFT | OMAP_LCDC_INV_VSYNC |
+			  OMAP_LCDC_INV_HSYNC,
+
+	.bpp		= 16,
+	.data_lines	= 18,
+	.x_res		= LCD_XRES,
+	.y_res		= LCD_YRES,
+	.hsw		= 3,
+	.hfp		= 0,
+	.hbp		= 28,
+	.vsw		= 2,
+	.vfp		= 1,
+	.vbp		= 0,
+
+	.pixel_clock	= LCD_PIXCLOCK_MAX,
+
+	.init		= omap2evm_panel_init,
+	.cleanup	= omap2evm_panel_cleanup,
+	.enable		= omap2evm_panel_enable,
+	.disable	= omap2evm_panel_disable,
+	.get_caps	= omap2evm_panel_get_caps,
+	.set_bklight_level      = omap2evm_bklight_setlevel,
+	.get_bklight_level      = omap2evm_bklight_getlevel,
+	.get_bklight_max        = omap2evm_bklight_getmaxlevel,
+};
+
+static int omap2evm_panel_probe(struct platform_device *pdev)
+{
+	omapfb_register_panel(&omap2evm_panel);
+	return 0;
+}
+
+static int omap2evm_panel_remove(struct platform_device *pdev)
+{
+	return 0;
+}
+
+static int omap2evm_panel_suspend(struct platform_device *pdev,
+				   pm_message_t mesg)
+{
+	return 0;
+}
+
+static int omap2evm_panel_resume(struct platform_device *pdev)
+{
+	return 0;
+}
+
+struct platform_driver omap2evm_panel_driver = {
+	.probe		= omap2evm_panel_probe,
+	.remove		= omap2evm_panel_remove,
+	.suspend	= omap2evm_panel_suspend,
+	.resume		= omap2evm_panel_resume,
+	.driver		= {
+		.name	= "omap2evm_lcd",
+		.owner	= THIS_MODULE,
+	},
+};
+
+static int __init omap2evm_panel_drv_init(void)
+{
+	return platform_driver_register(&omap2evm_panel_driver);
+}
+
+static void __exit omap2evm_panel_drv_exit(void)
+{
+	platform_driver_unregister(&omap2evm_panel_driver);
+}
+
+module_init(omap2evm_panel_drv_init);
+module_exit(omap2evm_panel_drv_exit);
diff --git a/drivers/video/omap/lcd_omap3beagle.c b/drivers/video/omap/lcd_omap3beagle.c
new file mode 100644
index 0000000..9637735
--- /dev/null
+++ b/drivers/video/omap/lcd_omap3beagle.c
@@ -0,0 +1,133 @@
+/*
+ * LCD panel support for the TI OMAP3 Beagle board
+ *
+ * Author: Koen Kooi <koen@openembedded.org>
+ *
+ * Derived from drivers/video/omap/lcd-omap3evm.c
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2 of the License, or (at your
+ * option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write to the Free Software Foundation, Inc.,
+ * 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
+ */
+
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/i2c/twl4030.h>
+
+#include <mach/gpio.h>
+#include <mach/mux.h>
+#include <mach/omapfb.h>
+#include <asm/mach-types.h>
+
+#define LCD_PANEL_ENABLE_GPIO       170
+
+#define LCD_XRES		1024	
+#define LCD_YRES 		768
+#define LCD_PIXCLOCK		64000 /* in kHz */
+
+static int omap3beagle_panel_init(struct lcd_panel *panel,
+				struct omapfb_device *fbdev)
+{
+	omap_request_gpio(LCD_PANEL_ENABLE_GPIO);
+	return 0;
+}
+
+static void omap3beagle_panel_cleanup(struct lcd_panel *panel)
+{
+}
+
+static int omap3beagle_panel_enable(struct lcd_panel *panel)
+{
+	omap_set_gpio_dataout(LCD_PANEL_ENABLE_GPIO, 1);
+	return 0;
+}
+
+static void omap3beagle_panel_disable(struct lcd_panel *panel)
+{
+	omap_set_gpio_dataout(LCD_PANEL_ENABLE_GPIO, 0);
+}
+
+static unsigned long omap3beagle_panel_get_caps(struct lcd_panel *panel)
+{
+	return 0;
+}
+
+struct lcd_panel omap3beagle_panel = {
+	.name		= "omap3beagle",
+	.config		= OMAP_LCDC_PANEL_TFT,
+
+	.bpp		= 24,
+	.data_lines	= 24,
+	.x_res		= LCD_XRES,
+	.y_res		= LCD_YRES,
+	.hsw		= 3,		/* hsync_len (4) - 1 */
+	.hfp		= 3,		/* right_margin (4) - 1 */
+	.hbp		= 39,		/* left_margin (40) - 1 */
+	.vsw		= 1,		/* vsync_len (2) - 1 */
+	.vfp		= 2,		/* lower_margin */
+	.vbp		= 7,		/* upper_margin (8) - 1 */
+
+	.pixel_clock	= LCD_PIXCLOCK,
+
+	.init		= omap3beagle_panel_init,
+	.cleanup	= omap3beagle_panel_cleanup,
+	.enable		= omap3beagle_panel_enable,
+	.disable	= omap3beagle_panel_disable,
+	.get_caps	= omap3beagle_panel_get_caps,
+};
+
+static int omap3beagle_panel_probe(struct platform_device *pdev)
+{
+	omapfb_register_panel(&omap3beagle_panel);
+	return 0;
+}
+
+static int omap3beagle_panel_remove(struct platform_device *pdev)
+{
+	return 0;
+}
+
+static int omap3beagle_panel_suspend(struct platform_device *pdev,
+				   pm_message_t mesg)
+{
+	return 0;
+}
+
+static int omap3beagle_panel_resume(struct platform_device *pdev)
+{
+	return 0;
+}
+
+struct platform_driver omap3beagle_panel_driver = {
+	.probe		= omap3beagle_panel_probe,
+	.remove		= omap3beagle_panel_remove,
+	.suspend	= omap3beagle_panel_suspend,
+	.resume		= omap3beagle_panel_resume,
+	.driver		= {
+		.name	= "omap3beagle_lcd",
+		.owner	= THIS_MODULE,
+	},
+};
+
+static int __init omap3beagle_panel_drv_init(void)
+{
+	return platform_driver_register(&omap3beagle_panel_driver);
+}
+
+static void __exit omap3beagle_panel_drv_exit(void)
+{
+	platform_driver_unregister(&omap3beagle_panel_driver);
+}
+
+module_init(omap3beagle_panel_drv_init);
+module_exit(omap3beagle_panel_drv_exit);
diff --git a/drivers/video/omap/lcd_omap3evm.c b/drivers/video/omap/lcd_omap3evm.c
new file mode 100644
index 0000000..a564ca5
--- /dev/null
+++ b/drivers/video/omap/lcd_omap3evm.c
@@ -0,0 +1,197 @@
+/*
+ * LCD panel support for the TI OMAP3 EVM board
+ *
+ * Author: Steve Sakoman <steve@sakoman.com>
+ *
+ * Derived from drivers/video/omap/lcd-apollon.c
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2 of the License, or (at your
+ * option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write to the Free Software Foundation, Inc.,
+ * 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
+ */
+
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/i2c/twl4030.h>
+
+#include <mach/gpio.h>
+#include <mach/mux.h>
+#include <mach/omapfb.h>
+#include <asm/mach-types.h>
+
+#define LCD_PANEL_ENABLE_GPIO       153
+#define LCD_PANEL_LR                2
+#define LCD_PANEL_UD                3
+#define LCD_PANEL_INI               152
+#define LCD_PANEL_QVGA              154
+#define LCD_PANEL_RESB              155
+
+#define LCD_XRES	 	480
+#define LCD_YRES 		640
+#define LCD_PIXCLOCK		26000 /* in kHz  */
+
+#define ENABLE_VDAC_DEDICATED	0x03
+#define ENABLE_VDAC_DEV_GRP	0x20
+#define ENABLE_VPLL2_DEDICATED	0x05
+#define ENABLE_VPLL2_DEV_GRP	0xE0
+
+#define TWL_LED_LEDEN		0x00
+#define TWL_PWMA_PWMAON		0x00
+#define TWL_PWMA_PWMAOFF	0x01
+
+static unsigned int bklight_level;
+
+static int omap3evm_panel_init(struct lcd_panel *panel,
+				struct omapfb_device *fbdev)
+{
+	omap_request_gpio(LCD_PANEL_LR);
+	omap_request_gpio(LCD_PANEL_UD);
+	omap_request_gpio(LCD_PANEL_INI);
+	omap_request_gpio(LCD_PANEL_RESB);
+	omap_request_gpio(LCD_PANEL_QVGA);
+
+	omap_set_gpio_direction(LCD_PANEL_LR, 0);
+	omap_set_gpio_direction(LCD_PANEL_UD, 0);
+	omap_set_gpio_direction(LCD_PANEL_INI, 0);
+	omap_set_gpio_direction(LCD_PANEL_RESB, 0);
+	omap_set_gpio_direction(LCD_PANEL_QVGA, 0);
+
+	twl4030_i2c_write_u8(TWL4030_MODULE_LED, 0x11, TWL_LED_LEDEN);
+	twl4030_i2c_write_u8(TWL4030_MODULE_PWMA, 0x01, TWL_PWMA_PWMAON);
+	twl4030_i2c_write_u8(TWL4030_MODULE_PWMA, 0x02, TWL_PWMA_PWMAOFF);
+	bklight_level = 100;
+
+	omap_set_gpio_dataout(LCD_PANEL_RESB, 1);
+	omap_set_gpio_dataout(LCD_PANEL_INI, 1);
+	omap_set_gpio_dataout(LCD_PANEL_QVGA, 0);
+	omap_set_gpio_dataout(LCD_PANEL_LR, 1);
+	omap_set_gpio_dataout(LCD_PANEL_UD, 1);
+
+	return 0;
+}
+
+static void omap3evm_panel_cleanup(struct lcd_panel *panel)
+{
+}
+
+static int omap3evm_panel_enable(struct lcd_panel *panel)
+{
+	omap_set_gpio_dataout(LCD_PANEL_ENABLE_GPIO, 0);
+	return 0;
+}
+
+static void omap3evm_panel_disable(struct lcd_panel *panel)
+{
+	omap_set_gpio_dataout(LCD_PANEL_ENABLE_GPIO, 1);
+}
+
+static unsigned long omap3evm_panel_get_caps(struct lcd_panel *panel)
+{
+	return 0;
+}
+
+static int omap3evm_bklight_setlevel(struct lcd_panel *panel,
+						unsigned int level)
+{
+	u8 c;
+	if ((level >= 0) && (level <= 100)) {
+		c = (125 * (100 - level)) / 100 + 2;
+		twl4030_i2c_write_u8(TWL4030_MODULE_PWMA, c, TWL_PWMA_PWMAOFF);
+		bklight_level = level;
+	}
+	return 0;
+}
+
+static unsigned int omap3evm_bklight_getlevel(struct lcd_panel *panel)
+{
+	return bklight_level;
+}
+
+static unsigned int omap3evm_bklight_getmaxlevel(struct lcd_panel *panel)
+{
+	return 100;
+}
+
+struct lcd_panel omap3evm_panel = {
+	.name		= "omap3evm",
+	.config		= OMAP_LCDC_PANEL_TFT | OMAP_LCDC_INV_VSYNC |
+			  OMAP_LCDC_INV_HSYNC,
+
+	.bpp		= 16,
+	.data_lines	= 18,
+	.x_res		= LCD_XRES,
+	.y_res		= LCD_YRES,
+	.hsw		= 3,		/* hsync_len (4) - 1 */
+	.hfp		= 3,		/* right_margin (4) - 1 */
+	.hbp		= 39,		/* left_margin (40) - 1 */
+	.vsw		= 1,		/* vsync_len (2) - 1 */
+	.vfp		= 2,		/* lower_margin */
+	.vbp		= 7,		/* upper_margin (8) - 1 */
+
+	.pixel_clock	= LCD_PIXCLOCK,
+
+	.init		= omap3evm_panel_init,
+	.cleanup	= omap3evm_panel_cleanup,
+	.enable		= omap3evm_panel_enable,
+	.disable	= omap3evm_panel_disable,
+	.get_caps	= omap3evm_panel_get_caps,
+	.set_bklight_level      = omap3evm_bklight_setlevel,
+	.get_bklight_level      = omap3evm_bklight_getlevel,
+	.get_bklight_max        = omap3evm_bklight_getmaxlevel,
+};
+
+static int omap3evm_panel_probe(struct platform_device *pdev)
+{
+	omapfb_register_panel(&omap3evm_panel);
+	return 0;
+}
+
+static int omap3evm_panel_remove(struct platform_device *pdev)
+{
+	return 0;
+}
+
+static int omap3evm_panel_suspend(struct platform_device *pdev,
+				   pm_message_t mesg)
+{
+	return 0;
+}
+
+static int omap3evm_panel_resume(struct platform_device *pdev)
+{
+	return 0;
+}
+
+struct platform_driver omap3evm_panel_driver = {
+	.probe		= omap3evm_panel_probe,
+	.remove		= omap3evm_panel_remove,
+	.suspend	= omap3evm_panel_suspend,
+	.resume		= omap3evm_panel_resume,
+	.driver		= {
+		.name	= "omap3evm_lcd",
+		.owner	= THIS_MODULE,
+	},
+};
+
+static int __init omap3evm_panel_drv_init(void)
+{
+	return platform_driver_register(&omap3evm_panel_driver);
+}
+
+static void __exit omap3evm_panel_drv_exit(void)
+{
+	platform_driver_unregister(&omap3evm_panel_driver);
+}
+
+module_init(omap3evm_panel_drv_init);
+module_exit(omap3evm_panel_drv_exit);
diff --git a/drivers/video/omap/lcd_p2.c b/drivers/video/omap/lcd_p2.c
new file mode 100644
index 0000000..8c66bf6
--- /dev/null
+++ b/drivers/video/omap/lcd_p2.c
@@ -0,0 +1,342 @@
+/*
+ * LCD panel support for the TI OMAP P2 board
+ *
+ * Authors:
+ *   jekyll <jekyll@mail.jekyll.idv.tw>
+ *   B Jp <lastjp_fr@yahoo.fr>
+ *   Brian Swetland <swetland@android.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2 of the License, or (at your
+ * option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write to the Free Software Foundation, Inc.,
+ * 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
+ */
+
+#include <linux/module.h>
+#include <linux/delay.h>
+#include <linux/platform_device.h>
+
+#include <mach/mux.h>
+#include <mach/gpio.h>
+#include <mach/omapfb.h>
+
+/*
+ * File: epson-md-tft.h
+ *
+ * This file contains definitions for Epsons MD-TF LCD Module
+ *
+ * Copyright (C) 2004 MPC-Data Limited  (http://www.mpc-data.co.uk)
+ * Author: Dave Peverley <dpeverley at mpc-data.co.uk>
+ *
+ *  This program is free software; you can redistribute  it and/or modify it
+ *  under  the terms of  the GNU General  Public License as published by the
+ *  Free Software Foundation;  either version 2 of the  License, or (at your
+ *  option) any later version.
+ *
+ *  THIS  SOFTWARE  IS  PROVIDED  ``AS  IS''  AND   ANY  EXPRESS  OR IMPLIED
+ *  WARRANTIES,   INCLUDING, BUT NOT  LIMITED  TO, THE IMPLIED WARRANTIES OF
+ *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN
+ *  NO  EVENT  SHALL   THE AUTHOR  BE    LIABLE FOR ANY   DIRECT,  INDIRECT,
+ *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
+ *  NOT LIMITED   TO, PROCUREMENT OF  SUBSTITUTE GOODS  OR SERVICES; LOSS OF
+ *  USE, DATA,  OR PROFITS; OR  BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
+ *  ANY THEORY OF LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, OR TORT
+ *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
+ *  THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ *
+ *  You should have received a copy of the  GNU General Public License along
+ *  with this program; if not, write  to the Free Software Foundation, Inc.,
+ *  675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ * Please report all bugs and problems to the author.
+ *
+ */
+
+/* LCD uWire commands & params
+ * All values from Epson
+ */
+#define LCD_DISON 0xAF
+#define LCD_DISOFF 0xAE
+#define LCD_DISNOR 0xA6
+#define LCD_DISINV 0xA7
+#define LCD_DISCTL 0xCA
+#define LCD_GCP64 0xCB
+#define LCD_GCP16 0xCC
+#define LCD_GSSET 0xCD
+#define LCD_SLPIN 0x95
+#define LCD_SLPOUT 0x94
+#define LCD_SD_PSET 0x75
+#define LCD_MD_PSET 0x76
+#define LCD_SD_CSET 0x15
+#define LCD_MD_CSET 0x16
+#define LCD_DATCTL 0xBC
+#define LCD_RAMWR 0x5C
+#define LCD_RAMRD 0x5D
+#define LCD_PTLIN 0xA8
+#define LCD_PTLOUT 0xA9
+#define LCD_ASCSET 0xAA
+#define LCD_SCSTART 0xAB
+#define LCD_VOLCTL 0xC6
+#define LCD_NOP 0x25
+#define LCD_OSCISEL 0x7
+#define LCD_3500KSET 0xD1
+#define LCD_3500KEND 0xD2
+#define LCD_14MSET 0xD3
+#define LCD_14MEND 0xD4
+
+#define INIT_3500KSET 0x45
+#define INIT_14MSET 0x4B
+#define INIT_DATCTL 0x08 /* 6.6.6 bits for D-Sample */
+
+#define INIT_OSCISEL 0x05
+
+#define INIT_VOLCTL 0x77 /* Nominel "volume" */
+
+#define INIT_VOLCTL_Ton 0x98 /* Activate power-IC timer */
+#define INIT_GSSET 0x00
+
+const unsigned short INIT_DISCTL[11] =
+{
+	0xDE, 0x01, 0x64, 0x00, 0x1B, 0xF4, 0x00, 0xDC, 0x00, 0x02, 0x00
+};
+
+const unsigned short INIT_GCP64[126] =
+{
+	0x3B,0x00,0x42,0x00,0x4A,0x00,0x51,0x00,
+	0x58,0x00,0x5F,0x00,0x66,0x00,0x6E,0x00,
+	0x75,0x00,0x7C,0x00,0x83,0x00,0x8A,0x00,
+	0x92,0x00,0x99,0x00,0xA0,0x00,0xA7,0x00,
+	0xAE,0x00,0xB6,0x00,0xBD,0x00,0xC4,0x00,
+	0xCB,0x00,0xD2,0x00,0xDA,0x00,0xE1,0x00,
+	0xE8,0x00,0xEF,0x00,0xF6,0x00,0xFE,0x00,
+	0x05,0x01,0x0C,0x01,0x13,0x01,0x1A,0x01,
+	0x22,0x01,0x29,0x01,0x30,0x01,0x37,0x01,
+	0x3E,0x01,0x46,0x01,0x4D,0x01,0x54,0x01,
+	0x5B,0x01,0x62,0x01,0x6A,0x01,0x71,0x01,
+	0x78,0x01,0x7F,0x01,0x86,0x01,0x8E,0x01,
+	0x95,0x01,0x9C,0x01,0xA3,0x01,0xAA,0x01,
+	0xB2,0x01,0xB9,0x01,0xC0,0x01,0xC7,0x01,
+	0xCE,0x01,0xD6,0x01,0xDD,0x01,0xE4,0x01,
+	0xEB,0x01,0xF2,0x01,0xFA,0x01
+};
+
+const unsigned short INIT_GCP16[15] =
+{
+	0x1A,0x31,0x48,0x54,0x5F,0x67,0x70,0x76,0x7C,0x80,0x83,0x84,0x85,0x87,0x96
+};
+
+const unsigned short INIT_MD_PSET[4] = { 0, 0, 219, 0 };
+const unsigned short INIT_MD_CSET[4] = { 2, 0, 177, 0 };
+
+const unsigned short INIT_SD_PSET[4] = { 0x00, 0x01, 0x00, 0x01 };
+const unsigned short INIT_SD_CSET[4] = { 0x00, 0x02, 0x00, 0x02 };
+
+const unsigned short INIT_ASCSET[7] = { 0x00, 0x00, 0xDB, 0x00, 0xDC, 0x00, 0x01 };
+const unsigned short INIT_SCSTART[2] = { 0x00, 0x00 };
+
+/* ----- end of epson_md_tft.h ----- */
+
+
+#include "../drivers/ssi/omap-uwire.h"
+
+#define LCD_UWIRE_CS 0
+
+static int p2_panel_init(struct lcd_panel *panel, struct omapfb_device *fbdev)
+{
+	return 0;
+}
+
+static void p2_panel_cleanup(struct lcd_panel *panel)
+{
+}
+
+static int p2_panel_enable(struct lcd_panel *panel)
+{
+	int i;
+	unsigned long value;
+
+		/* thwack the reset line */
+	omap_set_gpio_direction(19, 0);
+	omap_set_gpio_dataout(19, 0);
+	mdelay(2);
+	omap_set_gpio_dataout(19, 1);
+
+		/* bits 31:28 -> 0  LCD_PXL_15 .. 12 */
+	value = omap_readl(OMAP730_IO_CONF_3) & 0x0FFFFFFF;
+	omap_writel(value, OMAP730_IO_CONF_3);
+
+		/* bits 19:0 -> 0  LCD_VSYNC, AC, PXL_0, PCLK, HSYNC,
+		**                 PXL_9..1, PXL_10, PXL_11
+		*/
+	value = omap_readl(OMAP730_IO_CONF_4) & 0xFFF00000;
+	omap_writel(value, OMAP730_IO_CONF_4);
+
+	omap_uwire_configure_mode(0,16);
+
+	omap_uwire_data_transfer(LCD_UWIRE_CS, LCD_DISOFF, 9, 0,NULL,1);
+	omap_uwire_data_transfer(LCD_UWIRE_CS, LCD_SLPIN, 9, 0,NULL,1);
+	omap_uwire_data_transfer(LCD_UWIRE_CS, LCD_DISNOR, 9, 0,NULL,1);
+	omap_uwire_data_transfer(LCD_UWIRE_CS, LCD_GSSET, 9, 0,NULL,1);
+	omap_uwire_data_transfer(LCD_UWIRE_CS, (INIT_GSSET | 0x100), 9, 0,NULL,1);
+
+	/* DISCTL */
+	omap_uwire_data_transfer(LCD_UWIRE_CS, LCD_DISCTL, 9, 0,NULL,1);
+	for (i = 0; i < (sizeof(INIT_DISCTL)/sizeof(unsigned short)); i++)
+		omap_uwire_data_transfer(LCD_UWIRE_CS, (INIT_DISCTL[i] | 0x100), 9, 0,NULL,1);
+
+	/* GCP64 */
+	omap_uwire_data_transfer(LCD_UWIRE_CS, LCD_GCP64, 9, 0,NULL,1);
+	for (i = 0; i < (sizeof(INIT_GCP64)/sizeof(unsigned short)); i++)
+		omap_uwire_data_transfer(LCD_UWIRE_CS, (INIT_GCP64[i] | 0x100), 9, 0,NULL,1);
+
+	/* GCP16 */
+	omap_uwire_data_transfer(LCD_UWIRE_CS, LCD_GCP16, 9, 0,NULL,1);
+	for (i = 0; i < (sizeof(INIT_GCP16)/sizeof(unsigned short)); i++)
+		omap_uwire_data_transfer(LCD_UWIRE_CS, (INIT_GCP16[i] | 0x100), 9, 0,NULL,1);
+
+	/* MD_CSET */
+	omap_uwire_data_transfer(LCD_UWIRE_CS, LCD_MD_CSET, 9, 0,NULL,1);
+	for (i = 0; i < (sizeof(INIT_MD_CSET)/sizeof(unsigned short)); i++)
+		omap_uwire_data_transfer(LCD_UWIRE_CS, (INIT_MD_CSET[i] | 0x100), 9, 0,NULL,1);
+
+	/* MD_PSET */
+	omap_uwire_data_transfer(LCD_UWIRE_CS, LCD_MD_PSET, 9, 0,NULL,1);
+	for (i = 0; i < (sizeof(INIT_MD_PSET)/sizeof(unsigned short)); i++)
+		omap_uwire_data_transfer(LCD_UWIRE_CS, (INIT_MD_PSET[i] | 0x100), 9, 0,NULL,1);
+
+	/* SD_CSET */
+	omap_uwire_data_transfer(LCD_UWIRE_CS, LCD_SD_CSET, 9, 0,NULL,1);
+	for (i = 0; i < (sizeof(INIT_SD_CSET)/sizeof(unsigned short)); i++)
+		omap_uwire_data_transfer(LCD_UWIRE_CS, (INIT_SD_CSET[i] | 0x100), 9, 0,NULL,1);
+
+	/* SD_PSET */
+	omap_uwire_data_transfer(LCD_UWIRE_CS, LCD_SD_PSET, 9, 0,NULL,1);
+	for (i = 0; i < (sizeof(INIT_SD_PSET)/sizeof(unsigned short)); i++)
+		omap_uwire_data_transfer(LCD_UWIRE_CS, (INIT_SD_PSET[i] | 0x100), 9, 0,NULL,1);
+
+	/* DATCTL */
+	omap_uwire_data_transfer(LCD_UWIRE_CS, LCD_DATCTL, 9, 0,NULL,1);
+	omap_uwire_data_transfer(LCD_UWIRE_CS, (INIT_DATCTL | 0x100), 9, 0,NULL,1);
+
+	/* OSSISEL = d'5 */
+	omap_uwire_data_transfer(LCD_UWIRE_CS, LCD_OSCISEL, 9, 0,NULL,1);
+	omap_uwire_data_transfer(LCD_UWIRE_CS, (INIT_OSCISEL | 0x100), 9, 0,NULL,1);
+
+	/* 14MSET = d'74 */
+	omap_uwire_data_transfer(LCD_UWIRE_CS, LCD_14MSET, 9, 0,NULL,1);
+	omap_uwire_data_transfer(LCD_UWIRE_CS, (INIT_14MSET | 0x100), 9, 0,NULL,1);
+
+	/* 14MEND */
+	omap_uwire_data_transfer(LCD_UWIRE_CS, LCD_14MEND, 9, 0,NULL,1);
+
+	/* 3500KSET = d'69 */
+	omap_uwire_data_transfer(LCD_UWIRE_CS, LCD_3500KSET, 9, 0,NULL,1);
+	omap_uwire_data_transfer(LCD_UWIRE_CS, (INIT_3500KSET | 0x100), 9, 0,NULL,1);
+
+	/* 3500KEND */
+	omap_uwire_data_transfer(LCD_UWIRE_CS, LCD_3500KEND, 9, 0,NULL,1);
+
+	omap_uwire_data_transfer(LCD_UWIRE_CS, LCD_SLPOUT, 9, 0,NULL,1);
+
+	omap_uwire_data_transfer(LCD_UWIRE_CS, LCD_VOLCTL, 9, 0,NULL,1);
+	omap_uwire_data_transfer(LCD_UWIRE_CS, (INIT_VOLCTL_Ton | 0x100), 9, 0,NULL,1);
+
+	omap_uwire_data_transfer(LCD_UWIRE_CS, LCD_VOLCTL, 9, 0,NULL,1);
+
+	omap_uwire_data_transfer(LCD_UWIRE_CS, (INIT_VOLCTL | 0x100), 9, 0,NULL,1);
+
+	omap_uwire_data_transfer(LCD_UWIRE_CS, LCD_DISON, 9, 0,NULL,1);
+
+	/* enable backlight */
+	omap_set_gpio_direction(134, 0);
+	omap_set_gpio_dataout(134, 1);
+
+	return 0;
+}
+
+static void p2_panel_disable(struct lcd_panel *panel)
+{
+}
+
+static unsigned long p2_panel_get_caps(struct lcd_panel *panel)
+{
+	return 0;
+}
+
+struct lcd_panel p2_panel = {
+	.name		= "p2",
+	.config		= OMAP_LCDC_PANEL_TFT | OMAP_LCDC_INV_PIX_CLOCK,
+
+	.bpp		= 16,
+	.data_lines	= 16,
+	.x_res		= 176,
+	.y_res		= 220,
+	.pixel_clock	= 12500,
+	.hsw		= 5,
+	.hfp		= 1,
+	.hbp		= 1,
+	.vsw		= 2,
+	.vfp		= 12,
+	.vbp		= 1,
+
+	.init		= p2_panel_init,
+	.cleanup	= p2_panel_cleanup,
+	.enable		= p2_panel_enable,
+	.disable	= p2_panel_disable,
+	.get_caps	= p2_panel_get_caps,
+};
+
+static int p2_panel_probe(struct platform_device *pdev)
+{
+	omapfb_register_panel(&p2_panel);
+	return 0;
+}
+
+static int p2_panel_remove(struct platform_device *pdev)
+{
+	return 0;
+}
+
+static int p2_panel_suspend(struct platform_device *pdev, pm_message_t mesg)
+{
+	return 0;
+}
+
+static int p2_panel_resume(struct platform_device *pdev)
+{
+	return 0;
+}
+
+struct platform_driver p2_panel_driver = {
+	.probe		= p2_panel_probe,
+	.remove		= p2_panel_remove,
+	.suspend	= p2_panel_suspend,
+	.resume		= p2_panel_resume,
+	.driver		= {
+		.name	= "lcd_p2",
+		.owner	= THIS_MODULE,
+	},
+};
+
+static int p2_panel_drv_init(void)
+{
+	return platform_driver_register(&p2_panel_driver);
+}
+
+static void p2_panel_drv_cleanup(void)
+{
+	platform_driver_unregister(&p2_panel_driver);
+}
+
+module_init(p2_panel_drv_init);
+module_exit(p2_panel_drv_cleanup);
+
-- 
1.6.0.1.141.g445ca

