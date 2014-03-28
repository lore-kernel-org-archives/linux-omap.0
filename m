From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [PATCH 04/75] ARM: l2c: omap2: remove ES1.0 support
Date: Fri, 28 Mar 2014 15:14:39 +0000
Message-ID: <E1WTYUR-0004W9-RD@rmk-PC.arm.linux.org.uk>
References: <20140328151249.GJ7528@n2100.arm.linux.org.uk>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from gw-1.arm.linux.org.uk ([78.32.30.217]:41366 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751427AbaC1POo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 28 Mar 2014 11:14:44 -0400
In-Reply-To: <20140328151249.GJ7528@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org

Santosh says:
> But we should kill all of that since we long back decided to remove
> ES1.0 related code. The mach-omap code alreasy has removed the ES1.0
> compatibility so feel free to remove any specific ES1.0
> related stuff. That silicon is long dead.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-omap2/omap4-common.c | 25 ++++++++-----------------
 1 file changed, 8 insertions(+), 17 deletions(-)

diff --git a/arch/arm/mach-omap2/omap4-common.c b/arch/arm/mach-omap2/omap4-common.c
index 6cd3f3772ecf..9f8d506f511d 100644
--- a/arch/arm/mach-omap2/omap4-common.c
+++ b/arch/arm/mach-omap2/omap4-common.c
@@ -181,7 +181,7 @@ static void omap4_l2x0_set_debug(unsigned long val)
 
 static int __init omap_l2_cache_init(void)
 {
-	u32 aux_ctrl = 0;
+	u32 aux_ctrl;
 
 	/*
 	 * To avoid code running on other OMAPs in
@@ -195,27 +195,18 @@ static int __init omap_l2_cache_init(void)
 	if (WARN_ON(!l2cache_base))
 		return -ENOMEM;
 
-	/*
-	 * 16-way associativity, parity disabled
-	 * Way size - 32KB (es1.0)
-	 * Way size - 64KB (es2.0 +)
-	 */
-	aux_ctrl = ((1 << L2X0_AUX_CTRL_ASSOCIATIVITY_SHIFT) |
+	/* 16-way associativity, parity disabled, way size - 64KB (es2.0 +) */
+	aux_ctrl = (1 << L2X0_AUX_CTRL_ASSOCIATIVITY_SHIFT) |
 			(0x1 << 25) |
 			(0x1 << L2X0_AUX_CTRL_NS_LOCKDOWN_SHIFT) |
-			(0x1 << L2X0_AUX_CTRL_NS_INT_CTRL_SHIFT));
-
-	if (omap_rev() == OMAP4430_REV_ES1_0) {
-		aux_ctrl |= 0x2 << L2X0_AUX_CTRL_WAY_SIZE_SHIFT;
-	} else {
-		aux_ctrl |= ((0x3 << L2X0_AUX_CTRL_WAY_SIZE_SHIFT) |
+			(0x1 << L2X0_AUX_CTRL_NS_INT_CTRL_SHIFT)) |
+			(0x3 << L2X0_AUX_CTRL_WAY_SIZE_SHIFT) |
 			(1 << L2X0_AUX_CTRL_SHARE_OVERRIDE_SHIFT) |
 			(1 << L2X0_AUX_CTRL_DATA_PREFETCH_SHIFT) |
 			(1 << L2X0_AUX_CTRL_INSTR_PREFETCH_SHIFT) |
-			(1 << L2X0_AUX_CTRL_EARLY_BRESP_SHIFT));
-	}
-	if (omap_rev() != OMAP4430_REV_ES1_0)
-		omap_smc1(0x109, aux_ctrl);
+			(1 << L2X0_AUX_CTRL_EARLY_BRESP_SHIFT);
+
+	omap_smc1(0x109, aux_ctrl);
 
 	/* Enable PL310 L2 Cache controller */
 	omap_smc1(0x102, 0x1);
-- 
1.8.3.1

