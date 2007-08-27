From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 05/27] omap2 clock: rename, add comment to omap2_mpu_recalc()
Date: Mon, 27 Aug 2007 02:39:01 -0600
Message-ID: <20070827084122.544259482@pwsan.com>
References: <20070827083856.549249288@pwsan.com>
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-Disposition: inline; filename=clarify_omap2_mpu_recalc.patch
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

omap2_mpu_recalc() actually just looks up what the MPU speed 'should'
currently be from the current virt_prcm_set rate set, rather than reporting
the actual hardware settings.  Clarify this by renaming it to 
omap2_table_mpu_recalc() and adding some comments.

Signed-off-by: Paul Walmsley <paul@pwsan.com>


---
 arch/arm/mach-omap2/clock.c |    9 +++++++--
 arch/arm/mach-omap2/clock.h |    4 ++--
 2 files changed, 9 insertions(+), 4 deletions(-)

Index: linux-omap/arch/arm/mach-omap2/clock.c
===================================================================
--- linux-omap.orig/arch/arm/mach-omap2/clock.c	2007-08-27 00:52:05.000000000 -0600
+++ linux-omap/arch/arm/mach-omap2/clock.c	2007-08-27 00:52:19.000000000 -0600
@@ -592,8 +592,13 @@
 	return(ret);
 }
 
-/* Just return the MPU speed */
-static void omap2_mpu_recalc(struct clk * clk)
+/**
+ * omap2_table_mpu_recalc - just return the MPU speed
+ * @clk: virt_prcm_set struct clk
+ *
+ * Set virt_prcm_set's rate to the mpu_speed field of the current PRCM set.
+ */
+static void omap2_table_mpu_recalc(struct clk *clk)
 {
 	clk->rate = curr_prcm_set->mpu_speed;
 }
Index: linux-omap/arch/arm/mach-omap2/clock.h
===================================================================
--- linux-omap.orig/arch/arm/mach-omap2/clock.h	2007-08-27 00:52:05.000000000 -0600
+++ linux-omap/arch/arm/mach-omap2/clock.h	2007-08-27 00:52:07.000000000 -0600
@@ -24,7 +24,7 @@
 
 static void omap2_sys_clk_recalc(struct clk * clk);
 static void omap2_clksel_recalc(struct clk * clk);
-static void omap2_mpu_recalc(struct clk * clk);
+static void omap2_table_mpu_recalc(struct clk *clk);
 static int omap2_select_table_rate(struct clk * clk, unsigned long rate);
 static long omap2_round_to_table_rate(struct clk * clk, unsigned long rate);
 static void omap2_clk_disable(struct clk *clk);
@@ -1982,7 +1982,7 @@
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
 				VIRTUAL_CLOCK | ALWAYS_ENABLED | DELAYED_APP,
 	.parent		= &mpu_ck,	/* Indexed by mpu speed, no parent */
-	.recalc		= &omap2_mpu_recalc,	/* sets are keyed on mpu rate */
+	.recalc		= &omap2_table_mpu_recalc,	/* sets are keyed on mpu rate */
 	.set_rate	= &omap2_select_table_rate,
 	.round_rate	= &omap2_round_to_table_rate,
 };

-- 
