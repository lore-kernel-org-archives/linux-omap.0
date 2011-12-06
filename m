From: Benoit Cousson <b-cousson@ti.com>
Subject: [PATCH 3/3] ARM: OMAP2+: board-generic: Replace #if defined by #ifdef for consistency
Date: Tue, 6 Dec 2011 17:49:09 +0100
Message-ID: <1323190149-6492-4-git-send-email-b-cousson@ti.com>
References: <y>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:59564 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750846Ab1LFQuL (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 6 Dec 2011 11:50:11 -0500
In-Reply-To: <y>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: devicetree-discuss@lists.ozlabs.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Benoit Cousson <b-cousson@ti.com>

The file contains a mix of #ifdef and #if defined().
Replace the #if... by #ifdef.

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/board-generic.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/board-generic.c b/arch/arm/mach-omap2/board-generic.c
index fb55fa3..09f44e0 100644
--- a/arch/arm/mach-omap2/board-generic.c
+++ b/arch/arm/mach-omap2/board-generic.c
@@ -92,7 +92,7 @@ static void __init omap3_init(void)
 }
 #endif
 
-#if defined(CONFIG_SOC_OMAP2420)
+#ifdef CONFIG_SOC_OMAP2420
 static const char *omap242x_boards_compat[] __initdata = {
 	"ti,omap2420",
 	NULL,
@@ -110,7 +110,7 @@ DT_MACHINE_START(OMAP242X_DT, "Generic OMAP2420 (Flattened Device Tree)")
 MACHINE_END
 #endif
 
-#if defined(CONFIG_SOC_OMAP2430)
+#ifdef CONFIG_SOC_OMAP2430
 static const char *omap243x_boards_compat[] __initdata = {
 	"ti,omap2430",
 	NULL,
@@ -128,7 +128,7 @@ DT_MACHINE_START(OMAP243X_DT, "Generic OMAP2430 (Flattened Device Tree)")
 MACHINE_END
 #endif
 
-#if defined(CONFIG_ARCH_OMAP3)
+#ifdef CONFIG_ARCH_OMAP3
 static const char *omap3_boards_compat[] __initdata = {
 	"ti,omap3",
 	NULL,
@@ -146,7 +146,7 @@ DT_MACHINE_START(OMAP3_DT, "Generic OMAP3 (Flattened Device Tree)")
 MACHINE_END
 #endif
 
-#if defined(CONFIG_ARCH_OMAP4)
+#ifdef CONFIG_ARCH_OMAP4
 static const char *omap4_boards_compat[] __initdata = {
 	"ti,omap4",
 	NULL,
-- 
1.7.0.4

