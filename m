From: jean.pihet@newoldbits.com
Subject: [PATCH 15/26] OMAP2+: SmartReflex: rename nvalue table
Date: Tue, 22 Nov 2011 16:05:59 +0100
Message-ID: <1321974370-25800-16-git-send-email-j-pihet@ti.com>
References: <1321974370-25800-1-git-send-email-j-pihet@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:38321 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757127Ab1KVPHR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 22 Nov 2011 10:07:17 -0500
Received: by mail-fx0-f46.google.com with SMTP id n18so497590fag.19
        for <linux-omap@vger.kernel.org>; Tue, 22 Nov 2011 07:07:16 -0800 (PST)
In-Reply-To: <1321974370-25800-1-git-send-email-j-pihet@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, paul@pwsan.com, khilman@ti.com, balbi@ti.com, rjw@sisk.pl
Cc: Jean Pihet <j-pihet@ti.com>

From: Paul Walmsley <paul@pwsan.com>

struct omap_sr_nvalue_table now contains more than simply n-values, so
rename it accordingly to omap_sr_data_table.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Jean Pihet <j-pihet@ti.com>
---
 arch/arm/mach-omap2/smartreflex.c |   29 ++++++++++++++---------------
 arch/arm/mach-omap2/smartreflex.h |   17 ++++++++---------
 arch/arm/mach-omap2/sr_device.c   |   23 ++++++++++++-----------
 3 files changed, 34 insertions(+), 35 deletions(-)

diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/smartreflex.c
index 5a72c87..41c4d2a 100644
--- a/arch/arm/mach-omap2/smartreflex.c
+++ b/arch/arm/mach-omap2/smartreflex.c
@@ -3,14 +3,13 @@
  *
  * Author: Thara Gopinath	<thara@ti.com>
  *
- * Copyright (C) 2010 Texas Instruments, Inc.
+ * Copyright (C) 2007,2010 Texas Instruments, Inc.
+ * Lesly A M <x0080970@ti.com>
  * Thara Gopinath <thara@ti.com>
  *
- * Copyright (C) 2008 Nokia Corporation
+ * Copyright (C) 2008,2011 Nokia Corporation
  * Kalle Jokiniemi
- *
- * Copyright (C) 2007 Texas Instruments, Inc.
- * Lesly A M <x0080970@ti.com>
+ * Paul Walmsley
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
@@ -299,15 +298,15 @@ static struct omap_sr_nvalue_table *sr_retrieve_nvalue_row(
 {
 	int i;
 
-	if (!sr->nvalue_table) {
+	if (!sr->data_table) {
 		dev_warn(&sr->pdev->dev, "%s: Missing ntarget value table\n",
 			__func__);
 		return NULL;
 	}
 
-	for (i = 0; i < sr->nvalue_count; i++) {
-		if (sr->nvalue_table[i].volt_nominal == volt_nominal)
-			return &sr->nvalue_table[i];
+	for (i = 0; i < sr->data_count; i++) {
+		if (sr->data_table[i].volt_nominal == volt_nominal)
+			return &sr->data_table[i];
 	}
 
 	return NULL;
@@ -466,7 +465,7 @@ int sr_configure_minmax(struct smartreflex *sr)
  */
 int sr_enable(struct smartreflex *sr, unsigned long volt)
 {
-	struct omap_sr_nvalue_table *nvalue_row;
+	struct omap_sr_data_table *nvalue_row;
 	int ret;
 
 	if (IS_ERR_OR_NULL(sr))
@@ -737,7 +736,7 @@ static int __init omap_sr_probe(struct platform_device *pdev)
 	sr->pdev = pdev;
 	sr->srid = pdev->id;
 	sr->voltdm = pdata->voltdm;
-	sr->nvalue_count = pdata->nvalue_count;
+	sr->data_count = pdata->data_count;
 	sr->err_weight = pdata->err_weight;
 	sr->err_maxlimit = pdata->err_maxlimit;
 	sr->accum_data = pdata->accum_data;
@@ -814,20 +813,20 @@ static int __init omap_sr_probe(struct platform_device *pdev)
 		goto err_debugfs;
 	}
 
-	if (sr->nvalue_count == 0 || !sr->nvalue_table) {
+	if (sr->data_count == 0 || !sr->data_table) {
 		dev_warn(&pdev->dev, "%s: no SR data table\n", __func__);
 		ret = -ENODATA;
 		goto err_debugfs;
 	}
 
-	for (i = 0; i < sr->nvalue_count; i++) {
+	for (i = 0; i < sr->data_count; i++) {
 		char name[NVALUE_NAME_LEN + 1];
 
 		/* XXX Also needs to include errminlimit! */
 		snprintf(name, sizeof(name), "volt_%lu",
-			 sr->nvalue_table[i].volt_nominal);
+			 sr->data_table[i].volt_nominal);
 		(void) debugfs_create_x32(name, S_IRUGO | S_IWUSR, nvalue_dir,
-				&(sr->nvalue_table[i].nvalue));
+				&(sr->data_table[i].nvalue));
 	}
 
 	return ret;
diff --git a/arch/arm/mach-omap2/smartreflex.h b/arch/arm/mach-omap2/smartreflex.h
index 7b0304a..e7ed7a1 100644
--- a/arch/arm/mach-omap2/smartreflex.h
+++ b/arch/arm/mach-omap2/smartreflex.h
@@ -147,7 +147,7 @@ struct smartreflex {
 	char				*name;
 	int				srid;
 	int				ip_type;
-	int				nvalue_count;
+	int				data_count;
 	bool				autocomp_active;
 	u32				clk_length;
 	u32				err_weight;
@@ -162,7 +162,7 @@ struct smartreflex {
 	void __iomem			*base;
 	struct platform_device		*pdev;
 	struct list_head		node;
-	struct omap_sr_nvalue_table	*nvalue_table;
+	struct omap_sr_data_table	*data_table;
 	struct voltagedomain		*voltdm;
 	struct dentry			*dbg_dir;
 };
@@ -212,14 +212,14 @@ struct smartreflex_class_data {
 };
 
 /**
- * struct omap_sr_nvalue_table	- Smartreflex n-target value info
+ * struct omap_sr_data_table	- Smartreflex n-target value info
  *
  * @efuse_offs:	The offset of the efuse where n-target values are stored.
  * @nvalue:	The n-target value.
  * @errminlimit: The value of the ERRMINLIMIT bitfield for this n-target
  * @volt_nominal: microvolts DC that the VDD is initially programmed to
  */
-struct omap_sr_nvalue_table {
+struct omap_sr_data_table {
 	u32 efuse_offs;
 	u32 nvalue;
 	u32 errminlimit;
@@ -238,11 +238,10 @@ struct omap_sr_nvalue_table {
  * @senn_mod:		SENNENABLE value for sr
  * @senn_avgweight: XXX
  * @senp_avgweight: XXX
- * @nvalue_count:	Number of distinct nvalues in the nvalue table
+ * @data_count:	Number of rows in @data_table
  * @enable_on_init:	whether this sr module needs to enabled at
  *			boot up or not.
- * @nvalue_table:	table containing the  efuse offsets and nvalues
- *			corresponding to them.
+ * @data_table:	table containing SR parameters for each valid voltage
  * @voltdm:		Pointer to the voltage domain associated with the SR
  * @sr: struct smartreflex:
  *			associated with this SR device (allocated in *_probe())
@@ -257,9 +256,9 @@ struct smartreflex_platform_data {
 	u32				senn_mod;
 	u32				senn_avgweight;
 	u32				senp_avgweight;
-	int				nvalue_count;
+	int				data_count;
 	bool				enable_on_init;
-	struct omap_sr_nvalue_table	*nvalue_table;
+	struct omap_sr_data_table	*data_table;
 	struct voltagedomain		*voltdm;
 	struct smartreflex		*sr;
 };
diff --git a/arch/arm/mach-omap2/sr_device.c b/arch/arm/mach-omap2/sr_device.c
index aece907..2fefbb5 100644
--- a/arch/arm/mach-omap2/sr_device.c
+++ b/arch/arm/mach-omap2/sr_device.c
@@ -36,19 +36,20 @@ static bool sr_enable_on_init;
 static void __init sr_set_nvalues(struct omap_volt_data *volt_data,
 				  struct smartreflex_platform_data *pdata)
 {
-	struct omap_sr_nvalue_table *nvalue_table;
+	struct omap_sr_data_table *data_table;
 	int i, j, count = 0;
 
-	pdata->nvalue_count = 0;
-	pdata->nvalue_table = NULL;
+	pdata->data_count = 0;
+	pdata->data_table = NULL;
 
 	while (volt_data[count].volt_nominal)
 		count++;
 
-	nvalue_table = kzalloc(sizeof(struct omap_sr_nvalue_table)*count,
+	data_table = kzalloc(sizeof(struct omap_sr_data_table)*count,
 			GFP_KERNEL);
-	if (!nvalue_table) {
-		pr_err("OMAP: SmartReflex: cannot allocate memory for n-value table\n");
+	if (!data_table) {
+		pr_err("OMAP: SmartReflex: cannot allocate memory for n-value "
+		       "table\n");
 		return;
 	}
 
@@ -86,15 +87,15 @@ static void __init sr_set_nvalues(struct omap_volt_data *volt_data,
 			continue;
 		}
 
-		nvalue_table[j].nvalue = v;
-		nvalue_table[j].errminlimit = volt_data[i].sr_errminlimit;
-		nvalue_table[j].volt_nominal = volt_data[i].volt_nominal;
+		data_table[j].nvalue = v;
+		data_table[j].errminlimit = volt_data[i].sr_errminlimit;
+		data_table[j].volt_nominal = volt_data[i].volt_nominal;
 
 		j++;
 	}
 
-	pdata->nvalue_table = nvalue_table;
-	pdata->nvalue_count = j;
+	pdata->data_table = data_table;
+	pdata->data_count = j;
 }
 
 static int sr_dev_init(struct omap_hwmod *oh, void *user)
-- 
1.7.5.4

