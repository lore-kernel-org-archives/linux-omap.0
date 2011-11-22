From: jean.pihet@newoldbits.com
Subject: [PATCH 20/26] OMAP2+: SmartReflex: make driver generic
Date: Tue, 22 Nov 2011 16:06:04 +0100
Message-ID: <1321974370-25800-21-git-send-email-j-pihet@ti.com>
References: <1321974370-25800-1-git-send-email-j-pihet@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:38321 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756172Ab1KVPH1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 22 Nov 2011 10:07:27 -0500
Received: by mail-fx0-f46.google.com with SMTP id n18so497590fag.19
        for <linux-omap@vger.kernel.org>; Tue, 22 Nov 2011 07:07:27 -0800 (PST)
In-Reply-To: <1321974370-25800-1-git-send-email-j-pihet@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, paul@pwsan.com, khilman@ti.com, balbi@ti.com, rjw@sisk.pl
Cc: Jean Pihet <j-pihet@ti.com>

From: Jean Pihet <j-pihet@ti.com>

Use the data from the SmartReflex data struct; make the driver
OMAP independent.

Based on Paul's original code for the SmartReflex driver conversion.

Signed-off-by: Jean Pihet <j-pihet@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/smartreflex.c |  129 ++++++++++++++----------------------
 arch/arm/mach-omap2/smartreflex.h |    9 ++-
 2 files changed, 55 insertions(+), 83 deletions(-)

diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/smartreflex.c
index e57263a..2e37915 100644
--- a/arch/arm/mach-omap2/smartreflex.c
+++ b/arch/arm/mach-omap2/smartreflex.c
@@ -56,7 +56,6 @@ static inline void sr_modify_reg(struct smartreflex *sr, unsigned offset,
 				 u32 mask, u32 value)
 {
 	u32 reg_val;
-	u32 errconfig_offs = 0, errconfig_mask = 0;
 
 	reg_val = __raw_readl(sr->base + offset);
 	reg_val &= ~mask;
@@ -70,16 +69,8 @@ static inline void sr_modify_reg(struct smartreflex *sr, unsigned offset,
 	 * if they are currently set, but does allow the caller to write
 	 * those bits.
 	 */
-	if (sr->ip_type == SR_TYPE_V1) {
-		errconfig_offs = ERRCONFIG_V1;
-		errconfig_mask = ERRCONFIG_STATUS_V1_MASK;
-	} else if (sr->ip_type == SR_TYPE_V2) {
-		errconfig_offs = ERRCONFIG_V2;
-		errconfig_mask = ERRCONFIG_VPBOUNDINTST_V2;
-	}
-
-	if (offset == errconfig_offs)
-		reg_val &= ~errconfig_mask;
+	if (offset == sr->errconfig_offs)
+		reg_val &= ~sr->errconfig_mask;
 
 	reg_val |= value;
 
@@ -118,16 +109,16 @@ static irqreturn_t sr_interrupt(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
-static void sr_set_clk_length(struct smartreflex *sr)
+static int sr_calculate_clk_length(struct smartreflex *sr)
 {
 	struct clk *fck;
-	int fck_rate;
+	int fck_rate, clk_length;
 
-	fck = clk_get(sr->pdev->dev, "fck");
+	fck = clk_get(&sr->pdev->dev, "fck");
 	if (IS_ERR(fck)) {
 		dev_err(&sr->pdev->dev, "%s: unable to get sys clk\n",
 			__func__);
-		return;
+		return 0;
 	}
 	fck_rate = clk_get_rate(fck);
 	clk_put(fck);
@@ -136,9 +127,12 @@ static void sr_set_clk_length(struct smartreflex *sr)
 	 * This formula is from OMAP34xx TRM Rev ZH Section 4.10.5.4.3
 	 * "SmartReflex Submodules"
 	 */
-	sr->clk_length = fck_rate / (2 * SR_CLK);
+	clk_length = fck_rate / (2 * SR_CLK);
+
+	dev_dbg(&sr->pdev->dev, "%s: SRCLKLENGTH = %03x\n",
+		__func__, clk_length);
 
-	dev_dbg(&sr->pdev->dev, "%s: SRCLKLENGTH = %03x\n", sr->clk_length);
+	return clk_length;
 }
 
 static void sr_start_vddautocomp(struct smartreflex *sr)
@@ -318,52 +312,28 @@ static struct omap_sr_nvalue_table *sr_retrieve_nvalue_row(
  */
 int sr_configure_errgen(struct smartreflex *sr)
 {
-	u32 sr_config, sr_errconfig, errconfig_offs, vpboundint_en;
-	u32 vpboundint_st, senp_en = 0, senn_en = 0;
-	u8 senp_shift, senn_shift;
+	u32 sr_config, sr_errconfig;
 
 	if (IS_ERR_OR_NULL(sr))
 		return -EINVAL;
 
-	if (!sr->clk_length)
-		sr_set_clk_length(sr);
-
-	senp_en = sr->senp_mod;
-	senn_en = sr->senn_mod;
-
-	sr_config = (sr->clk_length << SRCONFIG_SRCLKLENGTH_SHIFT) |
-		SRCONFIG_SENENABLE | SRCONFIG_ERRGEN_EN;
-
-	if (sr->ip_type == SR_TYPE_V1) {
-		sr_config |= SRCONFIG_DELAYCTRL;
-		senn_shift = SRCONFIG_SENNENABLE_V1_SHIFT;
-		senp_shift = SRCONFIG_SENPENABLE_V1_SHIFT;
-		errconfig_offs = ERRCONFIG_V1;
-		vpboundint_en = ERRCONFIG_VPBOUNDINTEN_V1;
-		vpboundint_st = ERRCONFIG_VPBOUNDINTST_V1;
-	} else if (sr->ip_type == SR_TYPE_V2) {
-		senn_shift = SRCONFIG_SENNENABLE_V2_SHIFT;
-		senp_shift = SRCONFIG_SENPENABLE_V2_SHIFT;
-		errconfig_offs = ERRCONFIG_V2;
-		vpboundint_en = ERRCONFIG_VPBOUNDINTEN_V2;
-		vpboundint_st = ERRCONFIG_VPBOUNDINTST_V2;
-	} else {
-		dev_err(&sr->pdev->dev, "%s: Trying to Configure smartreflex module without specifying the ip\n", __func__);
+	if (!sr_calculate_clk_length(sr))
 		return -EINVAL;
-	}
-
-	sr_config |= ((senn_en << senn_shift) | (senp_en << senp_shift));
+	
+	sr_config = sr->proto_sr_config;
+	sr_config |=  SRCONFIG_ERRGEN_EN;
 	sr_write_reg(sr, SRCONFIG, sr_config);
+
 	sr_errconfig = (sr->err_weight << ERRCONFIG_ERRWEIGHT_SHIFT) |
 		(sr->err_maxlimit << ERRCONFIG_ERRMAXLIMIT_SHIFT) |
 		(sr->err_minlimit <<  ERRCONFIG_ERRMINLIMIT_SHIFT);
-	sr_modify_reg(sr, errconfig_offs, (SR_ERRWEIGHT_MASK |
+	sr_modify_reg(sr, sr->errconfig_offs, (SR_ERRWEIGHT_MASK |
 		SR_ERRMAXLIMIT_MASK | SR_ERRMINLIMIT_MASK),
 		sr_errconfig);
 
 	/* Enabling the interrupts if the ERROR module is used */
-	sr_modify_reg(sr, errconfig_offs,
-		vpboundint_en, (vpboundint_en | vpboundint_st));
+	sr_modify_reg(sr, sr->errconfig_offs,
+		sr->vpboundint_en, (sr->vpboundint_en | sr->vpboundint_st));
 
 	return 0;
 }
@@ -383,36 +353,14 @@ int sr_configure_errgen(struct smartreflex *sr)
 int sr_configure_minmax(struct smartreflex *sr)
 {
 	u32 sr_config, sr_avgwt;
-	u32 senp_en = 0, senn_en = 0;
-	u8 senp_shift, senn_shift;
 
 	if (IS_ERR_OR_NULL(sr))
 		return -EINVAL;
 
-	if (!sr->clk_length)
-		sr_set_clk_length(sr);
-
-	senp_en = sr->senp_mod;
-	senn_en = sr->senn_mod;
-
-	sr_config = (sr->clk_length << SRCONFIG_SRCLKLENGTH_SHIFT) |
-		SRCONFIG_SENENABLE |
-		(sr->accum_data << SRCONFIG_ACCUMDATA_SHIFT);
-
-	if (sr->ip_type == SR_TYPE_V1) {
-		sr_config |= SRCONFIG_DELAYCTRL;
-		senn_shift = SRCONFIG_SENNENABLE_V1_SHIFT;
-		senp_shift = SRCONFIG_SENPENABLE_V1_SHIFT;
-	} else if (sr->ip_type == SR_TYPE_V2) {
-		senn_shift = SRCONFIG_SENNENABLE_V2_SHIFT;
-		senp_shift = SRCONFIG_SENPENABLE_V2_SHIFT;
-	} else {
-		dev_err(&sr->pdev->dev, "%s: Trying to Configure smartreflex module without specifying the ip\n", __func__);
-		return -EINVAL;
-	}
-
-	sr_config |= ((senn_en << senn_shift) | (senp_en << senp_shift));
+	sr_config = sr->proto_sr_config;
+	sr_config |= (sr->accum_data << SRCONFIG_ACCUMDATA_SHIFT);
 	sr_write_reg(sr, SRCONFIG, sr_config);
+
 	sr_avgwt = (sr->senp_avgweight << AVGWEIGHT_SENPAVGWEIGHT_SHIFT) |
 		(sr->senn_avgweight << AVGWEIGHT_SENNAVGWEIGHT_SHIFT);
 	sr_write_reg(sr, AVGWEIGHT, sr_avgwt);
@@ -719,15 +667,12 @@ static int __init omap_sr_probe(struct platform_device *pdev)
 	pdata->sr = sr;
 
 	sr->pdev = pdev;
-	sr->srid = pdev->id;
 	sr->voltdm = pdata->voltdm;
 	sr->data_count = pdata->data_count;
 	sr->err_weight = pdata->err_weight;
 	sr->err_maxlimit = pdata->err_maxlimit;
 	sr->accum_data = pdata->accum_data;
-	sr->senn_mod = pdata->senn_mod;
 	sr->senn_avgweight = pdata->senn_avgweight;
-	sr->senp_mod = pdata->senp_mod;
 	sr->senp_avgweight = pdata->senp_avgweight;
 	sr->autocomp_active = false;
 	sr->ip_type = pdata->ip_type;
@@ -741,7 +686,33 @@ static int __init omap_sr_probe(struct platform_device *pdev)
 	if (irq)
 		sr->irq = irq->start;
 
-	sr_set_clk_length(sr);
+	srclklength = sr_calculate_clk_length(sr);
+
+	sr->proto_sr_config = (srclklength << SRCONFIG_SRCLKLENGTH_SHIFT) |
+		SRCONFIG_SENENABLE;
+
+	if (sr->ip_type == SR_TYPE_V1) {
+		senn_shift = SRCONFIG_SENNENABLE_V1_SHIFT;
+		senp_shift = SRCONFIG_SENPENABLE_V1_SHIFT;
+		sr->proto_sr_config |= SRCONFIG_DELAYCTRL;
+		sr->errconfig_offs = ERRCONFIG_V1;
+		sr->errconfig_mask = ERRCONFIG_STATUS_V1_MASK;
+		sr->vpboundint_en = ERRCONFIG_VPBOUNDINTEN_V1;
+		sr->vpboundint_st = ERRCONFIG_VPBOUNDINTST_V1;
+	} else if (sr->ip_type == SR_TYPE_V2) {
+		senn_shift = SRCONFIG_SENNENABLE_V2_SHIFT;
+		senp_shift = SRCONFIG_SENPENABLE_V2_SHIFT;
+		sr->errconfig_offs = ERRCONFIG_V2;
+		sr->errconfig_mask = ERRCONFIG_VPBOUNDINTST_V2;
+		sr->vpboundint_en = ERRCONFIG_VPBOUNDINTEN_V2;
+		sr->vpboundint_st = ERRCONFIG_VPBOUNDINTST_V2;
+	} else {
+		dev_err(&sr->pdev->dev, "%s: Trying to Configure smartreflex module without specifying the ip\n", __func__);
+		return -EINVAL;
+	}
+
+	sr->proto_sr_config |= ((pdata->senn_mod << senn_shift) |
+				(pdata->senp_mod << senp_shift));
 
 	list_add(&sr->node, &sr_list);
 
diff --git a/arch/arm/mach-omap2/smartreflex.h b/arch/arm/mach-omap2/smartreflex.h
index e0e8ee3..6ed1381 100644
--- a/arch/arm/mach-omap2/smartreflex.h
+++ b/arch/arm/mach-omap2/smartreflex.h
@@ -137,19 +137,19 @@
 /* XXX kerneldoc documentation needed */
 struct smartreflex {
 	char				*name;
-	int				srid;
 	int				ip_type;
 	int				data_count;
 	bool				autocomp_active;
-	u32				clk_length;
 	u32				err_weight;
 	u32				err_minlimit;
 	u32				err_maxlimit;
 	u32				accum_data;
 	u32				senn_avgweight;
 	u32				senp_avgweight;
-	u32				senp_mod;
-	u32				senn_mod;
+	u32				errconfig_mask;
+	u32				vpboundint_en;
+	u32				vpboundint_st;
+	u32				proto_sr_config;
 	unsigned int			irq;
 	void __iomem			*base;
 	struct platform_device		*pdev;
@@ -157,6 +157,7 @@ struct smartreflex {
 	struct omap_sr_data_table	*data_table;
 	struct voltagedomain		*voltdm;
 	struct dentry			*dbg_dir;
+	u8				errconfig_offs;
 };
 
 /* XXX Kerneldoc documentation needed */
-- 
1.7.5.4

