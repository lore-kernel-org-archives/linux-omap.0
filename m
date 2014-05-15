From: Zhuang Jin Can <jin.can.zhuang@intel.com>
Subject: [PATCH] usb: dwc3: gadget: check link trb after free_slot is
 increased
Date: Fri, 16 May 2014 05:57:57 +0800
Message-ID: <20140515215757.GD16153@intel.com>
Reply-To: jin.can.zhuang@intel.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: USB list <linux-usb@vger.kernel.org>, linux-omap@vger.kernel.org, Kernel development list <linux-kernel@vger.kernel.org>, david.a.cohen@linux.intel.com, Yuan@intel.com, Hang <hang.yuan@intel.com>, Zhuang@intel.com, Jin Can <jin.can.zhuang@intel.com>, Li@intel.com, Jiebing <jiebing.li@intel.com>
List-Id: linux-omap@vger.kernel.org

In ISOC transfers, when free_slot points to the last TRB (i.e. Link
TRB), and all queued requests meet Missed Interval Isoc error, busy_slot
points to trb0.
	busy_slot->trb0
		   trb1
		   ...
	free_slot->trb31(Link TRB)

After end transfer and receiving the XferNotReady event, trb_left is
caculated as 1 which is wrong, and no TRB will be primed to the
endpoint.

The root cause is free_slot is not increased the same way as busy_slot.
When busy_slot is increased by one, it checks if points to a link TRB
after increasement, but free_slot checks it before increasement.
free_slot should behave the same as busy_slot to make the trb_left
caculation correct.

Signed-off-by: Zhuang Jin Can <jin.can.zhuang@intel.com>
Signed-off-by: Jiebing Li <jiebing.li@intel.com>
---
 drivers/usb/dwc3/gadget.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 54da8c8..2ebe82b 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -828,10 +828,6 @@ static void dwc3_prepare_one_trb(struct dwc3_ep *dep,
 			length, last ? " last" : "",
 			chain ? " chain" : "");
 
-	/* Skip the LINK-TRB on ISOC */
-	if (((dep->free_slot & DWC3_TRB_MASK) == DWC3_TRB_NUM - 1) &&
-			usb_endpoint_xfer_isoc(dep->endpoint.desc))
-		dep->free_slot++;
 
 	trb = &dep->trb_pool[dep->free_slot & DWC3_TRB_MASK];
 
@@ -843,6 +839,10 @@ static void dwc3_prepare_one_trb(struct dwc3_ep *dep,
 	}
 
 	dep->free_slot++;
+	/* Skip the LINK-TRB on ISOC */
+	if (((dep->free_slot & DWC3_TRB_MASK) == DWC3_TRB_NUM - 1) &&
+			usb_endpoint_xfer_isoc(dep->endpoint.desc))
+		dep->free_slot++;
 
 	trb->size = DWC3_TRB_SIZE_LENGTH(length);
 	trb->bpl = lower_32_bits(dma);
-- 
1.7.9.5
