From: Sekhar Nori <nsekhar@ti.com>
Subject: [PATCH 2/2] ARM: OMAP2+: AM43x: L2 cache support
Date: Fri, 28 Mar 2014 14:05:29 +0530
Message-ID: <013dda556020e852a1bc5b875427e68ab9fdf69a.1395994759.git.nsekhar@ti.com>
References: <5ea7277c21215c7b4aa776d5379dc2d6263228c6.1395994759.git.nsekhar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:46980 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751164AbaC1IgB (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 28 Mar 2014 04:36:01 -0400
In-Reply-To: <5ea7277c21215c7b4aa776d5379dc2d6263228c6.1395994759.git.nsekhar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>, Sekhar Nori <nsekhar@ti.com>

From: Afzal Mohammed <afzal@ti.com>

Add support for L2 cache controller (PL310) on
AM437x SoC.

Signed-off-by: Afzal Mohammed <afzal@ti.com>
Signed-off-by: Sekhar Nori <nsekhar@ti.com>
---
 arch/arm/mach-omap2/Kconfig        |    1 +
 arch/arm/mach-omap2/omap4-common.c |    8 +++++++-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index 1124155..1fd34d2 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -65,6 +65,7 @@ config SOC_AM43XX
 	select ARCH_HAS_OPP
 	select ARM_GIC
 	select MACH_OMAP_GENERIC
+	select MIGHT_HAVE_CACHE_L2X0
 
 config SOC_DRA7XX
 	bool "TI DRA7XX"
diff --git a/arch/arm/mach-omap2/omap4-common.c b/arch/arm/mach-omap2/omap4-common.c
index 8f18460..763a169 100644
--- a/arch/arm/mach-omap2/omap4-common.c
+++ b/arch/arm/mach-omap2/omap4-common.c
@@ -188,7 +188,7 @@ static int __init omap_l2_cache_init(void)
 	 * To avoid code running on other OMAPs in
 	 * multi-omap builds
 	 */
-	if (!cpu_is_omap44xx())
+	if (!cpu_is_omap44xx() && !soc_is_am43xx())
 		return -ENODEV;
 
 	/* Static mapping, never released */
@@ -200,6 +200,7 @@ static int __init omap_l2_cache_init(void)
 	 * 16-way associativity, parity disabled
 	 * Way size - 32KB (es1.0)
 	 * Way size - 64KB (es2.0 +)
+	 * Way size - 16KB (am43xx)
 	 */
 	aux_ctrl = ((1 << L2X0_AUX_CTRL_ASSOCIATIVITY_SHIFT) |
 			(0x1 << 25) |
@@ -208,6 +209,11 @@ static int __init omap_l2_cache_init(void)
 
 	if (omap_rev() == OMAP4430_REV_ES1_0) {
 		aux_ctrl |= 0x2 << L2X0_AUX_CTRL_WAY_SIZE_SHIFT;
+	} else if (soc_is_am43xx()) {
+		aux_ctrl |= ((0x1 << L2X0_AUX_CTRL_WAY_SIZE_SHIFT) |
+			(1 << L2X0_AUX_CTRL_DATA_PREFETCH_SHIFT) |
+			(1 << L2X0_AUX_CTRL_INSTR_PREFETCH_SHIFT) |
+			(1 << L2X0_AUX_CTRL_EARLY_BRESP_SHIFT));
 	} else {
 		aux_ctrl |= ((0x3 << L2X0_AUX_CTRL_WAY_SIZE_SHIFT) |
 			(1 << L2X0_AUX_CTRL_SHARE_OVERRIDE_SHIFT) |
-- 
1.7.10.1

