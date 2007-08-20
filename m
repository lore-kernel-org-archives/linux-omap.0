From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 13/28] omap2 clock: stop using clk->src_offset in
	omap2_clk_set_parent()
Date: Mon, 20 Aug 2007 03:54:00 -0600
Message-ID: <20070820095531.243692596@pwsan.com>
References: <20070820095347.933473149@pwsan.com>
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline; filename=convert_set_parent.patch
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

Stop using clk->src_offset in omap2_clk_set_parent(); use what we get
from the clksel code instead.

Signed-off-by: Paul Walmsley <paul@pwsan.com>

---
 arch/arm/mach-omap2/clock.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

Index: linux-omap/arch/arm/mach-omap2/clock.c
Index: linux-omap/arch/arm/mach-omap2/clock.c
===================================================================
--- linux-omap.orig/arch/arm/mach-omap2/clock.c
+++ linux-omap/arch/arm/mach-omap2/clock.c
@@ -884,7 +884,7 @@ static int omap2_clk_set_parent(struct c
 
 	/* Set new source value (previous dividers if any in effect) */
 	reg_val = __raw_readl(src_addr) & ~field_mask;
-	reg_val |= (field_val << clk->src_offset);
+	reg_val |= (field_val << convert_mask_to_shift(field_mask));
 	__raw_writel(reg_val, src_addr);
 	wmb();
 
@@ -905,6 +905,9 @@ static int omap2_clk_set_parent(struct c
 	if (parent_div > 0)
 		clk->rate /= parent_div;
 
+	pr_debug("clock: set parent of %s to %s (new rate %ld)\n",
+		 clk->name, clk->parent->name, clk->rate);
+
 	if (unlikely(clk->flags & RATE_PROPAGATES))
 		propagate_rate(clk);
 

-- 
