From: Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 5/5] musb: dma: use optimal transfer element for sdma
Date: Wed, 12 May 2010 17:19:39 +0530
Message-ID: <1273664979-493-5-git-send-email-ajay.gupta@ti.com>
References: <1273664979-493-1-git-send-email-ajay.gupta@ti.com>
 <1273664979-493-2-git-send-email-ajay.gupta@ti.com>
 <1273664979-493-3-git-send-email-ajay.gupta@ti.com>
 <1273664979-493-4-git-send-email-ajay.gupta@ti.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1273664979-493-4-git-send-email-ajay.gupta-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Use optimal values of transfer element based on buffer address in system
DMA programming. This would improve the performance.

Signed-off-by: Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
---
 drivers/usb/musb/musbhsdma.c |   39 +++++++++++++++++++++++++++++++++------
 1 files changed, 33 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/musb/musbhsdma.c b/drivers/usb/musb/musbhsdma.c
index 6118d5f..a0da178 100644
--- a/drivers/usb/musb/musbhsdma.c
+++ b/drivers/usb/musb/musbhsdma.c
@@ -230,6 +230,8 @@ static void configure_channel(struct dma_channel *channel,
 	u8 buffer_is_aligned = (dma_addr & 0x3) ? 0 : 1;
 	u8 use_sdma = (musb_channel->sysdma_channel == -1) ? 0 : 1;
 	u16 csr = 0;
+	u16 frame = len;
+	int data_type = OMAP_DMA_DATA_TYPE_S8;
 
 	DBG(4, "%p, pkt_sz %d, addr 0x%x, len %d, mode %d\n",
 			channel, packet_sz, dma_addr, len, mode);
@@ -238,13 +240,38 @@ static void configure_channel(struct dma_channel *channel,
 			(musb->hwvers >= MUSB_HWVERS_1800))
 		use_sdma = 0;
 
+	if (use_sdma) {
+		switch (dma_addr & 0x3) {
+		case 0:
+			if ((len % 4) == 0) {
+				data_type = OMAP_DMA_DATA_TYPE_S32;
+				frame = len / 4;
+				break;
+			}
+			/* FALLTHROUGH */
+		case 2:
+			if ((len % 2) == 0) {
+				data_type = OMAP_DMA_DATA_TYPE_S16;
+				frame = len / 2;
+				break;
+			}
+			/* FALLTHROUGH */
+		case 1:
+		case 3:
+		default:
+			data_type = OMAP_DMA_DATA_TYPE_S8;
+			frame = len;
+			break;
+		}
+	}
+
 	if (use_sdma &&	!musb_channel->transmit) {
 		/* System DMA */
 		/* RX: set src = FIFO */
 		omap_set_dma_transfer_params(musb_channel->sysdma_channel,
-					OMAP_DMA_DATA_TYPE_S8,
-					len ? len : 1, 1, /* One frame */
-					OMAP_DMA_SYNC_ELEMENT,
+					data_type,
+					len ? frame : 1, 1, /* One frame */
+					OMAP_DMA_SYNC_FRAME,
 					OMAP24XX_DMA_NO_DEVICE,
 					0); /* Src Sync */
 
@@ -268,9 +295,9 @@ static void configure_channel(struct dma_channel *channel,
 		/* System DMA */
 		/* TX: set dst = FIFO */
 		omap_set_dma_transfer_params(musb_channel->sysdma_channel,
-					OMAP_DMA_DATA_TYPE_S8,
-					len ? len : 1, 1, /* One frame */
-					OMAP_DMA_SYNC_ELEMENT,
+					data_type,
+					len ? frame : 1, 1, /* One frame */
+					OMAP_DMA_SYNC_FRAME,
 					OMAP24XX_DMA_NO_DEVICE,
 					0); /* Src Sync */
 
-- 
1.6.2.4

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
