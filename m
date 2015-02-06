From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [RFC PATCH 1/2] usb: dwc3: ep0: preparation for implementing chained TRB
Date: Fri, 6 Feb 2015 17:25:34 +0530
Message-ID: <1423223735-32512-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: balbi@ti.com
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org, kishon@ti.com
List-Id: linux-omap@vger.kernel.org

No functional change. Modified few things so that there are no
code duplication while implementing chained TRB.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/usb/dwc3/ep0.c |   23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/drivers/usb/dwc3/ep0.c b/drivers/usb/dwc3/ep0.c
index 2ef3c8d..24b7925 100644
--- a/drivers/usb/dwc3/ep0.c
+++ b/drivers/usb/dwc3/ep0.c
@@ -779,7 +779,10 @@ static void dwc3_ep0_complete_data(struct dwc3 *dwc,
 	struct usb_request	*ur;
 	struct dwc3_trb		*trb;
 	struct dwc3_ep		*ep0;
-	u32			transferred;
+	unsigned		transfer_size = 0;
+	unsigned		maxp;
+	void			*buf;
+	u32			transferred = 0;
 	u32			status;
 	u32			length;
 	u8			epnum;
@@ -808,16 +811,17 @@ static void dwc3_ep0_complete_data(struct dwc3 *dwc,
 	}
 
 	ur = &r->request;
+	buf = ur->buf;
 
 	length = trb->size & DWC3_TRB_SIZE_MASK;
 
-	if (dwc->ep0_bounced) {
-		unsigned transfer_size = ur->length;
-		unsigned maxp = ep0->endpoint.maxpacket;
+	maxp = ep0->endpoint.maxpacket;
 
-		transfer_size += (maxp - (transfer_size % maxp));
-		transferred = min_t(u32, ur->length,
-				transfer_size - length);
+	if (dwc->ep0_bounced) {
+		transfer_size = roundup((ur->length - transfer_size),
+					maxp);
+		transferred = min_t(u32, ur->length - transferred,
+				    transfer_size - length);
 		memcpy(ur->buf, dwc->ep0_bounce, transferred);
 	} else {
 		transferred = ur->length - length;
@@ -927,7 +931,7 @@ static void __dwc3_ep0_do_control_data(struct dwc3 *dwc,
 				DWC3_TRBCTL_CONTROL_DATA);
 	} else if (!IS_ALIGNED(req->request.length, dep->endpoint.maxpacket)
 			&& (dep->number == 0)) {
-		u32	transfer_size;
+		u32	transfer_size = 0;
 		u32	maxpacket;
 
 		ret = usb_gadget_map_request(&dwc->gadget, &req->request,
@@ -940,7 +944,8 @@ static void __dwc3_ep0_do_control_data(struct dwc3 *dwc,
 		WARN_ON(req->request.length > DWC3_EP0_BOUNCE_SIZE);
 
 		maxpacket = dep->endpoint.maxpacket;
-		transfer_size = roundup(req->request.length, maxpacket);
+		transfer_size = roundup((req->request.length - transfer_size),
+					maxpacket);
 
 		dwc->ep0_bounced = true;
 
-- 
1.7.9.5
