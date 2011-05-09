From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 2/6] OMAP: omap3touchbook: Remove unused lcd stuff
Date: Mon,  9 May 2011 10:36:03 +0300
Message-ID: <1304926567-26814-3-git-send-email-tomi.valkeinen@ti.com>
References: <1304926567-26814-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:55393 "EHLO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752717Ab1EIHgX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 9 May 2011 03:36:23 -0400
Received: by mail-ey0-f182.google.com with SMTP id 7so2054805eyg.41
        for <linux-omap@vger.kernel.org>; Mon, 09 May 2011 00:36:22 -0700 (PDT)
In-Reply-To: <1304926567-26814-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>, Gregoire Gentil <gregoire@gentil.com>

board-omap3touchbook.c adds an LCD device, but the kernel doesn't
contain a driver for the device. So let's remove the unneeded LCD
device.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Gregoire Gentil <gregoire@gentil.com>
---
 arch/arm/mach-omap2/board-omap3touchbook.c |   18 ------------------
 1 files changed, 0 insertions(+), 18 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap3touchbook.c b/arch/arm/mach-omap2/board-omap3touchbook.c
index 127cb17..1c717a4 100644
--- a/arch/arm/mach-omap2/board-omap3touchbook.c
+++ b/arch/arm/mach-omap2/board-omap3touchbook.c
@@ -115,15 +115,6 @@ static struct omap2_hsmmc_info mmc[] = {
 	{}	/* Terminator */
 };
 
-static struct platform_device omap3_touchbook_lcd_device = {
-	.name		= "omap3touchbook_lcd",
-	.id		= -1,
-};
-
-static struct omap_lcd_config omap3_touchbook_lcd_config __initdata = {
-	.ctrl_name	= "internal",
-};
-
 static struct regulator_consumer_supply touchbook_vmmc1_supply = {
 	.supply			= "vmmc",
 };
@@ -181,12 +172,10 @@ static struct twl4030_gpio_platform_data touchbook_gpio_data = {
 
 static struct regulator_consumer_supply touchbook_vdac_supply = {
 	.supply		= "vdac",
-	.dev		= &omap3_touchbook_lcd_device.dev,
 };
 
 static struct regulator_consumer_supply touchbook_vdvi_supply = {
 	.supply		= "vdvi",
-	.dev		= &omap3_touchbook_lcd_device.dev,
 };
 
 /* VMMC1 for MMC1 pins CMD, CLK, DAT0..DAT3 (20 mA, plus card == max 220 mA) */
@@ -403,10 +392,6 @@ static struct platform_device keys_gpio = {
 	},
 };
 
-static struct omap_board_config_kernel omap3_touchbook_config[] __initdata = {
-	{ OMAP_TAG_LCD,		&omap3_touchbook_lcd_config },
-};
-
 #ifdef CONFIG_OMAP_MUX
 static struct omap_board_mux board_mux[] __initdata = {
 	{ .reg_offset = OMAP_MUX_TERMINATOR },
@@ -429,7 +414,6 @@ static void __init omap3_touchbook_init_irq(void)
 }
 
 static struct platform_device *omap3_touchbook_devices[] __initdata = {
-	&omap3_touchbook_lcd_device,
 	&leds_gpio,
 	&keys_gpio,
 };
@@ -510,8 +494,6 @@ static struct omap_musb_board_data musb_board_data = {
 static void __init omap3_touchbook_init(void)
 {
 	omap3_mux_init(board_mux, OMAP_PACKAGE_CBB);
-	omap_board_config = omap3_touchbook_config;
-	omap_board_config_size = ARRAY_SIZE(omap3_touchbook_config);
 
 	pm_power_off = omap3_touchbook_poweroff;
 
-- 
1.7.4.1

