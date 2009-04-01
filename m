From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: [PATCH 1/1] DSPBRIDGE: fix section mismatch warning
Date: Wed,  1 Apr 2009 15:24:02 +0300
Message-ID: <1238588642-26475-1-git-send-email-Hiroshi.DOYU@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:52877 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763103AbZDAMY0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 1 Apr 2009 08:24:26 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: h-kanigeri2@ti.com
Cc: linux-omap@vger.kernel.org, ameya.palande@nokia.com, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>


Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
---
 drivers/dsp/bridge/rmgr/drv_interface.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/dsp/bridge/rmgr/drv_interface.c b/drivers/dsp/bridge/rmgr/drv_interface.c
index 350e1b5..7f1f1d6 100755
--- a/drivers/dsp/bridge/rmgr/drv_interface.c
+++ b/drivers/dsp/bridge/rmgr/drv_interface.c
@@ -554,24 +554,24 @@ static int bridge_resume(struct platform_device *pdev)
 #define bridge_resume NULL
 #endif
 
-static struct platform_driver bridge_driver_ldm = {
+static struct platform_driver bridge_driver = {
 	.driver = {
 		.name = BRIDGE_NAME,
 	},
 	.probe	 = omap34xx_bridge_probe,
-	.remove	 = omap34xx_bridge_remove,
+	.remove	 = __devexit_p(omap34xx_bridge_remove),
 	.suspend = bridge_suspend,
 	.resume	 = bridge_resume,
 };
 
 static int __init bridge_init(void)
 {
-	return platform_driver_register(&bridge_driver_ldm);
+	return platform_driver_register(&bridge_driver);
 }
 
 static void __exit bridge_exit(void)
 {
-	platform_driver_unregister(&bridge_driver_ldm);
+	platform_driver_unregister(&bridge_driver);
 }
 
 /* This function is called when an application opens handle to the
-- 
1.5.6.3

