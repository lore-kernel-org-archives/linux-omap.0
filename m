From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 03/22] omap2 clock: fix clksel divisor bug
Date: Thu, 02 Aug 2007 12:10:05 -0600
Message-ID: <20070802181141.665897894@pwsan.com>
References: <20070802181002.792550043@pwsan.com>
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline; filename=fix_clock_div_error.patch
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

For clksel clocks, omap2_clk_set_rate() incorrectly divides the parent
clock's rate by the actual bits of the register field, rather than the
translated divisor value.  This happens to work for most clksel
clocks, since the register bit fields are equal to the divisor values.
But for some clocks, such as sys_clkout, the code gets the resulting
rate wrong.

Signed-off-by: Paul Walmsley <paul@pwsan.com>

---
 arch/arm/mach-omap2/clock.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-omap/arch/arm/mach-omap2/clock.c
===================================================================
--- linux-omap.orig/arch/arm/mach-omap2/clock.c
+++ linux-omap/arch/arm/mach-omap2/clock.c
@@ -819,7 +819,7 @@ static int omap2_clk_set_rate(struct clk
 		reg_val |= (field_val << div_off);
 		cm_write_reg(reg_val, reg);
 		wmb();
-		clk->rate = clk->parent->rate / field_val;
+		clk->rate = clk->parent->rate / new_div;
 
 		if (clk->flags & DELAYED_APP) {
 			prm_write_reg(OMAP24XX_VALID_CONFIG,

-- 
