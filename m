From: Jonathan McDowell <noodles@earth.li>
Subject: [PATCH 1/3] Add backlight support for Amstrad Delta
Date: Sun, 2 Apr 2006 17:36:14 +0100
Message-ID: <20060402163614.GC26949@earth.li>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
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
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

This patch adds support for the Amstrad Delta LCD backlight. It's the
first patch in a series of 3 enabling full LCD support for the Delta and
is the least intrusive, allowing control of the backlight through the
existing backlight class infrastructure.

Signed-Off-By: Jonathan McDowell <noodles@earth.li>

diff --git a/arch/arm/configs/ams_delta_defconfig b/arch/arm/configs/ams_delta_defconfig
index 03f02dd..7cc0727 100644
--- a/arch/arm/configs/ams_delta_defconfig
+++ b/arch/arm/configs/ams_delta_defconfig
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
 # Linux kernel version: 2.6.16-omap1
-# Wed Mar 22 10:53:48 2006
+# Sun Apr  2 16:00:11 2006
 #
 CONFIG_ARM=y
 CONFIG_MMU=y
@@ -623,13 +623,44 @@ CONFIG_I2C_OMAP=y
 #
 # Graphics support
 #
-# CONFIG_FB is not set
+CONFIG_FB=y
+# CONFIG_FB_CFB_FILLRECT is not set
+# CONFIG_FB_CFB_COPYAREA is not set
+# CONFIG_FB_CFB_IMAGEBLIT is not set
+# CONFIG_FB_MACMODES is not set
+# CONFIG_FB_MODE_HELPERS is not set
+# CONFIG_FB_TILEBLITTING is not set
+# CONFIG_FB_S1D13XXX is not set
+CONFIG_FB_OMAP=y
+# CONFIG_FB_OMAP_LCDC_EXTERNAL is not set
+# CONFIG_FB_OMAP_LCD_LPH8923 is not set
+# CONFIG_FB_OMAP_BOOTLOADER_INIT is not set
+# CONFIG_FB_OMAP_DMA_TUNE is not set
+# CONFIG_FB_VIRTUAL is not set
 
 #
 # Console display driver support
 #
 # CONFIG_VGA_CONSOLE is not set
 CONFIG_DUMMY_CONSOLE=y
+CONFIG_FRAMEBUFFER_CONSOLE=y
+# CONFIG_FRAMEBUFFER_CONSOLE_ROTATION is not set
+# CONFIG_FONTS is not set
+CONFIG_FONT_8x8=y
+CONFIG_FONT_8x16=y
+
+#
+# Logo configuration
+#
+CONFIG_LOGO=y
+# CONFIG_LOGO_LINUX_MONO is not set
+# CONFIG_LOGO_LINUX_VGA16 is not set
+CONFIG_LOGO_LINUX_CLUT224=y
+CONFIG_BACKLIGHT_LCD_SUPPORT=y
+CONFIG_BACKLIGHT_CLASS_DEVICE=y
+CONFIG_BACKLIGHT_DEVICE=y
+# CONFIG_LCD_CLASS_DEVICE is not set
+CONFIG_BACKLIGHT_AMS_DELTA=y
 
 #
 # Sound
diff --git a/arch/arm/mach-omap1/board-ams-delta.c b/arch/arm/mach-omap1/board-ams-delta.c
index 6178f04..7475587 100644
--- a/arch/arm/mach-omap1/board-ams-delta.c
+++ b/arch/arm/mach-omap1/board-ams-delta.c
@@ -84,6 +84,15 @@ static struct omap_board_config_kernel a
 	{ OMAP_TAG_UART,	&ams_delta_uart_config },
 };
 
+static struct platform_device ams_delta_bl_device = {
+	.name	= "ams-delta-bl",
+	.id	= -1,
+};
+
+static struct platform_device *ams_delta_devices[] __initdata = {
+	&ams_delta_bl_device,
+};
+
 static void __init ams_delta_init(void)
 {
 	iotable_init(ams_delta_io_desc, ARRAY_SIZE(ams_delta_io_desc));
@@ -94,6 +103,8 @@ static void __init ams_delta_init(void)
 
 	/* Clear latch2 (NAND, LCD, modem enable) */
 	ams_delta_latch2_write(~0, 0);
+
+	platform_add_devices(ams_delta_devices, ARRAY_SIZE(ams_delta_devices));
 }
 
 static void __init ams_delta_map_io(void)
diff --git a/drivers/video/backlight/Kconfig b/drivers/video/backlight/Kconfig
index 9d996f2..5f02b00 100644
--- a/drivers/video/backlight/Kconfig
+++ b/drivers/video/backlight/Kconfig
@@ -42,6 +42,14 @@ config LCD_DEVICE
 	depends on LCD_CLASS_DEVICE
 	default y
 
+config BACKLIGHT_AMS_DELTA
+	tristate "Amstrad Delta (E3) backlight driver"
+	depends on BACKLIGHT_DEVICE && MACH_AMS_DELTA
+	default y
+	help
+	  If you have an Amstrad Delta (E3) videophone, say y to enable
+	  the backlight driver.
+
 config BACKLIGHT_CORGI
 	tristate "Sharp Corgi Backlight Driver (SL-C7xx Series)"
 	depends on BACKLIGHT_DEVICE && PXA_SHARPSL
diff --git a/drivers/video/backlight/Makefile b/drivers/video/backlight/Makefile
index 744210c..2a793ea 100644
--- a/drivers/video/backlight/Makefile
+++ b/drivers/video/backlight/Makefile
@@ -1,6 +1,7 @@
 # Backlight & LCD drivers
 
 obj-$(CONFIG_LCD_CLASS_DEVICE)     += lcd.o
+obj-$(CONFIG_BACKLIGHT_AMS_DELTA) += ams_delta_bl.o
 obj-$(CONFIG_BACKLIGHT_CLASS_DEVICE) += backlight.o
 obj-$(CONFIG_BACKLIGHT_CORGI)	+= corgi_bl.o
 obj-$(CONFIG_BACKLIGHT_HP680)	+= hp680_bl.o
diff --git a/drivers/video/backlight/ams_delta_bl.c b/drivers/video/backlight/ams_delta_bl.c
new file mode 100644
index 0000000..6b84744
--- /dev/null
+++ b/drivers/video/backlight/ams_delta_bl.c
@@ -0,0 +1,172 @@
+/*
+ * Backlight driver for Amstrad E3 (Delta) videophone.
+ *
+ * Copyright (C) 2006 Jonathan McDowell <noodles@earth.li>
+ *
+ * Based on Richard Purdie's Corgi driver.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/fb.h>
+#include <linux/backlight.h>
+#include <linux/platform_device.h>
+
+#include <asm/arch/omap16xx.h>
+#include <asm/arch/board-ams-delta.h>
+
+#define AMS_DELTA_DEFAULT_INTENSITY	112
+#define AMS_DELTA_MAX_INTENSITY		255
+
+static int ams_delta_bl_powermode = FB_BLANK_UNBLANK;
+static int current_intensity = 0;
+
+static void ams_delta_bl_send_intensity(int intensity)
+{
+	if (ams_delta_bl_powermode != FB_BLANK_UNBLANK) {
+		intensity = 0;
+	}
+
+	omap_writeb(intensity, OMAP16XX_PWL_ENABLE);
+}
+
+static void ams_delta_bl_blank(int blank)
+{
+	switch(blank) {
+
+	case FB_BLANK_NORMAL:
+	case FB_BLANK_VSYNC_SUSPEND:
+	case FB_BLANK_HSYNC_SUSPEND:
+	case FB_BLANK_POWERDOWN:
+		if (ams_delta_bl_powermode == FB_BLANK_UNBLANK) {
+			ams_delta_latch2_write(AMS_DELTA_LATCH2_LCD_VBLEN, 0);
+			ams_delta_bl_send_intensity(0);
+			ams_delta_bl_powermode = blank;
+		}
+		break;
+	case FB_BLANK_UNBLANK:
+		if (ams_delta_bl_powermode != FB_BLANK_UNBLANK) {
+			ams_delta_latch2_write(AMS_DELTA_LATCH2_LCD_VBLEN,
+				AMS_DELTA_LATCH2_LCD_VBLEN);
+			ams_delta_bl_powermode = blank;
+			ams_delta_bl_send_intensity(current_intensity);
+		}
+		break;
+	}
+}
+
+#ifdef CONFIG_PM
+static int ams_delta_bl_suspend(struct platform_device *dev, pm_message_t state)
+{
+	ams_delta_bl_blank(FB_BLANK_POWERDOWN);
+	return 0;
+}
+
+static int ams_delta_bl_resume(struct platform_device *dev)
+{
+	ams_delta_bl_blank(FB_BLANK_UNBLANK);
+	return 0;
+}
+#else
+#define ams_delta_bl_suspend	NULL
+#define ams_delta_bl_resume	NULL
+#endif
+
+
+static int ams_delta_bl_set_power(struct backlight_device *bd, int state)
+{
+	ams_delta_bl_blank(state);
+	return 0;
+}
+
+static int ams_delta_bl_get_power(struct backlight_device *bd)
+{
+	return ams_delta_bl_powermode;
+}
+
+static int ams_delta_bl_set_intensity(struct backlight_device *bd,
+		int intensity)
+{
+	if (intensity > AMS_DELTA_MAX_INTENSITY)
+		intensity = AMS_DELTA_MAX_INTENSITY;
+	ams_delta_bl_send_intensity(intensity);
+	current_intensity = intensity;
+	return 0;
+}
+
+static int ams_delta_bl_get_intensity(struct backlight_device *bd)
+{
+	return current_intensity;
+}
+
+static struct backlight_properties ams_delta_bl_data = {
+	.owner		= THIS_MODULE,
+	.get_power      = ams_delta_bl_get_power,
+	.set_power      = ams_delta_bl_set_power,
+	.max_brightness = AMS_DELTA_MAX_INTENSITY,
+	.get_brightness = ams_delta_bl_get_intensity,
+	.set_brightness = ams_delta_bl_set_intensity,
+};
+
+static struct backlight_device *ams_delta_backlight_device;
+
+static int __init ams_delta_bl_probe(struct platform_device *pdev)
+{
+	ams_delta_backlight_device = backlight_device_register("ams-delta-bl",
+			NULL, &ams_delta_bl_data);
+	if (IS_ERR(ams_delta_backlight_device))
+		return PTR_ERR(ams_delta_backlight_device);
+
+	omap_writeb(1, OMAP16XX_PWL_CLK_ENABLE);
+	ams_delta_latch2_write(AMS_DELTA_LATCH2_LCD_VBLEN,
+			AMS_DELTA_LATCH2_LCD_VBLEN);
+	ams_delta_bl_set_intensity(NULL, AMS_DELTA_DEFAULT_INTENSITY);
+
+	printk("Amstrad Delta backlight driver initialized.\n");
+	return 0;
+}
+
+static int ams_delta_bl_remove(struct platform_device *dev)
+{
+	backlight_device_unregister(ams_delta_backlight_device);
+
+	ams_delta_bl_set_intensity(NULL, 0);
+	omap_writeb(0, OMAP16XX_PWL_CLK_ENABLE);
+	ams_delta_latch2_write(AMS_DELTA_LATCH2_LCD_VBLEN, 0);
+
+	printk("Amstrad Delta backlight driver unloaded\n");
+	return 0;
+}
+
+static struct platform_driver ams_delta_bl_driver = {
+	.probe		= ams_delta_bl_probe,
+	.remove		= ams_delta_bl_remove,
+	.suspend	= ams_delta_bl_suspend,
+	.resume		= ams_delta_bl_resume,
+	.driver		= {
+		.name	= "ams-delta-bl",
+	},
+};
+
+static int __init ams_delta_bl_init(void)
+{
+	return platform_driver_register(&ams_delta_bl_driver);
+}
+
+static void __exit ams_delta_bl_exit(void)
+{
+	platform_driver_unregister(&ams_delta_bl_driver);
+}
+
+module_init(ams_delta_bl_init);
+module_exit(ams_delta_bl_exit);
+
+MODULE_AUTHOR("Jonathan McDowell <noodles@earth.li>");
+MODULE_DESCRIPTION("Amstrad Delta backlight driver");
+MODULE_LICENSE("GPLv2");
