From: greg@kroah.com
Subject: [patch 11/12] usb: musb: adding high bandwidth support
Date: Wed, 18 Feb 2009 21:48:45 -0800
Message-ID: <20090219054845.GL26729@kroah.com>
References: <20090219052749.125178129@blue.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from kroah.org ([198.145.64.141]:54202 "EHLO coco.kroah.org"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755692AbZBSFtO (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 19 Feb 2009 00:49:14 -0500
Content-Disposition: inline; filename="usb-musb-adding-high-bandwidth-support.patch"
In-Reply-To: <20090219054750.GA26729@kroah.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>, Sergei Shtylyov <sshtylyov@ru.mvista.com>, Felipe Balbi <felipe.balbi@nokia.com>, linux-usb@vger.kernel.org
Cc: linux-omap@vger.kernel.org, Ajay Kumar Gupta <ajay.gupta@ti.com>, David Brownell <dbrownell@users.sourceforge.net>, Greg Kroah-Hartman <gregkh@suse.de>

From: Ajay Kumar Gupta <ajay.gupta@ti.com>

Tested with Creative (Live! Cam Optia) USB camera which uses
high bandwidth isochronous interface.FIFO table has been updated
for Rx high bandwidth case.

Signed-off-by: Ajay Kumar Gupta <ajay.gupta@ti.com>
Cc: Felipe Balbi <felipe.balbi@nokia.com>
Cc: David Brownell <dbrownell@users.sourceforge.net>

---
 drivers/usb/musb/musb_core.c |   18 +++++++++---------
 drivers/usb/musb/musb_host.c |   43 +++++++++++++++++++++++++++++--------------
 drivers/usb/musb/musb_host.h |    1 +
 3 files changed, 39 insertions(+), 23 deletions(-)

--- a/drivers/usb/musb/musb_core.c
+++ b/drivers/usb/musb/musb_core.c
@@ -1064,17 +1064,17 @@ static struct fifo_cfg __initdata mode_4
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
--- a/drivers/usb/musb/musb_host.c
+++ b/drivers/usb/musb/musb_host.c
@@ -604,7 +604,8 @@ musb_rx_reinit(struct musb *musb, struct
 	musb_writeb(ep->regs, MUSB_RXTYPE, qh->type_reg);
 	musb_writeb(ep->regs, MUSB_RXINTERVAL, qh->intv_reg);
 	/* NOTE: bulk combining rewrites high bits of maxpacket */
-	musb_writew(ep->regs, MUSB_RXMAXP, qh->maxpacket);
+	musb_writew(ep->regs, MUSB_RXMAXP, qh->maxpacket |
+				 ((qh->hb_mult - 1) << 11));
 
 	ep->rx_reinit = 0;
 }
@@ -727,7 +728,7 @@ static void musb_ep_program(struct musb 
 						packet_sz) - 1) << 11);
 			else
 				musb_writew(epio, MUSB_TXMAXP,
-					packet_sz);
+					packet_sz | ((qh->hb_mult - 1) << 11));
 			musb_writeb(epio, MUSB_TXINTERVAL, qh->intv_reg);
 		} else {
 			musb_writeb(epio, MUSB_NAKLIMIT0, qh->intv_reg);
@@ -767,10 +768,13 @@ static void musb_ep_program(struct musb 
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
 
@@ -1506,6 +1510,10 @@ void musb_host_rx(struct musb *musb, u8 
 			/* packet error reported later */
 			iso_err = true;
 		}
+	} else if (rx_csr & MUSB_RXCSR_INCOMPRX) {
+		DBG(3, "end %d Highbandwidth  incomplete ISO packet received\n",
+				epnum);
+		status = -EPROTO;
 	}
 
 	/* faults abort the transfer */
@@ -1713,7 +1721,11 @@ void musb_host_rx(struct musb *musb, u8 
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
@@ -1801,9 +1813,11 @@ static int musb_schedule(
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
@@ -1897,11 +1911,13 @@ static int musb_urb_enqueue(
 
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
@@ -2002,7 +2018,6 @@ static int musb_urb_enqueue(
 	}
 	spin_unlock_irqrestore(&musb->lock, flags);
 
-done:
 	if (ret != 0) {
 		spin_lock_irqsave(&musb->lock, flags);
 		usb_hcd_unlink_urb_from_ep(hcd, urb);
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

