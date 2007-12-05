From: David Brownell <david-b@pacbell.net>
Subject: Re: LCD Backlight control
Date: Wed, 5 Dec 2007 14:57:13 -0800
Message-ID: <200712051457.13767.david-b@pacbell.net>
References: <E1067FCAA4D74F4DB1DD9FBA2CE84A97B93FD5@dnce04.ent.ti.com>
	<200712051324.26035.david-b@pacbell.net>
	<fb249edb0712051334i21905eb5q428f8da7825fc9b3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <fb249edb0712051334i21905eb5q428f8da7825fc9b3@mail.gmail.com>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: andrzej zaborowski <balrogg@gmail.com>
Cc: "Agarwal, Vivek" <vagarwal@ti.com>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

On Wednesday 05 December 2007, andrzej zaborowski wrote:
> On 05/12/2007, David Brownell <david-b@pacbell.net> wrote:

> > (I don't know any reason that driver shouldn't go upstream, BTW;
> > most other OSK support is already there.)
> 
> Yes, it would be very nice if it could make its way there. It's a tiny
> piece but it so far is the driver that broke perhaps most often in
> this whole tree, due to backlight fwk changes upstream having to be
> accounted for on merges.

How's this look?  Against recent upstream GIT, verified on OSK+Mistral.
I'm assuming that the OMAP2 support was a mistake ... is that right?
If it looks right, feel free to sign off and submit this as-is.

- Dave

==========
This adds the OMAP1 PWL-based LCD backlight driver.  It's been in the
OMAP tree for some time.  Note that OMAP2 can do similar things with
the generic timers which have PWM outputs.  Such timers are more generic
than the PWL found on OMAP1 chips, but have a different EMI profile
because they aren't driven by a pseudorandom number generator.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
---
I changed this to be "omap1_bl" ... 2420 doesn't seem to have PWL,
so I'm assuming that's a generic OMAP2/OMAP3 thing.

 drivers/video/backlight/Kconfig    |    9 +
 drivers/video/backlight/Makefile   |    1 
 drivers/video/backlight/omap1_bl.c |  218 +++++++++++++++++++++++++++++++++++++
 3 files changed, 228 insertions(+)

--- a/drivers/video/backlight/Kconfig	2007-10-25 13:05:20.000000000 -0700
+++ b/drivers/video/backlight/Kconfig	2007-12-05 14:31:03.000000000 -0800
@@ -67,6 +67,15 @@ config BACKLIGHT_LOCOMO
 	  If you have a Sharp Zaurus SL-5500 (Collie) or SL-5600 (Poodle) say y to
 	  enable the LCD/backlight driver.
 
+config BACKLIGHT_OMAP1
+	tristate "OMAP1 PWL-based LCD Backlight"
+	depends on BACKLIGHT_CLASS_DEVICE && ARCH_OMAP1
+	default y
+	help
+	  This driver controls the LCD backlight level and power for
+	  the PWL module of OMAP1 processors.  Say Y if your board
+	  uses this hardware.
+
 config BACKLIGHT_HP680
 	tristate "HP Jornada 680 Backlight Driver"
 	depends on BACKLIGHT_CLASS_DEVICE && SH_HP6XX
--- a/drivers/video/backlight/Makefile	2007-10-25 13:05:20.000000000 -0700
+++ b/drivers/video/backlight/Makefile	2007-12-05 14:27:20.000000000 -0800
@@ -7,5 +7,6 @@ obj-$(CONFIG_BACKLIGHT_CLASS_DEVICE) += 
 obj-$(CONFIG_BACKLIGHT_CORGI)	+= corgi_bl.o
 obj-$(CONFIG_BACKLIGHT_HP680)	+= hp680_bl.o
 obj-$(CONFIG_BACKLIGHT_LOCOMO)	+= locomolcd.o
+obj-$(CONFIG_BACKLIGHT_OMAP1)	+= omap1_bl.o
 obj-$(CONFIG_BACKLIGHT_PROGEAR) += progear_bl.o
 obj-$(CONFIG_BACKLIGHT_CARILLO_RANCH) += cr_bllcd.o
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ b/drivers/video/backlight/omap1_bl.c	2007-12-05 14:25:57.000000000 -0800
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
+#include <asm/arch/hardware.h>
+#include <asm/arch/board.h>
+#include <asm/arch/mux.h>
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
