From: Eduardo Valentin <eduardo.valentin@nokia.com>
Subject: [PATCH 10/20] OMAP: McBSP: Rename thres sysfs symbols
Date: Thu, 30 Jul 2009 15:49:33 +0300
Message-ID: <1248958183-15015-11-git-send-email-eduardo.valentin@nokia.com>
References: <1248958183-15015-1-git-send-email-eduardo.valentin@nokia.com>
 <1248958183-15015-2-git-send-email-eduardo.valentin@nokia.com>
 <1248958183-15015-3-git-send-email-eduardo.valentin@nokia.com>
 <1248958183-15015-4-git-send-email-eduardo.valentin@nokia.com>
 <1248958183-15015-5-git-send-email-eduardo.valentin@nokia.com>
 <1248958183-15015-6-git-send-email-eduardo.valentin@nokia.com>
 <1248958183-15015-7-git-send-email-eduardo.valentin@nokia.com>
 <1248958183-15015-8-git-send-email-eduardo.valentin@nokia.com>
 <1248958183-15015-9-git-send-email-eduardo.valentin@nokia.com>
 <1248958183-15015-10-git-send-email-eduardo.valentin@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:35091 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751275AbZG3NBJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 30 Jul 2009 09:01:09 -0400
In-Reply-To: <1248958183-15015-10-git-send-email-eduardo.valentin@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, alsa-devel@vger.kernel.org
Cc: Jarkko Nikula <jhnikula@gmail.com>, "Nurkkala Eero.An (EXT-Offcode/Oulu)" <ext-Eero.Nurkkala@nokia.com>, Peter Ujfalusi <peter.ujfalusi@nokia.com>, Eduardo Valentin <eduardo.valentin@nokia.com>

This patch renames the symbols that handles threshold
sysfs properties. This way we can add more sysfs properties
to them.

Signed-off-by: Eduardo Valentin <eduardo.valentin@nokia.com>
---
 arch/arm/plat-omap/mcbsp.c |   23 ++++++++++++-----------
 1 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/arch/arm/plat-omap/mcbsp.c b/arch/arm/plat-omap/mcbsp.c
index 6fed8cf..1b8ff9e 100644
--- a/arch/arm/plat-omap/mcbsp.c
+++ b/arch/arm/plat-omap/mcbsp.c
@@ -1093,31 +1093,32 @@ static DEVICE_ATTR(prop, 0644, prop##_show, prop##_store);
 THRESHOLD_PROP_BUILDER(max_tx_thres);
 THRESHOLD_PROP_BUILDER(max_rx_thres);
 
-static const struct attribute *threshold_attrs[] = {
+static const struct attribute *additional_attrs[] = {
 	&dev_attr_max_tx_thres.attr,
 	&dev_attr_max_rx_thres.attr,
 	NULL,
 };
 
-static const struct attribute_group threshold_attr_group = {
-	.attrs = (struct attribute **)threshold_attrs,
+static const struct attribute_group additional_attr_group = {
+	.attrs = (struct attribute **)additional_attrs,
 };
 
-static inline int __devinit omap_thres_add(struct platform_device *pdev)
+static inline int __devinit omap_additional_add(struct platform_device *pdev)
 {
-	return sysfs_create_group(&pdev->dev.kobj, &threshold_attr_group);
+	return sysfs_create_group(&pdev->dev.kobj, &additional_attr_group);
 }
 
-static inline void __devexit omap_thres_remove(struct platform_device *pdev)
+static inline void __devexit omap_additional_rem(struct platform_device *pdev)
 {
-	sysfs_remove_group(&pdev->dev.kobj, &threshold_attr_group);
+	sysfs_remove_group(&pdev->dev.kobj, &additional_attr_group);
 }
 #else
-static inline int __devinit omap_thres_add(struct platform_device *pdev)
+static inline int __devinit omap_additional_add(struct platform_device *pdev)
 {
 	return 0;
 }
-static inline void __devexit omap_thres_remove(struct platform_device *pdev) {}
+static inline void __devexit omap_additional_rem(struct platform_device *pdev)
+{ }
 #endif /* CONFIG_ARCH_OMAP34XX */
 
 /*
@@ -1194,7 +1195,7 @@ static int __devinit omap_mcbsp_probe(struct platform_device *pdev)
 	if (cpu_is_omap34xx()) {
 		mcbsp->max_tx_thres = max_thres(mcbsp);
 		mcbsp->max_rx_thres = max_thres(mcbsp);
-		if (omap_thres_add(pdev))
+		if (omap_additional_add(pdev))
 			dev_warn(&pdev->dev,
 				"Unable to create threshold controls\n");
 	} else {
@@ -1227,7 +1228,7 @@ static int __devexit omap_mcbsp_remove(struct platform_device *pdev)
 			mcbsp->pdata->ops->free(mcbsp->id);
 
 		if (cpu_is_omap34xx())
-			omap_thres_remove(pdev);
+			omap_additional_rem(pdev);
 		clk_disable(mcbsp->fclk);
 		clk_disable(mcbsp->iclk);
 		clk_put(mcbsp->fclk);
-- 
1.6.2.GIT

