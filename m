From: "Nayak, Rajendra" <rnayak@ti.com>
Subject: [PATCH 05/09] OMAP3 clock: Revert "OMAP2/3 clock: store planned
 clock rates into temporary rate storage"
Date: Fri, 20 Mar 2009 18:56:11 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB02FAF6EF22@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:39631 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752682AbZCTN0W convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 20 Mar 2009 09:26:22 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id n2KDQEx9010965
	for <linux-omap@vger.kernel.org>; Fri, 20 Mar 2009 08:26:20 -0500
Received: from dbde70.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id n2KDQDo6003024
	for <linux-omap@vger.kernel.org>; Fri, 20 Mar 2009 18:56:13 +0530 (IST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Nayak, Rajendra" <rnayak@ti.com>

From: Rajendra Nayak <rnayak@ti.com>

This reverts commit a5e87de0795f569e9eb75d2bc0c937f3170d9c19.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
Signed-off-by: Tero Kristo <tero.kristo@nokia.com>
---
 arch/arm/mach-omap2/clock.c |   36 +++++++++++-------------------------
 1 files changed, 11 insertions(+), 25 deletions(-)

diff --git a/arch/arm/mach-omap2/clock.c b/arch/arm/mach-omap2/clock.c
index c29ea77..612db25 100644
--- a/arch/arm/mach-omap2/clock.c
+++ b/arch/arm/mach-omap2/clock.c
@@ -784,18 +784,10 @@ int omap2_clk_set_rate(struct clk *clk, unsigned long rate)
 {
 	int ret = -EINVAL;
 
-	if (!clk->set_rate)
-		return -EINVAL;
-
-	if (clk->notifier_count) {
-		clk->temp_rate = rate;
-		propagate_rate(clk, TEMP_RATE);
-	}
-
-	pr_debug("clock: %s: set_rate from %ld Hz to %ld Hz\n", clk->name,
-		 clk->rate, rate);
+	pr_debug("clock: set_rate for clock %s to rate %ld\n", clk->name, rate);
 
-	ret = clk->set_rate(clk, rate);
+	if (clk->set_rate != NULL)
+		ret = clk->set_rate(clk, rate);
 
 	return ret;
 }
@@ -837,7 +829,6 @@ static u32 _omap2_clksel_get_src_field(struct clk *src_clk, struct clk *clk,
 int omap2_clk_set_parent(struct clk *clk, struct clk *new_parent)
 {
 	u32 field_val, v, parent_div;
-	unsigned long orig_rate, new_rate;
 
 	if (!clk->clksel)
 		return -EINVAL;
@@ -846,16 +837,6 @@ int omap2_clk_set_parent(struct clk *clk, struct clk *new_parent)
 	if (!parent_div)
 		return -EINVAL;
 
-	orig_rate = clk->rate;
-	new_rate = new_parent->rate;
-	if (parent_div > 0)
-		new_rate /= parent_div;
-
-	if (clk->notifier_count) {
-		clk->temp_rate = new_rate;
-		propagate_rate(clk, TEMP_RATE);
-	}
-
 	if (clk->usecount > 0)
 		_omap2_clk_disable(clk);
 
@@ -872,10 +853,15 @@ int omap2_clk_set_parent(struct clk *clk, struct clk *new_parent)
 		_omap2_clk_enable(clk);
 
 	clk->parent = new_parent;
-	clk->rate = new_rate;
 
-	pr_debug("clock: %s: set parent to %s (orig rate %ld, new rate %ld)\n",
-		 clk->name, clk->parent->name, orig_rate, new_rate);
+	/* CLKSEL clocks follow their parents' rates, divided by a divisor */
+	clk->rate = new_parent->rate;
+
+	if (parent_div > 0)
+		clk->rate /= parent_div;
+
+	pr_debug("clock: set parent of %s to %s (new rate %ld)\n",
+		 clk->name, clk->parent->name, clk->rate);
 
 	return 0;
 }
-- 
1.5.4.3
