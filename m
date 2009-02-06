From: Ajay Kumar Gupta <ajay.gupta@ti.com>
Subject: [PATCH 1/3] usb: musb: adding high bandwidth support
Date: Fri,  6 Feb 2009 17:22:14 +0530
Message-ID: <1233921134-4013-1-git-send-email-ajay.gupta@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:40064 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752927AbZBFLwg (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 6 Feb 2009 06:52:36 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-usb@vger.kernel.org
Cc: linux-omap@vger.kernel.org, david-b@pacbell.net, felipe.balbi@nokia.com, Ajay Kumar Gupta <ajay.gupta@ti.com>

Tested with Creative (Live! Cam Optia) USB camera which uses
high bandwidth isochronous interface.FIFO table has been updated
for Rx high bandwidth case.

Signed-off-by: Ajay Kumar Gupta <ajay.gupta@ti.com>
---
 drivers/usb/musb/musb_core.c |   18 ++++++++--------
 drivers/usb/musb/musb_host.c |   43 ++++++++++++++++++++++++++++-------------
 drivers/usb/musb/musb_host.h |    1 +
 3 files changed, 39 insertions(+), 23 deletions(-)

diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
index 2cc34fa..5583cb1 100644
--- a/drivers/usb/musb/musb_core.c
+++ b/drivers/usb/musb/musb_core.c
@@ -1064,17 +1064,17 @@ static struct fifo_cfg __initdata mode_4_cfg[] = {
 { .hw_ep_num =  7, .style = FIFO_TX,   .maxpacket = 512, },
 { .hw_ep_num =  7, .style = FIFO_RX,   .maxpacket = 512, },
 { .hw_ep_num =  8, .style = FIFO_TX,   .maxpacket = 512, },
-{ .hw_ep_num =  8, .style = FIFO_RX,   .maxpacket = 512, },
+{ .hw_ep_num =  8, .style = FIFO_RX,   .maxpacket = 64, },
 { .hw_ep_num =  9, .style = FIFO_TX,   .maxpacket = 512, },
-{ .hw_ep_num =  9, .style = FIFO_RX,   .maxpacket = 512, },
+{ .hw_ep_num =  9, .style = FIFO_RX,   .maxpacket = 64, },
 { .hw_ep_num = 10, .style = FIFO_TX,   .maxpacket = 512, },
-{ .hw_ep_num = 10, .style = FIFO_RX,   .maxpacket = 512, },
-{ .hw_ep_num = 11, .style = FIFO_TX,   .maxpacket = 512, },
-{ .hw_ep_num = 11, .style = FIFO_RX,   .maxpacket = 512, },
-{ .hw_ep_num = 12, .style = FIFO_TX,   .maxpacket = 512, },
-{ .hw_ep_num = 12, .style = FIFO_RX,   .maxpacket = 512, },
-{ .hw_ep_num = 13, .style = FIFO_TX,   .maxpacket = 512, },
-{ .hw_ep_num = 13, .style = FIFO_RX,   .maxpacket = 512, },
+{ .hw_ep_num = 10, .style = FIFO_RX,   .maxpacket = 64, },
+{ .hw_ep_num = 11, .style = FIFO_TX,   .maxpacket = 256, },
+{ .hw_ep_num = 11, .style = FIFO_RX,   .maxpacket = 256, },
+{ .hw_ep_num = 12, .style = FIFO_TX,   .maxpacket = 256, },
+{ .hw_ep_num = 12, .style = FIFO_RX,   .maxpacket = 256, },
+{ .hw_ep_num = 13, .style = FIFO_TX,   .maxpacket = 256, },
+{ .hw_ep_num = 13, .style = FIFO_RX,   .maxpacket = 4096, },
 { .hw_ep_num = 14, .style = FIFO_RXTX, .maxpacket = 1024, },
 { .hw_ep_num = 15, .style = FIFO_RXTX, .maxpacket = 1024, },
 };
diff --git a/drivers/usb/musb/musb_host.c b/drivers/usb/musb/musb_host.c
index a035cec..a776951 100644
--- a/drivers/usb/musb/musb_host.c
+++ b/drivers/usb/musb/musb_host.c
@@ -607,7 +607,8 @@ musb_rx_reinit(struct musb *musb, struct musb_qh *qh, struct musb_hw_ep *ep)
 	musb_writeb(ep->regs, MUSB_RXTYPE, qh->type_reg);
 	musb_writeb(ep->regs, MUSB_RXINTERVAL, qh->intv_reg);
 	/* NOTE: bulk combining rewrites high bits of maxpacket */
-	musb_writew(ep->regs, MUSB_RXMAXP, qh->maxpacket);
+	musb_writew(ep->regs, MUSB_RXMAXP, qh->maxpacket |
+				 ((qh->hb_mult - 1) << 11));
 
 	ep->rx_reinit = 0;
 }
@@ -730,7 +731,7 @@ static void musb_ep_program(struct musb *musb, u8 epnum,
 						packet_sz) - 1) << 11);
 			else
 				musb_writew(epio, MUSB_TXMAXP,
-					packet_sz);
+					packet_sz | ((qh->hb_mult - 1) << 11));
 			musb_writeb(epio, MUSB_TXINTERVAL, qh->intv_reg);
 		} else {
 			musb_writeb(epio, MUSB_NAKLIMIT0, qh->intv_reg);
@@ -770,10 +771,13 @@ static void musb_ep_program(struct musb *musb, u8 epnum,
 					| MUSB_TXCSR_DMAMODE);
 				csr |= (MUSB_TXCSR_DMAENAB);
 					/* against programming guide */
-			} else
-				csr |= (MUSB_TXCSR_AUTOSET
-					| MUSB_TXCSR_DMAENAB
+			} else {
+				csr |= (MUSB_TXCSR_DMAENAB
 					| MUSB_TXCSR_DMAMODE);
+				/* autoset shouldn't be set in high bandwidth */
+				if (qh->hb_mult == 1)
+					csr |= MUSB_TXCSR_AUTOSET;
+			}
 
 			musb_writew(epio, MUSB_TXCSR, csr);
 
@@ -1444,6 +1448,10 @@ void musb_host_rx(struct musb *musb, u8 epnum)
 			/* packet error reported later */
 			iso_err = true;
 		}
+	} else if (rx_csr & MUSB_RXCSR_INCOMPRX) {
+		DBG(3, "end %d Highbandwidth  incomplete ISO packet received\n",
+				epnum);
+		status = -EPROTO;
 	}
 
 	/* faults abort the transfer */
@@ -1651,7 +1659,11 @@ void musb_host_rx(struct musb *musb, u8 epnum)
 				val &= ~MUSB_RXCSR_H_AUTOREQ;
 			else
 				val |= MUSB_RXCSR_H_AUTOREQ;
-			val |= MUSB_RXCSR_AUTOCLEAR | MUSB_RXCSR_DMAENAB;
+			val |= MUSB_RXCSR_DMAENAB;
+
+			/* autoclear shouldn't be set in high bandwidth */
+			if (qh->hb_mult == 1)
+				val |= MUSB_RXCSR_AUTOCLEAR;
 
 			musb_writew(epio, MUSB_RXCSR,
 				MUSB_RXCSR_H_WZC_BITS | val);
@@ -1744,9 +1756,11 @@ static int musb_schedule(
 			continue;
 
 		if (is_in)
-			diff = hw_ep->max_packet_sz_rx - qh->maxpacket;
+			diff = hw_ep->max_packet_sz_rx -
+				 (qh->maxpacket * qh->hb_mult);
 		else
-			diff = hw_ep->max_packet_sz_tx - qh->maxpacket;
+			diff = hw_ep->max_packet_sz_tx -
+				 (qh->maxpacket * qh->hb_mult);
 
 		if (diff >= 0 && best_diff > diff) {
 			best_diff = diff;
@@ -1841,11 +1855,13 @@ static int musb_urb_enqueue(
 
 	qh->maxpacket = le16_to_cpu(epd->wMaxPacketSize);
 
-	/* no high bandwidth support yet */
-	if (qh->maxpacket & ~0x7ff) {
-		ret = -EMSGSIZE;
-		goto done;
-	}
+	/* update qh->hb_mult for high bandwidth transfers.Bit 11 or 12
+	 * of wMaxPacketSize is set for two or three transaction per microframe.
+	 */
+	qh->hb_mult = 1 + ((qh->maxpacket >> 11) & 0x03);
+
+	if (qh->hb_mult > 1)
+		qh->maxpacket &= 0x7ff;
 
 	qh->epnum = usb_endpoint_num(epd);
 	qh->type = usb_endpoint_type(epd);
@@ -1944,7 +1960,6 @@ static int musb_urb_enqueue(
 	}
 	spin_unlock_irqrestore(&musb->lock, flags);
 
-done:
 	if (ret != 0) {
 		spin_lock_irqsave(&musb->lock, flags);
 		usb_hcd_unlink_urb_from_ep(hcd, urb);
diff --git a/drivers/usb/musb/musb_host.h b/drivers/usb/musb/musb_host.h
index 0b7fbcd..e70bf5d 100644
--- a/drivers/usb/musb/musb_host.h
+++ b/drivers/usb/musb/musb_host.h
@@ -68,6 +68,7 @@ struct musb_qh {
 	u8			type;		/* XFERTYPE_* */
 	u8			epnum;
 	u16			maxpacket;
+	u8			hb_mult;	/* high bandwidth pkts per uf */
 	u16			frame;		/* for periodic schedule */
 	unsigned		iso_idx;	/* in urb->iso_frame_desc[] */
 };
-- 
1.5.6

