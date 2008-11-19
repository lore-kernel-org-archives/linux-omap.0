From: Tero Kristo <tero.kristo@nokia.com>
Subject: [PATCH] PM: Fix a bug with noncore dpll rate calculation
Date: Wed, 19 Nov 2008 11:28:01 +0200
Message-ID: <1227086881-16261-1-git-send-email-tero.kristo@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:57167 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752627AbYKSJbF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 19 Nov 2008 04:31:05 -0500
Received: from esebh105.NOE.Nokia.com (esebh105.ntc.nokia.com [172.21.138.211])
	by mgw-mx03.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id mAJ9Ukub020470
	for <linux-omap@vger.kernel.org>; Wed, 19 Nov 2008 11:31:01 +0200
Received: from localhost.localdomain (sokoban.ntc.nokia.com [172.22.144.95])
	by mgw-int01.ntc.nokia.com (Switch-3.2.5/Switch-3.2.5) with ESMTP id mAJ9UwOo000931
	for <linux-omap@vger.kernel.org>; Wed, 19 Nov 2008 11:30:58 +0200
In-Reply-To: <>
References: <>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Noncore dpll can enter autoidle state, in which case the rate calculation
fails. Fixed by checking dpll mode instead of idle status.

Signed-off-by: Tero Kristo <tero.kristo@nokia.com>
---
 arch/arm/mach-omap2/clock.c           |   16 +++++++++++-----
 arch/arm/mach-omap2/cm-regbits-34xx.h |    2 ++
 2 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-omap2/clock.c b/arch/arm/mach-omap2/clock.c
index 522ce6f..bbd3e82 100644
--- a/arch/arm/mach-omap2/clock.c
+++ b/arch/arm/mach-omap2/clock.c
@@ -212,9 +212,16 @@ u32 omap2_get_dpll_rate(struct clk *clk)
 		return 0;
 
 	/* Return bypass rate if DPLL is bypassed */
-	v = cm_read_mod_reg(clk->prcm_mod, dd->idlest_reg);
-	v &= dd->idlest_mask;
-	v >>= __ffs(dd->idlest_mask);
+	if (cpu_is_omap34xx()) {
+		v = cm_read_mod_reg(clk->prcm_mod, dd->control_reg);
+		v &= dd->enable_mask;
+		v >>= __ffs(dd->enable_mask);
+	} else {
+		v = cm_read_mod_reg(clk->prcm_mod, dd->idlest_reg);
+		v &= dd->idlest_mask;
+		v >>= __ffs(dd->idlest_mask);
+	}
+
 	if (cpu_is_omap24xx()) {
 
 		if (v == ST_CORE_CLK_REF)
@@ -224,9 +231,8 @@ u32 omap2_get_dpll_rate(struct clk *clk)
 
 	} else if (cpu_is_omap34xx()) {
 
-		if (!v)
+		if (v == OMAP3430_EN_MPU_DPLL_BYPASS)
 			return dd->bypass_clk->rate;
-
 	}
 
 	v = cm_read_mod_reg(clk->prcm_mod, dd->mult_div1_reg);
diff --git a/arch/arm/mach-omap2/cm-regbits-34xx.h b/arch/arm/mach-omap2/cm-regbits-34xx.h
index 6f3f5a3..9995353 100644
--- a/arch/arm/mach-omap2/cm-regbits-34xx.h
+++ b/arch/arm/mach-omap2/cm-regbits-34xx.h
@@ -112,6 +112,8 @@
 #define OMAP3430_EN_MPU_DPLL_DRIFTGUARD_MASK		(1 << 3)
 #define OMAP3430_EN_MPU_DPLL_SHIFT			0
 #define OMAP3430_EN_MPU_DPLL_MASK			(0x7 << 0)
+#define OMAP3430_EN_MPU_DPLL_LOCK			(0x7 << 0)
+#define OMAP3430_EN_MPU_DPLL_BYPASS			(0x5 << 0)
 
 /* CM_IDLEST_MPU */
 #define OMAP3430_ST_MPU					(1 << 0)
-- 
1.5.4.3

