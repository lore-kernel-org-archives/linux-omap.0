From: Felipe Balbi <balbi@ti.com>
Subject: [RFC/PATCH 14/32] usb: gadget: imx_udc: let udc-core manage gadget->dev
Date: Thu, 24 Jan 2013 17:45:52 +0200
Message-ID: <1359042370-4358-15-git-send-email-balbi@ti.com>
References: <1359042370-4358-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1359042370-4358-1-git-send-email-balbi@ti.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Linux USB Mailing List <linux-usb@vger.kernel.org>
Cc: alexander.shishkin@linux.intel.com, gregkh@linuxfoundation.org, dahlmann.thomas@arcor.de, nicolas.ferre@atmel.com, leoli@freescale.com, eric.y.miao@gmail.com, linux@arm.linux.org.uk, haojian.zhuang@gmail.com, ben-linux@fluff.org, kgene.kim@samsung.com, kuninori.morimoto.gx@renesas.com, yoshihiro.shimoda.uh@renesas.com, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, linux-geode@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, linux-samsung-soc@vger.kernel.org, Felipe Balbi <balbi@ti.com>
List-Id: linux-omap@vger.kernel.org

By simply setting a flag, we can drop some
boilerplate code.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/usb/gadget/imx_udc.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/usb/gadget/imx_udc.c b/drivers/usb/gadget/imx_udc.c
index a0eb857..c8b5da3 100644
--- a/drivers/usb/gadget/imx_udc.c
+++ b/drivers/usb/gadget/imx_udc.c
@@ -1341,20 +1341,12 @@ static int imx_udc_start(struct usb_gadget *gadget,
 	imx_usb->driver = driver;
 	imx_usb->gadget.dev.driver = &driver->driver;
 
-	retval = device_add(&imx_usb->gadget.dev);
-	if (retval)
-		goto fail;
-
 	D_INI(imx_usb->dev, "<%s> registered gadget driver '%s'\n",
 		__func__, driver->driver.name);
 
 	imx_udc_enable(imx_usb);
 
 	return 0;
-fail:
-	imx_usb->driver = NULL;
-	imx_usb->gadget.dev.driver = NULL;
-	return retval;
 }
 
 static int imx_udc_stop(struct usb_gadget *gadget,
@@ -1370,8 +1362,6 @@ static int imx_udc_stop(struct usb_gadget *gadget,
 	imx_usb->gadget.dev.driver = NULL;
 	imx_usb->driver = NULL;
 
-	device_del(&imx_usb->gadget.dev);
-
 	D_INI(imx_usb->dev, "<%s> unregistered gadget driver '%s'\n",
 		__func__, driver->driver.name);
 
@@ -1472,8 +1462,7 @@ static int __init imx_udc_probe(struct platform_device *pdev)
 	imx_usb->clk = clk;
 	imx_usb->dev = &pdev->dev;
 
-	device_initialize(&imx_usb->gadget.dev);
-
+	imx_usb->gadget.register_my_device = true;
 	imx_usb->gadget.dev.parent = &pdev->dev;
 	imx_usb->gadget.dev.dma_mask = pdev->dev.dma_mask;
 
-- 
1.8.1.rc1.5.g7e0651a
