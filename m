From: jean.pihet@newoldbits.com
Subject: [PATCH 21/26] OMAP2+: SmartReflex: get rid of superfluous data that is duplicated between platform_data and the struct omap_sr
Date: Tue, 22 Nov 2011 16:06:05 +0100
Message-ID: <1321974370-25800-22-git-send-email-j-pihet@ti.com>
References: <1321974370-25800-1-git-send-email-j-pihet@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:43561 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757208Ab1KVPH3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 22 Nov 2011 10:07:29 -0500
Received: by mail-ww0-f44.google.com with SMTP id 5so432213wwe.1
        for <linux-omap@vger.kernel.org>; Tue, 22 Nov 2011 07:07:28 -0800 (PST)
In-Reply-To: <1321974370-25800-1-git-send-email-j-pihet@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, paul@pwsan.com, khilman@ti.com, balbi@ti.com, rjw@sisk.pl
Cc: Jean Pihet <j-pihet@ti.com>

From: Jean Pihet <j-pihet@ti.com>

Based on Paul's original code for the SmartReflex driver conversion.

Signed-off-by: Jean Pihet <j-pihet@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/smartreflex.c |   51 +++++++++++++++++++------------------
 arch/arm/mach-omap2/smartreflex.h |    6 ----
 2 files changed, 26 insertions(+), 31 deletions(-)

diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/smartreflex.c
index 2e37915..0f03d80 100644
--- a/arch/arm/mach-omap2/smartreflex.c
+++ b/arch/arm/mach-omap2/smartreflex.c
@@ -85,15 +85,16 @@ static inline u32 sr_read_reg(struct smartreflex *sr, unsigned offset)
 static irqreturn_t sr_interrupt(int irq, void *data)
 {
 	struct smartreflex *sr = (struct smartreflex *)data;
+	struct smartreflex_platform_data *pdata = sr->pdev->dev.platform_data;
 	u32 status = 0;
 
-	if (sr->ip_type == SR_TYPE_V1) {
+	if (pdata->ip_type == SR_TYPE_V1) {
 		/* Read the status bits */
 		status = sr_read_reg(sr, ERRCONFIG_V1);
 
 		/* Clear them by writing back */
 		sr_write_reg(sr, ERRCONFIG_V1, status);
-	} else if (sr->ip_type == SR_TYPE_V2) {
+	} else if (pdata->ip_type == SR_TYPE_V2) {
 		/* Read the status bits */
 		status = sr_read_reg(sr, IRQSTATUS);
 
@@ -280,6 +281,7 @@ static struct omap_sr_nvalue_table *sr_retrieve_nvalue_row(
 				struct smartreflex *sr,
 				unsigned long volt_nominal)
 {
+	struct smartreflex_platform_data *pdata = sr->pdev->dev.platform_data;
 	int i;
 
 	if (!sr->data_table) {
@@ -288,7 +290,7 @@ static struct omap_sr_nvalue_table *sr_retrieve_nvalue_row(
 		return NULL;
 	}
 
-	for (i = 0; i < sr->data_count; i++) {
+	for (i = 0; i < pdata->data_count; i++) {
 		if (sr->data_table[i].volt_nominal == volt_nominal)
 			return &sr->data_table[i];
 	}
@@ -312,6 +314,7 @@ static struct omap_sr_nvalue_table *sr_retrieve_nvalue_row(
  */
 int sr_configure_errgen(struct smartreflex *sr)
 {
+	struct smartreflex_platform_data *pdata = sr->pdev->dev.platform_data;
 	u32 sr_config, sr_errconfig;
 
 	if (IS_ERR_OR_NULL(sr))
@@ -324,8 +327,8 @@ int sr_configure_errgen(struct smartreflex *sr)
 	sr_config |=  SRCONFIG_ERRGEN_EN;
 	sr_write_reg(sr, SRCONFIG, sr_config);
 
-	sr_errconfig = (sr->err_weight << ERRCONFIG_ERRWEIGHT_SHIFT) |
-		(sr->err_maxlimit << ERRCONFIG_ERRMAXLIMIT_SHIFT) |
+	sr_errconfig = (pdata->err_weight << ERRCONFIG_ERRWEIGHT_SHIFT) |
+		(pdata->err_maxlimit << ERRCONFIG_ERRMAXLIMIT_SHIFT) |
 		(sr->err_minlimit <<  ERRCONFIG_ERRMINLIMIT_SHIFT);
 	sr_modify_reg(sr, sr->errconfig_offs, (SR_ERRWEIGHT_MASK |
 		SR_ERRMAXLIMIT_MASK | SR_ERRMINLIMIT_MASK),
@@ -352,31 +355,32 @@ int sr_configure_errgen(struct smartreflex *sr)
  */
 int sr_configure_minmax(struct smartreflex *sr)
 {
+	struct smartreflex_platform_data *pdata = sr->pdev->dev.platform_data;
 	u32 sr_config, sr_avgwt;
 
 	if (IS_ERR_OR_NULL(sr))
 		return -EINVAL;
 
 	sr_config = sr->proto_sr_config;
-	sr_config |= (sr->accum_data << SRCONFIG_ACCUMDATA_SHIFT);
+	sr_config |= (pdata->accum_data << SRCONFIG_ACCUMDATA_SHIFT);
 	sr_write_reg(sr, SRCONFIG, sr_config);
 
-	sr_avgwt = (sr->senp_avgweight << AVGWEIGHT_SENPAVGWEIGHT_SHIFT) |
-		(sr->senn_avgweight << AVGWEIGHT_SENNAVGWEIGHT_SHIFT);
+	sr_avgwt = (pdata->senp_avgweight << AVGWEIGHT_SENPAVGWEIGHT_SHIFT) |
+		(pdata->senn_avgweight << AVGWEIGHT_SENNAVGWEIGHT_SHIFT);
 	sr_write_reg(sr, AVGWEIGHT, sr_avgwt);
 
 	/*
 	 * Enabling the interrupts if MINMAXAVG module is used.
 	 * TODO: check if all the interrupts are mandatory
 	 */
-	if (sr->ip_type == SR_TYPE_V1) {
+	if (pdata->ip_type == SR_TYPE_V1) {
 		sr_modify_reg(sr, ERRCONFIG_V1,
 			(ERRCONFIG_MCUACCUMINTEN | ERRCONFIG_MCUVALIDINTEN |
 			ERRCONFIG_MCUBOUNDINTEN),
 			(ERRCONFIG_MCUACCUMINTEN | ERRCONFIG_MCUACCUMINTST |
 			 ERRCONFIG_MCUVALIDINTEN | ERRCONFIG_MCUVALIDINTST |
 			 ERRCONFIG_MCUBOUNDINTEN | ERRCONFIG_MCUBOUNDINTST));
-	} else if (sr->ip_type == SR_TYPE_V2) {
+	} else if (pdata->ip_type == SR_TYPE_V2) {
 		sr_write_reg(sr, IRQSTATUS,
 			IRQSTATUS_MCUACCUMINT | IRQSTATUS_MCVALIDINT |
 			IRQSTATUS_MCBOUNDSINT | IRQSTATUS_MCUDISABLEACKINT);
@@ -444,6 +448,8 @@ int sr_enable(struct smartreflex *sr, unsigned long volt)
  */
 void sr_disable(struct smartreflex *sr)
 {
+	struct smartreflex_platform_data *pdata = sr->pdev->dev.platform_data;
+
 	if (IS_ERR_OR_NULL(sr))
 		return;
 
@@ -456,9 +462,9 @@ void sr_disable(struct smartreflex *sr)
 	 * disable the clocks.
 	 */
 	if (sr_read_reg(sr, SRCONFIG) & SRCONFIG_SRENABLE) {
-		if (sr->ip_type == SR_TYPE_V1)
+		if (pdata->ip_type == SR_TYPE_V1)
 			sr_v1_disable(sr);
-		else if (sr->ip_type == SR_TYPE_V2)
+		else if (pdata->ip_type == SR_TYPE_V2)
 			sr_v2_disable(sr);
 	}
 
@@ -631,6 +637,7 @@ static int __init omap_sr_probe(struct platform_device *pdev)
 	struct smartreflex_platform_data *pdata = pdev->dev.platform_data;
 	struct resource *mem, *irq;
 	struct dentry *nvalue_dir;
+	int srclklength, senn_shift, senp_shift;
 	int i, ret = 0;
 
 	if (!sr) {
@@ -668,14 +675,8 @@ static int __init omap_sr_probe(struct platform_device *pdev)
 
 	sr->pdev = pdev;
 	sr->voltdm = pdata->voltdm;
-	sr->data_count = pdata->data_count;
-	sr->err_weight = pdata->err_weight;
-	sr->err_maxlimit = pdata->err_maxlimit;
-	sr->accum_data = pdata->accum_data;
-	sr->senn_avgweight = pdata->senn_avgweight;
-	sr->senp_avgweight = pdata->senp_avgweight;
+
 	sr->autocomp_active = false;
-	sr->ip_type = pdata->ip_type;
 	sr->base = ioremap(mem->start, resource_size(mem));
 	if (!sr->base) {
 		dev_err(&pdev->dev, "%s: ioremap fail\n", __func__);
@@ -691,7 +692,7 @@ static int __init omap_sr_probe(struct platform_device *pdev)
 	sr->proto_sr_config = (srclklength << SRCONFIG_SRCLKLENGTH_SHIFT) |
 		SRCONFIG_SENENABLE;
 
-	if (sr->ip_type == SR_TYPE_V1) {
+	if (pdata->ip_type == SR_TYPE_V1) {
 		senn_shift = SRCONFIG_SENNENABLE_V1_SHIFT;
 		senp_shift = SRCONFIG_SENPENABLE_V1_SHIFT;
 		sr->proto_sr_config |= SRCONFIG_DELAYCTRL;
@@ -699,7 +700,7 @@ static int __init omap_sr_probe(struct platform_device *pdev)
 		sr->errconfig_mask = ERRCONFIG_STATUS_V1_MASK;
 		sr->vpboundint_en = ERRCONFIG_VPBOUNDINTEN_V1;
 		sr->vpboundint_st = ERRCONFIG_VPBOUNDINTST_V1;
-	} else if (sr->ip_type == SR_TYPE_V2) {
+	} else if (pdata->ip_type == SR_TYPE_V2) {
 		senn_shift = SRCONFIG_SENNENABLE_V2_SHIFT;
 		senp_shift = SRCONFIG_SENPENABLE_V2_SHIFT;
 		sr->errconfig_offs = ERRCONFIG_V2;
@@ -757,9 +758,9 @@ static int __init omap_sr_probe(struct platform_device *pdev)
 	(void) debugfs_create_file("autocomp", S_IRUGO | S_IWUSR,
 			sr->dbg_dir, (void *)sr, &pm_sr_fops);
 	(void) debugfs_create_x32("errweight", S_IRUGO, sr->dbg_dir,
-			&sr->err_weight);
+			&pdata->err_weight);
 	(void) debugfs_create_x32("errmaxlimit", S_IRUGO, sr->dbg_dir,
-			&sr->err_maxlimit);
+			&pdata->err_maxlimit);
 
 	nvalue_dir = debugfs_create_dir("nvalue", sr->dbg_dir);
 	if (IS_ERR(nvalue_dir)) {
@@ -768,13 +769,13 @@ static int __init omap_sr_probe(struct platform_device *pdev)
 		goto err_debugfs;
 	}
 
-	if (sr->data_count == 0 || !sr->data_table) {
+	if (pdata->data_count == 0 || !pdata->data_table) {
 		dev_warn(&pdev->dev, "%s: no SR data table\n", __func__);
 		ret = -ENODATA;
 		goto err_debugfs;
 	}
 
-	for (i = 0; i < sr->data_count; i++) {
+	for (i = 0; i < pdata->data_count; i++) {
 		char name[NVALUE_NAME_LEN + 1];
 
 		/* XXX Also needs to include errminlimit! */
diff --git a/arch/arm/mach-omap2/smartreflex.h b/arch/arm/mach-omap2/smartreflex.h
index 6ed1381..7cd7f84 100644
--- a/arch/arm/mach-omap2/smartreflex.h
+++ b/arch/arm/mach-omap2/smartreflex.h
@@ -138,14 +138,8 @@
 struct smartreflex {
 	char				*name;
 	int				ip_type;
-	int				data_count;
 	bool				autocomp_active;
-	u32				err_weight;
 	u32				err_minlimit;
-	u32				err_maxlimit;
-	u32				accum_data;
-	u32				senn_avgweight;
-	u32				senp_avgweight;
 	u32				errconfig_mask;
 	u32				vpboundint_en;
 	u32				vpboundint_st;
-- 
1.7.5.4

