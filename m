From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH v2] DSPBRIDGE: remove clk_handle from drv interface
Date: Tue, 27 Apr 2010 20:29:09 -0500
Message-ID: <1272418167-12630-2-git-send-email-omar.ramirez@ti.com>
References: <1272418167-12630-1-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:44919 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750883Ab0D1BY1 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 27 Apr 2010 21:24:27 -0400
In-Reply-To: <1272418167-12630-1-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Ameya Palande <ameya.palande@nokia.com>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>, Nishanth Menon <nm@ti.com>, Omar Ramirez Luna <omar.ramirez@ti.com>

Since it is not used, remove.

Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
---
 drivers/dsp/bridge/rmgr/drv_interface.c |    9 ---------
 1 files changed, 0 insertions(+), 9 deletions(-)

diff --git a/drivers/dsp/bridge/rmgr/drv_interface.c b/drivers/dsp/bridge/rmgr/drv_interface.c
index 2f92278..ea2a5f3 100644
--- a/drivers/dsp/bridge/rmgr/drv_interface.c
+++ b/drivers/dsp/bridge/rmgr/drv_interface.c
@@ -149,7 +149,6 @@ static struct file_operations bridge_fops = {
 #ifdef CONFIG_PM
 static u32 time_out = 1000;
 #ifdef CONFIG_BRIDGE_DVFS
-static struct clk *clk_handle;
 s32 dsp_max_opps = VDD1_OPP5;
 #endif
 
@@ -324,10 +323,6 @@ static int __devinit omap34_xx_bridge_probe(struct platform_device *pdev)
 		for (i = 0; i < 6; i++)
 			pdata->mpu_speed[i] = vdd1_rate_table_bridge[i].rate;
 
-		clk_handle = clk_get(NULL, "iva2_ck");
-		if (!clk_handle)
-			pr_err("%s: clk_get failed to get iva2_ck\n", __func__);
-
 		if (!cpufreq_register_notifier(&iva_clk_notifier,
 						CPUFREQ_TRANSITION_NOTIFIER))
 			pr_err("%s: clk_notifier_register failed for iva2_ck\n",
@@ -383,10 +378,6 @@ static int __devexit omap34_xx_bridge_remove(struct platform_device *pdev)
 		driver_context = 0;
 		DBC_ASSERT(ret == true);
 	}
-#ifdef CONFIG_BRIDGE_DVFS
-	clk_put(clk_handle);
-	clk_handle = NULL;
-#endif /* #ifdef CONFIG_BRIDGE_DVFS */
 
 func_cont:
 	mem_ext_phys_pool_release();
-- 
1.6.0.4

