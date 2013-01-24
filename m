From: Felipe Balbi <balbi@ti.com>
Subject: [RFC/PATCH 22/32] usb: gadget: pch_udc: let udc-core manage gadget->dev
Date: Thu, 24 Jan 2013 17:46:00 +0200
Message-ID: <1359042370-4358-23-git-send-email-balbi@ti.com>
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
 drivers/usb/gadget/pch_udc.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/usb/gadget/pch_udc.c b/drivers/usb/gadget/pch_udc.c
index a787a8e..7032145 100644
--- a/drivers/usb/gadget/pch_udc.c
+++ b/drivers/usb/gadget/pch_udc.c
@@ -358,7 +358,6 @@ struct pch_udc_dev {
 			prot_stall:1,
 			irq_registered:1,
 			mem_region:1,
-			registered:1,
 			suspended:1,
 			connected:1,
 			vbus_session:1,
@@ -3078,8 +3077,6 @@ static void pch_udc_remove(struct pci_dev *pdev)
 				   pci_resource_len(pdev, PCH_UDC_PCI_BAR));
 	if (dev->active)
 		pci_disable_device(pdev);
-	if (dev->registered)
-		device_unregister(&dev->gadget.dev);
 	kfree(dev);
 	pci_set_drvdata(pdev, NULL);
 }
@@ -3196,17 +3193,12 @@ static int pch_udc_probe(struct pci_dev *pdev,
 	if (retval)
 		goto finished;
 
-	dev_set_name(&dev->gadget.dev, "gadget");
 	dev->gadget.dev.parent = &pdev->dev;
 	dev->gadget.dev.dma_mask = pdev->dev.dma_mask;
 	dev->gadget.dev.release = gadget_release;
 	dev->gadget.name = KBUILD_MODNAME;
 	dev->gadget.max_speed = USB_SPEED_HIGH;
-
-	retval = device_register(&dev->gadget.dev);
-	if (retval)
-		goto finished;
-	dev->registered = 1;
+	dev->gadget.register_my_device = true;
 
 	/* Put the device in disconnected state till a driver is bound */
 	pch_udc_set_disconnect(dev);
-- 
1.8.1.rc1.5.g7e0651a
