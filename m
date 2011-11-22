From: jean.pihet@newoldbits.com
Subject: [PATCH 02/26] OMAP3/4: SmartReflex: class drivers should use struct omap_sr *
Date: Tue, 22 Nov 2011 16:05:46 +0100
Message-ID: <1321974370-25800-3-git-send-email-j-pihet@ti.com>
References: <1321974370-25800-1-git-send-email-j-pihet@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:38321 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753952Ab1KVPGw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 22 Nov 2011 10:06:52 -0500
Received: by mail-fx0-f46.google.com with SMTP id n18so497590fag.19
        for <linux-omap@vger.kernel.org>; Tue, 22 Nov 2011 07:06:51 -0800 (PST)
In-Reply-To: <1321974370-25800-1-git-send-email-j-pihet@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, paul@pwsan.com, khilman@ti.com, balbi@ti.com, rjw@sisk.pl
Cc: Jean Pihet <j-pihet@ti.com>, Thara Gopinath <thara@ti.com>, Nishanth Menon <nm@ti.com>

From: Jean Pihet <j-pihet@ti.com>

Convert SmartReflex "class" functions to take a struct omap_sr *, rather than
a struct voltagedomain *.  SmartReflex code should be driver code and not
tightly coupled to OMAP subarchitecture-specific structures.

Based on Paul's original code for the SmartReflex driver conversion.

Signed-off-by: Jean Pihet <j-pihet@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Thara Gopinath <thara@ti.com>
Cc: Nishanth Menon <nm@ti.com>
Cc: Kevin Hilman <khilman@ti.com>
---
 arch/arm/mach-omap2/smartreflex-class3.c |   22 +++++++++---------
 arch/arm/mach-omap2/smartreflex.c        |   37 +++++------------------------
 arch/arm/mach-omap2/smartreflex.h        |   32 ++++++++++++++++++++++---
 3 files changed, 46 insertions(+), 45 deletions(-)

diff --git a/arch/arm/mach-omap2/smartreflex-class3.c b/arch/arm/mach-omap2/smartreflex-class3.c
index 53d9d0a..97bdb0b 100644
--- a/arch/arm/mach-omap2/smartreflex-class3.c
+++ b/arch/arm/mach-omap2/smartreflex-class3.c
@@ -13,33 +13,33 @@
 
 #include "smartreflex.h"
 
-static int sr_class3_enable(struct voltagedomain *voltdm)
+static int sr_class3_enable(struct omap_sr *sr)
 {
-	unsigned long volt = voltdm_get_voltage(voltdm);
+	unsigned long volt = voltdm_get_voltage(sr->voltdm);
 
 	if (!volt) {
 		pr_warning("%s: Curr voltage unknown. Cannot enable sr_%s\n",
-				__func__, voltdm->name);
+				__func__, sr->voltdm->name);
 		return -ENODATA;
 	}
 
-	omap_vp_enable(voltdm);
-	return sr_enable(voltdm, volt);
+	omap_vp_enable(sr->voltdm);
+	return sr_enable(sr->voltdm, volt);
 }
 
-static int sr_class3_disable(struct voltagedomain *voltdm, int is_volt_reset)
+static int sr_class3_disable(struct omap_sr *sr, int is_volt_reset)
 {
-	omap_vp_disable(voltdm);
-	sr_disable(voltdm);
+	omap_vp_disable(sr->voltdm);
+	sr_disable(sr->voltdm);
 	if (is_volt_reset)
-		voltdm_reset(voltdm);
+		voltdm_reset(sr->voltdm);
 
 	return 0;
 }
 
-static int sr_class3_configure(struct voltagedomain *voltdm)
+static int sr_class3_configure(struct omap_sr *sr)
 {
-	return sr_configure_errgen(voltdm);
+	return sr_configure_errgen(sr->voltdm);
 }
 
 /* SR class3 structure */
diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/smartreflex.c
index cf246b3..01ff78a 100644
--- a/arch/arm/mach-omap2/smartreflex.c
+++ b/arch/arm/mach-omap2/smartreflex.c
@@ -35,29 +35,6 @@
 #define NVALUE_NAME_LEN		40
 #define SR_DISABLE_TIMEOUT	200
 
-struct omap_sr {
-	int				srid;
-	int				ip_type;
-	int				nvalue_count;
-	bool				autocomp_active;
-	u32				clk_length;
-	u32				err_weight;
-	u32				err_minlimit;
-	u32				err_maxlimit;
-	u32				accum_data;
-	u32				senn_avgweight;
-	u32				senp_avgweight;
-	u32				senp_mod;
-	u32				senn_mod;
-	unsigned int			irq;
-	void __iomem			*base;
-	struct platform_device		*pdev;
-	struct list_head		node;
-	struct omap_sr_nvalue_table	*nvalue_table;
-	struct voltagedomain		*voltdm;
-	struct dentry			*dbg_dir;
-};
-
 /* sr_list contains all the instances of smartreflex module */
 static LIST_HEAD(sr_list);
 
@@ -146,7 +123,7 @@ static irqreturn_t sr_interrupt(int irq, void *data)
 	}
 
 	if (sr_class->notify)
-		sr_class->notify(sr_info->voltdm, status);
+		sr_class->notify(sr_info, status);
 
 	return IRQ_HANDLED;
 }
@@ -223,7 +200,7 @@ static void sr_start_vddautocomp(struct omap_sr *sr)
 		return;
 	}
 
-	if (!sr_class->enable(sr->voltdm))
+	if (!sr_class->enable(sr))
 		sr->autocomp_active = true;
 }
 
@@ -237,7 +214,7 @@ static void sr_stop_vddautocomp(struct omap_sr *sr)
 	}
 
 	if (sr->autocomp_active) {
-		sr_class->disable(sr->voltdm, 1);
+		sr_class->disable(sr, 1);
 		sr->autocomp_active = false;
 	}
 }
@@ -580,7 +557,7 @@ int sr_enable(struct voltagedomain *voltdm, unsigned long volt)
 		return 0;
 
 	/* Configure SR */
-	ret = sr_class->configure(voltdm);
+	ret = sr_class->configure(sr);
 	if (ret)
 		return ret;
 
@@ -691,7 +668,7 @@ void omap_sr_enable(struct voltagedomain *voltdm)
 		return;
 	}
 
-	sr_class->enable(voltdm);
+	sr_class->enable(sr);
 }
 
 /**
@@ -724,7 +701,7 @@ void omap_sr_disable(struct voltagedomain *voltdm)
 		return;
 	}
 
-	sr_class->disable(voltdm, 0);
+	sr_class->disable(sr, 0);
 }
 
 /**
@@ -757,7 +734,7 @@ void omap_sr_disable_reset_volt(struct voltagedomain *voltdm)
 		return;
 	}
 
-	sr_class->disable(voltdm, 1);
+	sr_class->disable(sr, 1);
 }
 
 /**
diff --git a/arch/arm/mach-omap2/smartreflex.h b/arch/arm/mach-omap2/smartreflex.h
index 5f35b9e..f435972 100644
--- a/arch/arm/mach-omap2/smartreflex.h
+++ b/arch/arm/mach-omap2/smartreflex.h
@@ -142,6 +142,30 @@
 #define OMAP3430_SR_ERRWEIGHT		0x04
 #define OMAP3430_SR_ERRMAXLIMIT		0x02
 
+/* XXX kerneldoc documentation needed */
+struct omap_sr {
+	int				srid;
+	int				ip_type;
+	int				nvalue_count;
+	bool				autocomp_active;
+	u32				clk_length;
+	u32				err_weight;
+	u32				err_minlimit;
+	u32				err_maxlimit;
+	u32				accum_data;
+	u32				senn_avgweight;
+	u32				senp_avgweight;
+	u32				senp_mod;
+	u32				senn_mod;
+	unsigned int			irq;
+	void __iomem			*base;
+	struct platform_device		*pdev;
+	struct list_head		node;
+	struct omap_sr_nvalue_table	*nvalue_table;
+	struct voltagedomain		*voltdm;
+	struct dentry			*dbg_dir;
+};
+
 /**
  * struct omap_sr_pmic_data - Strucutre to be populated by pmic code to pass
  *				pmic specific info to smartreflex driver
@@ -177,10 +201,10 @@ struct omap_sr_pmic_data {
  *			based decisions.
  */
 struct omap_sr_class_data {
-	int (*enable)(struct voltagedomain *voltdm);
-	int (*disable)(struct voltagedomain *voltdm, int is_volt_reset);
-	int (*configure)(struct voltagedomain *voltdm);
-	int (*notify)(struct voltagedomain *voltdm, u32 status);
+	int (*enable)(struct omap_sr *sr);
+	int (*disable)(struct omap_sr *sr, int is_volt_reset);
+	int (*configure)(struct omap_sr *sr);
+	int (*notify)(struct omap_sr *sr, u32 status);
 	u8 notify_flags;
 	u8 class_type;
 };
-- 
1.7.5.4

