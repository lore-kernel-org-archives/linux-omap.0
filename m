From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH v11 5/5] usb: dwc3: core: cleanup IRQ resources
Date: Fri, 10 Jun 2016 14:48:38 +0300
Message-ID: <575AA916.50502@ti.com>
References: <1462977406-22806-1-git-send-email-rogerq@ti.com>
 <1462977406-22806-6-git-send-email-rogerq@ti.com> <574E92E8.5080201@ti.com>
 <575A8EB0.1050706@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <575A8EB0.1050706@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: balbi@kernel.org, grygorii.strashko@ti.com, sergei.shtylyov@cogentembedded.com
Cc: tony@atomide.com, Joao.Pinto@synopsys.com, peter.chen@freescale.com, jun.li@freescale.com, yoshihiro.shimoda.uh@renesas.com, nsekhar@ti.com, b-liu@ti.com, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, rogerq@ti.com
List-Id: linux-omap@vger.kernel.org

Implementations might use different IRQs for
host, gadget so use named interrupt resources
to allow device tree to specify the interrupts.

Following are the interrupt names

Peripheral Interrupt - peripheral
HOST Interrupt - host

Maintain backward compatibility for a single named
interrupt ("dwc3_usb3") for all interrupts as well as
unnamed interrupt at index 0 for all interrupts.

As platform_get_irq() variants are used, tackle
the -EPROBE_DEFER case as well.

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
v11:
- consider irq == 0 as error case and return -EINVAL

v10:
- don't mention otg irq since we are not using it yet
- use platform_get_irq() and friends and check -EPROBE_DEFER case.

 drivers/usb/dwc3/core.c   | 22 ++++++++--------------
 drivers/usb/dwc3/gadget.c | 31 ++++++++++++++++++++++++++++---
 drivers/usb/dwc3/host.c   | 43 ++++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 78 insertions(+), 18 deletions(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 8fceeb1..131e7eb 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -766,7 +766,8 @@ static int dwc3_core_init_mode(struct dwc3 *dwc)
 		dwc3_set_mode(dwc, DWC3_GCTL_PRTCAP_DEVICE);
 		ret = dwc3_gadget_init(dwc);
 		if (ret) {
-			dev_err(dev, "failed to initialize gadget\n");
+			if (ret != -EPROBE_DEFER)
+				dev_err(dev, "failed to initialize gadget\n");
 			return ret;
 		}
 		break;
@@ -774,7 +775,8 @@ static int dwc3_core_init_mode(struct dwc3 *dwc)
 		dwc3_set_mode(dwc, DWC3_GCTL_PRTCAP_HOST);
 		ret = dwc3_host_init(dwc);
 		if (ret) {
-			dev_err(dev, "failed to initialize host\n");
+			if (ret != -EPROBE_DEFER)
+				dev_err(dev, "failed to initialize host\n");
 			return ret;
 		}
 		break;
@@ -782,13 +784,15 @@ static int dwc3_core_init_mode(struct dwc3 *dwc)
 		dwc3_set_mode(dwc, DWC3_GCTL_PRTCAP_OTG);
 		ret = dwc3_host_init(dwc);
 		if (ret) {
-			dev_err(dev, "failed to initialize host\n");
+			if (ret != -EPROBE_DEFER)
+				dev_err(dev, "failed to initialize host\n");
 			return ret;
 		}
 
 		ret = dwc3_gadget_init(dwc);
 		if (ret) {
-			dev_err(dev, "failed to initialize gadget\n");
+			if (ret != -EPROBE_DEFER)
+				dev_err(dev, "failed to initialize gadget\n");
 			return ret;
 		}
 		break;
@@ -843,16 +847,6 @@ static int dwc3_probe(struct platform_device *pdev)
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
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 0f6fb8e..1ade5e8 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -1738,7 +1738,7 @@ static int dwc3_gadget_start(struct usb_gadget *g,
 	int			ret = 0;
 	int			irq;
 
-	irq = platform_get_irq(to_platform_device(dwc->dev), 0);
+	irq = dwc->irq_gadget;
 	ret = request_threaded_irq(irq, dwc3_interrupt, dwc3_thread_interrupt,
 			IRQF_SHARED, "dwc3", dwc->ev_buf);
 	if (ret) {
@@ -1746,7 +1746,6 @@ static int dwc3_gadget_start(struct usb_gadget *g,
 				irq, ret);
 		goto err0;
 	}
-	dwc->irq_gadget = irq;
 
 	spin_lock_irqsave(&dwc->lock, flags);
 	if (dwc->gadget_driver) {
@@ -2866,7 +2865,33 @@ static irqreturn_t dwc3_interrupt(int irq, void *_evt)
  */
 int dwc3_gadget_init(struct dwc3 *dwc)
 {
-	int					ret;
+	int ret, irq;
+	struct platform_device *dwc3_pdev = to_platform_device(dwc->dev);
+
+	irq = platform_get_irq_byname(dwc3_pdev, "peripheral");
+	if (irq == -EPROBE_DEFER)
+		return irq;
+
+	if (irq <= 0) {
+		irq = platform_get_irq_byname(dwc3_pdev, "dwc_usb3");
+		if (irq == -EPROBE_DEFER)
+			return irq;
+
+		if (irq <= 0) {
+			irq = platform_get_irq(dwc3_pdev, 0);
+			if (irq <= 0) {
+				if (irq != -EPROBE_DEFER) {
+					dev_err(dwc->dev,
+						"missing peripheral IRQ\n");
+				}
+				if (!irq)
+					irq = -EINVAL;
+				return irq;
+			}
+		}
+	}
+
+	dwc->irq_gadget = irq;
 
 	dwc->ctrl_req = dma_alloc_coherent(dwc->dev, sizeof(*dwc->ctrl_req),
 			&dwc->ctrl_req_addr, GFP_KERNEL);
diff --git a/drivers/usb/dwc3/host.c b/drivers/usb/dwc3/host.c
index c679f63..2e960ed 100644
--- a/drivers/usb/dwc3/host.c
+++ b/drivers/usb/dwc3/host.c
@@ -24,7 +24,48 @@ int dwc3_host_init(struct dwc3 *dwc)
 {
 	struct platform_device	*xhci;
 	struct usb_xhci_pdata	pdata;
-	int			ret;
+	int			ret, irq;
+	struct resource		*res;
+	struct platform_device	*dwc3_pdev = to_platform_device(dwc->dev);
+
+	irq = platform_get_irq_byname(dwc3_pdev, "host");
+	if (irq == -EPROBE_DEFER)
+		return irq;
+
+	if (irq <= 0) {
+		irq = platform_get_irq_byname(dwc3_pdev, "dwc_usb3");
+		if (irq == -EPROBE_DEFER)
+			return irq;
+
+		if (irq <= 0) {
+			irq = platform_get_irq(dwc3_pdev, 0);
+			if (irq <= 0) {
+				if (irq != -EPROBE_DEFER) {
+					dev_err(dwc->dev,
+						"missing host IRQ\n");
+				}
+				if (!irq)
+					irq = -EINVAL;
+				return irq;
+			} else {
+				res = platform_get_resource(dwc3_pdev,
+							    IORESOURCE_IRQ, 0);
+			}
+		} else {
+			res = platform_get_resource_byname(dwc3_pdev,
+							   IORESOURCE_IRQ,
+							   "dwc_usb3");
+		}
+
+	} else {
+		res = platform_get_resource_byname(dwc3_pdev, IORESOURCE_IRQ,
+						   "host");
+	}
+
+	dwc->xhci_resources[1].start = irq;
+	dwc->xhci_resources[1].end = irq;
+	dwc->xhci_resources[1].flags = res->flags;
+	dwc->xhci_resources[1].name = res->name;
 
 	xhci = platform_device_alloc("xhci-hcd", PLATFORM_DEVID_AUTO);
 	if (!xhci) {
-- 
2.7.4
