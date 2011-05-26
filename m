From: Silesh C V <silesh@ti.com>
Subject: [PATCH] ARM: OMAP: Get rid of section mismatch warnings
Date: Thu, 26 May 2011 18:30:38 +0530
Message-ID: <1306414838-4330-1-git-send-email-silesh@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:36104 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751589Ab1EZMzk (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 26 May 2011 08:55:40 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, tony@atomide.com, Silesh C V <silesh@ti.com>

Get rid of the following and 8 other similar section mismatch
warnings

WARNING: vmlinux.o(.text+0x2740c): Section mismatch in reference from the function zoom_lcd_panel_init() to the (unknown reference) .init.data:(unknown)
The function zoom_lcd_panel_init() references
the (unknown reference) __initdata (unknown).
This is often because zoom_lcd_panel_init lacks a __initdata
annotation or the annotation of (unknown) is wrong.

WARNING: vmlinux.o(.text+0x277fc): Section mismatch in reference from the function omap_ethernet_init() to the (unknown reference) .init.data:(unknown)
The function omap_ethernet_init() references
the (unknown reference) __initdata (unknown).
This is often because omap_ethernet_init lacks a __initdata
annotation or the annotation of (unknown) is wrong.

WARNING: vmlinux.o(.data+0x2ff3c): Section mismatch in reference from the variable serial1_data to the (unknown reference) .init.data:(unknown)
The variable serial1_data references
the (unknown reference) __initdata (unknown)
If the reference is valid then annotate the
variable with __init* or __refdata (see linux/init.h) or name the variable:
*_template, *_timer, *_sht, *_ops, *_probe, *_probe_one, *_console

Signed-off-by: Silesh C V <silesh@ti.com>
---
 arch/arm/mach-omap2/board-3430sdp.c      |    6 +++---
 arch/arm/mach-omap2/board-4430sdp.c      |    8 ++++----
 arch/arm/mach-omap2/board-omap4panda.c   |    6 +++---
 arch/arm/mach-omap2/board-zoom-display.c |    2 +-
 4 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/arm/mach-omap2/board-3430sdp.c b/arch/arm/mach-omap2/board-3430sdp.c
index 52dbdf3..c710ad5 100644
--- a/arch/arm/mach-omap2/board-3430sdp.c
+++ b/arch/arm/mach-omap2/board-3430sdp.c
@@ -622,19 +622,19 @@ static struct omap_device_pad serial3_pads[] __initdata = {
 			 OMAP_MUX_MODE0),
 };
 
-static struct omap_board_data serial1_data = {
+static struct omap_board_data serial1_data __initdata = {
 	.id		= 0,
 	.pads		= serial1_pads,
 	.pads_cnt	= ARRAY_SIZE(serial1_pads),
 };
 
-static struct omap_board_data serial2_data = {
+static struct omap_board_data serial2_data __initdata = {
 	.id		= 1,
 	.pads		= serial2_pads,
 	.pads_cnt	= ARRAY_SIZE(serial2_pads),
 };
 
-static struct omap_board_data serial3_data = {
+static struct omap_board_data serial3_data __initdata = {
 	.id		= 2,
 	.pads		= serial3_pads,
 	.pads_cnt	= ARRAY_SIZE(serial3_pads),
diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
index ae3153c..da6c666 100644
--- a/arch/arm/mach-omap2/board-4430sdp.c
+++ b/arch/arm/mach-omap2/board-4430sdp.c
@@ -258,7 +258,7 @@ static struct gpio sdp4430_eth_gpios[] __initdata = {
 	{ ETH_KS8851_IRQ,	GPIOF_IN,		"eth_irq"	},
 };
 
-static int omap_ethernet_init(void)
+static int __init omap_ethernet_init(void)
 {
 	int status;
 
@@ -672,19 +672,19 @@ static struct omap_device_pad serial4_pads[] __initdata = {
 			 OMAP_PIN_OUTPUT | OMAP_MUX_MODE0),
 };
 
-static struct omap_board_data serial2_data = {
+static struct omap_board_data serial2_data __initdata = {
 	.id		= 1,
 	.pads		= serial2_pads,
 	.pads_cnt	= ARRAY_SIZE(serial2_pads),
 };
 
-static struct omap_board_data serial3_data = {
+static struct omap_board_data serial3_data __initdata = {
 	.id		= 2,
 	.pads		= serial3_pads,
 	.pads_cnt	= ARRAY_SIZE(serial3_pads),
 };
 
-static struct omap_board_data serial4_data = {
+static struct omap_board_data serial4_data __initdata = {
 	.id		= 3,
 	.pads		= serial4_pads,
 	.pads_cnt	= ARRAY_SIZE(serial4_pads),
diff --git a/arch/arm/mach-omap2/board-omap4panda.c b/arch/arm/mach-omap2/board-omap4panda.c
index 5d7c0a3..2d52ee7 100644
--- a/arch/arm/mach-omap2/board-omap4panda.c
+++ b/arch/arm/mach-omap2/board-omap4panda.c
@@ -526,19 +526,19 @@ static struct omap_device_pad serial4_pads[] __initdata = {
 			 OMAP_PIN_OUTPUT | OMAP_MUX_MODE0),
 };
 
-static struct omap_board_data serial2_data = {
+static struct omap_board_data serial2_data __initdata = {
 	.id             = 1,
 	.pads           = serial2_pads,
 	.pads_cnt       = ARRAY_SIZE(serial2_pads),
 };
 
-static struct omap_board_data serial3_data = {
+static struct omap_board_data serial3_data __initdata = {
 	.id             = 2,
 	.pads           = serial3_pads,
 	.pads_cnt       = ARRAY_SIZE(serial3_pads),
 };
 
-static struct omap_board_data serial4_data = {
+static struct omap_board_data serial4_data __initdata = {
 	.id             = 3,
 	.pads           = serial4_pads,
 	.pads_cnt       = ARRAY_SIZE(serial4_pads),
diff --git a/arch/arm/mach-omap2/board-zoom-display.c b/arch/arm/mach-omap2/board-zoom-display.c
index ce53e82..d826242 100644
--- a/arch/arm/mach-omap2/board-zoom-display.c
+++ b/arch/arm/mach-omap2/board-zoom-display.c
@@ -26,7 +26,7 @@ static struct gpio zoom_lcd_gpios[] __initdata = {
 	{ LCD_PANEL_QVGA_GPIO,	GPIOF_OUT_INIT_HIGH, "lcd qvga"	 },
 };
 
-static void zoom_lcd_panel_init(void)
+static void __init zoom_lcd_panel_init(void)
 {
 	zoom_lcd_gpios[0].gpio = (omap_rev() > OMAP3430_REV_ES3_0) ?
 			LCD_PANEL_RESET_GPIO_PROD :
-- 
1.7.1

