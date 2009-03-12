From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 86/86] [ARM] omap: clk_set_parent: deny changing parent if clock is enabled
Date: Thu, 12 Mar 2009 11:28:36 -0700
Message-ID: <1236882516-29403-87-git-send-email-khilman@deeprootsystems.com>
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
 <1236882516-29403-73-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-74-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-75-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-76-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-77-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-78-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-79-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-80-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-81-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-82-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-83-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-84-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-85-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-86-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.172]:64521 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757273AbZCLSew (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Mar 2009 14:34:52 -0400
Received: by wf-out-1314.google.com with SMTP id 28so1250318wfa.4
        for <linux-omap@vger.kernel.org>; Thu, 12 Mar 2009 11:34:50 -0700 (PDT)
In-Reply-To: <1236882516-29403-86-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

From: Russell King <rmk@dyn-67.arm.linux.org.uk>

Richard Woodruff writes:
| The historic usage of this has been against single use leaf clocks
| (1st instance of gptimer).  When it was used it did:
|       clk_get()
|       clk_set_parent()
|       clk_enable()
|
| This usage was ok for that. Use on a disabled clock is needed.
|
| If there are multiple users on the clock or it is enabled there are
| problems.
|
| The call can still be unfriendly if 2 different drivers are using the
| clock with their own clock get/enable. It might be the function should
| return an error if usecount != 0 to stop surprises.  It is all around
| better if the parenting is done when the clock is off.

This is a good reason to ensure that the clock is not enabled when
clk_set_parent() is called.

Acked-by: Richard Woodruff <r-woodruff2@ti.com>
Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-omap2/clock.c |    6 ------
 arch/arm/plat-omap/clock.c  |   17 ++++++++++-------
 2 files changed, 10 insertions(+), 13 deletions(-)

diff --git a/arch/arm/mach-omap2/clock.c b/arch/arm/mach-omap2/clock.c
index 40cb65b..f49bce9 100644
--- a/arch/arm/mach-omap2/clock.c
+++ b/arch/arm/mach-omap2/clock.c
@@ -807,9 +807,6 @@ int omap2_clk_set_parent(struct clk *clk, struct clk *new_parent)
 	if (!parent_div)
 		return -EINVAL;
 
-	if (clk->usecount > 0)
-		_omap2_clk_disable(clk);
-
 	/* Set new source value (previous dividers if any in effect) */
 	v = __raw_readl(clk->clksel_reg);
 	v &= ~clk->clksel_mask;
@@ -819,9 +816,6 @@ int omap2_clk_set_parent(struct clk *clk, struct clk *new_parent)
 
 	_omap2xxx_clk_commit(clk);
 
-	if (clk->usecount > 0)
-		_omap2_clk_enable(clk);
-
 	clk_reparent(clk, new_parent);
 
 	/* CLKSEL clocks follow their parents' rates, divided by a divisor */
diff --git a/arch/arm/plat-omap/clock.c b/arch/arm/plat-omap/clock.c
index 08baa18..2e06145 100644
--- a/arch/arm/plat-omap/clock.c
+++ b/arch/arm/plat-omap/clock.c
@@ -144,13 +144,16 @@ int clk_set_parent(struct clk *clk, struct clk *parent)
 		return ret;
 
 	spin_lock_irqsave(&clockfw_lock, flags);
-	if (arch_clock->clk_set_parent)
-		ret = arch_clock->clk_set_parent(clk, parent);
-	if (ret == 0) {
-		if (clk->recalc)
-			clk->rate = clk->recalc(clk);
-		propagate_rate(clk);
-	}
+	if (clk->usecount == 0) {
+		if (arch_clock->clk_set_parent)
+			ret = arch_clock->clk_set_parent(clk, parent);
+		if (ret == 0) {
+			if (clk->recalc)
+				clk->rate = clk->recalc(clk);
+			propagate_rate(clk);
+		}
+	} else
+		ret = -EBUSY;
 	spin_unlock_irqrestore(&clockfw_lock, flags);
 
 	return ret;
-- 
1.6.1.2

