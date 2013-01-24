From: Felipe Balbi <balbi@ti.com>
Subject: [RFC/PATCH 21/32] usb: gadget: net2280: let udc-core manage gadget->dev
Date: Thu, 24 Jan 2013 17:45:59 +0200
Message-ID: <1359042370-4358-22-git-send-email-balbi@ti.com>
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
 drivers/usb/gadget/net2280.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/usb/gadget/net2280.c b/drivers/usb/gadget/net2280.c
index 708c0b5..630f715 100644
--- a/drivers/usb/gadget/net2280.c
+++ b/drivers/usb/gadget/net2280.c
@@ -2667,7 +2667,6 @@ static void net2280_remove (struct pci_dev *pdev)
 				pci_resource_len (pdev, 0));
 	if (dev->enabled)
 		pci_disable_device (pdev);
-	device_unregister (&dev->gadget.dev);
 	device_remove_file (&pdev->dev, &dev_attr_registers);
 	pci_set_drvdata (pdev, NULL);
 
@@ -2699,11 +2698,11 @@ static int net2280_probe (struct pci_dev *pdev, const struct pci_device_id *id)
 	dev->gadget.max_speed = USB_SPEED_HIGH;
 
 	/* the "gadget" abstracts/virtualizes the controller */
-	dev_set_name(&dev->gadget.dev, "gadget");
 	dev->gadget.dev.parent = &pdev->dev;
 	dev->gadget.dev.dma_mask = pdev->dev.dma_mask;
 	dev->gadget.dev.release = gadget_release;
 	dev->gadget.name = driver_name;
+	dev->gadget.register_my_device = true;
 
 	/* now all the pci goodies ... */
 	if (pci_enable_device (pdev) < 0) {
@@ -2811,8 +2810,6 @@ static int net2280_probe (struct pci_dev *pdev, const struct pci_device_id *id)
 			use_dma
 				? (use_dma_chaining ? "chaining" : "enabled")
 				: "disabled");
-	retval = device_register (&dev->gadget.dev);
-	if (retval) goto done;
 	retval = device_create_file (&pdev->dev, &dev_attr_registers);
 	if (retval) goto done;
 
-- 
1.8.1.rc1.5.g7e0651a
