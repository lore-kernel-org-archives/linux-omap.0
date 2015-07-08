From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH v3 9/9] usb: dwc3: core: don't break during suspend/resume while we're dual-role
Date: Wed, 8 Jul 2015 13:37:40 +0300
Message-ID: <1436351860-28813-1-git-send-email-rogerq@ti.com>
References: <1436351524-28385-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1436351524-28385-1-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: balbi@ti.com
Cc: tony@atomide.com, Joao.Pinto@synopsys.com, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

We can't rely just on dr_mode to decide if we're in host or gadget
mode when we're configured as otg/dual-role. So while dr_mode is
OTG, we find out from  the otg state machine if we're in host
or gadget mode and take the necessary actions during suspend/resume.

Also make sure that we disable OTG irq and events during system suspend
so that we don't lockup the system during system suspend/resume.

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 drivers/usb/dwc3/core.c | 27 +++++++++------------------
 1 file changed, 9 insertions(+), 18 deletions(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index e3c094d..3784287 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -1444,18 +1444,15 @@ static int dwc3_suspend(struct device *dev)
 		dwc->octl = dwc3_readl(dwc->regs, DWC3_OCTL);
 		dwc->oevt = dwc3_readl(dwc->regs, DWC3_OEVT);
 		dwc->oevten = dwc3_readl(dwc->regs, DWC3_OEVTEN);
+		dwc3_writel(dwc->regs, DWC3_OEVTEN, 0);
+		disable_irq(dwc->otg_irq);
 	}
 
-	switch (dwc->dr_mode) {
-	case USB_DR_MODE_PERIPHERAL:
-	case USB_DR_MODE_OTG:
+	if (dwc->dr_mode == USB_DR_MODE_PERIPHERAL ||
+	    ((dwc->dr_mode == USB_DR_MODE_OTG) && dwc->fsm->protocol == PROTO_GADGET))
 		dwc3_gadget_suspend(dwc);
-		/* FALLTHROUGH */
-	case USB_DR_MODE_HOST:
-	default:
-		dwc3_event_buffers_cleanup(dwc);
-		break;
-	}
+
+	dwc3_event_buffers_cleanup(dwc);
 
 	dwc->gctl = dwc3_readl(dwc->regs, DWC3_GCTL);
 	spin_unlock_irqrestore(&dwc->lock, flags);
@@ -1495,18 +1492,12 @@ static int dwc3_resume(struct device *dev)
 		dwc3_writel(dwc->regs, DWC3_OCTL, dwc->octl);
 		dwc3_writel(dwc->regs, DWC3_OEVT, dwc->oevt);
 		dwc3_writel(dwc->regs, DWC3_OEVTEN, dwc->oevten);
+		enable_irq(dwc->otg_irq);
 	}
 
-	switch (dwc->dr_mode) {
-	case USB_DR_MODE_PERIPHERAL:
-	case USB_DR_MODE_OTG:
+	if (dwc->dr_mode == USB_DR_MODE_PERIPHERAL ||
+	    ((dwc->dr_mode == USB_DR_MODE_OTG) && dwc->fsm->protocol == PROTO_GADGET))
 		dwc3_gadget_resume(dwc);
-		/* FALLTHROUGH */
-	case USB_DR_MODE_HOST:
-	default:
-		/* do nothing */
-		break;
-	}
 
 	spin_unlock_irqrestore(&dwc->lock, flags);
 
-- 
2.1.4
