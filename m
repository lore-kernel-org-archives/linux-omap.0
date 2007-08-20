From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 02/28] omap2 clock: generalize initial clock rate setup:
	recalculate_root_clocks()
Date: Mon, 20 Aug 2007 03:53:49 -0600
Message-ID: <20070820095530.147074658@pwsan.com>
References: <20070820095347.933473149@pwsan.com>
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline; filename=add_propagate_roots.patch
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

Add a new clock framework function, recalculate_root_clocks(), that 
recalculates all root clocks (i.e., clocks with no parent clock).  
Call this function in omap2_clk_arch_init(), rather than manually
propagating specific clocks.  Add propagate_rate() recalcs to func_32k_ck
and osc_ck.

Signed-off-by: Paul Walmsley <paul@pwsan.com>

---
 arch/arm/mach-omap2/clock.c       |    6 ++----
 arch/arm/mach-omap2/clock.h       |    4 +++-
 arch/arm/plat-omap/clock.c        |   17 +++++++++++++++++
 include/asm-arm/arch-omap/clock.h |    1 +
 4 files changed, 23 insertions(+), 5 deletions(-)

Index: linux-omap/arch/arm/plat-omap/clock.c
Index: linux-omap/arch/arm/plat-omap/clock.c
===================================================================
--- linux-omap.orig/arch/arm/plat-omap/clock.c
+++ linux-omap/arch/arm/plat-omap/clock.c
@@ -312,6 +312,23 @@ void propagate_rate(struct clk * tclk)
 	}
 }
 
+/**
+ * recalculate_root_clocks - recalculate and propagate all root clocks
+ *
+ * Recalculates all root clocks (clocks with no parent), which if the
+ * clock's .recalc is set correctly, should also propagate their rates.
+ * Called at init.
+ */
+void recalculate_root_clocks(void)
+{
+	struct clk *clkp;
+
+	list_for_each_entry(clkp, &clocks, node) {
+		if (unlikely(!clkp->parent) && likely((u32)clkp->recalc))
+			clkp->recalc(clkp);
+	}
+}
+
 int clk_register(struct clk *clk)
 {
 	if (clk == NULL || IS_ERR(clk))
Index: linux-omap/include/asm-arm/arch-omap/clock.h
===================================================================
--- linux-omap.orig/include/asm-arm/arch-omap/clock.h
+++ linux-omap/include/asm-arm/arch-omap/clock.h
@@ -57,6 +57,7 @@ extern int clk_init(struct clk_functions
 extern int clk_register(struct clk *clk);
 extern void clk_unregister(struct clk *clk);
 extern void propagate_rate(struct clk *clk);
+extern void recalculate_root_clocks(void);
 extern void followparent_recalc(struct clk * clk);
 extern void clk_allow_idle(struct clk *clk);
 extern void clk_deny_idle(struct clk *clk);
Index: linux-omap/arch/arm/mach-omap2/clock.c
===================================================================
--- linux-omap.orig/arch/arm/mach-omap2/clock.c
+++ linux-omap/arch/arm/mach-omap2/clock.c
@@ -1179,8 +1179,7 @@ static int __init omap2_clk_arch_init(vo
 	if (omap2_select_table_rate(&virt_prcm_set, mpurate))
 		printk(KERN_ERR "Could not find matching MPU rate\n");
 
-	propagate_rate(&osc_ck);		/* update main root fast */
-	propagate_rate(&func_32k_ck);		/* update main root slow */
+	recalculate_root_clocks();
 
 	printk(KERN_INFO "Switched to new clocking rate (Crystal/DPLL/MPU): "
 	       "%ld.%01ld/%ld/%ld MHz\n",
@@ -1231,8 +1230,7 @@ int __init omap2_clk_init(void)
 	}
 	curr_prcm_set = prcm;
 
-	propagate_rate(&osc_ck);		/* update main root fast */
-	propagate_rate(&func_32k_ck);		/* update main root slow */
+	recalculate_root_clocks();
 
 	printk(KERN_INFO "Clocking rate (Crystal/DPLL/MPU): "
 	       "%ld.%01ld/%ld/%ld MHz\n",
Index: linux-omap/arch/arm/mach-omap2/clock.h
===================================================================
--- linux-omap.orig/arch/arm/mach-omap2/clock.h
+++ linux-omap/arch/arm/mach-omap2/clock.h
@@ -592,7 +592,8 @@ static struct clk func_32k_ck = {
 	.name		= "func_32k_ck",
 	.rate		= 32000,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
-				RATE_FIXED | ALWAYS_ENABLED,
+				RATE_FIXED | ALWAYS_ENABLED | RATE_PROPAGATES,
+	.recalc		= &propagate_rate,
 };
 
 /* Typical 12/13MHz in standalone mode, will be 26Mhz in chassis mode */
@@ -601,6 +602,7 @@ static struct clk osc_ck = {		/* (*12, *
 	.rate		= 26000000,		/* fixed up in clock init */
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
 				RATE_FIXED | RATE_PROPAGATES,
+	.recalc		= &propagate_rate,
 };
 
 /* With out modem likely 12MHz, with modem likely 13MHz */

-- 
