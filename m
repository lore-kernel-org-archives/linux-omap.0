From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 08/11] OMAP2+ clock: revise omap2_clk_{disable,enable}()
Date: Mon, 22 Feb 2010 21:50:55 -0700
Message-ID: <20100223045053.18888.74178.stgit@localhost.localdomain>
References: <20100223044915.18888.83242.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:60270 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751552Ab0BWE5k (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 22 Feb 2010 23:57:40 -0500
In-Reply-To: <20100223044915.18888.83242.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Richard Woodruff <r-woodruff2@ti.com>, Rajendra Nayak <rnayak@ti.com>

Simplify the code in the omap2_clk_disable() and omap2_clk_enable()
functions, reducing levels of indentation.  This makes the code easier
to read.  Add some additional debugging pr_debug()s here also to help
others understand what is going on.

Revise the omap2_clk_disable() logic so that it now attempts to
disable the clock's clockdomain before recursing up the clock tree.
Simultaneously, ensure that omap2_clk_enable() is called on parent
clocks first, before enabling the clockdomain.  This ensures that a
parent clock's clockdomain is enabled before the child clock's
clockdomain.  These sequences should be the inverse of each other.

Revise the omap2_clk_enable() logic so that it now cleans up after
itself upon encountering an error.  Previously, an error enabling a
parent clock could have resulted in inconsistent usecounts on the
enclosing clockdomain.

Remove the trivial _omap2_clk_disable() and _omap2_clk_enable() static
functions, and replace it with the clkops calls that they were
executing.

For all this to work, the clockdomain omap2_clkdm_clk_enable() and
omap2_clkdm_clk_disable() code must not return an error on clockdomains
without CLKSTCTRL registers; so modify those functions to simply return 0
in that case.

While here, add some basic kerneldoc documentation on both functions,
and get rid of some old non-CodingStyle-compliant comments that have
existed since the dawn of time (at least, the OMAP clock framework's
time).

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Richard Woodruff <r-woodruff2@ti.com>
Cc: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/clock.c       |  135 +++++++++++++++++++++++++------------
 arch/arm/mach-omap2/clockdomain.c |   10 ++-
 2 files changed, 99 insertions(+), 46 deletions(-)

diff --git a/arch/arm/mach-omap2/clock.c b/arch/arm/mach-omap2/clock.c
index d1f115d..a6d0b34 100644
--- a/arch/arm/mach-omap2/clock.c
+++ b/arch/arm/mach-omap2/clock.c
@@ -37,9 +37,9 @@
 
 u8 cpu_mask;
 
-/*-------------------------------------------------------------------------
- * OMAP2/3/4 specific clock functions
- *-------------------------------------------------------------------------*/
+/*
+ * OMAP2+ specific clock functions
+ */
 
 /* Private functions */
 
@@ -71,20 +71,6 @@ static void _omap2_module_wait_ready(struct clk *clk)
 			     clk->name);
 }
 
-/* Enables clock without considering parent dependencies or use count
- * REVISIT: Maybe change this to use clk->enable like on omap1?
- */
-static int _omap2_clk_enable(struct clk *clk)
-{
-	return clk->ops->enable(clk);
-}
-
-/* Disables clock without considering parent dependencies or use count */
-static void _omap2_clk_disable(struct clk *clk)
-{
-	clk->ops->disable(clk);
-}
-
 /* Public functions */
 
 /**
@@ -245,46 +231,106 @@ const struct clkops clkops_omap2_dflt = {
 	.disable	= omap2_dflt_clk_disable,
 };
 
+/**
+ * omap2_clk_disable - disable a clock, if the system is not using it
+ * @clk: struct clk * to disable
+ *
+ * Decrements the usecount on struct clk @clk.  If there are no users
+ * left, call the clkops-specific clock disable function to disable it
+ * in hardware.  If the clock is part of a clockdomain (which they all
+ * should be), request that the clockdomain be disabled.  (It too has
+ * a usecount, and so will not be disabled in the hardware until it no
+ * longer has any users.)  If the clock has a parent clock (most of
+ * them do), then call ourselves, recursing on the parent clock.  This
+ * can cause an entire branch of the clock tree to be powered off by
+ * simply disabling one clock.  Intended to be called with the clockfw_lock
+ * spinlock held.  No return value.
+ */
 void omap2_clk_disable(struct clk *clk)
 {
-	if (clk->usecount > 0 && !(--clk->usecount)) {
-		_omap2_clk_disable(clk);
-		if (clk->parent)
-			omap2_clk_disable(clk->parent);
-		if (clk->clkdm)
-			omap2_clkdm_clk_disable(clk->clkdm, clk);
-
+	if (clk->usecount == 0) {
+		WARN(1, "clock: %s: omap2_clk_disable() called, but usecount "
+		     "already 0?", clk->name);
+		return;
 	}
+
+	pr_debug("clock: %s: decrementing usecount\n", clk->name);
+
+	clk->usecount--;
+
+	if (clk->usecount > 0)
+		return;
+
+	pr_debug("clock: %s: disabling in hardware\n", clk->name);
+
+	clk->ops->disable(clk);
+
+	if (clk->clkdm)
+		omap2_clkdm_clk_disable(clk->clkdm, clk);
+
+	if (clk->parent)
+		omap2_clk_disable(clk->parent);
 }
 
+/**
+ * omap2_clk_enable - request that the system enable a clock
+ * @clk: struct clk * to enable
+ *
+ * Increments the usecount on struct clk @clk.  If there were no users
+ * previously, then recurse up the clock tree, enabling all of the
+ * clock's parents and all of the parent clockdomains, and finally,
+ * enabling @clk's clockdomain, and @clk itself.  Intended to be
+ * called with the clockfw_lock spinlock held.  Returns 0 upon success
+ * or a negative error code upon failure.
+ */
 int omap2_clk_enable(struct clk *clk)
 {
-	int ret = 0;
+	int ret;
 
-	if (clk->usecount++ == 0) {
-		if (clk->clkdm)
-			omap2_clkdm_clk_enable(clk->clkdm, clk);
+	pr_debug("clock: %s: incrementing usecount\n", clk->name);
 
-		if (clk->parent) {
-			ret = omap2_clk_enable(clk->parent);
-			if (ret)
-				goto err;
-		}
+	clk->usecount++;
+
+	if (clk->usecount > 1)
+		return 0;
 
-		ret = _omap2_clk_enable(clk);
+	pr_debug("clock: %s: enabling in hardware\n", clk->name);
+
+	if (clk->parent) {
+		ret = omap2_clk_enable(clk->parent);
 		if (ret) {
-			if (clk->parent)
-				omap2_clk_disable(clk->parent);
+			WARN(1, "clock: %s: could not enable parent %s: %d\n",
+			     clk->name, clk->parent->name, ret);
+			goto oce_err1;
+		}
+	}
 
-			goto err;
+	if (clk->clkdm) {
+		ret = omap2_clkdm_clk_enable(clk->clkdm, clk);
+		if (ret) {
+			WARN(1, "clock: %s: could not enable clockdomain %s: "
+			     "%d\n", clk->name, clk->clkdm->name, ret);
+			goto oce_err2;
 		}
 	}
-	return ret;
 
-err:
+	ret = clk->ops->enable(clk);
+	if (ret) {
+		WARN(1, "clock: %s: could not enable: %d\n", clk->name, ret);
+		goto oce_err3;
+	}
+
+	return 0;
+
+oce_err3:
 	if (clk->clkdm)
 		omap2_clkdm_clk_disable(clk->clkdm, clk);
+oce_err2:
+	if (clk->parent)
+		omap2_clk_disable(clk->parent);
+oce_err1:
 	clk->usecount--;
+
 	return ret;
 }
 
@@ -325,9 +371,9 @@ const struct clkops clkops_omap3_noncore_dpll_ops = {
 #endif
 
 
-/*-------------------------------------------------------------------------
- * Omap2 clock reset and init functions
- *-------------------------------------------------------------------------*/
+/*
+ * OMAP2+ clock reset and init functions
+ */
 
 #ifdef CONFIG_OMAP_RESET_CLOCKS
 void omap2_clk_disable_unused(struct clk *clk)
@@ -344,8 +390,9 @@ void omap2_clk_disable_unused(struct clk *clk)
 	if (cpu_is_omap34xx()) {
 		omap2_clk_enable(clk);
 		omap2_clk_disable(clk);
-	} else
-		_omap2_clk_disable(clk);
+	} else {
+		clk->ops->disable(clk);
+	}
 	if (clk->clkdm != NULL)
 		pwrdm_clkdm_state_switch(clk->clkdm);
 }
diff --git a/arch/arm/mach-omap2/clockdomain.c b/arch/arm/mach-omap2/clockdomain.c
index b26d30a..b87ad66 100644
--- a/arch/arm/mach-omap2/clockdomain.c
+++ b/arch/arm/mach-omap2/clockdomain.c
@@ -978,7 +978,7 @@ int omap2_clkdm_clk_enable(struct clockdomain *clkdm, struct clk *clk)
 	 * downstream clocks for debugging purposes?
 	 */
 
-	if (!clkdm || !clk || !clkdm->clkstctrl_reg)
+	if (!clkdm || !clk)
 		return -EINVAL;
 
 	if (atomic_inc_return(&clkdm->usecount) > 1)
@@ -989,6 +989,9 @@ int omap2_clkdm_clk_enable(struct clockdomain *clkdm, struct clk *clk)
 	pr_debug("clockdomain: clkdm %s: clk %s now enabled\n", clkdm->name,
 		 clk->name);
 
+	if (!clkdm->clkstctrl_reg)
+		return 0;
+
 	v = omap2_clkdm_clktrctrl_read(clkdm);
 
 	if ((cpu_is_omap34xx() && v == OMAP34XX_CLKSTCTRL_ENABLE_AUTO) ||
@@ -1030,7 +1033,7 @@ int omap2_clkdm_clk_disable(struct clockdomain *clkdm, struct clk *clk)
 	 * downstream clocks for debugging purposes?
 	 */
 
-	if (!clkdm || !clk || !clkdm->clkstctrl_reg)
+	if (!clkdm || !clk)
 		return -EINVAL;
 
 #ifdef DEBUG
@@ -1048,6 +1051,9 @@ int omap2_clkdm_clk_disable(struct clockdomain *clkdm, struct clk *clk)
 	pr_debug("clockdomain: clkdm %s: clk %s now disabled\n", clkdm->name,
 		 clk->name);
 
+	if (!clkdm->clkstctrl_reg)
+		return 0;
+
 	v = omap2_clkdm_clktrctrl_read(clkdm);
 
 	if ((cpu_is_omap34xx() && v == OMAP34XX_CLKSTCTRL_ENABLE_AUTO) ||


