From: Fabian Frederick <fabf@skynet.be>
Subject: [PATCH 03/10 linux-next] usb: dcw3: remove unnecessary break after return
Date: Thu, 24 Jul 2014 10:18:51 +0200
Message-ID: <1406189939-6433-4-git-send-email-fabf@skynet.be>
References: <1406189939-6433-1-git-send-email-fabf@skynet.be>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1406189939-6433-1-git-send-email-fabf@skynet.be>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: joe@perches.com, gregkh@linuxfoundation.org, Fabian Frederick <fabf@skynet.be>, Felipe Balbi <balbi@ti.com>, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Signed-off-by: Fabian Frederick <fabf@skynet.be>
---
 drivers/usb/dwc3/ep0.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/usb/dwc3/ep0.c b/drivers/usb/dwc3/ep0.c
index 21a3520..927dad3 100644
--- a/drivers/usb/dwc3/ep0.c
+++ b/drivers/usb/dwc3/ep0.c
@@ -422,7 +422,6 @@ static int dwc3_ep0_handle_feature(struct dwc3 *dwc,
 
 		case USB_DEVICE_LTM_ENABLE:
 			return -EINVAL;
-			break;
 
 		case USB_DEVICE_TEST_MODE:
 			if ((wIndex & 0xff) != 0)
@@ -530,7 +529,6 @@ static int dwc3_ep0_set_config(struct dwc3 *dwc, struct usb_ctrlrequest *ctrl)
 	switch (state) {
 	case USB_STATE_DEFAULT:
 		return -EINVAL;
-		break;
 
 	case USB_STATE_ADDRESS:
 		ret = dwc3_ep0_delegate_req(dwc, ctrl);
-- 
1.8.4.5
