From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 16/18] OMAP3 DPLL: reorganize static functions
Date: Fri, 15 Jan 2010 02:07:08 -0700
Message-ID: <20100115090707.30690.33928.stgit@localhost.localdomain>
References: <20100115090613.30690.49355.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:48752 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756843Ab0AOJIQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 15 Jan 2010 04:08:16 -0500
In-Reply-To: <20100115090613.30690.49355.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Move all static functions up to the top of the file to match the
practice in other OMAP clock code.  Make omap3_noncore_dpll_program()
static (noted by sparse) and prepend an underscore to the function
name to mark that it is file-local.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/dpll3xxx.c |  113 +++++++++++++++++++++-------------------
 1 files changed, 58 insertions(+), 55 deletions(-)

diff --git a/arch/arm/mach-omap2/dpll3xxx.c b/arch/arm/mach-omap2/dpll3xxx.c
index f6055b4..2b559fc 100644
--- a/arch/arm/mach-omap2/dpll3xxx.c
+++ b/arch/arm/mach-omap2/dpll3xxx.c
@@ -44,17 +44,7 @@
 
 #define MAX_DPLL_WAIT_TRIES		1000000
 
-
-/**
- * omap3_dpll_recalc - recalculate DPLL rate
- * @clk: DPLL struct clk
- *
- * Recalculate and propagate the DPLL rate.
- */
-unsigned long omap3_dpll_recalc(struct clk *clk)
-{
-	return omap2_get_dpll_rate(clk);
-}
+/* Private functions */
 
 /* _omap3_dpll_write_clken - write clken_bits arg to a DPLL's enable bits */
 static void _omap3_dpll_write_clken(struct clk *clk, u8 clken_bits)
@@ -136,8 +126,6 @@ static u16 _omap3_dpll_compute_freqsel(struct clk *clk, u8 n)
 	return f;
 }
 
-/* Non-CORE DPLL (e.g., DPLLs that do not control SDRC) clock functions */
-
 /*
  * _omap3_noncore_dpll_lock - instruct a DPLL to lock and wait for readiness
  * @clk: pointer to a DPLL struct clk
@@ -237,6 +225,63 @@ static int _omap3_noncore_dpll_stop(struct clk *clk)
 	return 0;
 }
 
+/*
+ * _omap3_noncore_dpll_program - set non-core DPLL M,N values directly
+ * @clk: struct clk * of DPLL to set
+ * @m: DPLL multiplier to set
+ * @n: DPLL divider to set
+ * @freqsel: FREQSEL value to set
+ *
+ * Program the DPLL with the supplied M, N values, and wait for the DPLL to
+ * lock..  Returns -EINVAL upon error, or 0 upon success.
+ */
+static int omap3_noncore_dpll_program(struct clk *clk, u16 m, u8 n, u16 freqsel)
+{
+	struct dpll_data *dd = clk->dpll_data;
+	u32 v;
+
+	/* 3430 ES2 TRM: 4.7.6.9 DPLL Programming Sequence */
+	_omap3_noncore_dpll_bypass(clk);
+
+	/* Set jitter correction */
+	if (!cpu_is_omap44xx()) {
+		v = __raw_readl(dd->control_reg);
+		v &= ~dd->freqsel_mask;
+		v |= freqsel << __ffs(dd->freqsel_mask);
+		__raw_writel(v, dd->control_reg);
+	}
+
+	/* Set DPLL multiplier, divider */
+	v = __raw_readl(dd->mult_div1_reg);
+	v &= ~(dd->mult_mask | dd->div1_mask);
+	v |= m << __ffs(dd->mult_mask);
+	v |= (n - 1) << __ffs(dd->div1_mask);
+	__raw_writel(v, dd->mult_div1_reg);
+
+	/* We let the clock framework set the other output dividers later */
+
+	/* REVISIT: Set ramp-up delay? */
+
+	_omap3_noncore_dpll_lock(clk);
+
+	return 0;
+}
+
+/* Public functions */
+
+/**
+ * omap3_dpll_recalc - recalculate DPLL rate
+ * @clk: DPLL struct clk
+ *
+ * Recalculate and propagate the DPLL rate.
+ */
+unsigned long omap3_dpll_recalc(struct clk *clk)
+{
+	return omap2_get_dpll_rate(clk);
+}
+
+/* Non-CORE DPLL (e.g., DPLLs that do not control SDRC) clock functions */
+
 /**
  * omap3_noncore_dpll_enable - instruct a DPLL to enter bypass or lock mode
  * @clk: pointer to a DPLL struct clk
@@ -292,48 +337,6 @@ void omap3_noncore_dpll_disable(struct clk *clk)
 
 /* Non-CORE DPLL rate set code */
 
-/*
- * omap3_noncore_dpll_program - set non-core DPLL M,N values directly
- * @clk: struct clk * of DPLL to set
- * @m: DPLL multiplier to set
- * @n: DPLL divider to set
- * @freqsel: FREQSEL value to set
- *
- * Program the DPLL with the supplied M, N values, and wait for the DPLL to
- * lock..  Returns -EINVAL upon error, or 0 upon success.
- */
-int omap3_noncore_dpll_program(struct clk *clk, u16 m, u8 n, u16 freqsel)
-{
-	struct dpll_data *dd = clk->dpll_data;
-	u32 v;
-
-	/* 3430 ES2 TRM: 4.7.6.9 DPLL Programming Sequence */
-	_omap3_noncore_dpll_bypass(clk);
-
-	/* Set jitter correction */
-	if (!cpu_is_omap44xx()) {
-		v = __raw_readl(dd->control_reg);
-		v &= ~dd->freqsel_mask;
-		v |= freqsel << __ffs(dd->freqsel_mask);
-		__raw_writel(v, dd->control_reg);
-	}
-
-	/* Set DPLL multiplier, divider */
-	v = __raw_readl(dd->mult_div1_reg);
-	v &= ~(dd->mult_mask | dd->div1_mask);
-	v |= m << __ffs(dd->mult_mask);
-	v |= (n - 1) << __ffs(dd->div1_mask);
-	__raw_writel(v, dd->mult_div1_reg);
-
-	/* We let the clock framework set the other output dividers later */
-
-	/* REVISIT: Set ramp-up delay? */
-
-	_omap3_noncore_dpll_lock(clk);
-
-	return 0;
-}
-
 /**
  * omap3_noncore_dpll_set_rate - set non-core DPLL rate
  * @clk: struct clk * of DPLL to set


