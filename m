From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 15/22] omap2 clock: return -EINVAL if no clock enable code;
	fix dpll_ck enable
Date: Thu, 02 Aug 2007 12:10:17 -0600
Message-ID: <20070802181143.017374780@pwsan.com>
References: <20070802181002.792550043@pwsan.com>
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline;
	filename=return-einval-if-no-enable-bit-defined.patch
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

If the clock framework can't figure out how to enable a clock, return
-EINVAL to indicate that the clock cannot be enabled.  Previously the
code returned 0, which indicated success.

Also fix the "clock.c: Enable for dpll_ck without enable code" boot
warning by marking dpll_ck as ALWAYS_ENABLED.  This is not technically
true, since the DPLL can be bypassed; but since we currently have no
software infrastructure to control it directly, ALWAYS_ENABLED is a
sufficient fiction for dpll_ck.

Signed-off-by: Paul Walmsley <paul@pwsan.com>

---
 arch/arm/mach-omap2/clock.c |   11 +++++++++--
 arch/arm/mach-omap2/clock.h |    3 ++-
 2 files changed, 11 insertions(+), 3 deletions(-)

Index: linux-omap/arch/arm/mach-omap2/clock.c
Index: linux-omap/arch/arm/mach-omap2/clock.c
===================================================================
--- linux-omap.orig/arch/arm/mach-omap2/clock.c
+++ linux-omap/arch/arm/mach-omap2/clock.c
@@ -218,7 +218,7 @@ static int _omap2_clk_enable(struct clk 
 	if (unlikely(clk->enable_reg == 0)) {
 		printk(KERN_ERR "clock.c: Enable for %s without enable code\n",
 		       clk->name);
-		return 0;
+		return -EINVAL;
 	}
 
 	if (clk->enable_reg == OMAP_CM_REGADDR(PLL_MOD, CM_CLKEN)) {
@@ -259,8 +259,15 @@ static void _omap2_clk_disable(struct cl
 		return;
 	}
 
-	if (clk->enable_reg == 0)
+	if (clk->enable_reg == 0) {
+		/*
+		 * 'Independent' here refers to a clock which is not
+		 * controlled by its parent.
+		 */
+		printk(KERN_ERR "clock: clk_disable called on independent "
+		       "clock %s which has no enable_reg\n", clk->name);
 		return;
+	}
 
 	if (clk->enable_reg == OMAP_CM_REGADDR(PLL_MOD, CM_CLKEN)) {
 		omap2_clk_fixed_disable(clk);
Index: linux-omap/arch/arm/mach-omap2/clock.h
===================================================================
--- linux-omap.orig/arch/arm/mach-omap2/clock.h
+++ linux-omap/arch/arm/mach-omap2/clock.h
@@ -630,7 +630,8 @@ static struct clk dpll_ck = {
 	.name		= "dpll_ck",
 	.parent		= &sys_ck,		/* Can be func_32k also */
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
-				RATE_PROPAGATES | RATE_CKCTL | CM_PLL_SEL1,
+				RATE_PROPAGATES | RATE_CKCTL | CM_PLL_SEL1 |
+				ALWAYS_ENABLED,
 	.recalc		= &omap2_clksel_recalc,
 };
 

-- 
