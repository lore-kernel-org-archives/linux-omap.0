From: Benoit Cousson <b-cousson@ti.com>
Subject: [PATCH 1/4] ARM: OMAP2+: board-generic: Remove un-needed .atag_offset for DT_MACHINE
Date: Mon, 13 Feb 2012 17:30:22 +0100
Message-ID: <1329150625-8604-2-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:39758 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755109Ab2BMQah (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 13 Feb 2012 11:30:37 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Benoit Cousson <b-cousson@ti.com>

Some .atag_offset entries were wrongly added during a merge conflict
resolution in 3.3.
Remove them all, since DT boot does not use that attribute anymore.

Replace as well the #if... by #ifdef for consistency.

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/board-generic.c |   12 ++++--------
 1 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-omap2/board-generic.c b/arch/arm/mach-omap2/board-generic.c
index ad49762..d32b593 100644
--- a/arch/arm/mach-omap2/board-generic.c
+++ b/arch/arm/mach-omap2/board-generic.c
@@ -91,14 +91,13 @@ static void __init omap3_init(void)
 }
 #endif
 
-#if defined(CONFIG_SOC_OMAP2420)
+#ifdef CONFIG_SOC_OMAP2420
 static const char *omap242x_boards_compat[] __initdata = {
 	"ti,omap2420",
 	NULL,
 };
 
 DT_MACHINE_START(OMAP242X_DT, "Generic OMAP2420 (Flattened Device Tree)")
-	.atag_offset	= 0x100,
 	.reserve	= omap_reserve,
 	.map_io		= omap242x_map_io,
 	.init_early	= omap2420_init_early,
@@ -111,14 +110,13 @@ DT_MACHINE_START(OMAP242X_DT, "Generic OMAP2420 (Flattened Device Tree)")
 MACHINE_END
 #endif
 
-#if defined(CONFIG_SOC_OMAP2430)
+#ifdef CONFIG_SOC_OMAP2430
 static const char *omap243x_boards_compat[] __initdata = {
 	"ti,omap2430",
 	NULL,
 };
 
 DT_MACHINE_START(OMAP243X_DT, "Generic OMAP2430 (Flattened Device Tree)")
-	.atag_offset	= 0x100,
 	.reserve	= omap_reserve,
 	.map_io		= omap243x_map_io,
 	.init_early	= omap2430_init_early,
@@ -131,14 +129,13 @@ DT_MACHINE_START(OMAP243X_DT, "Generic OMAP2430 (Flattened Device Tree)")
 MACHINE_END
 #endif
 
-#if defined(CONFIG_ARCH_OMAP3)
+#ifdef CONFIG_ARCH_OMAP3
 static const char *omap3_boards_compat[] __initdata = {
 	"ti,omap3",
 	NULL,
 };
 
 DT_MACHINE_START(OMAP3_DT, "Generic OMAP3 (Flattened Device Tree)")
-	.atag_offset	= 0x100,
 	.reserve	= omap_reserve,
 	.map_io		= omap3_map_io,
 	.init_early	= omap3430_init_early,
@@ -151,14 +148,13 @@ DT_MACHINE_START(OMAP3_DT, "Generic OMAP3 (Flattened Device Tree)")
 MACHINE_END
 #endif
 
-#if defined(CONFIG_ARCH_OMAP4)
+#ifdef CONFIG_ARCH_OMAP4
 static const char *omap4_boards_compat[] __initdata = {
 	"ti,omap4",
 	NULL,
 };
 
 DT_MACHINE_START(OMAP4_DT, "Generic OMAP4 (Flattened Device Tree)")
-	.atag_offset	= 0x100,
 	.reserve	= omap_reserve,
 	.map_io		= omap4_map_io,
 	.init_early	= omap4430_init_early,
-- 
1.7.0.4

