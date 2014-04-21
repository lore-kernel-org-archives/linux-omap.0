From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH 01/10] usb: dwc3: gadget: clear stall when disabling endpoint
Date: Mon, 21 Apr 2014 10:56:43 -0500
Message-ID: <1398095812-14222-2-git-send-email-balbi@ti.com>
References: <1398095812-14222-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:43399 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750772AbaDUP7R (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 21 Apr 2014 11:59:17 -0400
In-Reply-To: <1398095812-14222-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linux USB Mailing List <linux-usb@vger.kernel.org>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, leigh@solinno.co.uk, Tony Lindgren <tony@atomide.com>, Felipe Balbi <balbi@ti.com>, stable@vger.kernel.org

so it seems like DWC3 IP doesn't clear stalls
automatically when we disable an endpoint, because
of that, we _must_ make sure stalls are cleared
before clearing the proper bit in DALEPENA register.

Cc: <stable@vger.kernel.org> # v3.4+
Reported-by: Johannes Stezenbach <js@sig21.net>
Signed-off-by: Felipe Balbi <balbi@ti.com>
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

