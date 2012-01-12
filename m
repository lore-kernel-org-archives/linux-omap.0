From: Grazvydas Ignotas <notasas@gmail.com>
Subject: [PATCH] usb: musb: drop superfluous pm_runtime calls around musb_shutdown
Date: Thu, 12 Jan 2012 15:21:38 +0200
Message-ID: <1326374498-22968-1-git-send-email-notasas@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ee0-f46.google.com ([74.125.83.46]:61427 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753346Ab2ALNWh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Jan 2012 08:22:37 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, Hema HK <hemahk@ti.com>, Grazvydas Ignotas <notasas@gmail.com>

Since commit 4f9edd2d7e8d "usb: musb: Fix the crash issue during reboot"
musb_shutdown() does pm_runtime_get_sync/pm_runtime_put by itself, so
this no longer needs to be done by the caller. Also, musb_exit_debugfs()
doesn't access the device, so just drop those runtime_pm calls.

Signed-off-by: Grazvydas Ignotas <notasas@gmail.com>
---
 drivers/usb/musb/musb_core.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
index 485f7ba..b2ca6fd 100644
--- a/drivers/usb/musb/musb_core.c
+++ b/drivers/usb/musb/musb_core.c
@@ -2162,11 +2162,9 @@ static int __exit musb_remove(struct platform_device *pdev)
 	 *  - Peripheral mode: peripheral is deactivated (or never-activated)
 	 *  - OTG mode: both roles are deactivated (or never-activated)
 	 */
-	pm_runtime_get_sync(musb->controller);
 	musb_exit_debugfs(musb);
 	musb_shutdown(pdev);
 
-	pm_runtime_put(musb->controller);
 	musb_free(musb);
 	iounmap(ctrl_base);
 	device_init_wakeup(&pdev->dev, 0);
-- 
1.7.0.4

