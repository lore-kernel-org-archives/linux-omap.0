From: Sanjeev Premi <premi@ti.com>
Subject: [PATCH] Backlight driver for omap3evm
Date: Wed,  7 Jan 2009 20:25:51 +0530
Message-ID: <1231340151-16790-1-git-send-email-premi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:45065 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754856AbZAGO4K (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 7 Jan 2009 09:56:10 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, rpurdie@rpsys.net
Cc: Sanjeev Premi <premi@ti.com>

This patch implements the backlight driver for OMAP3EVM.
The mechanism for backlight control is reused from the
existing controls in lcd_omap3evm.c.

Signed-off-by: Sanjeev Premi <premi@ti.com>
---
 drivers/video/backlight/Kconfig       |    7 +
 drivers/video/backlight/Makefile      |    1 +
 drivers/video/backlight/omap3evm_bl.c |  252 +++++++++++++++++++++++++++++++++
 drivers/video/omap/Kconfig            |    1 +
 drivers/video/omap/lcd_omap3evm.c     |   25 ----
 5 files changed, 261 insertions(+), 25 deletions(-)
 create mode 100644 drivers/video/backlight/omap3evm_bl.c

diff --git a/drivers/video/backlight/Kconfig b/drivers/video/backlight/Kconfig
index 4a4dd9a..2efa5d0 100644
--- a/drivers/video/backlight/Kconfig
+++ b/drivers/video/backlight/Kconfig
@@ -152,6 +152,13 @@ config BACKLIGHT_OMAP1
 	  the PWL module of OMAP1 processors.  Say Y if your board
 	  uses this hardware.
 
+config BACKLIGHT_OMAP3EVM
+	tristate "OMAP3EVM LCD Backlight"
+	depends on BACKLIGHT_CLASS_DEVICE && MACH_OMAP3EVM
+	default y
+	help
+	  This driver controls the LCD backlight for OMAP3EVM.
+
 config BACKLIGHT_HP680
 	tristate "HP Jornada 680 Backlight Driver"
 	depends on BACKLIGHT_CLASS_DEVICE && SH_HP6XX
diff --git a/drivers/video/backlight/Makefile b/drivers/video/backlight/Makefile
index 103427d..0150953 100644
--- a/drivers/video/backlight/Makefile
+++ b/drivers/video/backlight/Makefile
@@ -15,6 +15,7 @@ obj-$(CONFIG_BACKLIGHT_CORGI)	+= corgi_bl.o
 obj-$(CONFIG_BACKLIGHT_HP680)	+= hp680_bl.o
 obj-$(CONFIG_BACKLIGHT_LOCOMO)	+= locomolcd.o
 obj-$(CONFIG_BACKLIGHT_OMAP1)	+= omap1_bl.o
+obj-$(CONFIG_BACKLIGHT_OMAP3EVM) += omap3evm_bl.o
 obj-$(CONFIG_BACKLIGHT_PROGEAR) += progear_bl.o
 obj-$(CONFIG_BACKLIGHT_CARILLO_RANCH) += cr_bllcd.o
 obj-$(CONFIG_BACKLIGHT_PWM)	+= pwm_bl.o
diff --git a/drivers/video/backlight/omap3evm_bl.c b/drivers/video/backlight/omap3evm_bl.c
new file mode 100644
index 0000000..a6dd3a1
--- /dev/null
+++ b/drivers/video/backlight/omap3evm_bl.c
@@ -0,0 +1,252 @@
+/*
+ * drivers/video/backlight/omap3evm_bl.c
+ *
+ * Backlight driver for OMAP3EVM
+ *
+ * Copyright (c) 2009, Texas Instruments Incorporated.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published
+ * by the Free Software Foundation.
+ *
+ * This program is distributed "as is" WITHOUT ANY WARRANTY of any kind,
+ * whether express or implied; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
+ * General Public License for more details.
+ */
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/platform_device.h>
+#include <linux/fb.h>
+#include <linux/backlight.h>
+#include <linux/i2c/twl4030.h>
+
+#include <mach/omapfb.h>
+
+/**
+ * Name of the driver
+ */
+#define OMAPBL_DRVNAME	"omap-backlight"
+
+/**
+ * Name of the device
+ */
+#define OMAPBL_DEVNAME	"omap-backlight"
+
+/**
+ * Minimum intensity supported by the panel
+ */
+#define OMAPBL_MIN_INTENSITY	0
+/**
+ * Maximum intensity supported by the panel
+ */
+#define OMAPBL_MAX_INTENSITY	100
+
+/**
+ * Default intensity after boot-up
+ */
+#define OMAPBL_DEF_INTENSITY	70
+
+/**
+ * Flag indicating the driver status - suspended / running
+ */
+#define OMAPBL_SUSPENDED	0x01
+
+/**
+ * Flag indicating low battery
+ */
+#define OMAPBL_BATTLOW		0x02
+
+#define TWL_PWMA_PWMAON		0x00
+#define TWL_PWMA_PWMAOFF	0x01
+
+/**
+ * Current backlight intensity
+ */
+static int panel_intensity;
+
+/**
+ * Backlight properties
+ */
+static struct backlight_properties omapbl_props;
+
+/**
+ * Generic backlight information
+ */
+static struct generic_bl_info *omapbl_info;
+
+/**
+ * Backlight device
+ */
+struct backlight_device *omapbl_device;
+
+/**
+ * Backlight flags
+ */
+static unsigned long omapbl_flags;
+
+static int omapbl_set_intensity(struct backlight_device *bd)
+{
+	int intensity = bd->props.brightness;
+	u8 c;
+
+	if (bd->props.power != FB_BLANK_UNBLANK)
+		intensity = 0;
+	if (bd->props.fb_blank != FB_BLANK_UNBLANK)
+		intensity = 0;
+	if (omapbl_flags & OMAPBL_SUSPENDED)
+		intensity = 0;
+	if (omapbl_flags & OMAPBL_BATTLOW)
+		intensity &= omapbl_info->limit_mask;
+
+	c = ((125 * (100 - intensity)) / 100) + 2;
+
+	twl4030_i2c_write_u8(TWL4030_MODULE_PWMA, c, TWL_PWMA_PWMAOFF);
+
+	panel_intensity = intensity;
+
+	return 0;
+}
+
+static int omapbl_get_intensity(struct backlight_device *bd)
+{
+	return panel_intensity;
+}
+
+/**
+ * omapbl_limit_intensity - Limit the backlight iuntensity
+ * @limit - Value 0 clears the limit. Else used as limit to be set.
+ *
+ * When the battery is low, this function is called to limit the backlight.
+ */
+void omapbl_limit_intensity(int limit)
+{
+	if (limit)
+		omapbl_flags |= OMAPBL_BATTLOW;
+	else
+		omapbl_flags &= ~OMAPBL_BATTLOW;
+
+	backlight_update_status(omapbl_device);
+}
+EXPORT_SYMBOL(omapbl_limit_intensity);
+
+static struct backlight_ops omapbl_ops = {
+	.get_brightness = omapbl_get_intensity,
+	.update_status  = omapbl_set_intensity,
+};
+
+static int omapbl_probe(struct platform_device *pdev)
+{
+	omapbl_device = backlight_device_register (OMAPBL_DRVNAME,
+							&pdev->dev,
+							NULL,
+							&omapbl_ops);
+
+	if (IS_ERR (omapbl_device))
+		return PTR_ERR (omapbl_device);
+
+	platform_set_drvdata(pdev, omapbl_device);
+
+	omapbl_device->props.power		= FB_BLANK_UNBLANK;
+	omapbl_device->props.max_brightness	= OMAPBL_MAX_INTENSITY;
+	omapbl_device->props.brightness		= OMAPBL_DEF_INTENSITY;
+
+	omapbl_set_intensity(omapbl_device);
+
+	printk(KERN_INFO "omap-backlight: driver initialized.\n");
+
+	return 0;
+}
+
+static int omapbl_remove(struct platform_device *pdev)
+{
+	struct backlight_device *bd = platform_get_drvdata(pdev);
+
+	omapbl_props.power = 0;
+	omapbl_props.brightness = 0;
+	backlight_update_status(bd);
+
+	backlight_device_unregister(bd);
+
+	printk(KERN_INFO "omap-backlight: driver unloaded.\n");
+
+	return 0;
+}
+
+#ifdef CONFIG_PM
+static int omapbl_suspend(struct platform_device *pdev, pm_message_t state)
+{
+	struct backlight_device *bd = platform_get_drvdata(pdev);
+
+	printk(KERN_INFO "omap-backlight: suspending...\n");
+
+	omapbl_flags |= OMAPBL_SUSPENDED;
+	backlight_update_status(bd);
+
+	return 0;
+}
+
+static int omapbl_resume(struct platform_device *pdev)
+{
+	struct backlight_device *bd = platform_get_drvdata(pdev);
+
+	printk(KERN_INFO "omap-backlight: resuming...\n");
+
+	omapbl_flags &= ~OMAPBL_SUSPENDED;
+	backlight_update_status(bd);
+
+	return 0;
+}
+#else
+#define omapbl_suspend	NULL
+#define omapbl_resume	NULL
+#endif
+
+static struct platform_driver omap_backlight_drv = {
+	.probe		= omapbl_probe,
+	.remove		= omapbl_remove,
+	.suspend	= omapbl_suspend,
+	.resume		= omapbl_resume,
+	.driver		= {
+				.name	= OMAPBL_DRVNAME,
+			},
+};
+
+static struct platform_device *omap_backlight_dev;
+
+static int __init omapbl_init(void)
+{
+	int ret = platform_driver_register(&omap_backlight_drv);
+
+	if (!ret) {
+		omap_backlight_dev = platform_device_alloc(OMAPBL_DEVNAME, -1);
+
+		if (!omap_backlight_dev)
+			return -ENOMEM;
+
+		ret = platform_device_add(omap_backlight_dev);
+
+		if (ret) {
+			platform_device_put(omap_backlight_dev);
+			platform_driver_unregister(&omap_backlight_drv);
+		}
+	}
+
+	return ret;
+}
+
+static void __exit omapbl_exit(void)
+{
+	platform_device_unregister(omap_backlight_dev);
+	platform_driver_unregister(&omap_backlight_drv);
+}
+
+module_init(omapbl_init);
+module_exit(omapbl_exit);
+
+MODULE_AUTHOR("Sanjeev Premi <premi@ti.com>");
+MODULE_DESCRIPTION("OMAP LCD Backlight driver");
+MODULE_LICENSE("GPLv2");
+
diff --git a/drivers/video/omap/Kconfig b/drivers/video/omap/Kconfig
index c355b59..41ae018 100644
--- a/drivers/video/omap/Kconfig
+++ b/drivers/video/omap/Kconfig
@@ -4,6 +4,7 @@ config FB_OMAP
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
+	select FB_BACKLIGHT
 	help
           Frame buffer driver for OMAP based boards.
 
diff --git a/drivers/video/omap/lcd_omap3evm.c b/drivers/video/omap/lcd_omap3evm.c
index 1c3d814..079989f 100644
--- a/drivers/video/omap/lcd_omap3evm.c
+++ b/drivers/video/omap/lcd_omap3evm.c
@@ -94,28 +94,6 @@ static unsigned long omap3evm_panel_get_caps(struct lcd_panel *panel)
 	return 0;
 }
 
-static int omap3evm_bklight_setlevel(struct lcd_panel *panel,
-						unsigned int level)
-{
-	u8 c;
-	if ((level >= 0) && (level <= 100)) {
-		c = (125 * (100 - level)) / 100 + 2;
-		twl4030_i2c_write_u8(TWL4030_MODULE_PWMA, c, TWL_PWMA_PWMAOFF);
-		bklight_level = level;
-	}
-	return 0;
-}
-
-static unsigned int omap3evm_bklight_getlevel(struct lcd_panel *panel)
-{
-	return bklight_level;
-}
-
-static unsigned int omap3evm_bklight_getmaxlevel(struct lcd_panel *panel)
-{
-	return 100;
-}
-
 struct lcd_panel omap3evm_panel = {
 	.name		= "omap3evm",
 	.config		= OMAP_LCDC_PANEL_TFT | OMAP_LCDC_INV_VSYNC |
@@ -139,9 +117,6 @@ struct lcd_panel omap3evm_panel = {
 	.enable		= omap3evm_panel_enable,
 	.disable	= omap3evm_panel_disable,
 	.get_caps	= omap3evm_panel_get_caps,
-	.set_bklight_level      = omap3evm_bklight_setlevel,
-	.get_bklight_level      = omap3evm_bklight_getlevel,
-	.get_bklight_max        = omap3evm_bklight_getmaxlevel,
 };
 
 static int omap3evm_panel_probe(struct platform_device *pdev)
-- 
1.5.6

