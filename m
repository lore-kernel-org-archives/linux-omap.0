From: Zhuang Jin Can <jin.can.zhuang@intel.com>
Subject: [PATCH] usb: dwc3: gadget: Fix desc NULL pointer in
 dwc3_gadget_ep_queue()
Date: Wed, 3 Sep 2014 14:26:34 +0800
Message-ID: <20140903062634.GA27870@intel.com>
Reply-To: jin.can.zhuang@intel.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: balbi@ti.com
Cc: david.a.cohen@intel.com, jiebing.li@intel.com, hang.yuan@intel.com, hao.wu@intel.com, gregkh@linuxfoundation.org, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

dep->endpoint.desc is checked at the beginning of
dwc3_gadget_ep_queue(), but after that it may be set to NULL
by another thread and then accessed again in dwc3_gadget_ep_queue().
This will lead to kernel oops.

Expand spinlock protection area to aviod race condition.

Signed-off-by: Zhuang Jin Can <jin.can.zhuang@intel.com>
Signed-off-by: Jiebing Li <jiebing.li@intel.com>
---
 drivers/usb/dwc3/gadget.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 349cacc..e8fb231 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -1225,16 +1225,17 @@ static int dwc3_gadget_ep_queue(struct usb_ep *ep, struct usb_request *request,
 
 	int				ret;
 
+	spin_lock_irqsave(&dwc->lock, flags);
 	if (!dep->endpoint.desc) {
 		dev_dbg(dwc->dev, "trying to queue request %p to disabled %s\n",
 				request, ep->name);
+		spin_unlock_irqrestore(&dwc->lock, flags);
 		return -ESHUTDOWN;
 	}
 
 	dev_vdbg(dwc->dev, "queing request %p to %s length %d\n",
 			request, ep->name, request->length);
 
-	spin_lock_irqsave(&dwc->lock, flags);
 	ret = __dwc3_gadget_ep_queue(dep, req);
 	spin_unlock_irqrestore(&dwc->lock, flags);
 
-- 
1.7.9.5
