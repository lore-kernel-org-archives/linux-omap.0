From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 20/22] omap2 clock: add fixed divisor clock code
Date: Thu, 02 Aug 2007 12:10:22 -0600
Message-ID: <20070802181143.586448449@pwsan.com>
References: <20070802181002.792550043@pwsan.com>
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline; filename=add-parent-div-to-struct-clk.patch
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

The rates of some clocks are equal to their parents' rates, divided by some
fixed integer.  This contrasts with the existing 'followparent' clocks, 
which follow their parents' rates strictly; and the existing 'clksel' clocks,
which follow their parents' rates divided by a runtime-selectable divisor.
Add code to implement these clocks without resorting to specifying a 
fixed rate.  

Signed-off-by: Paul Walmsley <paul@pwsan.com>

---
 arch/arm/mach-omap2/clock.c       |   79 ++++++++++++++++++++------------------
 arch/arm/mach-omap2/clock.h       |   11 ++---
 include/asm-arm/arch-omap/clock.h |    3 +
 3 files changed, 52 insertions(+), 41 deletions(-)

Index: linux-omap/arch/arm/mach-omap2/clock.c
Index: linux-omap/arch/arm/mach-omap2/clock.c
===================================================================
--- linux-omap.orig/arch/arm/mach-omap2/clock.c
+++ linux-omap/arch/arm/mach-omap2/clock.c
@@ -134,6 +134,20 @@ static void omap2_followparent_recalc(st
 	followparent_recalc(clk);
 }
 
+/*
+ * Used for clocks that have the same value as the parent clock,
+ * divided by some factor
+ */
+static void omap2_fixed_divisor_recalc(struct clk *clk)
+{
+	WARN_ON(!clk->fixed_div);
+
+	clk->rate = clk->parent->rate / clk->fixed_div;
+
+	if (clk->flags & RATE_PROPAGATES)
+		propagate_rate(clk);
+}
+
 static void omap2_propagate_rate(struct clk * clk)
 {
 	if (!(clk->flags & RATE_FIXED))
@@ -400,39 +414,27 @@ static void omap2_dpll_recalc(struct clk
  */
 static void omap2_clksel_recalc(struct clk * clk)
 {
-	u32 fixed = 0, div = 0;
-	u32 clksel1_core;
-
-	if (clk == &iva1_mpu_int_ifck) {
-		div = 2;
-		fixed = 1;
-	}
+	u32 clksel1_core, div = 0;
 
 	clksel1_core = cm_read_mod_reg(CORE_MOD, CM_CLKSEL1);
 
 	if ((clk == &dss1_fck) &&
 	    (clksel1_core & OMAP24XX_CLKSEL_DSS1_MASK) == 0) {
-		clk->rate = sys_ck.rate;
-		return;
+		div = 1;
 	}
 
 	if ((clk == &vlynq_fck) && cpu_is_omap2420() &&
 	    (clksel1_core & OMAP2420_CLKSEL_VLYNQ_MASK) == CLKSEL_VLYNQ_96MHZ) {
-		clk->rate = func_96m_ck.rate;
-		return;
+		div = 1;
 	}
 
-	if (!fixed) {
-		div = omap2_clksel_get_divisor(clk);
-		if (div == 0)
-			return;
-	}
+	div = omap2_clksel_get_divisor(clk);
+	if (div == 0)
+		return;
 
-	if (div != 0) {
-		if (unlikely(clk->rate == clk->parent->rate / div))
-			return;
-		clk->rate = clk->parent->rate / div;
-	}
+	if (unlikely(clk->rate == clk->parent->rate / div))
+		return;
+	clk->rate = clk->parent->rate / div;
 
 	if (unlikely(clk->flags & RATE_PROPAGATES))
 		propagate_rate(clk);
@@ -832,12 +834,13 @@ static int omap2_clk_set_rate(struct clk
 /* Converts encoded control register address into a full address */
 static u32 omap2_clksel_get_src_field(void __iomem **src_addr,
 				      struct clk *src_clk, u32 *field_mask,
-				      struct clk *clk)
+				      struct clk *clk, u32 *parent_div)
 {
 	u32 val = ~0, mask = 0;
 	void __iomem *src_reg_addr = 0;
 	u32 reg_offset;
 
+	*parent_div = 0;
 	reg_offset = clk->src_offset;
 
 	/* Find target control register.*/
@@ -854,21 +857,25 @@ static u32 omap2_clksel_get_src_field(vo
 				WARN_ON(1); /* unknown src_clk */
 		} else if (reg_offset == OMAP24XX_CLKSEL_DSS1_SHIFT) {
 			mask = OMAP24XX_CLKSEL_DSS1_MASK;
-			if (src_clk == &sys_ck)
+			if (src_clk == &sys_ck) {
 				val = CLKSEL_DSS1_SYSCLK;
-			else if (src_clk == &core_ck)	/* divided clock */
-				val = CLKSEL_DSS1_CORECLK_16;	/* rate needs fixing */
-			else
+			} else if (src_clk == &core_ck) {
+				val = CLKSEL_DSS1_CORECLK_16;
+				*parent_div = 16;
+			} else {
 				WARN_ON(1); /* unknown src clk */
+			}
 		} else if ((reg_offset == OMAP2420_CLKSEL_VLYNQ_SHIFT) &&
 			   cpu_is_omap2420()) {
 			mask = OMAP2420_CLKSEL_VLYNQ_MASK;
-			if (src_clk == &func_96m_ck)
+			if (src_clk == &func_96m_ck) {
 				val = CLKSEL_VLYNQ_96MHZ;
-			else if (src_clk == &core_ck)
+			} else if (src_clk == &core_ck) {
 				val = CLKSEL_VLYNQ_CORECLK_16;
-			else
+				*parent_div = 16;
+			} else {
 				WARN_ON(1); /* unknown src_clk */
+			}
 		} else {
 			WARN_ON(1); /* unknown reg_offset */
 		}
@@ -974,7 +981,7 @@ static u32 omap2_clksel_get_src_field(vo
 static int omap2_clk_set_parent(struct clk *clk, struct clk *new_parent)
 {
 	void __iomem *src_addr;
-	u32 field_val, field_mask, reg_val;
+	u32 field_val, field_mask, reg_val, parent_div;
 
 	if (unlikely(clk->flags & CONFIG_PARTICIPANT))
 		return -EINVAL;
@@ -983,7 +990,7 @@ static int omap2_clk_set_parent(struct c
 		return -EINVAL;
 
 	field_val = omap2_clksel_get_src_field(&src_addr, new_parent,
-					       &field_mask, clk);
+					       &field_mask, clk, &parent_div);
 	if (src_addr == 0)
 		return -EINVAL;
 
@@ -1001,17 +1008,17 @@ static int omap2_clk_set_parent(struct c
 			      OMAP24XX_PRCM_CLKCFG_CTRL);
 		wmb();
 	}
+
 	if (clk->usecount > 0)
 		_omap2_clk_enable(clk);
 
 	clk->parent = new_parent;
 
 	/* SRC_RATE_SEL_MASK clocks follow their parents rates.*/
-	if ((new_parent == &core_ck) &&
-	    (clk == &dss1_fck || clk == &vlynq_fck))
-		clk->rate = new_parent->rate / 0x10;
-	else
-		clk->rate = new_parent->rate;
+	clk->rate = new_parent->rate;
+
+	if (parent_div > 0)
+		clk->rate /= parent_div;
 
 	if (unlikely(clk->flags & RATE_PROPAGATES))
 		propagate_rate(clk);
Index: linux-omap/arch/arm/mach-omap2/clock.h
===================================================================
--- linux-omap.orig/arch/arm/mach-omap2/clock.h
+++ linux-omap/arch/arm/mach-omap2/clock.h
@@ -34,6 +34,7 @@ static void omap2_sys_clk_recalc(struct 
 static u32 omap2_clksel_to_divisor(u32 div_sel, u32 field_val);
 static u32 omap2_clksel_get_divisor(struct clk *clk);
 static void omap2_dpll_recalc(struct clk *clk);
+static void omap2_fixed_divisor_recalc(struct clk *clk);
 
 #define RATE_IN_242X	(1 << 0)
 #define RATE_IN_243X	(1 << 1)
@@ -704,11 +705,10 @@ static struct clk func_48m_ck = {
 static struct clk func_12m_ck = {
 	.name		= "func_12m_ck",
 	.parent		= &func_48m_ck,
-	.rate		= 12000000,
+	.fixed_div	= 4,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
-				RATE_FIXED | RATE_PROPAGATES |
-				PARENT_CONTROLS_CLOCK,
-	.recalc		= &omap2_propagate_rate,
+				RATE_PROPAGATES | PARENT_CONTROLS_CLOCK,
+	.recalc		= &omap2_fixed_divisor_recalc,
 };
 
 /* Secure timer, only available in secure mode */
@@ -848,7 +848,8 @@ static struct clk iva1_mpu_int_ifck = {
 	.flags		= CLOCK_IN_OMAP242X,
 	.enable_reg	= OMAP_CM_REGADDR(OMAP24XX_DSP_MOD, OMAP24XX_CM_FCLKEN),
 	.enable_bit	= OMAP2420_EN_IVA_MPU_SHIFT,
-	.recalc		= &omap2_clksel_recalc,
+	.fixed_div	= 2,
+	.recalc		= &omap2_fixed_divisor_recalc,
 };
 
 /*
Index: linux-omap/include/asm-arm/arch-omap/clock.h
===================================================================
--- linux-omap.orig/include/asm-arm/arch-omap/clock.h
+++ linux-omap/include/asm-arm/arch-omap/clock.h
@@ -34,6 +34,9 @@ struct clk {
 	void			(*init)(struct clk *);
 	int			(*enable)(struct clk *);
 	void			(*disable)(struct clk *);
+#if defined(CONFIG_ARCH_OMAP2420)
+	u8			fixed_div;
+#endif
 };
 
 struct clk_functions {

-- 
