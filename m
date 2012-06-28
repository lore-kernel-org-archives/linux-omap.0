From: Vaibhav Hiremath <hvaibhav@ti.com>
Subject: [PATCH-V3 2/3] ARM: OMAP2+: CLEANUP: Move omap3 dpll ops to dpll3xxx.c
Date: Thu, 28 Jun 2012 20:29:26 +0530
Message-ID: <1340895567-22766-3-git-send-email-hvaibhav@ti.com>
References: <1340895567-22766-1-git-send-email-hvaibhav@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:44268 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753561Ab2F1O7n (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 28 Jun 2012 10:59:43 -0400
In-Reply-To: <1340895567-22766-1-git-send-email-hvaibhav@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tony@atomide.com, linux-arm-kernel@lists.infradead.org, Vaibhav Hiremath <hvaibhav@ti.com>, Kevin Hilman <khilman@ti.com>

In order to remove unnecessary idefs, move noncore and core
dpll ops to dpll3xxx.c file (where it should have been already).

The clkops (clkops_omap3_core_dpll_ops & clkops_omap3_noncore_dpll_ops)
is used in clock data files, and dependency is already handled by
Makefile rule.

Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
Acked-by: Paul Walmsley <paul@pwsan.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Kevin Hilman <khilman@ti.com>

NOTE: No code change from last version.
---
 arch/arm/mach-omap2/clock.c    |   18 ------------------
 arch/arm/mach-omap2/dpll3xxx.c |   14 ++++++++++++++
 2 files changed, 14 insertions(+), 18 deletions(-)

diff --git a/arch/arm/mach-omap2/clock.c b/arch/arm/mach-omap2/clock.c
index 5c4e665..ea3f565 100644
--- a/arch/arm/mach-omap2/clock.c
+++ b/arch/arm/mach-omap2/clock.c
@@ -398,24 +398,6 @@ int omap2_clk_set_parent(struct clk *clk, struct clk *new_parent)
 	return omap2_clksel_set_parent(clk, new_parent);
 }

-/* OMAP3/4 non-CORE DPLL clkops */
-
-#if defined(CONFIG_ARCH_OMAP3) || defined(CONFIG_ARCH_OMAP4)
-
-const struct clkops clkops_omap3_noncore_dpll_ops = {
-	.enable		= omap3_noncore_dpll_enable,
-	.disable	= omap3_noncore_dpll_disable,
-	.allow_idle	= omap3_dpll_allow_idle,
-	.deny_idle	= omap3_dpll_deny_idle,
-};
-
-const struct clkops clkops_omap3_core_dpll_ops = {
-	.allow_idle	= omap3_dpll_allow_idle,
-	.deny_idle	= omap3_dpll_deny_idle,
-};
-
-#endif
-
 /*
  * OMAP2+ clock reset and init functions
  */
diff --git a/arch/arm/mach-omap2/dpll3xxx.c b/arch/arm/mach-omap2/dpll3xxx.c
index f0f10be..ff6f237 100644
--- a/arch/arm/mach-omap2/dpll3xxx.c
+++ b/arch/arm/mach-omap2/dpll3xxx.c
@@ -628,3 +628,17 @@ unsigned long omap3_clkoutx2_recalc(struct clk *clk)
 		rate = clk->parent->rate * 2;
 	return rate;
 }
+
+/* OMAP3/4 non-CORE DPLL clkops */
+
+const struct clkops clkops_omap3_noncore_dpll_ops = {
+	.enable		= omap3_noncore_dpll_enable,
+	.disable	= omap3_noncore_dpll_disable,
+	.allow_idle	= omap3_dpll_allow_idle,
+	.deny_idle	= omap3_dpll_deny_idle,
+};
+
+const struct clkops clkops_omap3_core_dpll_ops = {
+	.allow_idle	= omap3_dpll_allow_idle,
+	.deny_idle	= omap3_dpll_deny_idle,
+};
--
1.7.0.4

