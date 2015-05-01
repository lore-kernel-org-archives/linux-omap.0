From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 04/12] usb: musb: Remove DMA ifdef for musb_gadget.c short_packet
Date: Fri,  1 May 2015 12:29:30 -0700
Message-ID: <1430508578-5208-5-git-send-email-tony@atomide.com>
References: <1430508578-5208-1-git-send-email-tony@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from tkt-001-i374.relay.mailchannels.net ([174.136.5.177]:24378 "EHLO
	relay.mailchannels.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751201AbbEATf4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 May 2015 15:35:56 -0400
In-Reply-To: <1430508578-5208-1-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Bin Liu <b-liu@ti.com>, George Cherian <george.cherian@ti.com>, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org

Let's get rid of the horrible ifdef in middle of the expression.
We can do it by adding a variable for short_packet and testing
it separately for DMA related code.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/usb/musb/musb_gadget.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/musb/musb_gadget.c b/drivers/usb/musb/musb_gadget.c
index a94db12..625d482f 100644
--- a/drivers/usb/musb/musb_gadget.c
+++ b/drivers/usb/musb/musb_gadget.c
@@ -489,6 +489,7 @@ void musb_g_tx(struct musb *musb, u8 epnum)
 
 	if (request) {
 		u8	is_dma = 0;
+		bool	short_packet = false;
 
 		if (dma && (csr & MUSB_TXCSR_DMAENAB)) {
 			is_dma = 1;
@@ -507,15 +508,18 @@ void musb_g_tx(struct musb *musb, u8 epnum)
 		 * First, maybe a terminating short packet. Some DMA
 		 * engines might handle this by themselves.
 		 */
-		if ((request->zero && request->length
+		if ((request->zero && request->length)
 			&& (request->length % musb_ep->packet_sz == 0)
 			&& (request->actual == request->length))
-#if defined(CONFIG_USB_INVENTRA_DMA) || defined(CONFIG_USB_UX500_DMA)
-			|| (is_dma && (!dma->desired_mode ||
+				short_packet = true;
+
+		if ((musb_dma_inventra(musb) || musb_dma_ux500(musb)) &&
+			(is_dma && (!dma->desired_mode ||
 				(request->actual &
-					(musb_ep->packet_sz - 1))))
-#endif
-		) {
+					(musb_ep->packet_sz - 1)))))
+				short_packet = true;
+
+		if (short_packet) {
 			/*
 			 * On DMA completion, FIFO may not be
 			 * available yet...
-- 
2.1.4

