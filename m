From: Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
Subject: [PATCH] musb: host: release dma channels if no active io
Date: Sat, 15 May 2010 09:37:49 +0530
Message-ID: <1273896469-9686-1-git-send-email-ajay.gupta@ti.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Currently DMA channels are allocated and they remain allocated
even if there is no active data transfer. Added channel_release()
whenever there is no pending request.

Signed-off-by: Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
---
This patch is against today's linus's tree.

 drivers/usb/musb/musb_host.c |   14 ++++++++++++--
 1 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/musb/musb_host.c b/drivers/usb/musb/musb_host.c
index 877d20b..d78b887 100644
--- a/drivers/usb/musb/musb_host.c
+++ b/drivers/usb/musb/musb_host.c
@@ -387,11 +387,21 @@ static void musb_advance_schedule(struct musb *musb, struct urb *urb,
 	 */
 	if (list_empty(&qh->hep->urb_list)) {
 		struct list_head	*head;
+		struct dma_controller	*dma = musb->dma_controller;
 
-		if (is_in)
+		if (is_in) {
 			ep->rx_reinit = 1;
-		else
+			if (ep->rx_channel) {
+				dma->channel_release(ep->rx_channel);
+				ep->rx_channel = NULL;
+			}
+		} else {
 			ep->tx_reinit = 1;
+			if (ep->tx_channel) {
+				dma->channel_release(ep->tx_channel);
+				ep->tx_channel = NULL;
+			}
+		}
 
 		/* Clobber old pointers to this qh */
 		musb_ep_set_qh(ep, is_in, NULL);
-- 
1.6.2.4

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
