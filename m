From: Felipe Balbi <balbi@ti.com>
Subject: [RFT/PATCH 1/7] OMAP3+: PM: SR: add suspend/resume handlers
Date: Mon, 10 Oct 2011 15:26:13 +0300
Message-ID: <1318249579-4089-1-git-send-email-balbi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog125.obsmtp.com ([74.125.149.153]:46736 "EHLO
	na3sys009aog125.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751654Ab1JJM01 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 10 Oct 2011 08:26:27 -0400
Received: by bkbzt19 with SMTP id zt19so7829308bkb.9
        for <linux-omap@vger.kernel.org>; Mon, 10 Oct 2011 05:26:24 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Nishanth Menon <nm@ti.com>

From: Nishanth Menon <nm@ti.com>

SmartReflex should be disabled while entering low power mode due to
the following reasons:
a) SmartReflex values are not defined for retention voltage.
b) With SmartReflex enabled, if the CPU enters low power state, FSM
   will try to bump the voltage to current OPP's voltage for which
   it has entered low power state, causing power loss and potential
   unknown states for the SoC.
Since we are sure to attempt entering the lowest possible power state
during suspend operation, SmartReflex needs to be disabled for the
voltage domains in suspend path before achieving auto retention voltage
on the device.

Traditionally, this has been done with interrupts disabled as part of
the common code which handles the idle sequence. Instead, by using the
fact that we have to disable SmartReflex for sure during suspend
operations, we can opportunistically disable SmartReflex in device
standard pm ops, instead of disabling it as part of the code which
executes with interrupts disabled and slave CPU{s} shutdown. This
allows the system to do other parallel activities(such as suspending
other devices in the system using slave CPU{s}) and save the time
required to achieve suspend and resume from suspended state as a
sequential activity.

However, by being opportunistic as described above, we also increase
the likelihood of SmartReflex library access functions being invoked in
parallel contexts *after* SmartReflex driver's suspend handler (during
suspend operation) or *before* resume handler (during resume operation)
have been invoked (Example: DVFS for dependent devices, cpufreq for
MPU etc.). We prevent this by using a flag to reject the callers in
the duration where SmartReflex has been disabled.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/mach-omap2/smartreflex.c |   96 ++++++++++++++++++++++++++++++++++--
 1 files changed, 90 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/smartreflex.c
index 34c01a7..af158c0 100644
--- a/arch/arm/mach-omap2/smartreflex.c
+++ b/arch/arm/mach-omap2/smartreflex.c
@@ -23,6 +23,7 @@
 #include <linux/debugfs.h>
 #include <linux/delay.h>
 #include <linux/slab.h>
+#include <linux/pm.h>
 #include <linux/pm_runtime.h>
 
 #include <plat/common.h>
@@ -39,6 +40,7 @@ struct omap_sr {
 	int				ip_type;
 	int				nvalue_count;
 	bool				autocomp_active;
+	bool				is_suspended;
 	u32				clk_length;
 	u32				err_weight;
 	u32				err_minlimit;
@@ -683,6 +685,11 @@ void omap_sr_enable(struct voltagedomain *voltdm)
 	if (!sr->autocomp_active)
 		return;
 
+	if (sr->is_suspended) {
+		dev_dbg(&sr->pdev->dev, "%s: in suspended state\n", __func__);
+		return;
+	}
+
 	if (!sr_class || !(sr_class->enable) || !(sr_class->configure)) {
 		dev_warn(&sr->pdev->dev, "%s: smartreflex class driver not"
 			"registered\n", __func__);
@@ -716,6 +723,11 @@ void omap_sr_disable(struct voltagedomain *voltdm)
 	if (!sr->autocomp_active)
 		return;
 
+	if (sr->is_suspended) {
+		dev_dbg(&sr->pdev->dev, "%s: in suspended state\n", __func__);
+		return;
+	}
+
 	if (!sr_class || !(sr_class->disable)) {
 		dev_warn(&sr->pdev->dev, "%s: smartreflex class driver not"
 			"registered\n", __func__);
@@ -749,6 +761,11 @@ void omap_sr_disable_reset_volt(struct voltagedomain *voltdm)
 	if (!sr->autocomp_active)
 		return;
 
+	if (sr->is_suspended) {
+		dev_dbg(&sr->pdev->dev, "%s: in suspended state\n", __func__);
+		return;
+	}
+
 	if (!sr_class || !(sr_class->disable)) {
 		dev_warn(&sr->pdev->dev, "%s: smartreflex class driver not"
 			"registered\n", __func__);
@@ -807,14 +824,16 @@ static int omap_sr_autocomp_store(void *data, u64 val)
 		return -EINVAL;
 	}
 
-	/* control enable/disable only if there is a delta in value */
-	if (sr_info->autocomp_active != val) {
-		if (!val)
-			sr_stop_vddautocomp(sr_info);
-		else
-			sr_start_vddautocomp(sr_info);
+	if (sr_info->is_suspended) {
+		pr_warning("%s: in suspended state\n", __func__);
+		return -EBUSY;
 	}
 
+	if (!val)
+		sr_stop_vddautocomp(sr_info);
+	else
+		sr_start_vddautocomp(sr_info);
+
 	return 0;
 }
 
@@ -1001,10 +1020,75 @@ static int __devexit omap_sr_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static int omap_sr_suspend(struct device *dev)
+{
+	struct omap_sr_data *pdata;
+	struct omap_sr *sr_info;
+
+	pdata = dev_get_platdata(dev);
+	if (!pdata) {
+		dev_err(dev, "%s: platform data missing\n", __func__);
+		return -EINVAL;
+	}
+
+	sr_info = _sr_lookup(pdata->voltdm);
+	if (IS_ERR(sr_info)) {
+		dev_warn(dev, "%s: omap_sr struct not found\n", __func__);
+		return -EINVAL;
+	}
+
+	if (!sr_info->autocomp_active)
+		return 0;
+
+	if (sr_info->is_suspended)
+		return 0;
+
+	omap_sr_disable_reset_volt(pdata->voltdm);
+	sr_info->is_suspended = true;
+	/* Flag the same info to the other CPUs */
+	smp_wmb();
+
+	return 0;
+}
+
+static int omap_sr_resume(struct device *dev)
+{
+	struct omap_sr_data *pdata;
+	struct omap_sr *sr_info;
+
+	pdata = dev_get_platdata(dev);
+	if (!pdata) {
+		dev_err(dev, "%s: platform data missing\n", __func__);
+		return -EINVAL;
+	}
+
+	sr_info = _sr_lookup(pdata->voltdm);
+	if (IS_ERR(sr_info)) {
+		dev_warn(dev, "%s: omap_sr struct not found\n", __func__);
+		return -EINVAL;
+	}
+
+	if (!sr_info->autocomp_active)
+		return 0;
+
+	if (!sr_info->is_suspended)
+		return 0;
+
+	sr_info->is_suspended = false;
+	/* Flag the same info to the other CPUs */
+	smp_wmb();
+	omap_sr_enable(pdata->voltdm);
+
+	return 0;
+}
+
+static SIMPLE_DEV_PM_OPS(omap_sr_dev_pm_ops, omap_sr_suspend, omap_sr_resume);
+
 static struct platform_driver smartreflex_driver = {
 	.remove         = omap_sr_remove,
 	.driver		= {
 		.name	= "smartreflex",
+		.pm	= &omap_sr_dev_pm_ops,
 	},
 };
 
-- 
1.7.6.396.ge0613

