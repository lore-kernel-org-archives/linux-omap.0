From: Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 2/2] usb: musb: do not override DMA mode in channel program
Date: Thu,  8 Jul 2010 16:34:55 +0530
Message-ID: <1278587095-16978-3-git-send-email-ajay.gupta@ti.com>
References: <1278587095-16978-1-git-send-email-ajay.gupta@ti.com>
 <1278587095-16978-2-git-send-email-ajay.gupta@ti.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1278587095-16978-2-git-send-email-ajay.gupta-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org, gregkh-l3A5Bk7waGM@public.gmane.org, Anand Gadiyar <gadiyar-l0cyMroinI0@public.gmane.org>, Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

From: Anand Gadiyar <gadiyar-l0cyMroinI0@public.gmane.org>

There is no reason for the DMA channel program to override the
DMA mode passed down by its caller. Use the passed parameter
directly, and let the caller handle the decision on which mode
is to be used.

Signed-off-by: Anand Gadiyar <gadiyar-l0cyMroinI0@public.gmane.org>
Acked-by: Felipe Balbi <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Signed-off-by: Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
---
 drivers/usb/musb/musbhsdma.c |    5 +----
 1 files changed, 1 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/musb/musbhsdma.c b/drivers/usb/musb/musbhsdma.c
index dc66e43..6dc107f 100644
--- a/drivers/usb/musb/musbhsdma.c
+++ b/drivers/usb/musb/musbhsdma.c
@@ -173,10 +173,7 @@ static int dma_channel_program(struct dma_channel *channel,
 	musb_channel->max_packet_sz = packet_sz;
 	channel->status = MUSB_DMA_STATUS_BUSY;
 
-	if ((mode == 1) && (len >= packet_sz))
-		configure_channel(channel, packet_sz, 1, dma_addr, len);
-	else
-		configure_channel(channel, packet_sz, 0, dma_addr, len);
+	configure_channel(channel, packet_sz, mode, dma_addr, len);
 
 	return true;
 }
-- 
1.6.2.4

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
