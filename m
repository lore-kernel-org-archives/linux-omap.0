From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v2 2/6] usb: dwc3: ep0: use _roundup_ to calculate the transfer size
Date: Fri, 24 Jul 2015 12:17:12 +0530
Message-ID: <1437720436-4261-3-git-send-email-kishon@ti.com>
References: <1437720436-4261-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1437720436-4261-1-git-send-email-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: balbi@ti.com, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: gregkh@linuxfoundation.org, kishon@ti.com, nsekhar@ti.com
List-Id: linux-omap@vger.kernel.org

No functional change. Used _roundup_ macro to calculate the transfer
size aligned to maxpacket in  dwc3_ep0_complete_data. It also makes it
similar to how transfer size is calculated in __dwc3_ep0_do_control_data.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/usb/dwc3/ep0.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/usb/dwc3/ep0.c b/drivers/usb/dwc3/ep0.c
index 8858c60..713e46a 100644
--- a/drivers/usb/dwc3/ep0.c
+++ b/drivers/usb/dwc3/ep0.c
@@ -812,10 +812,8 @@ static void dwc3_ep0_complete_data(struct dwc3 *dwc,
 	length = trb->size & DWC3_TRB_SIZE_MASK;
 
 	if (dwc->ep0_bounced) {
-		unsigned transfer_size = ur->length;
 		unsigned maxp = ep0->endpoint.maxpacket;
-
-		transfer_size += (maxp - (transfer_size % maxp));
+		unsigned transfer_size = roundup(ur->length, maxp);
 
 		/* Maximum of DWC3_EP0_BOUNCE_SIZE can only be received */
 		if (transfer_size > DWC3_EP0_BOUNCE_SIZE)
-- 
1.7.9.5
