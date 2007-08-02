From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 18/22] omap2 clock: Use symbolic constants in clock.c
Date: Thu, 02 Aug 2007 12:10:20 -0600
Message-ID: <20070802181143.355088908@pwsan.com>
References: <20070802181002.792550043@pwsan.com>
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline; filename=cleanup-clock.c-magic-numbers.patch
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

Convert most of the magic numbers remaining in mach-omap2/clock.c to
symbolic constants.

Signed-off-by: Paul Walmsley <paul@pwsan.com>

---
 arch/arm/mach-omap2/clock.c |  158 ++++++++++++++++++++++++++++++--------------
 1 file changed, 109 insertions(+), 49 deletions(-)

Index: linux-omap/arch/arm/mach-omap2/clock.c
Index: linux-omap/arch/arm/mach-omap2/clock.c
===================================================================
--- linux-omap.orig/arch/arm/mach-omap2/clock.c
+++ linux-omap/arch/arm/mach-omap2/clock.c
@@ -42,12 +42,47 @@
 #define CLKSEL_VLYNQ_96MHZ		0
 #define CLKSEL_VLYNQ_CORECLK_16		0x10
 
+/* CM_CLKEN_PLL.EN_{54,96}M_PLL options (24XX) */
+#define EN_APLL_STOPPED			0
+#define EN_APLL_LOCKED			3
+
+/* CM_{CLKSEL2_CORE,CLKSEL_WKUP}.CLKSEL_GPT* options (24XX) */
+#define CLKSEL_GPT_32K			0
+#define CLKSEL_GPT_SYSCLK		1
+#define CLKSEL_GPT_EXTALTCLK		2
+
+/* CM_CLKSEL1_CORE.CLKSEL_DSS1 options (24XX) */
+#define CLKSEL_DSS1_SYSCLK		0
+#define CLKSEL_DSS1_CORECLK_16		0x10
+
+/* CM_CLKSEL1_CORE.CLKSEL_DSS2 options (24XX) */
+#define CLKSEL_DSS2_SYSCLK		0
+#define CLKSEL_DSS2_48MHZ		1
+
+/* CM_CLKSEL1_PLL.APLLS_CLKIN options (24XX) */
+#define APLLS_CLKIN_19_2MHZ		0
+#define APLLS_CLKIN_13MHZ		2
+#define APLLS_CLKIN_12MHZ		3
+
+/* CM_CLKSEL1_PLL.54M_SOURCE options (24XX) */
+#define CLK_54M_SOURCE_APLL		0
+#define CLK_54M_SOURCE_EXTALTCLK	1
+
+/* CM_CLKSEL1_PLL.48M_SOURCE options (24XX) */
+#define CLK_48M_SOURCE_APLL		0
+#define CLK_48M_SOURCE_EXTALTCLK	1
+
+/* PRCM_CLKOUT_CTRL.CLKOUT_SOURCE options (2420) */
+#define CLKOUT_SOURCE_CORE_CLK		0
+#define CLKOUT_SOURCE_SYS_CLK		1
+#define CLKOUT_SOURCE_96M_CLK		2
+#define CLKOUT_SOURCE_54M_CLK		3
+
 #define MAX_PLL_LOCK_WAIT		100000
 
 //#define DOWN_VARIABLE_DPLL 1			/* Experimental */
 
 static struct prcm_config *curr_prcm_set;
-static u32 curr_perf_level = PRCM_FULL_SPEED;
 static struct clk *vclk;
 static struct clk *sclk;
 static u8 cpu_mask;
@@ -66,7 +101,7 @@ static void omap2_sys_clk_recalc(struct 
 	if (!cpu_is_omap34xx()) {
 		div = prm_read_reg(OMAP24XX_PRCM_CLKSRC_CTRL);
 		/* Test if ext clk divided by 1 or 2 */
-		div &= (0x3 << OMAP_SYSCLKDIV_SHIFT);
+		div &= OMAP_SYSCLKDIV_MASK;
 		div >>= clk->rate_offset;
 		clk->rate = (clk->parent->rate / div);
 	}
@@ -151,15 +186,17 @@ static int omap2_wait_clock_ready(void _
 /* Enable an APLL if off */
 static void omap2_clk_fixed_enable(struct clk *clk)
 {
-	u32 cval;
+	u32 cval, apll_mask;
+
+	apll_mask = EN_APLL_LOCKED << clk->enable_bit;
 
 	cval = cm_read_mod_reg(PLL_MOD, CM_CLKEN);
 
-	if ((cval & (0x3 << clk->enable_bit)) == (0x3 << clk->enable_bit))
-		return;
+	if ((cval & apll_mask) == apll_mask)
+		return;   /* apll already enabled */
 
-	cval &= ~(0x3 << clk->enable_bit);
-	cval |= (0x3 << clk->enable_bit);
+	cval &= ~apll_mask;
+	cval |= apll_mask;
 	cm_write_mod_reg(cval, PLL_MOD, CM_CLKEN);
 
 	if (clk == &apll96_ck)
@@ -188,7 +225,9 @@ static void omap2_clk_wait_ready(struct 
 
 	/* No check for DSS or cam clocks */
 	if (((u32)reg & 0x0f) == 0) { /* CM_{F,I}CLKEN1 */
-		if (clk->enable_bit <= 1 || clk->enable_bit == 31)
+		if (clk->enable_bit == OMAP24XX_EN_DSS2_SHIFT ||
+		    clk->enable_bit == OMAP24XX_EN_DSS1_SHIFT ||
+		    clk->enable_bit == OMAP24XX_EN_CAM_SHIFT)
 			return;
 	}
 
@@ -244,7 +283,7 @@ static void omap2_clk_fixed_disable(stru
 	u32 cval;
 
 	cval = cm_read_mod_reg(PLL_MOD, CM_CLKEN);
-	cval &= ~(0x3 << clk->enable_bit);
+	cval &= ~(EN_APLL_LOCKED << clk->enable_bit);
 	cm_write_mod_reg(cval, PLL_MOD, CM_CLKEN);
 }
 
@@ -326,7 +365,7 @@ static u32 omap2_dpll_round_rate(unsigne
 	core_clk_src = cm_read_mod_reg(PLL_MOD, CM_CLKSEL2);
 	core_clk_src &= OMAP24XX_CORE_CLK_SRC_MASK;
 
-	if (core_clk_src == 1) {	/* DPLL clockout */
+	if (core_clk_src == CORE_CLK_SRC_DPLL) {	/* DPLL clockout */
 		high = curr_prcm_set->dpll_speed * 2;
 		low = curr_prcm_set->dpll_speed;
 	} else {				/* DPLL clockout x 2 */
@@ -521,18 +560,18 @@ static int omap2_reprogram_dpll(struct c
 		else
 			low = curr_prcm_set->dpll_speed / 2;
 
-		/* REVISIT: This sets several reserved bits? */
 		tmpset.cm_clksel1_pll = cm_read_mod_reg(PLL_MOD, CM_CLKSEL1);
-		tmpset.cm_clksel1_pll &= ~(0x3FFF << 8);
+		tmpset.cm_clksel1_pll &= ~(OMAP24XX_DPLL_MULT_MASK |
+					   OMAP24XX_DPLL_DIV_MASK);
 		div = ((curr_prcm_set->xtal_speed / 1000000) - 1);
 		tmpset.cm_clksel2_pll = cm_read_mod_reg(PLL_MOD, CM_CLKSEL2);
 		tmpset.cm_clksel2_pll &= ~OMAP24XX_CORE_CLK_SRC_MASK;
 		if (rate > low) {
-			tmpset.cm_clksel2_pll |= 0x2;
+			tmpset.cm_clksel2_pll |= CORE_CLK_SRC_DPLL_X2;
 			mult = ((rate / 2) / 1000000);
 			done_rate = CORE_CLK_SRC_DPLL_X2;
 		} else {
-			tmpset.cm_clksel2_pll |= 0x1;
+			tmpset.cm_clksel2_pll |= CORE_CLK_SRC_DPLL;
 			mult = (rate / 1000000);
 			done_rate = CORE_CLK_SRC_DPLL;
 		}
@@ -807,22 +846,28 @@ static u32 omap2_clksel_get_src_field(vo
 		if (reg_offset == OMAP24XX_CLKSEL_DSS2_SHIFT) {
 			mask = OMAP24XX_CLKSEL_DSS2_MASK;
 			if (src_clk == &sys_ck)
-				val = 0;
-			if (src_clk == &func_48m_ck)
-				val = 1;
+				val = CLKSEL_DSS2_SYSCLK;
+			else if (src_clk == &func_48m_ck)
+				val = CLKSEL_DSS2_48MHZ;
+			else
+				WARN_ON(1); /* unknown src_clk */
 		} else if (reg_offset == OMAP24XX_CLKSEL_DSS1_SHIFT) {
 			mask = OMAP24XX_CLKSEL_DSS1_MASK;
 			if (src_clk == &sys_ck)
-				val = 0;
+				val = CLKSEL_DSS1_SYSCLK;
 			else if (src_clk == &core_ck)	/* divided clock */
-				val = 0x10;		/* rate needs fixing */
+				val = CLKSEL_DSS1_CORECLK_16;	/* rate needs fixing */
+			else
+				WARN_ON(1); /* unknown src clk */
 		} else if ((reg_offset == OMAP2420_CLKSEL_VLYNQ_SHIFT) &&
 			   cpu_is_omap2420()) {
 			mask = OMAP2420_CLKSEL_VLYNQ_MASK;
 			if (src_clk == &func_96m_ck)
-				val = 0;
+				val = CLKSEL_VLYNQ_96MHZ;
 			else if (src_clk == &core_ck)
-				val = 0x10;             /* rate needs fixing */
+				val = CLKSEL_VLYNQ_CORECLK_16;
+			else
+				WARN_ON(1); /* unknown src_clk */
 		} else {
 			WARN_ON(1); /* unknown reg_offset */
 		}
@@ -834,38 +879,46 @@ static u32 omap2_clksel_get_src_field(vo
 		mask = OMAP24XX_CLKSEL_GPT2_MASK;
 		mask <<= (reg_offset - OMAP24XX_CLKSEL_GPT2_SHIFT);
 		if (src_clk == &func_32k_ck)
-			val = 0x0;
-		if (src_clk == &sys_ck)
-			val = 0x1;
-		if (src_clk == &alt_ck)
-			val = 0x2;
+			val = CLKSEL_GPT_32K;
+		else if (src_clk == &sys_ck)
+			val = CLKSEL_GPT_SYSCLK;
+		else if (src_clk == &alt_ck)
+			val = CLKSEL_GPT_EXTALTCLK;
+		else
+			WARN_ON(1);  /* unknown src_clk */
 		break;
 	case CM_WKUP_SEL1:
 		WARN_ON(reg_offset != 0); /* unknown reg_offset */
 		src_reg_addr = OMAP_CM_REGADDR(WKUP_MOD, CM_CLKSEL);
 		mask = OMAP24XX_CLKSEL_GPT1_MASK;
 		if (src_clk == &func_32k_ck)
-			val = 0x0;
-		if (src_clk == &sys_ck)
-			val = 0x1;
-		if (src_clk == &alt_ck)
-			val = 0x2;
+			val = CLKSEL_GPT_32K;
+		else if (src_clk == &sys_ck)
+			val = CLKSEL_GPT_SYSCLK;
+		else if (src_clk == &alt_ck)
+			val = CLKSEL_GPT_EXTALTCLK;
+		else
+			WARN_ON(1); /* unknown src_clk */
 		break;
 	case CM_PLL_SEL1:
 		src_reg_addr = OMAP_CM_REGADDR(PLL_MOD, CM_CLKSEL1);
 		if (reg_offset == 0x3) {
 			mask = OMAP24XX_48M_SOURCE;
 			if (src_clk == &apll96_ck)
-				val = 0;
-			if (src_clk == &alt_ck)
-				val = 1;
+				val = CLK_48M_SOURCE_APLL;
+			else if (src_clk == &alt_ck)
+				val = CLK_48M_SOURCE_EXTALTCLK;
+			else
+				WARN_ON(1); /* unknown src_clk */
 		}
 		else if (reg_offset == 0x5) {
 			mask = OMAP24XX_54M_SOURCE;
 			if (src_clk == &apll54_ck)
-				val = 0;
-			if (src_clk == &alt_ck)
-				val = 1;
+				val = CLK_54M_SOURCE_APLL;
+			else if (src_clk == &alt_ck)
+				val = CLK_54M_SOURCE_EXTALTCLK;
+			else
+				WARN_ON(1); /* unknown src_clk */
 		} else {
 			WARN_ON(1); /* unknown reg_offset */
 		}
@@ -875,9 +928,11 @@ static u32 omap2_clksel_get_src_field(vo
 		src_reg_addr = OMAP_CM_REGADDR(PLL_MOD, CM_CLKSEL2);
 		mask = OMAP24XX_CORE_CLK_SRC_MASK;
 		if (src_clk == &func_32k_ck)
-			val = 0x0;
-		if (src_clk == &dpll_ck)
-			val = 0x2;
+			val = CORE_CLK_SRC_32K;
+		else if (src_clk == &dpll_ck)
+			val = CORE_CLK_SRC_DPLL_X2;
+		else
+			WARN_ON(1); /* unknown src_clk */
 		break;
 	case CM_SYSCLKOUT_SEL1:
 		src_reg_addr = OMAP24XX_PRCM_CLKOUT_CTRL;
@@ -892,12 +947,14 @@ static u32 omap2_clksel_get_src_field(vo
 
 		if (src_clk == &dpll_ck)
 			val = 0;
-		if (src_clk == &sys_ck)
+		else if (src_clk == &sys_ck)
 			val = 1;
-		if (src_clk == &func_96m_ck)
+		else if (src_clk == &func_96m_ck)
 			val = 2;
-		if (src_clk == &func_54m_ck)
+		else if (src_clk == &func_54m_ck)
 			val = 3;
+		else
+			WARN_ON(1); /* unknown src_clk */
 		break;
 	}
 
@@ -906,6 +963,8 @@ static u32 omap2_clksel_get_src_field(vo
 	else
 		*src_addr = src_reg_addr;
 
+	WARN_ON(mask == 0);
+
 	*field_mask = mask;
 
 	return val;
@@ -1001,7 +1060,8 @@ static int omap2_select_table_rate(struc
 		if (prcm->dpll_speed == prcm->xtal_speed)
 			bypass = 1;
 
-		if ((prcm->cm_clksel2_pll & OMAP24XX_CORE_CLK_SRC_MASK) == 2)
+		if ((prcm->cm_clksel2_pll & OMAP24XX_CORE_CLK_SRC_MASK) ==
+		    CORE_CLK_SRC_DPLL_X2)
 			done_rate = CORE_CLK_SRC_DPLL_X2;
 		else
 			done_rate = CORE_CLK_SRC_DPLL;
@@ -1016,7 +1076,7 @@ static int omap2_select_table_rate(struc
 		cm_write_mod_reg(prcm->cm_clksel_gfx, GFX_MOD, CM_CLKSEL);
 
 		/* Major subsystem dividers */
-		tmp = cm_read_mod_reg(CORE_MOD, CM_CLKSEL1) & 0x2000;
+		tmp = cm_read_mod_reg(CORE_MOD, CM_CLKSEL1) & OMAP24XX_CLKSEL_DSS2_MASK;
 		cm_write_mod_reg(prcm->cm_clksel1_core | tmp, CORE_MOD, CM_CLKSEL1);
 		if (cpu_is_omap2430())
 			cm_write_mod_reg(prcm->cm_clksel_mdm,
@@ -1073,13 +1133,13 @@ static void __init omap2_get_crystal_rat
 
 	aplls = cm_read_mod_reg(PLL_MOD, CM_CLKSEL1);
 	aplls &= OMAP24XX_APLLS_CLKIN_MASK;
-	aplls >>= OMAP24XX_APLLS_CLKIN_SHIFT;	/* Isolate field, 0,2,3 */
+	aplls >>= OMAP24XX_APLLS_CLKIN_SHIFT;
 
-	if (aplls == 0)
+	if (aplls == APLLS_CLKIN_19_2MHZ)
 		sclk = 19200000;
-	else if (aplls == 2)
+	else if (aplls == APLLS_CLKIN_13MHZ)
 		sclk = 13000000;
-	else if (aplls == 3)
+	else if (aplls == APLLS_CLKIN_12MHZ)
 		sclk = 12000000;
 
 	div = prm_read_reg(OMAP24XX_PRCM_CLKSRC_CTRL);

-- 
