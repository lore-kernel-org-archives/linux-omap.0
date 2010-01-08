From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH 5/8] DSPBRIDGE: change to cpufreq_register_notifier for OPP changes
Date: Thu,  7 Jan 2010 19:00:45 -0600
Message-ID: <1262912445-30075-1-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:38033 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754502Ab0AHAvh (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 7 Jan 2010 19:51:37 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, Ameya Palande <ameya.palande@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>, Fernando Guzman <x0095840@ti.com>, Ernesto Ramos <ernesto@ti.com>

From: Fernando Guzman Lugo <x0095840@ti.com>

This patch changes clk_notifier_unregister with
cpufreq_unregister_notifier, which is used for OPP change
notifications

Signed-off-by: Fernando Guzman Lugo <x0095840@ti.com>
---
 drivers/dsp/bridge/Kconfig              |    2 +-
 drivers/dsp/bridge/rmgr/drv_interface.c |   25 +++++++++++++++----------
 2 files changed, 16 insertions(+), 11 deletions(-)

diff --git a/drivers/dsp/bridge/Kconfig b/drivers/dsp/bridge/Kconfig
index e494f02..ea639e3 100644
--- a/drivers/dsp/bridge/Kconfig
+++ b/drivers/dsp/bridge/Kconfig
@@ -13,7 +13,7 @@ menuconfig MPU_BRIDGE
 
 config BRIDGE_DVFS
 	bool "Enable Bridge Dynamic Voltage and Frequency Scaling (DVFS)"
-	depends on MPU_BRIDGE && OMAP_PM_SRF
+	depends on MPU_BRIDGE && OMAP_PM_SRF && CPU_FREQ
 	default n
 	help
 	  DVFS allows DSP Bridge to initiate the operating point change to
diff --git a/drivers/dsp/bridge/rmgr/drv_interface.c b/drivers/dsp/bridge/rmgr/drv_interface.c
index e551840..d7aa8e0 100644
--- a/drivers/dsp/bridge/rmgr/drv_interface.c
+++ b/drivers/dsp/bridge/rmgr/drv_interface.c
@@ -240,15 +240,18 @@ u32 vdd1_dsp_freq[6][4] = {
 };
 
 #ifdef CONFIG_BRIDGE_DVFS
-static int dspbridge_post_scale(struct notifier_block *op, unsigned long level,
-				void *ptr)
+static int dspbridge_scale_notification(struct notifier_block *op,
+		unsigned long val, void *ptr)
 {
-	PWR_PM_PostScale(PRCM_VDD1, level);
+	struct dspbridge_platform_data *pdata =
+					omap_dspbridge_dev->dev.platform_data;
+	if (CPUFREQ_POSTCHANGE == val && pdata->dsp_get_opp)
+		PWR_PM_PostScale(PRCM_VDD1, pdata->dsp_get_opp());
 	return 0;
 }
 
 static struct notifier_block iva_clk_notifier = {
-	.notifier_call = dspbridge_post_scale,
+	.notifier_call = dspbridge_scale_notification,
 	NULL,
 };
 #endif
@@ -387,12 +390,13 @@ static int __devinit omap34xx_bridge_probe(struct platform_device *pdev)
 			GT_0trace(driverTrace, GT_7CLASS,
 			"clk_get PASS to get iva2_ck \n");
 		}
-		if (!clk_notifier_register(clk_handle, &iva_clk_notifier)) {
+		if (!cpufreq_register_notifier(&iva_clk_notifier,
+						CPUFREQ_TRANSITION_NOTIFIER)) {
 			GT_0trace(driverTrace, GT_7CLASS,
-			"clk_notifier_register PASS for iva2_ck \n");
+			"cpufreq_register_notifier PASS for iva2_ck \n");
 		} else {
 			GT_0trace(driverTrace, GT_7CLASS,
-			"clk_notifier_register FAIL for iva2_ck \n");
+			"cpufreq_register_notifier FAIL for iva2_ck \n");
 		}
 #endif
 		driverContext = DSP_Init(&initStatus);
@@ -436,12 +440,13 @@ static int __devexit omap34xx_bridge_remove(struct platform_device *pdev)
 		goto func_cont;
 
 #ifdef CONFIG_BRIDGE_DVFS
-	if (!clk_notifier_unregister(clk_handle, &iva_clk_notifier)) {
+	if (!cpufreq_unregister_notifier(&iva_clk_notifier,
+						CPUFREQ_TRANSITION_NOTIFIER)) {
 		GT_0trace(driverTrace, GT_7CLASS,
-		"clk_notifier_unregister PASS for iva2_ck \n");
+		"cpufreq_unregister_notifier PASS for iva2_ck \n");
 	} else {
 		GT_0trace(driverTrace, GT_7CLASS,
-		"clk_notifier_unregister FAILED for iva2_ck \n");
+		"cpufreq_unregister_notifier FAILED for iva2_ck \n");
 	}
 #endif /* #ifdef CONFIG_BRIDGE_DVFS */
 
-- 
1.6.2.4

