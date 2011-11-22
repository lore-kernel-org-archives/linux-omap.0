From: jean.pihet@newoldbits.com
Subject: [PATCH 11/26] OMAP3+: SmartReflex: remove unused PMIC code
Date: Tue, 22 Nov 2011 16:05:55 +0100
Message-ID: <1321974370-25800-12-git-send-email-j-pihet@ti.com>
References: <1321974370-25800-1-git-send-email-j-pihet@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:48485 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757061Ab1KVPHJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 22 Nov 2011 10:07:09 -0500
Received: by mail-ey0-f174.google.com with SMTP id 27so270729eye.19
        for <linux-omap@vger.kernel.org>; Tue, 22 Nov 2011 07:07:09 -0800 (PST)
In-Reply-To: <1321974370-25800-1-git-send-email-j-pihet@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, paul@pwsan.com, khilman@ti.com, balbi@ti.com, rjw@sisk.pl
Cc: Jean Pihet <j-pihet@ti.com>

From: Paul Walmsley <paul@pwsan.com>

The code can be added it back in when it actually does something.

Based on Paul's original code for the SmartReflex driver conversion.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Jean Pihet <j-pihet@ti.com>
---
 arch/arm/mach-omap2/smartreflex.c |   31 -------------------------------
 arch/arm/mach-omap2/smartreflex.h |   15 ---------------
 2 files changed, 0 insertions(+), 46 deletions(-)

diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/smartreflex.c
index 3b10245..86f2bf2 100644
--- a/arch/arm/mach-omap2/smartreflex.c
+++ b/arch/arm/mach-omap2/smartreflex.c
@@ -38,7 +38,6 @@
 static LIST_HEAD(sr_list);
 
 static struct smartreflex_class_data *sr_class;
-static struct omap_sr_pmic_data *sr_pmic_data;
 static struct dentry		*sr_dbg_dir;
 
 static inline void sr_write_reg(struct smartreflex *sr, unsigned offset, u32 value)
@@ -665,25 +664,6 @@ void omap_sr_disable_reset_volt(struct smartreflex *sr)
 	sr_class->disable(sr, 1);
 }
 
-/**
- * omap_sr_register_pmic() - API to register pmic specific info.
- * @pmic_data:	The structure containing pmic specific data.
- *
- * This API is to be called from the PMIC specific code to register with
- * smartreflex driver pmic specific info. Currently the only info required
- * is the smartreflex init on the PMIC side.
- */
-void omap_sr_register_pmic(struct omap_sr_pmic_data *pmic_data)
-{
-	if (!pmic_data) {
-		pr_warning("%s: Trying to register NULL PMIC data structure"
-			"with smartreflex\n", __func__);
-		return;
-	}
-
-	sr_pmic_data = pmic_data;
-}
-
 /* PM Debug Fs enteries to enable disable smartreflex. */
 static int omap_sr_autocomp_show(void *data, u64 *val)
 {
@@ -933,17 +913,6 @@ static int __init sr_init(void)
 {
 	int ret = 0;
 
-	/*
-	 * sr_init is a late init. If by then a pmic specific API is not
-	 * registered either there is no need for anything to be done on
-	 * the PMIC side or somebody has forgotten to register a PMIC
-	 * handler. Warn for the second condition.
-	 */
-	if (sr_pmic_data && sr_pmic_data->sr_pmic_init)
-		sr_pmic_data->sr_pmic_init();
-	else
-		pr_warning("%s: No PMIC hook to init smartreflex\n", __func__);
-
 	ret = platform_driver_probe(&smartreflex_driver, omap_sr_probe);
 	if (ret) {
 		pr_err("%s: platform driver register failed for SR\n",
diff --git a/arch/arm/mach-omap2/smartreflex.h b/arch/arm/mach-omap2/smartreflex.h
index 0573995..0ebcec0 100644
--- a/arch/arm/mach-omap2/smartreflex.h
+++ b/arch/arm/mach-omap2/smartreflex.h
@@ -166,16 +166,6 @@ struct smartreflex {
 	struct dentry			*dbg_dir;
 };
 
-/**
- * struct omap_sr_pmic_data - Strucutre to be populated by pmic code to pass
- *				pmic specific info to smartreflex driver
- *
- * @sr_pmic_init:	API to initialize smartreflex on the PMIC side.
- */
-struct omap_sr_pmic_data {
-	void (*sr_pmic_init) (void);
-};
-
 /* XXX Kerneldoc documentation needed */
 struct omap_sr_dev_attr {
 	char *sensor_voltdm_name; /* XXX should be const */
@@ -272,9 +262,6 @@ void omap_sr_enable(struct smartreflex *sr);
 void omap_sr_disable(struct smartreflex *sr);
 void omap_sr_disable_reset_volt(struct smartreflex *sr);
 
-/* API to register the pmic specific data with the smartreflex driver. */
-void omap_sr_register_pmic(struct omap_sr_pmic_data *pmic_data);
-
 /* Smartreflex driver hooks to be called from Smartreflex class driver */
 int sr_enable(struct smartreflex *sr, unsigned long volt);
 void sr_disable(struct smartreflex *sr);
@@ -288,7 +275,5 @@ static inline void omap_sr_enable(struct smartreflex *sr) {}
 static inline void omap_sr_disable(struct smartreflex *sr) {}
 static inline void omap_sr_disable_reset_volt(
 		struct smartreflex *sr) {}
-static inline void omap_sr_register_pmic(
-		struct omap_sr_pmic_data *pmic_data) {}
 #endif
 #endif
-- 
1.7.5.4

