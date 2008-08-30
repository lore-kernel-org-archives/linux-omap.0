From: Felipe Balbi <me@felipebalbi.com>
Subject: [PATCH 30/33] add omap backlight support
Date: Sat, 30 Aug 2008 20:16:30 +0300
Message-ID: <1220116593-862-31-git-send-email-me@felipebalbi.com>
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
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:36928 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755236AbYH3RYK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 30 Aug 2008 13:24:10 -0400
In-Reply-To: <1220116593-862-30-git-send-email-me@felipebalbi.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Felipe Balbi <felipe.balbi@nokia.com>

From: Felipe Balbi <felipe.balbi@nokia.com>

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 drivers/video/backlight/Kconfig   |    9 ++
 drivers/video/backlight/Makefile  |    1 +
 drivers/video/backlight/omap_bl.c |  218 +++++++++++++++++++++++++++++++++++++
 3 files changed, 228 insertions(+), 0 deletions(-)
 create mode 100644 drivers/video/backlight/omap_bl.c

diff --git a/drivers/video/backlight/Kconfig b/drivers/video/backlight/Kconfig
index 452b770..6b8cb23 100644
--- a/drivers/video/backlight/Kconfig
+++ b/drivers/video/backlight/Kconfig
@@ -133,6 +133,15 @@ config BACKLIGHT_HP680
 	  If you have a HP Jornada 680, say y to enable the
 	  backlight driver.
 
+config BACKLIGHT_OMAP
+	tristate "OMAP LCD Backlight"
+	depends on BACKLIGHT_CLASS_DEVICE && (ARCH_OMAP1 || ARCH_OMAP2)
+	default y
+	help
+	  This driver controls the LCD backlight level and power
+	  for the PWL module of OMAP processors.  Say Y if you plan
+	  to use power saving.
+
 config BACKLIGHT_PROGEAR
 	tristate "Frontpath ProGear Backlight Driver"
 	depends on BACKLIGHT_CLASS_DEVICE && PCI && X86
diff --git a/drivers/video/backlight/Makefile b/drivers/video/backlight/Makefile
index b405aac..a317041 100644
--- a/drivers/video/backlight/Makefile
+++ b/drivers/video/backlight/Makefile
@@ -12,6 +12,7 @@ obj-$(CONFIG_BACKLIGHT_CORGI)	+= corgi_bl.o
 obj-$(CONFIG_BACKLIGHT_HP680)	+= hp680_bl.o
 obj-$(CONFIG_BACKLIGHT_LOCOMO)	+= locomolcd.o
 obj-$(CONFIG_BACKLIGHT_OMAP1)	+= omap1_bl.o
+obj-$(CONFIG_BACKLIGHT_OMAP)	+= omap_bl.o
 obj-$(CONFIG_BACKLIGHT_PROGEAR) += progear_bl.o
 obj-$(CONFIG_BACKLIGHT_CARILLO_RANCH) += cr_bllcd.o
 obj-$(CONFIG_BACKLIGHT_PWM)	+= pwm_bl.o
diff --git a/drivers/video/backlight/omap_bl.c b/drivers/video/backlight/omap_bl.c
new file mode 100644
index 0000000..eb9b5ba
--- /dev/null
+++ b/drivers/video/backlight/omap_bl.c
@@ -0,0 +1,218 @@
+/*
+ * drivers/video/backlight/omap_bl.c
+ *
+ * Backlight driver for OMAP based boards.
+ *
+ * Copyright (c) 2006 Andrzej Zaborowski  <balrog@zabor.org>
+ *
+ * This package is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This package is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this package; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ */
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/platform_device.h>
+#include <linux/fb.h>
+#include <linux/backlight.h>
+
+#include <mach/hardware.h>
+#include <mach/board.h>
+#include <mach/mux.h>
+
+#define OMAPBL_MAX_INTENSITY		0xff
+
+struct omap_backlight {
+	int powermode;
+	int current_intensity;
+
+	struct device *dev;
+	struct omap_backlight_config *pdata;
+};
+
+static void inline omapbl_send_intensity(int intensity)
+{
+	omap_writeb(intensity, OMAP_PWL_ENABLE);
+}
+
+static void inline omapbl_send_enable(int enable)
+{
+	omap_writeb(enable, OMAP_PWL_CLK_ENABLE);
+}
+
+static void omapbl_blank(struct omap_backlight *bl, int mode)
+{
+	if (bl->pdata->set_power)
+		bl->pdata->set_power(bl->dev, mode);
+
+	switch (mode) {
+	case FB_BLANK_NORMAL:
+	case FB_BLANK_VSYNC_SUSPEND:
+	case FB_BLANK_HSYNC_SUSPEND:
+	case FB_BLANK_POWERDOWN:
+		omapbl_send_intensity(0);
+		omapbl_send_enable(0);
+		break;
+
+	case FB_BLANK_UNBLANK:
+		omapbl_send_intensity(bl->current_intensity);
+		omapbl_send_enable(1);
+		break;
+	}
+}
+
+#ifdef CONFIG_PM
+static int omapbl_suspend(struct platform_device *pdev, pm_message_t state)
+{
+	struct backlight_device *dev = platform_get_drvdata(pdev);
+	struct omap_backlight *bl = dev_get_drvdata(&dev->dev);
+
+	omapbl_blank(bl, FB_BLANK_POWERDOWN);
+	return 0;
+}
+
+static int omapbl_resume(struct platform_device *pdev)
+{
+	struct backlight_device *dev = platform_get_drvdata(pdev);
+	struct omap_backlight *bl = dev_get_drvdata(&dev->dev);
+
+	omapbl_blank(bl, bl->powermode);
+	return 0;
+}
+#else
+#define omapbl_suspend	NULL
+#define omapbl_resume	NULL
+#endif
+
+static int omapbl_set_power(struct backlight_device *dev, int state)
+{
+	struct omap_backlight *bl = dev_get_drvdata(&dev->dev);
+
+	omapbl_blank(bl, state);
+	bl->powermode = state;
+
+	return 0;
+}
+
+static int omapbl_update_status(struct backlight_device *dev)
+{
+	struct omap_backlight *bl = dev_get_drvdata(&dev->dev);
+
+	if (bl->current_intensity != dev->props.brightness) {
+		if (dev->props.brightness < 0)
+			return -EPERM;	/* Leave current_intensity untouched */
+
+		if (bl->powermode == FB_BLANK_UNBLANK)
+			omapbl_send_intensity(dev->props.brightness);
+		bl->current_intensity = dev->props.brightness;
+	}
+
+	if (dev->props.fb_blank != bl->powermode)
+		omapbl_set_power(dev, dev->props.fb_blank);
+
+	return 0;
+}
+
+
+static int omapbl_get_intensity(struct backlight_device *dev)
+{
+	struct omap_backlight *bl = dev_get_drvdata(&dev->dev);
+	return bl->current_intensity;
+}
+
+static struct backlight_ops omapbl_ops = {
+	.get_brightness = omapbl_get_intensity,
+	.update_status  = omapbl_update_status,
+};
+
+
+static int omapbl_probe(struct platform_device *pdev)
+{
+	struct backlight_device *dev;
+	struct omap_backlight *bl;
+	struct omap_backlight_config *pdata = pdev->dev.platform_data;
+
+	if (!pdata)
+		return -ENXIO;
+
+	omapbl_ops.check_fb = pdata->check_fb;
+
+	bl = kzalloc(sizeof(struct omap_backlight), GFP_KERNEL);
+	if (unlikely(!bl))
+		return -ENOMEM;
+
+	dev = backlight_device_register("omap-bl", &pdev->dev,
+			bl, &omapbl_ops);
+	if (IS_ERR(dev)) {
+		kfree(bl);
+		return PTR_ERR(dev);
+	}
+
+	bl->powermode = FB_BLANK_POWERDOWN;
+	bl->current_intensity = 0;
+
+	bl->pdata = pdata;
+	bl->dev = &pdev->dev;
+
+	platform_set_drvdata(pdev, dev);
+
+	omap_cfg_reg(PWL);	/* Conflicts with UART3 */
+
+	dev->props.fb_blank = FB_BLANK_UNBLANK;
+	dev->props.max_brightness = OMAPBL_MAX_INTENSITY;
+	dev->props.brightness = pdata->default_intensity;
+	omapbl_update_status(dev);
+
+	printk(KERN_INFO "OMAP LCD backlight initialised\n");
+
+	return 0;
+}
+
+static int omapbl_remove(struct platform_device *pdev)
+{
+	struct backlight_device *dev = platform_get_drvdata(pdev);
+	struct omap_backlight *bl = dev_get_drvdata(&dev->dev);
+
+	backlight_device_unregister(dev);
+	kfree(bl);
+
+	return 0;
+}
+
+static struct platform_driver omapbl_driver = {
+	.probe		= omapbl_probe,
+	.remove		= omapbl_remove,
+	.suspend	= omapbl_suspend,
+	.resume		= omapbl_resume,
+	.driver		= {
+		.name	= "omap-bl",
+	},
+};
+
+static int __init omapbl_init(void)
+{
+	return platform_driver_register(&omapbl_driver);
+}
+
+static void __exit omapbl_exit(void)
+{
+	platform_driver_unregister(&omapbl_driver);
+}
+
+module_init(omapbl_init);
+module_exit(omapbl_exit);
+
+MODULE_AUTHOR("Andrzej Zaborowski <balrog@zabor.org>");
+MODULE_DESCRIPTION("OMAP LCD Backlight driver");
+MODULE_LICENSE("GPL");
-- 
1.6.0.1.141.g445ca

