From: Cory Maccarrone <darkstar6262@gmail.com>
Subject: [PATCH 1/3] [OMAP] htcherald: Add board support and LCD for HTC
	Herald
Date: Sun, 4 Oct 2009 10:33:48 -0700
Message-ID: <6cb013310910041033m2c606d24g6db199326800ee14@mail.gmail.com>
References: <6cb013310910032157p19438de3h672fb68a100f7f90@mail.gmail.com>
	<6cb013310910040941k19f07c4fr831820aaeed93b6d@mail.gmail.com>
	<6cb013310910040942o241097am36915b561f2e9805@mail.gmail.com>
	<6cb013310910041032p2abbb4adycd2dfe6f79e4956f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yx0-f199.google.com ([209.85.210.199]:34875 "EHLO
	mail-yx0-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757440AbZJDReo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 4 Oct 2009 13:34:44 -0400
Received: by yxe37 with SMTP id 37so2439920yxe.33
        for <linux-omap@vger.kernel.org>; Sun, 04 Oct 2009 10:34:08 -0700 (PDT)
In-Reply-To: <6cb013310910041032p2abbb4adycd2dfe6f79e4956f@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

This patch introduces support for the HTC Herald (T-Mobile
Wing, etc.) series of smart phones -- board support and LCD
panel settings.

Signed-off-by: Cory Maccarrone <darkstar6262@gmail.com>
---
 arch/arm/mach-omap1/board-htcherald.c |  203 +++++++++++++++++++++++++++++++++
 drivers/video/omap/lcd_htcherald.c    |  164 ++++++++++++++++++++++++++
 2 files changed, 367 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-omap1/board-htcherald.c
 create mode 100644 drivers/video/omap/lcd_htcherald.c

diff --git a/arch/arm/mach-omap1/board-htcherald.c
b/arch/arm/mach-omap1/board-htcherald.c
new file mode 100644
index 0000000..93f8903
--- /dev/null
+++ b/arch/arm/mach-omap1/board-htcherald.c
@@ -0,0 +1,203 @@
+/*
+ * HTC Herald board configuration
+ * Copyright (C) 2009 Cory Maccarrone <darkstar6262@gmail.com>
+ * Copyright (C) 2009 Wing Linux
+ *
+ * Based on the board-htcwizard.c file from the linwizard project:
+ * Copyright (C) 2006 Unai Uribarri
+ * Copyright (C) 2008 linwizard.sourceforge.net
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
+
+#include <asm/mach-types.h>
+#include <asm/mach/arch.h>
+#include <asm/mach/map.h>
+#include <mach/omap7xx.h>
+#include <asm/page.h>
+#include <asm/memory.h>
+#include <mach/common.h>
+#include <mach/board.h>
+
+#include <mach/io.h>
+#include <mach/irqs.h>
+#include <mach/gpio.h>
+#include <mach/keypad.h>
+
+#include <linux/delay.h>
+
+static struct omap_lcd_config htcherald_lcd_config __initdata = {
+	.ctrl_name	= "internal",
+};
+
+static struct omap_board_config_kernel htcherald_config[] __initdata =
+{
+	{ OMAP_TAG_LCD, &htcherald_lcd_config },
+};
+
+/* Keyboard definition */
+
+static int htc_herald_keymap[] = {
+	KEY(0,0,KEY_RECORD), /* Mail button */
+	KEY(0,1,KEY_CAMERA), /* Camera */
+	KEY(0,2,KEY_PHONE), /* Send key */
+	KEY(0,3,KEY_VOLUMEUP), /* Volume up */
+	KEY(0,4,KEY_F2),  /* Right bar (landscape) */
+	KEY(0,5,KEY_MAIL), /* Win key (portrait) */
+	KEY(0,6,KEY_DIRECTORY), /* Right bar (protrait) */
+	KEY(1,0,KEY_LEFTCTRL), /* Windows key */
+	KEY(1,1,KEY_COMMA),
+	KEY(1,2,KEY_M),
+	KEY(1,3,KEY_K),
+	KEY(1,4,KEY_SLASH), /* OK key */
+	KEY(1,5,KEY_I),
+	KEY(1,6,KEY_U),
+	KEY(2,0,KEY_LEFTALT),
+	KEY(2,1,KEY_TAB),
+	KEY(2,2,KEY_N),
+	KEY(2,3,KEY_J),
+	KEY(2,4,KEY_ENTER),
+	KEY(2,5,KEY_H),
+	KEY(2,6,KEY_Y),
+	KEY(3,0,KEY_SPACE),
+	KEY(3,1,KEY_L),
+	KEY(3,2,KEY_B),
+	KEY(3,3,KEY_V),
+	KEY(3,4,KEY_BACKSPACE),
+	KEY(3,5,KEY_G),
+	KEY(3,6,KEY_T),
+	KEY(4,0,KEY_CAPSLOCK), /* Shift */
+	KEY(4,1,KEY_C),
+	KEY(4,2,KEY_F),
+	KEY(4,3,KEY_R),
+	KEY(4,4,KEY_O),
+	KEY(4,5,KEY_E),
+	KEY(4,6,KEY_D),
+	KEY(5,0,KEY_X),
+	KEY(5,1,KEY_Z),
+	KEY(5,2,KEY_S),
+	KEY(5,3,KEY_W),
+	KEY(5,4,KEY_P),
+	KEY(5,5,KEY_Q),
+	KEY(5,6,KEY_A),
+	KEY(6,0,KEY_CONNECT), /* Voice button */
+	KEY(6,2,KEY_CANCEL), /* End key */
+	KEY(6,3,KEY_VOLUMEDOWN), /* Volume down */
+	KEY(6,4,KEY_F1), /* Left bar (landscape) */
+	KEY(6,5,KEY_WWW), /* OK button (portrait) */
+	KEY(6,6,KEY_CALENDAR), /* Left bar (portrait) */
+	0
+};
+
+struct omap_kp_platform_data htcherald_kp_data = {
+	.rows	= 7,
+	.cols	= 7,
+	.delay = 20,
+	.rep = 1,
+	.keymap = htc_herald_keymap,
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
+		.platform_data = &htcherald_kp_data,
+	},
+	.num_resources	= ARRAY_SIZE(kp_resources),
+	.resource	= kp_resources,
+};
+
+/* LCD Device resources */
+static struct platform_device lcd_device = {
+	.name           = "lcd_htcherald",
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
+static void __init htcherald_map_io(void)
+{
+	omap1_map_common_io();
+	printk(KERN_INFO "htcherald_map_io done.\n");
+}
+
+static void __init htcherald_disable_watchdog(void)
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
+static void __init htcherald_init(void)
+{
+	printk(KERN_INFO "HTC Herald init.\n");
+
+	omap_gpio_init();
+
+	omap_board_config = htcherald_config;
+	omap_board_config_size = ARRAY_SIZE(htcherald_config);
+	platform_add_devices(devices, ARRAY_SIZE(devices));
+
+	htcherald_disable_watchdog();
+}
+
+static void __init htcherald_init_irq(void)
+{
+	printk(KERN_INFO "htcherald_init_irq.\n");
+	omap1_init_common_hw();
+	omap_init_irq();
+}
+
+MACHINE_START(HERALD, "HTC Herald")
+	/* Maintainer: Cory Maccarrone <darkstar6262@gmail.com> */
+	/* Maintainer: wing-linux.sourceforge.net */
+	.phys_io        = 0xfff00000,
+	.io_pg_offst    = ((0xfef00000) >> 18) & 0xfffc,
+	.boot_params    = 0x10000100,
+	.map_io         = htcherald_map_io,
+	.init_irq       = htcherald_init_irq,
+	.init_machine   = htcherald_init,
+	.timer          = &omap_timer,
+MACHINE_END
diff --git a/drivers/video/omap/lcd_htcherald.c
b/drivers/video/omap/lcd_htcherald.c
new file mode 100644
index 0000000..eb0dc2c
--- /dev/null
+++ b/drivers/video/omap/lcd_htcherald.c
@@ -0,0 +1,164 @@
+/*
+ * File: drivers/video/omap/lcd-htcherald.c
+ *
+ * LCD panel support for the HTC Herald
+ *
+ * Copyright (C) 2009 Cory Maccarrone <darkstar6262@gmail.com>
+ * Copyright (C) 2009 Wing Linux
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
+#include <mach/omapfb.h>
+#include <mach/io.h>
+
+/* LCD register definition */
+#define       OMAP_LCDC_CONTROL               (0xfffec000 + 0x00)
+#define       OMAP_LCDC_STATUS                (0xfffec000 + 0x10)
+#define       OMAP_DMA_LCD_CCR                (0xfffee300 + 0xc2)
+#define       OMAP_DMA_LCD_CTRL               (0xfffee300 + 0xc4)
+#define       OMAP_LCDC_CTRL_LCD_EN           (1 << 0)
+#define       OMAP_LCDC_STAT_DONE             (1 << 0)
+
+static int htcherald_panel_init(struct lcd_panel *panel,
+                                struct omapfb_device *fbdev)
+{
+	return 0;
+}
+
+static void htcherald_panel_cleanup(struct lcd_panel *panel)
+{
+}
+
+static int htcherald_panel_enable(struct lcd_panel *panel)
+{
+	return 0;
+}
+
+static void htcherald_panel_disable(struct lcd_panel *panel)
+{
+}
+
+static unsigned long htcherald_panel_get_caps(struct lcd_panel *panel)
+{
+	return 0;
+}
+
+/* Found on WIZ200 (miknix) and some HERA110 models (darkstar62) */
+struct lcd_panel htcherald_panel_1 = {
+	.name		= "lcd_herald",
+	.config		= OMAP_LCDC_PANEL_TFT |
+			  OMAP_LCDC_INV_HSYNC |
+			  OMAP_LCDC_INV_VSYNC |
+			  OMAP_LCDC_INV_PIX_CLOCK,
+	.bpp		= 16,
+	.data_lines	= 16,
+	.x_res		= 240,
+	.y_res		= 320,
+	.pixel_clock	= 6093,
+	.pcd		= 0, /* 15 */
+	.hsw		= 10,
+	.hfp		= 10,
+	.hbp		= 20,
+	.vsw		= 3,
+	.vfp		= 2,
+	.vbp		= 2,
+
+	.init		= htcherald_panel_init,
+	.cleanup	= htcherald_panel_cleanup,
+	.enable		= htcherald_panel_enable,
+	.disable	= htcherald_panel_disable,
+	.get_caps	= htcherald_panel_get_caps,
+};
+
+static int htcherald_panel_probe(struct platform_device *pdev)
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
+		while (!(omap_readl(OMAP_LCDC_STATUS) & OMAP_LCDC_STAT_DONE) && --tries);
+
+		if (!tries) {
+			printk(KERN_WARNING "lcd_htcherald: Unable to confirm controller
is disabled -- LCD might not work\n");
+		}
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
+
+	omapfb_register_panel(&htcherald_panel_1);
+	return 0;
+}
+
+static int htcherald_panel_remove(struct platform_device *pdev)
+{
+	return 0;
+}
+
+static int htcherald_panel_suspend(struct platform_device *pdev,
pm_message_t mesg)
+{
+	return 0;
+}
+
+static int htcherald_panel_resume(struct platform_device *pdev)
+{
+	return 0;
+}
+
+struct platform_driver htcherald_panel_driver = {
+	.probe		= htcherald_panel_probe,
+	.remove		= htcherald_panel_remove,
+	.suspend	= htcherald_panel_suspend,
+	.resume		= htcherald_panel_resume,
+	.driver		= {
+		.name	= "lcd_htcherald",
+		.owner	= THIS_MODULE,
+	},
+};
+
+static int htcherald_panel_drv_init(void)
+{
+	return platform_driver_register(&htcherald_panel_driver);
+}
+
+static void htcherald_panel_drv_cleanup(void)
+{
+	platform_driver_unregister(&htcherald_panel_driver);
+}
+
+module_init(htcherald_panel_drv_init);
+module_exit(htcherald_panel_drv_cleanup);
+
-- 
1.5.6.3
