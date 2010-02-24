From: Thara Gopinath <thara@ti.com>
Subject: [PATCH 05/16] OMAP3: PM: Export get_vdd1_opp and get_vdd2_opp from shared resource framework
Date: Wed, 24 Feb 2010 14:59:06 +0530
Message-ID: <1267003757-22456-6-git-send-email-thara@ti.com>
References: <1267003757-22456-1-git-send-email-thara@ti.com>
 <1267003757-22456-2-git-send-email-thara@ti.com>
 <1267003757-22456-3-git-send-email-thara@ti.com>
 <1267003757-22456-4-git-send-email-thara@ti.com>
 <1267003757-22456-5-git-send-email-thara@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:59780 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756125Ab0BXJ3b (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 24 Feb 2010 04:29:31 -0500
In-Reply-To: <1267003757-22456-5-git-send-email-thara@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@deeprootsystems.com, paul@pwsan.com, nm@ti.com, b-cousson@ti.com, vishwanath.bs@ti.com, sawant@ti.com, Thara Gopinath <thara@ti.com>

get_vdd1_opp and get_vdd2_opp APIs will be needed by voltage.c
and smartreflex-class3.c which will get added in the later patches
in this patch series. So it is very clumsy to declare these API's
in each of these files and employ the mechanism of getting the opp
from mpu and l3 clocks.
This patch removes get_vdd1_opp and get_vdd2_opp from smartreflex.c.
To keep the implementaion clean these functions are exported out
in resource34xx.c.

Signed-off-by: Thara Gopinath <thara@ti.com>
---
 arch/arm/mach-omap2/resource34xx.c |   10 +++++
 arch/arm/mach-omap2/smartreflex.c  |   66 ------------------------------------
 arch/arm/mach-omap2/smartreflex.h  |    2 +
 3 files changed, 12 insertions(+), 66 deletions(-)

diff --git a/arch/arm/mach-omap2/resource34xx.c b/arch/arm/mach-omap2/resource34xx.c
index c6cce8b..db5f40e 100644
--- a/arch/arm/mach-omap2/resource34xx.c
+++ b/arch/arm/mach-omap2/resource34xx.c
@@ -560,3 +560,13 @@ int validate_freq(struct shared_resource *resp, u32 target_level)
 		return freq_to_opp(&x, OPP_DSP, target_level);
 	return 0;
 }
+
+int get_vdd1_opp(void)
+{
+	return curr_vdd1_opp;
+}
+
+int get_vdd2_opp(void)
+{
+	return curr_vdd2_opp;
+}
diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/smartreflex.c
index db2e9bf..c00925d 100644
--- a/arch/arm/mach-omap2/smartreflex.c
+++ b/arch/arm/mach-omap2/smartreflex.c
@@ -46,7 +46,6 @@ struct omap_sr {
 	int			srid;
 	int			is_sr_reset;
 	int			is_autocomp_active;
-	struct clk		*vdd_opp_clk;
 	u32			clk_length;
 	void __iomem		*srbase_addr;
 	unsigned int		irq;
@@ -115,65 +114,6 @@ static void sr_clk_disable(struct omap_sr *sr)
 	sr->is_sr_reset = 1;
 }
 
-static u8 get_vdd1_opp(void)
-{
-	struct omap_opp *opp;
-	unsigned long freq;
-	struct omap_sr *sr_info = _sr_lookup(SR1);
-
-	if (!sr_info) {
-		pr_warning("omap_sr struct corresponding to SR1 not found\n");
-		return 0;
-	}
-
-	if (sr_info->vdd_opp_clk == NULL || IS_ERR(sr_info->vdd_opp_clk))
-		return 0;
-
-	freq = sr_info->vdd_opp_clk->rate;
-	opp = opp_find_freq_ceil(OPP_MPU, &freq);
-	if (IS_ERR(opp))
-		return 0;
-	/*
-	 * Use higher freq voltage even if an exact match is not available
-	 * we are probably masking a clock framework bug, so warn
-	 */
-	if (unlikely(freq != sr_info->vdd_opp_clk->rate))
-		pr_warning("%s: Available freq %ld != dpll freq %ld.\n",
-			   __func__, freq, sr_info->vdd_opp_clk->rate);
-
-	return opp_get_opp_id(opp);
-}
-
-static u8 get_vdd2_opp(void)
-{
-	struct omap_opp *opp;
-	unsigned long freq;
-	struct omap_sr *sr_info = _sr_lookup(SR2);
-
-	if (!sr_info) {
-		pr_warning("omap_sr struct corresponding to SR2 not found\n");
-		return 0;
-	}
-
-	if (sr_info->vdd_opp_clk == NULL || IS_ERR(sr_info->vdd_opp_clk))
-		return 0;
-
-	freq = sr_info->vdd_opp_clk->rate;
-	opp = opp_find_freq_ceil(OPP_L3, &freq);
-	if (IS_ERR(opp))
-		return 0;
-
-	/*
-	 * Use higher freq voltage even if an exact match is not available
-	 * we are probably masking a clock framework bug, so warn
-	 */
-	if (unlikely(freq != sr_info->vdd_opp_clk->rate))
-		pr_warning("%s: Available freq %ld != dpll freq %ld.\n",
-			   __func__, freq, sr_info->vdd_opp_clk->rate);
-	return opp_get_opp_id(opp);
-}
-
-
 static void sr_set_clk_length(struct omap_sr *sr)
 {
 	struct clk *sys_ck;
@@ -858,12 +798,6 @@ static int __devinit omap_smartreflex_probe(struct platform_device *pdev)
 		sr_info->irq = odev->hwmods[0]->mpu_irqs[0].irq;
 	sr_set_clk_length(sr_info);
 
-	if (sr_info->srid == SR1) {
-		sr_info->vdd_opp_clk = clk_get(NULL, "dpll1_ck");
-	} else {
-		sr_info->vdd_opp_clk = clk_get(NULL, "l3_ick");
-	}
-
 	/* Create the debug fs enteries */
 	sprintf(name, "sr%d_autocomp", sr_info->srid);
 	(void) debugfs_create_file(name, S_IRUGO | S_IWUGO, pm_dbg_main_dir,
diff --git a/arch/arm/mach-omap2/smartreflex.h b/arch/arm/mach-omap2/smartreflex.h
index 20fc128..572cdca 100644
--- a/arch/arm/mach-omap2/smartreflex.h
+++ b/arch/arm/mach-omap2/smartreflex.h
@@ -17,6 +17,8 @@
 #include <linux/platform_device.h>
 
 extern struct dentry *pm_dbg_main_dir;
+extern int get_vdd1_opp(void);
+extern int get_vdd2_opp(void);
 
 #define PHY_TO_OFF_PM_MASTER(p)		(p - 0x36)
 #define PHY_TO_OFF_PM_RECIEVER(p)	(p - 0x5b)
-- 
1.7.0.rc1.33.g07cf0f

