From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: [PATCH 14/14] ARM: OMAP3+: SmartReflex: fix error handling
Date: Wed,  8 Feb 2012 18:43:59 +0100
Message-ID: <1328723039-15952-15-git-send-email-j-pihet@ti.com>
References: <1328723039-15952-1-git-send-email-j-pihet@ti.com>
Mime-Version: 1.0
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:41928 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756863Ab2BHRoq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 8 Feb 2012 12:44:46 -0500
Received: by mail-wi0-f174.google.com with SMTP id s10so579415wic.19
        for <linux-omap@vger.kernel.org>; Wed, 08 Feb 2012 09:44:46 -0800 (PST)
In-Reply-To: <1328723039-15952-1-git-send-email-j-pihet@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Kevin Hilman <khilman@ti.com>
Cc: balbi@ti.com, nm@ti.com, Jean Pihet <j-pihet@ti.com>

Fix the code to correctly use IS_ERR and PTR_ERR on the return
values pointers

Reported-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Signed-off-by: Jean Pihet <j-pihet@ti.com>
---
 arch/arm/mach-omap2/smartreflex.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/smartreflex.c
index f6b8f45..008fbd7 100644
--- a/arch/arm/mach-omap2/smartreflex.c
+++ b/arch/arm/mach-omap2/smartreflex.c
@@ -421,7 +421,7 @@ int sr_configure_errgen(struct voltagedomain *voltdm)
 	if (IS_ERR(sr)) {
 		pr_warning("%s: omap_sr struct for sr_%s not found\n",
 			__func__, voltdm->name);
-		return -EINVAL;
+		return PTR_ERR(sr);
 	}
 
 	if (!sr->clk_length)
@@ -489,7 +489,7 @@ int sr_disable_errgen(struct voltagedomain *voltdm)
 	if (IS_ERR(sr)) {
 		pr_warning("%s: omap_sr struct for sr_%s not found\n",
 			__func__, voltdm->name);
-		return -EINVAL;
+		return PTR_ERR(sr);
 	}
 
 	switch (sr->ip_type) {
@@ -540,7 +540,7 @@ int sr_configure_minmax(struct voltagedomain *voltdm)
 	if (IS_ERR(sr)) {
 		pr_warning("%s: omap_sr struct for sr_%s not found\n",
 			__func__, voltdm->name);
-		return -EINVAL;
+		return PTR_ERR(sr);
 	}
 
 	if (!sr->clk_length)
@@ -626,7 +626,7 @@ int sr_enable(struct voltagedomain *voltdm, unsigned long volt)
 	if (IS_ERR(sr)) {
 		pr_warning("%s: omap_sr struct for sr_%s not found\n",
 			__func__, voltdm->name);
-		return -EINVAL;
+		return PTR_ERR(sr);
 	}
 
 	volt_data = omap_voltage_get_voltdata(sr->voltdm, volt);
@@ -634,7 +634,7 @@ int sr_enable(struct voltagedomain *voltdm, unsigned long volt)
 	if (IS_ERR(volt_data)) {
 		dev_warn(&sr->pdev->dev, "%s: Unable to get voltage table"
 			"for nominal voltage %ld\n", __func__, volt);
-		return -ENODATA;
+		return PTR_ERR(volt_data);
 	}
 
 	nvalue_reciprocal = sr_retrieve_nvalue(sr, volt_data->sr_efuse_offs);
@@ -1079,7 +1079,7 @@ static int __devexit omap_sr_remove(struct platform_device *pdev)
 	if (IS_ERR(sr_info)) {
 		dev_warn(&pdev->dev, "%s: omap_sr struct not found\n",
 			__func__);
-		return -EINVAL;
+		return PTR_ERR(sr_info);
 	}
 
 	if (sr_info->autocomp_active)
-- 
1.7.5.4

