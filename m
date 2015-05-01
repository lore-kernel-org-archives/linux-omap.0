From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 07/12] usb: musb: Remove ifdefs for musb_host_rx in musb_host.c part1
Date: Fri,  1 May 2015 12:29:33 -0700
Message-ID: <1430508578-5208-8-git-send-email-tony@atomide.com>
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
 drivers/usb/musb/musb_host.c | 61 ++++++++++++++++++++++++++++++++------------
 1 file changed, 44 insertions(+), 17 deletions(-)

diff --git a/drivers/usb/musb/musb_host.c b/drivers/usb/musb/musb_host.c
index fc036ed..75d50c8 100644
--- a/drivers/usb/musb/musb_host.c
+++ b/drivers/usb/musb/musb_host.c
@@ -1533,6 +1533,44 @@ done:
 			MUSB_TXCSR_H_WZC_BITS | MUSB_TXCSR_TXPKTRDY);
 }
 
+#ifdef CONFIG_USB_TI_CPPI41_DMA
+/* Seems to set up ISO for cppi41 and not advance len. See commit c57c41d */
+static int musb_rx_dma_iso_cppi41(struct dma_controller *dma,
+				  struct musb_hw_ep *hw_ep,
+				  struct musb_qh *qh,
+				  struct urb *urb,
+				  size_t len)
+{
+	struct dma_channel *channel = hw_ep->tx_channel;
+	void __iomem *epio = hw_ep->regs;
+	dma_addr_t *buf;
+	u32 length, res;
+	u16 val;
+
+	buf = (void *)urb->iso_frame_desc[qh->iso_idx].offset +
+		(u32)urb->transfer_dma;
+
+	length = urb->iso_frame_desc[qh->iso_idx].length;
+
+	val = musb_readw(epio, MUSB_RXCSR);
+	val |= MUSB_RXCSR_DMAENAB;
+	musb_writew(hw_ep->regs, MUSB_RXCSR, val);
+
+	res = dma->channel_program(channel, qh->maxpacket, 0,
+				   (u32)buf, length);
+
+	return res;
+}
+#else
+static inline int musb_rx_dma_iso_cppi41(struct dma_controller *dma,
+					 struct musb_hw_ep *hw_ep,
+					 struct musb_qh *qh,
+					 struct urb *urb,
+					 size_t len)
+{
+	return false;
+}
+#endif
 
 #ifdef CONFIG_USB_INVENTRA_DMA
 
@@ -1746,25 +1784,14 @@ void musb_host_rx(struct musb *musb, u8 epnum)
 			if (++qh->iso_idx >= urb->number_of_packets) {
 				done = true;
 			} else {
-#if defined(CONFIG_USB_TI_CPPI41_DMA)
-				struct dma_controller   *c;
-				dma_addr_t *buf;
-				u32 length, ret;
+				struct dma_controller *c = musb->dma_controller;
 
-				c = musb->dma_controller;
-				buf = (void *)
-					urb->iso_frame_desc[qh->iso_idx].offset
-					+ (u32)urb->transfer_dma;
+				/* REVISIT: Why ignore return value here? */
+				if (musb_dma_cppi41(musb))
+					done = musb_rx_dma_iso_cppi41(c, hw_ep,
+								      qh, urb,
+								      xfer_len);
 
-				length =
-					urb->iso_frame_desc[qh->iso_idx].length;
-
-				val |= MUSB_RXCSR_DMAENAB;
-				musb_writew(hw_ep->regs, MUSB_RXCSR, val);
