From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: [PATCH 04/20] ARM: OMAP3+: SmartReflex Class3: disable errorgen before disable VP
Date: Wed,  1 Feb 2012 09:49:43 +0100
Message-ID: <1328086199-28486-5-git-send-email-j-pihet@ti.com>
References: <1328086199-28486-1-git-send-email-j-pihet@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:46589 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755308Ab2BAIuT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 1 Feb 2012 03:50:19 -0500
Received: by mail-ww0-f44.google.com with SMTP id dt10so1012846wgb.1
        for <linux-omap@vger.kernel.org>; Wed, 01 Feb 2012 00:50:18 -0800 (PST)
In-Reply-To: <1328086199-28486-1-git-send-email-j-pihet@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, balbi@ti.com, nm@ti.com
Cc: Kevin Hilman <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>, Jean Pihet <j-pihet@ti.com>

From: Nishanth Menon <nm@ti.com>

SmartReflex AVS Errorgen module supplies signals to Voltage
Processor. It is suggested that by disabling Errorgen module
before we disable VP, we might be able to ensure lesser
chances of race condition to occur in the system.

Signed-off-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Jean Pihet <j-pihet@ti.com>
---
 arch/arm/mach-omap2/smartreflex-class3.c |    1 +
 arch/arm/mach-omap2/smartreflex.c        |   44 ++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/smartreflex.h        |    1 +
 3 files changed, 46 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/smartreflex-class3.c b/arch/arm/mach-omap2/smartreflex-class3.c
index 53d9d0a..955566e 100644
--- a/arch/arm/mach-omap2/smartreflex-class3.c
+++ b/arch/arm/mach-omap2/smartreflex-class3.c
@@ -29,6 +29,7 @@ static int sr_class3_enable(struct voltagedomain *voltdm)
 
 static int sr_class3_disable(struct voltagedomain *voltdm, int is_volt_reset)
 {
+	sr_disable_errgen(voltdm);
 	omap_vp_disable(voltdm);
 	sr_disable(voltdm);
 	if (is_volt_reset)
diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/smartreflex.c
index ee224df..d7294c6 100644
--- a/arch/arm/mach-omap2/smartreflex.c
+++ b/arch/arm/mach-omap2/smartreflex.c
@@ -454,6 +454,50 @@ int sr_configure_errgen(struct voltagedomain *voltdm)
 }
 
 /**
+ * sr_disable_errgen() - Disables SmartReflex AVS module's errgen component
+ * @voltdm: voltagedomain pointer to which the SR module to be configured belongs to.
+ *
+ * This API is to be called from the smartreflex class driver to
+ * disable the error generator module inside the smartreflex module.
+ *
+ * Returns 0 on success and error value in case of failure.
+ */
+int sr_disable_errgen(struct voltagedomain *voltdm)
+{
+	u32 errconfig_offs, vpboundint_en;
+	u32 vpboundint_st;
+	struct omap_sr *sr = _sr_lookup(voltdm);
+
+	if (IS_ERR(sr)) {
+		pr_warning("%s: omap_sr struct for sr_%s not found\n",
+			__func__, voltdm->name);
+		return -EINVAL;
+	}
+
+	if (sr->ip_type == SR_TYPE_V1) {
+		errconfig_offs = ERRCONFIG_V1;
+		vpboundint_en = ERRCONFIG_VPBOUNDINTEN_V1;
+		vpboundint_st = ERRCONFIG_VPBOUNDINTST_V1;
+	} else if (sr->ip_type == SR_TYPE_V2) {
+		errconfig_offs = ERRCONFIG_V2;
+		vpboundint_en = ERRCONFIG_VPBOUNDINTEN_V2;
+		vpboundint_st = ERRCONFIG_VPBOUNDINTST_V2;
+	} else {
+		dev_err(&sr->pdev->dev, "%s: Trying to Configure smartreflex"
+			"module without specifying the ip\n", __func__);
+		return -EINVAL;
+	}
+
+	/* Disable the interrupts of ERROR module */
+	sr_modify_reg(sr, errconfig_offs, vpboundint_en | vpboundint_st, 0);
+
+	/* Disable the Sensor and errorgen */
+	sr_modify_reg(sr, SRCONFIG, SRCONFIG_SENENABLE | SRCONFIG_ERRGEN_EN, 0);
+
+	return 0;
+}
+
+/**
  * sr_configure_minmax() - Configures the smrtreflex to perform AVS using the
  *			 minmaxavg module.
  * @voltdm:	VDD pointer to which the SR module to be configured belongs to.
diff --git a/arch/arm/mach-omap2/smartreflex.h b/arch/arm/mach-omap2/smartreflex.h
index fd61498..5809141 100644
--- a/arch/arm/mach-omap2/smartreflex.h
+++ b/arch/arm/mach-omap2/smartreflex.h
@@ -240,6 +240,7 @@ void omap_sr_register_pmic(struct omap_sr_pmic_data *pmic_data);
 int sr_enable(struct voltagedomain *voltdm, unsigned long volt);
 void sr_disable(struct voltagedomain *voltdm);
 int sr_configure_errgen(struct voltagedomain *voltdm);
+int sr_disable_errgen(struct voltagedomain *voltdm);
 int sr_configure_minmax(struct voltagedomain *voltdm);
 
 /* API to register the smartreflex class driver with the smartreflex driver */
-- 
1.7.5.4

