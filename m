From: jean.pihet@newoldbits.com
Subject: [PATCH 12/26] OMAP: SmartReflex: remove some SoC-specific implementation details from driver
Date: Tue, 22 Nov 2011 16:05:56 +0100
Message-ID: <1321974370-25800-13-git-send-email-j-pihet@ti.com>
References: <1321974370-25800-1-git-send-email-j-pihet@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:38321 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757104Ab1KVPHL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 22 Nov 2011 10:07:11 -0500
Received: by mail-fx0-f46.google.com with SMTP id n18so497590fag.19
        for <linux-omap@vger.kernel.org>; Tue, 22 Nov 2011 07:07:11 -0800 (PST)
In-Reply-To: <1321974370-25800-1-git-send-email-j-pihet@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, paul@pwsan.com, khilman@ti.com, balbi@ti.com, rjw@sisk.pl
Cc: Jean Pihet <j-pihet@ti.com>, Thara Gopinath <thara@ti.com>, Nishanth Menon <nm@ti.com>

From: Paul Walmsley <paul@pwsan.com>

The SmartReflex driver incorrectly treats some per-OPP data as data
common to all OPPs (e.g., ERRMINLIMIT).  Move this data into a per-OPP
data structure.

The SmartReflex driver should not be dependent on whether the host SoC
uses eFuses to store SmartReflex parameters or not.  (Even SoCs that
do store SR data in eFuses often need to override that data with
software-defined values.)  So, convert sr_retrieve_nvalue() to look up
per-OPP data by the OPP's nominal voltage, rather than by the eFuse
offset.

Based on Paul's original code for the SmartReflex driver conversion.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Jean Pihet <j-pihet@ti.com>
Cc: Thara Gopinath <thara@ti.com>
Cc: Nishanth Menon <nm@ti.com>
Cc: Kevin Hilman <khilman@ti.com>
---
 arch/arm/mach-omap2/smartreflex.c |   53 ++++++++++++++-----------------------
 arch/arm/mach-omap2/smartreflex.h |    4 +++
 arch/arm/mach-omap2/sr_device.c   |   27 ++++++++++++++----
 3 files changed, 45 insertions(+), 39 deletions(-)

diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/smartreflex.c
index 86f2bf2..66c6f6b 100644
--- a/arch/arm/mach-omap2/smartreflex.c
+++ b/arch/arm/mach-omap2/smartreflex.c
@@ -300,22 +300,24 @@ static void sr_v2_disable(struct smartreflex *sr)
 	sr_write_reg(sr, IRQSTATUS, IRQSTATUS_MCUDISABLEACKINT);
 }
 
-static u32 sr_retrieve_nvalue(struct smartreflex *sr, u32 efuse_offs)
+static struct omap_sr_nvalue_table *sr_retrieve_nvalue_row(
+				struct smartreflex *sr,
+				unsigned long volt_nominal)
 {
 	int i;
 
 	if (!sr->nvalue_table) {
 		dev_warn(&sr->pdev->dev, "%s: Missing ntarget value table\n",
 			__func__);
-		return 0;
+		return NULL;
 	}
 
 	for (i = 0; i < sr->nvalue_count; i++) {
-		if (sr->nvalue_table[i].efuse_offs == efuse_offs)
-			return sr->nvalue_table[i].nvalue;
+		if (sr->nvalue_table[i].volt_nominal == volt_nominal)
+			return &sr->nvalue_table[i];
 	}
 
-	return 0;
+	return NULL;
 }
 
 /* Public Functions */
@@ -471,31 +473,21 @@ int sr_configure_minmax(struct smartreflex *sr)
  */
 int sr_enable(struct smartreflex *sr, unsigned long volt)
 {
-	u32 nvalue_reciprocal;
-	struct omap_volt_data *volt_data;
+	struct omap_sr_nvalue_table *nvalue_row;
 	int ret;
 
 	if (IS_ERR_OR_NULL(sr))
 		return -EINVAL;
 
-	volt_data = omap_voltage_get_voltdata(sr->voltdm, volt);
-
-	if (IS_ERR(volt_data)) {
-		dev_warn(&sr->pdev->dev, "%s: Unable to get voltage table"
-			"for nominal voltage %ld\n", __func__, volt);
-		return -ENODATA;
-	}
-
-	nvalue_reciprocal = sr_retrieve_nvalue(sr, volt_data->sr_efuse_offs);
-
-	if (!nvalue_reciprocal) {
-		dev_warn(&sr->pdev->dev, "%s: NVALUE = 0 at voltage %ld\n",
-			__func__, volt);
+	nvalue_row = sr_retrieve_nvalue_row(sr, volt);
+	if (!nvalue_row) {
+		dev_warn(&sr->pdev->dev, "%s: failure getting SR data for "
+					 "this voltage %ld\n",__func__, volt);
 		return -ENODATA;
 	}
 
 	/* errminlimit is opp dependent and hence linked to voltage */
-	sr->err_minlimit = volt_data->sr_errminlimit;
+	sr->err_minlimit = nvalue_row->errminlimit;
 
 	pm_runtime_get_sync(&sr->pdev->dev);
 
@@ -508,7 +500,7 @@ int sr_enable(struct smartreflex *sr, unsigned long volt)
 	if (ret)
 		return ret;
 
-	sr_write_reg(sr, NVALUERECIPROCAL, nvalue_reciprocal);
+	sr_write_reg(sr, NVALUERECIPROCAL, nvalue_row->nvalue);
 
 	/* SRCONFIG - enable SR */
 	sr_modify_reg(sr, SRCONFIG, SRCONFIG_SRENABLE, SRCONFIG_SRENABLE);
@@ -714,7 +706,6 @@ static int __init omap_sr_probe(struct platform_device *pdev)
 	struct smartreflex_platform_data *pdata = pdev->dev.platform_data;
 	struct resource *mem, *irq;
 	struct dentry *nvalue_dir;
-	struct omap_volt_data *volt_data;
 	int i, ret = 0;
 	char *name;
 
@@ -823,8 +814,6 @@ static int __init omap_sr_probe(struct platform_device *pdev)
 			&sr->err_weight);
 	(void) debugfs_create_x32("errmaxlimit", S_IRUGO, sr->dbg_dir,
 			&sr->err_maxlimit);
-	(void) debugfs_create_x32("errminlimit", S_IRUGO, sr->dbg_dir,
-			&sr->err_minlimit);
 
 	nvalue_dir = debugfs_create_dir("nvalue", sr->dbg_dir);
 	if (IS_ERR(nvalue_dir)) {
@@ -834,12 +823,10 @@ static int __init omap_sr_probe(struct platform_device *pdev)
 		goto err_debugfs;
 	}
 
-	omap_voltage_get_volttable(sr->voltdm, &volt_data);
-	if (!volt_data) {
-		dev_warn(&pdev->dev, "%s: No Voltage table for the"
-			" corresponding vdd vdd_%s. Cannot create debugfs"
-			"entries for n-values\n",
-			__func__, sr->voltdm->name);
+	if (sr->nvalue_count == 0 || !sr->nvalue_table) {
+		dev_warn(&pdev->dev, "%s: No Voltage table for the "
+			 "corresponding vdd vdd_%s. Cannot create debugfs "
+			 "entries for n-values\n", __func__, sr->voltdm->name);
 		ret = -ENODATA;
 		goto err_debugfs;
 	}
@@ -848,8 +835,8 @@ static int __init omap_sr_probe(struct platform_device *pdev)
 		char name[NVALUE_NAME_LEN + 1];
 
 		/* XXX Also needs to include errminlimit! */
-		snprintf(name, sizeof(name), "volt_%u",
-			 volt_data[i].volt_nominal);
+		snprintf(name, sizeof(name), "volt_%lu",
+			 sr->nvalue_table[i].volt_nominal);
 		(void) debugfs_create_x32(name, S_IRUGO | S_IWUSR, nvalue_dir,
 				&(sr->nvalue_table[i].nvalue));
 	}
diff --git a/arch/arm/mach-omap2/smartreflex.h b/arch/arm/mach-omap2/smartreflex.h
index 0ebcec0..ca70a90 100644
--- a/arch/arm/mach-omap2/smartreflex.h
+++ b/arch/arm/mach-omap2/smartreflex.h
@@ -215,10 +215,14 @@ struct smartreflex_class_data {
  *
  * @efuse_offs:	The offset of the efuse where n-target values are stored.
  * @nvalue:	The n-target value.
+ * @errminlimit: The value of the ERRMINLIMIT bitfield for this n-target
+ * @volt_nominal: microvolts DC that the VDD is initially programmed to
  */
 struct omap_sr_nvalue_table {
 	u32 efuse_offs;
 	u32 nvalue;
+	u32 errminlimit;
+	unsigned long volt_nominal;
 };
 
 /**
diff --git a/arch/arm/mach-omap2/sr_device.c b/arch/arm/mach-omap2/sr_device.c
index f464d6a2..8fe836f 100644
--- a/arch/arm/mach-omap2/sr_device.c
+++ b/arch/arm/mach-omap2/sr_device.c
@@ -36,7 +36,7 @@ static void __init sr_set_nvalues(struct omap_volt_data *volt_data,
 				  struct smartreflex_platform_data *pdata)
 {
 	struct omap_sr_nvalue_table *nvalue_table;
-	int i, count = 0;
+	int i, j, count = 0;
 
 	pdata->nvalue_count = 0;
 	pdata->nvalue_table = NULL;
@@ -51,8 +51,9 @@ static void __init sr_set_nvalues(struct omap_volt_data *volt_data,
 		return;
 	}
 
-	for (i = 0; i < count; i++) {
+	for (i = 0, j = 0; i < count; i++) {
 		u32 v;
+
 		/*
 		 * In OMAP4 the efuse registers are 24 bit aligned.
 		 * A __raw_readl will fail for non-32 bit aligned address
@@ -65,15 +66,29 @@ static void __init sr_set_nvalues(struct omap_volt_data *volt_data,
 				omap_ctrl_readb(offset + 1) << 8 |
 				omap_ctrl_readb(offset + 2) << 16;
 		} else {
-			 v = omap_ctrl_readl(volt_data[i].sr_efuse_offs);
+			v = omap_ctrl_readl(volt_data[i].sr_efuse_offs);
 		}
 
-		nvalue_table[i].efuse_offs = volt_data[i].sr_efuse_offs;
-		nvalue_table[i].nvalue = v;
+		/*
+		 * Many OMAP SoCs don't have the eFuse values set.
+		 * For example, pretty much all OMAP3xxx before
+		 * ES3.something.
+		 *
+		 * XXX There needs to be some way for board files or
+		 * userspace to add these in.
+		 */
+		if (v == 0)
+			continue;
+
+		nvalue_table[j].nvalue = v;
+		nvalue_table[j].errminlimit = volt_data[i].sr_errminlimit;
+		nvalue_table[j].volt_nominal = volt_data[i].volt_nominal;
+
+		j++;
 	}
 
 	pdata->nvalue_table = nvalue_table;
-	pdata->nvalue_count = count;
+	pdata->nvalue_count = j;
 }
 
 static int sr_dev_init(struct omap_hwmod *oh, void *user)
-- 
1.7.5.4

