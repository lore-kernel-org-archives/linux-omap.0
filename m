From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 08/28] omap2 clock: convert omap2_clksel_to_divisor and
	omap2_divisor_to_clksel to use new clksel struct
Date: Mon, 20 Aug 2007 03:53:55 -0600
Message-ID: <20070820095530.752364456@pwsan.com>
References: <20070820095347.933473149@pwsan.com>
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline; filename=add_gcbp_convert_c2d_d2c.patch
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Convert omap2_clksel_to_divisor() and omap2_divisor_to_clksel() to use
the new struct clksel and struct clksel_rate data.  Add 
omap2_get_clksel_by_parent() utility code, called by both functions, 
to return the appropriate struct clksel for a given (struct clk, parent 
struct clk) combination.

Signed-off-by: Paul Walmsley <paul@pwsan.com>

---
 arch/arm/mach-omap2/clock.c |  132 +++++++++++++++++++++++++++++++++-----------
 arch/arm/mach-omap2/clock.h |    3 -
 2 files changed, 102 insertions(+), 33 deletions(-)

Index: linux-omap/arch/arm/mach-omap2/clock.c
Index: linux-omap/arch/arm/mach-omap2/clock.c
===================================================================
--- linux-omap.orig/arch/arm/mach-omap2/clock.c
+++ linux-omap/arch/arm/mach-omap2/clock.c
@@ -497,6 +497,38 @@ static inline u32 omap2_divider_from_tab
 	return ~0;	/* No acceptable divider */
 }
 
+/**
+ * omap2_get_clksel_by_parent - return clksel struct for a given clk & parent
+ * @clk: OMAP struct clk ptr to inspect
+ * @src_clk: OMAP struct clk ptr of the parent clk to search for
+ *
+ * Scan the struct clksel array associated with the clock to find
+ * the element associated with the supplied parent clock address.
+ * Returns a pointer to the struct clksel on success or NULL on error.
+ */
+const static struct clksel *omap2_get_clksel_by_parent(struct clk *clk,
+						       struct clk *src_clk)
+{
+	const struct clksel *clks;
+
+	if (!clk->clksel)
+		return NULL;
+
+	for (clks = clk->clksel; clks->parent; clks++) {
+		if (clks->parent == src_clk)
+			break; /* Found the requested parent */
+	}
+
+	if (!clks->parent) {
+		printk(KERN_ERR "clock: Could not find parent clock %s in "
+		       "clksel array of clock %s\n", src_clk->name,
+		       clk->name);
+		return NULL;
+	}
+
+	return clks;
+}
+
 /*
  * Find divisor for the given clock and target rate.
  *
@@ -683,38 +715,74 @@ static long omap2_round_to_table_rate(st
 	return highest_rate;
 }
 
-/*
- * omap2_clksel_to_divisor() - turn field value into integer divider
+/**
+ * omap2_clksel_to_divisor() - turn clksel field value into integer divider
+ * @clk: OMAP struct clk to use
+ * @field_val: register field value to find
+ *
+ * Given a struct clk of a rate-selectable clksel clock, and a register field
+ * value to search for, find the corresponding clock divisor.  The register
+ * field value should be pre-masked and shifted down so the LSB is at bit 0
+ * before calling.  Returns 0 on error
  */
-static u32 omap2_clksel_to_divisor(u32 div_sel, u32 field_val)
+static u32 omap2_clksel_to_divisor(struct clk *clk, u32 field_val)
 {
-	u32 i;
+	const struct clksel *clks;
+	const struct clksel_rate *clkr;
 
-	if ((div_sel & SRC_RATE_SEL_MASK) == CM_SYSCLKOUT_SEL1) {
-		for (i = 0; i < ARRAY_SIZE(sysclkout_div); i++) {
-			if (field_val == i)
-				return sysclkout_div[i];
-		}
+	clks = omap2_get_clksel_by_parent(clk, clk->parent);
+	if (clks == NULL)
 		return 0;
-	} else
-		return field_val;
+
+	for (clkr = clks->rates; clkr->div; clkr++) {
+		if ((clkr->flags & cpu_mask) && (clkr->val == field_val))
+			break;
+	}
+
+	if (!clkr->div) {
+		printk(KERN_ERR "clock: Could not find fieldval %d for "
+		       "clock %s parent %s\n", field_val, clk->name,
+		       clk->parent->name);
+		return 0;
+	}
+
+	return clkr->div;
 }
 
-/*
- * omap2_divisor_to_clksel() - turn integer divider into field value
+/**
+ * omap2_divisor_to_clksel() - turn clksel integer divisor into a field value
+ * @clk: OMAP struct clk to use
+ * @div: integer divisor to search for
+ *
+ * Given a struct clk of a rate-selectable clksel clock, and a clock divisor,
+ * find the corresponding register field value.  The return register value is
+ * the value before left-shifting.  Returns 0xffffffff on error
  */
-static u32 omap2_divisor_to_clksel(u32 div_sel, u32 div)
+static u32 omap2_divisor_to_clksel(struct clk *clk, u32 div)
 {
-	u32 i;
+	const struct clksel *clks;
+	const struct clksel_rate *clkr;
+
+	/* should never happen */
+	WARN_ON(div == 0);
 
-	if ((div_sel & SRC_RATE_SEL_MASK) == CM_SYSCLKOUT_SEL1) {
-		for (i = 0; i < ARRAY_SIZE(sysclkout_div); i++) {
-			if (div == sysclkout_div[i])
-				return i;
-		}
-		return ~0;
-	} else
-		return div;
+	clks = omap2_get_clksel_by_parent(clk, clk->parent);
+	if (clks == NULL)
+		return 0;
+
+	for (clkr = clks->rates; clkr->div; clkr++) {
+		if ((clkr->flags & cpu_mask) && (clkr->div == div))
+			break;
+	}
+
+	if (!clkr->div) {
+		printk(KERN_ERR "clock: Could not find divisor %d for "
+		       "clock %s parent %s\n", div, clk->name,
+		       clk->parent->name);
+		return 0;
+	}
+
+	return clkr->val;
 }
 
 /*
@@ -800,13 +868,15 @@ static void __iomem *omap2_get_clksel(u3
 }
 
 
-/*
- * Return divider to be applied to parent clock.
- * Return 0 on error.
+/**
+ * omap2_clksel_get_divisor - get current divider applied to parent clock.
+ * @clk: OMAP struct clk to use.
+ *
+ * Returns the integer divisor upon success or 0 on error.
  */
 static u32 omap2_clksel_get_divisor(struct clk *clk)
 {
-	u32 div, field_mask, field_val;
+	u32 field_mask, field_val;
 	void __iomem *div_addr;
 
 	div_addr = omap2_get_clksel(&field_mask, clk);
@@ -814,11 +884,9 @@ static u32 omap2_clksel_get_divisor(stru
 		return 0;
 
 	field_val = cm_read_reg(div_addr) & field_mask;
-	field_val >>= clk->rate_offset;
-
-	div = omap2_clksel_to_divisor(clk->flags, field_val);
+	field_val >>= convert_mask_to_shift(field_mask);
 
-	return div;
+	return omap2_clksel_to_divisor(clk, field_val);
 }
 
 /* Set the clock rate for a clock source */
@@ -844,7 +912,7 @@ static int omap2_clk_set_rate(struct clk
 		if (div_addr == 0)
 			return ret;
 
-		field_val = omap2_divisor_to_clksel(clk->flags, new_div);
+		field_val = omap2_divisor_to_clksel(clk, new_div);
 		if (field_val == ~0)
 			return ret;
 
Index: linux-omap/arch/arm/mach-omap2/clock.h
===================================================================
--- linux-omap.orig/arch/arm/mach-omap2/clock.h
+++ linux-omap/arch/arm/mach-omap2/clock.h
@@ -30,8 +30,9 @@ static long omap2_round_to_table_rate(st
 static void omap2_clk_disable(struct clk *clk);
 static void omap2_sys_clk_recalc(struct clk * clk);
 static void omap2_init_clksel_parent(struct clk *clk);
-static u32 omap2_clksel_to_divisor(u32 div_sel, u32 field_val);
 static u32 omap2_clksel_get_divisor(struct clk *clk);
+static u32 omap2_clksel_to_divisor(struct clk *clk, u32 field_val);
+static u32 omap2_divisor_to_clksel(struct clk *clk, u32 div);
 static void omap2_dpll_recalc(struct clk *clk);
 static void omap2_fixed_divisor_recalc(struct clk *clk);
 

-- 
