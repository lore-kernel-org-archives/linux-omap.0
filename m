From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH 4/5] ARM: OMAP2/3/4: Fix DEBUG_LL UART io address
Date: Sun, 23 Aug 2009 19:04:54 +0530
Message-ID: <1251034495-10107-4-git-send-email-santosh.shilimkar@ti.com>
References: <1251034495-10107-1-git-send-email-santosh.shilimkar@ti.com>
 <1251034495-10107-2-git-send-email-santosh.shilimkar@ti.com>
 <1251034495-10107-3-git-send-email-santosh.shilimkar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:52704 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933905AbZHWNfH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 23 Aug 2009 09:35:07 -0400
In-Reply-To: <1251034495-10107-3-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, khilman@deeprootsystems.com
Cc: linux-omap@vger.kernel.org, Santosh Shilimkar <santosh.shilimkar@ti.com>

This patch fixes the low level debug UART io address as per this series.
The change is essential to have CONFIG_DEBUG_LL working.

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/mach-omap2/board-2430sdp.c           |    2 +-
 arch/arm/mach-omap2/board-3430sdp.c           |    2 +-
 arch/arm/mach-omap2/board-4430sdp.c           |    2 +-
 arch/arm/mach-omap2/board-apollon.c           |    2 +-
 arch/arm/mach-omap2/board-generic.c           |    2 +-
 arch/arm/mach-omap2/board-h4.c                |    2 +-
 arch/arm/mach-omap2/board-ldp.c               |    2 +-
 arch/arm/mach-omap2/board-omap3beagle.c       |    2 +-
 arch/arm/mach-omap2/board-omap3evm.c          |    2 +-
 arch/arm/mach-omap2/board-omap3pandora.c      |    2 +-
 arch/arm/mach-omap2/board-overo.c             |    2 +-
 arch/arm/mach-omap2/board-rx51.c              |    2 +-
 arch/arm/mach-omap2/board-zoom2.c             |    2 +-
 arch/arm/plat-omap/include/mach/debug-macro.S |    4 ++--
 14 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/arch/arm/mach-omap2/board-2430sdp.c b/arch/arm/mach-omap2/board-2430sdp.c
index 8ec2a13..6a6d26b 100644
--- a/arch/arm/mach-omap2/board-2430sdp.c
+++ b/arch/arm/mach-omap2/board-2430sdp.c
@@ -227,7 +227,7 @@ static void __init omap_2430sdp_map_io(void)
 MACHINE_START(OMAP_2430SDP, "OMAP2430 sdp2430 board")
 	/* Maintainer: Syed Khasim - Texas Instruments Inc */
 	.phys_io	= 0x48000000,
-	.io_pg_offst	= ((0xd8000000) >> 18) & 0xfffc,
+	.io_pg_offst	= ((0xfa000000) >> 18) & 0xfffc,
 	.boot_params	= 0x80000100,
 	.map_io		= omap_2430sdp_map_io,
 	.init_irq	= omap_2430sdp_init_irq,
diff --git a/arch/arm/mach-omap2/board-3430sdp.c b/arch/arm/mach-omap2/board-3430sdp.c
index ac262cd..f8aebd6 100644
--- a/arch/arm/mach-omap2/board-3430sdp.c
+++ b/arch/arm/mach-omap2/board-3430sdp.c
@@ -506,7 +506,7 @@ static void __init omap_3430sdp_map_io(void)
 MACHINE_START(OMAP_3430SDP, "OMAP3430 3430SDP board")
 	/* Maintainer: Syed Khasim - Texas Instruments Inc */
 	.phys_io	= 0x48000000,
-	.io_pg_offst	= ((0xd8000000) >> 18) & 0xfffc,
+	.io_pg_offst	= ((0xfa000000) >> 18) & 0xfffc,
 	.boot_params	= 0x80000100,
 	.map_io		= omap_3430sdp_map_io,
 	.init_irq	= omap_3430sdp_init_irq,
diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
index 2ecd9af..d55a9d1 100644
--- a/arch/arm/mach-omap2/board-4430sdp.c
+++ b/arch/arm/mach-omap2/board-4430sdp.c
@@ -85,7 +85,7 @@ static void __init omap_4430sdp_map_io(void)
 MACHINE_START(OMAP_4430SDP, "OMAP4430 4430SDP board")
 	/* Maintainer: Santosh Shilimkar - Texas Instruments Inc */
 	.phys_io	= 0x48000000,
-	.io_pg_offst	= ((0xd8000000) >> 18) & 0xfffc,
+	.io_pg_offst	= ((0xfa000000) >> 18) & 0xfffc,
 	.boot_params	= 0x80000100,
 	.map_io		= omap_4430sdp_map_io,
 	.init_irq	= omap_4430sdp_init_irq,
diff --git a/arch/arm/mach-omap2/board-apollon.c b/arch/arm/mach-omap2/board-apollon.c
index dcfc20d..7aad831 100644
--- a/arch/arm/mach-omap2/board-apollon.c
+++ b/arch/arm/mach-omap2/board-apollon.c
@@ -338,7 +338,7 @@ static void __init omap_apollon_map_io(void)
 MACHINE_START(OMAP_APOLLON, "OMAP24xx Apollon")
 	/* Maintainer: Kyungmin Park <kyungmin.park@samsung.com> */
 	.phys_io	= 0x48000000,
-	.io_pg_offst	= ((0xd8000000) >> 18) & 0xfffc,
+	.io_pg_offst	= ((0xfa000000) >> 18) & 0xfffc,
 	.boot_params	= 0x80000100,
 	.map_io		= omap_apollon_map_io,
 	.init_irq	= omap_apollon_init_irq,
diff --git a/arch/arm/mach-omap2/board-generic.c b/arch/arm/mach-omap2/board-generic.c
index fd00aa0..f118311 100644
--- a/arch/arm/mach-omap2/board-generic.c
+++ b/arch/arm/mach-omap2/board-generic.c
@@ -61,7 +61,7 @@ static void __init omap_generic_map_io(void)
 MACHINE_START(OMAP_GENERIC, "Generic OMAP24xx")
 	/* Maintainer: Paul Mundt <paul.mundt@nokia.com> */
 	.phys_io	= 0x48000000,
-	.io_pg_offst	= ((0xd8000000) >> 18) & 0xfffc,
+	.io_pg_offst	= ((0xfa000000) >> 18) & 0xfffc,
 	.boot_params	= 0x80000100,
 	.map_io		= omap_generic_map_io,
 	.init_irq	= omap_generic_init_irq,
diff --git a/arch/arm/mach-omap2/board-h4.c b/arch/arm/mach-omap2/board-h4.c
index 7b1d61d..260e9fe 100644
--- a/arch/arm/mach-omap2/board-h4.c
+++ b/arch/arm/mach-omap2/board-h4.c
@@ -381,7 +381,7 @@ static void __init omap_h4_map_io(void)
 MACHINE_START(OMAP_H4, "OMAP2420 H4 board")
 	/* Maintainer: Paul Mundt <paul.mundt@nokia.com> */
 	.phys_io	= 0x48000000,
-	.io_pg_offst	= ((0xd8000000) >> 18) & 0xfffc,
+	.io_pg_offst	= ((0xfa000000) >> 18) & 0xfffc,
 	.boot_params	= 0x80000100,
 	.map_io		= omap_h4_map_io,
 	.init_irq	= omap_h4_init_irq,
diff --git a/arch/arm/mach-omap2/board-ldp.c b/arch/arm/mach-omap2/board-ldp.c
index ea383f8..1b66261 100644
--- a/arch/arm/mach-omap2/board-ldp.c
+++ b/arch/arm/mach-omap2/board-ldp.c
@@ -400,7 +400,7 @@ static void __init omap_ldp_map_io(void)
 
 MACHINE_START(OMAP_LDP, "OMAP LDP board")
 	.phys_io	= 0x48000000,
-	.io_pg_offst	= ((0xd8000000) >> 18) & 0xfffc,
+	.io_pg_offst	= ((0xfa000000) >> 18) & 0xfffc,
 	.boot_params	= 0x80000100,
 	.map_io		= omap_ldp_map_io,
 	.init_irq	= omap_ldp_init_irq,
diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
index e00ba12..395a8d6 100644
--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -424,7 +424,7 @@ static void __init omap3_beagle_map_io(void)
 MACHINE_START(OMAP3_BEAGLE, "OMAP3 Beagle Board")
 	/* Maintainer: Syed Mohammed Khasim - http://beagleboard.org */
 	.phys_io	= 0x48000000,
-	.io_pg_offst	= ((0xd8000000) >> 18) & 0xfffc,
+	.io_pg_offst	= ((0xfa000000) >> 18) & 0xfffc,
 	.boot_params	= 0x80000100,
 	.map_io		= omap3_beagle_map_io,
 	.init_irq	= omap3_beagle_init_irq,
diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
index c4b1446..c190188 100644
--- a/arch/arm/mach-omap2/board-omap3evm.c
+++ b/arch/arm/mach-omap2/board-omap3evm.c
@@ -325,7 +325,7 @@ static void __init omap3_evm_map_io(void)
 MACHINE_START(OMAP3EVM, "OMAP3 EVM")
 	/* Maintainer: Syed Mohammed Khasim - Texas Instruments */
 	.phys_io	= 0x48000000,
-	.io_pg_offst	= ((0xd8000000) >> 18) & 0xfffc,
+	.io_pg_offst	= ((0xfa000000) >> 18) & 0xfffc,
 	.boot_params	= 0x80000100,
 	.map_io		= omap3_evm_map_io,
 	.init_irq	= omap3_evm_init_irq,
diff --git a/arch/arm/mach-omap2/board-omap3pandora.c b/arch/arm/mach-omap2/board-omap3pandora.c
index 864ee3d..d490df3 100644
--- a/arch/arm/mach-omap2/board-omap3pandora.c
+++ b/arch/arm/mach-omap2/board-omap3pandora.c
@@ -413,7 +413,7 @@ static void __init omap3pandora_map_io(void)
 
 MACHINE_START(OMAP3_PANDORA, "Pandora Handheld Console")
 	.phys_io	= 0x48000000,
-	.io_pg_offst	= ((0xd8000000) >> 18) & 0xfffc,
+	.io_pg_offst	= ((0xfa000000) >> 18) & 0xfffc,
 	.boot_params	= 0x80000100,
 	.map_io		= omap3pandora_map_io,
 	.init_irq	= omap3pandora_init_irq,
diff --git a/arch/arm/mach-omap2/board-overo.c b/arch/arm/mach-omap2/board-overo.c
index 6bce230..8dd72be 100644
--- a/arch/arm/mach-omap2/board-overo.c
+++ b/arch/arm/mach-omap2/board-overo.c
@@ -455,7 +455,7 @@ static void __init overo_map_io(void)
 
 MACHINE_START(OVERO, "Gumstix Overo")
 	.phys_io	= 0x48000000,
-	.io_pg_offst	= ((0xd8000000) >> 18) & 0xfffc,
+	.io_pg_offst	= ((0xfa000000) >> 18) & 0xfffc,
 	.boot_params	= 0x80000100,
 	.map_io		= overo_map_io,
 	.init_irq	= overo_init_irq,
diff --git a/arch/arm/mach-omap2/board-rx51.c b/arch/arm/mach-omap2/board-rx51.c
index 1c9e07f..d6eb9a6 100644
--- a/arch/arm/mach-omap2/board-rx51.c
+++ b/arch/arm/mach-omap2/board-rx51.c
@@ -90,7 +90,7 @@ static void __init rx51_map_io(void)
 MACHINE_START(NOKIA_RX51, "Nokia RX-51 board")
 	/* Maintainer: Lauri Leukkunen <lauri.leukkunen@nokia.com> */
 	.phys_io	= 0x48000000,
-	.io_pg_offst	= ((0xd8000000) >> 18) & 0xfffc,
+	.io_pg_offst	= ((0xfa000000) >> 18) & 0xfffc,
 	.boot_params	= 0x80000100,
 	.map_io		= rx51_map_io,
 	.init_irq	= rx51_init_irq,
diff --git a/arch/arm/mach-omap2/board-zoom2.c b/arch/arm/mach-omap2/board-zoom2.c
index 427b7b8..762db60 100644
--- a/arch/arm/mach-omap2/board-zoom2.c
+++ b/arch/arm/mach-omap2/board-zoom2.c
@@ -101,7 +101,7 @@ static void __init omap_zoom2_map_io(void)
 
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
-- 
1.5.4.7

