From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 06/12] usb: musb: Remove ifdefs for TX DMA for musb_host.c
Date: Fri,  1 May 2015 12:29:32 -0700
Message-ID: <1430508578-5208-7-git-send-email-tony@atomide.com>
References: <1430508578-5208-1-git-send-email-tony@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from tkt-001-i373.relay.mailchannels.net ([174.136.5.175]:2365 "EHLO
	relay.mailchannels.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751087AbbEATaG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 May 2015 15:30:06 -0400
In-Reply-To: <1430508578-5208-1-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Bin Liu <b-liu@ti.com>, George Cherian <george.cherian@ti.com>, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org

We can remove the ifdefs by setting up helper functions for
mentor DMA and cppi/tusb DMA.

Note that I've kept the existing formatting as otherwise this
patch becomes pretty much unreadable.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/usb/musb/musb_host.c | 61 ++++++++++++++++++++++++++++++++++----------
 1 file changed, 48 insertions(+), 13 deletions(-)

diff --git a/drivers/usb/musb/musb_host.c b/drivers/usb/musb/musb_host.c
index df982b9..fc036ed 100644
--- a/drivers/usb/musb/musb_host.c
+++ b/drivers/usb/musb/musb_host.c
@@ -617,23 +617,22 @@ musb_rx_reinit(struct musb *musb, struct musb_qh *qh, struct musb_hw_ep *ep)
 	ep->rx_reinit = 0;
 }
 
-static bool musb_tx_dma_program(struct dma_controller *dma,
+static int musb_tx_dma_set_mode_mentor(struct dma_controller *dma,
 		struct musb_hw_ep *hw_ep, struct musb_qh *qh,
-		struct urb *urb, u32 offset, u32 length)
+		struct urb *urb, u32 offset,
+		u32 *length, u8 *mode)
 {
 	struct dma_channel	*channel = hw_ep->tx_channel;
 	void __iomem		*epio = hw_ep->regs;
 	u16			pkt_size = qh->maxpacket;
 	u16			csr;
-	u8			mode;
 
-#if defined(CONFIG_USB_INVENTRA_DMA) || defined(CONFIG_USB_UX500_DMA)
-	if (length > channel->max_len)
-		length = channel->max_len;
+	if (*length > channel->max_len)
+		*length = channel->max_len;
 
 	csr = musb_readw(epio, MUSB_TXCSR);
-	if (length > pkt_size) {
-		mode = 1;
+	if (*length > pkt_size) {
+		*mode = 1;
 		csr |= MUSB_TXCSR_DMAMODE | MUSB_TXCSR_DMAENAB;
 		/* autoset shouldn't be set in high bandwidth */
 		/*
@@ -649,15 +648,28 @@ static bool musb_tx_dma_program(struct dma_controller *dma,
 					can_bulk_split(hw_ep->musb, qh->type)))
 			csr |= MUSB_TXCSR_AUTOSET;
 	} else {
-		mode = 0;
+		*mode = 0;
 		csr &= ~(MUSB_TXCSR_AUTOSET | MUSB_TXCSR_DMAMODE);
 		csr |= MUSB_TXCSR_DMAENAB; /* against programmer's guide */
 	}
 	channel->desired_mode = mode;
 	musb_writew(epio, MUSB_TXCSR, csr);
-#else
+
+	return 0;
+}
+
+static int musb_tx_dma_set_mode_cppi_tusb(struct dma_controller *dma,
+					  struct musb_hw_ep *hw_ep,
+					  struct musb_qh *qh,
+					  struct urb *urb,
+					  u32 offset,
+					  u32 *length,
+					  u8 *mode)
+{
+	struct dma_channel *channel = hw_ep->tx_channel;
+
 	if (!is_cppi_enabled(hw_ep->musb) && !tusb_dma_omap(hw_ep->musb))
-		return false;
+		return -ENODEV;
 
 	channel->actual_len = 0;
 
@@ -665,8 +677,28 @@ static bool musb_tx_dma_program(struct dma_controller *dma,
 	 * TX uses "RNDIS" mode automatically but needs help
 	 * to identify the zero-length-final-packet case.
 	 */
-	mode = (urb->transfer_flags & URB_ZERO_PACKET) ? 1 : 0;
-#endif
+	*mode = (urb->transfer_flags & URB_ZERO_PACKET) ? 1 : 0;
+
+	return 0;
+}
+
+static bool musb_tx_dma_program(struct dma_controller *dma,
+		struct musb_hw_ep *hw_ep, struct musb_qh *qh,
+		struct urb *urb, u32 offset, u32 length)
+{
+	struct dma_channel	*channel = hw_ep->tx_channel;
+	u16			pkt_size = qh->maxpacket;
+	u8			mode;
+	int			res;
+
+	if (musb_dma_inventra(hw_ep->musb) || musb_dma_ux500(hw_ep->musb))
+		res = musb_tx_dma_set_mode_mentor(dma, hw_ep, qh, urb,
+						 offset, &length, &mode);
+	else
+		res = musb_tx_dma_set_mode_cppi_tusb(dma, hw_ep, qh, urb,
+						     offset, &length, &mode);
+	if (res)
+		return false;
 
 	qh->segsize = length;
 
@@ -678,6 +710,9 @@ static bool musb_tx_dma_program(struct dma_controller *dma,
 
 	if (!dma->channel_program(channel, pkt_size, mode,
 			urb->transfer_dma + offset, length)) {
+		void __iomem *epio = hw_ep->regs;
+		u16 csr;
+
 		dma->channel_release(channel);
 		hw_ep->tx_channel = NULL;
 
-- 
2.1.4

