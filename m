From: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
Subject: [PATCH RFC v2] usb: musb: omap: fix the error check for pm_runtime_get_sync
Date: Thu, 22 Mar 2012 18:58:45 +0530
Message-ID: <1332422925-3212-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

pm_runtime_get_sync returns a signed integer.In case of errors
it returns a negative value.This patch fixes the error check
by making it signed instead of unsigned thus preventing register
access if get_sync_fails. Also passes the error cause to the
debug message.

Cc :  Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
Signed-off-by: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
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
+		dev_err(dev, "pm_runtime_get_sync FAILED %d\n", status);
 		goto err1;
 	}
 
-- 
1.7.1

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
