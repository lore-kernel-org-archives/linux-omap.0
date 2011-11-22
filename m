From: jean.pihet@newoldbits.com
Subject: [PATCH 22/26] OMAP2+: SmartReflex: remove OMAP specific code
Date: Tue, 22 Nov 2011 16:06:06 +0100
Message-ID: <1321974370-25800-23-git-send-email-j-pihet@ti.com>
References: <1321974370-25800-1-git-send-email-j-pihet@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:43561 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757234Ab1KVPHb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 22 Nov 2011 10:07:31 -0500
Received: by mail-ww0-f44.google.com with SMTP id 5so432213wwe.1
        for <linux-omap@vger.kernel.org>; Tue, 22 Nov 2011 07:07:30 -0800 (PST)
In-Reply-To: <1321974370-25800-1-git-send-email-j-pihet@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, paul@pwsan.com, khilman@ti.com, balbi@ti.com, rjw@sisk.pl
Cc: Jean Pihet <j-pihet@ti.com>

From: Jean Pihet <j-pihet@ti.com>

In preparation for the generic driver implementation

Based on Paul's original code for the SmartReflex driver conversion.

Signed-off-by: Jean Pihet <j-pihet@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/smartreflex.c |   80 -------------------------------------
 arch/arm/mach-omap2/smartreflex.h |   10 -----
 2 files changed, 0 insertions(+), 90 deletions(-)

diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/smartreflex.c
index 0f03d80..947446f 100644
--- a/arch/arm/mach-omap2/smartreflex.c
+++ b/arch/arm/mach-omap2/smartreflex.c
@@ -507,86 +507,6 @@ int sr_register_class(struct smartreflex_class_data *class_data)
 	return 0;
 }
 
-/**
- * omap_sr_enable() -  API to enable SR clocks and to call into the
- *			registered smartreflex class enable API.
- * @sr: struct smartreflex *
- *
- * This API is to be called from the kernel in order to enable
- * a particular smartreflex module. This API will do the initial
- * configurations to turn on the smartreflex module and in turn call
- * into the registered smartreflex class enable API.
- */
-void omap_sr_enable(struct smartreflex *sr)
-{
-	if (IS_ERR_OR_NULL(sr))
-		return;
-
-	if (!sr->autocomp_active)
-		return;
-
-	if (!sr_class || !(sr_class->enable) || !(sr_class->configure)) {
-		dev_warn(&sr->pdev->dev, "%s: smartreflex class driver not registered\n", __func__);
-		return;
-	}
-
-	sr_class->enable(sr);
-}
-
-/**
- * omap_sr_disable() - API to disable SR without resetting the voltage
- *			processor voltage
- * @sr: struct smartreflex *
- *
- * This API is to be called from the kernel in order to disable
- * a particular smartreflex module. This API will in turn call
- * into the registered smartreflex class disable API. This API will tell
- * the smartreflex class disable not to reset the VP voltage after
- * disabling smartreflex.
- */
-void omap_sr_disable(struct smartreflex *sr)
-{
-	if (IS_ERR_OR_NULL(sr))
-		return;
-
-	if (!sr->autocomp_active)
-		return;
-
-	if (!sr_class || !(sr_class->disable)) {
-		dev_warn(&sr->pdev->dev, "%s: smartreflex class driver not registered\n", __func__);
-		return;
-	}
-
-	sr_class->disable(sr, 0);
-}
-
-/**
- * omap_sr_disable_reset_volt() - API to disable SR and reset the
- *				voltage processor voltage
- * @sr: struct smartreflex *
- *
- * This API is to be called from the kernel in order to disable
- * a particular smartreflex module. This API will in turn call
- * into the registered smartreflex class disable API. This API will tell
- * the smartreflex class disable to reset the VP voltage after
- * disabling smartreflex.
- */
-void omap_sr_disable_reset_volt(struct smartreflex *sr)
-{
-	if (IS_ERR_OR_NULL(sr))
-		return;
-
-	if (!sr->autocomp_active)
-		return;
-
-	if (!sr_class || !(sr_class->disable)) {
-		dev_warn(&sr->pdev->dev, "%s: smartreflex class driver not registered\n", __func__);
-		return;
-	}
-
-	sr_class->disable(sr, 1);
-}
-
 /* PM Debug Fs enteries to enable disable smartreflex. */
 static int omap_sr_autocomp_show(void *data, u64 *val)
 {
diff --git a/arch/arm/mach-omap2/smartreflex.h b/arch/arm/mach-omap2/smartreflex.h
index 7cd7f84..5c641a8 100644
--- a/arch/arm/mach-omap2/smartreflex.h
+++ b/arch/arm/mach-omap2/smartreflex.h
@@ -245,11 +245,6 @@ struct smartreflex_platform_data {
 	struct smartreflex		*sr;
 };
 
-/* Smartreflex module enable/disable interface */
-void omap_sr_enable(struct smartreflex *sr);
-void omap_sr_disable(struct smartreflex *sr);
-void omap_sr_disable_reset_volt(struct smartreflex *sr);
-
 /* Smartreflex driver hooks to be called from Smartreflex class driver */
 int sr_enable(struct smartreflex *sr, unsigned long volt);
 void sr_disable(struct smartreflex *sr);
@@ -258,10 +253,5 @@ int sr_configure_minmax(struct smartreflex *sr);
 
 /* API to register the smartreflex class driver with the smartreflex driver */
 int sr_register_class(struct smartreflex_class_data *class_data);
-#else
-static inline void omap_sr_enable(struct smartreflex *sr) {}
-static inline void omap_sr_disable(struct smartreflex *sr) {}
-static inline void omap_sr_disable_reset_volt(
-		struct smartreflex *sr) {}
 #endif
 #endif
-- 
1.7.5.4

