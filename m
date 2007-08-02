From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 16/22] omap2 clock: From: Paul Walmsley <paul@pwsan.com>
	Subject:
Date: Thu, 02 Aug 2007 12:10:18 -0600
Message-ID: <20070802181143.125777080@pwsan.com>
References: <20070802181002.792550043@pwsan.com>
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-Disposition: inline; filename=set_parent_on_only_clksel_clks.patch
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Clean up omap2_clk_set_parent() by bailing out early if the clock is not
parent-selectable.

Signed-off-by: Paul Walmsley <paul@pwsan.com>

---
 arch/arm/mach-omap2/clock.c |   77 ++++++++++++++++++++------------------------
 1 file changed, 35 insertions(+), 42 deletions(-)

Index: linux-omap/arch/arm/mach-omap2/clock.c
Index: linux-omap/arch/arm/mach-omap2/clock.c
===================================================================
--- linux-omap.orig/arch/arm/mach-omap2/clock.c
+++ linux-omap/arch/arm/mach-omap2/clock.c
@@ -913,63 +913,56 @@ static u32 omap2_get_src_field(u32 *type
 static int omap2_clk_set_parent(struct clk *clk, struct clk *new_parent)
 {
 	void __iomem * reg;
-	u32 src_sel, src_off, field_val, field_mask, reg_val, rate;
+	u32 src_sel, src_off, field_val, field_mask, reg_val;
 	int ret = -EINVAL;
 
 	if (unlikely(clk->flags & CONFIG_PARTICIPANT))
 		return ret;
 
-	if (clk->flags & SRC_SEL_MASK) {	/* On-chip SEL collection */
-		src_sel = (SRC_RATE_SEL_MASK & clk->flags);
-		src_off = clk->src_offset;
+	if (unlikely(!(clk->flags & SRC_SEL_MASK)))
+		return ret;
 
-		if (src_sel == 0)
-			goto set_parent_error;
+	src_sel = (SRC_RATE_SEL_MASK & clk->flags);
+	src_off = clk->src_offset;
 
-		field_val = omap2_get_src_field(&src_sel, src_off, new_parent,
-						&field_mask);
+	if (src_sel == 0)
+		return ret;
 
-		reg = (void __iomem *)src_sel;
+	field_val = omap2_get_src_field(&src_sel, src_off, new_parent,
+					&field_mask);
 
-		if (clk->usecount > 0)
-			_omap2_clk_disable(clk);
+	reg = (void __iomem *)src_sel;
 
-		/* Set new source value (previous dividers if any in effect) */
-		reg_val = __raw_readl(reg) & ~(field_mask << src_off);
-		reg_val |= (field_val << src_off);
-		__raw_writel(reg_val, reg);
-		wmb();
-
-		if (clk->flags & DELAYED_APP) {
-			prm_write_reg(OMAP24XX_VALID_CONFIG,
-				      OMAP24XX_PRCM_CLKCFG_CTRL);
-			wmb();
-		}
-		if (clk->usecount > 0)
-			_omap2_clk_enable(clk);
+	if (clk->usecount > 0)
+		_omap2_clk_disable(clk);
 
-		clk->parent = new_parent;
+	/* Set new source value (previous dividers if any in effect) */
+	reg_val = __raw_readl(reg) & ~(field_mask << src_off);
+	reg_val |= (field_val << src_off);
+	__raw_writel(reg_val, reg);
+	wmb();
+
+	if (clk->flags & DELAYED_APP) {
+		prm_write_reg(OMAP24XX_VALID_CONFIG,
+			      OMAP24XX_PRCM_CLKCFG_CTRL);
+		wmb();
+	}
+	if (clk->usecount > 0)
+		_omap2_clk_enable(clk);
 
-		/* SRC_RATE_SEL_MASK clocks follow their parents rates.*/
-		if ((new_parent == &core_ck) &&
-		    (clk == &dss1_fck || clk == &vlynq_fck))
-			clk->rate = new_parent->rate / 0x10;
-		else
-			clk->rate = new_parent->rate;
+	clk->parent = new_parent;
 
-		if (unlikely(clk->flags & RATE_PROPAGATES))
-			propagate_rate(clk);
+	/* SRC_RATE_SEL_MASK clocks follow their parents rates.*/
+	if ((new_parent == &core_ck) &&
+	    (clk == &dss1_fck || clk == &vlynq_fck))
+		clk->rate = new_parent->rate / 0x10;
+	else
+		clk->rate = new_parent->rate;
 
-		return 0;
-	} else {
-		clk->parent = new_parent;
-		rate = new_parent->rate;
-		omap2_clk_set_rate(clk, rate);
-		ret = 0;
-	}
+	if (unlikely(clk->flags & RATE_PROPAGATES))
+		propagate_rate(clk);
 
- set_parent_error:
-	return ret;
+	return 0;
 }
 
 /* Sets basic clocks based on the specified rate */

-- 
