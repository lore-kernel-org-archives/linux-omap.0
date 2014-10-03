From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 1/5] ARM: OMAP3: clock: use clk_features flags for omap3 DPLL4 checks
Date: Fri, 3 Oct 2014 16:57:10 +0300
Message-ID: <1412344634-2798-2-git-send-email-t-kristo@ti.com>
References: <1412344634-2798-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:50083 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752090AbaJCN5w (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 3 Oct 2014 09:57:52 -0400
In-Reply-To: <1412344634-2798-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, tony@atomide.com, mturquette@linaro.org, paul@pwsan.com
Cc: linux-arm-kernel@lists.infradead.org

DPLL4 can't be reprogrammed on OMAP3430 ES1.0 due to hardware limitation.
Currently, the code does runtime omap_rev() check to see the chip it is
being executed on, instead, change this to use clk_features flags.
This avoids need for runtime omap_rev() checks.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/clock.c     |    4 ++++
 arch/arm/mach-omap2/clock.h     |    1 +
 arch/arm/mach-omap2/clock3xxx.c |    2 +-
 3 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/clock.c b/arch/arm/mach-omap2/clock.c
index 500530d..c2b2398 100644
--- a/arch/arm/mach-omap2/clock.c
+++ b/arch/arm/mach-omap2/clock.c
@@ -771,4 +771,8 @@ void __init ti_clk_init_features(void)
 		ti_clk_features.cm_idlest_val = OMAP24XX_CM_IDLEST_VAL;
 	else if (cpu_is_omap34xx())
 		ti_clk_features.cm_idlest_val = OMAP34XX_CM_IDLEST_VAL;
+
+	/* On OMAP3430 ES1.0, DPLL4 can't be re-programmed */
+	if (omap_rev() == OMAP3430_REV_ES1_0)
+		ti_clk_features.flags |= TI_CLK_DPLL4_DENY_REPROGRAM;
 }
diff --git a/arch/arm/mach-omap2/clock.h b/arch/arm/mach-omap2/clock.h
index 4592a27..641337c 100644
--- a/arch/arm/mach-omap2/clock.h
+++ b/arch/arm/mach-omap2/clock.h
@@ -234,6 +234,7 @@ struct ti_clk_features {
 };
 
 #define TI_CLK_DPLL_HAS_FREQSEL		(1 << 0)
+#define TI_CLK_DPLL4_DENY_REPROGRAM	(1 << 1)
 
 extern struct ti_clk_features ti_clk_features;
 
diff --git a/arch/arm/mach-omap2/clock3xxx.c b/arch/arm/mach-omap2/clock3xxx.c
index 0b02b41..9a25601 100644
--- a/arch/arm/mach-omap2/clock3xxx.c
+++ b/arch/arm/mach-omap2/clock3xxx.c
@@ -46,7 +46,7 @@ int omap3_dpll4_set_rate(struct clk_hw *hw, unsigned long rate,
 	 * on 3430ES1 prevents us from changing DPLL multipliers or dividers
 	 * on DPLL4.
 	 */
-	if (omap_rev() == OMAP3430_REV_ES1_0) {
+	if (ti_clk_features.flags & TI_CLK_DPLL4_DENY_REPROGRAM) {
 		pr_err("clock: DPLL4 cannot change rate due to silicon 'Limitation 2.5' on 3430ES1.\n");
 		return -EINVAL;
 	}
-- 
1.7.9.5

