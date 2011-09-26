From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH] ARM: OMAP2+: Use SoC specifc map_io
Date: Mon, 26 Sep 2011 16:16:46 -0700
Message-ID: <20110926231646.GJ6324@atomide.com>
References: <1316809399-19579-1-git-send-email-b-cousson@ti.com>
 <1316809399-19579-2-git-send-email-b-cousson@ti.com>
 <20110923230049.GC6324@atomide.com>
 <20110926231516.GI6324@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:11821 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752627Ab1IZXQv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 26 Sep 2011 19:16:51 -0400
Content-Disposition: inline
In-Reply-To: <20110926231516.GI6324@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: grant.likely@secretlab.ca, paul@pwsan.com, khilman@ti.com, rnayak@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org

There's no longer any need for the board specific
map_io.

Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/mach-omap2/board-2430sdp.c b/arch/arm/mach-omap2/board-2430sdp.c
index 618216c..45dafe2 100644
--- a/arch/arm/mach-omap2/board-2430sdp.c
+++ b/arch/arm/mach-omap2/board-2430sdp.c
@@ -243,17 +243,11 @@ static void __init omap_2430sdp_init(void)
 			 "Secondary LCD backlight");
 }
 
-static void __init omap_2430sdp_map_io(void)
-{
-	omap2_set_globals_243x();
-	omap243x_map_common_io();
-}
-
 MACHINE_START(OMAP_2430SDP, "OMAP2430 sdp2430 board")
 	/* Maintainer: Syed Khasim - Texas Instruments Inc */
 	.boot_params	= 0x80000100,
 	.reserve	= omap_reserve,
-	.map_io		= omap_2430sdp_map_io,
+	.map_io		= omap243x_map_io,
 	.init_early	= omap2430_init_early,
 	.init_irq	= omap2_init_irq,
 	.init_machine	= omap_2430sdp_init,
diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
index ab19d30..44a3e2c 100644
--- a/arch/arm/mach-omap2/board-4430sdp.c
+++ b/arch/arm/mach-omap2/board-4430sdp.c
@@ -825,17 +825,11 @@ static void __init omap_4430sdp_init(void)
 	omap_4430sdp_display_init();
 }
 
-static void __init omap_4430sdp_map_io(void)
-{
-	omap2_set_globals_443x();
-	omap44xx_map_common_io();
-}
-
 MACHINE_START(OMAP_4430SDP, "OMAP4430 4430SDP board")
 	/* Maintainer: Santosh Shilimkar - Texas Instruments Inc */
 	.boot_params	= 0x80000100,
 	.reserve	= omap_reserve,
-	.map_io		= omap_4430sdp_map_io,
+	.map_io		= omap4_map_io,
 	.init_early	= omap4430_init_early,
 	.init_irq	= gic_init_irq,
 	.init_machine	= omap_4430sdp_init,
diff --git a/arch/arm/mach-omap2/board-apollon.c b/arch/arm/mach-omap2/board-apollon.c
index cf546f8..8528436 100644
--- a/arch/arm/mach-omap2/board-apollon.c
+++ b/arch/arm/mach-omap2/board-apollon.c
@@ -337,17 +337,11 @@ static void __init omap_apollon_init(void)
 	omap_sdrc_init(NULL, NULL);
 }
 
-static void __init omap_apollon_map_io(void)
-{
-	omap2_set_globals_242x();
-	omap242x_map_common_io();
-}
-
 MACHINE_START(OMAP_APOLLON, "OMAP24xx Apollon")
 	/* Maintainer: Kyungmin Park <kyungmin.park@samsung.com> */
 	.boot_params	= 0x80000100,
 	.reserve	= omap_reserve,
-	.map_io		= omap_apollon_map_io,
+	.map_io		= omap242x_map_io,
 	.init_early	= omap2420_init_early,
 	.init_irq	= omap2_init_irq,
 	.init_machine	= omap_apollon_init,
diff --git a/arch/arm/mach-omap2/board-h4.c b/arch/arm/mach-omap2/board-h4.c
index 948fde0..fcc5107 100644
--- a/arch/arm/mach-omap2/board-h4.c
+++ b/arch/arm/mach-omap2/board-h4.c
@@ -369,17 +369,11 @@ static void __init omap_h4_init(void)
 	h4_init_flash();
 }
 
-static void __init omap_h4_map_io(void)
-{
-	omap2_set_globals_242x();
-	omap242x_map_common_io();
-}
-
 MACHINE_START(OMAP_H4, "OMAP2420 H4 board")
 	/* Maintainer: Paul Mundt <paul.mundt@nokia.com> */
 	.boot_params	= 0x80000100,
 	.reserve	= omap_reserve,
-	.map_io		= omap_h4_map_io,
+	.map_io		= omap242x_map_io,
 	.init_early	= omap2420_init_early,
 	.init_irq	= omap_h4_init_irq,
 	.init_machine	= omap_h4_init,
diff --git a/arch/arm/mach-omap2/board-n8x0.c b/arch/arm/mach-omap2/board-n8x0.c
index 77a4e19..d1f4a02 100644
--- a/arch/arm/mach-omap2/board-n8x0.c
+++ b/arch/arm/mach-omap2/board-n8x0.c
@@ -616,12 +616,6 @@ static struct i2c_board_info n810_i2c_board_info_2[] __initdata = {
 	},
 };
 
-static void __init n8x0_map_io(void)
-{
-	omap2_set_globals_242x();
-	omap242x_map_common_io();
-}
-
 #ifdef CONFIG_OMAP_MUX
 static struct omap_board_mux board_mux[] __initdata = {
 	/* I2S codec port pins for McBSP block */
@@ -692,7 +686,7 @@ static void __init n8x0_init_machine(void)
 MACHINE_START(NOKIA_N800, "Nokia N800")
 	.boot_params	= 0x80000100,
 	.reserve	= omap_reserve,
-	.map_io		= n8x0_map_io,
+	.map_io		= omap242x_map_io,
 	.init_early	= omap2420_init_early,
 	.init_irq	= omap2_init_irq,
 	.init_machine	= n8x0_init_machine,
@@ -702,7 +696,7 @@ MACHINE_END
 MACHINE_START(NOKIA_N810, "Nokia N810")
 	.boot_params	= 0x80000100,
 	.reserve	= omap_reserve,
-	.map_io		= n8x0_map_io,
+	.map_io		= omap242x_map_io,
 	.init_early	= omap2420_init_early,
 	.init_irq	= omap2_init_irq,
 	.init_machine	= n8x0_init_machine,
@@ -712,7 +706,7 @@ MACHINE_END
 MACHINE_START(NOKIA_N810_WIMAX, "Nokia N810 WiMAX")
 	.boot_params	= 0x80000100,
 	.reserve	= omap_reserve,
-	.map_io		= n8x0_map_io,
+	.map_io		= omap242x_map_io,
 	.init_early	= omap2420_init_early,
 	.init_irq	= omap2_init_irq,
 	.init_machine	= n8x0_init_machine,
diff --git a/arch/arm/mach-omap2/board-omap4panda.c b/arch/arm/mach-omap2/board-omap4panda.c
index 1bce765..e269290 100644
--- a/arch/arm/mach-omap2/board-omap4panda.c
+++ b/arch/arm/mach-omap2/board-omap4panda.c
@@ -570,17 +570,11 @@ static void __init omap4_panda_init(void)
 	omap4_panda_display_init();
 }
 
-static void __init omap4_panda_map_io(void)
-{
-	omap2_set_globals_443x();
-	omap44xx_map_common_io();
-}
-
 MACHINE_START(OMAP4_PANDA, "OMAP4 Panda board")
 	/* Maintainer: David Anders - Texas Instruments Inc */
 	.boot_params	= 0x80000100,
 	.reserve	= omap_reserve,
-	.map_io		= omap4_panda_map_io,
+	.map_io		= omap4_map_io,
 	.init_early	= omap4430_init_early,
 	.init_irq	= gic_init_irq,
 	.init_machine	= omap4_panda_init,
diff --git a/arch/arm/mach-omap2/board-rm680.c b/arch/arm/mach-omap2/board-rm680.c
index a3182e8..a98db61 100644
--- a/arch/arm/mach-omap2/board-rm680.c
+++ b/arch/arm/mach-omap2/board-rm680.c
@@ -143,16 +143,10 @@ static void __init rm680_init(void)
 	rm680_peripherals_init();
 }
 
-static void __init rm680_map_io(void)
-{
-	omap2_set_globals_3xxx();
-	omap34xx_map_common_io();
-}
-
 MACHINE_START(NOKIA_RM680, "Nokia RM-680 board")
 	.boot_params	= 0x80000100,
 	.reserve	= omap_reserve,
-	.map_io		= rm680_map_io,
+	.map_io		= omap3_map_io,
 	.init_early	= omap3630_init_early,
 	.init_irq	= omap3_init_irq,
 	.init_machine	= rm680_init,
diff --git a/arch/arm/mach-omap2/board-rx51.c b/arch/arm/mach-omap2/board-rx51.c
index 32a79e2..8677a06 100644
--- a/arch/arm/mach-omap2/board-rx51.c
+++ b/arch/arm/mach-omap2/board-rx51.c
@@ -139,12 +139,6 @@ static void __init rx51_init(void)
 	platform_device_register(&leds_gpio);
 }
 
-static void __init rx51_map_io(void)
-{
-	omap2_set_globals_3xxx();
-	omap34xx_map_common_io();
-}
-
 static void __init rx51_reserve(void)
 {
 	rx51_video_mem_init();
@@ -155,7 +149,7 @@ MACHINE_START(NOKIA_RX51, "Nokia RX-51 board")
 	/* Maintainer: Lauri Leukkunen <lauri.leukkunen@nokia.com> */
 	.boot_params	= 0x80000100,
 	.reserve	= rx51_reserve,
-	.map_io		= rx51_map_io,
+	.map_io		= omap3_map_io,
 	.init_early	= omap3430_init_early,
 	.init_irq	= omap3_init_irq,
 	.init_machine	= rx51_init,
