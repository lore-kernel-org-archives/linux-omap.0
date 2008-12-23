From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 02/22] OMAP clock: move rate recalc,
	propagation code up to plat-omap/clock.c
Date: Mon, 22 Dec 2008 23:38:29 -0700
Message-ID: <20081223063828.8542.93926.stgit@localhost.localdomain>
References: <20081223063709.8542.82882.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:52854 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752127AbYLWGjg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 23 Dec 2008 01:39:36 -0500
In-Reply-To: <20081223063709.8542.82882.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Paul Walmsley <paul@pwsan.com>

Previously the individual clock recalculation functions handled their
own rate recalculation.  This can be handled in the clk_set_rate(),
clk_set_parent(), and recalculate_root_clocks() functions in
plat-omap/clock.c.  Removes duplicate code and clarifies the role of the
recalc functions.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap1/clock.c     |   14 --------------
 arch/arm/mach-omap2/clock.c     |   12 ------------
 arch/arm/mach-omap2/clock24xx.c |    6 ------
 arch/arm/mach-omap2/clock34xx.c |    9 ---------
 arch/arm/plat-omap/clock.c      |   34 +++++++++++++++++++++++++++-------
 5 files changed, 27 insertions(+), 48 deletions(-)

diff --git a/arch/arm/mach-omap1/clock.c b/arch/arm/mach-omap1/clock.c
index 4d0c444..ae2b304 100644
--- a/arch/arm/mach-omap1/clock.c
+++ b/arch/arm/mach-omap1/clock.c
@@ -225,9 +225,6 @@ static void omap1_ckctl_recalc(struct clk * clk)
 	if (unlikely(clk->rate == clk->parent->rate / dsor))
 		return; /* No change, quick exit */
 	clk->rate = clk->parent->rate / dsor;
-
-	if (unlikely(clk->flags & RATE_PROPAGATES))
-		propagate_rate(clk);
 }
 
 static void omap1_ckctl_recalc_dsp_domain(struct clk * clk)
@@ -248,9 +245,6 @@ static void omap1_ckctl_recalc_dsp_domain(struct clk * clk)
 	if (unlikely(clk->rate == clk->parent->rate / dsor))
 		return; /* No change, quick exit */
 	clk->rate = clk->parent->rate / dsor;
-
-	if (unlikely(clk->flags & RATE_PROPAGATES))
-		propagate_rate(clk);
 }
 
 /* MPU virtual clock functions */
@@ -314,9 +308,6 @@ static int omap1_clk_set_rate_dsp_domain(struct clk *clk, unsigned long rate)
 		ret = 0;
 	}
 
-	if (unlikely(ret == 0 && (clk->flags & RATE_PROPAGATES)))
-		propagate_rate(clk);
-
 	return ret;
 }
 
@@ -423,8 +414,6 @@ static int omap1_set_sossi_rate(struct clk *clk, unsigned long rate)
 	omap_writel(l, MOD_CONF_CTRL_1);
 
 	clk->rate = p_rate / (div + 1);
-	if (unlikely(clk->flags & RATE_PROPAGATES))
-		propagate_rate(clk);
 
 	return 0;
 }
@@ -583,9 +572,6 @@ static int omap1_clk_set_rate(struct clk *clk, unsigned long rate)
 		ret = 0;
 	}
 
-	if (unlikely(ret == 0 && (clk->flags & RATE_PROPAGATES)))
-		propagate_rate(clk);
-
 	return ret;
 }
 
diff --git a/arch/arm/mach-omap2/clock.c b/arch/arm/mach-omap2/clock.c
index 8a064b3..13db3d5 100644
--- a/arch/arm/mach-omap2/clock.c
+++ b/arch/arm/mach-omap2/clock.c
@@ -302,9 +302,6 @@ void omap2_fixed_divisor_recalc(struct clk *clk)
 	WARN_ON(!clk->fixed_div);
 
 	clk->rate = clk->parent->rate / clk->fixed_div;
-
-	if (clk->flags & RATE_PROPAGATES)
-		propagate_rate(clk);
 }
 
 /**
@@ -506,9 +503,6 @@ void omap2_clksel_recalc(struct clk *clk)
 	clk->rate = clk->parent->rate / div;
 
 	pr_debug("clock: new clock rate is %ld (div %d)\n", clk->rate, div);
-
-	if (clk->flags & RATE_PROPAGATES)
-		propagate_rate(clk);
 }
 
 /**
@@ -779,9 +773,6 @@ int omap2_clk_set_rate(struct clk *clk, unsigned long rate)
 	if (clk->set_rate != NULL)
 		ret = clk->set_rate(clk, rate);
 
-	if (ret == 0 && (clk->flags & RATE_PROPAGATES))
-		propagate_rate(clk);
-
 	return ret;
 }
 
@@ -863,9 +854,6 @@ int omap2_clk_set_parent(struct clk *clk, struct clk *new_parent)
 	pr_debug("clock: set parent of %s to %s (new rate %ld)\n",
 		 clk->name, clk->parent->name, clk->rate);
 
-	if (clk->flags & RATE_PROPAGATES)
-		propagate_rate(clk);
-
 	return 0;
 }
 
diff --git a/arch/arm/mach-omap2/clock24xx.c b/arch/arm/mach-omap2/clock24xx.c
index 8567de2..9e1328f 100644
--- a/arch/arm/mach-omap2/clock24xx.c
+++ b/arch/arm/mach-omap2/clock24xx.c
@@ -178,8 +178,6 @@ static long omap2_dpllcore_round_rate(unsigned long target_rate)
 static void omap2_dpllcore_recalc(struct clk *clk)
 {
 	clk->rate = omap2xxx_clk_get_core_rate(clk);
-
-	propagate_rate(clk);
 }
 
 static int omap2_reprogram_dpllcore(struct clk *clk, unsigned long rate)
@@ -250,7 +248,6 @@ static int omap2_reprogram_dpllcore(struct clk *clk, unsigned long rate)
 		omap2xxx_sdrc_init_params(omap2xxx_sdrc_dll_is_unlocked());
 		omap2xxx_sdrc_reprogram(done_rate, 0);
 	}
-	omap2_dpllcore_recalc(&dpll_ck);
 	ret = 0;
 
 dpll_exit:
@@ -379,7 +376,6 @@ static int omap2_select_table_rate(struct clk *clk, unsigned long rate)
 
 		local_irq_restore(flags);
 	}
-	omap2_dpllcore_recalc(&dpll_ck);
 
 	return 0;
 }
@@ -469,13 +465,11 @@ static u32 omap2_get_sysclkdiv(void)
 static void omap2_osc_clk_recalc(struct clk *clk)
 {
 	clk->rate = omap2_get_apll_clkin() * omap2_get_sysclkdiv();
-	propagate_rate(clk);
 }
 
 static void omap2_sys_clk_recalc(struct clk *clk)
 {
 	clk->rate = clk->parent->rate / omap2_get_sysclkdiv();
-	propagate_rate(clk);
 }
 
 /*
diff --git a/arch/arm/mach-omap2/clock34xx.c b/arch/arm/mach-omap2/clock34xx.c
index 738a029..22cbcce 100644
--- a/arch/arm/mach-omap2/clock34xx.c
+++ b/arch/arm/mach-omap2/clock34xx.c
@@ -54,8 +54,6 @@
 static void omap3_dpll_recalc(struct clk *clk)
 {
 	clk->rate = omap2_get_dpll_rate(clk);
-
-	propagate_rate(clk);
 }
 
 /* _omap3_dpll_write_clken - write clken_bits arg to a DPLL's enable bits */
@@ -429,8 +427,6 @@ static int omap3_noncore_dpll_set_rate(struct clk *clk, unsigned long rate)
 
 	}
 
-	omap3_dpll_recalc(clk);
-
 	return 0;
 }
 
@@ -493,8 +489,6 @@ static int omap3_core_dpll_m2_set_rate(struct clk *clk, unsigned long rate)
 				  sp->actim_ctrlb, new_div);
 	local_irq_enable();
 
-	omap2_clksel_recalc(clk);
-
 	return 0;
 }
 
@@ -612,9 +606,6 @@ static void omap3_clkoutx2_recalc(struct clk *clk)
 		clk->rate = clk->parent->rate;
 	else
 		clk->rate = clk->parent->rate * 2;
-
-	if (clk->flags & RATE_PROPAGATES)
-		propagate_rate(clk);
 }
 
 /* Common clock code */
diff --git a/arch/arm/plat-omap/clock.c b/arch/arm/plat-omap/clock.c
index d13acd2..9f458cb 100644
--- a/arch/arm/plat-omap/clock.c
+++ b/arch/arm/plat-omap/clock.c
@@ -183,8 +183,16 @@ int clk_set_rate(struct clk *clk, unsigned long rate)
 		return ret;
 
 	spin_lock_irqsave(&clockfw_lock, flags);
-	if (arch_clock->clk_set_rate)
+
+	if (arch_clock->clk_set_rate) {
 		ret = arch_clock->clk_set_rate(clk, rate);
+		if (ret == 0) {
+			(*clk->recalc)(clk);
+			if (clk->flags & RATE_PROPAGATES)
+				propagate_rate(clk);
+		}
+	}
+
 	spin_unlock_irqrestore(&clockfw_lock, flags);
 
 	return ret;
@@ -200,8 +208,16 @@ int clk_set_parent(struct clk *clk, struct clk *parent)
 		return ret;
 
 	spin_lock_irqsave(&clockfw_lock, flags);
-	if (arch_clock->clk_set_parent)
-		ret =  arch_clock->clk_set_parent(clk, parent);
+
+	if (arch_clock->clk_set_parent) {
+		ret = arch_clock->clk_set_parent(clk, parent);
+		if (ret == 0) {
+			(*clk->recalc)(clk);
+			if (clk->flags & RATE_PROPAGATES)
+				propagate_rate(clk);
+		}
+	}
+
 	spin_unlock_irqrestore(&clockfw_lock, flags);
 
 	return ret;
@@ -256,8 +272,6 @@ void followparent_recalc(struct clk *clk)
 		return;
 
 	clk->rate = clk->parent->rate;
-	if (unlikely(clk->flags & RATE_PROPAGATES))
-		propagate_rate(clk);
 }
 
 /* Propagate rate to children */
@@ -271,8 +285,11 @@ void propagate_rate(struct clk * tclk)
 	list_for_each_entry(clkp, &clocks, node) {
 		if (likely(clkp->parent != tclk))
 			continue;
-		if (likely((u32)clkp->recalc))
+		if (likely((u32)clkp->recalc)) {
 			clkp->recalc(clkp);
+			if (clkp->flags & RATE_PROPAGATES)
+				propagate_rate(clkp);
+		}
 	}
 }
 
@@ -288,8 +305,11 @@ void recalculate_root_clocks(void)
 	struct clk *clkp;
 
 	list_for_each_entry(clkp, &clocks, node) {
-		if (unlikely(!clkp->parent) && likely((u32)clkp->recalc))
+		if (unlikely(!clkp->parent) && likely((u32)clkp->recalc)) {
 			clkp->recalc(clkp);
+			if (clkp->flags & RATE_PROPAGATES)
+				propagate_rate(clkp);
+		}
 	}
 }
 


