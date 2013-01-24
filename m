From: Felipe Balbi <balbi@ti.com>
Subject: [RFC/PATCH 02/32] usb: dwc3: gadget: let udc-core manage gadget->dev
Date: Thu, 24 Jan 2013 17:45:40 +0200
Message-ID: <1359042370-4358-3-git-send-email-balbi@ti.com>
References: <1359042370-4358-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1359042370-4358-1-git-send-email-balbi@ti.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Linux USB Mailing List <linux-usb@vger.kernel.org>
Cc: alexander.shishkin@linux.intel.com, gregkh@linuxfoundation.org, dahlmann.thomas@arcor.de, nicolas.ferre@atmel.com, leoli@freescale.com, eric.y.miao@gmail.com, linux@arm.linux.org.uk, haojian.zhuang@gmail.com, ben-linux@fluff.org, kgene.kim@samsung.com, kuninori.morimoto.gx@renesas.com, yoshihiro.shimoda.uh@renesas.com, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, linux-geode@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, linux-samsung-soc@vger.kernel.org, Felipe Balbi <balbi@ti.com>
List-Id: linux-omap@vger.kernel.org

We don't need to register that device ourselves
if we simply set gadget->register_my_device.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/usb/dwc3/gadget.c | 17 ++---------------
 1 file changed, 2 insertions(+), 15 deletions(-)

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 2e43b33..7002cf6 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -2412,8 +2412,6 @@ int dwc3_gadget_init(struct dwc3 *dwc)
 		goto err3;
 	}
 
-	dev_set_name(&dwc->gadget.dev, "gadget");
-
 	dwc->gadget.ops			= &dwc3_gadget_ops;
 	dwc->gadget.max_speed		= USB_SPEED_SUPER;
 	dwc->gadget.speed		= USB_SPEED_UNKNOWN;
@@ -2425,6 +2423,7 @@ int dwc3_gadget_init(struct dwc3 *dwc)
 	dwc->gadget.dev.dma_parms	= dwc->dev->dma_parms;
 	dwc->gadget.dev.dma_mask	= dwc->dev->dma_mask;
 	dwc->gadget.dev.release		= dwc3_gadget_release;
+	dwc->gadget.register_my_device	= true;
 	dwc->gadget.name		= "dwc3-gadget";
 
 	/*
@@ -2480,24 +2479,14 @@ int dwc3_gadget_init(struct dwc3 *dwc)
 		dwc3_gadget_usb3_phy_suspend(dwc, false);
 	}
 
-	ret = device_register(&dwc->gadget.dev);
-	if (ret) {
-		dev_err(dwc->dev, "failed to register gadget device\n");
-		put_device(&dwc->gadget.dev);
-		goto err6;
-	}
-
 	ret = usb_add_gadget_udc(dwc->dev, &dwc->gadget);
 	if (ret) {
 		dev_err(dwc->dev, "failed to register udc\n");
-		goto err7;
+		goto err6;
 	}
 
 	return 0;
 
-err7:
-	device_unregister(&dwc->gadget.dev);
-
 err6:
 	dwc3_writel(dwc->regs, DWC3_DEVTEN, 0x00);
 	free_irq(irq, dwc);
@@ -2546,6 +2535,4 @@ void dwc3_gadget_exit(struct dwc3 *dwc)
 
 	dma_free_coherent(dwc->dev, sizeof(*dwc->ctrl_req),
 			dwc->ctrl_req, dwc->ctrl_req_addr);
-
-	device_unregister(&dwc->gadget.dev);
 }
-- 
1.8.1.rc1.5.g7e0651a
