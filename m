From: Sergio Aguirre <saaguirre@ti.com>
Subject: [RFC][PATCH] omap3: Unify omap2_set_globals_3[43,6x]x functions
Date: Tue, 29 Jun 2010 15:30:27 -0500
Message-ID: <1277843427-25596-1-git-send-email-saaguirre@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:57832 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755442Ab0F2UcD (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 29 Jun 2010 16:32:03 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Sergio Aguirre <saaguirre@ti.com>

The only difference between them is the physical address of the
uart4 port, which is only present in 36xx chips.

We don't really need to care about keeping these 2 functions, since
the decision to use uart4 is more cleanly done later when we do have
access to omap_revision variable.

Signed-off-by: Sergio Aguirre <saaguirre@ti.com>
---
 arch/arm/mach-omap2/board-3430sdp.c        |    2 +-
 arch/arm/mach-omap2/board-3630sdp.c        |    2 +-
 arch/arm/mach-omap2/board-am3517evm.c      |    2 +-
 arch/arm/mach-omap2/board-cm-t35.c         |    2 +-
 arch/arm/mach-omap2/board-devkit8000.c     |    2 +-
 arch/arm/mach-omap2/board-igep0020.c       |    2 +-
 arch/arm/mach-omap2/board-ldp.c            |    2 +-
 arch/arm/mach-omap2/board-omap3beagle.c    |    2 +-
 arch/arm/mach-omap2/board-omap3evm.c       |    2 +-
 arch/arm/mach-omap2/board-omap3pandora.c   |    2 +-
 arch/arm/mach-omap2/board-omap3stalker.c   |    2 +-
 arch/arm/mach-omap2/board-omap3touchbook.c |    2 +-
 arch/arm/mach-omap2/board-overo.c          |    2 +-
 arch/arm/mach-omap2/board-rx51.c           |    2 +-
 arch/arm/mach-omap2/board-zoom2.c          |    2 +-
 arch/arm/mach-omap2/board-zoom3.c          |    2 +-
 arch/arm/plat-omap/common.c                |   10 ++--------
 arch/arm/plat-omap/include/plat/common.h   |    3 +--
 18 files changed, 19 insertions(+), 26 deletions(-)

diff --git a/arch/arm/mach-omap2/board-3430sdp.c b/arch/arm/mach-omap2/board-3430sdp.c
index dd9c031..4961f3b 100644
--- a/arch/arm/mach-omap2/board-3430sdp.c
+++ b/arch/arm/mach-omap2/board-3430sdp.c
@@ -805,7 +805,7 @@ static void __init omap_3430sdp_init(void)
 
 static void __init omap_3430sdp_map_io(void)
 {
-	omap2_set_globals_343x();
+	omap2_set_globals_3xxx();
 	omap34xx_map_common_io();
 }
 
diff --git a/arch/arm/mach-omap2/board-3630sdp.c b/arch/arm/mach-omap2/board-3630sdp.c
index 57290fb..72c2130 100644
--- a/arch/arm/mach-omap2/board-3630sdp.c
+++ b/arch/arm/mach-omap2/board-3630sdp.c
@@ -68,7 +68,7 @@ static const struct ehci_hcd_omap_platform_data ehci_pdata __initconst = {
 
 static void __init omap_sdp_map_io(void)
 {
-	omap2_set_globals_36xx();
+	omap2_set_globals_3xxx();
 	omap34xx_map_common_io();
 }
 
diff --git a/arch/arm/mach-omap2/board-am3517evm.c b/arch/arm/mach-omap2/board-am3517evm.c
index 7da92de..4356424 100644
--- a/arch/arm/mach-omap2/board-am3517evm.c
+++ b/arch/arm/mach-omap2/board-am3517evm.c
@@ -463,7 +463,7 @@ static void __init am3517_evm_init(void)
 
 static void __init am3517_evm_map_io(void)
 {
-	omap2_set_globals_343x();
+	omap2_set_globals_3xxx();
 	omap34xx_map_common_io();
 }
 
diff --git a/arch/arm/mach-omap2/board-cm-t35.c b/arch/arm/mach-omap2/board-cm-t35.c
index bc4c3f8..6ce30b3 100644
--- a/arch/arm/mach-omap2/board-cm-t35.c
+++ b/arch/arm/mach-omap2/board-cm-t35.c
@@ -710,7 +710,7 @@ static void __init cm_t35_init_irq(void)
 
 static void __init cm_t35_map_io(void)
 {
-	omap2_set_globals_343x();
+	omap2_set_globals_3xxx();
 	omap34xx_map_common_io();
 }
 
diff --git a/arch/arm/mach-omap2/board-devkit8000.c b/arch/arm/mach-omap2/board-devkit8000.c
index 922b746..1164258 100644
--- a/arch/arm/mach-omap2/board-devkit8000.c
+++ b/arch/arm/mach-omap2/board-devkit8000.c
@@ -816,7 +816,7 @@ static void __init devkit8000_init(void)
 
 static void __init devkit8000_map_io(void)
 {
-	omap2_set_globals_343x();
+	omap2_set_globals_3xxx();
 	omap34xx_map_common_io();
 }
 
diff --git a/arch/arm/mach-omap2/board-igep0020.c b/arch/arm/mach-omap2/board-igep0020.c
index 759e39d..a8544ab 100644
--- a/arch/arm/mach-omap2/board-igep0020.c
+++ b/arch/arm/mach-omap2/board-igep0020.c
@@ -534,7 +534,7 @@ static void __init igep2_init(void)
 
 static void __init igep2_map_io(void)
 {
-	omap2_set_globals_343x();
+	omap2_set_globals_3xxx();
 	omap34xx_map_common_io();
 }
 
diff --git a/arch/arm/mach-omap2/board-ldp.c b/arch/arm/mach-omap2/board-ldp.c
index 9cd2669..9bcb182 100644
--- a/arch/arm/mach-omap2/board-ldp.c
+++ b/arch/arm/mach-omap2/board-ldp.c
@@ -408,7 +408,7 @@ static void __init omap_ldp_init(void)
 
 static void __init omap_ldp_map_io(void)
 {
-	omap2_set_globals_343x();
+	omap2_set_globals_3xxx();
 	omap34xx_map_common_io();
 }
 
diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
index 0ab0c26..7b95cc1 100644
--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -509,7 +509,7 @@ static void __init omap3_beagle_init(void)
 
 static void __init omap3_beagle_map_io(void)
 {
-	omap2_set_globals_343x();
+	omap2_set_globals_3xxx();
 	omap34xx_map_common_io();
 }
 
diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
index a3d2e28..65b46d4 100644
--- a/arch/arm/mach-omap2/board-omap3evm.c
+++ b/arch/arm/mach-omap2/board-omap3evm.c
@@ -717,7 +717,7 @@ static void __init omap3_evm_init(void)
 
 static void __init omap3_evm_map_io(void)
 {
-	omap2_set_globals_343x();
+	omap2_set_globals_3xxx();
 	omap34xx_map_common_io();
 }
 
diff --git a/arch/arm/mach-omap2/board-omap3pandora.c b/arch/arm/mach-omap2/board-omap3pandora.c
index c0f4f12..49feae4 100644
--- a/arch/arm/mach-omap2/board-omap3pandora.c
+++ b/arch/arm/mach-omap2/board-omap3pandora.c
@@ -592,7 +592,7 @@ static void __init omap3pandora_init(void)
 
 static void __init omap3pandora_map_io(void)
 {
-	omap2_set_globals_343x();
+	omap2_set_globals_3xxx();
 	omap34xx_map_common_io();
 }
 
diff --git a/arch/arm/mach-omap2/board-omap3stalker.c b/arch/arm/mach-omap2/board-omap3stalker.c
index a04cffd..497d429 100644
--- a/arch/arm/mach-omap2/board-omap3stalker.c
+++ b/arch/arm/mach-omap2/board-omap3stalker.c
@@ -654,7 +654,7 @@ static void __init omap3_stalker_init(void)
 
 static void __init omap3_stalker_map_io(void)
 {
-	omap2_set_globals_343x();
+	omap2_set_globals_3xxx();
 	omap34xx_map_common_io();
 }
 
diff --git a/arch/arm/mach-omap2/board-omap3touchbook.c b/arch/arm/mach-omap2/board-omap3touchbook.c
index f05b867..77a0ace 100644
--- a/arch/arm/mach-omap2/board-omap3touchbook.c
+++ b/arch/arm/mach-omap2/board-omap3touchbook.c
@@ -561,7 +561,7 @@ static void __init omap3_touchbook_init(void)
 
 static void __init omap3_touchbook_map_io(void)
 {
-	omap2_set_globals_343x();
+	omap2_set_globals_3xxx();
 	omap34xx_map_common_io();
 }
 
diff --git a/arch/arm/mach-omap2/board-overo.c b/arch/arm/mach-omap2/board-overo.c
index d05ced5..d62fc19 100644
--- a/arch/arm/mach-omap2/board-overo.c
+++ b/arch/arm/mach-omap2/board-overo.c
@@ -524,7 +524,7 @@ static void __init overo_init(void)
 
 static void __init overo_map_io(void)
 {
-	omap2_set_globals_343x();
+	omap2_set_globals_3xxx();
 	omap34xx_map_common_io();
 }
 
diff --git a/arch/arm/mach-omap2/board-rx51.c b/arch/arm/mach-omap2/board-rx51.c
index 3bd956f..a58e8cb 100644
--- a/arch/arm/mach-omap2/board-rx51.c
+++ b/arch/arm/mach-omap2/board-rx51.c
@@ -143,7 +143,7 @@ static void __init rx51_init(void)
 
 static void __init rx51_map_io(void)
 {
-	omap2_set_globals_343x();
+	omap2_set_globals_3xxx();
 	rx51_video_mem_init();
 	omap34xx_map_common_io();
 }
diff --git a/arch/arm/mach-omap2/board-zoom2.c b/arch/arm/mach-omap2/board-zoom2.c
index ffe188c..3d2deb4 100644
--- a/arch/arm/mach-omap2/board-zoom2.c
+++ b/arch/arm/mach-omap2/board-zoom2.c
@@ -86,7 +86,7 @@ static void __init omap_zoom2_init(void)
 
 static void __init omap_zoom2_map_io(void)
 {
-	omap2_set_globals_343x();
+	omap2_set_globals_3xxx();
 	omap34xx_map_common_io();
 }
 
diff --git a/arch/arm/mach-omap2/board-zoom3.c b/arch/arm/mach-omap2/board-zoom3.c
index 5b605eb..91bc56a 100644
--- a/arch/arm/mach-omap2/board-zoom3.c
+++ b/arch/arm/mach-omap2/board-zoom3.c
@@ -27,7 +27,7 @@
 
 static void __init omap_zoom_map_io(void)
 {
-	omap2_set_globals_36xx();
+	omap2_set_globals_3xxx();
 	omap34xx_map_common_io();
 }
 
diff --git a/arch/arm/plat-omap/common.c b/arch/arm/plat-omap/common.c
index fca73cd..4631766 100644
--- a/arch/arm/plat-omap/common.c
+++ b/arch/arm/plat-omap/common.c
@@ -317,19 +317,13 @@ static struct omap_globals omap3_globals = {
 	.uart1_phys	= OMAP3_UART1_BASE,
 	.uart2_phys	= OMAP3_UART2_BASE,
 	.uart3_phys	= OMAP3_UART3_BASE,
+	.uart4_phys	= OMAP3_UART4_BASE,
 };
 
-void __init omap2_set_globals_343x(void)
+void __init omap2_set_globals_3xxx(void)
 {
 	__omap2_set_globals(&omap3_globals);
 }
-
-void __init omap2_set_globals_36xx(void)
-{
-	omap3_globals.uart4_phys = OMAP3_UART4_BASE;
-
-	__omap2_set_globals(&omap3_globals);
-}
 #endif
 
 #if defined(CONFIG_ARCH_OMAP4)
diff --git a/arch/arm/plat-omap/include/plat/common.h b/arch/arm/plat-omap/include/plat/common.h
index 5e4afbe..962aaeb 100644
--- a/arch/arm/plat-omap/include/plat/common.h
+++ b/arch/arm/plat-omap/include/plat/common.h
@@ -58,8 +58,7 @@ struct omap_globals {
 
 void omap2_set_globals_242x(void);
 void omap2_set_globals_243x(void);
-void omap2_set_globals_343x(void);
-void omap2_set_globals_36xx(void);
+void omap2_set_globals_3xxx(void);
 void omap2_set_globals_443x(void);
 
 /* These get called from omap2_set_globals_xxxx(), do not call these */
-- 
1.6.3.3

