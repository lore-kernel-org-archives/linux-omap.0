From: jean.pihet@newoldbits.com
Subject: [PATCH 5/6] ARM: OMAP3+: SmartReflex: introduce class private data per voltage domain
Date: Tue, 13 Mar 2012 11:26:20 +0100
Message-ID: <1331634381-31436-6-git-send-email-j-pihet@ti.com>
References: <1331634381-31436-1-git-send-email-j-pihet@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:59492 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030335Ab2CMK0y (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 13 Mar 2012 06:26:54 -0400
Received: by mail-we0-f174.google.com with SMTP id x9so335358wej.19
        for <linux-omap@vger.kernel.org>; Tue, 13 Mar 2012 03:26:54 -0700 (PDT)
In-Reply-To: <1331634381-31436-1-git-send-email-j-pihet@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Kevin Hilman <khilman@ti.com>
Cc: Nishanth Menon <nm@ti.com>, Jean Pihet <j-pihet@ti.com>

From: Nishanth Menon <nm@ti.com>

Introduce private data for class drivers to operate on per
voltage domain. This removes the necessity for drivers such
as SmartReflex AVS Class 1.5 drivers from maintaining
a special lookup table which does not scale when number of
voltage domains change depending on silicon. It also makes
the life of such class drivers to be faster without having
to do a double lookup to get to their voltage domain specific
private data

Signed-off-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Jean Pihet <j-pihet@ti.com>
---
 arch/arm/mach-omap2/smartreflex-class3.c |   10 +++++++---
 arch/arm/mach-omap2/smartreflex.c        |   23 +++++++++++++----------
 arch/arm/mach-omap2/smartreflex.h        |   16 ++++++++++------
 3 files changed, 30 insertions(+), 19 deletions(-)

diff --git a/arch/arm/mach-omap2/smartreflex-class3.c b/arch/arm/mach-omap2/smartreflex-class3.c
index 955566e..9dcda93 100644
--- a/arch/arm/mach-omap2/smartreflex-class3.c
+++ b/arch/arm/mach-omap2/smartreflex-class3.c
@@ -13,7 +13,8 @@
 
 #include "smartreflex.h"
 
-static int sr_class3_enable(struct voltagedomain *voltdm)
+static int sr_class3_enable(struct voltagedomain *voltdm,
+			    void *voltdm_cdata)
 {
 	unsigned long volt = voltdm_get_voltage(voltdm);
 
@@ -27,7 +28,9 @@ static int sr_class3_enable(struct voltagedomain *voltdm)
 	return sr_enable(voltdm, volt);
 }
 
-static int sr_class3_disable(struct voltagedomain *voltdm, int is_volt_reset)
+static int sr_class3_disable(struct voltagedomain *voltdm,
+			     void *voltdm_cdata,
+			     int is_volt_reset)
 {
 	sr_disable_errgen(voltdm);
 	omap_vp_disable(voltdm);
@@ -38,7 +41,8 @@ static int sr_class3_disable(struct voltagedomain *voltdm, int is_volt_reset)
 	return 0;
 }
 
-static int sr_class3_configure(struct voltagedomain *voltdm)
+static int sr_class3_configure(struct voltagedomain *voltdm,
+			       void *voltdm_cdata)
 {
 	return sr_configure_errgen(voltdm);
 }
diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/smartreflex.c
index 8a10c0a..c351af6 100644
--- a/arch/arm/mach-omap2/smartreflex.c
+++ b/arch/arm/mach-omap2/smartreflex.c
@@ -40,6 +40,8 @@ struct omap_sr {
 	struct platform_device		*pdev;
 	struct omap_sr_nvalue_table	*nvalue_table;
 	struct voltagedomain		*voltdm;
+	/* Managed by class driver as needed */
+	void				*voltdm_cdata;
 	struct dentry			*dbg_dir;
 	unsigned int			irq;
 	int				srid;
@@ -232,8 +234,8 @@ static irqreturn_t sr_interrupt(int irq, void *data)
 		sr_info->irq_enabled = false;
 	} else {
 		/* If the caller reports inability to handle, disable as well */
-		if (sr_class->notify &&
-		    sr_class->notify(sr_info->voltdm, value)) {
+		if (sr_class->notify && sr_class->notify(sr_info->voltdm,
+						sr_info->voltdm_cdata, value)) {
 			dev_err(&sr_info->pdev->dev, "%s: Callback cant handle!"
 				"status=0x%08x. Disabling to prevent spam!!\n",
 				__func__, status);
@@ -320,13 +322,14 @@ static void sr_start_vddautocomp(struct omap_sr *sr)
 	}
 
 	if (sr_class->init &&
-	    sr_class->init(sr->voltdm, sr_class->class_priv_data)) {
+	    sr_class->init(sr->voltdm, &sr->voltdm_cdata,
+			   sr_class->class_priv_data)) {
 		dev_err(&sr->pdev->dev,
 			"%s: SRClass initialization failed\n", __func__);
 		return;
 	}
 
-	if (!sr_class->enable(sr->voltdm))
+	if (!sr_class->enable(sr->voltdm, sr->voltdm_cdata))
 		sr->autocomp_active = true;
 }
 
@@ -340,9 +343,9 @@ static void sr_stop_vddautocomp(struct omap_sr *sr)
 	}
 
 	if (sr->autocomp_active) {
-		sr_class->disable(sr->voltdm, 1);
+		sr_class->disable(sr->voltdm, sr->voltdm_cdata, 1);
 		if (sr_class->deinit &&
-		    sr_class->deinit(sr->voltdm,
+		    sr_class->deinit(sr->voltdm, &sr->voltdm_cdata,
 			    sr_class->class_priv_data)) {
 			dev_err(&sr->pdev->dev,
 				"%s: SR[%d]Class deinitialization failed\n",
@@ -763,7 +766,7 @@ int sr_enable(struct voltagedomain *voltdm, unsigned long volt)
 		return 0;
 
 	/* Configure SR */
-	ret = sr_class->configure(voltdm);
+	ret = sr_class->configure(voltdm, sr->voltdm_cdata);
 	if (ret)
 		return ret;
 
@@ -945,7 +948,7 @@ void omap_sr_enable(struct voltagedomain *voltdm)
 		return;
 	}
 
-	sr_class->enable(voltdm);
+	sr_class->enable(voltdm, sr->voltdm_cdata);
 }
 
 /**
@@ -978,7 +981,7 @@ void omap_sr_disable(struct voltagedomain *voltdm)
 		return;
 	}
 
-	sr_class->disable(voltdm, 0);
+	sr_class->disable(voltdm, sr->voltdm_cdata, 0);
 }
 
 /**
@@ -1011,7 +1014,7 @@ void omap_sr_disable_reset_volt(struct voltagedomain *voltdm)
 		return;
 	}
 
-	sr_class->disable(voltdm, 1);
+	sr_class->disable(voltdm, sr->voltdm_cdata, 1);
 }
 
 /**
diff --git a/arch/arm/mach-omap2/smartreflex.h b/arch/arm/mach-omap2/smartreflex.h
index 2b0ef0e..1fbafe7 100644
--- a/arch/arm/mach-omap2/smartreflex.h
+++ b/arch/arm/mach-omap2/smartreflex.h
@@ -195,12 +195,16 @@ struct omap_smartreflex_dev_attr {
  * @class_priv_data:	Class specific private data (optional)
  */
 struct omap_sr_class_data {
-	int (*enable)(struct voltagedomain *voltdm);
-	int (*disable)(struct voltagedomain *voltdm, int is_volt_reset);
-	int (*init)(struct voltagedomain *voltdm, void *class_priv_data);
-	int (*deinit)(struct voltagedomain *voltdm, void *class_priv_data);
-	int (*configure)(struct voltagedomain *voltdm);
-	int (*notify)(struct voltagedomain *voltdm, u32 status);
+	int (*enable)(struct voltagedomain *voltdm, void *voltdm_cdata);
+	int (*disable)(struct voltagedomain *voltdm, void *voltdm_cdata,
+		       int is_volt_reset);
+	int (*init)(struct voltagedomain *voltdm, void **voltdm_cdata,
+		    void *class_priv_data);
+	int (*deinit)(struct voltagedomain *voltdm, void **voltdm_cdata,
+		      void *class_priv_data);
+	int (*configure)(struct voltagedomain *voltdm, void *voltdm_cdata);
+	int (*notify)(struct voltagedomain *voltdm, void *voltdm_cdata,
+		      u32 status);
 	u8 notify_flags;
 	u8 class_type;
 	void *class_priv_data;
-- 
1.7.5.4

