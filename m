From: George Cherian <george.cherian@ti.com>
Subject: [PATCH 1/4] usb: dwc3: gadget: free trb pool only from epnum 2
Date: Mon, 27 May 2013 14:35:49 +0530
Message-ID: <1369645549-14867-1-git-send-email-george.cherian@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: balbi@ti.com, gregkh@linuxfoundation.org, George Cherian <george.cherian@ti.com>
List-Id: linux-omap@vger.kernel.org

we never allocate a TRB pool for physical endpoints
0 and 1 so trying to free it (a invalid TRB pool pointer)
will lead us in a warning while removing dwc3.ko module.

In order to fix the situation, all we have to do is skip
dwc3_free_trb_pool() for physical endpoints 0 and 1 just
as we while deleting endpoints from the endpoints list.

Signed-off-by: George Cherian <george.cherian@ti.com>
Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/usb/dwc3/gadget.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 2b6e7e0..1c246f9 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -1706,12 +1706,20 @@ static void dwc3_gadget_free_endpoints(struct dwc3 *dwc)
 		dep = dwc->eps[epnum];
 		if (!dep)
 			continue;
+		/*
+		 * physical endpoints 0 and 1 are special. They form the
+		 * bi-directional USB endpoint 0.
+		 *
+		 * For those two physical endpoints, we don't allocate a TRB
+		 * pool nor do we add them the endpoints list. Due to that, we
+		 * should these two operations otherwise we would end up with
+		 * all sorts of bugs when removing dwc3.ko.
+		 */
 
-		dwc3_free_trb_pool(dep);
-
-		if (epnum != 0 && epnum != 1)
+		if (epnum != 0 && epnum != 1) {
+			dwc3_free_trb_pool(dep);
 			list_del(&dep->endpoint.ep_list);
-
+		}
 		kfree(dep);
 	}
 }
-- 
1.8.1.4
