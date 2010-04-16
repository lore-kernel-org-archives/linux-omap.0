From: Thara Gopinath <thara@ti.com>
Subject: [PATCHv3 02/22] OMAP3: PM: Create list to keep track of various smartreflex instances.
Date: Fri, 16 Apr 2010 14:32:57 +0530
Message-ID: <1271408597-3066-3-git-send-email-thara@ti.com>
References: <1271408597-3066-1-git-send-email-thara@ti.com>
 <1271408597-3066-2-git-send-email-thara@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:51442 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756380Ab0DPJDa (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 16 Apr 2010 05:03:30 -0400
In-Reply-To: <1271408597-3066-2-git-send-email-thara@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@deeprootsystems.com, paul@pwsan.com, b-cousson@ti.com, vishwanath.bs@ti.com, sawant@ti.com, Thara Gopinath <thara@ti.com>

This patch removes the pointer sr1, sr2 in smartreflex.c and
instead creatse a list for keeping track of multiple smartreflex
instances.. This makes it scalable for next gen OMAPs where there
are more than two smartreflex modules.

Signed-off-by: Thara Gopinath <thara@ti.com>
---
 arch/arm/mach-omap2/smartreflex.c |  114 ++++++++++++++++++++++++------------
 1 files changed, 76 insertions(+), 38 deletions(-)

diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/smartreflex.c
index 1c5ec37..dc8d6e1 100644
--- a/arch/arm/mach-omap2/smartreflex.c
+++ b/arch/arm/mach-omap2/smartreflex.c
@@ -26,6 +26,7 @@
 #include <linux/kobject.h>
 #include <linux/i2c/twl.h>
 #include <linux/io.h>
+#include <linux/list.h>
 
 #include <plat/omap34xx.h>
 #include <plat/control.h>
@@ -51,9 +52,12 @@ struct omap_sr {
 	u32		opp5_nvalue;
 	u32		senp_mod, senn_mod;
 	void __iomem	*srbase_addr;
-	void __iomem	*vpbase_addr;
+	struct list_head	node;
 };
 
+/* sr_list contains all the instances of smartreflex module */
+static LIST_HEAD(sr_list);
+
 #define SR_REGADDR(offs)	(sr->srbase_addr + offset)
 
 static inline void sr_write_reg(struct omap_sr *sr, unsigned offset, u32 value)
@@ -78,6 +82,20 @@ static inline u32 sr_read_reg(struct omap_sr *sr, unsigned offset)
 	return __raw_readl(SR_REGADDR(offset));
 }
 
+static struct omap_sr *_sr_lookup(int srid)
+{
+	struct omap_sr *sr_info, *temp_sr_info;
+
+	sr_info = NULL;
+	list_for_each_entry(temp_sr_info, &sr_list, node) {
+		if (srid == temp_sr_info->srid) {
+			sr_info = temp_sr_info;
+			break;
+		}
+	}
+	return sr_info;
+}
+
 static int sr_clk_enable(struct omap_sr *sr)
 {
 	if (clk_enable(sr->clk) != 0) {
@@ -151,11 +169,17 @@ static u8 get_vdd1_opp(void)
 {
 	struct omap_opp *opp;
 	unsigned long freq;
+	struct omap_sr *sr_info = _sr_lookup(SR1);
 
-	if (sr1.vdd_opp_clk == NULL || IS_ERR(sr1.vdd_opp_clk))
+	if (!sr_info) {
+		pr_warning("omap_sr struct corresponding to SR1 not found\n");
+		return 0;
+	}
+
+	if (sr_info->vdd_opp_clk == NULL || IS_ERR(sr_info->vdd_opp_clk))
 		return 0;
 
-	freq = sr1.vdd_opp_clk->rate;
+	freq = sr_info->vdd_opp_clk->rate;
 	opp = opp_find_freq_ceil(OPP_MPU, &freq);
 	if (IS_ERR(opp))
 		return 0;
@@ -163,9 +187,9 @@ static u8 get_vdd1_opp(void)
 	 * Use higher freq voltage even if an exact match is not available
 	 * we are probably masking a clock framework bug, so warn
 	 */
-	if (unlikely(freq != sr1.vdd_opp_clk->rate))
+	if (unlikely(freq != sr_info->vdd_opp_clk->rate))
 		pr_warning("%s: Available freq %ld != dpll freq %ld.\n",
-			   __func__, freq, sr1.vdd_opp_clk->rate);
+			   __func__, freq, sr_info->vdd_opp_clk->rate);
 
 	return opp_get_opp_id(opp);
 }
@@ -174,11 +198,17 @@ static u8 get_vdd2_opp(void)
 {
 	struct omap_opp *opp;
 	unsigned long freq;
+	struct omap_sr *sr_info = _sr_lookup(SR2);
+
+	if (!sr_info) {
+		pr_warning("omap_sr struct corresponding to SR2 not found\n");
+		return 0;
+	}
 
-	if (sr2.vdd_opp_clk == NULL || IS_ERR(sr2.vdd_opp_clk))
+	if (sr_info->vdd_opp_clk == NULL || IS_ERR(sr_info->vdd_opp_clk))
 		return 0;
 
-	freq = sr2.vdd_opp_clk->rate;
+	freq = sr_info->vdd_opp_clk->rate;
 	opp = opp_find_freq_ceil(OPP_L3, &freq);
 	if (IS_ERR(opp))
 		return 0;
@@ -187,9 +217,9 @@ static u8 get_vdd2_opp(void)
 	 * Use higher freq voltage even if an exact match is not available
 	 * we are probably masking a clock framework bug, so warn
 	 */
-	if (unlikely(freq != sr2.vdd_opp_clk->rate))
+	if (unlikely(freq != sr_info->vdd_opp_clk->rate))
 		pr_warning("%s: Available freq %ld != dpll freq %ld.\n",
-			   __func__, freq, sr2.vdd_opp_clk->rate);
+			   __func__, freq, sr_info->vdd_opp_clk->rate);
 	return opp_get_opp_id(opp);
 }
 
@@ -694,14 +724,13 @@ static void sr_disable(struct omap_sr *sr)
 
 void sr_start_vddautocomap(int srid, u32 target_opp_no)
 {
-	struct omap_sr *sr = NULL;
+	struct omap_sr *sr = _sr_lookup(srid);
 
-	if (srid == SR1)
-		sr = &sr1;
-	else if (srid == SR2)
-		sr = &sr2;
-	else
+	if (!sr) {
+		pr_warning("omap_sr struct corresponding to SR%d not found\n",
+								srid);
 		return;
+	}
 
 	if (sr->is_sr_reset == 1) {
 		sr_clk_enable(sr);
@@ -719,14 +748,13 @@ EXPORT_SYMBOL(sr_start_vddautocomap);
 
 int sr_stop_vddautocomap(int srid)
 {
-	struct omap_sr *sr = NULL;
+	struct omap_sr *sr = _sr_lookup(srid);
 
-	if (srid == SR1)
-		sr = &sr1;
-	else if (srid == SR2)
-		sr = &sr2;
-	else
-		return -EINVAL;
+	if (!sr) {
+		pr_warning("omap_sr struct corresponding to SR%d not found\n",
+								srid);
+		return false;
+	}
 
 	if (sr->is_autocomp_active == 1) {
 		sr_disable(sr);
@@ -744,14 +772,13 @@ EXPORT_SYMBOL(sr_stop_vddautocomap);
 void enable_smartreflex(int srid)
 {
 	u32 target_opp_no = 0;
-	struct omap_sr *sr = NULL;
+	struct omap_sr *sr = _sr_lookup(srid);
 
-	if (srid == SR1)
-		sr = &sr1;
-	else if (srid == SR2)
-		sr = &sr2;
-	else
+	if (!sr) {
+		pr_warning("omap_sr struct corresponding to SR%d not found\n",
+								srid);
 		return;
+	}
 
 	if (sr->is_autocomp_active == 1) {
 		if (sr->is_sr_reset == 1) {
@@ -779,15 +806,13 @@ void enable_smartreflex(int srid)
 void disable_smartreflex(int srid)
 {
 	u32 i = 0;
+	struct omap_sr *sr = _sr_lookup(srid);
 
-	struct omap_sr *sr = NULL;
-
-	if (srid == SR1)
-		sr = &sr1;
-	else if (srid == SR2)
-		sr = &sr2;
-	else
+	if (!sr) {
+		pr_warning("omap_sr struct corresponding to SR%d not found\n",
+								srid);
 		return;
+	}
 
 	if (sr->is_autocomp_active == 1) {
 		if (sr->is_sr_reset == 0) {
@@ -920,7 +945,13 @@ int sr_voltagescale_vcbypass(u32 target_opp, u32 current_opp,
 static ssize_t omap_sr_vdd1_autocomp_show(struct kobject *kobj,
 					struct kobj_attribute *attr, char *buf)
 {
-	return sprintf(buf, "%d\n", sr1.is_autocomp_active);
+	struct omap_sr *sr_info = _sr_lookup(SR1);
+
+	if (!sr_info) {
+		pr_warning("omap_sr struct corresponding to SR1 not found\n");
+		return 0;
+	}
+	return sprintf(buf, "%d\n", sr_info->is_autocomp_active);
 }
 
 static ssize_t omap_sr_vdd1_autocomp_store(struct kobject *kobj,
@@ -960,7 +991,13 @@ static struct kobj_attribute sr_vdd1_autocomp = {
 static ssize_t omap_sr_vdd2_autocomp_show(struct kobject *kobj,
 					struct kobj_attribute *attr, char *buf)
 {
-	return sprintf(buf, "%d\n", sr2.is_autocomp_active);
+	struct omap_sr *sr_info = _sr_lookup(SR2);
+
+	if (!sr_info) {
+		pr_warning("omap_sr struct corresponding to SR2 not found\n");
+		return 0;
+	}
+	return sprintf(buf, "%d\n", sr_info->is_autocomp_active);
 }
 
 static ssize_t omap_sr_vdd2_autocomp_store(struct kobject *kobj,
@@ -1010,7 +1047,6 @@ static int __init omap3_sr_init(void)
 	RdReg |= DCDC_GLOBAL_CFG_ENABLE_SRFLX;
 	ret |= twl_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER, RdReg,
 				R_DCDC_GLOBAL_CFG);
-
 	if (cpu_is_omap34xx()) {
 		sr1.clk = clk_get(NULL, "sr1_fck");
 		sr2.clk = clk_get(NULL, "sr2_fck");
@@ -1036,6 +1072,8 @@ static int __init omap3_sr_init(void)
 	ret = sysfs_create_file(power_kobj, &sr_vdd2_autocomp.attr);
 	if (ret)
 		pr_err("sysfs_create_file failed: %d\n", ret);
+	list_add(&sr1.node, &sr_list);
+	list_add(&sr2.node, &sr_list);
 
 	return 0;
 }
-- 
1.7.0.rc1.33.g07cf0f

