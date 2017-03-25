From: Shuah Khan <shuahkh@osg.samsung.com>
Subject: [PATCH 6/7] usb: dwc3: gadget: change goto labels in this file to meaningful names
Date: Fri, 24 Mar 2017 18:05:04 -0600
Message-ID: <683bd245ba40d23fc0529be846dab70a096ab2d2.1490387086.git.shuahkh@osg.samsung.com>
References: <cover.1490387086.git.shuahkh@osg.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1490387086.git.shuahkh@osg.samsung.com>
In-Reply-To: <cover.1490387086.git.shuahkh@osg.samsung.com>
References: <cover.1490387086.git.shuahkh@osg.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: balbi@kernel.org, gregkh@linuxfoundation.org, kgene@kernel.org, krzk@kernel.org, javier@osg.samsung.com
Cc: Shuah Khan <shuahkh@osg.samsung.com>, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Change goto labels in this file to meaningful names.

Signed-off-by: Shuah Khan <shuahkh@osg.samsung.com>
---
 drivers/usb/dwc3/gadget.c | 56 +++++++++++++++++++++++------------------------
 1 file changed, 28 insertions(+), 28 deletions(-)

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 8d44a2f..9795226 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -1345,19 +1345,19 @@ static int dwc3_gadget_ep_dequeue(struct usb_ep *ep,
 		if (r == req) {
 			/* wait until it is processed */
 			dwc3_stop_active_transfer(dwc, dep->number, true);
-			goto out1;
+			goto gadget_giveback;
 		}
 		dev_err(dwc->dev, "request %p was not queued to %s\n",
 				request, ep->name);
 		ret = -EINVAL;
-		goto out0;
+		goto return_ret;
 	}
 
-out1:
+gadget_giveback:
 	/* giveback the request */
 	dwc3_gadget_giveback(dep, req, -ECONNRESET);
 
-out0:
+return_ret:
 	spin_unlock_irqrestore(&dwc->lock, flags);
 
 	return ret;
@@ -1811,14 +1811,14 @@ static int __dwc3_gadget_start(struct dwc3 *dwc)
 	ret = __dwc3_gadget_ep_enable(dep, false, false);
 	if (ret) {
 		dev_err(dwc->dev, "failed to enable %s\n", dep->name);
-		goto err0;
+		goto return_ret;
 	}
 
 	dep = dwc->eps[1];
 	ret = __dwc3_gadget_ep_enable(dep, false, false);
 	if (ret) {
 		dev_err(dwc->dev, "failed to enable %s\n", dep->name);
-		goto err1;
+		goto ep_disable;
 	}
 
 	/* begin to receive SETUP packets */
@@ -1829,10 +1829,10 @@ static int __dwc3_gadget_start(struct dwc3 *dwc)
 
 	return 0;
 
-err1:
+ep_disable:
 	__dwc3_gadget_ep_disable(dwc->eps[0]);
 
-err0:
+return_ret:
 	return ret;
 }
 
@@ -1850,7 +1850,7 @@ static int dwc3_gadget_start(struct usb_gadget *g,
 	if (ret) {
 		dev_err(dwc->dev, "failed to request irq #%d --> %d\n",
 				irq, ret);
-		goto err0;
+		goto return_ret;
 	}
 
 	spin_lock_irqsave(&dwc->lock, flags);
@@ -1859,7 +1859,7 @@ static int dwc3_gadget_start(struct usb_gadget *g,
 				dwc->gadget.name,
 				dwc->gadget_driver->driver.name);
 		ret = -EBUSY;
-		goto err1;
+		goto irq_free;
 	}
 
 	dwc->gadget_driver	= driver;
@@ -1871,11 +1871,11 @@ static int dwc3_gadget_start(struct usb_gadget *g,
 
 	return 0;
 
-err1:
+irq_free:
 	spin_unlock_irqrestore(&dwc->lock, flags);
 	free_irq(irq, dwc);
 
-err0:
+return_ret:
 	return ret;
 }
 
@@ -3063,7 +3063,7 @@ int dwc3_gadget_init(struct dwc3 *dwc)
 	irq = dwc3_gadget_get_irq(dwc);
 	if (irq < 0) {
 		ret = irq;
-		goto err0;
+		goto return_ret;
 	}
 
 	dwc->irq_gadget = irq;
@@ -3073,7 +3073,7 @@ int dwc3_gadget_init(struct dwc3 *dwc)
 	if (!dwc->ctrl_req) {
 		dev_err(dwc->dev, "failed to allocate ctrl request\n");
 		ret = -ENOMEM;
-		goto err0;
+		goto return_ret;
 	}
 
 	dwc->ep0_trb = dma_alloc_coherent(dwc->sysdev,
@@ -3082,13 +3082,13 @@ int dwc3_gadget_init(struct dwc3 *dwc)
 	if (!dwc->ep0_trb) {
 		dev_err(dwc->dev, "failed to allocate ep0 trb\n");
 		ret = -ENOMEM;
-		goto err1;
+		goto free_ctrl_req;
 	}
 
 	dwc->setup_buf = kzalloc(DWC3_EP0_BOUNCE_SIZE, GFP_KERNEL);
 	if (!dwc->setup_buf) {
 		ret = -ENOMEM;
-		goto err2;
+		goto free_ep0_trb;
 	}
 
 	dwc->ep0_bounce = dma_alloc_coherent(dwc->sysdev,
@@ -3097,20 +3097,20 @@ int dwc3_gadget_init(struct dwc3 *dwc)
 	if (!dwc->ep0_bounce) {
 		dev_err(dwc->dev, "failed to allocate ep0 bounce buffer\n");
 		ret = -ENOMEM;
-		goto err3;
+		goto free_setup_buf;
 	}
 
 	dwc->zlp_buf = kzalloc(DWC3_ZLP_BUF_SIZE, GFP_KERNEL);
 	if (!dwc->zlp_buf) {
 		ret = -ENOMEM;
-		goto err4;
+		goto free_ep0_bounce;
 	}
 
 	dwc->bounce = dma_alloc_coherent(dwc->sysdev, DWC3_BOUNCE_SIZE,
 			&dwc->bounce_addr, GFP_KERNEL);
 	if (!dwc->bounce) {
 		ret = -ENOMEM;
-		goto err5;
+		goto free_zlp_buf;
 	}
 
 	init_completion(&dwc->ep0_in_setup);
@@ -3150,39 +3150,39 @@ int dwc3_gadget_init(struct dwc3 *dwc)
 
 	ret = dwc3_gadget_init_endpoints(dwc, dwc->num_eps);
 	if (ret)
-		goto err6;
+		goto free_bounce;
 
 	ret = usb_add_gadget_udc(dwc->dev, &dwc->gadget);
 	if (ret) {
 		dev_err(dwc->dev, "failed to register udc\n");
-		goto err6;
+		goto free_bounce;
 	}
 
 	return 0;
-err6:
+free_bounce:
 	dma_free_coherent(dwc->sysdev, DWC3_BOUNCE_SIZE, dwc->bounce,
 			dwc->bounce_addr);
 
-err5:
+free_zlp_buf:
 	kfree(dwc->zlp_buf);
 
-err4:
+free_ep0_bounce:
 	dwc3_gadget_free_endpoints(dwc);
 	dma_free_coherent(dwc->sysdev, DWC3_EP0_BOUNCE_SIZE,
 			dwc->ep0_bounce, dwc->ep0_bounce_addr);
 
-err3:
+free_setup_buf:
 	kfree(dwc->setup_buf);
 
-err2:
+free_ep0_trb:
 	dma_free_coherent(dwc->sysdev, sizeof(*dwc->ep0_trb) * 2,
 			dwc->ep0_trb, dwc->ep0_trb_addr);
 
-err1:
+free_ctrl_req:
 	dma_free_coherent(dwc->sysdev, sizeof(*dwc->ctrl_req),
 			dwc->ctrl_req, dwc->ctrl_req_addr);
 
-err0:
+return_ret:
 	return ret;
 }
 
-- 
2.7.4
