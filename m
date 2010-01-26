From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 07/14] omap2/3/4: Fix omap2_map_common_io for multi-omap
Date: Tue, 26 Jan 2010 12:12:51 -0800
Message-ID: <20100126201251.15382.42461.stgit@baageli.muru.com>
References: <20100126200646.15382.52167.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:58083 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752644Ab0AZUMb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 26 Jan 2010 15:12:31 -0500
In-Reply-To: <20100126200646.15382.52167.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

Fix omap2_map_common_io for multi-omap

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/board-2430sdp.c        |    2 +
 arch/arm/mach-omap2/board-3430sdp.c        |    2 +
 arch/arm/mach-omap2/board-3630sdp.c        |    2 +
 arch/arm/mach-omap2/board-4430sdp.c        |    2 +
 arch/arm/mach-omap2/board-am3517evm.c      |    2 +
 arch/arm/mach-omap2/board-apollon.c        |    2 +
 arch/arm/mach-omap2/board-cm-t35.c         |    2 +
 arch/arm/mach-omap2/board-generic.c        |    2 +
 arch/arm/mach-omap2/board-h4.c             |    2 +
 arch/arm/mach-omap2/board-igep0020.c       |    2 +
 arch/arm/mach-omap2/board-ldp.c            |    2 +
 arch/arm/mach-omap2/board-n8x0.c           |    2 +
 arch/arm/mach-omap2/board-omap3beagle.c    |    2 +
 arch/arm/mach-omap2/board-omap3evm.c       |    2 +
 arch/arm/mach-omap2/board-omap3pandora.c   |    2 +
 arch/arm/mach-omap2/board-omap3touchbook.c |    2 +
 arch/arm/mach-omap2/board-overo.c          |    2 +
 arch/arm/mach-omap2/board-rx51.c           |    2 +
 arch/arm/mach-omap2/board-zoom2.c          |    2 +
 arch/arm/mach-omap2/board-zoom3.c          |    2 +
 arch/arm/mach-omap2/io.c                   |   51 +++++++++++++++++++---------
 arch/arm/plat-omap/include/plat/io.h       |   33 ++++++++++++++++++
 22 files changed, 86 insertions(+), 38 deletions(-)

diff --git a/arch/arm/mach-omap2/board-2430sdp.c b/arch/arm/mach-omap2/board-2430sdp.c
index e508904..1a61978 100644
--- a/arch/arm/mach-omap2/board-2430sdp.c
+++ b/arch/arm/mach-omap2/board-2430sdp.c
@@ -215,7 +215,7 @@ static void __init omap_2430sdp_init(void)
 static void __init omap_2430sdp_map_io(void)
 {
 	omap2_set_globals_243x();
-	omap2_map_common_io();
+	omap243x_map_common_io();
 }
 
 MACHINE_START(OMAP_2430SDP, "OMAP2430 sdp2430 board")
diff --git a/arch/arm/mach-omap2/board-3430sdp.c b/arch/arm/mach-omap2/board-3430sdp.c
index c90b0d0..eda4f64 100644
--- a/arch/arm/mach-omap2/board-3430sdp.c
+++ b/arch/arm/mach-omap2/board-3430sdp.c
@@ -674,7 +674,7 @@ static void __init omap_3430sdp_init(void)
 static void __init omap_3430sdp_map_io(void)
 {
 	omap2_set_globals_343x();
-	omap2_map_common_io();
+	omap34xx_map_common_io();
 }
 
 MACHINE_START(OMAP_3430SDP, "OMAP3430 3430SDP board")
diff --git a/arch/arm/mach-omap2/board-3630sdp.c b/arch/arm/mach-omap2/board-3630sdp.c
index c178e68..4386d2b 100755
--- a/arch/arm/mach-omap2/board-3630sdp.c
+++ b/arch/arm/mach-omap2/board-3630sdp.c
@@ -69,7 +69,7 @@ static struct ehci_hcd_omap_platform_data ehci_pdata __initconst = {
 static void __init omap_sdp_map_io(void)
 {
 	omap2_set_globals_36xx();
-	omap2_map_common_io();
+	omap34xx_map_common_io();
 }
 
 static struct omap_board_config_kernel sdp_config[] __initdata = {
diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
index 0c6be6b..cc4c00d 100644
--- a/arch/arm/mach-omap2/board-4430sdp.c
+++ b/arch/arm/mach-omap2/board-4430sdp.c
@@ -87,7 +87,7 @@ static void __init omap_4430sdp_init(void)
 static void __init omap_4430sdp_map_io(void)
 {
 	omap2_set_globals_443x();
-	omap2_map_common_io();
+	omap44xx_map_common_io();
 }
 
 MACHINE_START(OMAP_4430SDP, "OMAP4430 4430SDP board")
diff --git a/arch/arm/mach-omap2/board-am3517evm.c b/arch/arm/mach-omap2/board-am3517evm.c
index b4e6eca..3966846 100644
--- a/arch/arm/mach-omap2/board-am3517evm.c
+++ b/arch/arm/mach-omap2/board-am3517evm.c
@@ -83,7 +83,7 @@ static void __init am3517_evm_init(void)
 static void __init am3517_evm_map_io(void)
 {
 	omap2_set_globals_343x();
-	omap2_map_common_io();
+	omap34xx_map_common_io();
 }
 
 MACHINE_START(OMAP3517EVM, "OMAP3517/AM3517 EVM")
diff --git a/arch/arm/mach-omap2/board-apollon.c b/arch/arm/mach-omap2/board-apollon.c
index fbbd68d..aa69fb9 100644
--- a/arch/arm/mach-omap2/board-apollon.c
+++ b/arch/arm/mach-omap2/board-apollon.c
@@ -337,7 +337,7 @@ static void __init omap_apollon_init(void)
 static void __init omap_apollon_map_io(void)
 {
 	omap2_set_globals_242x();
-	omap2_map_common_io();
+	omap242x_map_common_io();
 }
 
 MACHINE_START(OMAP_APOLLON, "OMAP24xx Apollon")
diff --git a/arch/arm/mach-omap2/board-cm-t35.c b/arch/arm/mach-omap2/board-cm-t35.c
index 2626a9f..65c96bc 100644
--- a/arch/arm/mach-omap2/board-cm-t35.c
+++ b/arch/arm/mach-omap2/board-cm-t35.c
@@ -479,7 +479,7 @@ static void __init cm_t35_init_irq(void)
 static void __init cm_t35_map_io(void)
 {
 	omap2_set_globals_343x();
-	omap2_map_common_io();
+	omap34xx_map_common_io();
 }
 
 static struct omap_board_mux board_mux[] __initdata = {
diff --git a/arch/arm/mach-omap2/board-generic.c b/arch/arm/mach-omap2/board-generic.c
index 7e6e6ca..16cc068 100644
--- a/arch/arm/mach-omap2/board-generic.c
+++ b/arch/arm/mach-omap2/board-generic.c
@@ -50,7 +50,7 @@ static void __init omap_generic_init(void)
 static void __init omap_generic_map_io(void)
 {
 	omap2_set_globals_242x(); /* should be 242x, 243x, or 343x */
-	omap2_map_common_io();
+	omap242x_map_common_io();
 }
 
 MACHINE_START(OMAP_GENERIC, "Generic OMAP24xx")
diff --git a/arch/arm/mach-omap2/board-h4.c b/arch/arm/mach-omap2/board-h4.c
index cfb7f12..5c49c40 100644
--- a/arch/arm/mach-omap2/board-h4.c
+++ b/arch/arm/mach-omap2/board-h4.c
@@ -370,7 +370,7 @@ static void __init omap_h4_init(void)
 static void __init omap_h4_map_io(void)
 {
 	omap2_set_globals_242x();
-	omap2_map_common_io();
+	omap242x_map_common_io();
 }
 
 MACHINE_START(OMAP_H4, "OMAP2420 H4 board")
diff --git a/arch/arm/mach-omap2/board-igep0020.c b/arch/arm/mach-omap2/board-igep0020.c
index 117b8fd..9f75433 100644
--- a/arch/arm/mach-omap2/board-igep0020.c
+++ b/arch/arm/mach-omap2/board-igep0020.c
@@ -246,7 +246,7 @@ static void __init igep2_init(void)
 static void __init igep2_map_io(void)
 {
 	omap2_set_globals_343x();
-	omap2_map_common_io();
+	omap34xx_map_common_io();
 }
 
 MACHINE_START(IGEP0020, "IGEP v2 board")
diff --git a/arch/arm/mach-omap2/board-ldp.c b/arch/arm/mach-omap2/board-ldp.c
index 995d4a2..f169967 100644
--- a/arch/arm/mach-omap2/board-ldp.c
+++ b/arch/arm/mach-omap2/board-ldp.c
@@ -404,7 +404,7 @@ static void __init omap_ldp_init(void)
 static void __init omap_ldp_map_io(void)
 {
 	omap2_set_globals_343x();
-	omap2_map_common_io();
+	omap34xx_map_common_io();
 }
 
 MACHINE_START(OMAP_LDP, "OMAP LDP board")
diff --git a/arch/arm/mach-omap2/board-n8x0.c b/arch/arm/mach-omap2/board-n8x0.c
index 764ab1e..9de03f8 100644
--- a/arch/arm/mach-omap2/board-n8x0.c
+++ b/arch/arm/mach-omap2/board-n8x0.c
@@ -99,7 +99,7 @@ static void __init n8x0_onenand_init(void) {}
 static void __init n8x0_map_io(void)
 {
 	omap2_set_globals_242x();
-	omap2_map_common_io();
+	omap242x_map_common_io();
 }
 
 static void __init n8x0_init_irq(void)
diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
index 231cb4e..bf91bf7 100644
--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -455,7 +455,7 @@ static void __init omap3_beagle_init(void)
 static void __init omap3_beagle_map_io(void)
 {
 	omap2_set_globals_343x();
-	omap2_map_common_io();
+	omap34xx_map_common_io();
 }
 
 MACHINE_START(OMAP3_BEAGLE, "OMAP3 Beagle Board")
diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
index 34de178..fde27cf 100644
--- a/arch/arm/mach-omap2/board-omap3evm.c
+++ b/arch/arm/mach-omap2/board-omap3evm.c
@@ -478,7 +478,7 @@ static void __init omap3_evm_init(void)
 static void __init omap3_evm_map_io(void)
 {
 	omap2_set_globals_343x();
-	omap2_map_common_io();
+	omap34xx_map_common_io();
 }
 
 MACHINE_START(OMAP3EVM, "OMAP3 EVM")
diff --git a/arch/arm/mach-omap2/board-omap3pandora.c b/arch/arm/mach-omap2/board-omap3pandora.c
index ef17cf1..bc482ab 100644
--- a/arch/arm/mach-omap2/board-omap3pandora.c
+++ b/arch/arm/mach-omap2/board-omap3pandora.c
@@ -423,7 +423,7 @@ static void __init omap3pandora_init(void)
 static void __init omap3pandora_map_io(void)
 {
 	omap2_set_globals_343x();
-	omap2_map_common_io();
+	omap34xx_map_common_io();
 }
 
 MACHINE_START(OMAP3_PANDORA, "Pandora Handheld Console")
diff --git a/arch/arm/mach-omap2/board-omap3touchbook.c b/arch/arm/mach-omap2/board-omap3touchbook.c
index fe3d22c..63436e9 100644
--- a/arch/arm/mach-omap2/board-omap3touchbook.c
+++ b/arch/arm/mach-omap2/board-omap3touchbook.c
@@ -557,7 +557,7 @@ static void __init omap3_touchbook_init(void)
 static void __init omap3_touchbook_map_io(void)
 {
 	omap2_set_globals_343x();
-	omap2_map_common_io();
+	omap34xx_map_common_io();
 }
 
 MACHINE_START(TOUCHBOOK, "OMAP3 touchbook Board")
diff --git a/arch/arm/mach-omap2/board-overo.c b/arch/arm/mach-omap2/board-overo.c
index d192dd9..61abe09 100644
--- a/arch/arm/mach-omap2/board-overo.c
+++ b/arch/arm/mach-omap2/board-overo.c
@@ -469,7 +469,7 @@ static void __init overo_init(void)
 static void __init overo_map_io(void)
 {
 	omap2_set_globals_343x();
-	omap2_map_common_io();
+	omap34xx_map_common_io();
 }
 
 MACHINE_START(OVERO, "Gumstix Overo")
diff --git a/arch/arm/mach-omap2/board-rx51.c b/arch/arm/mach-omap2/board-rx51.c
index 67bb347..6a49f91 100644
--- a/arch/arm/mach-omap2/board-rx51.c
+++ b/arch/arm/mach-omap2/board-rx51.c
@@ -93,7 +93,7 @@ static void __init rx51_init(void)
 static void __init rx51_map_io(void)
 {
 	omap2_set_globals_343x();
-	omap2_map_common_io();
+	omap34xx_map_common_io();
 }
 
 MACHINE_START(NOKIA_RX51, "Nokia RX-51 board")
diff --git a/arch/arm/mach-omap2/board-zoom2.c b/arch/arm/mach-omap2/board-zoom2.c
index bb87cf7..9a26f84 100644
--- a/arch/arm/mach-omap2/board-zoom2.c
+++ b/arch/arm/mach-omap2/board-zoom2.c
@@ -87,7 +87,7 @@ static void __init omap_zoom2_init(void)
 static void __init omap_zoom2_map_io(void)
 {
 	omap2_set_globals_343x();
-	omap2_map_common_io();
+	omap34xx_map_common_io();
 }
 
 MACHINE_START(OMAP_ZOOM2, "OMAP Zoom2 board")
diff --git a/arch/arm/mach-omap2/board-zoom3.c b/arch/arm/mach-omap2/board-zoom3.c
index 456b690..5e20894 100644
--- a/arch/arm/mach-omap2/board-zoom3.c
+++ b/arch/arm/mach-omap2/board-zoom3.c
@@ -27,7 +27,7 @@
 static void __init omap_zoom_map_io(void)
 {
 	omap2_set_globals_36xx();
-	omap2_map_common_io();
+	omap34xx_map_common_io();
 }
 
 static struct omap_board_config_kernel zoom_config[] __initdata = {
diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index 5a79964..fcae090 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -234,37 +234,54 @@ static struct map_desc omap44xx_io_desc[] __initdata = {
 };
 #endif
 
-void __init omap2_map_common_io(void)
+static void __init _omap2_map_common_io(void)
+{
+	/* Normally devicemaps_init() would flush caches and tlb after
+	 * mdesc->map_io(), but we must also do it here because of the CPU
+	 * revision check below.
+	 */
+	local_flush_tlb_all();
+	flush_cache_all();
+
+	omap2_check_revision();
+	omap_sram_init();
+	omapfb_reserve_sdram();
+	omap_vram_reserve_sdram();
+}
+
+#ifdef CONFIG_ARCH_OMAP2420
+void __init omap242x_map_common_io()
 {
-#if defined(CONFIG_ARCH_OMAP2420)
 	iotable_init(omap24xx_io_desc, ARRAY_SIZE(omap24xx_io_desc));
 	iotable_init(omap242x_io_desc, ARRAY_SIZE(omap242x_io_desc));
+	_omap2_map_common_io();
+}
 #endif
 
-#if defined(CONFIG_ARCH_OMAP2430)
+#ifdef CONFIG_ARCH_OMAP2430
+void __init omap243x_map_common_io()
+{
 	iotable_init(omap24xx_io_desc, ARRAY_SIZE(omap24xx_io_desc));
 	iotable_init(omap243x_io_desc, ARRAY_SIZE(omap243x_io_desc));
+	_omap2_map_common_io();
+}
 #endif
 
-#if defined(CONFIG_ARCH_OMAP34XX)
+#ifdef CONFIG_ARCH_OMAP34XX
+void __init omap34xx_map_common_io()
+{
 	iotable_init(omap34xx_io_desc, ARRAY_SIZE(omap34xx_io_desc));
+	_omap2_map_common_io();
+}
 #endif
 
-#if defined(CONFIG_ARCH_OMAP4)
+#ifdef CONFIG_ARCH_OMAP4
+void __init omap44xx_map_common_io()
+{
 	iotable_init(omap44xx_io_desc, ARRAY_SIZE(omap44xx_io_desc));
-#endif
-	/* Normally devicemaps_init() would flush caches and tlb after
-	 * mdesc->map_io(), but we must also do it here because of the CPU
-	 * revision check below.
-	 */
-	local_flush_tlb_all();
-	flush_cache_all();
-
-	omap2_check_revision();
-	omap_sram_init();
-	omapfb_reserve_sdram();
-	omap_vram_reserve_sdram();
+	_omap2_map_common_io();
 }
+#endif
 
 /*
  * omap2_init_reprogram_sdrc - reprogram SDRC timing parameters
diff --git a/arch/arm/plat-omap/include/plat/io.h b/arch/arm/plat-omap/include/plat/io.h
index a3e7b47..19257bb 100644
--- a/arch/arm/plat-omap/include/plat/io.h
+++ b/arch/arm/plat-omap/include/plat/io.h
@@ -268,7 +268,38 @@ struct omap_sdrc_params;
 extern void omap1_map_common_io(void);
 extern void omap1_init_common_hw(void);
 
-extern void omap2_map_common_io(void);
+#ifdef CONFIG_ARCH_OMAP2420
+extern void omap242x_map_common_io(void);
+#else
+static inline void omap242x_map_common_io(void)
+{
+}
+#endif
+
+#ifdef CONFIG_ARCH_OMAP2430
+extern void omap243x_map_common_io(void);
+#else
+static inline void omap243x_map_common_io(void)
+{
+}
+#endif
+
+#ifdef CONFIG_ARCH_OMAP34XX
+extern void omap34xx_map_common_io(void);
+#else
+static inline void omap34xx_map_common_io(void)
+{
+}
+#endif
+
+#ifdef CONFIG_ARCH_OMAP4
+extern void omap44xx_map_common_io(void);
+#else
+static inline void omap44xx_map_common_io(void)
+{
+}
+#endif
+
 extern void omap2_init_common_hw(struct omap_sdrc_params *sdrc_cs0,
 				 struct omap_sdrc_params *sdrc_cs1);
 

