From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH] ARM: OMAP2+: Remove custom init_irq for remaining boards
Date: Mon, 26 Sep 2011 16:18:11 -0700
Message-ID: <20110926231811.GK6324@atomide.com>
References: <1316809399-19579-1-git-send-email-b-cousson@ti.com>
 <1316809399-19579-2-git-send-email-b-cousson@ti.com>
 <20110923230049.GC6324@atomide.com>
 <20110926231516.GI6324@atomide.com>
 <20110926231646.GJ6324@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:39580 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752181Ab1IZXSO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 26 Sep 2011 19:18:14 -0400
Content-Disposition: inline
In-Reply-To: <20110926231646.GJ6324@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: grant.likely@secretlab.ca, paul@pwsan.com, khilman@ti.com, rnayak@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org

With SoC specific timers, board specific init_irq is
no longer needed. Earlier this was still needed to
initialize the gptimer12 on Beagle based boards.

Also convert board-h4.c to use omap2_init_irq accidentally
did not get converted earlier.

Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/mach-omap2/board-devkit8000.c b/arch/arm/mach-omap2/board-devkit8000.c
index 4b1f6c6..059b74d 100644
--- a/arch/arm/mach-omap2/board-devkit8000.c
+++ b/arch/arm/mach-omap2/board-devkit8000.c
@@ -397,11 +397,6 @@ static struct platform_device keys_gpio = {
 	},
 };
 
-static void __init devkit8000_init_irq(void)
-{
-	omap3_init_irq();
-}
-
 #define OMAP_DM9000_BASE	0x2c000000
 
 static struct resource omap_dm9000_resources[] = {
@@ -665,7 +660,7 @@ MACHINE_START(DEVKIT8000, "OMAP3 Devkit8000")
 	.reserve	= omap_reserve,
 	.map_io		= omap3_map_io,
 	.init_early	= omap35xx_init_early,
-	.init_irq	= devkit8000_init_irq,
+	.init_irq	= omap3_init_irq,
 	.init_machine	= devkit8000_init,
 	.timer		= &omap3_secure_timer,
 MACHINE_END
diff --git a/arch/arm/mach-omap2/board-h4.c b/arch/arm/mach-omap2/board-h4.c
index fcc5107..8486142 100644
--- a/arch/arm/mach-omap2/board-h4.c
+++ b/arch/arm/mach-omap2/board-h4.c
@@ -290,11 +290,6 @@ static struct omap_board_config_kernel h4_config[] __initdata = {
 	{ OMAP_TAG_LCD,		&h4_lcd_config },
 };
 
-static void __init omap_h4_init_irq(void)
-{
-	omap2_init_irq();
-}
-
 static struct at24_platform_data m24c01 = {
 	.byte_len	= SZ_1K / 8,
 	.page_size	= 16,
@@ -375,7 +370,7 @@ MACHINE_START(OMAP_H4, "OMAP2420 H4 board")
 	.reserve	= omap_reserve,
 	.map_io		= omap242x_map_io,
 	.init_early	= omap2420_init_early,
-	.init_irq	= omap_h4_init_irq,
+	.init_irq	= omap2_init_irq,
 	.init_machine	= omap_h4_init,
 	.timer		= &omap2_timer,
 MACHINE_END
diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
index ce3234d..e085371 100644
--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -449,11 +449,6 @@ static void __init omap3_beagle_init_early(void)
 	omap2_init_common_infrastructure();
 }
 
-static void __init omap3_beagle_init_irq(void)
-{
-	omap3_init_irq();
-}
-
 static struct platform_device *omap3_beagle_devices[] __initdata = {
 	&leds_gpio,
 	&keys_gpio,
@@ -561,7 +556,7 @@ MACHINE_START(OMAP3_BEAGLE, "OMAP3 Beagle Board")
 	.reserve	= omap_reserve,
 	.map_io		= omap3_map_io,
 	.init_early	= omap3_beagle_init_early,
-	.init_irq	= omap3_beagle_init_irq,
+	.init_irq	= omap3_init_irq,
 	.init_machine	= omap3_beagle_init,
 	.timer		= &omap3_secure_timer,
 MACHINE_END
diff --git a/arch/arm/mach-omap2/board-omap3stalker.c b/arch/arm/mach-omap2/board-omap3stalker.c
index 807c274..fa58a0f 100644
--- a/arch/arm/mach-omap2/board-omap3stalker.c
+++ b/arch/arm/mach-omap2/board-omap3stalker.c
@@ -428,11 +428,6 @@ static int __init omap3_stalker_i2c_init(void)
 static struct omap_board_config_kernel omap3_stalker_config[] __initdata = {
 };
 
-static void __init omap3_stalker_init_irq(void)
-{
-	omap3_init_irq();
-}
-
 static struct platform_device *omap3_stalker_devices[] __initdata = {
 	&keys_gpio,
 };
@@ -492,7 +487,7 @@ MACHINE_START(SBC3530, "OMAP3 STALKER")
 	.boot_params		= 0x80000100,
 	.map_io			= omap3_map_io,
 	.init_early		= omap35xx_init_early,
-	.init_irq		= omap3_stalker_init_irq,
+	.init_irq		= omap3_init_irq,
 	.init_machine		= omap3_stalker_init,
 	.timer			= &omap3_secure_timer,
 MACHINE_END
diff --git a/arch/arm/mach-omap2/board-omap3touchbook.c b/arch/arm/mach-omap2/board-omap3touchbook.c
index f7f1809..05488fb 100644
--- a/arch/arm/mach-omap2/board-omap3touchbook.c
+++ b/arch/arm/mach-omap2/board-omap3touchbook.c
@@ -326,11 +326,6 @@ static struct omap_board_mux board_mux[] __initdata = {
 };
 #endif
 
-static void __init omap3_touchbook_init_irq(void)
-{
-	omap3_init_irq();
-}
-
 static struct platform_device *omap3_touchbook_devices[] __initdata = {
 	&omap3_touchbook_lcd_device,
 	&leds_gpio,
@@ -403,7 +398,7 @@ MACHINE_START(TOUCHBOOK, "OMAP3 touchbook Board")
 	.reserve	= omap_reserve,
 	.map_io		= omap3_map_io,
 	.init_early	= omap3430_init_early,
-	.init_irq	= omap3_touchbook_init_irq,
+	.init_irq	= omap3_init_irq,
 	.init_machine	= omap3_touchbook_init,
 	.timer		= &omap3_secure_timer,
 MACHINE_END
