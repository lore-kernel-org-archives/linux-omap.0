From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 05/22] omap2 clock: fix CodingStyle issues
Date: Thu, 02 Aug 2007 12:10:07 -0600
Message-ID: <20070802181141.896203830@pwsan.com>
References: <20070802181002.792550043@pwsan.com>
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline; filename=codingstyle-clock.c.patch
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

Clean up some CodingStyle non-conformances in clock.c.

Signed-off-by: Paul Walmsley <paul@pwsan.com>


---
 arch/arm/mach-omap2/clock.c |   40 ++++++++++++++++++++--------------------
 1 file changed, 20 insertions(+), 20 deletions(-)

Index: linux-omap/arch/arm/mach-omap2/clock.c
Index: linux-omap/arch/arm/mach-omap2/clock.c
===================================================================
--- linux-omap.orig/arch/arm/mach-omap2/clock.c
+++ linux-omap/arch/arm/mach-omap2/clock.c
@@ -396,7 +396,7 @@ static inline u32 omap2_divider_from_tab
 	if (div_array == NULL)
 		return ~1;
 
-	for (i=0; i < size; i++) {
+	for (i = 0; i < size; i++) {
 		test_rate = src_rate / *div_array;
 		if (test_rate <= tgt_rate)
 			return *div_array;
@@ -418,45 +418,45 @@ static u32 omap2_clksel_round_rate(struc
 	u32 gfx_div[] = {2, 3, 4};
 	u32 sysclkout_div[] = {1, 2, 4, 8, 16};
 	u32 dss1_div[] = {1, 2, 3, 4, 5, 6, 8, 9, 12, 16};
-	u32 vylnq_div[] = {1, 2, 3, 4, 6, 8, 9, 12, 16, 18};
+	u32 vlynq_div[] = {1, 2, 3, 4, 6, 8, 9, 12, 16, 18};
 	u32 best_div = ~0, asize = 0;
 	u32 *div_array = NULL;
 
 	switch (tclk->flags & SRC_RATE_SEL_MASK) {
 	case CM_GFX_SEL1:
-		asize = 3;
+		asize = ARRAY_SIZE(gfx_div);
 		div_array = gfx_div;
 		break;
 	case CM_PLL_SEL1:
 		return omap2_dpll_round_rate(target_rate);
 	case CM_SYSCLKOUT_SEL1:
-		asize = 5;
+		asize = ARRAY_SIZE(sysclkout_div);
 		div_array = sysclkout_div;
 		break;
 	case CM_CORE_SEL1:
-		if(tclk == &dss1_fck){
-			if(tclk->parent == &core_ck){
-				asize = 10;
+		if (tclk == &dss1_fck) {
+			if (tclk->parent == &core_ck) {
+				asize = ARRAY_SIZE(dss1_div);
 				div_array = dss1_div;
 			} else {
 				*new_div = 0; /* fixed clk */
 				return(tclk->parent->rate);
 			}
-		} else if((tclk == &vlynq_fck) && cpu_is_omap2420()){
-			if(tclk->parent == &core_ck){
-				asize = 10;
-				div_array = vylnq_div;
+		} else if ((tclk == &vlynq_fck) && cpu_is_omap2420()) {
+			if (tclk->parent == &core_ck) {
+				asize = ARRAY_SIZE(vlynq_div);
+				div_array = vlynq_div;
 			} else {
 				*new_div = 0; /* fixed clk */
-				return(tclk->parent->rate);
+				return (tclk->parent->rate);
 			}
 		}
 		break;
 	}
 
 	best_div = omap2_divider_from_table(asize, div_array,
-	 tclk->parent->rate, target_rate);
-	if (best_div == ~0){
+					    tclk->parent->rate, target_rate);
+	if (best_div == ~0) {
 		*new_div = 1;
 		return best_div; /* signal error */
 	}
@@ -778,7 +778,6 @@ static u32 omap2_clksel_get_divisor(stru
 
 /* Set the clock rate for a clock source */
 static int omap2_clk_set_rate(struct clk *clk, unsigned long rate)
-
 {
 	int ret = -EINVAL;
 	void __iomem * reg;
@@ -795,7 +794,7 @@ static int omap2_clk_set_rate(struct clk
 
 		validrate = omap2_clksel_round_rate(clk, rate, &new_div);
 		if (validrate != rate)
-			return(ret);
+			return ret;
 
 		field_val = omap2_get_clksel(&div_sel, &field_mask, clk);
 		if (div_sel == 0)
@@ -837,8 +836,9 @@ static int omap2_clk_set_rate(struct clk
 			wmb();
 		}
 		ret = 0;
-	} else if (clk->set_rate != 0)
+	} else if (clk->set_rate != 0) {
 		ret = clk->set_rate(clk, rate);
+	}
 
 	if (unlikely(ret == 0 && (clk->flags & RATE_PROPAGATES)))
 		propagate_rate(clk);
@@ -872,10 +872,10 @@ static u32 omap2_get_src_field(u32 *type
 			else if (src_clk == &core_ck)	/* divided clock */
 				val = 0x10;		/* rate needs fixing */
 		} else if ((reg_offset == OMAP2420_CLKSEL_VLYNQ_SHIFT) &&
-			   cpu_is_omap2420()){
+			   cpu_is_omap2420()) {
 			mask = OMAP2420_CLKSEL_VLYNQ_MASK;
 			mask >>= OMAP2420_CLKSEL_VLYNQ_SHIFT;
-			if(src_clk == &func_96m_ck)
+			if (src_clk == &func_96m_ck)
 				val = 0;
 			else if (src_clk == &core_ck)
 				val = 0x10;
@@ -1034,7 +1034,7 @@ static int omap2_select_table_rate(struc
 
 	if (!found_speed) {
 		printk(KERN_INFO "Could not set MPU rate to %luMHz\n",
-	 rate / 1000000);
+		       rate / 1000000);
 		return -EINVAL;
 	}
 

-- 
