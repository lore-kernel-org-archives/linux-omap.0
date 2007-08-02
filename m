From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 17/22] omap2 clock: Cleanup in clksel-related code;
	add sys_clkout2 divisor handling
Date: Thu, 02 Aug 2007 12:10:19 -0600
Message-ID: <20070802181143.242524981@pwsan.com>
References: <20070802181002.792550043@pwsan.com>
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline; filename=get_clksel_cleanup.patch
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

Convert omap2_get_clksel to use void __iomem *.  Add
omap2_divisor_to_clksel(), to convert clock divisors into appropriate
register bit field values.  Use non-shifted register bit field masks
in clksel code, rather than masks that have been preshifted down to
bit 0 -- this simplifies existing code and facilitates the use of
symbolic constants from the recent PRCM cleanup.  Also add code to
properly handle divisors for sys_clkout2 on OMAP2420.  Previously
this clock's divisor settings were ignored.

Signed-off-by: Paul Walmsley <paul@pwsan.com>

---
 arch/arm/mach-omap2/clock.c |  192 +++++++++++++++++++++-----------------------
 1 file changed, 93 insertions(+), 99 deletions(-)

Index: linux-omap/arch/arm/mach-omap2/clock.c
Index: linux-omap/arch/arm/mach-omap2/clock.c
===================================================================
--- linux-omap.orig/arch/arm/mach-omap2/clock.c
+++ linux-omap/arch/arm/mach-omap2/clock.c
@@ -52,6 +52,8 @@ static struct clk *vclk;
 static struct clk *sclk;
 static u8 cpu_mask;
 
+static u32 sysclkout_div[] = {1, 2, 4, 8, 16};
+
 /*-------------------------------------------------------------------------
  * Omap2 specific clock functions
  *-------------------------------------------------------------------------*/
@@ -428,7 +430,6 @@ static u32 omap2_clksel_round_rate(struc
 	u32 *new_div)
 {
 	u32 gfx_div[] = {2, 3, 4};
-	u32 sysclkout_div[] = {1, 2, 4, 8, 16};
 	u32 dss1_div[] = {1, 2, 3, 4, 5, 6, 8, 9, 12, 16};
 	u32 vlynq_div[] = {1, 2, 3, 4, 6, 8, 9, 12, 16, 18};
 	u32 best_div = ~0, asize = 0;
@@ -601,38 +602,50 @@ static long omap2_round_to_table_rate(st
 }
 
 /*
- * omap2_convert_field_to_div() - turn field value into integer divider
+ * omap2_clksel_to_divisor() - turn field value into integer divider
  */
 static u32 omap2_clksel_to_divisor(u32 div_sel, u32 field_val)
 {
 	u32 i;
-	u32 clkout_array[] = {1, 2, 4, 8, 16};
 
 	if ((div_sel & SRC_RATE_SEL_MASK) == CM_SYSCLKOUT_SEL1) {
-		for (i = 0; i < 5; i++) {
+		for (i = 0; i < ARRAY_SIZE(sysclkout_div); i++) {
 			if (field_val == i)
-				return clkout_array[i];
+				return sysclkout_div[i];
 		}
-		return ~0;
+		return 0;
 	} else
 		return field_val;
 }
 
 /*
+ * omap2_divisor_to_clksel() - turn integer divider into field value
+ */
+static u32 omap2_divisor_to_clksel(u32 div_sel, u32 div)
+{
+	u32 i;
+
+	if ((div_sel & SRC_RATE_SEL_MASK) == CM_SYSCLKOUT_SEL1) {
+		for (i = 0; i < ARRAY_SIZE(sysclkout_div); i++) {
+			if (div == sysclkout_div[i])
+				return i;
+		}
+		return ~0;
+	} else
+		return div;
+}
+
+/*
  * Returns the CLKSEL divider register value
- * REVISIT: This should be cleaned up to work nicely with void __iomem *
  */
-static u32 omap2_get_clksel(u32 *div_sel, u32 *field_mask,
-			    struct clk *clk)
+static void __iomem *omap2_get_clksel(u32 *field_mask, struct clk *clk)
 {
-	int ret = ~0;
-	u32 reg_val, div_off;
+	u32 div_off, mask = ~0;
 	void __iomem *div_addr = 0;
-	u32 mask = ~0;
 
 	div_off = clk->rate_offset;
 
-	switch ((*div_sel & SRC_RATE_SEL_MASK)) {
+	switch (clk->flags & SRC_RATE_SEL_MASK) {
 	case CM_MPU_SEL1:
 		div_addr = OMAP_CM_REGADDR(MPU_MOD, CM_CLKSEL);
 		mask = OMAP24XX_CLKSEL_MPU_MASK;
@@ -696,44 +709,32 @@ static u32 omap2_get_clksel(u32 *div_sel
 		}
 	}
 
-	*field_mask = (mask >> div_off);
-
-	if (unlikely(mask == ~0))
-		div_addr = 0;
-
-	*div_sel = (u32)div_addr;
-
-	if (unlikely(div_addr == 0))
-		return ret;
-
-	/* Isolate field */
-	reg_val = cm_read_reg(div_addr) & mask;
+	if (unlikely((mask == ~0) || (div_addr == 0)))
+		return 0;
 
-	/* Normalize back to divider value */
-	reg_val >>= div_off;
+	*field_mask = mask;
 
-	return reg_val;
+	return div_addr;
 }
 
+
 /*
  * Return divider to be applied to parent clock.
  * Return 0 on error.
  */
 static u32 omap2_clksel_get_divisor(struct clk *clk)
 {
-	int ret = 0;
-	u32 div, div_sel, div_off, field_mask, field_val;
+	u32 div, field_mask, field_val;
+	void __iomem *div_addr;
 
-	/* isolate control register */
-	div_sel = (SRC_RATE_SEL_MASK & clk->flags);
+	div_addr = omap2_get_clksel(&field_mask, clk);
+	if (div_addr == 0)
+		return 0;
 
-	div_off = clk->rate_offset;
-	field_val = omap2_get_clksel(&div_sel, &field_mask, clk);
-	if (div_sel == 0)
-		return ret;
+	field_val = cm_read_reg(div_addr) & field_mask;
+	field_val >>= clk->rate_offset;
 
-	div_sel = (SRC_RATE_SEL_MASK & clk->flags);
-	div = omap2_clksel_to_divisor(div_sel, field_val);
+	div = omap2_clksel_to_divisor(clk->flags, field_val);
 
 	return div;
 }
@@ -742,53 +743,33 @@ static u32 omap2_clksel_get_divisor(stru
 static int omap2_clk_set_rate(struct clk *clk, unsigned long rate)
 {
 	int ret = -EINVAL;
-	void __iomem * reg;
-	u32 div_sel, div_off, field_mask, field_val, reg_val, validrate;
+	u32 div_off, field_mask, field_val, reg_val, validrate;
 	u32 new_div = 0;
+	void __iomem *div_addr;
 
 	if (!(clk->flags & CONFIG_PARTICIPANT) && (clk->flags & RATE_CKCTL)) {
 		if (clk == &dpll_ck)
 			return omap2_reprogram_dpll(clk, rate);
 
 		/* Isolate control register */
-		div_sel = (SRC_RATE_SEL_MASK & clk->flags);
 		div_off = clk->rate_offset;
 
 		validrate = omap2_clksel_round_rate(clk, rate, &new_div);
 		if (validrate != rate)
 			return ret;
 
-		field_val = omap2_get_clksel(&div_sel, &field_mask, clk);
-		if (div_sel == 0)
+		div_addr = omap2_get_clksel(&field_mask, clk);
+		if (div_addr == 0)
 			return ret;
 
-		if (clk->flags & CM_SYSCLKOUT_SEL1) {
-			switch (new_div) {
-			case 16:
-				field_val = 4;
-				break;
-			case 8:
-				field_val = 3;
-				break;
-			case 4:
-				field_val = 2;
-				break;
-			case 2:
-				field_val = 1;
-				break;
-			case 1:
-				field_val = 0;
-				break;
-			}
-		} else
-			field_val = new_div;
-
-		reg = (void __iomem *)div_sel;
+		field_val = omap2_divisor_to_clksel(clk->flags, new_div);
+		if (field_val == ~0)
+			return ret;
 
-		reg_val = cm_read_reg(reg);
-		reg_val &= ~(field_mask << div_off);
+		reg_val = cm_read_reg(div_addr);
+		reg_val &= ~field_mask;
 		reg_val |= (field_val << div_off);
-		cm_write_reg(reg_val, reg);
+		cm_write_reg(reg_val, div_addr);
 		wmb();
 		clk->rate = clk->parent->rate / new_div;
 
@@ -809,26 +790,28 @@ static int omap2_clk_set_rate(struct clk
 }
 
 /* Converts encoded control register address into a full address */
-static u32 omap2_get_src_field(u32 *type_to_addr, u32 reg_offset,
-			       struct clk *src_clk, u32 *field_mask)
+static u32 omap2_clksel_get_src_field(void __iomem **src_addr,
+				      struct clk *src_clk, u32 *field_mask,
+				      struct clk *clk)
 {
 	u32 val = ~0, mask = 0;
 	void __iomem *src_reg_addr = 0;
+	u32 reg_offset;
+
+	reg_offset = clk->src_offset;
 
 	/* Find target control register.*/
-	switch ((*type_to_addr & SRC_RATE_SEL_MASK)) {
+	switch (clk->flags & SRC_RATE_SEL_MASK) {
 	case CM_CORE_SEL1:
 		src_reg_addr = OMAP_CM_REGADDR(CORE_MOD, CM_CLKSEL1);
 		if (reg_offset == OMAP24XX_CLKSEL_DSS2_SHIFT) {
 			mask = OMAP24XX_CLKSEL_DSS2_MASK;
-			mask >>= OMAP24XX_CLKSEL_DSS2_SHIFT;
 			if (src_clk == &sys_ck)
 				val = 0;
 			if (src_clk == &func_48m_ck)
 				val = 1;
 		} else if (reg_offset == OMAP24XX_CLKSEL_DSS1_SHIFT) {
 			mask = OMAP24XX_CLKSEL_DSS1_MASK;
-			mask >>= OMAP24XX_CLKSEL_DSS1_SHIFT;
 			if (src_clk == &sys_ck)
 				val = 0;
 			else if (src_clk == &core_ck)	/* divided clock */
@@ -836,16 +819,20 @@ static u32 omap2_get_src_field(u32 *type
 		} else if ((reg_offset == OMAP2420_CLKSEL_VLYNQ_SHIFT) &&
 			   cpu_is_omap2420()) {
 			mask = OMAP2420_CLKSEL_VLYNQ_MASK;
-			mask >>= OMAP2420_CLKSEL_VLYNQ_SHIFT;
 			if (src_clk == &func_96m_ck)
 				val = 0;
 			else if (src_clk == &core_ck)
 				val = 0x10;             /* rate needs fixing */
+		} else {
+			WARN_ON(1); /* unknown reg_offset */
 		}
 		break;
 	case CM_CORE_SEL2:
+		WARN_ON(reg_offset < OMAP24XX_CLKSEL_GPT2_SHIFT ||
+			reg_offset > OMAP24XX_CLKSEL_GPT12_SHIFT);
 		src_reg_addr = OMAP_CM_REGADDR(CORE_MOD, CM_CLKSEL2);
-		mask = 0x3;
+		mask = OMAP24XX_CLKSEL_GPT2_MASK;
+		mask <<= (reg_offset - OMAP24XX_CLKSEL_GPT2_SHIFT);
 		if (src_clk == &func_32k_ck)
 			val = 0x0;
 		if (src_clk == &sys_ck)
@@ -854,8 +841,9 @@ static u32 omap2_get_src_field(u32 *type
 			val = 0x2;
 		break;
 	case CM_WKUP_SEL1:
+		WARN_ON(reg_offset != 0); /* unknown reg_offset */
 		src_reg_addr = OMAP_CM_REGADDR(WKUP_MOD, CM_CLKSEL);
-		mask = 0x3;
+		mask = OMAP24XX_CLKSEL_GPT1_MASK;
 		if (src_clk == &func_32k_ck)
 			val = 0x0;
 		if (src_clk == &sys_ck)
@@ -865,23 +853,27 @@ static u32 omap2_get_src_field(u32 *type
 		break;
 	case CM_PLL_SEL1:
 		src_reg_addr = OMAP_CM_REGADDR(PLL_MOD, CM_CLKSEL1);
-		mask = 0x1;
 		if (reg_offset == 0x3) {
+			mask = OMAP24XX_48M_SOURCE;
 			if (src_clk == &apll96_ck)
 				val = 0;
 			if (src_clk == &alt_ck)
 				val = 1;
 		}
 		else if (reg_offset == 0x5) {
+			mask = OMAP24XX_54M_SOURCE;
 			if (src_clk == &apll54_ck)
 				val = 0;
 			if (src_clk == &alt_ck)
 				val = 1;
+		} else {
+			WARN_ON(1); /* unknown reg_offset */
 		}
 		break;
 	case CM_PLL_SEL2:
+		WARN_ON(reg_offset != 0);
 		src_reg_addr = OMAP_CM_REGADDR(PLL_MOD, CM_CLKSEL2);
-		mask = 0x3;
+		mask = OMAP24XX_CORE_CLK_SRC_MASK;
 		if (src_clk == &func_32k_ck)
 			val = 0x0;
 		if (src_clk == &dpll_ck)
@@ -889,7 +881,15 @@ static u32 omap2_get_src_field(u32 *type
 		break;
 	case CM_SYSCLKOUT_SEL1:
 		src_reg_addr = OMAP24XX_PRCM_CLKOUT_CTRL;
-		mask = 0x3;
+
+		if (reg_offset == OMAP24XX_CLKOUT_SOURCE_SHIFT) {
+			mask = OMAP24XX_CLKOUT_SOURCE_MASK;
+		} else if (reg_offset == OMAP2420_CLKOUT2_SOURCE_SHIFT) {
+			mask = OMAP2420_CLKOUT2_SOURCE_MASK;
+		} else {
+			WARN_ON(1); /* unknown reg_offset */
+		}
+
 		if (src_clk == &dpll_ck)
 			val = 0;
 		if (src_clk == &sys_ck)
@@ -902,9 +902,10 @@ static u32 omap2_get_src_field(u32 *type
 	}
 
 	if (val == ~0)			/* Catch errors in offset */
-		*type_to_addr = 0;
+		*src_addr = 0;
 	else
-		*type_to_addr = (u32)src_reg_addr;
+		*src_addr = src_reg_addr;
+
 	*field_mask = mask;
 
 	return val;
@@ -912,34 +913,27 @@ static u32 omap2_get_src_field(u32 *type
 
 static int omap2_clk_set_parent(struct clk *clk, struct clk *new_parent)
 {
-	void __iomem * reg;
-	u32 src_sel, src_off, field_val, field_mask, reg_val;
-	int ret = -EINVAL;
+	void __iomem *src_addr;
+	u32 field_val, field_mask, reg_val;
 
 	if (unlikely(clk->flags & CONFIG_PARTICIPANT))
-		return ret;
+		return -EINVAL;
 
 	if (unlikely(!(clk->flags & SRC_SEL_MASK)))
-		return ret;
-
-	src_sel = (SRC_RATE_SEL_MASK & clk->flags);
-	src_off = clk->src_offset;
-
-	if (src_sel == 0)
-		return ret;
-
-	field_val = omap2_get_src_field(&src_sel, src_off, new_parent,
-					&field_mask);
+		return -EINVAL;
 
-	reg = (void __iomem *)src_sel;
+	field_val = omap2_clksel_get_src_field(&src_addr, new_parent,
+					       &field_mask, clk);
+	if (src_addr == 0)
+		return -EINVAL;
 
 	if (clk->usecount > 0)
 		_omap2_clk_disable(clk);
 
 	/* Set new source value (previous dividers if any in effect) */
-	reg_val = __raw_readl(reg) & ~(field_mask << src_off);
-	reg_val |= (field_val << src_off);
-	__raw_writel(reg_val, reg);
+	reg_val = __raw_readl(src_addr) & ~field_mask;
+	reg_val |= (field_val << clk->src_offset);
+	__raw_writel(reg_val, src_addr);
 	wmb();
 
 	if (clk->flags & DELAYED_APP) {

-- 
