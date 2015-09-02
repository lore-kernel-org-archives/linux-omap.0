From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH v4 8/9] usb: dwc3: core: Prevent otg events from disabling themselves
Date: Wed, 2 Sep 2015 17:24:23 +0300
Message-ID: <1441203864-15786-9-git-send-email-rogerq@ti.com>
References: <1441203864-15786-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1441203864-15786-1-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: balbi@ti.com
Cc: tony@atomide.com, Joao.Pinto@synopsys.com, sergei.shtylyov@cogentembedded.com, peter.chen@freescale.com, jun.li@freescale.com, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

There is a race happening during dwc3_drd_init() that causes
otg events to get disabled. This is what happens.

dwc3_otg_irq() happens immediately when PRTCAP is set to OTG,
even though OEVTEN is 0. This is because BIT 31 IRQ of
OEVT can't be disabled by OEVTEN.
We configure OEVTEN in dwc3_otg_init() but dwc3_otg_irq() has
already saved OEVTEN as 0 into dwc->oevten. So finally when
dwc3_irq_thread_irq() is called we save 0 into OEVTEN
thus disabling OTG irqs forever.

We fix this by disabling IRQs when configuring OEVTEN in
dwc3_otg_init().

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 drivers/usb/dwc3/core.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 684010c..654aebf 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -921,6 +921,7 @@ static int dwc3_drd_init(struct dwc3 *dwc)
 	int ret, id, vbus;
 	struct usb_otg_caps *otgcaps = &dwc->otg_config.otg_caps;
 	u32 reg;
+	unsigned long flags;
 
 	otgcaps->otg_rev = 0;
 	otgcaps->hnp_support = false;
@@ -993,6 +994,8 @@ try_otg_core:
 		goto error;
 	}
 
+	spin_lock_irqsave(&dwc->lock, flags);
+
 	/* we need to set OTG to get events from OTG core */
 	dwc3_set_mode(dwc, DWC3_GCTL_PRTCAP_OTG);
 	/* GUSB2PHYCFG0.SusPHY=0 */
@@ -1018,6 +1021,8 @@ try_otg_core:
 	/* OCTL.PeriMode = 1 */
 	dwc3_writel(dwc->regs, DWC3_OCTL, DWC3_OCTL_PERIMODE);
 
+	spin_unlock_irqrestore(&dwc->lock, flags);
+
 	dwc3_otg_fsm_sync(dwc);
 	usb_otg_sync_inputs(dwc->fsm);
 
-- 
2.1.4
