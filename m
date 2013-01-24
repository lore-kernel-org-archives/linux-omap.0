From: Felipe Balbi <balbi@ti.com>
Subject: [RFC/PATCH 26/32] usb: gadget: s3c2410_udc: let udc-core manage gadget->dev
Date: Thu, 24 Jan 2013 17:46:04 +0200
Message-ID: <1359042370-4358-27-git-send-email-balbi@ti.com>
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
 drivers/usb/gadget/s3c2410_udc.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/usb/gadget/s3c2410_udc.c b/drivers/usb/gadget/s3c2410_udc.c
index fc07b43..302e137 100644
--- a/drivers/usb/gadget/s3c2410_udc.c
+++ b/drivers/usb/gadget/s3c2410_udc.c
@@ -1677,13 +1677,6 @@ static int s3c2410_udc_start(struct usb_gadget *g,
 	udc->driver = driver;
 	udc->gadget.dev.driver = &driver->driver;
 
-	/* Bind the driver */
-	retval = device_add(&udc->gadget.dev);
-	if (retval) {
-		dev_err(&udc->gadget.dev, "Error in device_add() : %d\n", retval);
-		goto register_error;
-	}
-
 	/* Enable udc */
 	s3c2410_udc_enable(udc);
 
@@ -1700,7 +1693,6 @@ static int s3c2410_udc_stop(struct usb_gadget *g,
 {
 	struct s3c2410_udc *udc = to_s3c2410(g);
 
-	device_del(&udc->gadget.dev);
 	udc->driver = NULL;
 
 	/* Disable udc */
@@ -1838,9 +1830,9 @@ static int s3c2410_udc_probe(struct platform_device *pdev)
 		goto err_mem;
 	}
 
-	device_initialize(&udc->gadget.dev);
 	udc->gadget.dev.parent = &pdev->dev;
 	udc->gadget.dev.dma_mask = pdev->dev.dma_mask;
+	udc->gadget.register_my_device = true;
 
 	the_controller = udc;
 	platform_set_drvdata(pdev, udc);
-- 
1.8.1.rc1.5.g7e0651a
