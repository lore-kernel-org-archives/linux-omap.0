From: Omar Ramirez Luna <x00omar@ti.com>
Subject: [PATCH 13/14] DSPBRIDGE: Stop and reset DSP before removing constraints
Date: Wed, 20 May 2009 00:02:19 -0500
Message-ID: <1242795740-21535-13-git-send-email-x00omar@ti.com>
References: <1242795740-21535-1-git-send-email-x00omar@ti.com>
 <1242795740-21535-2-git-send-email-x00omar@ti.com>
 <1242795740-21535-3-git-send-email-x00omar@ti.com>
 <1242795740-21535-4-git-send-email-x00omar@ti.com>
 <1242795740-21535-5-git-send-email-x00omar@ti.com>
 <1242795740-21535-6-git-send-email-x00omar@ti.com>
 <1242795740-21535-7-git-send-email-x00omar@ti.com>
 <1242795740-21535-8-git-send-email-x00omar@ti.com>
 <1242795740-21535-9-git-send-email-x00omar@ti.com>
 <1242795740-21535-10-git-send-email-x00omar@ti.com>
 <1242795740-21535-11-git-send-email-x00omar@ti.com>
 <1242795740-21535-12-git-send-email-x00omar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:40808 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752459AbZETE6e (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 20 May 2009 00:58:34 -0400
In-Reply-To: <1242795740-21535-12-git-send-email-x00omar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Hiroshi.DOYU@nokia.com, ameya.palande@nokia.com, Omar Ramirez Luna <omar.ramirez@ti.com>, Hari Kanigeri <h-kanigeri2@ti.com>

From: Omar Ramirez Luna <omar.ramirez@ti.com>

This patch implements the DSP Reset procedure to be made
on bridge exit before unregistering the constraints set by dsp.

Signed-off-by: Hari Kanigeri <h-kanigeri2@ti.com>
Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
---
 drivers/dsp/bridge/rmgr/drv_interface.c |   17 ++++++++---------
 1 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/dsp/bridge/rmgr/drv_interface.c b/drivers/dsp/bridge/rmgr/drv_interface.c
index d17d3cf..d14e663 100644
--- a/drivers/dsp/bridge/rmgr/drv_interface.c
+++ b/drivers/dsp/bridge/rmgr/drv_interface.c
@@ -469,6 +469,14 @@ static int __devexit omap34xx_bridge_remove(struct platform_device *pdev)
 		pCtxtclosed = pTmp;
 	}
 func_cont:
+	if (driverContext) {
+		/* Put the DSP in reset state */
+		ret = DSP_Deinit(driverContext);
+		driverContext = 0;
+		DBC_Assert(ret == true);
+	}
+	SERVICES_Exit();
+	GT_exit();
 	/* unregister the clock notifier */
 #ifdef CONFIG_BRIDGE_DVFS
 	if (!clk_notifier_unregister(clk_handle, &iva_clk_notifier)) {
@@ -483,15 +491,6 @@ func_cont:
 	clk_handle = NULL;
 #endif /* #ifdef CONFIG_BRIDGE_DVFS */
 
-	if (driverContext) {
-		ret = DSP_Deinit(driverContext);
-		driverContext = 0;
-
-		DBC_Assert(ret == true);
-	}
-	SERVICES_Exit();
-	GT_exit();
-
 	devno = MKDEV(driver_major, driver_minor);
 	if (bridge_device) {
 		cdev_del(&bridge_device->cdev);
-- 
1.6.2.4

