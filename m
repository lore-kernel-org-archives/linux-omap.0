From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 08/12] usb: musb: Remove ifdefs for musb_host_rx in musb_host.c part2
Date: Fri,  1 May 2015 12:29:34 -0700
Message-ID: <1430508578-5208-9-git-send-email-tony@atomide.com>
References: <1430508578-5208-1-git-send-email-tony@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from tkt-001-i374.relay.mailchannels.net ([174.136.5.177]:52852 "EHLO
	relay.mailchannels.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751885AbbEATf6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 May 2015 15:35:58 -0400
In-Reply-To: <1430508578-5208-1-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Bin Liu <b-liu@ti.com>, George Cherian <george.cherian@ti.com>, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org

Remove ifdefs for musb_host_rx to get closer to building in
all the DMA drivers.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/usb/musb/musb_host.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/musb/musb_host.c b/drivers/usb/musb/musb_host.c
index 75d50c8..739da2a 100644
--- a/drivers/usb/musb/musb_host.c
+++ b/drivers/usb/musb/musb_host.c
@@ -1734,9 +1734,8 @@ void musb_host_rx(struct musb *musb, u8 epnum)
 	 */
 
 	/* FIXME this is _way_ too much in-line logic for Mentor DMA */
-
-#if !defined(CONFIG_USB_INVENTRA_DMA) && !defined(CONFIG_USB_UX500_DMA)
-	if (rx_csr & MUSB_RXCSR_H_REQPKT)  {
+	if (!musb_dma_inventra(musb) && !musb_dma_ux500(musb) &&
+	    (rx_csr & MUSB_RXCSR_H_REQPKT)) {
 		/* REVISIT this happened for a while on some short reads...
 		 * the cleanup still needs investigation... looks bad...
 		 * and also duplicates dma cleanup code above ... plus,
@@ -1757,7 +1756,7 @@ void musb_host_rx(struct musb *musb, u8 epnum)
 		musb_writew(epio, MUSB_RXCSR,
 				MUSB_RXCSR_H_WZC_BITS | rx_csr);
 	}
-#endif
+
 	if (dma && (rx_csr & MUSB_RXCSR_DMAENAB)) {
 		xfer_len = dma->actual_len;
 
-- 
2.1.4

