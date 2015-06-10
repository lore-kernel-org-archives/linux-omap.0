From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH 5/5] usb: dwc3: ep0: handle non maxpacket aligned transfers > 512
Date: Wed, 10 Jun 2015 14:48:52 +0530
Message-ID: <1433927932-32395-6-git-send-email-kishon@ti.com>
References: <1433927932-32395-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:37512 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754127AbbFJJTO (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 10 Jun 2015 05:19:14 -0400
In-Reply-To: <1433927932-32395-1-git-send-email-kishon@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: nsekhar@ti.com, kishon@ti.com, gregkh@linuxfoundation.org

Use chained TRB mechanism to handle non maxpacket aligned transfers
greater than bounce buffer size. With this the first TRB will be programmed
to receive 'ALIGN(ur->length - maxp, maxp)' data and the second TRB
will be programmed to receive the remaining data using bounce buffer.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/usb/dwc3/ep0.c |   42 ++++++++++++++++++++++++++++--------------
 1 file changed, 28 insertions(+), 14 deletions(-)

diff --git a/drivers/usb/dwc3/ep0.c b/drivers/usb/dwc3/ep0.c
index 6847afe..4c777fe 100644
--- a/drivers/usb/dwc3/ep0.c
+++ b/drivers/usb/dwc3/ep0.c
@@ -830,13 +830,26 @@ static void dwc3_ep0_complete_data(struct dwc3 *dwc,
 	maxp = ep0->endpoint.maxpacket;
 
 	if (dwc->ep0_bounced) {
+		/*
+		 * Handle the first TRB before handling the bounce buffer if
+		 * the request length is greater than the bounce buffer size
+		 */
+		if (ur->length > DWC3_EP0_BOUNCE_SIZE) {
+			transfer_size = ALIGN(ur->length - maxp, maxp);
+			transferred = transfer_size - length;
+			buf = (u8 *)buf + transferred;
+			ur->actual += transferred;
+			remaining_ur_length -= transferred;
+
+			trb++;
+			length = trb->size & DWC3_TRB_SIZE_MASK;
+
+			ep0->free_slot = 0;
+		}
+
 		transfer_size = roundup((ur->length - transfer_size),
 					maxp);
 
-		/* Maximum of DWC3_EP0_BOUNCE_SIZE can only be received */
-		if (transfer_size > DWC3_EP0_BOUNCE_SIZE)
-			transfer_size = DWC3_EP0_BOUNCE_SIZE;
-
 		transferred = min_t(u32, remaining_ur_length,
 				    transfer_size - length);
 		memcpy(buf, dwc->ep0_bounce, transferred);
@@ -959,21 +972,22 @@ static void __dwc3_ep0_do_control_data(struct dwc3 *dwc,
 		}
 
 		maxpacket = dep->endpoint.maxpacket;
-		transfer_size = roundup((req->request.length - transfer_size),
-					maxpacket);
 
-		if (transfer_size > DWC3_EP0_BOUNCE_SIZE) {
-			dev_WARN(dwc->dev, "bounce buf can't handle req len\n");
-			transfer_size = DWC3_EP0_BOUNCE_SIZE;
+		if (req->request.length > DWC3_EP0_BOUNCE_SIZE) {
+			transfer_size = ALIGN(req->request.length - maxpacket,
+					      maxpacket);
+			ret = dwc3_ep0_start_trans(dwc, dep->number,
+						   req->request.dma,
+						   transfer_size,
+						   DWC3_TRBCTL_CONTROL_DATA,
+						   true);
 		}
 
+		transfer_size = roundup((req->request.length - transfer_size),
+					maxpacket);
+
 		dwc->ep0_bounced = true;
 
-		/*
-		 * REVISIT in case request length is bigger than
-		 * DWC3_EP0_BOUNCE_SIZE we will need two chained
-		 * TRBs to handle the transfer.
-		 */
 		ret = dwc3_ep0_start_trans(dwc, dep->number,
 				dwc->ep0_bounce_addr, transfer_size,
 				DWC3_TRBCTL_CONTROL_DATA, false);
-- 
1.7.9.5

