From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH] ARM: OMAP: Remove broken LCD driver for SX1
Date: Wed, 26 Nov 2008 15:28:34 -0800
Message-ID: <20081126232833.GO11997@atomide.com>
References: <20081126232707.GN11997@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:61813 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752447AbYKZX2d (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 26 Nov 2008 18:28:33 -0500
Content-Disposition: inline
In-Reply-To: <20081126232707.GN11997@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org

>From 7953031da4200323ab5d85bd514054ca4ba9d225 Mon Sep 17 00:00:00 2001
From: Tony Lindgren <tony@atomide.com>
Date: Mon, 24 Nov 2008 18:11:16 -0800
Subject: [PATCH] ARM: OMAP: Remove broken LCD driver for SX1

Recently the omap McBSP code was cleaned up to get rid of
direct McBSP register tinkering by the drivers. Looks like
lcd_sx1.c never got converted, and now it breaks builds.

It seems the lcd_sx1.c driver is attempting SPI mode, but
doing it in a different way compared to omap_mcbsp_set_spi_mode().

Remove the broken driver, patches welcome to add it back when
done properly by patching both mcbsp.c and lcd_sx1.c.

Cc: Vovan888@gmail.com
Cc: linux-fbdev-devel@lists.sourceforge.net
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/video/omap/Makefile  |    1 -
 drivers/video/omap/lcd_sx1.c |  327 ------------------------------------------
 2 files changed, 0 insertions(+), 328 deletions(-)
 delete mode 100644 drivers/video/omap/lcd_sx1.c

diff --git a/drivers/video/omap/Makefile b/drivers/video/omap/Makefile
index 99da8b6..ed13889 100644
--- a/drivers/video/omap/Makefile
+++ b/drivers/video/omap/Makefile
@@ -23,7 +23,6 @@ objs-y$(CONFIG_MACH_OMAP_PALMZ71) += lcd_palmz71.o
 objs-$(CONFIG_ARCH_OMAP16XX)$(CONFIG_MACH_OMAP_INNOVATOR) += lcd_inn1610.o
 objs-$(CONFIG_ARCH_OMAP15XX)$(CONFIG_MACH_OMAP_INNOVATOR) += lcd_inn1510.o
 objs-y$(CONFIG_MACH_OMAP_OSK) += lcd_osk.o
-objs-y$(CONFIG_MACH_SX1) += lcd_sx1.o
 
 omapfb-objs := $(objs-yy)
 
diff --git a/drivers/video/omap/lcd_sx1.c b/drivers/video/omap/lcd_sx1.c
deleted file mode 100644
index e55de20..0000000
--- a/drivers/video/omap/lcd_sx1.c
+++ /dev/null
@@ -1,327 +0,0 @@
-/*
- * LCD panel support for the Siemens SX1 mobile phone
- *
- * Current version : Vovan888@gmail.com, great help from FCA00000
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License as published by the
- * Free Software Foundation; either version 2 of the License, or (at your
- * option) any later version.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, write to the Free Software Foundation, Inc.,
- * 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
- */
-
-#include <linux/module.h>
-#include <linux/platform_device.h>
-#include <linux/delay.h>
-#include <linux/io.h>
-
-#include <mach/gpio.h>
-#include <mach/omapfb.h>
-#include <mach/mcbsp.h>
-#include <mach/mux.h>
-
-/*
- * OMAP310 GPIO registers
- */
-#define GPIO_DATA_INPUT		0xfffce000
-#define GPIO_DATA_OUTPUT	0xfffce004
-#define GPIO_DIR_CONTROL	0xfffce008
-#define GPIO_INT_CONTROL	0xfffce00c
-#define GPIO_INT_MASK		0xfffce010
-#define GPIO_INT_STATUS		0xfffce014
-#define GPIO_PIN_CONTROL	0xfffce018
-
-
-#define A_LCD_SSC_RD	3
-#define A_LCD_SSC_SD	7
-#define _A_LCD_RESET	9
-#define _A_LCD_SSC_CS	12
-#define _A_LCD_SSC_A0	13
-
-#define DSP_REG		0xE1017024
-
-const unsigned char INIT_1[12] = {
-	0x1C, 0x02, 0x88, 0x00, 0x1E, 0xE0, 0x00, 0xDC, 0x00, 0x02, 0x00
-};
-
-const unsigned char INIT_2[127] = {
-	0x15, 0x00, 0x29, 0x00, 0x3E, 0x00, 0x51, 0x00,
-	0x65, 0x00, 0x7A, 0x00, 0x8D, 0x00, 0xA1, 0x00,
-	0xB6, 0x00, 0xC7, 0x00, 0xD8, 0x00, 0xEB, 0x00,
-	0xFB, 0x00, 0x0B, 0x01, 0x1B, 0x01, 0x27, 0x01,
-	0x34, 0x01, 0x41, 0x01, 0x4C, 0x01, 0x55, 0x01,
-	0x5F, 0x01, 0x68, 0x01, 0x70, 0x01, 0x78, 0x01,
-	0x7E, 0x01, 0x86, 0x01, 0x8C, 0x01, 0x94, 0x01,
-	0x9B, 0x01, 0xA1, 0x01, 0xA4, 0x01, 0xA9, 0x01,
-	0xAD, 0x01, 0xB2, 0x01, 0xB7, 0x01, 0xBC, 0x01,
-	0xC0, 0x01, 0xC4, 0x01, 0xC8, 0x01, 0xCB, 0x01,
-	0xCF, 0x01, 0xD2, 0x01, 0xD5, 0x01, 0xD8, 0x01,
-	0xDB, 0x01, 0xE0, 0x01, 0xE3, 0x01, 0xE6, 0x01,
-	0xE8, 0x01, 0xEB, 0x01, 0xEE, 0x01, 0xF1, 0x01,
-	0xF3, 0x01, 0xF8, 0x01, 0xF9, 0x01, 0xFC, 0x01,
-	0x00, 0x02, 0x03, 0x02, 0x07, 0x02, 0x09, 0x02,
-	0x0E, 0x02, 0x13, 0x02, 0x1C, 0x02, 0x00
-};
-
-const unsigned char INIT_3[15] = {
-	0x14, 0x26, 0x33, 0x3D, 0x45, 0x4D, 0x53, 0x59,
-	0x5E, 0x63, 0x67, 0x6D, 0x71, 0x78, 0xFF
-};
-
-static void epson_sendbyte(int flag, unsigned char byte)
-{
-	int i, shifter = 0x80;
-
-	if (!flag)
-		gpio_set_value(_A_LCD_SSC_A0, 0);
-	mdelay(2);
-	gpio_set_value(A_LCD_SSC_RD, 1);
-
-	gpio_set_value(A_LCD_SSC_SD, flag);
-
-	OMAP_MCBSP_WRITE(OMAP1510_MCBSP3_BASE, PCR0, 0x2200);
-	OMAP_MCBSP_WRITE(OMAP1510_MCBSP3_BASE, PCR0, 0x2202);
-	for (i = 0; i < 8; i++) {
-		OMAP_MCBSP_WRITE(OMAP1510_MCBSP3_BASE, PCR0, 0x2200);
-		gpio_set_value(A_LCD_SSC_SD, shifter & byte);
-		OMAP_MCBSP_WRITE(OMAP1510_MCBSP3_BASE, PCR0, 0x2202);
-		shifter >>= 1;
-	}
-	gpio_set_value(_A_LCD_SSC_A0, 1);
-}
-
-static void init_system(void)
-{
-	omap_mcbsp_request(OMAP_MCBSP3);
-	omap_mcbsp_stop(OMAP_MCBSP3);
-}
-
-static void setup_GPIO(void)
-{
-	/* new wave */
-	gpio_request(A_LCD_SSC_RD, "lcd_ssc_rd");
-	gpio_request(A_LCD_SSC_SD, "lcd_ssc_sd");
-	gpio_request(_A_LCD_RESET, "lcd_reset");
-	gpio_request(_A_LCD_SSC_CS, "lcd_ssc_cs");
-	gpio_request(_A_LCD_SSC_A0, "lcd_ssc_a0");
-
-	/* set GPIOs to output, with initial data */
-	gpio_direction_output(A_LCD_SSC_RD, 1);
-	gpio_direction_output(A_LCD_SSC_SD, 0);
-	gpio_direction_output(_A_LCD_RESET, 0);
-	gpio_direction_output(_A_LCD_SSC_CS, 1);
-	gpio_direction_output(_A_LCD_SSC_A0, 1);
-}
-
-static void display_init(void)
-{
-	int i;
-
-	omap_cfg_reg(MCBSP3_CLKX);
-
-	mdelay(2);
-	setup_GPIO();
-	mdelay(2);
-
-	/* reset LCD */
-	gpio_set_value(A_LCD_SSC_SD, 1);
-	epson_sendbyte(0, 0x25);
-
-	gpio_set_value(_A_LCD_RESET, 0);
-	mdelay(10);
-	gpio_set_value(_A_LCD_RESET, 1);
-
-	gpio_set_value(_A_LCD_SSC_CS, 1);
-	mdelay(2);
-	gpio_set_value(_A_LCD_SSC_CS, 0);
-
-	/* init LCD, phase 1 */
-	epson_sendbyte(0, 0xCA);
-	for (i = 0; i < 10; i++)
-		epson_sendbyte(1, INIT_1[i]);
-	gpio_set_value(_A_LCD_SSC_CS, 1);
-	gpio_set_value(_A_LCD_SSC_CS, 0);
-
-	/* init LCD phase 2 */
-	epson_sendbyte(0, 0xCB);
-	for (i = 0; i < 125; i++)
-		epson_sendbyte(1, INIT_2[i]);
-	gpio_set_value(_A_LCD_SSC_CS, 1);
-	gpio_set_value(_A_LCD_SSC_CS, 0);
-
-	/* init LCD phase 2a */
-	epson_sendbyte(0, 0xCC);
-	for (i = 0; i < 14; i++)
-		epson_sendbyte(1, INIT_3[i]);
-	gpio_set_value(_A_LCD_SSC_CS, 1);
-	gpio_set_value(_A_LCD_SSC_CS, 0);
-
-	/* init LCD phase 3 */
-	epson_sendbyte(0, 0xBC);
-	epson_sendbyte(1, 0x08);
-	gpio_set_value(_A_LCD_SSC_CS, 1);
-	gpio_set_value(_A_LCD_SSC_CS, 0);
-
-	/* init LCD phase 4 */
-	epson_sendbyte(0, 0x07);
-	epson_sendbyte(1, 0x05);
-	gpio_set_value(_A_LCD_SSC_CS, 1);
-	gpio_set_value(_A_LCD_SSC_CS, 0);
-
-	/* init LCD phase 5 */
-	epson_sendbyte(0, 0x94);
-	gpio_set_value(_A_LCD_SSC_CS, 1);
-	gpio_set_value(_A_LCD_SSC_CS, 0);
-
-	/* init LCD phase 6 */
-	epson_sendbyte(0, 0xC6);
-	epson_sendbyte(1, 0x80);
-	gpio_set_value(_A_LCD_SSC_CS, 1);
-	mdelay(100); /* used to be 1000 */
-	gpio_set_value(_A_LCD_SSC_CS, 0);
-
-	/* init LCD phase 7 */
-	epson_sendbyte(0, 0x16);
-	epson_sendbyte(1, 0x02);
-	epson_sendbyte(1, 0x00);
-	epson_sendbyte(1, 0xB1);
-	epson_sendbyte(1, 0x00);
-	gpio_set_value(_A_LCD_SSC_CS, 1);
-	gpio_set_value(_A_LCD_SSC_CS, 0);
-
-	/* init LCD phase 8 */
-	epson_sendbyte(0, 0x76);
-	epson_sendbyte(1, 0x00);
-	epson_sendbyte(1, 0x00);
-	epson_sendbyte(1, 0xDB);
-	epson_sendbyte(1, 0x00);
-	gpio_set_value(_A_LCD_SSC_CS, 1);
-	gpio_set_value(_A_LCD_SSC_CS, 0);
-
-	/* init LCD phase 9 */
-	epson_sendbyte(0, 0xAF);
-	gpio_set_value(_A_LCD_SSC_CS, 1);
-}
-
-static int sx1_panel_init(struct lcd_panel *panel, struct omapfb_device *fbdev)
-{
-	return 0;
-}
-
-static void sx1_panel_cleanup(struct lcd_panel *panel)
-{
-}
-
-static void sx1_panel_disable(struct lcd_panel *panel)
-{
-	printk(KERN_INFO "SX1: LCD panel disable\n");
-	sx1_setmmipower(0);
-	gpio_set_value(_A_LCD_SSC_CS, 1);
-
-	epson_sendbyte(0, 0x25);
-	gpio_set_value(_A_LCD_SSC_CS, 0);
-
-	epson_sendbyte(0, 0xAE);
-	gpio_set_value(_A_LCD_SSC_CS, 1);
-	mdelay(100);
-	gpio_set_value(_A_LCD_SSC_CS, 0);
-
-	epson_sendbyte(0, 0x95);
-	gpio_set_value(_A_LCD_SSC_CS, 1);
-}
-
-static int sx1_panel_enable(struct lcd_panel *panel)
-{
-	printk(KERN_INFO "lcd_sx1: LCD panel enable\n");
-	init_system();
-	display_init();
-
-	sx1_setmmipower(1);
-	sx1_setbacklight(0x18);
-	sx1_setkeylight (0x06);
-	return 0;
-}
-
-
-static unsigned long sx1_panel_get_caps(struct lcd_panel *panel)
-{
-	return 0;
-}
-
-struct lcd_panel sx1_panel = {
-	.name		= "sx1",
-	.config		= OMAP_LCDC_PANEL_TFT | OMAP_LCDC_INV_VSYNC |
-			  OMAP_LCDC_INV_HSYNC | OMAP_LCDC_INV_PIX_CLOCK |
-			  OMAP_LCDC_INV_OUTPUT_EN,
-
-	.x_res		= 176,
-	.y_res		= 220,
-	.data_lines	= 16,
-	.bpp		= 16,
-	.hsw		= 5,
-	.hfp		= 5,
-	.hbp		= 5,
-	.vsw		= 2,
-	.vfp		= 1,
-	.vbp		= 1,
-	.pixel_clock	= 1500,
-
-	.init		= sx1_panel_init,
-	.cleanup	= sx1_panel_cleanup,
-	.enable		= sx1_panel_enable,
-	.disable	= sx1_panel_disable,
-	.get_caps	= sx1_panel_get_caps,
-};
-
-static int sx1_panel_probe(struct platform_device *pdev)
-{
-	omapfb_register_panel(&sx1_panel);
-	return 0;
-}
-
-static int sx1_panel_remove(struct platform_device *pdev)
-{
-	return 0;
-}
-
-static int sx1_panel_suspend(struct platform_device *pdev, pm_message_t mesg)
-{
-	return 0;
-}
-
-static int sx1_panel_resume(struct platform_device *pdev)
-{
-	return 0;
-}
-
-struct platform_driver sx1_panel_driver = {
-	.probe		= sx1_panel_probe,
-	.remove		= sx1_panel_remove,
-	.suspend	= sx1_panel_suspend,
-	.resume		= sx1_panel_resume,
-	.driver	= {
-		.name	= "lcd_sx1",
-		.owner	= THIS_MODULE,
-	},
-};
-
-static int sx1_panel_drv_init(void)
-{
-	return platform_driver_register(&sx1_panel_driver);
-}
-
-static void sx1_panel_drv_cleanup(void)
-{
-	platform_driver_unregister(&sx1_panel_driver);
-}
-
-module_init(sx1_panel_drv_init);
-module_exit(sx1_panel_drv_cleanup);
-- 
1.5.6.rc3.21.g8c6b5

