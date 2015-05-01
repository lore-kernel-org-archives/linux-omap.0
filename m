From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 10/12] usb: musb: Remove ifdefs for musb_host_rx in musb_host.c part4
Date: Fri,  1 May 2015 12:29:36 -0700
Message-ID: <1430508578-5208-11-git-send-email-tony@atomide.com>
References: <1430508578-5208-1-git-send-email-tony@atomide.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1430508578-5208-1-git-send-email-tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Cc: Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>, George Cherian <george.cherian-l0cyMroinI0@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Remove ifdefs for musb_host_rx to get closer to building in
all the DMA drivers.

Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
---
 drivers/usb/musb/musb_host.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/musb/musb_host.c b/drivers/usb/musb/musb_host.c
index e2e7393..bc671c5 100644
--- a/drivers/usb/musb/musb_host.c
+++ b/drivers/usb/musb/musb_host.c
@@ -1857,9 +1857,8 @@ void musb_host_rx(struct musb *musb, u8 epnum)
 		}
 
 		/* we are expecting IN packets */
-#if defined(CONFIG_USB_INVENTRA_DMA) || defined(CONFIG_USB_UX500_DMA) || \
-	defined(CONFIG_USB_TI_CPPI41_DMA)
-		if (dma) {
+		if ((musb_dma_inventra(musb) || musb_dma_ux500(musb) ||
+		    musb_dma_cppi41(musb)) && dma) {
 			struct dma_controller	*c;
 			u16			rx_count;
 			int			ret, length;
@@ -1976,7 +1975,6 @@ void musb_host_rx(struct musb *musb, u8 epnum)
 				musb_writew(epio, MUSB_RXCSR, val);
 			}
 		}
-#endif	/* Mentor DMA */
 
 		if (!dma) {
 			unsigned int received_len;
-- 
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
