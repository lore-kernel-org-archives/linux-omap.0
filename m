From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 13/22] omap2 clock: convert PARENT_CONTROLS_CLOCK into a
	clock flag
Date: Thu, 02 Aug 2007 12:10:15 -0600
Message-ID: <20070802181142.791439404@pwsan.com>
References: <20070802181002.792550043@pwsan.com>
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline;
	filename=convert-parent-controls-clock-into-clock-flag.patch
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

The clock framework currently uses a magic value in struct clk
.enable_bit to indicate that the clock's parent controls enabling and
disabling the clock.  There's no need to use this type of in-band
special value when there's already a good means to indicate binary
clock parameters: the clock flags field.  This patch converts the
existing PARENT_CONTROLS_CLOCK code to use a clock flag.

Signed-off-by: Paul Walmsley <paul@pwsan.com>


---
 arch/arm/mach-omap2/clock.c       |   15 ++++++---------
 arch/arm/mach-omap2/clock.h       |   23 ++++++++---------------
 include/asm-arm/arch-omap/clock.h |    2 ++
 3 files changed, 16 insertions(+), 24 deletions(-)

Index: linux-omap/arch/arm/mach-omap2/clock.c
===================================================================
--- linux-omap.orig/arch/arm/mach-omap2/clock.c
+++ linux-omap/arch/arm/mach-omap2/clock.c
@@ -122,9 +122,6 @@ static void omap2_clk_fixed_enable(struc
 {
 	u32 cval, i=0;
 
-	if (clk->enable_bit == PARENT_CONTROLS_CLOCK)	/* Parent will do it */
-		return;
-
 	cval = cm_read_mod_reg(PLL_MOD, CM_CLKEN);
 
 	if ((cval & (0x3 << clk->enable_bit)) == (0x3 << clk->enable_bit))
@@ -197,7 +194,7 @@ static int _omap2_clk_enable(struct clk 
 {
 	u32 regval32;
 
-	if (clk->flags & ALWAYS_ENABLED)
+	if (clk->flags & (ALWAYS_ENABLED | PARENT_CONTROLS_CLOCK))
 		return 0;
 
 	if (unlikely(clk == &osc_ck)) {
@@ -211,7 +208,7 @@ static int _omap2_clk_enable(struct clk 
 		return 0;
 	}
 
-	if (clk->enable_reg == (void __iomem *)OMAP_CM_REGADDR(PLL_MOD, CM_CLKEN)) {
+	if (clk->enable_reg == OMAP_CM_REGADDR(PLL_MOD, CM_CLKEN)) {
 		omap2_clk_fixed_enable(clk);
 		return 0;
 	}
@@ -231,9 +228,6 @@ static void omap2_clk_fixed_disable(stru
 {
 	u32 cval;
 
-	if (clk->enable_bit == PARENT_CONTROLS_CLOCK)
-		return;		/* let parent off do it */
-
 	cval = cm_read_mod_reg(PLL_MOD, CM_CLKEN);
 	cval &= ~(0x3 << clk->enable_bit);
 	cm_write_mod_reg(cval, PLL_MOD, CM_CLKEN);
@@ -244,6 +238,9 @@ static void _omap2_clk_disable(struct cl
 {
 	u32 regval32;
 
+	if (clk->flags & (ALWAYS_ENABLED | PARENT_CONTROLS_CLOCK))
+		return;
+
 	if (unlikely(clk == &osc_ck)) {
 		omap2_set_osc_ck(0);
 		return;
@@ -252,7 +249,7 @@ static void _omap2_clk_disable(struct cl
 	if (clk->enable_reg == 0)
 		return;
 
-	if (clk->enable_reg == (void __iomem *)OMAP_CM_REGADDR(PLL_MOD, CM_CLKEN)) {
+	if (clk->enable_reg == OMAP_CM_REGADDR(PLL_MOD, CM_CLKEN)) {
 		omap2_clk_fixed_disable(clk);
 		return;
 	}
Index: linux-omap/arch/arm/mach-omap2/clock.h
===================================================================
--- linux-omap.orig/arch/arm/mach-omap2/clock.h
+++ linux-omap/arch/arm/mach-omap2/clock.h
@@ -34,9 +34,6 @@ static void omap2_sys_clk_recalc(struct 
 static u32 omap2_clksel_to_divisor(u32 div_sel, u32 field_val);
 static u32 omap2_clksel_get_divisor(struct clk *clk);
 
-/* REVISIT: should use a clock flag for this, not a magic number */
-#define PARENT_CONTROLS_CLOCK	0xff
-
 #define RATE_IN_242X	(1 << 0)
 #define RATE_IN_243X	(1 << 1)
 #define RATE_IN_343X	(1 << 2)
@@ -667,10 +664,9 @@ static struct clk func_54m_ck = {
 	.parent		= &apll54_ck,	/* can also be alt_clk */
 	.rate		= 54000000,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
-				RATE_FIXED | CM_PLL_SEL1 | RATE_PROPAGATES,
+				RATE_FIXED | CM_PLL_SEL1 | RATE_PROPAGATES |
+				PARENT_CONTROLS_CLOCK,
 	.src_offset	= OMAP24XX_54M_SOURCE_SHIFT,
-	.enable_reg	= OMAP_CM_REGADDR(PLL_MOD, CM_CLKEN),
-	.enable_bit	= PARENT_CONTROLS_CLOCK,
 	.recalc		= &omap2_propagate_rate,
 };
 
@@ -687,9 +683,8 @@ static struct clk func_96m_ck = {
 	.parent		= &apll96_ck,
 	.rate		= 96000000,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
-				RATE_FIXED | RATE_PROPAGATES,
-	.enable_reg	= OMAP_CM_REGADDR(PLL_MOD, CM_CLKEN),
-	.enable_bit	= PARENT_CONTROLS_CLOCK,
+				RATE_FIXED | RATE_PROPAGATES |
+				PARENT_CONTROLS_CLOCK,
 	.recalc		= &omap2_propagate_rate,
 };
 
@@ -698,10 +693,9 @@ static struct clk func_48m_ck = {
 	.parent		= &apll96_ck,	 /* 96M or Alt */
 	.rate		= 48000000,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
-				RATE_FIXED | CM_PLL_SEL1 | RATE_PROPAGATES,
+				RATE_FIXED | CM_PLL_SEL1 | RATE_PROPAGATES |
+				PARENT_CONTROLS_CLOCK,
 	.src_offset	= OMAP24XX_48M_SOURCE_SHIFT,
-	.enable_reg	= OMAP_CM_REGADDR(PLL_MOD, CM_CLKEN),
-	.enable_bit	= PARENT_CONTROLS_CLOCK,
 	.recalc		= &omap2_propagate_rate,
 };
 
@@ -710,10 +704,9 @@ static struct clk func_12m_ck = {
 	.parent		= &func_48m_ck,
 	.rate		= 12000000,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
-				RATE_FIXED | RATE_PROPAGATES,
+				RATE_FIXED | RATE_PROPAGATES |
+				PARENT_CONTROLS_CLOCK,
 	.recalc		= &omap2_propagate_rate,
-	.enable_reg	= OMAP_CM_REGADDR(PLL_MOD, CM_CLKEN),
-	.enable_bit	= PARENT_CONTROLS_CLOCK,
 };
 
 /* Secure timer, only available in secure mode */
Index: linux-omap/include/asm-arm/arch-omap/clock.h
===================================================================
--- linux-omap.orig/include/asm-arm/arch-omap/clock.h
+++ linux-omap/include/asm-arm/arch-omap/clock.h
@@ -88,6 +88,8 @@ extern int clk_get_usecount(struct clk *
 #define CLOCK_IN_OMAP242X	(1 << 25)
 #define CLOCK_IN_OMAP243X	(1 << 26)
 #define CLOCK_IN_OMAP343X	(1 << 27)
+#define PARENT_CONTROLS_CLOCK	(1 << 28)
+
 
 
 /* CM_CLKSEL2_PLL.CORE_CLK_SRC options (24XX) */

-- 
