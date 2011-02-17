From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 4/5] OMAP: clock: bail out early if arch_clock functions not
	implemented
Date: Wed, 16 Feb 2011 21:17:55 -0700
Message-ID: <20110217041754.16009.57090.stgit@twilight.localdomain>
References: <20110217041437.16009.52336.stgit@twilight.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:55849 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752570Ab1BQESa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 16 Feb 2011 23:18:30 -0500
In-Reply-To: <20110217041437.16009.52336.stgit@twilight.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Bail out before we take the clockfw_lock spinlock if the corresponding
OMAP1 or OMAP2+ clock function is not defined.  The intention is to
reduce and simplify the work that is done inside the spinlock.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/plat-omap/clock.c |   66 +++++++++++++++++++++++++-------------------
 1 files changed, 38 insertions(+), 28 deletions(-)

diff --git a/arch/arm/plat-omap/clock.c b/arch/arm/plat-omap/clock.c
index 2770ddd..c9122dd 100644
--- a/arch/arm/plat-omap/clock.c
+++ b/arch/arm/plat-omap/clock.c
@@ -37,14 +37,16 @@ static struct clk_functions *arch_clock;
 int clk_enable(struct clk *clk)
 {
 	unsigned long flags;
-	int ret = 0;
+	int ret;
 
 	if (clk == NULL || IS_ERR(clk))
 		return -EINVAL;
 
+	if (!arch_clock || !arch_clock->clk_enable)
+		return -EINVAL;
+
 	spin_lock_irqsave(&clockfw_lock, flags);
-	if (arch_clock->clk_enable)
-		ret = arch_clock->clk_enable(clk);
+	ret = arch_clock->clk_enable(clk);
 	spin_unlock_irqrestore(&clockfw_lock, flags);
 
 	return ret;
@@ -58,6 +60,9 @@ void clk_disable(struct clk *clk)
 	if (clk == NULL || IS_ERR(clk))
 		return;
 
+	if (!arch_clock || !arch_clock->clk_disable)
+		return;
+
 	spin_lock_irqsave(&clockfw_lock, flags);
 	if (clk->usecount == 0) {
 		pr_err("Trying disable clock %s with 0 usecount\n",
@@ -66,8 +71,7 @@ void clk_disable(struct clk *clk)
 		goto out;
 	}
 
-	if (arch_clock->clk_disable)
-		arch_clock->clk_disable(clk);
+	arch_clock->clk_disable(clk);
 
 out:
 	spin_unlock_irqrestore(&clockfw_lock, flags);
@@ -77,7 +81,7 @@ EXPORT_SYMBOL(clk_disable);
 unsigned long clk_get_rate(struct clk *clk)
 {
 	unsigned long flags;
-	unsigned long ret = 0;
+	unsigned long ret;
 
 	if (clk == NULL || IS_ERR(clk))
 		return 0;
@@ -97,14 +101,16 @@ EXPORT_SYMBOL(clk_get_rate);
 long clk_round_rate(struct clk *clk, unsigned long rate)
 {
 	unsigned long flags;
-	long ret = 0;
+	long ret;
 
 	if (clk == NULL || IS_ERR(clk))
-		return ret;
+		return 0;
+
+	if (!arch_clock || !arch_clock->clk_round_rate)
+		return 0;
 
 	spin_lock_irqsave(&clockfw_lock, flags);
-	if (arch_clock->clk_round_rate)
-		ret = arch_clock->clk_round_rate(clk, rate);
+	ret = arch_clock->clk_round_rate(clk, rate);
 	spin_unlock_irqrestore(&clockfw_lock, flags);
 
 	return ret;
@@ -119,14 +125,13 @@ int clk_set_rate(struct clk *clk, unsigned long rate)
 	if (clk == NULL || IS_ERR(clk))
 		return ret;
 
+	if (!arch_clock || !arch_clock->clk_set_rate)
+		return ret;
+
 	spin_lock_irqsave(&clockfw_lock, flags);
-	if (arch_clock->clk_set_rate)
-		ret = arch_clock->clk_set_rate(clk, rate);
-	if (ret == 0) {
-		if (clk->recalc)
-			clk->rate = clk->recalc(clk);
+	ret = arch_clock->clk_set_rate(clk, rate);
+	if (ret == 0)
 		propagate_rate(clk);
-	}
 	spin_unlock_irqrestore(&clockfw_lock, flags);
 
 	return ret;
@@ -141,15 +146,14 @@ int clk_set_parent(struct clk *clk, struct clk *parent)
 	if (clk == NULL || IS_ERR(clk) || parent == NULL || IS_ERR(parent))
 		return ret;
 
+	if (!arch_clock || !arch_clock->clk_set_parent)
+		return ret;
+
 	spin_lock_irqsave(&clockfw_lock, flags);
 	if (clk->usecount == 0) {
-		if (arch_clock->clk_set_parent)
-			ret = arch_clock->clk_set_parent(clk, parent);
-		if (ret == 0) {
-			if (clk->recalc)
-				clk->rate = clk->recalc(clk);
+		ret = arch_clock->clk_set_parent(clk, parent);
+		if (ret == 0)
 			propagate_rate(clk);
-		}
 	} else
 		ret = -EBUSY;
 	spin_unlock_irqrestore(&clockfw_lock, flags);
@@ -399,9 +403,11 @@ void clk_init_cpufreq_table(struct cpufreq_frequency_table **table)
 {
 	unsigned long flags;
 
+	if (!arch_clock || !arch_clock->clk_init_cpufreq_table)
+		return;
+
 	spin_lock_irqsave(&clockfw_lock, flags);
-	if (arch_clock->clk_init_cpufreq_table)
-		arch_clock->clk_init_cpufreq_table(table);
+	arch_clock->clk_init_cpufreq_table(table);
 	spin_unlock_irqrestore(&clockfw_lock, flags);
 }
 
@@ -409,9 +415,11 @@ void clk_exit_cpufreq_table(struct cpufreq_frequency_table **table)
 {
 	unsigned long flags;
 
+	if (!arch_clock || !arch_clock->clk_exit_cpufreq_table)
+		return;
+
 	spin_lock_irqsave(&clockfw_lock, flags);
-	if (arch_clock->clk_exit_cpufreq_table)
-		arch_clock->clk_exit_cpufreq_table(table);
+	arch_clock->clk_exit_cpufreq_table(table);
 	spin_unlock_irqrestore(&clockfw_lock, flags);
 }
 #endif
@@ -429,6 +437,9 @@ static int __init clk_disable_unused(void)
 	struct clk *ck;
 	unsigned long flags;
 
+	if (!arch_clock || !arch_clock->clk_disable_unused)
+		return 0;
+
 	pr_info("clock: disabling unused clocks to save power\n");
 	list_for_each_entry(ck, &clocks, node) {
 		if (ck->ops == &clkops_null)
@@ -438,8 +449,7 @@ static int __init clk_disable_unused(void)
 			continue;
 
 		spin_lock_irqsave(&clockfw_lock, flags);
-		if (arch_clock->clk_disable_unused)
-			arch_clock->clk_disable_unused(ck);
+		arch_clock->clk_disable_unused(ck);
 		spin_unlock_irqrestore(&clockfw_lock, flags);
 	}
 


