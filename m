From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 26/27] omap2 clock: generalize clock enable upon framework
	initialization
Date: Mon, 27 Aug 2007 02:39:22 -0600
Message-ID: <20070827084124.659527206@pwsan.com>
References: <20070827083856.549249288@pwsan.com>
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline; filename=add_startup_enable.patch
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

The OMAP2 clock framework enables a few clocks by hand upon initialization.
OMAP3430 will have a different set of clocks to enable upon init.  So, 
generalize this code by adding a new clock flag, ENABLE_ON_INIT, to mark
clocks that should be enabled on init; and add a new framework-wide function, 
clk_enable_init_clocks(), that can be called from generalized init code.

Signed-off-by: Paul Walmsley <paul@pwsan.com>

---
 arch/arm/mach-omap2/clock.c       |   11 +----------
 arch/arm/mach-omap2/clock.h       |   10 +++++-----
 arch/arm/plat-omap/clock.c        |   11 +++++++++++
 include/asm-arm/arch-omap/clock.h |    4 +++-
 4 files changed, 20 insertions(+), 16 deletions(-)

Index: linux-omap/arch/arm/mach-omap2/clock.c
===================================================================
--- linux-omap.orig/arch/arm/mach-omap2/clock.c	2007-08-27 02:20:23.000000000 -0600
+++ linux-omap/arch/arm/mach-omap2/clock.c	2007-08-27 02:20:24.000000000 -0600
@@ -1183,16 +1183,7 @@
 	 * Only enable those clocks we will need, let the drivers
 	 * enable other clocks as necessary
 	 */
-	clk_enable(&sync_32k_ick);
-	clk_enable(&omapctrl_ick);
-
-	/* Force the APLLs always active. The clocks are idled
-	 * automatically by hardware. */
-	clk_enable(&apll96_ck);
-	clk_enable(&apll54_ck);
-
-	if (cpu_is_omap2430())
-		clk_enable(&sdrc_ick);
+	clk_enable_init_clocks();
 
 	/* Avoid sleeping sleeping during omap2_clk_prepare_for_reboot() */
 	vclk = clk_get(NULL, "virt_prcm_set");
Index: linux-omap/arch/arm/mach-omap2/clock.h
===================================================================
--- linux-omap.orig/arch/arm/mach-omap2/clock.h	2007-08-27 02:20:23.000000000 -0600
+++ linux-omap/arch/arm/mach-omap2/clock.h	2007-08-27 02:20:24.000000000 -0600
@@ -656,7 +656,7 @@
 	.parent		= &sys_ck,
 	.rate		= 96000000,
 	.flags		= CLOCK_IN_OMAP242X |CLOCK_IN_OMAP243X |
-				RATE_FIXED | RATE_PROPAGATES,
+				RATE_FIXED | RATE_PROPAGATES | ENABLE_ON_INIT,
 	.enable_reg	= OMAP_CM_REGADDR(PLL_MOD, CM_CLKEN),
 	.enable_bit	= OMAP24XX_EN_96M_PLL_SHIFT,
 	.enable		= &omap2_clk_fixed_enable,
@@ -669,7 +669,7 @@
 	.parent		= &sys_ck,
 	.rate		= 54000000,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
-				RATE_FIXED | RATE_PROPAGATES,
+				RATE_FIXED | RATE_PROPAGATES | ENABLE_ON_INIT,
 	.enable_reg	= OMAP_CM_REGADDR(PLL_MOD, CM_CLKEN),
 	.enable_bit	= OMAP24XX_EN_54M_PLL_SHIFT,
 	.enable		= &omap2_clk_fixed_enable,
@@ -2034,7 +2034,7 @@
 static struct clk sync_32k_ick = {
 	.name		= "sync_32k_ick",
 	.parent		= &l4_ck,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
+	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X | ENABLE_ON_INIT,
 	.enable_reg	= OMAP_CM_REGADDR(WKUP_MOD, CM_ICLKEN),
 	.enable_bit	= OMAP24XX_EN_32KSYNC_SHIFT,
 	.recalc		= &followparent_recalc,
@@ -2050,7 +2050,7 @@
 static struct clk omapctrl_ick = {
 	.name		= "omapctrl_ick",
 	.parent		= &l4_ck,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
+	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X | ENABLE_ON_INIT,
 	.enable_reg	= OMAP_CM_REGADDR(WKUP_MOD, CM_ICLKEN),
 	.enable_bit	= OMAP24XX_EN_OMAPCTRL_SHIFT,
 	.recalc		= &followparent_recalc,
@@ -2329,7 +2329,7 @@
 static struct clk sdrc_ick = {
 	.name		= "sdrc_ick",
 	.parent		= &l4_ck,
-	.flags		= CLOCK_IN_OMAP243X,
+	.flags		= CLOCK_IN_OMAP243X | ENABLE_ON_INIT,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, OMAP2430_CM_ICLKEN3),
 	.enable_bit	= OMAP2430_EN_SDRC_SHIFT,
 	.recalc		= &followparent_recalc,
Index: linux-omap/arch/arm/plat-omap/clock.c
===================================================================
--- linux-omap.orig/arch/arm/plat-omap/clock.c	2007-08-27 02:19:26.000000000 -0600
+++ linux-omap/arch/arm/plat-omap/clock.c	2007-08-27 02:20:24.000000000 -0600
@@ -383,6 +383,17 @@
 }
 EXPORT_SYMBOL(clk_allow_idle);
 
+void clk_enable_init_clocks(void)
+{
+	struct clk *clkp;
+
+	list_for_each_entry(clkp, &clocks, node) {
+		if (clkp->flags & ENABLE_ON_INIT)
+			clk_enable(clkp);
+	}
+}
+EXPORT_SYMBOL(clk_enable_init_clocks);
+
 /*-------------------------------------------------------------------------*/
 
 #ifdef CONFIG_OMAP_RESET_CLOCKS
Index: linux-omap/include/asm-arm/arch-omap/clock.h
===================================================================
--- linux-omap.orig/include/asm-arm/arch-omap/clock.h	2007-08-27 02:20:23.000000000 -0600
+++ linux-omap/include/asm-arm/arch-omap/clock.h	2007-08-27 02:20:24.000000000 -0600
@@ -91,6 +91,7 @@
 extern void clk_allow_idle(struct clk *clk);
 extern void clk_deny_idle(struct clk *clk);
 extern int clk_get_usecount(struct clk *clk);
+extern void clk_enable_init_clocks(void);
 
 /* Clock flags */
 #define RATE_CKCTL		(1 << 0)	/* Main fixed ratio clocks */
@@ -104,7 +105,8 @@
 #define CLOCK_NO_IDLE_PARENT	(1 << 8)
 #define DELAYED_APP		(1 << 9)	/* Delay application of clock */
 #define CONFIG_PARTICIPANT	(1 << 10)	/* Fundamental clock */
-/* bits 11-20 are currently free */
+#define ENABLE_ON_INIT		(1 << 11)	/* Enable upon framework init */
+/* bits 12-20 are currently free */
 #define CLOCK_IN_OMAP310	(1 << 21)
 #define CLOCK_IN_OMAP730	(1 << 22)
 #define CLOCK_IN_OMAP1510	(1 << 23)

-- 
