From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 23/28] omap2 clock: use standard clk->enable/disable for
	APLLs
Date: Mon, 20 Aug 2007 03:54:10 -0600
Message-ID: <20070820095532.240548798@pwsan.com>
References: <20070820095347.933473149@pwsan.com>
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline; filename=clean-up-apll-enable-disable.patch
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

Now that we're calling the clock-specific enable & disable code, we can
get rid of the special-case code in _omap2_clk_{enable,disable}() for the
APLLs.

Signed-off-by: Paul Walmsley <paul@pwsan.com>

---
 arch/arm/mach-omap2/clock.c |   20 ++++++++------------
 arch/arm/mach-omap2/clock.h |    6 ++++++
 2 files changed, 14 insertions(+), 12 deletions(-)

Index: linux-omap/arch/arm/mach-omap2/clock.c
Index: linux-omap/arch/arm/mach-omap2/clock.c
===================================================================
--- linux-omap.orig/arch/arm/mach-omap2/clock.c
+++ linux-omap/arch/arm/mach-omap2/clock.c
@@ -212,7 +212,7 @@ static int omap2_wait_clock_ready(void _
 
 
 /* Enable an APLL if off */
-static void omap2_clk_fixed_enable(struct clk *clk)
+static int omap2_clk_fixed_enable(struct clk *clk)
 {
 	u32 cval, apll_mask;
 
@@ -221,7 +221,7 @@ static void omap2_clk_fixed_enable(struc
 	cval = cm_read_mod_reg(PLL_MOD, CM_CLKEN);
 
 	if ((cval & apll_mask) == apll_mask)
-		return;   /* apll already enabled */
+		return 0;   /* apll already enabled */
 
 	cval &= ~apll_mask;
 	cval |= apll_mask;
@@ -234,6 +234,12 @@ static void omap2_clk_fixed_enable(struc
 
 	omap2_wait_clock_ready(OMAP_CM_REGADDR(PLL_MOD, CM_IDLEST), cval,
 			    clk->name);
+
+	/*
+	 * REVISIT: Should we return an error code if omap2_wait_clock_ready()
+	 * fails?
+	 */
+	return 0;
 }
 
 static void omap2_clk_wait_ready(struct clk *clk)
@@ -288,11 +294,6 @@ static int _omap2_clk_enable(struct clk 
 		return -EINVAL;
 	}
 
-	if (clk->enable_reg == OMAP_CM_REGADDR(PLL_MOD, CM_CLKEN)) {
-		omap2_clk_fixed_enable(clk);
-		return 0;
-	}
-
 	regval32 = cm_read_reg(clk->enable_reg);
 	regval32 |= (1 << clk->enable_bit);
 	cm_write_reg(regval32, clk->enable_reg);
@@ -336,11 +337,6 @@ static void _omap2_clk_disable(struct cl
 		return;
 	}
 
-	if (clk->enable_reg == OMAP_CM_REGADDR(PLL_MOD, CM_CLKEN)) {
-		omap2_clk_fixed_disable(clk);
-		return;
-	}
-
 	regval32 = cm_read_reg(clk->enable_reg);
 	regval32 &= ~(1 << clk->enable_bit);
 	cm_write_reg(regval32, clk->enable_reg);
Index: linux-omap/arch/arm/mach-omap2/clock.h
===================================================================
--- linux-omap.orig/arch/arm/mach-omap2/clock.h
+++ linux-omap/arch/arm/mach-omap2/clock.h
@@ -38,6 +38,8 @@ static u32 omap2_clksel_to_divisor(struc
 static u32 omap2_divisor_to_clksel(struct clk *clk, u32 div);
 static void omap2_dpll_recalc(struct clk *clk);
 static void omap2_fixed_divisor_recalc(struct clk *clk);
+static int omap2_clk_fixed_enable(struct clk *clk);
+static void omap2_clk_fixed_disable(struct clk *clk);
 static long omap2_clksel_round_rate(struct clk *clk, unsigned long target_rate);
 static int omap2_clksel_set_rate(struct clk *clk, unsigned long rate);
 static int omap2_reprogram_dpll(struct clk * clk, unsigned long rate);
@@ -647,6 +649,8 @@ static struct clk apll96_ck = {
 				RATE_FIXED | RATE_PROPAGATES,
 	.enable_reg	= OMAP_CM_REGADDR(PLL_MOD, CM_CLKEN),
 	.enable_bit	= OMAP24XX_EN_96M_PLL_SHIFT,
+	.enable		= &omap2_clk_fixed_enable,
+	.disable	= &omap2_clk_fixed_disable,
 	.recalc		= &propagate_rate,
 };
 
@@ -658,6 +662,8 @@ static struct clk apll54_ck = {
 				RATE_FIXED | RATE_PROPAGATES,
 	.enable_reg	= OMAP_CM_REGADDR(PLL_MOD, CM_CLKEN),
 	.enable_bit	= OMAP24XX_EN_54M_PLL_SHIFT,
+	.enable		= &omap2_clk_fixed_enable,
+	.disable	= &omap2_clk_fixed_disable,
 	.recalc		= &propagate_rate,
 };
 

-- 
