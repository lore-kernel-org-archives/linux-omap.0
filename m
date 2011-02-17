From: sawant@ti.com
Subject: [PATCH] omap2plus: smartreflex: remove sr debug directory in omap_sr_remove()
Date: Thu, 17 Feb 2011 21:27:30 +0530
Message-ID: <1297958250-13612-1-git-send-email-sawant@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:60765 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751289Ab1BQP5l (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 17 Feb 2011 10:57:41 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Anand S Sawant <sawant@ti.com>

From: Anand S Sawant <sawant@ti.com>

omap_sr_probe() creates the smartreflex debug directory and its
underlying nvalue debug directory. These directories are removed in
omap_sr_remove().

Basic smartreflex functionality tested on OMAP3630 Zoom3 & OMAP4430 SDP

Signed-off-by: Anand S Sawant <sawant@ti.com>
---
Rebased on the latest Kevin's pm branch 
(commit id: b6fb54bc4bfc396a9b982d76c1c954c974290a1a)

 arch/arm/mach-omap2/smartreflex.c |   23 +++++++++++++----------
 1 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/smartreflex.c
index a1f532e..dc19f17 100644
--- a/arch/arm/mach-omap2/smartreflex.c
+++ b/arch/arm/mach-omap2/smartreflex.c
@@ -54,6 +54,7 @@ struct omap_sr {
 	struct list_head		node;
 	struct omap_sr_nvalue_table	*nvalue_table;
 	struct voltagedomain		*voltdm;
+	struct dentry			*dbg_dir;
 };
 
 /* sr_list contains all the instances of smartreflex module */
@@ -822,7 +823,7 @@ static int __init omap_sr_probe(struct platform_device *pdev)
 	struct omap_sr *sr_info = kzalloc(sizeof(struct omap_sr), GFP_KERNEL);
 	struct omap_sr_data *pdata = pdev->dev.platform_data;
 	struct resource *mem, *irq;
-	struct dentry *vdd_dbg_dir, *dbg_dir, *nvalue_dir;
+	struct dentry *vdd_dbg_dir, *nvalue_dir;
 	struct omap_volt_data *volt_data;
 	int i, ret = 0;
 
@@ -895,23 +896,23 @@ static int __init omap_sr_probe(struct platform_device *pdev)
 	if (!vdd_dbg_dir)
 		return -EINVAL;
 
-	dbg_dir = debugfs_create_dir("smartreflex", vdd_dbg_dir);
-	if (IS_ERR(dbg_dir)) {
+	sr_info->dbg_dir = debugfs_create_dir("smartreflex", vdd_dbg_dir);
+	if (IS_ERR(sr_info->dbg_dir)) {
 		dev_err(&pdev->dev, "%s: Unable to create debugfs directory\n",
 			__func__);
-		return PTR_ERR(dbg_dir);
+		return PTR_ERR(sr_info->dbg_dir);
 	}
 
-	(void) debugfs_create_file("autocomp", S_IRUGO | S_IWUSR, dbg_dir,
-				(void *)sr_info, &pm_sr_fops);
-	(void) debugfs_create_x32("errweight", S_IRUGO, dbg_dir,
+	(void) debugfs_create_file("autocomp", S_IRUGO | S_IWUSR,
+			sr_info->dbg_dir, (void *)sr_info, &pm_sr_fops);
+	(void) debugfs_create_x32("errweight", S_IRUGO, sr_info->dbg_dir,
 			&sr_info->err_weight);
-	(void) debugfs_create_x32("errmaxlimit", S_IRUGO, dbg_dir,
+	(void) debugfs_create_x32("errmaxlimit", S_IRUGO, sr_info->dbg_dir,
 			&sr_info->err_maxlimit);
-	(void) debugfs_create_x32("errminlimit", S_IRUGO, dbg_dir,
+	(void) debugfs_create_x32("errminlimit", S_IRUGO, sr_info->dbg_dir,
 			&sr_info->err_minlimit);
 
-	nvalue_dir = debugfs_create_dir("nvalue", dbg_dir);
+	nvalue_dir = debugfs_create_dir("nvalue", sr_info->dbg_dir);
 	if (IS_ERR(nvalue_dir)) {
 		dev_err(&pdev->dev, "%s: Unable to create debugfs directory"
 			"for n-values\n", __func__);
@@ -975,6 +976,8 @@ static int __devexit omap_sr_remove(struct platform_device *pdev)
 
 	if (sr_info->autocomp_active)
 		sr_stop_vddautocomp(sr_info);
+	if (sr_info->dbg_dir)
+		debugfs_remove_recursive(sr_info->dbg_dir);
 
 	list_del(&sr_info->node);
 	iounmap(sr_info->base);
-- 
1.7.0.4

