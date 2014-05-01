From: Zhuang Jin Can <jin.can.zhuang@intel.com>
Subject: [PATCH] usb: dwc3: gadget: fix burst size corruption
Date: Thu, 1 May 2014 03:16:04 -0400
Message-ID: <20140501071604.GB30575@intel.com>
Reply-To: jin.can.zhuang@intel.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

endpoint.maxburst may be 0 if a gadget doesn't call config_ep_by_speed()
to update it from the companion descriptor.
And endpoint.maxburst - 1 returns 11111b which wrongly sets bit
26 of endpoint parameter 0.
This sets a wrong endpoint state and will cause "Get Endpoint State"
command can't get the corret endpoint state and "Set Endpoint Config"
command can't restore the correct endpoint state during hibernation
resume flow.
Thus, when endpoint.maxburst is 0, we should set burst as 0 directly.

Signed-off-by: Zhuang Jin Can <jin.can.zhuang@intel.com>
---
 drivers/usb/dwc3/gadget.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 70715ee..44eca95 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -440,7 +440,8 @@ static int dwc3_gadget_set_ep_config(struct dwc3 *dwc, struct dwc3_ep *dep,
 
 	/* Burst size is only needed in SuperSpeed mode */
 	if (dwc->gadget.speed == USB_SPEED_SUPER) {
-		u32 burst = dep->endpoint.maxburst - 1;
+		u32 burst = dep->endpoint.maxburst ?
+				dep->endpoint.maxburst - 1 : 0;
 
 		params.param0 |= DWC3_DEPCFG_BURST_SIZE(burst);
 	}
-- 
1.7.9.5
