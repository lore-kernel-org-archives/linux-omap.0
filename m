From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: [PATCH 05/21] Revert "OMAP3+: PM: SR: add suspend/resume handlers"
Date: Wed, 25 Jan 2012 16:16:07 +0100
Message-ID: <1327504583-13408-6-git-send-email-j-pihet@ti.com>
References: <1327504583-13408-1-git-send-email-j-pihet@ti.com>
Mime-Version: 1.0
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:53734 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752253Ab2AYPQw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 25 Jan 2012 10:16:52 -0500
Received: by mail-we0-f174.google.com with SMTP id b13so3871040wer.19
        for <linux-omap@vger.kernel.org>; Wed, 25 Jan 2012 07:16:52 -0800 (PST)
In-Reply-To: <1327504583-13408-1-git-send-email-j-pihet@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, balbi@ti.com, nm@ti.com
Cc: Kevin Hilman <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>, Jean Pihet <j-pihet@ti.com>

From: Nishanth Menon <nm@ti.com>

This reverts commit b6be18f0bab68ed304ebbb2d787d1c36237eda62.

Revert the patch so that we remove any opportunity of SR disable/enable
and any device_scale transitions from conflicting with suspend/resume
path by moving the sr enable/disable activity to the very last
stage(in pmxx.C). The previous patch tried to optimize suspend resume
time, but since device_scale opportunities are from multiple drivers
(other than cpufreq), hence reverting back to original approach

Conflicts:

	arch/arm/mach-omap2/smartreflex.c

Change-Id: I236b0e8259cfb371899dd0c93875739a21358e33
Signed-off-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Jean Pihet <j-pihet@ti.com>
---
 arch/arm/mach-omap2/smartreflex.c |   90 -------------------------------------
 1 files changed, 0 insertions(+), 90 deletions(-)

diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/smartreflex.c
index 95fd228..7e755bb 100644
--- a/arch/arm/mach-omap2/smartreflex.c
+++ b/arch/arm/mach-omap2/smartreflex.c
@@ -24,7 +24,6 @@
 #include <linux/debugfs.h>
 #include <linux/delay.h>
 #include <linux/slab.h>
-#include <linux/pm.h>
 #include <linux/pm_runtime.h>
 
 #include "common.h"
@@ -41,7 +40,6 @@ struct omap_sr {
 	int				ip_type;
 	int				nvalue_count;
 	bool				autocomp_active;
-	bool				is_suspended;
 	u32				clk_length;
 	u32				err_weight;
 	u32				err_minlimit;
@@ -687,11 +685,6 @@ void omap_sr_enable(struct voltagedomain *voltdm)
 	if (!sr->autocomp_active)
 		return;
 
-	if (sr->is_suspended) {
-		dev_dbg(&sr->pdev->dev, "%s: in suspended state\n", __func__);
-		return;
-	}
-
 	if (!sr_class || !(sr_class->enable) || !(sr_class->configure)) {
 		dev_warn(&sr->pdev->dev, "%s: smartreflex class driver not"
 			"registered\n", __func__);
@@ -725,11 +718,6 @@ void omap_sr_disable(struct voltagedomain *voltdm)
 	if (!sr->autocomp_active)
 		return;
 
-	if (sr->is_suspended) {
-		dev_dbg(&sr->pdev->dev, "%s: in suspended state\n", __func__);
-		return;
-	}
-
 	if (!sr_class || !(sr_class->disable)) {
 		dev_warn(&sr->pdev->dev, "%s: smartreflex class driver not"
 			"registered\n", __func__);
@@ -763,11 +751,6 @@ void omap_sr_disable_reset_volt(struct voltagedomain *voltdm)
 	if (!sr->autocomp_active)
 		return;
 
-	if (sr->is_suspended) {
-		dev_dbg(&sr->pdev->dev, "%s: in suspended state\n", __func__);
-		return;
-	}
-
 	if (!sr_class || !(sr_class->disable)) {
 		dev_warn(&sr->pdev->dev, "%s: smartreflex class driver not"
 			"registered\n", __func__);
@@ -826,11 +809,6 @@ static int omap_sr_autocomp_store(void *data, u64 val)
 		return -EINVAL;
 	}
 
-	if (sr_info->is_suspended) {
-		pr_warning("%s: in suspended state\n", __func__);
-		return -EBUSY;
-	}
-
 	/* control enable/disable only if there is a delta in value */
 	if (sr_info->autocomp_active != val) {
 		if (!val)
@@ -1033,78 +1011,10 @@ static int __devexit omap_sr_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static int omap_sr_suspend(struct device *dev)
-{
-	struct omap_sr_data *pdata;
-	struct omap_sr *sr_info;
-
-	pdata = dev_get_platdata(dev);
-	if (!pdata) {
-		dev_err(dev, "%s: platform data missing\n", __func__);
-		return -EINVAL;
-	}
-
-	sr_info = _sr_lookup(pdata->voltdm);
-	if (IS_ERR(sr_info)) {
-		dev_warn(dev, "%s: omap_sr struct not found\n", __func__);
-		return -EINVAL;
-	}
-
-	if (!sr_info->autocomp_active)
-		return 0;
-
-	if (sr_info->is_suspended)
-		return 0;
-
-	omap_sr_disable_reset_volt(pdata->voltdm);
-	sr_info->is_suspended = true;
-	/* Flag the same info to the other CPUs */
-	smp_wmb();
-
-	return 0;
-}
-
-static int omap_sr_resume(struct device *dev)
-{
-	struct omap_sr_data *pdata;
-	struct omap_sr *sr_info;
-
-	pdata = dev_get_platdata(dev);
-	if (!pdata) {
-		dev_err(dev, "%s: platform data missing\n", __func__);
-		return -EINVAL;
-	}
-
-	sr_info = _sr_lookup(pdata->voltdm);
-	if (IS_ERR(sr_info)) {
-		dev_warn(dev, "%s: omap_sr struct not found\n", __func__);
-		return -EINVAL;
-	}
-
-	if (!sr_info->autocomp_active)
-		return 0;
-
-	if (!sr_info->is_suspended)
-		return 0;
-
-	sr_info->is_suspended = false;
-	/* Flag the same info to the other CPUs */
-	smp_wmb();
-	omap_sr_enable(pdata->voltdm);
-
-	return 0;
-}
-
-const static struct dev_pm_ops omap_sr_dev_pm_ops = {
-	.suspend_noirq = omap_sr_suspend,
-	.resume_noirq = omap_sr_resume,
-};
-
 static struct platform_driver smartreflex_driver = {
 	.remove         = omap_sr_remove,
 	.driver		= {
 		.name	= "smartreflex",
-		.pm	= &omap_sr_dev_pm_ops,
 	},
 };
 
-- 
1.7.5.4

