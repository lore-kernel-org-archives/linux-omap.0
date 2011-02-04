From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH v2 6/9] omap: dpll: Add allow_idle/deny_idle support for all DPLL's
Date: Fri,  4 Feb 2011 15:29:01 +0530
Message-ID: <1296813544-25170-7-git-send-email-santosh.shilimkar@ti.com>
References: <1296813544-25170-1-git-send-email-santosh.shilimkar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:55026 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754850Ab1BDJ7Y (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 4 Feb 2011 04:59:24 -0500
In-Reply-To: <1296813544-25170-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@ti.com, paul@pwsan.com, b-cousson@ti.com, rnayak@ti.com, linux-arm-kernel@lists.infradead.org

From: Rajendra Nayak <rnayak@ti.com>

All OMAP3/4 dpll's support hardware level autogating.
Populate allow_idle/deny_idle function pointers for all
DPLL's in clkops.

Also for OMAP4, call omap_clk_enable_autoidle() from PM
core (only with CONFIG_PM) to enable hardware level
autogating on all clock nodes which support it (For now
only DPLL nodes)

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/clock.c          |    8 +++++++-
 arch/arm/mach-omap2/clock.h          |    1 +
 arch/arm/mach-omap2/clock3xxx_data.c |    2 +-
 arch/arm/mach-omap2/clock44xx_data.c |    2 +-
 arch/arm/mach-omap2/pm44xx.c         |    4 ++++
 5 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/clock.c b/arch/arm/mach-omap2/clock.c
index 5c08c18..8ec618e 100644
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
index 403a4a1..20a7118 100644
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
index e8cb32f..3fb8d2b 100644
--- a/arch/arm/mach-omap2/clock44xx_data.c
+++ b/arch/arm/mach-omap2/clock44xx_data.c
@@ -444,7 +444,7 @@ static struct clk dpll_core_ck = {
 	.parent		= &sys_clkin_ck,
 	.dpll_data	= &dpll_core_dd,
 	.init		= &omap2_init_dpll_parent,
-	.ops		= &clkops_null,
+	.ops		= &clkops_omap3_core_dpll_ops,
 	.recalc		= &omap3_dpll_recalc,
 };
 
diff --git a/arch/arm/mach-omap2/pm44xx.c b/arch/arm/mach-omap2/pm44xx.c
index 76cfff2..8431d41 100644
--- a/arch/arm/mach-omap2/pm44xx.c
+++ b/arch/arm/mach-omap2/pm44xx.c
@@ -15,6 +15,7 @@
 #include <linux/list.h>
 #include <linux/err.h>
 #include <linux/slab.h>
+#include <plat/clock.h>
 
 #include "powerdomain.h"
 #include <mach/omap4-common.h>
@@ -111,6 +112,9 @@ static int __init omap4_pm_init(void)
 		pr_err("Failed to setup powerdomains\n");
 		goto err2;
 	}
+
+	/* Enable autoidle for all clks which support it*/
+	omap_clk_enable_autoidle();
 #endif
 
 #ifdef CONFIG_SUSPEND
-- 
1.6.0.4

