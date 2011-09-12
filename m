From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCHv2 2/6] OMAP: omap3touchbook: Remove unused lcd stuff
Date: Mon, 12 Sep 2011 14:20:44 +0300
Message-ID: <1315826448-27891-3-git-send-email-tomi.valkeinen@ti.com>
References: <1315826448-27891-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog115.obsmtp.com ([74.125.149.238]:45300 "EHLO
	na3sys009aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754997Ab1ILLVC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 12 Sep 2011 07:21:02 -0400
Received: by mail-bw0-f52.google.com with SMTP id 5so2671836bke.39
        for <linux-omap@vger.kernel.org>; Mon, 12 Sep 2011 04:21:01 -0700 (PDT)
In-Reply-To: <1315826448-27891-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, tony@atomide.com
Cc: archit@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>, Gregoire Gentil <gregoire@gentil.com>

board-omap3touchbook.c adds an LCD device, but the kernel doesn't
contain a driver for the device. So let's remove the unneeded LCD
device.

Cc: Gregoire Gentil <gregoire@gentil.com>
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/mach-omap2/board-omap3touchbook.c |   18 ------------------
 1 files changed, 0 insertions(+), 18 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap3touchbook.c b/arch/arm/mach-omap2/board-omap3touchbook.c
index 852ea04..80e8276 100644
--- a/arch/arm/mach-omap2/board-omap3touchbook.c
+++ b/arch/arm/mach-omap2/board-omap3touchbook.c
@@ -104,15 +104,6 @@ static struct omap2_hsmmc_info mmc[] = {
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
 static struct regulator_consumer_supply touchbook_vmmc1_supply[] = {
 	REGULATOR_SUPPLY("vmmc", "omap_hsmmc.0"),
 };
@@ -165,14 +156,12 @@ static struct twl4030_gpio_platform_data touchbook_gpio_data = {
 static struct regulator_consumer_supply touchbook_vdac_supply[] = {
 {
 	.supply		= "vdac",
-	.dev		= &omap3_touchbook_lcd_device.dev,
 },
 };
 
 static struct regulator_consumer_supply touchbook_vdvi_supply[] = {
 {
 	.supply		= "vdvi",
-	.dev		= &omap3_touchbook_lcd_device.dev,
 },
 };
 
@@ -316,10 +305,6 @@ static struct platform_device keys_gpio = {
 	},
 };
 
-static struct omap_board_config_kernel omap3_touchbook_config[] __initdata = {
-	{ OMAP_TAG_LCD,		&omap3_touchbook_lcd_config },
-};
-
 #ifdef CONFIG_OMAP_MUX
 static struct omap_board_mux board_mux[] __initdata = {
 	{ .reg_offset = OMAP_MUX_TERMINATOR },
@@ -339,7 +324,6 @@ static void __init omap3_touchbook_init_irq(void)
 }
 
 static struct platform_device *omap3_touchbook_devices[] __initdata = {
-	&omap3_touchbook_lcd_device,
 	&leds_gpio,
 	&keys_gpio,
 };
@@ -376,8 +360,6 @@ early_param("tbr", early_touchbook_revision);
 static void __init omap3_touchbook_init(void)
 {
 	omap3_mux_init(board_mux, OMAP_PACKAGE_CBB);
-	omap_board_config = omap3_touchbook_config;
-	omap_board_config_size = ARRAY_SIZE(omap3_touchbook_config);
 
 	pm_power_off = omap3_touchbook_poweroff;
 
-- 
1.7.4.1

