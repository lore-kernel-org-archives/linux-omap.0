From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 06/13] omap3: Unify omap2_set_globals_3[43,6x]x functions
Date: Thu, 08 Jul 2010 16:54:47 +0300
Message-ID: <20100708135447.26276.33006.stgit@baageli.muru.com>
References: <20100708135342.26276.80936.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:55786 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757896Ab0GHNyx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Jul 2010 09:54:53 -0400
In-Reply-To: <20100708135342.26276.80936.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Kevin Hilman <khilman@deeprootsystems.com>, Sergio Aguirre <saaguirre@ti.com>, linux-omap@vger.kernel.org

From: Sergio Aguirre <saaguirre@ti.com>

The only difference between them is the physical address of the
uart4 port, which is only present in 36xx chips.

We don't really need to care about keeping these 2 functions, since
the decision to use uart4 is more cleanly done later when we do have
access to omap_revision variable.

Signed-off-by: Sergio Aguirre <saaguirre@ti.com>
Acked-by: Kevin Hilman <khilman@deeprootsystems.com>
[tony@atomide.com: added comment for the uart4_phys]
Signed-off-by: Tony Lindgren <tony@atomide.com>
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
index f474a80..e3c2ffd 100644
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
index f267dc0..1942951 100644
--- a/arch/arm/mach-omap2/board-3630sdp.c
+++ b/arch/arm/mach-omap2/board-3630sdp.c
@@ -67,7 +67,7 @@ static const struct ehci_hcd_omap_platform_data ehci_pdata __initconst = {
 
 static void __init omap_sdp_map_io(void)
 {
-	omap2_set_globals_36xx();
+	omap2_set_globals_3xxx();
 	omap34xx_map_common_io();
 }
 
diff --git a/arch/arm/mach-omap2/board-am3517evm.c b/arch/arm/mach-omap2/board-am3517evm.c
index af383a8..f326d59 100644
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
index e679a2c..6692ba0 100644
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
index ca4d521..461635b 100644
--- a/arch/arm/mach-omap2/board-devkit8000.c
+++ b/arch/arm/mach-omap2/board-devkit8000.c
@@ -810,7 +810,7 @@ static void __init devkit8000_init(void)
 
 static void __init devkit8000_map_io(void)
 {
-	omap2_set_globals_343x();
+	omap2_set_globals_3xxx();
 	omap34xx_map_common_io();
 }
 
diff --git a/arch/arm/mach-omap2/board-igep0020.c b/arch/arm/mach-omap2/board-igep0020.c
index d55c57b..7eefbc3 100644
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
index fefd7e6..f7c0a2a 100644
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
index 69b154c..518a3f7 100644
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
index b952610..4056b3c 100644
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
index a58bdef..3c9a630 100644
--- a/arch/arm/mach-omap2/board-omap3pandora.c
+++ b/arch/arm/mach-omap2/board-omap3pandora.c
@@ -702,7 +702,7 @@ static void __init omap3pandora_init(void)
 
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
index 2f5f823..d34742e 100644
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
index 4ceeb56..15b87fd 100644
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
index 1b86b5b..3bd4a8d 100644
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
index 1520a2c..242b9d5 100644
--- a/arch/arm/mach-omap2/board-zoom2.c
+++ b/arch/arm/mach-omap2/board-zoom2.c
@@ -99,7 +99,7 @@ static void __init omap_zoom2_init(void)
 
 static void __init omap_zoom2_map_io(void)
 {
-	omap2_set_globals_343x();
+	omap2_set_globals_3xxx();
 	omap34xx_map_common_io();
 }
 
diff --git a/arch/arm/mach-omap2/board-zoom3.c b/arch/arm/mach-omap2/board-zoom3.c
index 7d17046..171efc1 100644
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
index 219c01e..5d9b0ca 100644
--- a/arch/arm/plat-omap/common.c
+++ b/arch/arm/plat-omap/common.c
@@ -309,19 +309,13 @@ static struct omap_globals omap3_globals = {
 	.uart1_phys	= OMAP3_UART1_BASE,
 	.uart2_phys	= OMAP3_UART2_BASE,
 	.uart3_phys	= OMAP3_UART3_BASE,
+	.uart4_phys	= OMAP3_UART4_BASE,	/* Only on 3630 */
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
index fe83e90..13d0cf9 100644
--- a/arch/arm/plat-omap/include/plat/common.h
+++ b/arch/arm/plat-omap/include/plat/common.h
@@ -56,8 +56,7 @@ struct omap_globals {
 
 void omap2_set_globals_242x(void);
 void omap2_set_globals_243x(void);
-void omap2_set_globals_343x(void);
-void omap2_set_globals_36xx(void);
+void omap2_set_globals_3xxx(void);
 void omap2_set_globals_443x(void);
 
 /* These get called from omap2_set_globals_xxxx(), do not call these */

