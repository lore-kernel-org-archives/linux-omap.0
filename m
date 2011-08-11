From: Michael Jones <michael.jones@matrix-vision.de>
Subject: [PATCH] omap2+: cleanup unneeded *_init_irq functions
Date: Thu, 11 Aug 2011 09:02:23 +0200
Message-ID: <1313046143-24115-1-git-send-email-michael.jones@matrix-vision.de>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail1.matrix-vision.com ([78.47.19.71]:47287 "EHLO
	mail1.matrix-vision.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751468Ab1HKHDU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Aug 2011 03:03:20 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, linux-arm-kernel@lists.infradead.org

After 0c336dc5ec492886620d4afdc252c63f32adbd0e (omap2+: Remove
omap2_gp_clockevent_set_gptimer) these functions didn't have much
purpose anymore. Just pass omap3_init_irq directly with MACHINE_START.

Signed-off-by: Michael Jones <michael.jones@matrix-vision.de>
---
 arch/arm/mach-omap2/board-devkit8000.c     |    7 +------
 arch/arm/mach-omap2/board-omap3beagle.c    |    7 +------
 arch/arm/mach-omap2/board-omap3stalker.c   |    7 +------
 arch/arm/mach-omap2/board-omap3touchbook.c |    7 +------
 4 files changed, 4 insertions(+), 24 deletions(-)

diff --git a/arch/arm/mach-omap2/board-devkit8000.c b/arch/arm/mach-omap2/board-devkit8000.c
index b6002ec..8fc4fd2 100644
--- a/arch/arm/mach-omap2/board-devkit8000.c
+++ b/arch/arm/mach-omap2/board-devkit8000.c
@@ -405,11 +405,6 @@ static void __init devkit8000_init_early(void)
 				  mt46h32m32lf6_sdrc_params);
 }
 
-static void __init devkit8000_init_irq(void)
-{
-	omap3_init_irq();
-}
-
 #define OMAP_DM9000_BASE	0x2c000000
 
 static struct resource omap_dm9000_resources[] = {
@@ -671,7 +666,7 @@ MACHINE_START(DEVKIT8000, "OMAP3 Devkit8000")
 	.reserve	= omap_reserve,
 	.map_io		= omap3_map_io,
 	.init_early	= devkit8000_init_early,
-	.init_irq	= devkit8000_init_irq,
+	.init_irq	= omap3_init_irq,
 	.init_machine	= devkit8000_init,
 	.timer		= &omap3_secure_timer,
 MACHINE_END
diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
index 32f5f89..2488f01 100644
--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -451,11 +451,6 @@ static void __init omap3_beagle_init_early(void)
 				  mt46h32m32lf6_sdrc_params);
 }
 
-static void __init omap3_beagle_init_irq(void)
-{
-	omap3_init_irq();
-}
-
 static struct platform_device *omap3_beagle_devices[] __initdata = {
 	&leds_gpio,
 	&keys_gpio,
@@ -564,7 +559,7 @@ MACHINE_START(OMAP3_BEAGLE, "OMAP3 Beagle Board")
 	.reserve	= omap_reserve,
 	.map_io		= omap3_map_io,
 	.init_early	= omap3_beagle_init_early,
-	.init_irq	= omap3_beagle_init_irq,
+	.init_irq	= omap3_init_irq,
 	.init_machine	= omap3_beagle_init,
 	.timer		= &omap3_secure_timer,
 MACHINE_END
diff --git a/arch/arm/mach-omap2/board-omap3stalker.c b/arch/arm/mach-omap2/board-omap3stalker.c
index 8e10498..319bbd1 100644
--- a/arch/arm/mach-omap2/board-omap3stalker.c
+++ b/arch/arm/mach-omap2/board-omap3stalker.c
@@ -434,11 +434,6 @@ static void __init omap3_stalker_init_early(void)
 	omap2_init_common_devices(mt46h32m32lf6_sdrc_params, NULL);
 }
 
-static void __init omap3_stalker_init_irq(void)
-{
-	omap3_init_irq();
-}
-
 static struct platform_device *omap3_stalker_devices[] __initdata = {
 	&keys_gpio,
 };
@@ -497,7 +492,7 @@ MACHINE_START(SBC3530, "OMAP3 STALKER")
 	.boot_params		= 0x80000100,
 	.map_io			= omap3_map_io,
 	.init_early		= omap3_stalker_init_early,
-	.init_irq		= omap3_stalker_init_irq,
+	.init_irq		= omap3_init_irq,
 	.init_machine		= omap3_stalker_init,
 	.timer			= &omap3_secure_timer,
 MACHINE_END
diff --git a/arch/arm/mach-omap2/board-omap3touchbook.c b/arch/arm/mach-omap2/board-omap3touchbook.c
index 852ea04..36a0f6f 100644
--- a/arch/arm/mach-omap2/board-omap3touchbook.c
+++ b/arch/arm/mach-omap2/board-omap3touchbook.c
@@ -333,11 +333,6 @@ static void __init omap3_touchbook_init_early(void)
 				  mt46h32m32lf6_sdrc_params);
 }
 
-static void __init omap3_touchbook_init_irq(void)
-{
-	omap3_init_irq();
-}
-
 static struct platform_device *omap3_touchbook_devices[] __initdata = {
 	&omap3_touchbook_lcd_device,
 	&leds_gpio,
@@ -408,7 +403,7 @@ MACHINE_START(TOUCHBOOK, "OMAP3 touchbook Board")
 	.reserve	= omap_reserve,
 	.map_io		= omap3_map_io,
 	.init_early	= omap3_touchbook_init_early,
-	.init_irq	= omap3_touchbook_init_irq,
+	.init_irq	= omap3_init_irq,
 	.init_machine	= omap3_touchbook_init,
 	.timer		= &omap3_secure_timer,
 MACHINE_END
-- 
1.7.6


MATRIX VISION GmbH, Talstrasse 16, DE-71570 Oppenweiler
Registergericht: Amtsgericht Stuttgart, HRB 271090
Geschaeftsfuehrer: Gerhard Thullner, Werner Armingeon, Uwe Furtner, Erhard Meier
