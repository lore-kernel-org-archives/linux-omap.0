From: Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 1/3] musb: NAK timeout scheme on bulk reserved ep
Date: Thu, 30 Oct 2008 14:42:22 +0530
Message-ID: <1225357942-10920-1-git-send-email-ajay.gupta@ti.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org, me-uiRdBs8odbtmTBlB0Cgj/Q@public.gmane.org, felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org, Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>, Ravi Babu <ravibabu-l0cyMroinI0@public.gmane.org>, Swaminathan S <swami.iyer-l0cyMroinI0@public.gmane.org>, Thomas Abraham <t-abraham-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Fixes endpoint starvation issue when more than one bulk qhs
are multiplexed on reserved bulk endpoint.NAK timeout interval
is set for such qhs and next qh is scheduled when NAK timeout
occurs.
This scheme doesn't work for devices which are connected to a
high to full speed tree as there is no NAK timeout interrupt
at musb controller from such devices.
A module parameter 'bulk_nak_timeout' is added so that this feature
can be disabled if not required.

Signed-off-by: Ravi Babu <ravibabu-l0cyMroinI0@public.gmane.org>
Signed-off-by: Swaminathan S <swami.iyer-l0cyMroinI0@public.gmane.org>
Signed-off-by: Thomas Abraham <t-abraham-l0cyMroinI0@public.gmane.org>
Signed-off-by: Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
---
These patches have been created against latest omap git and Felipe's
musb .28 patch series at,
http://marc.info/?l=linux-usb&m=122528597116718&w=2

 drivers/usb/musb/musb_host.c |   70 ++++++++++++++++++++++++++++++++++++++++--
 1 files changed, 67 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/musb/musb_host.c b/drivers/usb/musb/musb_host.c
index 30b5685..b77ca0b 100644
--- a/drivers/usb/musb/musb_host.c
+++ b/drivers/usb/musb/musb_host.c
@@ -100,6 +100,10 @@
  * of transfers between endpoints, or anything clever.
  */
 
+static void musb_bulk_nak_timeout(struct musb *musb, struct musb_hw_ep *ep);
+static int bulk_nak_timeout = 1;
+module_param(bulk_nak_timeout, bool, 0);
+MODULE_PARM_DESC(bulk_nak_timeout, "enable/disable use of bulk nak timeout");
 
 static void musb_ep_program(struct musb *musb, u8 epnum,
 			struct urb *urb, unsigned int nOut,
@@ -1449,10 +1453,15 @@ void musb_host_rx(struct musb *musb, u8 epnum)
 			 * we have a candidate... NAKing is *NOT* an error
 			 */
 			DBG(6, "RX end %d NAK timeout\n", epnum);
+			if (usb_pipebulk(urb->pipe) && qh->mux == 1 &&
+				(musb->in_bulk.next->next != &musb->in_bulk) &&
+					bulk_nak_timeout) {
+				musb_bulk_nak_timeout(musb, hw_ep);
+				return;
+			}
 			musb_ep_select(mbase, epnum);
-			musb_writew(epio, MUSB_RXCSR,
-					MUSB_RXCSR_H_WZC_BITS
-					| MUSB_RXCSR_H_REQPKT);
+			rx_csr &= ~MUSB_RXCSR_DATAERROR;
+			musb_writew(epio, MUSB_RXCSR, rx_csr);
 
 			goto finish;
 		} else {
@@ -1802,6 +1811,9 @@ static int musb_schedule(
 
 	idle = 1;
 	qh->mux = 0;
+	/* disable NAK scheme when bulk is not multiplexed */
+	if (is_in && qh->type == USB_ENDPOINT_XFER_BULK && bulk_nak_timeout)
+		qh->intv_reg = 0;
 	hw_ep = musb->endpoints + best_end;
 	if (is_in)
 		musb->in[best_end] = qh;
@@ -1912,6 +1924,17 @@ static int musb_urb_enqueue(
 	case USB_ENDPOINT_XFER_ISOC:
 		/* iso always uses log encoding */
 		break;
+	case USB_ENDPOINT_XFER_BULK:
+		/* Enable bulk NAK time out scheme when bulk requests are
+		 * multiplxed.This scheme doen't work in high speed to full
+		 * speed scenario as NAK interrupts are not coming from a
+		 * full speed device connected to a high speed device.
+		 */
+		if (usb_pipein(urb->pipe) && bulk_nak_timeout) {
+			interval = 8;
+			break;
+		}
+		/* FALLTHROUGH */
 	default:
 		/* REVISIT we actually want to use NAK limits, hinting to the
 		 * transfer scheduling logic to try some other qh, e.g. try
@@ -2265,6 +2288,47 @@ static int musb_bus_resume(struct usb_hcd *hcd)
 	return 0;
 }
 
+static void musb_bulk_nak_timeout(struct musb *musb, struct musb_hw_ep *ep)
+{
+	struct dma_channel	*dma;
+	struct urb	*urb;
+	void __iomem	*mbase = musb->mregs;
+	void __iomem	*epio = ep->regs;
+	struct musb_qh	*cur_qh, *next_qh;
+	u16	rx_csr;
+
+	musb_ep_select(mbase, ep->epnum);
+	dma = is_dma_capable() ? ep->rx_channel : NULL;
+
+	/* clear nak timeout bit */
+	rx_csr = musb_readw(epio, MUSB_RXCSR);
+	rx_csr &= ~MUSB_RXCSR_DATAERROR;
+	musb_writew(epio, MUSB_RXCSR, rx_csr);
+
+	cur_qh = first_qh(&musb->in_bulk);
+	if (cur_qh) {
+		urb = next_urb(cur_qh);
+		if (dma_channel_status(dma) == MUSB_DMA_STATUS_BUSY) {
+			dma->status = MUSB_DMA_STATUS_CORE_ABORT;
+			musb->dma_controller->channel_abort(dma);
+			urb->actual_length += dma->actual_len;
+			dma->actual_len = 0L;
+		}
+		musb_save_toggle(ep, 1, urb);
+
+		/* delete cur_qh and add to tail to musb->in_bulk */
+		list_del(&cur_qh->ring);
+		list_add_tail(&cur_qh->ring, &musb->in_bulk);
+
+		/* get the next qh from musb->in_bulk */
+		next_qh = first_qh(&musb->in_bulk);
+
+		/* set rx_reinit and schedule the next qh */
+		ep->rx_reinit = 1;
+		musb_start_urb(musb, 1, next_qh);
+	}
+}
+
 const struct hc_driver musb_hc_driver = {
 	.description		= "musb-hcd",
 	.product_desc		= "MUSB HDRC host driver",
-- 
1.5.6

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
