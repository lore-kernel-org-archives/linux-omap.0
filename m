From: Belisko Marek <marek.belisko@gmail.com>
Subject: [PATCH] omap1: Add board support and LCD for HTC Oxygen
Date: Wed, 31 Mar 2010 11:57:09 +0200
Message-ID: <w2he7c6a05e1003310257y9f5bfa8en6c668e9019141d20@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f46.google.com ([74.125.82.46]:52095 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933051Ab0CaJ5M (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 31 Mar 2010 05:57:12 -0400
Received: by wwb17 with SMTP id 17so274013wwb.19
        for <linux-omap@vger.kernel.org>; Wed, 31 Mar 2010 02:57:10 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

    This patch introduces support for the HTC Herald (S310, etc.)
    series of smart phones -- board support
    and LCD panel settings.

Signed-off-by: Marek Belisko <marek.belisko@gmail.com>
---
 arch/arm/mach-omap1/Kconfig           |    6 +
 arch/arm/mach-omap1/Makefile          |    1 +
 arch/arm/mach-omap1/board-htcoxygen.c |  282 +++++++++++++++++++++++++++++++++
 drivers/video/omap/Makefile           |    1 +
 drivers/video/omap/lcd_htcoxygen.c    |  129 +++++++++++++++
 5 files changed, 419 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-omap1/board-htcoxygen.c
 create mode 100644 drivers/video/omap/lcd_htcoxygen.c

diff --git a/arch/arm/mach-omap1/Kconfig b/arch/arm/mach-omap1/Kconfig
index 27f4897..dc4e5df 100644
--- a/arch/arm/mach-omap1/Kconfig
+++ b/arch/arm/mach-omap1/Kconfig
@@ -161,6 +161,12 @@ config MACH_OMAP_GENERIC
           custom OMAP boards. Say Y here if you have a custom
           board.

+config MACH_HTCOXYGEN
+	bool "HTC Oxygen"
+	depends on ARCH_OMAP850
+	help
+	  HTC Oxygen smartphone support (AKA HTC S310, ...)
+	
 comment "OMAP CPU Speed"
 	depends on ARCH_OMAP1

diff --git a/arch/arm/mach-omap1/Makefile b/arch/arm/mach-omap1/Makefile
index b6a537c..10ce723 100644
--- a/arch/arm/mach-omap1/Makefile
+++ b/arch/arm/mach-omap1/Makefile
@@ -39,6 +39,7 @@ obj-$(CONFIG_MACH_NOKIA770)		+= board-nokia770.o
 obj-$(CONFIG_MACH_AMS_DELTA)		+= board-ams-delta.o
 obj-$(CONFIG_MACH_SX1)			+= board-sx1.o board-sx1-mmc.o
 obj-$(CONFIG_MACH_HERALD)		+= board-htcherald.o
+obj-$(CONFIG_MACH_HTCOXYGEN)		+= board-htcoxygen.o

 ifeq ($(CONFIG_ARCH_OMAP15XX),y)
 # Innovator-1510 FPGA
diff --git a/arch/arm/mach-omap1/board-htcoxygen.c
b/arch/arm/mach-omap1/board-htcoxygen.c
new file mode 100644
index 0000000..c0ffa59
--- /dev/null
+++ b/arch/arm/mach-omap1/board-htcoxygen.c
@@ -0,0 +1,282 @@
+/*
+ * HTC Oxygen board configuration
+ * Copyright (C) 2010 Marek Belisko <marek.belisko@gmail.com>
+ *
+ * Based on board-herald.c file from wing-linux project:
+ * Copyright (C) 2009 Cory Maccarrone <darkstar6262@gmail.com>
+ * Copyright (C) 2009 Wing Linux
+ *
+ * This  program is  free  software; you  can  redistribute it  and/or
+ * modify  it under the  terms of  the GNU  General Public  License as
+ * published by the Free Software  Foundation; either version 2 of the
+ * License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT  ANY  WARRANTY;  without   even  the  implied  warranty  of
+ * MERCHANTABILITY or  FITNESS FOR A PARTICULAR PURPOSE.   See the GNU
+ * General Public License for more details.
+ *
+ * You should have  received a copy of the  GNU General Public License
+ * along  with  this program;  if  not,  write  to the  Free  Software
+ * Foundation,  Inc.,  51 Franklin  Street,  Fifth  Floor, Boston,  MA
+ * 02110-1301, USA.
+ *
+ */
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/platform_device.h>
+#include <linux/input.h>
+#include <linux/bootmem.h>
+#include <linux/io.h>
+#include <linux/gpio.h>
+
+#include <asm/mach-types.h>
+#include <asm/mach/arch.h>
+
+#include <plat/omap7xx.h>
+#include <plat/common.h>
+#include <plat/board.h>
+#include <plat/keypad.h>
+#include <plat/usb.h>
+
+#include <mach/irqs.h>
+
+#include <linux/delay.h>
+
+/* LCD register definition */
+#define       OMAP_LCDC_CONTROL               (0xfffec000 + 0x00)
+#define       OMAP_LCDC_STATUS                (0xfffec000 + 0x10)
+#define       OMAP_DMA_LCD_CCR                (0xfffee300 + 0xc2)
+#define       OMAP_DMA_LCD_CTRL               (0xfffee300 + 0xc4)
+#define       OMAP_LCDC_CTRL_LCD_EN           (1 << 0)
+#define       OMAP_LCDC_STAT_DONE             (1 << 0)
+
+static struct omap_lcd_config htcoxygen_lcd_config __initdata = {
+	.ctrl_name	= "internal",
+};
+
+static struct omap_board_config_kernel htcoxygen_config[] __initdata = {
+	{ OMAP_TAG_LCD, &htcoxygen_lcd_config },
+};
+
+/* Keyboard definition */
+
+static int htc_oxygen_keymap[] = {
+	KEY(1,3,KEY_ENTER),
+	KEY(3,3,KEY_MENU),
+	KEY(2,3,KEY_BACKSPACE),
+	KEY(4,3,KEY_BACKSPACE),
+	KEY(3,5,KEY_LEFTALT),
+	KEY(4,5,KEY_RIGHTALT),
+	KEY(1,0,KEY_KP1),
+	KEY(2,0,KEY_KP2),
+	KEY(3,0,KEY_KP3),
+	KEY(4,0,KEY_KP4),
+	KEY(1,1,KEY_KP5),
+	KEY(2,1,KEY_KP6),
+	KEY(3,1,KEY_KP7),
+	KEY(4,1,KEY_KP8),
+	KEY(1,2,KEY_KP9),
+	KEY(3,2,KEY_KPASTERISK),
+	KEY(2,2,KEY_KP0),
+	KEY(4,2,KEY_KPSLASH),
+	KEY(0,1,KEY_VOLUMEUP),
+	KEY(0,3,KEY_VOLUMEDOWN),
+	KEY(0,2,KEY_CAMERA),
+	0
+};
+
+struct omap_kp_platform_data htcoxygen_kp_data = {
+	.rows	= 7,
+	.cols	= 7,
+	.delay = 20,
+	.rep = 1,
+	.keymap = htc_oxygen_keymap,
+};
+
+static struct resource kp_resources[] = {
+	[0] = {
+		.start	= INT_7XX_MPUIO_KEYPAD,
+		.end	= INT_7XX_MPUIO_KEYPAD,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device kp_device = {
+	.name		= "omap-keypad",
+	.id		= -1,
+	.dev		= {
+		.platform_data = &htcoxygen_kp_data,
+	},
+	.num_resources	= ARRAY_SIZE(kp_resources),
+	.resource	= kp_resources,
+};
+
+/* USB Device */
+static struct omap_usb_config htcoxygen_usb_config __initdata = {
+	.otg = 0,
+	.register_host = 0,
+	.register_dev  = 1,
+	.hmc_mode = 4,
+	.pins[0] = 2,
+};
+
+/* LCD Device resources */
+static struct platform_device lcd_device = {
+	.name           = "lcd_htcoxygen",
+	.id             = -1,
+};
+
+static struct platform_device *devices[] __initdata = {
+	&kp_device,
+	&lcd_device,
+};
+
+/*
+ * Init functions from here on
+ */
+
+static void __init htcoxygen_lcd_init(void)
+{
+	u32 reg;
+	unsigned int tries = 200;
+
+	/* disable controller if active */
+	reg = omap_readl(OMAP_LCDC_CONTROL);
+	if (reg & OMAP_LCDC_CTRL_LCD_EN) {
+		reg &= ~OMAP_LCDC_CTRL_LCD_EN;
+		omap_writel(reg, OMAP_LCDC_CONTROL);
+
+		/* wait for end of frame */
+		while (!(omap_readl(OMAP_LCDC_STATUS) & OMAP_LCDC_STAT_DONE)) {
+			tries--;
+			if (!tries)
+				break;
+		}
+		if (!tries)
+			printk(KERN_WARNING "Timeout waiting for end of frame "
+			       "-- LCD may not be available\n");
+
+		/* turn off DMA */
+		reg = omap_readw(OMAP_DMA_LCD_CCR);
+		reg &= ~(1 << 7);
+		omap_writew(reg, OMAP_DMA_LCD_CCR);
+
+		reg = omap_readw(OMAP_DMA_LCD_CTRL);
+		reg &= ~(1 << 8);
+		omap_writew(reg, OMAP_DMA_LCD_CTRL);
+	}
+}
+
+static void __init htcoxygen_map_io(void)
+{
+	omap1_map_common_io();
+
+	/*
+	 * The LCD panel must be disabled and DMA turned off here, as doing
+	 * it later causes the LCD never to reinitialize.
+	 */
+	htcoxygen_lcd_init();
+
+	printk(KERN_INFO "htcoxygen_map_io done.\n");
+}
+
+static void __init htcoxygen_disable_watchdog(void)
+{
+	/* Disable watchdog if running */
+	if (omap_readl(OMAP_WDT_TIMER_MODE) & 0x8000) {
+		/*
+		 * disable a potentially running watchdog timer before
+		 * it kills us.
+		 */
+		printk(KERN_WARNING "OMAP850 Watchdog seems to be activated,
disabling it for now.\n");
+		omap_writel(0xF5, OMAP_WDT_TIMER_MODE);
+		omap_writel(0xA0, OMAP_WDT_TIMER_MODE);
+	}
+}
+
+#define HTCOXYGEN_GPIO_USB_EN1 33
+#define HTCOXYGEN_GPIO_USB_EN2 73
+#define HTCOXYGEN_GPIO_USB_DM  35
+#define HTCOXYGEN_GPIO_USB_DP  36
+
+static void __init htcoxygen_usb_enable(void)
+{
+	unsigned int tries = 20;
+	unsigned int value = 0;
+
+	/* Request the GPIOs we need to control here */
+	if (gpio_request(HTCOXYGEN_GPIO_USB_EN1, "oxygen_usb") < 0)
+		goto err1;
+
+	if (gpio_request(HTCOXYGEN_GPIO_USB_EN2, "oxygen_usb") < 0)
+		goto err2;
+
+	if (gpio_request(HTCOXYGEN_GPIO_USB_DM, "oxygen_usb") < 0)
+		goto err3;
+
+	if (gpio_request(HTCOXYGEN_GPIO_USB_DP, "oxygen_usb") < 0)
+		goto err4;
+
+	/* force USB_EN GPIO to 0 */
+	do {
+		/* output low */
+		gpio_direction_output(HTCOXYGEN_GPIO_USB_EN1, 0);
+	} while ((value = gpio_get_value(HTCOXYGEN_GPIO_USB_EN1)) == 1 &&
+			--tries);
+
+	if (value == 1)
+		printk(KERN_WARNING "Unable to reset USB, trying to continue\n");
+
+	gpio_direction_output(HTCOXYGEN_GPIO_USB_EN2, 0); /* output low */
+	gpio_direction_input(HTCOXYGEN_GPIO_USB_DM); /* input */
+	gpio_direction_input(HTCOXYGEN_GPIO_USB_DP); /* input */
+
+	goto done;
+
+err4:
+	gpio_free(HTCOXYGEN_GPIO_USB_DM);
+err3:
+	gpio_free(HTCOXYGEN_GPIO_USB_EN2);
+err2:
+	gpio_free(HTCOXYGEN_GPIO_USB_EN1);
+err1:
+	printk(KERN_ERR "Unabled to request GPIO for USB\n");
+done:
+	printk(KERN_INFO "USB setup complete.\n");
+}
+
+static void __init htcoxygen_init(void)
+{
+	printk(KERN_INFO "HTC Oxygen init.\n");
+
+	omap_gpio_init();
+
+	omap_board_config = htcoxygen_config;
+	omap_board_config_size = ARRAY_SIZE(htcoxygen_config);
+	platform_add_devices(devices, ARRAY_SIZE(devices));
+
+	htcoxygen_disable_watchdog();
+
+	htcoxygen_usb_enable();
+	omap_usb_init(&htcoxygen_usb_config);
+}
+
+static void __init htcoxygen_init_irq(void)
+{
+	printk(KERN_INFO "htcoxygen_init_irq.\n");
+	omap1_init_common_hw();
+	omap_init_irq();
+}
+
+MACHINE_START(HTCOXYGEN, "HTC Oxygen")
+	/* Maintainer: Marek Belisko <marek.belisko@gmail.com> */
+	.phys_io        = 0xfff00000,
+	.io_pg_offst    = ((0xfef00000) >> 18) & 0xfffc,
+	.boot_params    = 0x10000100,
+	.map_io         = htcoxygen_map_io,
+	.init_irq       = htcoxygen_init_irq,
+	.init_machine   = htcoxygen_init,
+	.timer          = &omap_timer,
+MACHINE_END
diff --git a/drivers/video/omap/Makefile b/drivers/video/omap/Makefile
index 49226a1..1f72e3f 100644
--- a/drivers/video/omap/Makefile
+++ b/drivers/video/omap/Makefile
@@ -36,6 +36,7 @@ objs-y$(CONFIG_MACH_OMAP3_BEAGLE) += lcd_omap3beagle.o
 objs-y$(CONFIG_FB_OMAP_LCD_MIPID) += lcd_mipid.o
 objs-y$(CONFIG_MACH_OVERO) += lcd_overo.o
 objs-y$(CONFIG_MACH_HERALD) += lcd_htcherald.o
+objs-y$(CONFIG_MACH_HTCOXYGEN) += lcd_htcoxygen.o

 omapfb-objs := $(objs-yy)

diff --git a/drivers/video/omap/lcd_htcoxygen.c
b/drivers/video/omap/lcd_htcoxygen.c
new file mode 100644
index 0000000..3f472d3
--- /dev/null
+++ b/drivers/video/omap/lcd_htcoxygen.c
@@ -0,0 +1,129 @@
+/*
+ * File: drivers/video/omap/lcd-oxygen.c
+ *
+ * LCD panel support for the HTC Oxygen.
+ *
+ * Copyright (C) 2010 Marek Belisko <marek.belisko@gmail.com>
+ *
+ * Based on the lcd_htcwizard.c file from the linwizard project:
+ * Copyright (C) linwizard.sourceforge.net
+ * Author: Angelo Arrifano <miknix@gmail.com>
+ * Based on lcd_h4 by Imre Deak <imre.deak@nokia.com>
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
+#include "omapfb.h"
+
+static int htcoxygen_panel_init(struct lcd_panel *panel,
+					struct omapfb_device *fbdev)
+{
+	return 0;
+}
+
+static void htcoxygen_panel_cleanup(struct lcd_panel *panel)
+{
+}
+
+static int htcoxygen_panel_enable(struct lcd_panel *panel)
+{
+	return 0;
+}
+
+static void htcoxygen_panel_disable(struct lcd_panel *panel)
+{
+}
+
+static unsigned long htcoxygen_panel_get_caps(struct lcd_panel *panel)
+{
+	return 0;
+}
+
+struct lcd_panel htcoxygen_panel = {
+	.name           = "lcd_oxygen",
+	.config         = OMAP_LCDC_PANEL_TFT |
+	                  OMAP_LCDC_INV_VSYNC |
+			  OMAP_LCDC_INV_HSYNC |
+			  OMAP_LCDC_HSVS_OPPOSITE,
+	.bpp            = 16,
+	.data_lines     = 16,
+	.x_res          = 176,
+	.y_res          = 220,
+	.pixel_clock    = 3362,
+	.hsw            = 10,
+	.hfp            = 45,
+	.hbp            = 9,
+	.vsw            = 3,
+	.vfp            = 3,
+	.vbp            = 3,
+	.pcd            = 0,
+
+	.init           = htcoxygen_panel_init,
+	.cleanup        = htcoxygen_panel_cleanup,
+	.enable         = htcoxygen_panel_enable,
+	.disable        = htcoxygen_panel_disable,
+	.get_caps       = htcoxygen_panel_get_caps,
+};
+
+
+static int htcoxygen_panel_probe(struct platform_device *pdev)
+{
+	omapfb_register_panel(&htcoxygen_panel);
+	return 0;
+}
+
+static int htcoxygen_panel_remove(struct platform_device *pdev)
+{
+	return 0;
+}
+
+static int htcoxygen_panel_suspend(struct platform_device *pdev,
+						pm_message_t mesg)
+{
+	return 0;
+}
+
+static int htcoxygen_panel_resume(struct platform_device *pdev)
+{
+	return 0;
+}
+
+struct platform_driver htcoxygen_panel_driver = {
+	.probe		= htcoxygen_panel_probe,
+	.remove		= htcoxygen_panel_remove,
+	.suspend	= htcoxygen_panel_suspend,
+	.resume		= htcoxygen_panel_resume,
+	.driver		= {
+		.name	= "lcd_htcoxygen",
+		.owner	= THIS_MODULE,
+	},
+};
+
+static int __init htcoxygen_panel_drv_init(void)
+{
+	return platform_driver_register(&htcoxygen_panel_driver);
+}
+
+static void __exit htcoxygen_panel_drv_cleanup(void)
+{
+	platform_driver_unregister(&htcoxygen_panel_driver);
+}
+
+module_init(htcoxygen_panel_drv_init);
+module_exit(htcoxygen_panel_drv_cleanup);
+
-- 
1.6.4.2
