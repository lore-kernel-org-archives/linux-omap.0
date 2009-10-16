From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 13/14] omap: Fix DEBUG_LL UART io address
Date: Fri, 16 Oct 2009 16:42:36 -0700
Message-ID: <20091016234236.2463.84720.stgit@localhost>
References: <20091016233624.2463.26653.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:61812 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751011AbZJPXmd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 Oct 2009 19:42:33 -0400
In-Reply-To: <20091016233624.2463.26653.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org, Santosh Shilimkar <santosh.shilimkar@ti.com>

From: Santosh Shilimkar <santosh.shilimkar@ti.com>

This patch fixes the low level debug UART io address as per this series.
The change is essential to have CONFIG_DEBUG_LL working.

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/board-2430sdp.c           |    2 +-
 arch/arm/mach-omap2/board-3430sdp.c           |    2 +-
 arch/arm/mach-omap2/board-4430sdp.c           |    2 +-
 arch/arm/mach-omap2/board-apollon.c           |    2 +-
 arch/arm/mach-omap2/board-generic.c           |    2 +-
 arch/arm/mach-omap2/board-h4.c                |    2 +-
 arch/arm/mach-omap2/board-ldp.c               |    2 +-
 arch/arm/mach-omap2/board-n8x0.c              |    6 +++---
 arch/arm/mach-omap2/board-omap3beagle.c       |    2 +-
 arch/arm/mach-omap2/board-omap3evm.c          |    2 +-
 arch/arm/mach-omap2/board-omap3pandora.c      |    2 +-
 arch/arm/mach-omap2/board-overo.c             |    2 +-
 arch/arm/mach-omap2/board-rx51.c              |    2 +-
 arch/arm/mach-omap2/board-zoom2.c             |    2 +-
 arch/arm/plat-omap/include/mach/debug-macro.S |    4 ++--
 15 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/arch/arm/mach-omap2/board-2430sdp.c b/arch/arm/mach-omap2/board-2430sdp.c
index 42217b3..e032a33 100644
--- a/arch/arm/mach-omap2/board-2430sdp.c
+++ b/arch/arm/mach-omap2/board-2430sdp.c
@@ -221,7 +221,7 @@ static void __init omap_2430sdp_map_io(void)
 MACHINE_START(OMAP_2430SDP, "OMAP2430 sdp2430 board")
 	/* Maintainer: Syed Khasim - Texas Instruments Inc */
 	.phys_io	= 0x48000000,
-	.io_pg_offst	= ((0xd8000000) >> 18) & 0xfffc,
+	.io_pg_offst	= ((0xfa000000) >> 18) & 0xfffc,
 	.boot_params	= 0x80000100,
 	.map_io		= omap_2430sdp_map_io,
 	.init_irq	= omap_2430sdp_init_irq,
diff --git a/arch/arm/mach-omap2/board-3430sdp.c b/arch/arm/mach-omap2/board-3430sdp.c
index efaf053..364ce7e 100644
--- a/arch/arm/mach-omap2/board-3430sdp.c
+++ b/arch/arm/mach-omap2/board-3430sdp.c
@@ -511,7 +511,7 @@ static void __init omap_3430sdp_map_io(void)
 MACHINE_START(OMAP_3430SDP, "OMAP3430 3430SDP board")
 	/* Maintainer: Syed Khasim - Texas Instruments Inc */
 	.phys_io	= 0x48000000,
-	.io_pg_offst	= ((0xd8000000) >> 18) & 0xfffc,
+	.io_pg_offst	= ((0xfa000000) >> 18) & 0xfffc,
 	.boot_params	= 0x80000100,
 	.map_io		= omap_3430sdp_map_io,
 	.init_irq	= omap_3430sdp_init_irq,
diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
index 2a7b901..50a62f2 100644
--- a/arch/arm/mach-omap2/board-4430sdp.c
+++ b/arch/arm/mach-omap2/board-4430sdp.c
@@ -93,7 +93,7 @@ static void __init omap_4430sdp_map_io(void)
 MACHINE_START(OMAP_4430SDP, "OMAP4430 4430SDP board")
 	/* Maintainer: Santosh Shilimkar - Texas Instruments Inc */
 	.phys_io	= 0x48000000,
-	.io_pg_offst	= ((0xd8000000) >> 18) & 0xfffc,
+	.io_pg_offst	= ((0xfa000000) >> 18) & 0xfffc,
 	.boot_params	= 0x80000100,
 	.map_io		= omap_4430sdp_map_io,
 	.init_irq	= omap_4430sdp_init_irq,
diff --git a/arch/arm/mach-omap2/board-apollon.c b/arch/arm/mach-omap2/board-apollon.c
index a113228..e8a0e56 100644
--- a/arch/arm/mach-omap2/board-apollon.c
+++ b/arch/arm/mach-omap2/board-apollon.c
@@ -333,7 +333,7 @@ static void __init omap_apollon_map_io(void)
 MACHINE_START(OMAP_APOLLON, "OMAP24xx Apollon")
 	/* Maintainer: Kyungmin Park <kyungmin.park@samsung.com> */
 	.phys_io	= 0x48000000,
-	.io_pg_offst	= ((0xd8000000) >> 18) & 0xfffc,
+	.io_pg_offst	= ((0xfa000000) >> 18) & 0xfffc,
 	.boot_params	= 0x80000100,
 	.map_io		= omap_apollon_map_io,
 	.init_irq	= omap_apollon_init_irq,
diff --git a/arch/arm/mach-omap2/board-generic.c b/arch/arm/mach-omap2/board-generic.c
index 2e09a1c..1a139c0 100644
--- a/arch/arm/mach-omap2/board-generic.c
+++ b/arch/arm/mach-omap2/board-generic.c
@@ -56,7 +56,7 @@ static void __init omap_generic_map_io(void)
 MACHINE_START(OMAP_GENERIC, "Generic OMAP24xx")
 	/* Maintainer: Paul Mundt <paul.mundt@nokia.com> */
 	.phys_io	= 0x48000000,
-	.io_pg_offst	= ((0xd8000000) >> 18) & 0xfffc,
+	.io_pg_offst	= ((0xfa000000) >> 18) & 0xfffc,
 	.boot_params	= 0x80000100,
 	.map_io		= omap_generic_map_io,
 	.init_irq	= omap_generic_init_irq,
diff --git a/arch/arm/mach-omap2/board-h4.c b/arch/arm/mach-omap2/board-h4.c
index eaa02d0..86f78f3 100644
--- a/arch/arm/mach-omap2/board-h4.c
+++ b/arch/arm/mach-omap2/board-h4.c
@@ -376,7 +376,7 @@ static void __init omap_h4_map_io(void)
 MACHINE_START(OMAP_H4, "OMAP2420 H4 board")
 	/* Maintainer: Paul Mundt <paul.mundt@nokia.com> */
 	.phys_io	= 0x48000000,
-	.io_pg_offst	= ((0xd8000000) >> 18) & 0xfffc,
+	.io_pg_offst	= ((0xfa000000) >> 18) & 0xfffc,
 	.boot_params	= 0x80000100,
 	.map_io		= omap_h4_map_io,
 	.init_irq	= omap_h4_init_irq,
diff --git a/arch/arm/mach-omap2/board-ldp.c b/arch/arm/mach-omap2/board-ldp.c
index d110a7f..4ccc01a 100644
--- a/arch/arm/mach-omap2/board-ldp.c
+++ b/arch/arm/mach-omap2/board-ldp.c
@@ -399,7 +399,7 @@ static void __init omap_ldp_map_io(void)
 
 MACHINE_START(OMAP_LDP, "OMAP LDP board")
 	.phys_io	= 0x48000000,
-	.io_pg_offst	= ((0xd8000000) >> 18) & 0xfffc,
+	.io_pg_offst	= ((0xfa000000) >> 18) & 0xfffc,
 	.boot_params	= 0x80000100,
 	.map_io		= omap_ldp_map_io,
 	.init_irq	= omap_ldp_init_irq,
diff --git a/arch/arm/mach-omap2/board-n8x0.c b/arch/arm/mach-omap2/board-n8x0.c
index 8341632..2f6ccba 100644
--- a/arch/arm/mach-omap2/board-n8x0.c
+++ b/arch/arm/mach-omap2/board-n8x0.c
@@ -121,7 +121,7 @@ static void __init n8x0_init_machine(void)
 
 MACHINE_START(NOKIA_N800, "Nokia N800")
 	.phys_io	= 0x48000000,
-	.io_pg_offst	= ((0xd8000000) >> 18) & 0xfffc,
+	.io_pg_offst	= ((0xfa000000) >> 18) & 0xfffc,
 	.boot_params	= 0x80000100,
 	.map_io		= n8x0_map_io,
 	.init_irq	= n8x0_init_irq,
@@ -131,7 +131,7 @@ MACHINE_END
 
 MACHINE_START(NOKIA_N810, "Nokia N810")
 	.phys_io	= 0x48000000,
-	.io_pg_offst	= ((0xd8000000) >> 18) & 0xfffc,
+	.io_pg_offst	= ((0xfa000000) >> 18) & 0xfffc,
 	.boot_params	= 0x80000100,
 	.map_io		= n8x0_map_io,
 	.init_irq	= n8x0_init_irq,
@@ -141,7 +141,7 @@ MACHINE_END
 
 MACHINE_START(NOKIA_N810_WIMAX, "Nokia N810 WiMAX")
 	.phys_io	= 0x48000000,
-	.io_pg_offst	= ((0xd8000000) >> 18) & 0xfffc,
+	.io_pg_offst	= ((0xfa000000) >> 18) & 0xfffc,
 	.boot_params	= 0x80000100,
 	.map_io		= n8x0_map_io,
 	.init_irq	= n8x0_init_irq,
diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
index 70df6b4..7db803d 100644
--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -429,7 +429,7 @@ static void __init omap3_beagle_map_io(void)
 MACHINE_START(OMAP3_BEAGLE, "OMAP3 Beagle Board")
 	/* Maintainer: Syed Mohammed Khasim - http://beagleboard.org */
 	.phys_io	= 0x48000000,
-	.io_pg_offst	= ((0xd8000000) >> 18) & 0xfffc,
+	.io_pg_offst	= ((0xfa000000) >> 18) & 0xfffc,
 	.boot_params	= 0x80000100,
 	.map_io		= omap3_beagle_map_io,
 	.init_irq	= omap3_beagle_init_irq,
diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
index e4ec0c5..72f0b1e 100644
--- a/arch/arm/mach-omap2/board-omap3evm.c
+++ b/arch/arm/mach-omap2/board-omap3evm.c
@@ -324,7 +324,7 @@ static void __init omap3_evm_map_io(void)
 MACHINE_START(OMAP3EVM, "OMAP3 EVM")
 	/* Maintainer: Syed Mohammed Khasim - Texas Instruments */
 	.phys_io	= 0x48000000,
-	.io_pg_offst	= ((0xd8000000) >> 18) & 0xfffc,
+	.io_pg_offst	= ((0xfa000000) >> 18) & 0xfffc,
 	.boot_params	= 0x80000100,
 	.map_io		= omap3_evm_map_io,
 	.init_irq	= omap3_evm_init_irq,
diff --git a/arch/arm/mach-omap2/board-omap3pandora.c b/arch/arm/mach-omap2/board-omap3pandora.c
index 7f6bf87..12d2381 100644
--- a/arch/arm/mach-omap2/board-omap3pandora.c
+++ b/arch/arm/mach-omap2/board-omap3pandora.c
@@ -412,7 +412,7 @@ static void __init omap3pandora_map_io(void)
 
 MACHINE_START(OMAP3_PANDORA, "Pandora Handheld Console")
 	.phys_io	= 0x48000000,
-	.io_pg_offst	= ((0xd8000000) >> 18) & 0xfffc,
+	.io_pg_offst	= ((0xfa000000) >> 18) & 0xfffc,
 	.boot_params	= 0x80000100,
 	.map_io		= omap3pandora_map_io,
 	.init_irq	= omap3pandora_init_irq,
diff --git a/arch/arm/mach-omap2/board-overo.c b/arch/arm/mach-omap2/board-overo.c
index 9917d2f..c5e0da9 100644
--- a/arch/arm/mach-omap2/board-overo.c
+++ b/arch/arm/mach-omap2/board-overo.c
@@ -451,7 +451,7 @@ static void __init overo_map_io(void)
 
 MACHINE_START(OVERO, "Gumstix Overo")
 	.phys_io	= 0x48000000,
-	.io_pg_offst	= ((0xd8000000) >> 18) & 0xfffc,
+	.io_pg_offst	= ((0xfa000000) >> 18) & 0xfffc,
 	.boot_params	= 0x80000100,
 	.map_io		= overo_map_io,
 	.init_irq	= overo_init_irq,
diff --git a/arch/arm/mach-omap2/board-rx51.c b/arch/arm/mach-omap2/board-rx51.c
index f9196c3..c973812 100644
--- a/arch/arm/mach-omap2/board-rx51.c
+++ b/arch/arm/mach-omap2/board-rx51.c
@@ -85,7 +85,7 @@ static void __init rx51_map_io(void)
 MACHINE_START(NOKIA_RX51, "Nokia RX-51 board")
 	/* Maintainer: Lauri Leukkunen <lauri.leukkunen@nokia.com> */
 	.phys_io	= 0x48000000,
-	.io_pg_offst	= ((0xd8000000) >> 18) & 0xfffc,
+	.io_pg_offst	= ((0xfa000000) >> 18) & 0xfffc,
 	.boot_params	= 0x80000100,
 	.map_io		= rx51_map_io,
 	.init_irq	= rx51_init_irq,
diff --git a/arch/arm/mach-omap2/board-zoom2.c b/arch/arm/mach-omap2/board-zoom2.c
index fd3369d..48bd2af 100644
--- a/arch/arm/mach-omap2/board-zoom2.c
+++ b/arch/arm/mach-omap2/board-zoom2.c
@@ -283,7 +283,7 @@ static void __init omap_zoom2_map_io(void)
 
 MACHINE_START(OMAP_ZOOM2, "OMAP Zoom2 board")
 	.phys_io	= 0x48000000,
-	.io_pg_offst	= ((0xd8000000) >> 18) & 0xfffc,
+	.io_pg_offst	= ((0xfa000000) >> 18) & 0xfffc,
 	.boot_params	= 0x80000100,
 	.map_io		= omap_zoom2_map_io,
 	.init_irq	= omap_zoom2_init_irq,
diff --git a/arch/arm/plat-omap/include/mach/debug-macro.S b/arch/arm/plat-omap/include/mach/debug-macro.S
index ac24050..63bb06d 100644
--- a/arch/arm/plat-omap/include/mach/debug-macro.S
+++ b/arch/arm/plat-omap/include/mach/debug-macro.S
@@ -27,7 +27,7 @@
 
 #elif  CONFIG_ARCH_OMAP2
 		moveq	\rx, #0x48000000	@ physical base address
-		movne	\rx, #0xd8000000	@ virtual base
+		movne	\rx, #0xfa000000	@ virtual base
 		orr	\rx, \rx, #0x0006a000
 #ifdef CONFIG_OMAP_LL_DEBUG_UART2
 		add	\rx, \rx, #0x00002000	@ UART 2
@@ -38,7 +38,7 @@
 
 #elif defined(CONFIG_ARCH_OMAP3) || defined(CONFIG_ARCH_OMAP4)
 		moveq	\rx, #0x48000000	@ physical base address
-		movne	\rx, #0xd8000000	@ virtual base
+		movne	\rx, #0xfa000000	@ virtual base
 		orr	\rx, \rx, #0x0006a000
 #ifdef CONFIG_OMAP_LL_DEBUG_UART2
 		add	\rx, \rx, #0x00002000	@ UART 2

