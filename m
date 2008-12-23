From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 21/22] OMAP2/3 clock: don't tinker with hardirqs when they are
	supposed to be disabled
Date: Mon, 22 Dec 2008 23:38:46 -0700
Message-ID: <20081223063845.8542.11309.stgit@localhost.localdomain>
References: <20081223063709.8542.82882.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:52917 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753067AbYLWGjy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 23 Dec 2008 01:39:54 -0500
In-Reply-To: <20081223063709.8542.82882.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Paul Walmsley <paul@pwsan.com>

Clock rate change code executes inside a spinlock with hardirqs
disabled.  The only code that should be messing around with the
hardirq state should be the plat-omap/clock.c code.  In the
omap2_reprogram_dpllcore() case, this probably just wastes cycles, but
in the omap3_core_dpll_m2_set_rate() case, this is a nasty bug.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/clock24xx.c |   12 +++---------
 arch/arm/mach-omap2/clock34xx.c |    2 --
 2 files changed, 3 insertions(+), 11 deletions(-)

diff --git a/arch/arm/mach-omap2/clock24xx.c b/arch/arm/mach-omap2/clock24xx.c
index 67974d6..65584b7 100644
--- a/arch/arm/mach-omap2/clock24xx.c
+++ b/arch/arm/mach-omap2/clock24xx.c
@@ -220,10 +220,7 @@ static int omap2_reprogram_dpllcore(struct clk *clk, unsigned long rate)
 	u32 bypass = 0;
 	struct prcm_config tmpset;
 	const struct dpll_data *dd;
-	unsigned long flags;
-	int ret = -EINVAL;
 
-	local_irq_save(flags);
 	cur_rate = omap2xxx_clk_get_core_rate(&dpll_ck, dpll_ck.parent->rate);
 	mult = cm_read_mod_reg(PLL_MOD, CM_CLKSEL2);
 	mult &= OMAP24XX_CORE_CLK_SRC_MASK;
@@ -235,7 +232,7 @@ static int omap2_reprogram_dpllcore(struct clk *clk, unsigned long rate)
 	} else if (rate != cur_rate) {
 		valid_rate = omap2_dpllcore_round_rate(rate);
 		if (valid_rate != rate)
-			goto dpll_exit;
+			return -EINVAL;
 
 		if (mult == 1)
 			low = curr_prcm_set->dpll_speed;
@@ -244,7 +241,7 @@ static int omap2_reprogram_dpllcore(struct clk *clk, unsigned long rate)
 
 		dd = clk->dpll_data;
 		if (!dd)
-			goto dpll_exit;
+			return -EINVAL;
 
 		tmpset.cm_clksel1_pll = cm_read_mod_reg(clk->prcm_mod,
 							dd->mult_div1_reg);
@@ -282,11 +279,8 @@ static int omap2_reprogram_dpllcore(struct clk *clk, unsigned long rate)
 		omap2xxx_sdrc_init_params(omap2xxx_sdrc_dll_is_unlocked());
 		omap2xxx_sdrc_reprogram(done_rate, 0);
 	}
-	ret = 0;
 
-dpll_exit:
-	local_irq_restore(flags);
-	return(ret);
+	return 0;
 }
 
 /**
diff --git a/arch/arm/mach-omap2/clock34xx.c b/arch/arm/mach-omap2/clock34xx.c
index 917664d..1878282 100644
--- a/arch/arm/mach-omap2/clock34xx.c
+++ b/arch/arm/mach-omap2/clock34xx.c
@@ -491,10 +491,8 @@ static int omap3_core_dpll_m2_set_rate(struct clk *clk, unsigned long rate)
 	WARN_ON(new_div != 1 && new_div != 2);
 
 	/* REVISIT: Add SDRC_MR changing to this code also */
-	local_irq_disable();
 	omap3_configure_core_dpll(sp->rfr_ctrl, sp->actim_ctrla,
 				  sp->actim_ctrlb, new_div);
-	local_irq_enable();
 
 	return 0;
 }


