From: Mike Rapoport <mike@compulab.co.il>
Subject: [PATCH] omap3: introduce omap3_map_io
Date: Wed, 30 Jun 2010 11:47:52 +0300
Message-ID: <1277887672-9457-1-git-send-email-mike@compulab.co.il>
References: <20100630063646.GS2822@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from compulab.co.il ([67.18.134.219]:51181 "EHLO compulab.co.il"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751964Ab0F3IvT (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 30 Jun 2010 04:51:19 -0400
In-Reply-To: <20100630063646.GS2822@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
Cc: linux-omap@vger.kernel.org, Mike Rapoport <mike@compulab.co.il>, Sergio Aguirre <saaguirre@ti.com>, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@deeprootsystems.com>

Hi Tony,
Here's the patch. It applies on top of Sergio's patch "Unify 
omap2_set_globals_3[43,6x]x functions".

---
Most OMAP3-based boards use exactly the same code for .map_io method in
the machine_desc structure.
This patch introduces omap3_map_io and updates board-* files to use it
as .map_io method.

Signed-off-by: Mike Rapoport <mike@compulab.co.il>
CC: Sergio Aguirre <saaguirre@ti.com>
CC: Tony Lindgren <tony@atomide.com>
CC: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/board-3430sdp.c        |    8 +-------
 arch/arm/mach-omap2/board-3630sdp.c        |    8 +-------
 arch/arm/mach-omap2/board-am3517evm.c      |    8 +-------
 arch/arm/mach-omap2/board-cm-t35.c         |    8 +-------
 arch/arm/mach-omap2/board-devkit8000.c     |    8 +-------
 arch/arm/mach-omap2/board-igep0020.c       |    8 +-------
 arch/arm/mach-omap2/board-ldp.c            |    8 +-------
 arch/arm/mach-omap2/board-omap3beagle.c    |    8 +-------
 arch/arm/mach-omap2/board-omap3evm.c       |    8 +-------
 arch/arm/mach-omap2/board-omap3pandora.c   |    8 +-------
 arch/arm/mach-omap2/board-omap3stalker.c   |    8 +-------
 arch/arm/mach-omap2/board-omap3touchbook.c |    8 +-------
 arch/arm/mach-omap2/board-overo.c          |    8 +-------
 arch/arm/mach-omap2/board-zoom2.c          |    8 +-------
 arch/arm/mach-omap2/board-zoom3.c          |    8 +-------
 arch/arm/plat-omap/common.c                |    6 ++++++
 arch/arm/plat-omap/include/plat/common.h   |    2 ++
 17 files changed, 23 insertions(+), 105 deletions(-)

diff --git a/arch/arm/mach-omap2/board-3430sdp.c b/arch/arm/mach-omap2/board-3430sdp.c
index 4961f3b..ecdd2c3 100644
--- a/arch/arm/mach-omap2/board-3430sdp.c
+++ b/arch/arm/mach-omap2/board-3430sdp.c
@@ -803,18 +803,12 @@ static void __init omap_3430sdp_init(void)
 	usb_ehci_init(&ehci_pdata);
 }
 
-static void __init omap_3430sdp_map_io(void)
-{
-	omap2_set_globals_3xxx();
-	omap34xx_map_common_io();
-}
-
 MACHINE_START(OMAP_3430SDP, "OMAP3430 3430SDP board")
 	/* Maintainer: Syed Khasim - Texas Instruments Inc */
 	.phys_io	= 0x48000000,
 	.io_pg_offst	= ((0xfa000000) >> 18) & 0xfffc,
 	.boot_params	= 0x80000100,
-	.map_io		= omap_3430sdp_map_io,
+	.map_io		= omap3_map_io,
 	.reserve	= omap_reserve,
 	.init_irq	= omap_3430sdp_init_irq,
 	.init_machine	= omap_3430sdp_init,
diff --git a/arch/arm/mach-omap2/board-3630sdp.c b/arch/arm/mach-omap2/board-3630sdp.c
index 72c2130..59860df 100644
--- a/arch/arm/mach-omap2/board-3630sdp.c
+++ b/arch/arm/mach-omap2/board-3630sdp.c
@@ -66,12 +66,6 @@ static const struct ehci_hcd_omap_platform_data ehci_pdata __initconst = {
 	.reset_gpio_port[2]  = -EINVAL
 };
 
-static void __init omap_sdp_map_io(void)
-{
-	omap2_set_globals_3xxx();
-	omap34xx_map_common_io();
-}
-
 static struct omap_board_config_kernel sdp_config[] __initdata = {
 };
 
@@ -107,7 +101,7 @@ MACHINE_START(OMAP_3630SDP, "OMAP 3630SDP board")
 	.phys_io	= 0x48000000,
 	.io_pg_offst	= ((0xfa000000) >> 18) & 0xfffc,
 	.boot_params	= 0x80000100,
-	.map_io		= omap_sdp_map_io,
+	.map_io		= omap3_map_io,
 	.reserve	= omap_reserve,
 	.init_irq	= omap_sdp_init_irq,
 	.init_machine	= omap_sdp_init,
diff --git a/arch/arm/mach-omap2/board-am3517evm.c b/arch/arm/mach-omap2/board-am3517evm.c
index 4356424..4d0f585 100644
--- a/arch/arm/mach-omap2/board-am3517evm.c
+++ b/arch/arm/mach-omap2/board-am3517evm.c
@@ -461,17 +461,11 @@ static void __init am3517_evm_init(void)
 	am3517_evm_ethernet_init(&am3517_evm_emac_pdata);
 }
 
-static void __init am3517_evm_map_io(void)
-{
-	omap2_set_globals_3xxx();
-	omap34xx_map_common_io();
-}
-
 MACHINE_START(OMAP3517EVM, "OMAP3517/AM3517 EVM")
 	.phys_io	= 0x48000000,
 	.io_pg_offst	= ((0xd8000000) >> 18) & 0xfffc,
 	.boot_params	= 0x80000100,
-	.map_io		= am3517_evm_map_io,
+	.map_io		= omap3_map_io,
 	.reserve	= omap_reserve,
 	.init_irq	= am3517_evm_init_irq,
 	.init_machine	= am3517_evm_init,
diff --git a/arch/arm/mach-omap2/board-cm-t35.c b/arch/arm/mach-omap2/board-cm-t35.c
index 6ce30b3..b910f72 100644
--- a/arch/arm/mach-omap2/board-cm-t35.c
+++ b/arch/arm/mach-omap2/board-cm-t35.c
@@ -708,12 +708,6 @@ static void __init cm_t35_init_irq(void)
 	omap_gpio_init();
 }
 
-static void __init cm_t35_map_io(void)
-{
-	omap2_set_globals_3xxx();
-	omap34xx_map_common_io();
-}
-
 static struct omap_board_mux board_mux[] __initdata = {
 	/* nCS and IRQ for CM-T35 ethernet */
 	OMAP3_MUX(GPMC_NCS5, OMAP_MUX_MODE0),
@@ -836,7 +830,7 @@ MACHINE_START(CM_T35, "Compulab CM-T35")
 	.phys_io	= 0x48000000,
 	.io_pg_offst	= ((0xd8000000) >> 18) & 0xfffc,
 	.boot_params	= 0x80000100,
-	.map_io		= cm_t35_map_io,
+	.map_io		= omap3_map_io,
 	.reserve	= omap_reserve,
 	.init_irq	= cm_t35_init_irq,
 	.init_machine	= cm_t35_init,
diff --git a/arch/arm/mach-omap2/board-devkit8000.c b/arch/arm/mach-omap2/board-devkit8000.c
index 1164258..8233dd5 100644
--- a/arch/arm/mach-omap2/board-devkit8000.c
+++ b/arch/arm/mach-omap2/board-devkit8000.c
@@ -814,17 +814,11 @@ static void __init devkit8000_init(void)
 	omap_mux_init_signal("sdrc_cke1", OMAP_PIN_OUTPUT);
 }
 
-static void __init devkit8000_map_io(void)
-{
-	omap2_set_globals_3xxx();
-	omap34xx_map_common_io();
-}
-
 MACHINE_START(DEVKIT8000, "OMAP3 Devkit8000")
 	.phys_io	= 0x48000000,
 	.io_pg_offst	= ((0xd8000000) >> 18) & 0xfffc,
 	.boot_params	= 0x80000100,
-	.map_io		= devkit8000_map_io,
+	.map_io		= omap3_map_io,
 	.reserve	= omap_reserve,
 	.init_irq	= devkit8000_init_irq,
 	.init_machine	= devkit8000_init,
diff --git a/arch/arm/mach-omap2/board-igep0020.c b/arch/arm/mach-omap2/board-igep0020.c
index a8544ab..175f043 100644
--- a/arch/arm/mach-omap2/board-igep0020.c
+++ b/arch/arm/mach-omap2/board-igep0020.c
@@ -532,17 +532,11 @@ static void __init igep2_init(void)
 		pr_warning("IGEP v2: Could not obtain gpio GPIO_WIFI_NRESET\n");
 }
 
-static void __init igep2_map_io(void)
-{
-	omap2_set_globals_3xxx();
-	omap34xx_map_common_io();
-}
-
 MACHINE_START(IGEP0020, "IGEP v2 board")
 	.phys_io	= 0x48000000,
 	.io_pg_offst	= ((0xfa000000) >> 18) & 0xfffc,
 	.boot_params	= 0x80000100,
-	.map_io		= igep2_map_io,
+	.map_io		= omap3_map_io,
 	.reserve	= omap_reserve,
 	.init_irq	= igep2_init_irq,
 	.init_machine	= igep2_init,
diff --git a/arch/arm/mach-omap2/board-ldp.c b/arch/arm/mach-omap2/board-ldp.c
index 9bcb182..07e1f73 100644
--- a/arch/arm/mach-omap2/board-ldp.c
+++ b/arch/arm/mach-omap2/board-ldp.c
@@ -406,17 +406,11 @@ static void __init omap_ldp_init(void)
 	ldp_vmmc1_supply.dev = mmc[0].dev;
 }
 
-static void __init omap_ldp_map_io(void)
-{
-	omap2_set_globals_3xxx();
-	omap34xx_map_common_io();
-}
-
 MACHINE_START(OMAP_LDP, "OMAP LDP board")
 	.phys_io	= 0x48000000,
 	.io_pg_offst	= ((0xfa000000) >> 18) & 0xfffc,
 	.boot_params	= 0x80000100,
-	.map_io		= omap_ldp_map_io,
+	.map_io		= omap3_map_io,
 	.reserve	= omap_reserve,
 	.init_irq	= omap_ldp_init_irq,
 	.init_machine	= omap_ldp_init,
diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
index 7b95cc1..6a6d2d7 100644
--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -507,18 +507,12 @@ static void __init omap3_beagle_init(void)
 	beagle_display_init();
 }
 
-static void __init omap3_beagle_map_io(void)
-{
-	omap2_set_globals_3xxx();
-	omap34xx_map_common_io();
-}
-
 MACHINE_START(OMAP3_BEAGLE, "OMAP3 Beagle Board")
 	/* Maintainer: Syed Mohammed Khasim - http://beagleboard.org */
 	.phys_io	= 0x48000000,
 	.io_pg_offst	= ((0xfa000000) >> 18) & 0xfffc,
 	.boot_params	= 0x80000100,
-	.map_io		= omap3_beagle_map_io,
+	.map_io		= omap3_map_io,
 	.reserve	= omap_reserve,
 	.init_irq	= omap3_beagle_init_irq,
 	.init_machine	= omap3_beagle_init,
diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
index 65b46d4..6494dbd 100644
--- a/arch/arm/mach-omap2/board-omap3evm.c
+++ b/arch/arm/mach-omap2/board-omap3evm.c
@@ -715,18 +715,12 @@ static void __init omap3_evm_init(void)
 	omap3_evm_display_init();
 }
 
-static void __init omap3_evm_map_io(void)
-{
-	omap2_set_globals_3xxx();
-	omap34xx_map_common_io();
-}
-
 MACHINE_START(OMAP3EVM, "OMAP3 EVM")
 	/* Maintainer: Syed Mohammed Khasim - Texas Instruments */
 	.phys_io	= 0x48000000,
 	.io_pg_offst	= ((0xfa000000) >> 18) & 0xfffc,
 	.boot_params	= 0x80000100,
-	.map_io		= omap3_evm_map_io,
+	.map_io		= omap3_map_io,
 	.reserve	= omap_reserve,
 	.init_irq	= omap3_evm_init_irq,
 	.init_machine	= omap3_evm_init,
diff --git a/arch/arm/mach-omap2/board-omap3pandora.c b/arch/arm/mach-omap2/board-omap3pandora.c
index 49feae4..4ac146b 100644
--- a/arch/arm/mach-omap2/board-omap3pandora.c
+++ b/arch/arm/mach-omap2/board-omap3pandora.c
@@ -590,17 +590,11 @@ static void __init omap3pandora_init(void)
 	omap_mux_init_signal("sdrc_cke1", OMAP_PIN_OUTPUT);
 }
 
-static void __init omap3pandora_map_io(void)
-{
-	omap2_set_globals_3xxx();
-	omap34xx_map_common_io();
-}
-
 MACHINE_START(OMAP3_PANDORA, "Pandora Handheld Console")
 	.phys_io	= 0x48000000,
 	.io_pg_offst	= ((0xfa000000) >> 18) & 0xfffc,
 	.boot_params	= 0x80000100,
-	.map_io		= omap3pandora_map_io,
+	.map_io		= omap3_map_io,
 	.reserve	= omap_reserve,
 	.init_irq	= omap3pandora_init_irq,
 	.init_machine	= omap3pandora_init,
diff --git a/arch/arm/mach-omap2/board-omap3stalker.c b/arch/arm/mach-omap2/board-omap3stalker.c
index 497d429..bcd01d2 100644
--- a/arch/arm/mach-omap2/board-omap3stalker.c
+++ b/arch/arm/mach-omap2/board-omap3stalker.c
@@ -652,18 +652,12 @@ static void __init omap3_stalker_init(void)
 	omap_mux_init_signal("sdr_cke1", OMAP_PIN_OUTPUT);
 }
 
-static void __init omap3_stalker_map_io(void)
-{
-	omap2_set_globals_3xxx();
-	omap34xx_map_common_io();
-}
-
 MACHINE_START(SBC3530, "OMAP3 STALKER")
 	/* Maintainer: Jason Lam -lzg@ema-tech.com */
 	.phys_io		= 0x48000000,
 	.io_pg_offst		= ((0xfa000000) >> 18) & 0xfffc,
 	.boot_params		= 0x80000100,
-	.map_io			= omap3_stalker_map_io,
+	.map_io			= omap3_map_io,
 	.init_irq		= omap3_stalker_init_irq,
 	.init_machine		= omap3_stalker_init,
 	.timer			= &omap_timer,
diff --git a/arch/arm/mach-omap2/board-omap3touchbook.c b/arch/arm/mach-omap2/board-omap3touchbook.c
index 77a0ace..69d431b 100644
--- a/arch/arm/mach-omap2/board-omap3touchbook.c
+++ b/arch/arm/mach-omap2/board-omap3touchbook.c
@@ -559,18 +559,12 @@ static void __init omap3_touchbook_init(void)
 	omap_mux_init_signal("sdrc_cke1", OMAP_PIN_OUTPUT);
 }
 
-static void __init omap3_touchbook_map_io(void)
-{
-	omap2_set_globals_3xxx();
-	omap34xx_map_common_io();
-}
-
 MACHINE_START(TOUCHBOOK, "OMAP3 touchbook Board")
 	/* Maintainer: Gregoire Gentil - http://www.alwaysinnovating.com */
 	.phys_io	= 0x48000000,
 	.io_pg_offst	= ((0xd8000000) >> 18) & 0xfffc,
 	.boot_params	= 0x80000100,
-	.map_io		= omap3_touchbook_map_io,
+	.map_io		= omap3_map_io,
 	.reserve	= omap_reserve,
 	.init_irq	= omap3_touchbook_init_irq,
 	.init_machine	= omap3_touchbook_init,
diff --git a/arch/arm/mach-omap2/board-overo.c b/arch/arm/mach-omap2/board-overo.c
index d62fc19..c1bbb48 100644
--- a/arch/arm/mach-omap2/board-overo.c
+++ b/arch/arm/mach-omap2/board-overo.c
@@ -522,17 +522,11 @@ static void __init overo_init(void)
 					"OVERO_GPIO_USBH_CPEN\n");
 }
 
-static void __init overo_map_io(void)
-{
-	omap2_set_globals_3xxx();
-	omap34xx_map_common_io();
-}
-
 MACHINE_START(OVERO, "Gumstix Overo")
 	.phys_io	= 0x48000000,
 	.io_pg_offst	= ((0xfa000000) >> 18) & 0xfffc,
 	.boot_params	= 0x80000100,
-	.map_io		= overo_map_io,
+	.map_io		= omap3_map_io,
 	.reserve	= omap_reserve,
 	.init_irq	= overo_init_irq,
 	.init_machine	= overo_init,
diff --git a/arch/arm/mach-omap2/board-zoom2.c b/arch/arm/mach-omap2/board-zoom2.c
index 3d2deb4..161f729 100644
--- a/arch/arm/mach-omap2/board-zoom2.c
+++ b/arch/arm/mach-omap2/board-zoom2.c
@@ -84,17 +84,11 @@ static void __init omap_zoom2_init(void)
 	zoom_debugboard_init();
 }
 
-static void __init omap_zoom2_map_io(void)
-{
-	omap2_set_globals_3xxx();
-	omap34xx_map_common_io();
-}
-
 MACHINE_START(OMAP_ZOOM2, "OMAP Zoom2 board")
 	.phys_io	= ZOOM_UART_BASE,
 	.io_pg_offst	= (ZOOM_UART_VIRT >> 18) & 0xfffc,
 	.boot_params	= 0x80000100,
-	.map_io		= omap_zoom2_map_io,
+	.map_io		= omap3_map_io,
 	.reserve	= omap_reserve,
 	.init_irq	= omap_zoom2_init_irq,
 	.init_machine	= omap_zoom2_init,
diff --git a/arch/arm/mach-omap2/board-zoom3.c b/arch/arm/mach-omap2/board-zoom3.c
index 91bc56a..ca9a79a 100644
--- a/arch/arm/mach-omap2/board-zoom3.c
+++ b/arch/arm/mach-omap2/board-zoom3.c
@@ -25,12 +25,6 @@
 #include "mux.h"
 #include "sdram-hynix-h8mbx00u0mer-0em.h"
 
-static void __init omap_zoom_map_io(void)
-{
-	omap2_set_globals_3xxx();
-	omap34xx_map_common_io();
-}
-
 static struct omap_board_config_kernel zoom_config[] __initdata = {
 };
 
@@ -76,7 +70,7 @@ MACHINE_START(OMAP_ZOOM3, "OMAP Zoom3 board")
 	.phys_io	= ZOOM_UART_BASE,
 	.io_pg_offst	= (ZOOM_UART_VIRT >> 18) & 0xfffc,
 	.boot_params	= 0x80000100,
-	.map_io		= omap_zoom_map_io,
+	.map_io		= omap3_map_io,
 	.reserve	= omap_reserve,
 	.init_irq	= omap_zoom_init_irq,
 	.init_machine	= omap_zoom_init,
diff --git a/arch/arm/plat-omap/common.c b/arch/arm/plat-omap/common.c
index 4631766..147529d 100644
--- a/arch/arm/plat-omap/common.c
+++ b/arch/arm/plat-omap/common.c
@@ -324,6 +324,12 @@ void __init omap2_set_globals_3xxx(void)
 {
 	__omap2_set_globals(&omap3_globals);
 }
+
+void __init omap3_map_io(void)
+{
+	omap2_set_globals_3xxx();
+	omap34xx_map_common_io();
+}
 #endif
 
 #if defined(CONFIG_ARCH_OMAP4)
diff --git a/arch/arm/plat-omap/include/plat/common.h b/arch/arm/plat-omap/include/plat/common.h
index 962aaeb..e9cf3da 100644
--- a/arch/arm/plat-omap/include/plat/common.h
+++ b/arch/arm/plat-omap/include/plat/common.h
@@ -68,6 +68,8 @@ void omap2_set_globals_control(struct omap_globals *);
 void omap2_set_globals_prcm(struct omap_globals *);
 void omap2_set_globals_uart(struct omap_globals *);
 
+void omap3_map_io(void);
+
 /**
  * omap_test_timeout - busy-loop, testing a condition
  * @cond: condition to test until it evaluates to true
-- 
1.6.6.2

