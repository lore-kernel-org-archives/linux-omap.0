From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH v3 4/9] usb: dwc3: core: Adapt to named interrupts
Date: Wed, 8 Jul 2015 13:36:35 +0300
Message-ID: <1436351795-28556-1-git-send-email-rogerq@ti.com>
References: <1436351524-28385-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1436351524-28385-1-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: balbi@ti.com
Cc: tony@atomide.com, Joao.Pinto@synopsys.com, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

From: Felipe Balbi <balbi@ti.com>

Add support to use interrupt names,

Following are the interrupt names

Peripheral Interrupt - peripheral
HOST Interrupt - host
OTG Interrupt - otg

[Roger Q]
- If any of these are missing we use the
first available IRQ resource so that we don't
break with older DTBs.

- Use gadget_irq in gadget driver.

Signed-off-by: Felipe Balbi <balbi@ti.com>
Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 drivers/usb/dwc3/core.c   | 12 ++++++++++++
 drivers/usb/dwc3/core.h   |  7 +++++++
 drivers/usb/dwc3/gadget.c |  2 +-
 3 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index a7498e0..7b33d7b 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -941,6 +941,18 @@ static int dwc3_probe(struct platform_device *pdev)
 	dwc->xhci_resources[1].flags = res->flags;
 	dwc->xhci_resources[1].name = res->name;
 
+	dwc->otg_irq = platform_get_irq_byname(pdev, "otg");
+	if (!dwc->otg_irq)
+		dwc->otg_irq = res->start;
+
+	dwc->gadget_irq = platform_get_irq_byname(pdev, "peripheral");
+	if (!dwc->gadget_irq)
+		dwc->gadget_irq = res->start;
+
+	dwc->xhci_irq = platform_get_irq_byname(pdev, "host");
+	if (!dwc->xhci_irq)
+		dwc->xhci_irq = res->start;
+
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!res) {
 		dev_err(dev, "missing memory resource\n");
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index 9c1c094..c3431b2 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -742,6 +742,9 @@ struct dwc3_scratchpad_array {
  * @maximum_speed: maximum speed requested (mainly for testing purposes)
  * @revision: revision register contents
  * @dr_mode: requested mode of operation
+ * @xhci_irq: IRQ number for XHCI IRQs
+ * @gadget_irq: IRQ number for Peripheral IRQs
+ * @otg_irq: IRQ number for OTG IRQs
  * @usb2_phy: pointer to USB2 PHY
  * @usb3_phy: pointer to USB3 PHY
  * @usb2_generic_phy: pointer to USB2 PHY
@@ -846,6 +849,10 @@ struct dwc3 {
 
 	enum usb_dr_mode	dr_mode;
 
+	int			gadget_irq;
+	int			xhci_irq;
+	int			otg_irq;
+
 	/* used for suspend/resume */
 	u32			dcfg;
 	u32			gctl;
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 333a7c0..cf6b945 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -1531,7 +1531,7 @@ static int dwc3_gadget_start(struct usb_gadget *g,
 	int			irq;
 	u32			reg;
 
-	irq = platform_get_irq(to_platform_device(dwc->dev), 0);
+	irq = dwc->gadget_irq;
 	ret = request_threaded_irq(irq, dwc3_interrupt, dwc3_thread_interrupt,
 			IRQF_SHARED, "dwc3", dwc);
 	if (ret) {
-- 
2.1.4
