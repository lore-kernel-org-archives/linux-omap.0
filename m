From: Anand S Sawant <sawant@ti.com>
Subject: [PATCH] omap2plus: smartreflex: add error checking for debugfs_create_*()
Date: Thu, 27 Jan 2011 17:22:16 +0530
Message-ID: <1296129136-11116-1-git-send-email-sawant@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:60678 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754386Ab1A0Lw0 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 27 Jan 2011 06:52:26 -0500
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id p0RBqNUB000629
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Thu, 27 Jan 2011 05:52:25 -0600
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Anand S Sawant <sawant@ti.com>

debugfs_create_*() functions return a struct dentry pointer. In
omap_sr_probe(), the pointer is checked if the debug entry created
happens to be a directory. However, it is ignored in case of leaf
nodes viz. while calling  debugfs_create_file() and
debugfs_create_x32().

Replace the unnecessary void casts with appropriate error check
of the returned struct dentry pointer and provide a warning in
case of error.

Tested on OMAP3630 Zoom3 and OMAP4430 SDP

Reported-by: Nishanth Menon <nm@ti.com>
Acked-by: Nishanth Menon <nm@ti.com>
Reviewed-by: Charulatha V <charu@ti.com>

Signed-off-by: Anand S Sawant <sawant@ti.com>
---
Based on the latest Kevin's PM branch

 arch/arm/mach-omap2/smartreflex.c |   41 +++++++++++++++++++++++++++++++-----
 1 files changed, 35 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/smartreflex.c
index 77ecebf..c57f80f 100644
--- a/arch/arm/mach-omap2/smartreflex.c
+++ b/arch/arm/mach-omap2/smartreflex.c
@@ -822,7 +822,7 @@ static int __init omap_sr_probe(struct platform_device *pdev)
 	struct omap_sr *sr_info = kzalloc(sizeof(struct omap_sr), GFP_KERNEL);
 	struct omap_sr_data *pdata = pdev->dev.platform_data;
 	struct resource *mem, *irq;
-	struct dentry *vdd_dbg_dir, *dbg_dir, *nvalue_dir;
+	struct dentry *vdd_dbg_dir, *dbg_dir, *nvalue_dir, *dbg_entry;
 	struct omap_volt_data *volt_data;
 	int i, ret = 0;
 
@@ -901,14 +901,37 @@ static int __init omap_sr_probe(struct platform_device *pdev)
 		return PTR_ERR(dbg_dir);
 	}
 
-	(void) debugfs_create_file("autocomp", S_IRUGO | S_IWUGO, dbg_dir,
+	dbg_entry = debugfs_create_file("autocomp", S_IRUGO | S_IWUGO, dbg_dir,
 				(void *)sr_info, &pm_sr_fops);
-	(void) debugfs_create_x32("errweight", S_IRUGO, dbg_dir,
+	if (IS_ERR(dbg_entry)) {
+		dev_warn(&pdev->dev,
+			"%s: Unable to create debugfs entry for autocomp",
+			__func__);
+	}
+
+	dbg_entry = debugfs_create_x32("errweight", S_IRUGO, dbg_dir,
 			&sr_info->err_weight);
-	(void) debugfs_create_x32("errmaxlimit", S_IRUGO, dbg_dir,
+	if (IS_ERR(dbg_entry)) {
+		dev_warn(&pdev->dev,
+			"%s: Unable to create debugfs entry for errweight",
+			__func__);
+	}
+
+	dbg_entry = debugfs_create_x32("errmaxlimit", S_IRUGO, dbg_dir,
 			&sr_info->err_maxlimit);
-	(void) debugfs_create_x32("errminlimit", S_IRUGO, dbg_dir,
+	if (IS_ERR(dbg_entry)) {
+		dev_warn(&pdev->dev,
+			"%s: Unable to create debugfs entry for errmaxlimit",
+			__func__);
+	}
+
+	dbg_entry = debugfs_create_x32("errminlimit", S_IRUGO, dbg_dir,
 			&sr_info->err_minlimit);
+	if (IS_ERR(dbg_entry)) {
+		dev_warn(&pdev->dev,
+			"%s: Unable to create debugfs entry for errminlimit",
+			__func__);
+	}
 
 	nvalue_dir = debugfs_create_dir("nvalue", dbg_dir);
 	if (IS_ERR(nvalue_dir)) {
@@ -940,8 +963,14 @@ static int __init omap_sr_probe(struct platform_device *pdev)
 		strcpy(name, "volt_");
 		sprintf(volt_name, "%d", volt_data[i].volt_nominal);
 		strcat(name, volt_name);
-		(void) debugfs_create_x32(name, S_IRUGO | S_IWUGO, nvalue_dir,
+		dbg_entry = debugfs_create_x32(name, S_IRUGO | S_IWUGO,
+				nvalue_dir,
 				&(sr_info->nvalue_table[i].nvalue));
+		if (IS_ERR(dbg_entry)) {
+			dev_warn(&pdev->dev,
+				"%s: Unable to create debugfs entry for %s",
+				__func__, name);
+		}
 	}
 
 	return ret;
-- 
1.7.0.4

