From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH v8 5/5] usb: dwc3: core: cleanup IRQ resources
Date: Wed, 11 May 2016 17:36:46 +0300
Message-ID: <1462977406-22806-6-git-send-email-rogerq@ti.com>
References: <1462977406-22806-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1462977406-22806-1-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: balbi@kernel.org
Cc: tony@atomide.com, Joao.Pinto@synopsys.com, sergei.shtylyov@cogentembedded.com, peter.chen@freescale.com, jun.li@freescale.com, grygorii.strashko@ti.com, yoshihiro.shimoda.uh@renesas.com, nsekhar@ti.com, b-liu@ti.com, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

Implementations might use different IRQs for
host, gadget and OTG so use named interrupt resources
to allow Device tree to specify the 3 interrupts.

Following are the interrupt names

Peripheral Interrupt - peripheral
HOST Interrupt - host
OTG Interrupt - otg

We still maintain backward compatibility for a single named
interrupt for all 3 interrupts (e.g. for dwc3-pci) and
single unnamed interrupt for all 3 interrupts (e.g. old DT).

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 drivers/usb/dwc3/core.c   | 10 ----------
 drivers/usb/dwc3/core.h   |  3 +++
 drivers/usb/dwc3/gadget.c | 23 +++++++++++++++++++----
 drivers/usb/dwc3/host.c   | 19 +++++++++++++++++++
 4 files changed, 41 insertions(+), 14 deletions(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index c050a88..4e8b154 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -814,16 +814,6 @@ static int dwc3_probe(struct platform_device *pdev)
 	dwc->mem = mem;
 	dwc->dev = dev;
 
-	res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
-	if (!res) {
-		dev_err(dev, "missing IRQ\n");
-		return -ENODEV;
-	}
-	dwc->xhci_resources[1].start = res->start;
-	dwc->xhci_resources[1].end = res->end;
-	dwc->xhci_resources[1].flags = res->flags;
-	dwc->xhci_resources[1].name = res->name;
-
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!res) {
 		dev_err(dev, "missing memory resource\n");
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index 186a886..ab0d615 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -716,6 +716,7 @@ struct dwc3_scratchpad_array {
  * @maximum_speed: maximum speed requested (mainly for testing purposes)
  * @revision: revision register contents
  * @dr_mode: requested mode of operation
+ * @gadget_irq: IRQ number for Peripheral IRQs
  * @usb2_phy: pointer to USB2 PHY
  * @usb3_phy: pointer to USB3 PHY
  * @usb2_generic_phy: pointer to USB2 PHY
@@ -817,6 +818,8 @@ struct dwc3 {
 
 	enum usb_dr_mode	dr_mode;
 
+	int			gadget_irq;
+
 	/* used for suspend/resume */
 	u32			dcfg;
 	u32			gctl;
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index c3b0d01..f493c32 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -1605,7 +1605,7 @@ static int dwc3_gadget_start(struct usb_gadget *g,
 	int			irq;
 	u32			reg;
 
-	irq = platform_get_irq(to_platform_device(dwc->dev), 0);
+	irq = dwc->gadget_irq;
 	ret = request_threaded_irq(irq, dwc3_interrupt, dwc3_thread_interrupt,
 			IRQF_SHARED, "dwc3", dwc->ev_buf);
 	if (ret) {
@@ -1728,7 +1728,6 @@ static int dwc3_gadget_stop(struct usb_gadget *g)
 {
 	struct dwc3		*dwc = gadget_to_dwc(g);
 	unsigned long		flags;
-	int			irq;
 
 	spin_lock_irqsave(&dwc->lock, flags);
 
@@ -1740,8 +1739,7 @@ static int dwc3_gadget_stop(struct usb_gadget *g)
 
 	spin_unlock_irqrestore(&dwc->lock, flags);
 
-	irq = platform_get_irq(to_platform_device(dwc->dev), 0);
-	free_irq(irq, dwc->ev_buf);
+	free_irq(dwc->gadget_irq, dwc->ev_buf);
 
 	return 0;
 }
@@ -2781,6 +2779,23 @@ static irqreturn_t dwc3_interrupt(int irq, void *_evt)
 int dwc3_gadget_init(struct dwc3 *dwc)
 {
 	int					ret;
+	struct resource *res;
+	struct platform_device *dwc3_pdev = to_platform_device(dwc->dev);
+
+	dwc->gadget_irq = platform_get_irq_byname(dwc3_pdev, "peripheral");
+	if (dwc->gadget_irq <= 0) {
+		dwc->gadget_irq = platform_get_irq_byname(dwc3_pdev,
+							  "dwc_usb3");
+		if (dwc->gadget_irq <= 0) {
+			res = platform_get_resource(dwc3_pdev, IORESOURCE_IRQ,
+						    0);
+			if (!res) {
+				dev_err(dwc->dev, "missing peripheral IRQ\n");
+				return -ENODEV;
+			}
+			dwc->gadget_irq = res->start;
+		}
+	}
 
 	dwc->ctrl_req = dma_alloc_coherent(dwc->dev, sizeof(*dwc->ctrl_req),
 			&dwc->ctrl_req_addr, GFP_KERNEL);
diff --git a/drivers/usb/dwc3/host.c b/drivers/usb/dwc3/host.c
index c679f63..f2b60a4 100644
--- a/drivers/usb/dwc3/host.c
+++ b/drivers/usb/dwc3/host.c
@@ -25,6 +25,25 @@ int dwc3_host_init(struct dwc3 *dwc)
 	struct platform_device	*xhci;
 	struct usb_xhci_pdata	pdata;
 	int			ret;
+	struct resource		*res;
+	struct platform_device	*dwc3_pdev = to_platform_device(dwc->dev);
+
+	res = platform_get_resource_byname(dwc3_pdev, IORESOURCE_IRQ, "host");
+	if (!res) {
+		res = platform_get_resource_byname(dwc3_pdev, IORESOURCE_IRQ,
+						   "dwc_usb3");
+		if (!res) {
+			res = platform_get_resource(dwc3_pdev, IORESOURCE_IRQ,
+						    0);
+			if (!res)
+				return -ENOMEM;
+		}
+	}
+
+	dwc->xhci_resources[1].start = res->start;
+	dwc->xhci_resources[1].end = res->end;
+	dwc->xhci_resources[1].flags = res->flags;
+	dwc->xhci_resources[1].name = res->name;
 
 	xhci = platform_device_alloc("xhci-hcd", PLATFORM_DEVID_AUTO);
 	if (!xhci) {
-- 
2.7.4
