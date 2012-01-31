From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: [PATCH 17/19] ARM: OMAP3+: SmartReflex: misc cleanups
Date: Tue, 31 Jan 2012 10:58:30 +0100
Message-ID: <1328003912-11709-18-git-send-email-j-pihet@ti.com>
References: <1328003912-11709-1-git-send-email-j-pihet@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:32880 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753854Ab2AaJ7W (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 31 Jan 2012 04:59:22 -0500
Received: by mail-ww0-f44.google.com with SMTP id dt10so67497wgb.1
        for <linux-omap@vger.kernel.org>; Tue, 31 Jan 2012 01:59:21 -0800 (PST)
In-Reply-To: <1328003912-11709-1-git-send-email-j-pihet@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, balbi@ti.com, nm@ti.com
Cc: Kevin Hilman <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>, Jean Pihet <j-pihet@ti.com>

From: Felipe Balbi <balbi@ti.com>

There are no functional changes here, only misc cleanups in general:
- re-organize variable declarations,
- converting if {} else if {} else {} into switch statements,
- correct comments typos,
- add/remove white lines to improve readability,
- etc.

Signed-off-by: Felipe Balbi <balbi@ti.com>
Signed-off-by: Jean Pihet <j-pihet@ti.com>
---
 arch/arm/mach-omap2/smartreflex.c |  103 +++++++++++++++++++++++++-----------
 1 files changed, 71 insertions(+), 32 deletions(-)

diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/smartreflex.c
index c86880d..c2e3d6b 100644
--- a/arch/arm/mach-omap2/smartreflex.c
+++ b/arch/arm/mach-omap2/smartreflex.c
@@ -36,10 +36,18 @@
 #define SR_DISABLE_TIMEOUT	200
 
 struct omap_sr {
+	struct list_head		node;
+	struct platform_device		*pdev;
+	struct omap_sr_nvalue_table	*nvalue_table;
+	struct voltagedomain		*voltdm;
+	struct dentry			*dbg_dir;
+
+	unsigned int			irq;
+
 	int				srid;
 	int				ip_type;
 	int				nvalue_count;
-	bool				autocomp_active;
+
 	u32				clk_length;
 	u32				err_weight;
 	u32				err_minlimit;
@@ -49,16 +57,13 @@ struct omap_sr {
 	u32				senp_avgweight;
 	u32				senp_mod;
 	u32				senn_mod;
-	unsigned int			irq;
+
 	bool				irq_enabled;
+	bool				autocomp_active;
+
 	void __iomem			*base;
-	struct platform_device		*pdev;
-	struct list_head		node;
-	struct omap_sr_nvalue_table	*nvalue_table;
-	struct voltagedomain		*voltdm;
 	/* Managed by class driver as needed */
 	void				*voltdm_cdata;
-	struct dentry			*dbg_dir;
 };
 
 /* sr_list contains all the instances of smartreflex module */
@@ -190,11 +195,12 @@ static inline u8 irqstat_to_notifier_v2(u32 status)
 
 static irqreturn_t sr_interrupt(int irq, void *data)
 {
-	struct omap_sr *sr_info = (struct omap_sr *)data;
+	struct omap_sr *sr_info = data;
 	u32 status = 0;
 	u32 value = 0;
 
-	if (sr_info->ip_type == SR_TYPE_V1) {
+	switch (sr_info->ip_type) {
+	case SR_TYPE_V1:
 		/* Status bits are one bit before enable bits in v1 */
 		value = notifier_to_irqen_v1(sr_class->notify_flags) >> 1;
 
@@ -206,7 +212,8 @@ static irqreturn_t sr_interrupt(int irq, void *data)
 		sr_modify_reg(sr_info, ERRCONFIG_V1, value, status);
 
 		value = irqstat_to_notifier_v1(status);
-	} else if (sr_info->ip_type == SR_TYPE_V2) {
+		break;
+	case SR_TYPE_V2:
 		value = notifier_to_irqen_v2(sr_class->notify_flags);
 		/* Read the status bits */
 		status = sr_read_reg(sr_info, IRQSTATUS);
@@ -215,6 +222,11 @@ static irqreturn_t sr_interrupt(int irq, void *data)
 		/* Clear them by writing back */
 		sr_write_reg(sr_info, IRQSTATUS, status);
 		value = irqstat_to_notifier_v2(status);
+		break;
+	default:
+		dev_err(&sr_info->pdev->dev, "UNKNOWN IP type %d\n",
+			sr_info->ip_type);
+		return IRQ_NONE;
 	}
 
 	/* Attempt some resemblance of recovery! */
@@ -255,6 +267,7 @@ static void sr_set_clk_length(struct omap_sr *sr)
 			__func__);
 		return;
 	}
+
 	sys_clk_speed = clk_get_rate(sys_ck);
 	clk_put(sys_ck);
 
@@ -372,7 +385,7 @@ static int sr_late_init(struct omap_sr *sr_info)
 			goto error;
 		}
 		ret = request_irq(sr_info->irq, sr_interrupt,
-				0, name, (void *)sr_info);
+				0, name, sr_info);
 		if (ret)
 			goto error;
 		disable_irq(sr_info->irq);
@@ -393,6 +406,7 @@ error:
 		"not function as desired\n", __func__);
 	kfree(name);
 	kfree(sr_info);
+
 	return ret;
 }
 
@@ -513,8 +527,9 @@ static u32 sr_retrieve_nvalue(struct omap_sr *sr, u32 efuse_offs)
  */
 int sr_configure_errgen(struct voltagedomain *voltdm)
 {
-	u32 sr_config, sr_errconfig, errconfig_offs, vpboundint_en;
-	u32 vpboundint_st, senp_en = 0, senn_en = 0;
+	u32 sr_config, sr_errconfig, errconfig_offs;
+	u32 vpboundint_en, vpboundint_st;
+	u32 senp_en = 0, senn_en = 0;
 	u8 senp_shift, senn_shift;
 	struct omap_sr *sr = _sr_lookup(voltdm);
 
@@ -533,20 +548,23 @@ int sr_configure_errgen(struct voltagedomain *voltdm)
 	sr_config = (sr->clk_length << SRCONFIG_SRCLKLENGTH_SHIFT) |
 		SRCONFIG_SENENABLE | SRCONFIG_ERRGEN_EN;
 
-	if (sr->ip_type == SR_TYPE_V1) {
+	switch (sr->ip_type) {
+	case SR_TYPE_V1:
 		sr_config |= SRCONFIG_DELAYCTRL;
 		senn_shift = SRCONFIG_SENNENABLE_V1_SHIFT;
 		senp_shift = SRCONFIG_SENPENABLE_V1_SHIFT;
 		errconfig_offs = ERRCONFIG_V1;
 		vpboundint_en = ERRCONFIG_VPBOUNDINTEN_V1;
 		vpboundint_st = ERRCONFIG_VPBOUNDINTST_V1;
-	} else if (sr->ip_type == SR_TYPE_V2) {
+		break;
+	case SR_TYPE_V2:
 		senn_shift = SRCONFIG_SENNENABLE_V2_SHIFT;
 		senp_shift = SRCONFIG_SENPENABLE_V2_SHIFT;
 		errconfig_offs = ERRCONFIG_V2;
 		vpboundint_en = ERRCONFIG_VPBOUNDINTEN_V2;
 		vpboundint_st = ERRCONFIG_VPBOUNDINTST_V2;
-	} else {
+		break;
+	default:
 		dev_err(&sr->pdev->dev, "%s: Trying to Configure smartreflex"
 			"module without specifying the ip\n", __func__);
 		return -EINVAL;
@@ -579,8 +597,8 @@ int sr_configure_errgen(struct voltagedomain *voltdm)
  */
 int sr_disable_errgen(struct voltagedomain *voltdm)
 {
-	u32 errconfig_offs, vpboundint_en;
-	u32 vpboundint_st;
+	u32 errconfig_offs;
+	u32 vpboundint_en, vpboundint_st;
 	struct omap_sr *sr = _sr_lookup(voltdm);
 
 	if (IS_ERR(sr)) {
@@ -589,15 +607,18 @@ int sr_disable_errgen(struct voltagedomain *voltdm)
 		return -EINVAL;
 	}
 
-	if (sr->ip_type == SR_TYPE_V1) {
+	switch (sr->ip_type) {
+	case SR_TYPE_V1:
 		errconfig_offs = ERRCONFIG_V1;
 		vpboundint_en = ERRCONFIG_VPBOUNDINTEN_V1;
 		vpboundint_st = ERRCONFIG_VPBOUNDINTST_V1;
-	} else if (sr->ip_type == SR_TYPE_V2) {
+		break;
+	case SR_TYPE_V2:
 		errconfig_offs = ERRCONFIG_V2;
 		vpboundint_en = ERRCONFIG_VPBOUNDINTEN_V2;
 		vpboundint_st = ERRCONFIG_VPBOUNDINTST_V2;
-	} else {
+		break;
+	default:
 		dev_err(&sr->pdev->dev, "%s: Trying to Configure smartreflex"
 			"module without specifying the ip\n", __func__);
 		return -EINVAL;
@@ -647,14 +668,17 @@ int sr_configure_minmax(struct voltagedomain *voltdm)
 		SRCONFIG_SENENABLE |
 		(sr->accum_data << SRCONFIG_ACCUMDATA_SHIFT);
 
-	if (sr->ip_type == SR_TYPE_V1) {
+	switch (sr->ip_type) {
+	case SR_TYPE_V1:
 		sr_config |= SRCONFIG_DELAYCTRL;
 		senn_shift = SRCONFIG_SENNENABLE_V1_SHIFT;
 		senp_shift = SRCONFIG_SENPENABLE_V1_SHIFT;
-	} else if (sr->ip_type == SR_TYPE_V2) {
+		break;
+	case SR_TYPE_V2:
 		senn_shift = SRCONFIG_SENNENABLE_V2_SHIFT;
 		senp_shift = SRCONFIG_SENPENABLE_V2_SHIFT;
-	} else {
+		break;
+	default:
 		dev_err(&sr->pdev->dev, "%s: Trying to Configure smartreflex"
 			"module without specifying the ip\n", __func__);
 		return -EINVAL;
@@ -670,20 +694,27 @@ int sr_configure_minmax(struct voltagedomain *voltdm)
 	 * Enabling the interrupts if MINMAXAVG module is used.
 	 * TODO: check if all the interrupts are mandatory
 	 */
-	if (sr->ip_type == SR_TYPE_V1) {
+	switch (sr->ip_type) {
+	case SR_TYPE_V1:
 		sr_modify_reg(sr, ERRCONFIG_V1,
 			(ERRCONFIG_MCUACCUMINTEN | ERRCONFIG_MCUVALIDINTEN |
 			ERRCONFIG_MCUBOUNDINTEN),
 			(ERRCONFIG_MCUACCUMINTEN | ERRCONFIG_MCUACCUMINTST |
 			 ERRCONFIG_MCUVALIDINTEN | ERRCONFIG_MCUVALIDINTST |
 			 ERRCONFIG_MCUBOUNDINTEN | ERRCONFIG_MCUBOUNDINTST));
-	} else if (sr->ip_type == SR_TYPE_V2) {
+		break;
+	case SR_TYPE_V2:
 		sr_write_reg(sr, IRQSTATUS,
 			IRQSTATUS_MCUACCUMINT | IRQSTATUS_MCVALIDINT |
 			IRQSTATUS_MCBOUNDSINT | IRQSTATUS_MCUDISABLEACKINT);
 		sr_write_reg(sr, IRQENABLE_SET,
 			IRQENABLE_MCUACCUMINT | IRQENABLE_MCUVALIDINT |
 			IRQENABLE_MCUBOUNDSINT | IRQENABLE_MCUDISABLEACKINT);
+		break;
+	default:
+		dev_err(&sr->pdev->dev, "%s: Trying to Configure smartreflex"
+			"module without specifying the ip\n", __func__);
+		return -EINVAL;
 	}
 
 	return 0;
@@ -702,9 +733,9 @@ int sr_configure_minmax(struct voltagedomain *voltdm)
  */
 int sr_enable(struct voltagedomain *voltdm, unsigned long volt)
 {
-	u32 nvalue_reciprocal;
 	struct omap_volt_data *volt_data;
 	struct omap_sr *sr = _sr_lookup(voltdm);
+	u32 nvalue_reciprocal;
 	int ret;
 
 	if (IS_ERR(sr)) {
@@ -776,10 +807,17 @@ void sr_disable(struct voltagedomain *voltdm)
 	 * disable the clocks.
 	 */
 	if (sr_read_reg(sr, SRCONFIG) & SRCONFIG_SRENABLE) {
-		if (sr->ip_type == SR_TYPE_V1)
+		switch (sr->ip_type) {
+		case SR_TYPE_V1:
 			sr_v1_disable(sr);
-		else if (sr->ip_type == SR_TYPE_V2)
+			break;
+		case SR_TYPE_V2:
 			sr_v2_disable(sr);
+			break;
+		default:
+			dev_err(&sr->pdev->dev, "UNKNOWN IP type %d\n",
+				sr->ip_type);
+		}
 	}
 
 	pm_runtime_put_sync_suspend(&sr->pdev->dev);
@@ -1002,7 +1040,7 @@ void omap_sr_register_pmic(struct omap_sr_pmic_data *pmic_data)
 	sr_pmic_data = pmic_data;
 }
 
-/* PM Debug Fs enteries to enable disable smartreflex. */
+/* PM Debug Fs enteries to enable and disable smartreflex. */
 static int omap_sr_autocomp_show(void *data, u64 *val)
 {
 	struct omap_sr *sr_info = (struct omap_sr *) data;
@@ -1044,11 +1082,11 @@ static int omap_sr_autocomp_store(void *data, u64 val)
 }
 
 DEFINE_SIMPLE_ATTRIBUTE(pm_sr_fops, omap_sr_autocomp_show,
-		omap_sr_autocomp_store, "%llu\n");
+			omap_sr_autocomp_store, "%llu\n");
 
 static int __init omap_sr_probe(struct platform_device *pdev)
 {
-	struct omap_sr *sr_info = kzalloc(sizeof(struct omap_sr), GFP_KERNEL);
+	struct omap_sr *sr_info;
 	struct omap_sr_data *pdata = pdev->dev.platform_data;
 	struct resource *mem, *irq;
 	struct dentry *nvalue_dir;
@@ -1056,6 +1094,7 @@ static int __init omap_sr_probe(struct platform_device *pdev)
 	int i, ret = 0;
 	char *name;
 
+	sr_info = kzalloc(sizeof(struct omap_sr), GFP_KERNEL);
 	if (!sr_info) {
 		dev_err(&pdev->dev, "%s: unable to allocate sr_info\n",
 			__func__);
-- 
1.7.5.4

