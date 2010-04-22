From: Nishanth Menon <nm@ti.com>
Subject: [PATCH 1/3] DSPBRIDGE: fix cpufreq_register_notifier usage
Date: Wed, 21 Apr 2010 19:17:57 -0500
Message-ID: <1271895479-27744-2-git-send-email-nm@ti.com>
References: <1271895479-27744-1-git-send-email-nm@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:49512 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754488Ab0DVASL (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 21 Apr 2010 20:18:11 -0400
In-Reply-To: <1271895479-27744-1-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Deepak Chitriki <deepak.chitriki@ti.com>, Ameya Palande <ameya.palande@nokia.com>, Andy Shevchenko <ext-andriy.shevchenko@nokia.com>, Fernando Guzman Lugo <x0095840@ti.com>, Felipe Contreras <felipe.contreras@nokia.com>, Hari Kanigeri <h-kanigeri2@ti.com>, Hiroshi Doyu <hiroshi.doyu@nokia.com>, Omar Ramirez Luna <omar.ramirez@ti.com>, Ramesh Gupta <grgupta@ti.com>

From: Deepak Chitriki <deepak.chitriki@ti.com>

cpufreq_register_notifier() function calls
srcu_notifier_chain_register() which always returns 0  on success and
dspbridge throws the error message "clk_notifier_register failed for
iva2_ck". Fix the faulty ! in if logic and the faulty error message
we report to log.

Cc: Ameya Palande <ameya.palande@nokia.com>
Cc: Andy Shevchenko <ext-andriy.shevchenko@nokia.com>
Cc: Deepak Chitriki <deepak.chitriki@ti.com>
Cc: Fernando Guzman Lugo <x0095840@ti.com>
Cc: Felipe Contreras <felipe.contreras@nokia.com>
Cc: Hari Kanigeri <h-kanigeri2@ti.com>
Cc: Hiroshi Doyu <hiroshi.doyu@nokia.com>
Cc: Omar Ramirez Luna <omar.ramirez@ti.com>
Cc: Ramesh Gupta <grgupta@ti.com>

Signed-off-by: Deepak Chitriki <deepak.chitriki@ti.com>

---
 drivers/dsp/bridge/rmgr/drv_interface.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/dsp/bridge/rmgr/drv_interface.c b/drivers/dsp/bridge/rmgr/drv_interface.c
index 61aa13a..388c07a 100644
--- a/drivers/dsp/bridge/rmgr/drv_interface.c
+++ b/drivers/dsp/bridge/rmgr/drv_interface.c
@@ -351,10 +351,10 @@ static int __devinit omap34_xx_bridge_probe(struct platform_device *pdev)
 		if (!clk_handle)
 			pr_err("%s: clk_get failed to get iva2_ck\n", __func__);
 
-		if (!cpufreq_register_notifier(&iva_clk_notifier,
+		if (cpufreq_register_notifier(&iva_clk_notifier,
 						CPUFREQ_TRANSITION_NOTIFIER))
-			pr_err("%s: clk_notifier_register failed for iva2_ck\n",
-			       __func__);
+			pr_err("%s: cpufreq_register_notifier failed for "
+				"iva2_ck\n", __func__);
 #endif
 		driver_context = dsp_init(&init_status);
 		if (DSP_FAILED(init_status)) {
@@ -393,9 +393,9 @@ static int __devexit omap34_xx_bridge_remove(struct platform_device *pdev)
 		goto func_cont;
 
 #ifdef CONFIG_BRIDGE_DVFS
-	if (!cpufreq_unregister_notifier(&iva_clk_notifier,
+	if (cpufreq_unregister_notifier(&iva_clk_notifier,
 						CPUFREQ_TRANSITION_NOTIFIER))
-		pr_err("%s: clk_notifier_unregister failed for iva2_ck\n",
+		pr_err("%s: cpufreq_unregister_notifier failed for iva2_ck\n",
 		       __func__);
 #endif /* #ifdef CONFIG_BRIDGE_DVFS */
 
-- 
1.6.3.3

