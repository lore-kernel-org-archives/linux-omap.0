From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 1/8] usb: dwc3: gadget: clear stall when disabling endpoint
Date: Wed, 16 Apr 2014 16:26:28 -0500
Message-ID: <1397683595-3606-2-git-send-email-balbi@ti.com>
References: <1397683595-3606-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1397683595-3606-1-git-send-email-balbi-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linux USB Mailing List <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>, Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>, George Cherian <george.cherian-l0cyMroinI0@public.gmane.org>, bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, aaro.koskinen-X3B1VOXEql0@public.gmane.org, heikki.krogerus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, zhangwm-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org, David Cohen <david.a.cohen-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

so it seems like DWC3 IP doesn't clear stalls
automatically when we disable an endpoint, because
of that, we _must_ make sure stalls are cleared
before clearing the proper bit in DALEPENA register.

Cc: <stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org> # v3.4+
Reported-by: Johannes Stezenbach <js-FF7aIK3TAVNeoWH0uzbU5w@public.gmane.org>
Signed-off-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
---
 drivers/usb/dwc3/gadget.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index a740eac..f0dc0ee 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -608,6 +608,10 @@ static int __dwc3_gadget_ep_disable(struct dwc3_ep *dep)
 
 	dwc3_remove_requests(dwc, dep);
 
+	/* make sure HW endpoint isn't stalled */
+	if (dep->flags & DWC3_EP_STALL)
+		__dwc3_gadget_ep_set_halt(dep, 0);
+
 	reg = dwc3_readl(dwc->regs, DWC3_DALEPENA);
 	reg &= ~DWC3_DALEPENA_EP(dep->number);
 	dwc3_writel(dwc->regs, DWC3_DALEPENA, reg);
-- 
1.9.2.459.g68773ac

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
