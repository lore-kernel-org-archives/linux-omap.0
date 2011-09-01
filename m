From: Benoit Cousson <b-cousson@ti.com>
Subject: [PATCH 7/7] OMAP3: beagleboard: Remove DT support from regular board
Date: Thu, 1 Sep 2011 19:25:12 +0200
Message-ID: <1314897912-18178-8-git-send-email-b-cousson@ti.com>
References: <1314897912-18178-1-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:38253 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756466Ab1IARZr (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 1 Sep 2011 13:25:47 -0400
In-Reply-To: <1314897912-18178-1-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: grant.likely@secretlab.ca, tony@atomide.com
Cc: linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, manjugk@ti.com, Benoit Cousson <b-cousson@ti.com>

In order to avoid conflict with the new board-omap3-dt.c file,
remove the .dt_compat entry from the beagle regular board
file.

Any DT work for OMAP3 will have to be done on the generic DT
board file to avoid breaking the legacy board support until
DT migration is done.

Based on orginal patch fropm Manju:
http://www.spinics.net/lists/linux-omap/msg55832.html

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Signed-off-by: G, Manjunath Kondaiah <manjugk@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/board-omap3beagle.c |   13 -------------
 1 files changed, 0 insertions(+), 13 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
index a7923ca..2c358a2 100644
--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -19,7 +19,6 @@
 #include <linux/err.h>
 #include <linux/clk.h>
 #include <linux/io.h>
-#include <linux/of_platform.h>
 #include <linux/leds.h>
 #include <linux/gpio.h>
 #include <linux/input.h>
@@ -388,9 +387,7 @@ static int __init omap3_beagle_i2c_init(void)
 	/* Bus 3 is attached to the DVI port where devices like the pico DLP
 	 * projector don't work reliably with 400kHz */
 	omap_register_i2c_bus(3, 100, beagle_i2c_eeprom, ARRAY_SIZE(beagle_i2c_eeprom));
-#ifdef CONFIG_OF
 	omap_register_i2c_bus(2, 100, NULL, 0);
-#endif /* CONFIG_OF */
 	return 0;
 }
 
@@ -528,10 +525,6 @@ static void __init beagle_opp_init(void)
 
 static void __init omap3_beagle_init(void)
 {
-#ifdef CONFIG_OF
-	of_platform_prepare(NULL, NULL);
-#endif /* CONFIG_OF */
-
 	omap3_mux_init(board_mux, OMAP_PACKAGE_CBB);
 	omap3_beagle_init_rev();
 	omap3_beagle_i2c_init();
@@ -563,11 +556,6 @@ static void __init omap3_beagle_init(void)
 	beagle_opp_init();
 }
 
-static const char *omap3_beagle_dt_match[] __initdata = {
-	"ti,omap3-beagle",
-	NULL
-};
-
 MACHINE_START(OMAP3_BEAGLE, "OMAP3 Beagle Board")
 	/* Maintainer: Syed Mohammed Khasim - http://beagleboard.org */
 	.boot_params	= 0x80000100,
@@ -577,5 +565,4 @@ MACHINE_START(OMAP3_BEAGLE, "OMAP3 Beagle Board")
 	.init_irq	= omap3_beagle_init_irq,
 	.init_machine	= omap3_beagle_init,
 	.timer		= &omap3_secure_timer,
-	.dt_compat	= omap3_beagle_dt_match,
 MACHINE_END
-- 
1.7.0.4

