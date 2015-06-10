From: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 1/5] usb: dwc3: ep0: use _roundup_ to calculate the transfer size
Date: Wed, 10 Jun 2015 14:48:48 +0530
Message-ID: <1433927932-32395-2-git-send-email-kishon@ti.com>
References: <1433927932-32395-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1433927932-32395-1-git-send-email-kishon-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: balbi-l0cyMroinI0@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: nsekhar-l0cyMroinI0@public.gmane.org, kishon-l0cyMroinI0@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

No functional change. Used _roundup_ macro to calculate the transfer
size aligned to maxpacket in  dwc3_ep0_complete_data. It also makes it
similar to how transfer size is calculated in __dwc3_ep0_do_control_data.

Signed-off-by: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
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
