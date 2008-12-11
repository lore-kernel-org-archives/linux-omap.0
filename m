From: Tero Kristo <tero.kristo@nokia.com>
Subject: [PATCH 10/23] OMAP3 clock: use pr_debug() rather than pr_info() in some clock change code
Date: Thu, 11 Dec 2008 17:52:29 +0200
Message-ID: <1229010762-3150-11-git-send-email-tero.kristo@nokia.com>
References: <>
 <1229010762-3150-1-git-send-email-tero.kristo@nokia.com>
 <1229010762-3150-2-git-send-email-tero.kristo@nokia.com>
 <1229010762-3150-3-git-send-email-tero.kristo@nokia.com>
 <1229010762-3150-4-git-send-email-tero.kristo@nokia.com>
 <1229010762-3150-5-git-send-email-tero.kristo@nokia.com>
 <1229010762-3150-6-git-send-email-tero.kristo@nokia.com>
 <1229010762-3150-7-git-send-email-tero.kristo@nokia.com>
 <1229010762-3150-8-git-send-email-tero.kristo@nokia.com>
 <1229010762-3150-9-git-send-email-tero.kristo@nokia.com>
 <1229010762-3150-10-git-send-email-tero.kristo@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:53975 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756224AbYLKP7X (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Dec 2008 10:59:23 -0500
In-Reply-To: <1229010762-3150-10-git-send-email-tero.kristo@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Paul Walmsley <paul@pwsan.com>

From: Paul Walmsley <paul@pwsan.com>

The CORE DPLL M2 frequency change code should use pr_debug(), not
pr_info(), for its debug messages.  Same with
omap2_clksel_round_rate_div().  While here, convert a few printk(KERN_ERR ..
into pr_err().

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/clock.c     |   12 ++++++------
 arch/arm/mach-omap2/clock34xx.c |    8 ++++----
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-omap2/clock.c b/arch/arm/mach-omap2/clock.c
index b4ef3a3..7c7e60e 100644
--- a/arch/arm/mach-omap2/clock.c
+++ b/arch/arm/mach-omap2/clock.c
@@ -564,8 +564,8 @@ u32 omap2_clksel_round_rate_div(struct clk *clk, unsigned long target_rate,
 	const struct clksel_rate *clkr;
 	u32 last_div = 0;
 
-	printk(KERN_INFO "clock: clksel_round_rate_div: %s target_rate %ld\n",
-	       clk->name, target_rate);
+	pr_debug("clock: clksel_round_rate_div: %s target_rate %ld\n",
+		 clk->name, target_rate);
 
 	*new_div = 1;
 
@@ -579,7 +579,7 @@ u32 omap2_clksel_round_rate_div(struct clk *clk, unsigned long target_rate,
 
 		/* Sanity check */
 		if (clkr->div <= last_div)
-			printk(KERN_ERR "clock: clksel_rate table not sorted "
+			pr_err("clock: clksel_rate table not sorted "
 			       "for clock %s", clk->name);
 
 		last_div = clkr->div;
@@ -591,7 +591,7 @@ u32 omap2_clksel_round_rate_div(struct clk *clk, unsigned long target_rate,
 	}
 
 	if (!clkr->div) {
-		printk(KERN_ERR "clock: Could not find divisor for target "
+		pr_err("clock: Could not find divisor for target "
 		       "rate %ld for clock %s parent %s\n", target_rate,
 		       clk->name, clk->parent->name);
 		return ~0;
@@ -599,8 +599,8 @@ u32 omap2_clksel_round_rate_div(struct clk *clk, unsigned long target_rate,
 
 	*new_div = clkr->div;
 
-	printk(KERN_INFO "clock: new_div = %d, new_rate = %ld\n", *new_div,
-	       (clk->parent->rate / clkr->div));
+	pr_debug("clock: new_div = %d, new_rate = %ld\n", *new_div,
+		 (clk->parent->rate / clkr->div));
 
 	return (clk->parent->rate / clkr->div);
 }
diff --git a/arch/arm/mach-omap2/clock34xx.c b/arch/arm/mach-omap2/clock34xx.c
index efeb9c9..adf0be3 100644
--- a/arch/arm/mach-omap2/clock34xx.c
+++ b/arch/arm/mach-omap2/clock34xx.c
@@ -517,10 +517,10 @@ static int omap3_core_dpll_m2_set_rate(struct clk *clk, unsigned long rate)
 		unlock_dll = 1;
 	}
 
-	pr_info("clock: changing CORE DPLL rate from %lu to %lu\n", clk->rate,
-		validrate);
-	pr_info("clock: SDRC timing params used: %08x %08x %08x\n",
-		sp->rfr_ctrl, sp->actim_ctrla, sp->actim_ctrlb);
+	pr_debug("clock: changing CORE DPLL rate from %lu to %lu\n", clk->rate,
+		 validrate);
+	pr_debug("clock: SDRC timing params used: %08x %08x %08x\n",
+		 sp->rfr_ctrl, sp->actim_ctrla, sp->actim_ctrlb);
 
 	/* REVISIT: SRAM code doesn't support other M2 divisors yet */
 	WARN_ON(new_div != 1 && new_div != 2);
-- 
1.5.4.3

