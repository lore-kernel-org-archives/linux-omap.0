From: Paul Walmsley <paul@booyaka.com>
Subject: omap2: use symbolic constant to mark parent-controlled clocks in
 clock.[ch]
Date: Thu, 3 May 2007 12:08:06 -0600 (MDT)
Message-ID: <Pine.LNX.4.64.0705031206440.19145@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
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


The current OMAP2 clock management code uses a magic number, 0xff, to 
indicate that the clock's parent will handle enabling and disabling the 
clock.  Move the magic number into a symbolic constant for readability.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
  arch/arm/mach-omap2/clock.c |    6 +++---
  arch/arm/mach-omap2/clock.h |   10 ++++++----
  2 files changed, 9 insertions(+), 7 deletions(-)

Index: linux-omap-2.6/arch/arm/mach-omap2/clock.c
===================================================================
--- linux-omap-2.6.orig/arch/arm/mach-omap2/clock.c
+++ linux-omap-2.6/arch/arm/mach-omap2/clock.c
@@ -97,7 +97,7 @@ static void omap2_clk_fixed_enable(struc
  {
  	u32 cval, i=0;

-	if (clk->enable_bit == 0xff)			/* Parent will do it */
+	if (clk->enable_bit == PARENT_CONTROLS_CLOCK)	/* Parent will do it */
  		return;

  	cval = CM_CLKEN_PLL;
@@ -205,8 +205,8 @@ static void omap2_clk_fixed_disable(stru
  {
  	u32 cval;

-	if(clk->enable_bit == 0xff)		/* let parent off do it */
-		return;
+	if (clk->enable_bit == PARENT_CONTROLS_CLOCK)
+		return;		/* let parent off do it */

  	cval = CM_CLKEN_PLL;
  	cval &= ~(0x3 << clk->enable_bit);
Index: linux-omap-2.6/arch/arm/mach-omap2/clock.h
===================================================================
--- linux-omap-2.6.orig/arch/arm/mach-omap2/clock.h
+++ linux-omap-2.6/arch/arm/mach-omap2/clock.h
@@ -29,6 +29,8 @@ static void omap2_sys_clk_recalc(struct
  static u32 omap2_clksel_to_divisor(u32 div_sel, u32 field_val);
  static u32 omap2_clksel_get_divisor(struct clk *clk);

+/* REVISIT: should use a clock flag for this, not a magic number */
+#define PARENT_CONTROLS_CLOCK	0xff

  #define RATE_IN_242X	(1 << 0)
  #define RATE_IN_243X	(1 << 1)
@@ -664,7 +666,7 @@ static struct clk func_54m_ck = {
  				RATE_FIXED | CM_PLL_SEL1 | RATE_PROPAGATES,
  	.src_offset	= 5,
  	.enable_reg	= (void __iomem *)&CM_CLKEN_PLL,
-	.enable_bit	= 0xff,
+	.enable_bit	= PARENT_CONTROLS_CLOCK,
  	.recalc		= &omap2_propagate_rate,
  };

@@ -691,7 +693,7 @@ static struct clk func_96m_ck = {
  	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
  				RATE_FIXED | RATE_PROPAGATES,
  	.enable_reg	= (void __iomem *)&CM_CLKEN_PLL,
-	.enable_bit	= 0xff,
+	.enable_bit	= PARENT_CONTROLS_CLOCK,
  	.recalc		= &omap2_propagate_rate,
  };

@@ -703,7 +705,7 @@ static struct clk func_48m_ck = {
  				RATE_FIXED | CM_PLL_SEL1 | RATE_PROPAGATES,
  	.src_offset	= 3,
  	.enable_reg	= (void __iomem *)&CM_CLKEN_PLL,
-	.enable_bit	= 0xff,
+	.enable_bit	= PARENT_CONTROLS_CLOCK,
  	.recalc		= &omap2_propagate_rate,
  };

@@ -715,7 +717,7 @@ static struct clk func_12m_ck = {
  				RATE_FIXED | RATE_PROPAGATES,
  	.recalc		= &omap2_propagate_rate,
  	.enable_reg	= (void __iomem *)&CM_CLKEN_PLL,
-	.enable_bit	= 0xff,
+	.enable_bit	= PARENT_CONTROLS_CLOCK,
  };

  /* Secure timer, only available in secure mode */
