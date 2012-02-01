From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: [PATCH 20/20] ARM: OMAP3+: SmartReflex: fix error handling
Date: Wed,  1 Feb 2012 09:49:59 +0100
Message-ID: <1328086199-28486-21-git-send-email-j-pihet@ti.com>
References: <1328086199-28486-1-git-send-email-j-pihet@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:40135 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754676Ab2BAIuw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 1 Feb 2012 03:50:52 -0500
Received: by mail-we0-f174.google.com with SMTP id b13so753770wer.19
        for <linux-omap@vger.kernel.org>; Wed, 01 Feb 2012 00:50:51 -0800 (PST)
In-Reply-To: <1328086199-28486-1-git-send-email-j-pihet@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, balbi@ti.com, nm@ti.com
Cc: Kevin Hilman <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>, Jean Pihet <j-pihet@ti.com>

Fix the code to correctly use IS_ERR and PTR_ERR on the return
values pointers

Reported-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Signed-off-by: Jean Pihet <j-pihet@ti.com>
---
 arch/arm/mach-omap2/smartreflex.c |   16 ++++++++--------
 1 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/smartreflex.c
index 96a97c1..205531b 100644
--- a/arch/arm/mach-omap2/smartreflex.c
+++ b/arch/arm/mach-omap2/smartreflex.c
@@ -536,7 +536,7 @@ int sr_configure_errgen(struct voltagedomain *voltdm)
 	if (IS_ERR(sr)) {
 		pr_warning("%s: omap_sr struct for sr_%s not found\n",
 			__func__, voltdm->name);
-		return -EINVAL;
+		return PTR_ERR(sr);
 	}
 
 	if (!sr->clk_length)
@@ -604,7 +604,7 @@ int sr_disable_errgen(struct voltagedomain *voltdm)
 	if (IS_ERR(sr)) {
 		pr_warning("%s: omap_sr struct for sr_%s not found\n",
 			__func__, voltdm->name);
-		return -EINVAL;
+		return PTR_ERR(sr);
 	}
 
 	switch (sr->ip_type) {
@@ -655,7 +655,7 @@ int sr_configure_minmax(struct voltagedomain *voltdm)
 	if (IS_ERR(sr)) {
 		pr_warning("%s: omap_sr struct for sr_%s not found\n",
 			__func__, voltdm->name);
-		return -EINVAL;
+		return PTR_ERR(sr);
 	}
 
 	if (!sr->clk_length)
@@ -741,7 +741,7 @@ int sr_enable(struct voltagedomain *voltdm, unsigned long volt)
 	if (IS_ERR(sr)) {
 		pr_warning("%s: omap_sr struct for sr_%s not found\n",
 			__func__, voltdm->name);
-		return -EINVAL;
+		return PTR_ERR(sr);
 	}
 
 	volt_data = omap_voltage_get_voltdata(sr->voltdm, volt);
@@ -749,7 +749,7 @@ int sr_enable(struct voltagedomain *voltdm, unsigned long volt)
 	if (IS_ERR(volt_data)) {
 		dev_warn(&sr->pdev->dev, "%s: Unable to get voltage table"
 			"for nominal voltage %ld\n", __func__, volt);
-		return -ENODATA;
+		return PTR_ERR(volt_data);
 	}
 
 	nvalue_reciprocal = sr_retrieve_nvalue(sr, volt_data->sr_efuse_offs);
@@ -839,10 +839,10 @@ int sr_notifier_control(struct voltagedomain *voltdm, bool enable)
 	struct omap_sr *sr = _sr_lookup(voltdm);
 	u32 value = 0;
 
-	if (!sr) {
+	if (IS_ERR(sr)) {
 		pr_warning("%s: sr corresponding to domain not found\n",
 				__func__);
-		return -EINVAL;
+		return PTR_ERR(sr);
 	}
 	if (!sr->autocomp_active)
 		return -EINVAL;
@@ -1258,7 +1258,7 @@ static int __devexit omap_sr_remove(struct platform_device *pdev)
 	if (IS_ERR(sr_info)) {
 		dev_warn(&pdev->dev, "%s: omap_sr struct not found\n",
 			__func__);
-		return -EINVAL;
+		return PTR_ERR(sr_info);
 	}
 
 	if (sr_info->autocomp_active)
-- 
1.7.5.4

