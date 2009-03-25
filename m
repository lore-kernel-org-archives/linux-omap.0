From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 1/2] OMAP clock: add clk_round_rate_parent (with OMAP2/3
	implementation)
Date: Wed, 25 Mar 2009 10:09:21 -0600
Message-ID: <20090325160920.31866.22103.stgit@localhost.localdomain>
References: <20090325160759.31866.49722.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:41120 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757474AbZCYQK7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 25 Mar 2009 12:10:59 -0400
In-Reply-To: <20090325160759.31866.49722.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Paul Walmsley <paul@pwsan.com>

This patch adds clk_round_rate_parent(), a means for internal clock
code to determine what a clock's rate would be if its parent changed.
This is needed by the pre-change clock notifier, which passes the
current clock rate and the desired clock rate to its callbacks.

An implementation is provided for the OMAP2/3 architecture
(omap2_clk_round_rate_parent)..

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/clock.c             |   30 ++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/clock.h             |    1 +
 arch/arm/mach-omap2/clock24xx.c         |    1 +
 arch/arm/mach-omap2/clock34xx.c         |    1 +
 arch/arm/plat-omap/include/mach/clock.h |    2 ++
 5 files changed, 35 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/clock.c b/arch/arm/mach-omap2/clock.c
index 41662fd..65391ba 100644
--- a/arch/arm/mach-omap2/clock.c
+++ b/arch/arm/mach-omap2/clock.c
@@ -871,6 +871,36 @@ struct clk *omap2_clk_get_parent(struct clk *clk)
 	return clk->parent;
 }
 
+/**
+ * omap2_clk_round_rate_parent - return the rate for @clk if parent were changed
+ * @clk: struct clk that may change parents
+ * @new_parent: the struct clk that @clk may be reparented under
+ *
+ * Given a struct clk @clk and a new parent struct clk @new_parent,
+ * determine what @clk's rate would be after the reparent operation.
+ * Returns the new clock rate or -EINVAL upon error.
+ */
+long omap2_clk_round_rate_parent(struct clk *clk, struct clk *new_parent)
+{
+	u32 field_val, parent_div;
+	long rate;
+
+	if (!clk->clksel || !new_parent)
+		return -EINVAL;
+
+	parent_div = _omap2_clksel_get_src_field(new_parent, clk, &field_val);
+	if (!parent_div)
+		return -EINVAL;
+
+	/* CLKSEL clocks follow their parents' rates, divided by a divisor */
+	rate = new_parent->rate;
+	if (parent_div > 0)
+		rate /= parent_div;
+
+	return rate;
+}
+
+
 /* DPLL rate rounding code */
 
 /**
diff --git a/arch/arm/mach-omap2/clock.h b/arch/arm/mach-omap2/clock.h
index f4d489f..af350ed 100644
--- a/arch/arm/mach-omap2/clock.h
+++ b/arch/arm/mach-omap2/clock.h
@@ -41,6 +41,7 @@ int omap2_clk_register(struct clk *clk);
 int omap2_clk_enable(struct clk *clk);
 void omap2_clk_disable(struct clk *clk);
 long omap2_clk_round_rate(struct clk *clk, unsigned long rate);
+long omap2_clk_round_rate_parent(struct clk *clk, struct clk *new_parent);
 int omap2_clk_set_rate(struct clk *clk, unsigned long rate);
 int omap2_clk_set_parent(struct clk *clk, struct clk *new_parent);
 int omap2_dpll_set_rate_tolerance(struct clk *clk, unsigned int tolerance);
diff --git a/arch/arm/mach-omap2/clock24xx.c b/arch/arm/mach-omap2/clock24xx.c
index 53864c0..3f75524 100644
--- a/arch/arm/mach-omap2/clock24xx.c
+++ b/arch/arm/mach-omap2/clock24xx.c
@@ -448,6 +448,7 @@ static struct clk_functions omap2_clk_functions = {
 	.clk_enable		= omap2_clk_enable,
 	.clk_disable		= omap2_clk_disable,
 	.clk_round_rate		= omap2_clk_round_rate,
+	.clk_round_rate_parent	= omap2_clk_round_rate_parent,
 	.clk_set_rate		= omap2_clk_set_rate,
 	.clk_set_parent		= omap2_clk_set_parent,
 	.clk_get_parent		= omap2_clk_get_parent,
diff --git a/arch/arm/mach-omap2/clock34xx.c b/arch/arm/mach-omap2/clock34xx.c
index f7ac5c1..12ff39f 100644
--- a/arch/arm/mach-omap2/clock34xx.c
+++ b/arch/arm/mach-omap2/clock34xx.c
@@ -635,6 +635,7 @@ static struct clk_functions omap2_clk_functions = {
 	.clk_enable		= omap2_clk_enable,
 	.clk_disable		= omap2_clk_disable,
 	.clk_round_rate		= omap2_clk_round_rate,
+	.clk_round_rate_parent	= omap2_clk_round_rate_parent,
 	.clk_set_rate		= omap2_clk_set_rate,
 	.clk_set_parent		= omap2_clk_set_parent,
 	.clk_get_parent		= omap2_clk_get_parent,
diff --git a/arch/arm/plat-omap/include/mach/clock.h b/arch/arm/plat-omap/include/mach/clock.h
index db57b71..89a2662 100644
--- a/arch/arm/plat-omap/include/mach/clock.h
+++ b/arch/arm/plat-omap/include/mach/clock.h
@@ -121,6 +121,8 @@ struct clk_functions {
 	int		(*clk_enable)(struct clk *clk);
 	void		(*clk_disable)(struct clk *clk);
 	long		(*clk_round_rate)(struct clk *clk, unsigned long rate);
+	long		(*clk_round_rate_parent)(struct clk *clk,
+						 struct clk *parent);
 	int		(*clk_set_rate)(struct clk *clk, unsigned long rate);
 	int		(*clk_set_parent)(struct clk *clk, struct clk *parent);
 	struct clk *	(*clk_get_parent)(struct clk *clk);


