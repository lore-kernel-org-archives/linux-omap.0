From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 12/27] omap2 clock: stop using clk->src_offset in
	omap2_clk_set_rate()
Date: Mon, 27 Aug 2007 02:39:08 -0600
Message-ID: <20070827084123.256921718@pwsan.com>
References: <20070827083856.549249288@pwsan.com>
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline; filename=convert_set_rate.patch
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

Stop using clk->rate_offset in omap2_clk_set_rate(); use what we get
from the clksel code instead.

Signed-off-by: Paul Walmsley <paul@pwsan.com>

---
 arch/arm/mach-omap2/clock.c |    9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

Index: linux-omap/arch/arm/mach-omap2/clock.c
===================================================================
--- linux-omap.orig/arch/arm/mach-omap2/clock.c	2007-08-27 02:19:36.000000000 -0600
+++ linux-omap/arch/arm/mach-omap2/clock.c	2007-08-27 02:19:37.000000000 -0600
@@ -781,17 +781,14 @@
 static int omap2_clk_set_rate(struct clk *clk, unsigned long rate)
 {
 	int ret = -EINVAL;
-	u32 div_off, field_mask, field_val, reg_val, validrate;
-	u32 new_div = 0;
+	u32 field_mask, field_val, reg_val, new_div = 0;
+	unsigned long validrate;
 	void __iomem *div_addr;
 
 	if (!(clk->flags & CONFIG_PARTICIPANT) && (clk->flags & RATE_CKCTL)) {
 		if (clk == &dpll_ck)
 			return omap2_reprogram_dpll(clk, rate);
 
-		/* Isolate control register */
-		div_off = clk->rate_offset;
-
 		validrate = omap2_clksel_round_rate(clk, rate, &new_div);
 		if (validrate != rate)
 			return ret;
@@ -806,7 +803,7 @@
 
 		reg_val = cm_read_reg(div_addr);
 		reg_val &= ~field_mask;
-		reg_val |= (field_val << div_off);
+		reg_val |= (field_val << mask_to_shift(field_mask));
 		cm_write_reg(reg_val, div_addr);
 		wmb();
 		clk->rate = clk->parent->rate / new_div;

-- 
