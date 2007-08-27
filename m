From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 11/27] omap2 clock: convert omap2_clksel_get_src_field() to
	use new clksel struct
Date: Mon, 27 Aug 2007 02:39:07 -0600
Message-ID: <20070827084123.160092031@pwsan.com>
References: <20070827083856.549249288@pwsan.com>
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline; filename=convert_get_src_field.patch
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

Convert omap2_clksel_get_src_field() to use new struct clksel and struct
clksel_rate data. 

Signed-off-by: Paul Walmsley <paul@pwsan.com>

---
 arch/arm/mach-omap2/clock.c |  206 +++++---------------------------------------
 1 file changed, 25 insertions(+), 181 deletions(-)

Index: linux-omap/arch/arm/mach-omap2/clock.c
===================================================================
--- linux-omap.orig/arch/arm/mach-omap2/clock.c	2007-08-27 02:19:33.000000000 -0600
+++ linux-omap/arch/arm/mach-omap2/clock.c	2007-08-27 02:19:36.000000000 -0600
@@ -46,38 +46,11 @@
 #define EN_APLL_STOPPED			0
 #define EN_APLL_LOCKED			3
 
-/* CM_{CLKSEL2_CORE,CLKSEL_WKUP}.CLKSEL_GPT* options (24XX) */
-#define CLKSEL_GPT_32K			0
-#define CLKSEL_GPT_SYSCLK		1
-#define CLKSEL_GPT_EXTALTCLK		2
-
-/* CM_CLKSEL1_CORE.CLKSEL_DSS1 options (24XX) */
-#define CLKSEL_DSS1_SYSCLK		0
-#define CLKSEL_DSS1_CORECLK_16		0x10
-
-/* CM_CLKSEL1_CORE.CLKSEL_DSS2 options (24XX) */
-#define CLKSEL_DSS2_SYSCLK		0
-#define CLKSEL_DSS2_48MHZ		1
-
 /* CM_CLKSEL1_PLL.APLLS_CLKIN options (24XX) */
 #define APLLS_CLKIN_19_2MHZ		0
 #define APLLS_CLKIN_13MHZ		2
 #define APLLS_CLKIN_12MHZ		3
 
-/* CM_CLKSEL1_PLL.54M_SOURCE options (24XX) */
-#define CLK_54M_SOURCE_APLL		0
-#define CLK_54M_SOURCE_EXTALTCLK	1
-
-/* CM_CLKSEL1_PLL.48M_SOURCE options (24XX) */
-#define CLK_48M_SOURCE_APLL		0
-#define CLK_48M_SOURCE_EXTALTCLK	1
-
-/* PRCM_CLKOUT_CTRL.CLKOUT_SOURCE options (2420) */
-#define CLKOUT_SOURCE_CORE_CLK		0
-#define CLKOUT_SOURCE_SYS_CLK		1
-#define CLKOUT_SOURCE_96M_CLK		2
-#define CLKOUT_SOURCE_54M_CLK		3
-
 #define MAX_PLL_LOCK_WAIT		100000
 
 //#define DOWN_VARIABLE_DPLL 1			/* Experimental */
@@ -474,28 +447,6 @@
 		propagate_rate(clk);
 }
 
-/*
- * Finds best divider value in an array based on the source and target
- * rates. The divider array must be sorted with smallest divider first.
- */
-static inline u32 omap2_divider_from_table(u32 size, u32 *div_array,
-					   u32 src_rate, u32 tgt_rate)
-{
-	int i, test_rate;
-
-	if (div_array == NULL)
-		return ~1;
-
-	for (i = 0; i < size; i++) {
-		test_rate = src_rate / *div_array;
-		if (test_rate <= tgt_rate)
-			return *div_array;
-		++div_array;
-	}
-
-	return ~0;	/* No acceptable divider */
-}
-
 /**
  * omap2_get_clksel_by_parent - return clksel struct for a given clk & parent
  * @clk: OMAP struct clk ptr to inspect
@@ -876,151 +827,44 @@
 	return ret;
 }
 
-/* Converts encoded control register address into a full address */
+/*
+ * Converts encoded control register address into a full address
+ * On error, *src_addr will be returned as 0.
+ */
 static u32 omap2_clksel_get_src_field(void __iomem **src_addr,
 				      struct clk *src_clk, u32 *field_mask,
 				      struct clk *clk, u32 *parent_div)
 {
-	u32 val = ~0, mask = 0;
-	void __iomem *src_reg_addr = 0;
-	u32 reg_offset;
+	const struct clksel *clks;
+	const struct clksel_rate *clkr;
 
 	*parent_div = 0;
-	reg_offset = clk->src_offset;
+	*src_addr = 0;
 
-	/* Find target control register.*/
-	switch (clk->flags & SRC_RATE_SEL_MASK) {
-	case CM_CORE_SEL1:
-		src_reg_addr = OMAP_CM_REGADDR(CORE_MOD, CM_CLKSEL1);
-		if (reg_offset == OMAP24XX_CLKSEL_DSS2_SHIFT) {
-			mask = OMAP24XX_CLKSEL_DSS2_MASK;
-			if (src_clk == &sys_ck)
-				val = CLKSEL_DSS2_SYSCLK;
-			else if (src_clk == &func_48m_ck)
-				val = CLKSEL_DSS2_48MHZ;
-			else
-				WARN_ON(1); /* unknown src_clk */
-		} else if (reg_offset == OMAP24XX_CLKSEL_DSS1_SHIFT) {
-			mask = OMAP24XX_CLKSEL_DSS1_MASK;
-			if (src_clk == &sys_ck) {
-				val = CLKSEL_DSS1_SYSCLK;
-			} else if (src_clk == &core_ck) {
-				val = CLKSEL_DSS1_CORECLK_16;
-				*parent_div = 16;
-			} else {
-				WARN_ON(1); /* unknown src clk */
-			}
-		} else if ((reg_offset == OMAP2420_CLKSEL_VLYNQ_SHIFT) &&
-			   cpu_is_omap2420()) {
-			mask = OMAP2420_CLKSEL_VLYNQ_MASK;
-			if (src_clk == &func_96m_ck) {
-				val = CLKSEL_VLYNQ_96MHZ;
-			} else if (src_clk == &core_ck) {
-				val = CLKSEL_VLYNQ_CORECLK_16;
-				*parent_div = 16;
-			} else {
-				WARN_ON(1); /* unknown src_clk */
-			}
-		} else {
-			WARN_ON(1); /* unknown reg_offset */
-		}
-		break;
-	case CM_CORE_SEL2:
-		WARN_ON(reg_offset < OMAP24XX_CLKSEL_GPT2_SHIFT ||
-			reg_offset > OMAP24XX_CLKSEL_GPT12_SHIFT);
-		src_reg_addr = OMAP_CM_REGADDR(CORE_MOD, CM_CLKSEL2);
-		mask = OMAP24XX_CLKSEL_GPT2_MASK;
-		mask <<= (reg_offset - OMAP24XX_CLKSEL_GPT2_SHIFT);
-		if (src_clk == &func_32k_ck)
-			val = CLKSEL_GPT_32K;
-		else if (src_clk == &sys_ck)
-			val = CLKSEL_GPT_SYSCLK;
-		else if (src_clk == &alt_ck)
-			val = CLKSEL_GPT_EXTALTCLK;
-		else
-			WARN_ON(1);  /* unknown src_clk */
-		break;
-	case CM_WKUP_SEL1:
-		WARN_ON(reg_offset != 0); /* unknown reg_offset */
-		src_reg_addr = OMAP_CM_REGADDR(WKUP_MOD, CM_CLKSEL);
-		mask = OMAP24XX_CLKSEL_GPT1_MASK;
-		if (src_clk == &func_32k_ck)
-			val = CLKSEL_GPT_32K;
-		else if (src_clk == &sys_ck)
-			val = CLKSEL_GPT_SYSCLK;
-		else if (src_clk == &alt_ck)
-			val = CLKSEL_GPT_EXTALTCLK;
-		else
-			WARN_ON(1); /* unknown src_clk */
-		break;
-	case CM_PLL_SEL1:
-		src_reg_addr = OMAP_CM_REGADDR(PLL_MOD, CM_CLKSEL1);
-		if (reg_offset == 0x3) {
-			mask = OMAP24XX_48M_SOURCE;
-			if (src_clk == &apll96_ck)
-				val = CLK_48M_SOURCE_APLL;
-			else if (src_clk == &alt_ck)
-				val = CLK_48M_SOURCE_EXTALTCLK;
-			else
-				WARN_ON(1); /* unknown src_clk */
-		}
-		else if (reg_offset == 0x5) {
-			mask = OMAP24XX_54M_SOURCE;
-			if (src_clk == &apll54_ck)
-				val = CLK_54M_SOURCE_APLL;
-			else if (src_clk == &alt_ck)
-				val = CLK_54M_SOURCE_EXTALTCLK;
-			else
-				WARN_ON(1); /* unknown src_clk */
-		} else {
-			WARN_ON(1); /* unknown reg_offset */
-		}
-		break;
-	case CM_PLL_SEL2:
-		WARN_ON(reg_offset != 0);
-		src_reg_addr = OMAP_CM_REGADDR(PLL_MOD, CM_CLKSEL2);
-		mask = OMAP24XX_CORE_CLK_SRC_MASK;
-		if (src_clk == &func_32k_ck)
-			val = CORE_CLK_SRC_32K;
-		else if (src_clk == &dpll_ck)
-			val = CORE_CLK_SRC_DPLL_X2;
-		else
-			WARN_ON(1); /* unknown src_clk */
-		break;
-	case CM_SYSCLKOUT_SEL1:
-		src_reg_addr = OMAP24XX_PRCM_CLKOUT_CTRL;
-
-		if (reg_offset == OMAP24XX_CLKOUT_SOURCE_SHIFT) {
-			mask = OMAP24XX_CLKOUT_SOURCE_MASK;
-		} else if (reg_offset == OMAP2420_CLKOUT2_SOURCE_SHIFT) {
-			mask = OMAP2420_CLKOUT2_SOURCE_MASK;
-		} else {
-			WARN_ON(1); /* unknown reg_offset */
-		}
+	clks = omap2_get_clksel_by_parent(clk, src_clk);
+	if (clks == NULL)
+		return 0;
 
-		if (src_clk == &dpll_ck)
-			val = 0;
-		else if (src_clk == &sys_ck)
-			val = 1;
-		else if (src_clk == &func_96m_ck)
-			val = 2;
-		else if (src_clk == &func_54m_ck)
-			val = 3;
-		else
-			WARN_ON(1); /* unknown src_clk */
-		break;
+	for (clkr = clks->rates; clkr->div; clkr++) {
+		if (clkr->flags & (cpu_mask | DEFAULT_RATE))
+			break; /* Found the default rate for this platform */
 	}
 
-	if (val == ~0)			/* Catch errors in offset */
-		*src_addr = 0;
-	else
-		*src_addr = src_reg_addr;
+	if (!clkr->div) {
+		printk(KERN_ERR "clock: Could not find default rate for "
+		       "clock %s parent %s\n", clk->name,
+		       src_clk->parent->name);
+		return 0;
+	}
 
-	WARN_ON(mask == 0);
+	/* Should never happen.  Add a clksel mask to the struct clk. */
+	WARN_ON(clk->clksel_mask == 0);
 
-	*field_mask = mask;
+	*field_mask = clk->clksel_mask;
+	*src_addr = clk->clksel_reg;
+	*parent_div = clkr->div;
 
-	return val;
+	return clkr->val;
 }
 
 static int omap2_clk_set_parent(struct clk *clk, struct clk *new_parent)

-- 
