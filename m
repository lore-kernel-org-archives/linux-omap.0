From: Felipe Balbi <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 3/7] usb: musb: we already tested for dyn_fifo
Date: Thu, 21 Jan 2010 15:33:54 +0200
Message-ID: <1264080838-9452-4-git-send-email-felipe.balbi@nokia.com>
References: <1264080838-9452-1-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1264080838-9452-1-git-send-email-felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Cc: Linux USB Mailing List <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Felipe Balbi <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

... and even added a flag to struct musb, so let's
use that.

Signed-off-by: Felipe Balbi <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
---
 drivers/usb/musb/musb_core.c |   19 ++++---------------
 1 files changed, 4 insertions(+), 15 deletions(-)

diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
index a6dc18c..3e9b3b0 100644
--- a/drivers/usb/musb/musb_core.c
+++ b/drivers/usb/musb/musb_core.c
@@ -1398,21 +1398,10 @@ static int __init musb_core_init(u16 musb_type, struct musb *musb)
 	musb->nr_endpoints = 1;
 	musb->epmask = 1;
 
-	if (reg & MUSB_CONFIGDATA_DYNFIFO) {
-		if (musb->config->dyn_fifo)
-			status = ep_config_from_table(musb);
-		else {
-			ERR("reconfigure software for Dynamic FIFOs\n");
-			status = -ENODEV;
-		}
-	} else {
-		if (!musb->config->dyn_fifo)
-			status = ep_config_from_hw(musb);
-		else {
-			ERR("reconfigure software for static FIFOs\n");
-			return -ENODEV;
-		}
-	}
+	if (musb->dyn_fifo)
+		status = ep_config_from_table(musb);
+	else
+		status = ep_config_from_hw(musb);
 
 	if (status < 0)
 		return status;
-- 
1.6.6.rc0

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
