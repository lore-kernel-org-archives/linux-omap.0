From: "Premi, Sanjeev" <premi@ti.com>
Subject: Query on backlight driver
Date: Wed, 7 Jan 2009 01:46:58 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301BB75B335@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:39154 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755284AbZAFURQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 6 Jan 2009 15:17:16 -0500
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "rpurdie@rpsys.net" <rpurdie@rpsys.net>

I have implemented a basic backlight driver for OMAP3EVM (patch below).
 
However, have been having few problems. Any suggestions would be useful.
 
1) Though build was successful; the print from the backlight driver did
   not appear during the kernel boot.
 
2) Figured out that despite defining BACKLIGHT_OMAP3EVM and manually
   setting CONFIG_FB_BACKLIGHT=y it gets "reset" during build despite
   making these changes:
 
    --- Backlight & LCD device support
    <*>   Lowlevel LCD controls
    < >     Samsung LTV350QV LCD Panel
    < >     Toppoly TDO24M LCD Panels support
    < >     VGG2432A4 LCM device support
    < >     Platform LCD controls
    -*-   Lowlevel Backlight controls
    < >     Generic (aka Sharp Corgi) Backlight Driver (DEPRECATED)
    <*>     OMAP3EVM LCD Backlight

3) Was able to overcome this problem with this change:
   diff --git a/drivers/video/omap/Kconfig b/drivers/video/omap/Kconfig
   @@ -4,6 +4,7 @@ config FB_OMAP
     select FB_CFB_FILLRECT
     select FB_CFB_COPYAREA
     select FB_CFB_IMAGEBLIT
   + select FB_BACKLIGHT
     help
           Frame buffer driver for OMAP based boards.
 
4) But still, the driver isn't getting loaded.
 
   Is there any further implicit dependency to be satisfied?
 
Best regards,
Sanjeev
 
PS: The tabs in the may be replaced with space in the patch below.
    Final patch submission will done from Linux machine; will not
    have this problem.

diff --git a/drivers/video/backlight/Kconfig b/drivers/video/backlight/Kconfig
index 4a4dd9a..6e4d98a 100644
--- a/drivers/video/backlight/Kconfig
+++ b/drivers/video/backlight/Kconfig
@@ -152,6 +152,14 @@ config BACKLIGHT_OMAP1
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
index 0000000..8104834
--- /dev/null
+++ b/drivers/video/backlight/omap3evm_bl.c
@@ -0,0 +1,233 @@
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
+#include <mach/omapfb.h>
+
+/**
+ * Name of the driver
+ */
+#define OMAPBL_DRVNAME	"omap-backlight"
+
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
+#define OMAPBL_SUSPENDED     0x01
+
+/**
+ * Flag indicating low battery
+ */
+#define OMAPBL_BATTLOW       0x02
+
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
+
+static int omapbl_set_intensity(struct backlight_device *bd)
+{
+	int intensity = bd->props.brightness;
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
+	omapbl_info->set_bl_intensity(intensity);
+
+	panel_intensity = intensity;
+
+	if (omapbl_info->kick_battery)
+		omapbl_info->kick_battery();
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
+	struct generic_bl_info *machinfo = pdev->dev.platform_data;
+	const char *name = OMAPBL_DRVNAME;
+
+	omapbl_info = machinfo;
+	if (!machinfo->limit_mask)
+		machinfo->limit_mask = -1;
+
+	if (machinfo->name)
+		name = machinfo->name;
+
+	omapbl_device = backlight_device_register (name,
+				&pdev->dev, NULL, &omapbl_ops);
+
+	if (IS_ERR (omapbl_device))
+		return PTR_ERR (omapbl_device);
+
+	platform_set_drvdata(pdev, omapbl_device);
+
+	omapbl_device->props.max_brightness = machinfo->max_intensity;
+	omapbl_device->props.power = FB_BLANK_UNBLANK;
+	omapbl_device->props.brightness = machinfo->default_intensity;
+
+	backlight_update_status(omapbl_device);
+
+	printk(KERN_INFO "OMAP LCD backlight initialized.\n");
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
+	printk(KERN_INFO "OMAP LCD backlight unloaded.\n");
+
+	return 0;
+}
+
+#ifdef CONFIG_PM
+static int omapbl_suspend(struct platform_device *pdev, pm_message_t state)
+{
+	struct backlight_device *bd = platform_get_drvdata(pdev);
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
+static struct platform_driver omapbl_driver = {
+	.probe		= omapbl_probe,
+	.remove		= omapbl_remove,
+	.suspend	= omapbl_suspend,
+	.resume		= omapbl_resume,
+	.driver		= {
+				.name	= "omap-backlight",
+			},
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
 