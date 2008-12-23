From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 22/22] OMAP3 SmartReflex: get rid of custom clocks
Date: Mon, 22 Dec 2008 23:38:47 -0700
Message-ID: <20081223063846.8542.25070.stgit@localhost.localdomain>
References: <20081223063709.8542.82882.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:52911 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752744AbYLWGjv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 23 Dec 2008 01:39:51 -0500
In-Reply-To: <20081223063709.8542.82882.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Paul Walmsley <paul@pwsan.com>, Kalle Jokiniemi <ext-kalle.jokiniemi@nokia.com>

smartreflex.c defines some custom clocks that don't have clockdomains
associated with them, which is now disallowed.  The custom clocks are
not actually needed, so remove them.  This patch should not cause any
functional change.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Kalle Jokiniemi <ext-kalle.jokiniemi@nokia.com>
---
 arch/arm/mach-omap2/smartreflex.c |   89 ++++++++-----------------------------
 1 files changed, 19 insertions(+), 70 deletions(-)

diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/smartreflex.c
index 9fa033d..f26a9a1 100644
--- a/arch/arm/mach-omap2/smartreflex.c
+++ b/arch/arm/mach-omap2/smartreflex.c
@@ -53,13 +53,6 @@ struct omap_sr {
 	void __iomem	*vpbase_addr;
 };
 
-/* Custom clocks to enable SR specific enable/disable functions. */
-struct sr_custom_clk {
-	struct clk	clk;  /* meta-clock with custom enable/disable calls */
-	struct clk	*fck; /* actual functional clock */
-	struct omap_sr	*sr;
-};
-
 #define SR_REGADDR(offs)	(sr->srbase_addr + offset)
 
 static inline void sr_write_reg(struct omap_sr *sr, unsigned offset, u32 value)
@@ -84,38 +77,28 @@ static inline u32 sr_read_reg(struct omap_sr *sr, unsigned offset)
 	return __raw_readl(SR_REGADDR(offset));
 }
 
-/* Custom clock handling functions */
-static int sr_clk_enable(struct clk *clk)
+static int sr_clk_enable(struct omap_sr *sr)
 {
-	struct sr_custom_clk *sr_clk = container_of(clk, struct sr_custom_clk,
-									clk);
-
-	if (clk_enable(sr_clk->fck) != 0) {
-		printk(KERN_ERR "Could not enable %s\n", sr_clk->fck->name);
-		goto clk_enable_err;
+	if (clk_enable(sr->clk) != 0) {
+		printk(KERN_ERR "Could not enable %s\n", sr->clk->name);
+		return -1;
 	}
 
 	/* set fclk- active , iclk- idle */
-	sr_modify_reg(sr_clk->sr, ERRCONFIG, SR_CLKACTIVITY_MASK,
-						SR_CLKACTIVITY_IOFF_FON);
+	sr_modify_reg(sr, ERRCONFIG, SR_CLKACTIVITY_MASK,
+		      SR_CLKACTIVITY_IOFF_FON);
 
 	return 0;
-
-clk_enable_err:
-	return -1;
 }
 
-static void sr_clk_disable(struct clk *clk)
+static void sr_clk_disable(struct omap_sr *sr)
 {
-	struct sr_custom_clk *sr_clk = container_of(clk, struct sr_custom_clk,
-									clk);
-
 	/* set fclk, iclk- idle */
-	sr_modify_reg(sr_clk->sr, ERRCONFIG, SR_CLKACTIVITY_MASK,
-						SR_CLKACTIVITY_IOFF_FOFF);
+	sr_modify_reg(sr, ERRCONFIG, SR_CLKACTIVITY_MASK,
+		      SR_CLKACTIVITY_IOFF_FOFF);
 
-	clk_disable(sr_clk->fck);
-	sr_clk->sr->is_sr_reset = 1;
+	clk_disable(sr->clk);
+	sr->is_sr_reset = 1;
 }
 
 static struct omap_sr sr1 = {
@@ -134,24 +117,6 @@ static struct omap_sr sr2 = {
 	.srbase_addr		= OMAP2_IO_ADDRESS(OMAP34XX_SR2_BASE),
 };
 
-static struct sr_custom_clk sr1_custom_clk = {
-	.clk = {
-			.name		= "sr1_custom_clk",
-			.enable		= sr_clk_enable,
-			.disable	= sr_clk_disable,
-	},
-	.sr	= &sr1,
-};
-
-static struct sr_custom_clk sr2_custom_clk = {
-	.clk = {
-			.name		= "sr2_custom_clk",
-			.enable		= sr_clk_enable,
-			.disable	= sr_clk_disable,
-	},
-	.sr	= &sr2,
-};
-
 static void cal_reciprocal(u32 sensor, u32 *sengain, u32 *rnsen)
 {
 	u32 gn, rn, mul;
@@ -181,20 +146,6 @@ static u32 cal_test_nvalue(u32 sennval, u32 senpval)
 		(rnsenn << NVALUERECIPROCAL_RNSENN_SHIFT));
 }
 
-static void sr_clk_init(struct sr_custom_clk *sr_clk)
-{
-	if (sr_clk->sr->srid == SR1) {
-		sr_clk->fck = clk_get(NULL, "sr1_fck");
-		if (IS_ERR(sr_clk->fck))
-			printk(KERN_ERR "Could not get sr1_fck\n");
-	} else if (sr_clk->sr->srid == SR2) {
-		sr_clk->fck = clk_get(NULL, "sr2_fck");
-		if (IS_ERR(sr_clk->fck))
-			printk(KERN_ERR "Could not get sr2_fck\n");
-	}
-	clk_register(&sr_clk->clk);
-}
-
 static void sr_set_clk_length(struct omap_sr *sr)
 {
 	struct clk *osc_sys_ck;
@@ -511,7 +462,7 @@ void sr_start_vddautocomap(int srid, u32 target_opp_no)
 		sr = &sr2;
 
 	if (sr->is_sr_reset == 1) {
-		clk_enable(sr->clk);
+		sr_clk_enable(sr);
 		sr_configure(sr);
 	}
 
@@ -524,7 +475,7 @@ void sr_start_vddautocomap(int srid, u32 target_opp_no)
 		printk(KERN_WARNING "SR%d: VDD autocomp not activated\n", srid);
 		sr->is_autocomp_active = 0;
 		if (sr->is_sr_reset == 1)
-			clk_disable(sr->clk);
+			sr_clk_disable(sr);
 	}
 }
 EXPORT_SYMBOL(sr_start_vddautocomap);
@@ -540,7 +491,7 @@ int sr_stop_vddautocomap(int srid)
 
 	if (sr->is_autocomp_active == 1) {
 		sr_disable(sr);
-		clk_disable(sr->clk);
+		sr_clk_disable(sr);
 		sr->is_autocomp_active = 0;
 		return SR_TRUE;
 	} else {
@@ -565,7 +516,7 @@ void enable_smartreflex(int srid)
 	if (sr->is_autocomp_active == 1) {
 		if (sr->is_sr_reset == 1) {
 			/* Enable SR clks */
-			clk_enable(sr->clk);
+			sr_clk_enable(sr);
 
 			if (srid == SR1)
 				target_opp_no = get_opp_no(current_vdd1_opp);
@@ -575,7 +526,7 @@ void enable_smartreflex(int srid)
 			sr_configure(sr);
 
 			if (!sr_enable(sr, target_opp_no))
-				clk_disable(sr->clk);
+				sr_clk_disable(sr);
 		}
 	}
 }
@@ -598,7 +549,7 @@ void disable_smartreflex(int srid)
 							~SRCONFIG_SRENABLE);
 
 			/* Disable SR clk */
-			clk_disable(sr->clk);
+			sr_clk_disable(sr);
 			if (sr->srid == SR1) {
 				/* Disable VP1 */
 				prm_clear_mod_reg_bits(PRM_VP1_CONFIG_VPENABLE,
@@ -774,10 +725,8 @@ static int __init omap3_sr_init(void)
 		current_vdd2_opp = PRCM_VDD1_OPP1;
 	}
 	if (cpu_is_omap34xx()) {
-		sr_clk_init(&sr1_custom_clk);
-		sr_clk_init(&sr2_custom_clk);
-		sr1.clk = clk_get(NULL, "sr1_custom_clk");
-		sr2.clk = clk_get(NULL, "sr2_custom_clk");
+		sr1.clk = clk_get(NULL, "sr1_fck");
+		sr2.clk = clk_get(NULL, "sr2_fck");
 	}
 	sr_set_clk_length(&sr1);
 	sr_set_clk_length(&sr2);


