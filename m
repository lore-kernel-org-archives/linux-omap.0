From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH 4/7] omap: dpll: Add allow_idle/deny_idle support for all DPLL's
Date: Tue,  8 Feb 2011 15:40:35 +0530
Message-ID: <1297159838-30282-5-git-send-email-rnayak@ti.com>
References: <1297159838-30282-1-git-send-email-rnayak@ti.com>
 <1297159838-30282-2-git-send-email-rnayak@ti.com>
 <1297159838-30282-3-git-send-email-rnayak@ti.com>
 <1297159838-30282-4-git-send-email-rnayak@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:59044 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753045Ab1BHKK4 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 8 Feb 2011 05:10:56 -0500
In-Reply-To: <1297159838-30282-4-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: paul@pwsan.com, b-cousson@ti.com, khilman@ti.com, santosh.shilimkar@ti.com, linux-arm-kernel@lists.infradead.org, Rajendra Nayak <rnayak@ti.com>

All OMAP3/4 dpll's support hardware level autogating.
Populate allow_idle/deny_idle function pointers for all
DPLL's in clkops.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/clock.c          |    8 +++++++-
 arch/arm/mach-omap2/clock.h          |    1 +
 arch/arm/mach-omap2/clock3xxx_data.c |    2 +-
 arch/arm/mach-omap2/clock44xx_data.c |    2 +-
 4 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/clock.c b/arch/arm/mach-omap2/clock.c
index e0f017d..909e3c5 100644
--- a/arch/arm/mach-omap2/clock.c
+++ b/arch/arm/mach-omap2/clock.c
@@ -377,10 +377,16 @@ int omap2_clk_set_parent(struct clk *clk, struct clk *new_parent)
 const struct clkops clkops_omap3_noncore_dpll_ops = {
 	.enable		= omap3_noncore_dpll_enable,
 	.disable	= omap3_noncore_dpll_disable,
+	.allow_idle	= omap3_dpll_allow_idle,
+	.deny_idle	= omap3_dpll_deny_idle,
 };
 
-#endif
+const struct clkops clkops_omap3_core_dpll_ops = {
+	.allow_idle	= omap3_dpll_allow_idle,
+	.deny_idle	= omap3_dpll_deny_idle,
+};
 
+#endif
 
 /*
  * OMAP2+ clock reset and init functions
diff --git a/arch/arm/mach-omap2/clock.h b/arch/arm/mach-omap2/clock.h
index 896584e..2a939e5 100644
--- a/arch/arm/mach-omap2/clock.h
+++ b/arch/arm/mach-omap2/clock.h
@@ -146,5 +146,6 @@ extern void omap2_clk_exit_cpufreq_table(struct cpufreq_frequency_table **table)
 #endif
 
 extern const struct clkops clkops_omap3_noncore_dpll_ops;
+extern const struct clkops clkops_omap3_core_dpll_ops;
 
 #endif
diff --git a/arch/arm/mach-omap2/clock3xxx_data.c b/arch/arm/mach-omap2/clock3xxx_data.c
index 3e9d721..7cf89f8 100644
--- a/arch/arm/mach-omap2/clock3xxx_data.c
+++ b/arch/arm/mach-omap2/clock3xxx_data.c
@@ -429,7 +429,7 @@ static struct dpll_data dpll3_dd = {
 
 static struct clk dpll3_ck = {
 	.name		= "dpll3_ck",
-	.ops		= &clkops_null,
+	.ops		= &clkops_omap3_core_dpll_ops,
 	.parent		= &sys_ck,
 	.dpll_data	= &dpll3_dd,
 	.round_rate	= &omap2_dpll_round_rate,
diff --git a/arch/arm/mach-omap2/clock44xx_data.c b/arch/arm/mach-omap2/clock44xx_data.c
index de9ec8d..b843b6e 100644
--- a/arch/arm/mach-omap2/clock44xx_data.c
+++ b/arch/arm/mach-omap2/clock44xx_data.c
@@ -443,7 +443,7 @@ static struct clk dpll_core_ck = {
 	.parent		= &sys_clkin_ck,
 	.dpll_data	= &dpll_core_dd,
 	.init		= &omap2_init_dpll_parent,
-	.ops		= &clkops_null,
+	.ops		= &clkops_omap3_core_dpll_ops,
 	.recalc		= &omap3_dpll_recalc,
 };
 
-- 
1.7.0.4

