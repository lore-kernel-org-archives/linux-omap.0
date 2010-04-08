From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH 01/19] DSPBRIDGE: rename generic clk_handle for iva2_clk
Date: Thu,  8 Apr 2010 18:15:50 -0500
Message-ID: <1270768568-10712-2-git-send-email-omar.ramirez@ti.com>
References: <1270768568-10712-1-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:57271 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933799Ab0DHW71 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 8 Apr 2010 18:59:27 -0400
In-Reply-To: <1270768568-10712-1-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Paul Walmsley <paul@pwsan.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, Felipe Contreras <felipe.contreras@gmail.com>, Ameya Palande <ameya.palande@nokia.com>, Guzman Lugo Fernando <x0095840@ti.com>, Nishanth Menon <nm@ti.com>, Omar Ramirez Luna <omar.ramirez@ti.com>

In the contexts is being used clk_handle refers to iva2_clk
handle only.

Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
---
 drivers/dsp/bridge/rmgr/drv_interface.c |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/dsp/bridge/rmgr/drv_interface.c b/drivers/dsp/bridge/rmgr/drv_interface.c
index d592181..862e01b 100644
--- a/drivers/dsp/bridge/rmgr/drv_interface.c
+++ b/drivers/dsp/bridge/rmgr/drv_interface.c
@@ -150,7 +150,7 @@ static struct file_operations bridge_fops = {
 #ifdef CONFIG_PM
 static u32 time_out = 1000;
 #ifdef CONFIG_BRIDGE_DVFS
-static struct clk *clk_handle;
+static struct clk *iva2_clk;
 s32 dsp_max_opps = VDD1_OPP5;
 #endif
 
@@ -306,11 +306,11 @@ static int __devinit omap34_xx_bridge_probe(struct platform_device *pdev)
 		for (i = 0; i < 6; i++)
 			pdata->mpu_speed[i] = vdd1_rate_table_bridge[i].rate;
 
-		clk_handle = clk_get(NULL, "iva2_ck");
-		if (!clk_handle)
+		iva2_clk = clk_get(NULL, "iva2_ck");
+		if (!iva2_clk)
 			pr_err("%s: clk_get failed to get iva2_ck\n", __func__);
 
-		if (clk_notifier_register(clk_handle, &iva_clk_notifier))
+		if (clk_notifier_register(iva2_clk, &iva_clk_notifier))
 			pr_err("%s: clk_notifier_register failed for iva2_ck\n",
 			       __func__);
 #endif
@@ -346,7 +346,7 @@ static int __devexit omap34_xx_bridge_remove(struct platform_device *pdev)
 		goto func_cont;
 
 #ifdef CONFIG_BRIDGE_DVFS
-	if (clk_notifier_unregister(clk_handle, &iva_clk_notifier))
+	if (clk_notifier_unregister(iva2_clk, &iva_clk_notifier))
 		pr_err("%s: clk_notifier_unregister failed for iva2_ck\n",
 		       __func__);
 #endif /* #ifdef CONFIG_BRIDGE_DVFS */
@@ -358,8 +358,8 @@ static int __devexit omap34_xx_bridge_remove(struct platform_device *pdev)
 		DBC_ASSERT(ret == true);
 	}
 #ifdef CONFIG_BRIDGE_DVFS
-	clk_put(clk_handle);
-	clk_handle = NULL;
+	clk_put(iva2_clk);
+	iva2_clk = NULL;
 #endif /* #ifdef CONFIG_BRIDGE_DVFS */
 
 func_cont:
-- 
1.6.2.4

