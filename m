From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v3 1/6] usb: dwc3: ep0: Fix mem corruption on OUT transfers of more than 512 bytes
Date: Mon, 27 Jul 2015 12:25:27 +0530
Message-ID: <1437980132-20232-2-git-send-email-kishon@ti.com>
References: <1437980132-20232-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1437980132-20232-1-git-send-email-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: balbi@ti.com, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: gregkh@linuxfoundation.org, kishon@ti.com, nsekhar@ti.com
List-Id: linux-omap@vger.kernel.org

DWC3 uses bounce buffer to handle non max packet aligned OUT transfers and
the size of bounce buffer is 512 bytes. However if the host initiates OUT
transfers of size more than 512 bytes (and non max packet aligned), the
driver throws a WARN dump but still programs the TRB to receive more than
512 bytes. This will cause bounce buffer to overflow and corrupt the
adjacent memory locations which can be fatal.

Fix it by programming the TRB to receive a maximum of DWC3_EP0_BOUNCE_SIZE
(512) bytes.

Cc: <stable@vger.kernel.org> # 3.4+
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/usb/dwc3/ep0.c |   12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/dwc3/ep0.c b/drivers/usb/dwc3/ep0.c
index 2ef3c8d..8858c60 100644
--- a/drivers/usb/dwc3/ep0.c
+++ b/drivers/usb/dwc3/ep0.c
@@ -816,6 +816,11 @@ static void dwc3_ep0_complete_data(struct dwc3 *dwc,
 		unsigned maxp = ep0->endpoint.maxpacket;
 
 		transfer_size += (maxp - (transfer_size % maxp));
+
+		/* Maximum of DWC3_EP0_BOUNCE_SIZE can only be received */
+		if (transfer_size > DWC3_EP0_BOUNCE_SIZE)
+			transfer_size = DWC3_EP0_BOUNCE_SIZE;
+
 		transferred = min_t(u32, ur->length,
 				transfer_size - length);
 		memcpy(ur->buf, dwc->ep0_bounce, transferred);
@@ -937,11 +942,14 @@ static void __dwc3_ep0_do_control_data(struct dwc3 *dwc,
 			return;
 		}
 
-		WARN_ON(req->request.length > DWC3_EP0_BOUNCE_SIZE);
-
 		maxpacket = dep->endpoint.maxpacket;
 		transfer_size = roundup(req->request.length, maxpacket);
 
+		if (transfer_size > DWC3_EP0_BOUNCE_SIZE) {
+			dev_WARN(dwc->dev, "bounce buf can't handle req len\n");
+			transfer_size = DWC3_EP0_BOUNCE_SIZE;
+		}
+
 		dwc->ep0_bounced = true;
 
 		/*
-- 
1.7.9.5
