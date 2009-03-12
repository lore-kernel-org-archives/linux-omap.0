From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 72/86] [ARM] omap: clks: call recalc after any rate change
Date: Thu, 12 Mar 2009 11:28:22 -0700
Message-ID: <1236882516-29403-73-git-send-email-khilman@deeprootsystems.com>
References: <1236882516-29403-1-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-2-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-3-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-4-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-5-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-6-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-7-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-8-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-9-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-10-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-11-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-12-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-13-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-14-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-15-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-16-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-17-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-18-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-19-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-20-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-21-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-22-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-23-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-24-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-25-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-26-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-27-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-28-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-29-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-30-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-31-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-32-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-33-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-34-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-35-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-36-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-37-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-38-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-39-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-40-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-41-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-42-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-43-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-44-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-45-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-46-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-47-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-48-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-49-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-50-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-51-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-52-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-53-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-54-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-55-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-56-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-57-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-58-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-59-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-60-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-61-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-62-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-63-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-64-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-65-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-66-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-67-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-68-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-69-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-70-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-71-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-72-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ag-out-0708.google.com ([72.14.246.250]:55744 "EHLO
	ag-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757257AbZCLSdv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Mar 2009 14:33:51 -0400
Received: by ag-out-0708.google.com with SMTP id 26so1107479agb.10
        for <linux-omap@vger.kernel.org>; Thu, 12 Mar 2009 11:33:49 -0700 (PDT)
In-Reply-To: <1236882516-29403-72-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

From: Russell King <rmk@dyn-67.arm.linux.org.uk>

This implements the remainder of:
  OMAP clock: move rate recalc, propagation code up to plat-omap/clock.c
from Paul Walmsley which is not covered by the previous:
  [ARM] omap: move clock propagation into core omap clock code
  [ARM] omap: remove unnecessary calls to propagate_rate()
  [ARM] omap: move propagate_rate() calls into generic omap clock code
commits.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-omap2/clock24xx.c |    2 --
 arch/arm/mach-omap2/clock34xx.c |    4 ----
 arch/arm/plat-omap/clock.c      |   16 ++++++++++++----
 3 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-omap2/clock24xx.c b/arch/arm/mach-omap2/clock24xx.c
index 2ce8c02..4564ae3 100644
--- a/arch/arm/mach-omap2/clock24xx.c
+++ b/arch/arm/mach-omap2/clock24xx.c
@@ -441,7 +441,6 @@ static int omap2_reprogram_dpllcore(struct clk *clk, unsigned long rate)
 		omap2xxx_sdrc_init_params(omap2xxx_sdrc_dll_is_unlocked());
 		omap2xxx_sdrc_reprogram(done_rate, 0);
 	}
-	omap2_dpllcore_recalc(&dpll_ck);
 	ret = 0;
 
 dpll_exit:
@@ -570,7 +569,6 @@ static int omap2_select_table_rate(struct clk *clk, unsigned long rate)
 
 		local_irq_restore(flags);
 	}
-	omap2_dpllcore_recalc(&dpll_ck);
 
 	return 0;
 }
diff --git a/arch/arm/mach-omap2/clock34xx.c b/arch/arm/mach-omap2/clock34xx.c
index 06a81fe..75eb254 100644
--- a/arch/arm/mach-omap2/clock34xx.c
+++ b/arch/arm/mach-omap2/clock34xx.c
@@ -614,8 +614,6 @@ static int omap3_noncore_dpll_set_rate(struct clk *clk, unsigned long rate)
 	omap3_noncore_dpll_program(clk, dd->last_rounded_m, dd->last_rounded_n,
 				   freqsel);
 
-	omap3_dpll_recalc(clk);
-
 	return 0;
 }
 
@@ -693,8 +691,6 @@ static int omap3_core_dpll_m2_set_rate(struct clk *clk, unsigned long rate)
 				  sp->actim_ctrlb, new_div);
 	local_irq_enable();
 
-	omap2_clksel_recalc(clk);
-
 	return 0;
 }
 
diff --git a/arch/arm/plat-omap/clock.c b/arch/arm/plat-omap/clock.c
index 5272a22..54da27a 100644
--- a/arch/arm/plat-omap/clock.c
+++ b/arch/arm/plat-omap/clock.c
@@ -140,8 +140,12 @@ int clk_set_rate(struct clk *clk, unsigned long rate)
 	spin_lock_irqsave(&clockfw_lock, flags);
 	if (arch_clock->clk_set_rate)
 		ret = arch_clock->clk_set_rate(clk, rate);
-	if (ret == 0 && (clk->flags & RATE_PROPAGATES))
-		propagate_rate(clk);
+	if (ret == 0) {
+		if (clk->recalc)
+			clk->recalc(clk);
+		if (clk->flags & RATE_PROPAGATES)
+			propagate_rate(clk);
+	}
 	spin_unlock_irqrestore(&clockfw_lock, flags);
 
 	return ret;
@@ -159,8 +163,12 @@ int clk_set_parent(struct clk *clk, struct clk *parent)
 	spin_lock_irqsave(&clockfw_lock, flags);
 	if (arch_clock->clk_set_parent)
 		ret = arch_clock->clk_set_parent(clk, parent);
-	if (ret == 0 && (clk->flags & RATE_PROPAGATES))
-		propagate_rate(clk);
+	if (ret == 0) {
+		if (clk->recalc)
+			clk->recalc(clk);
+		if (clk->flags & RATE_PROPAGATES)
+			propagate_rate(clk);
+	}
 	spin_unlock_irqrestore(&clockfw_lock, flags);
 
 	return ret;
-- 
1.6.1.2

