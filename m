From: Zhuang Jin Can <jin.can.zhuang@intel.com>
Subject: [PATCH] usb: dwc3: gadget: giveback request if start transfer fail
Date: Thu, 1 May 2014 02:36:08 -0400
Message-ID: <20140501063608.GA30575@intel.com>
Reply-To: jin.can.zhuang@intel.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

At least we should giveback the current request to the
gadget. Otherwise, the gadget will be stuck without knowing
anything.

It was oberved that the failure can happen if the request is
queued when the run/stop bit of controller is not set.

Signed-off-by: Zhuang Jin Can <jin.can.zhuang@intel.com>
---
 drivers/usb/dwc3/gadget.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 70715ee..8d0c3c7 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -1000,9 +1000,7 @@ static int __dwc3_gadget_kick_transfer(struct dwc3_ep *dep, u16 cmd_param,
 		 * here and stop, unmap, free and del each of the linked
 		 * requests instead of what we do now.
 		 */
-		usb_gadget_unmap_request(&dwc->gadget, &req->request,
-				req->direction);
-		list_del(&req->list);
+		dwc3_gadget_giveback(dep, req, -ESHUTDOWN);
 		return ret;
 	}
 
-- 
1.7.9.5
