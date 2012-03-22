From: Shubhrajyoti D <shubhrajyoti@ti.com>
Subject: [PATCH RFC] usb: musb: omap: fix the error check for pm_runtime_get_sync
Date: Thu, 22 Mar 2012 12:48:06 +0530
Message-ID: <1332400686-27674-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:54475 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750969Ab2CVHSL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 22 Mar 2012 03:18:11 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-usb@vger.kernel.org, balbi@ti.com, Shubhrajyoti D <shubhrajyoti@ti.com>, Kishon Vijay Abraham I <kishon@ti.com>

pm_runtime_get_sync returns a signed integer.In case of errors
it returns a negative value.This patch fixes the error check
by making it signed instead of unsigned thus preventing register
access if get_sync_fails. Also passes the error cause to the
debug message.

Cc:  Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
---
Compile tested only

 drivers/usb/musb/omap2430.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/musb/omap2430.c b/drivers/usb/musb/omap2430.c
index 2ae0bb3..e5dd18f 100644
--- a/drivers/usb/musb/omap2430.c
+++ b/drivers/usb/musb/omap2430.c
@@ -282,7 +282,8 @@ static void musb_otg_notifier_work(struct work_struct *data_notifier_work)
 
 static int omap2430_musb_init(struct musb *musb)
 {
-	u32 l, status = 0;
+	u32 l;
+	int status = 0;
 	struct device *dev = musb->controller;
 	struct musb_hdrc_platform_data *plat = dev->platform_data;
 	struct omap_musb_board_data *data = plat->board_data;
@@ -301,7 +302,7 @@ static int omap2430_musb_init(struct musb *musb)
 
 	status = pm_runtime_get_sync(dev);
 	if (status < 0) {
-		dev_err(dev, "pm_runtime_get_sync FAILED");
+		dev_err(dev, "pm_runtime_get_sync FAILED %d \n",status);
 		goto err1;
 	}
 
-- 
1.7.1

