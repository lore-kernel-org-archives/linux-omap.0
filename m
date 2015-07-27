From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v3 3/6] usb: dwc3: ep0: preparation for handling non maxpacket aligned transfers > 512
Date: Mon, 27 Jul 2015 12:25:29 +0530
Message-ID: <1437980132-20232-4-git-send-email-kishon@ti.com>
References: <1437980132-20232-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1437980132-20232-1-git-send-email-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: balbi@ti.com, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: gregkh@linuxfoundation.org, kishon@ti.com, nsekhar@ti.com
List-Id: linux-omap@vger.kernel.org

No functional change. This is in preparation for handling non maxpacket
aligned transfers greater than bounce buffer size. This is basically to
avoid code duplication when using chained TRB transfers to handle
non maxpacket aligned transfers greater than bounce buffer size.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/usb/dwc3/ep0.c |   25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/drivers/usb/dwc3/ep0.c b/drivers/usb/dwc3/ep0.c
index 713e46a..4998074 100644
--- a/drivers/usb/dwc3/ep0.c
+++ b/drivers/usb/dwc3/ep0.c
@@ -779,7 +779,11 @@ static void dwc3_ep0_complete_data(struct dwc3 *dwc,
 	struct usb_request	*ur;
 	struct dwc3_trb		*trb;
 	struct dwc3_ep		*ep0;
-	u32			transferred;
+	unsigned		transfer_size = 0;
+	unsigned		maxp;
+	unsigned		remaining_ur_length;
+	void			*buf;
+	u32			transferred = 0;
 	u32			status;
 	u32			length;
 	u8			epnum;
@@ -808,20 +812,24 @@ static void dwc3_ep0_complete_data(struct dwc3 *dwc,
 	}
 
 	ur = &r->request;
+	buf = ur->buf;
+	remaining_ur_length = ur->length;
 
 	length = trb->size & DWC3_TRB_SIZE_MASK;
 
+	maxp = ep0->endpoint.maxpacket;
+
 	if (dwc->ep0_bounced) {
-		unsigned maxp = ep0->endpoint.maxpacket;
-		unsigned transfer_size = roundup(ur->length, maxp);
+		transfer_size = roundup((ur->length - transfer_size),
+					maxp);
 
 		/* Maximum of DWC3_EP0_BOUNCE_SIZE can only be received */
 		if (transfer_size > DWC3_EP0_BOUNCE_SIZE)
 			transfer_size = DWC3_EP0_BOUNCE_SIZE;
 
-		transferred = min_t(u32, ur->length,
-				transfer_size - length);
-		memcpy(ur->buf, dwc->ep0_bounce, transferred);
+		transferred = min_t(u32, remaining_ur_length,
+				    transfer_size - length);
+		memcpy(buf, dwc->ep0_bounce, transferred);
 	} else {
 		transferred = ur->length - length;
 	}
@@ -930,7 +938,7 @@ static void __dwc3_ep0_do_control_data(struct dwc3 *dwc,
 				DWC3_TRBCTL_CONTROL_DATA);
 	} else if (!IS_ALIGNED(req->request.length, dep->endpoint.maxpacket)
 			&& (dep->number == 0)) {
-		u32	transfer_size;
+		u32	transfer_size = 0;
 		u32	maxpacket;
 
 		ret = usb_gadget_map_request(&dwc->gadget, &req->request,
@@ -941,7 +949,8 @@ static void __dwc3_ep0_do_control_data(struct dwc3 *dwc,
 		}
 
 		maxpacket = dep->endpoint.maxpacket;
-		transfer_size = roundup(req->request.length, maxpacket);
+		transfer_size = roundup((req->request.length - transfer_size),
+					maxpacket);
 
 		if (transfer_size > DWC3_EP0_BOUNCE_SIZE) {
 			dev_WARN(dwc->dev, "bounce buf can't handle req len\n");
-- 
1.7.9.5
