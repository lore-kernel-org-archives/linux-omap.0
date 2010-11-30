From: Bryan Wu <bryan.wu@canonical.com>
Subject: [PATCH 1/3] Backlight: driver for Sharp LS037V7DW01 panel on OMAP machine
Date: Tue, 30 Nov 2010 20:07:38 +0800
Message-ID: <1291118860-10325-2-git-send-email-bryan.wu@canonical.com>
References: <1291118860-10325-1-git-send-email-bryan.wu@canonical.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from adelie.canonical.com ([91.189.90.139]:50735 "EHLO
	adelie.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751662Ab0K3MHt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 30 Nov 2010 07:07:49 -0500
In-Reply-To: <1291118860-10325-1-git-send-email-bryan.wu@canonical.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@nokia.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, gadiyar@ti.com, rpurdie@rpsys.net

This driver is split from drivers/video/backlight/sharp_ls037v7dw01.c

Signed-off-by: Bryan Wu <bryan.wu@canonical.com>
---
 drivers/video/backlight/Kconfig             |   10 ++
 drivers/video/backlight/Makefile            |    1 +
 drivers/video/backlight/sharp_ls037v7dw01.c |  144 +++++++++++++++++++++++++++
 3 files changed, 155 insertions(+), 0 deletions(-)
 create mode 100644 drivers/video/backlight/sharp_ls037v7dw01.c

diff --git a/drivers/video/backlight/Kconfig b/drivers/video/backlight/Kconfig
index e54a337..46b2415 100644
--- a/drivers/video/backlight/Kconfig
+++ b/drivers/video/backlight/Kconfig
@@ -307,6 +307,16 @@ config BACKLIGHT_PCF50633
 	  If you have a backlight driven by a NXP PCF50633 MFD, say Y here to
 	  enable its driver.
 
+config BACKLIGHT_SHARP_LS037V7DW01
+	tristate "Backlight driver for SHARP LS037V7DW01 Panel"
+	depends on PANEL_GENERIC_DPI
+	help
+	  If you are using Sharp LS037V7DW01 LCD panel, say Y here to enable this driver.
+
+	  To compile this driver as a module, choose M here: the module will
+	  be called sharp_ls037v7dw01.
+
+
 endif # BACKLIGHT_CLASS_DEVICE
 
 endif # BACKLIGHT_LCD_SUPPORT
diff --git a/drivers/video/backlight/Makefile b/drivers/video/backlight/Makefile
index 44c0f81..c756f49 100644
--- a/drivers/video/backlight/Makefile
+++ b/drivers/video/backlight/Makefile
@@ -35,4 +35,5 @@ obj-$(CONFIG_BACKLIGHT_ADP5520)	+= adp5520_bl.o
 obj-$(CONFIG_BACKLIGHT_ADP8860)	+= adp8860_bl.o
 obj-$(CONFIG_BACKLIGHT_88PM860X) += 88pm860x_bl.o
 obj-$(CONFIG_BACKLIGHT_PCF50633)	+= pcf50633-backlight.o
+obj-$(CONFIG_BACKLIGHT_SHARP_LS037V7DW01)	+= sharp_ls037v7dw01.o
 
diff --git a/drivers/video/backlight/sharp_ls037v7dw01.c b/drivers/video/backlight/sharp_ls037v7dw01.c
new file mode 100644
index 0000000..e90595e
--- /dev/null
+++ b/drivers/video/backlight/sharp_ls037v7dw01.c
@@ -0,0 +1,144 @@
+/*
+ * Backlight driver for Sharp LS037V7DW01
+ *
+ * Copyright (C) 2010 Canonical Ltd.
+ * Author: Bryan Wu <bryan.wu@canonical.com>
+ *
+ * Copyright (C) 2008 Nokia Corporation
+ * Author: Tomi Valkeinen <tomi.valkeinen@nokia.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published by
+ * the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include <linux/module.h>
+#include <linux/device.h>
+#include <linux/backlight.h>
+#include <linux/fb.h>
+#include <linux/err.h>
+
+/* This OMAP platform header file is required by this driver */
+#include <plat/display.h>
+
+static int sharp_ls_bl_update_status(struct backlight_device *bl)
+{
+	struct omap_dss_device *dssdev = bl_get_data(bl);
+	int level;
+
+	if (!dssdev->set_backlight)
+		return -EINVAL;
+
+	if (bl->props.fb_blank == FB_BLANK_UNBLANK &&
+			bl->props.power == FB_BLANK_UNBLANK)
+		level = bl->props.brightness;
+	else
+		level = 0;
+
+	return dssdev->set_backlight(dssdev, level);
+}
+
+static int sharp_ls_bl_get_brightness(struct backlight_device *bl)
+{
+	if (bl->props.fb_blank == FB_BLANK_UNBLANK &&
+			bl->props.power == FB_BLANK_UNBLANK)
+		return bl->props.brightness;
+
+	return 0;
+}
+
+static const struct backlight_ops sharp_ls_bl_ops = {
+	.get_brightness = sharp_ls_bl_get_brightness,
+	.update_status  = sharp_ls_bl_update_status,
+};
+
+static int __devinit sharp_ls_bl_probe(struct platform_device *pdev)
+{
+	struct backlight_properties props;
+	struct backlight_device *bl;
+	struct omap_dss_device *dssdev = pdev->dev.platform_data;
+
+	if (!dssdev)
+		return -EINVAL;
+
+	memset(&props, 0, sizeof(struct backlight_properties));
+	props.max_brightness = dssdev->max_backlight_level;
+
+	bl = backlight_device_register("sharp-ls-bl", &dssdev->dev, dssdev,
+			&sharp_ls_bl_ops, &props);
+	if (IS_ERR(bl))
+		return PTR_ERR(bl);
+
+	bl->props.fb_blank = FB_BLANK_UNBLANK;
+	bl->props.power = FB_BLANK_UNBLANK;
+	bl->props.brightness = dssdev->max_backlight_level;
+	backlight_update_status(bl);
+
+	platform_set_drvdata(pdev, bl);
+	return 0;
+}
+
+static int __devexit sharp_ls_bl_remove(struct platform_device *pdev)
+{
+	struct backlight_device *bl = platform_get_drvdata(pdev);
+
+	bl->props.power = FB_BLANK_POWERDOWN;
+	backlight_update_status(bl);
+	backlight_device_unregister(bl);
+
+	return 0;
+}
+
+#ifdef CONFIG_PM
+static int sharp_ls_bl_suspend(struct platform_device *dev, pm_message_t state)
+{
+	return 0;
+}
+
+static int sharp_ls_bl_resume(struct platform_device *dev)
+{
+	struct backlight_device *bl = platform_get_drvdata(dev);
+
+	backlight_update_status(bl);
+	return 0;
+}
+#else
+#define sharp_ls_bl_suspend	NULL
+#define sharp_ls_bl_resume	NULL
+#endif
+
+static struct platform_driver sharp_ls_bl_driver = {
+	.driver		= {
+		.name	= "sharp-ls-bl",
+		.owner	= THIS_MODULE,
+	},
+	.probe		= sharp_ls_bl_probe,
+	.remove		= __devexit_p(sharp_ls_bl_remove),
+	.suspend	= sharp_ls_bl_suspend,
+	.resume		= sharp_ls_bl_resume,
+};
+
+static int __init sharp_ls_bl_init(void)
+{
+	return platform_driver_register(&sharp_ls_bl_driver);
+}
+module_init(sharp_ls_bl_init);
+
+static void __exit sharp_ls_bl_exit(void)
+{
+	platform_driver_unregister(&sharp_ls_bl_driver);
+}
+module_exit(sharp_ls_bl_exit);
+
+MODULE_DESCRIPTION("Sharp LS037V7DW01 Backlight Driver");
+MODULE_AUTHOR("Bryan Wu <bryan.wu@canonical.com>");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:sharp-ls-bl");
-- 
1.7.1

