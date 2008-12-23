From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 3/7] OMAP2/3 clock: store planned clock rates into temporary
	rate storage
Date: Tue, 23 Dec 2008 03:13:53 -0700
Message-ID: <20081223101352.22979.60139.stgit@localhost.localdomain>
References: <20081223101116.22979.53805.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:58104 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752910AbYLWKOi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 23 Dec 2008 05:14:38 -0500
In-Reply-To: <20081223101116.22979.53805.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Paul Walmsley <paul@pwsan.com>

In omap2_clk_set_rate() and omap2_clk_set_parent(), if a notifier
exists on this clock, precompute the rate that each clock will be set
to, and store that into the clk->temp_rate variable for each struct clk.
Also improve some debug while here.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/clock.c |   36 +++++++++++++++++++++++++-----------
 1 files changed, 25 insertions(+), 11 deletions(-)

diff --git a/arch/arm/mach-omap2/clock.c b/arch/arm/mach-omap2/clock.c
index c21767a..c990a17 100644
--- a/arch/arm/mach-omap2/clock.c
+++ b/arch/arm/mach-omap2/clock.c
@@ -790,10 +790,18 @@ int omap2_clk_set_rate(struct clk *clk, unsigned long rate)
 {
 	int ret = -EINVAL;
 
-	pr_debug("clock: set_rate for clock %s to rate %ld\n", clk->name, rate);
+	if (!clk->set_rate)
+		return -EINVAL;
+
+	if (clk->notifier_count) {
+		clk->temp_rate = rate;
+		propagate_rate(clk, TEMP_RATE);
+	}
+
+	pr_debug("clock: %s: set_rate from %ld Hz to %ld Hz\n", clk->name,
+		 clk->rate, rate);
 
-	if (clk->set_rate != NULL)
-		ret = clk->set_rate(clk, rate);
+	ret = clk->set_rate(clk, rate);
 
 	return ret;
 }
@@ -835,6 +843,7 @@ static u32 _omap2_clksel_get_src_field(struct clk *src_clk, struct clk *clk,
 int omap2_clk_set_parent(struct clk *clk, struct clk *new_parent)
 {
 	u32 field_val, v, parent_div;
+	unsigned long orig_rate, new_rate;
 
 	if (!clk->clksel)
 		return -EINVAL;
@@ -843,6 +852,16 @@ int omap2_clk_set_parent(struct clk *clk, struct clk *new_parent)
 	if (!parent_div)
 		return -EINVAL;
 
+	orig_rate = clk->rate;
+	new_rate = new_parent->rate;
+	if (parent_div > 0)
+		new_rate /= parent_div;
+
+	if (clk->notifier_count) {
+		clk->temp_rate = new_rate;
+		propagate_rate(clk, TEMP_RATE);
+	}
+
 	if (clk->usecount > 0)
 		_omap2_clk_disable(clk);
 
@@ -859,15 +878,10 @@ int omap2_clk_set_parent(struct clk *clk, struct clk *new_parent)
 		_omap2_clk_enable(clk);
 
 	clk->parent = new_parent;
+	clk->rate = new_rate;
 
-	/* CLKSEL clocks follow their parents' rates, divided by a divisor */
-	clk->rate = new_parent->rate;
-
-	if (parent_div > 0)
-		clk->rate /= parent_div;
-
-	pr_debug("clock: set parent of %s to %s (new rate %ld)\n",
-		 clk->name, clk->parent->name, clk->rate);
+	pr_debug("clock: %s: set parent to %s (orig rate %ld, new rate %ld)\n",
+		 clk->name, clk->parent->name, orig_rate, new_rate);
 
 	return 0;
 }


