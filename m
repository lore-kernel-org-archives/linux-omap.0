From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 1/2] 3430 clock: revise SmartReflex clocks
Date: Mon, 05 Nov 2007 01:24:07 -0700
Message-ID: <20071105082528.400123896@pwsan.com>
References: <20071105082406.387923286@pwsan.com>
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline; filename=add_sr_clocks.patch
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

The two SmartReflex voltage controllers on OMAP3430 have one
functional clock each.  These clocks appear to be independent of each 
other.  Encode them appropriately, replacing the previous 'sr_alwon_fck'
clock.

Signed-off-by: Paul Walmsley <paul@pwsan.com>

---
 arch/arm/mach-omap2/clock34xx.h |   23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

Index: linux-omap/arch/arm/mach-omap2/clock34xx.h
===================================================================
--- linux-omap.orig/arch/arm/mach-omap2/clock34xx.h	2007-10-24 23:47:20.000000000 -0600
+++ linux-omap/arch/arm/mach-omap2/clock34xx.h	2007-10-24 23:47:22.000000000 -0600
@@ -2003,11 +2003,23 @@
 
 /* SR clocks */
 
-/* REVISIT: dependent on en_sr1 && en_sr2 - use custom enable/disable? */
-static struct clk sr_alwon_fck = {
-	.name		= "sr_alwon_fck",
+/* SmartReflex fclk (VDD1) */
+static struct clk sr1_fck = {
+	.name		= "sr1_fck",
 	.parent		= &sys_ck,
-	.flags		= CLOCK_IN_OMAP343X,
+	.enable_reg	= OMAP_CM_REGADDR(WKUP_MOD, CM_FCLKEN),
+	.enable_bit	= OMAP3430_EN_SR1_SHIFT,
+	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES,
+	.recalc		= &followparent_recalc,
+};
+
+/* SmartReflex fclk (VDD2) */
+static struct clk sr2_fck = {
+	.name		= "sr2_fck",
+	.parent		= &sys_ck,
+	.enable_reg	= OMAP_CM_REGADDR(WKUP_MOD, CM_FCLKEN),
+	.enable_bit	= OMAP3430_EN_SR2_SHIFT,
+	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES,
 	.recalc		= &followparent_recalc,
 };
 
@@ -2204,7 +2216,8 @@
 	&mcbsp2_fck,
 	&mcbsp3_fck,
 	&mcbsp4_fck,
-	&sr_alwon_fck,
+	&sr1_fck,
+	&sr2_fck,
 	&sr_l4_ick,
 	&secure_32k_fck,
 	&gpt12_fck,

-- 
