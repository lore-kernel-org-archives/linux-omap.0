From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH v3 6/9] usb: dwc3: save/restore OTG registers during suspend/resume
Date: Wed, 8 Jul 2015 13:36:57 +0300
Message-ID: <1436351817-28643-1-git-send-email-rogerq@ti.com>
References: <1436351524-28385-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1436351524-28385-1-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: balbi@ti.com
Cc: tony@atomide.com, Joao.Pinto@synopsys.com, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

Without this we loose OTG controller register context and malfunction
after a system suspend-resume.

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 drivers/usb/dwc3/core.c | 17 +++++++++++++++++
 drivers/usb/dwc3/core.h |  6 +++++-
 2 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 138847f..d050e0e 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -56,6 +56,7 @@ void dwc3_set_mode(struct dwc3 *dwc, u32 mode)
 	reg = dwc3_readl(dwc->regs, DWC3_GCTL);
 	reg &= ~(DWC3_GCTL_PRTCAPDIR(DWC3_GCTL_PRTCAP_OTG));
 	reg |= DWC3_GCTL_PRTCAPDIR(mode);
+	dwc->current_mode = mode;
 	dwc3_writel(dwc->regs, DWC3_GCTL, reg);
 }
 
@@ -1432,6 +1433,14 @@ static int dwc3_suspend(struct device *dev)
 
 	spin_lock_irqsave(&dwc->lock, flags);
 
+	/* Save OTG state only if we're really using it */
+	if (dwc->current_mode == DWC3_GCTL_PRTCAP_OTG) {
+		dwc->ocfg = dwc3_readl(dwc->regs, DWC3_OCFG);
+		dwc->octl = dwc3_readl(dwc->regs, DWC3_OCTL);
+		dwc->oevt = dwc3_readl(dwc->regs, DWC3_OEVT);
+		dwc->oevten = dwc3_readl(dwc->regs, DWC3_OEVTEN);
+	}
+
 	switch (dwc->dr_mode) {
 	case USB_DR_MODE_PERIPHERAL:
 	case USB_DR_MODE_OTG:
@@ -1475,6 +1484,14 @@ static int dwc3_resume(struct device *dev)
 	dwc3_event_buffers_setup(dwc);
 	dwc3_writel(dwc->regs, DWC3_GCTL, dwc->gctl);
 
+	/* Restore OTG state only if we're really using it */
+	if (dwc->current_mode == DWC3_GCTL_PRTCAP_OTG) {
+		dwc3_writel(dwc->regs, DWC3_OCFG, dwc->ocfg);
+		dwc3_writel(dwc->regs, DWC3_OCTL, dwc->octl);
+		dwc3_writel(dwc->regs, DWC3_OEVT, dwc->oevt);
+		dwc3_writel(dwc->regs, DWC3_OEVTEN, dwc->oevten);
+	}
+
 	switch (dwc->dr_mode) {
 	case USB_DR_MODE_PERIPHERAL:
 	case USB_DR_MODE_OTG:
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index 744a5ff..c9c64c9 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -737,6 +737,7 @@ struct dwc3_scratchpad_array {
  * @regs: base address for our registers
  * @regs_size: address space size
  * @oevten: otg interrupt enable mask copy
+ * @current_mode: current mode of operation written to PRTCAPDIR
  * @nr_scratch: number of scratch buffers
  * @num_event_buffers: calculated number of event buffers
  * @u1u2: only used on revisions <1.83a for workaround
@@ -862,9 +863,12 @@ struct dwc3 {
 	/* used for suspend/resume */
 	u32			dcfg;
 	u32			gctl;
-
+	u32			ocfg;
+	u32			octl;
+	u32			oevt;
 	u32			oevten;
 
+	u32			current_mode;
 	u32			nr_scratch;
 	u32			num_event_buffers;
 	u32			u1u2;
-- 
2.1.4
