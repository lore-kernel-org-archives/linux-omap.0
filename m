From: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v2 2/7] usb: dwc3-omap: use of_platform API to create dwc3 core pdev
Date: Mon, 1 Oct 2012 15:55:02 +0530
Message-ID: <1349087107-18229-3-git-send-email-kishon@ti.com>
References: <1349087107-18229-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1349087107-18229-1-git-send-email-kishon-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, kishon-l0cyMroinI0@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Used of_platform_populate() to populate dwc3 core platform_device
from device tree data. Since now the allocation of unique device id is
handled be of_*, removed the call to dwc3_get_device_id.

Signed-off-by: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
---
 drivers/usb/dwc3/dwc3-omap.c |   52 ++++++++----------------------------------
 1 file changed, 10 insertions(+), 42 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-omap.c b/drivers/usb/dwc3/dwc3-omap.c
index e335da3..cb4037a 100644
--- a/drivers/usb/dwc3/dwc3-omap.c
+++ b/drivers/usb/dwc3/dwc3-omap.c
@@ -47,6 +47,7 @@
 #include <linux/ioport.h>
 #include <linux/io.h>
 #include <linux/of.h>
+#include <linux/of_platform.h>
 
 #include "core.h"
 
@@ -130,7 +131,6 @@ struct dwc3_omap {
 	/* device lock */
 	spinlock_t		lock;
 
-	struct platform_device	*dwc3;
 	struct device		*dev;
 
 	int			irq;
@@ -218,12 +218,10 @@ static int __devinit dwc3_omap_probe(struct platform_device *pdev)
 	struct dwc3_omap_data	*pdata = pdev->dev.platform_data;
 	struct device_node	*node = pdev->dev.of_node;
 
-	struct platform_device	*dwc3;
 	struct dwc3_omap	*omap;
 	struct resource		*res;
 	struct device		*dev = &pdev->dev;
 
-	int			devid;
 	int			size;
 	int			ret = -ENOMEM;
 	int			irq;
@@ -260,34 +258,19 @@ static int __devinit dwc3_omap_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	}
 
-	devid = dwc3_get_device_id();
-	if (devid < 0)
-		return -ENODEV;
-
-	dwc3 = platform_device_alloc("dwc3", devid);
-	if (!dwc3) {
-		dev_err(dev, "couldn't allocate dwc3 device\n");
-		goto err1;
-	}
-
 	context = devm_kzalloc(dev, resource_size(res), GFP_KERNEL);
 	if (!context) {
 		dev_err(dev, "couldn't allocate dwc3 context memory\n");
-		goto err2;
+		return -ENOMEM;
 	}
 
 	spin_lock_init(&omap->lock);
-	dma_set_coherent_mask(&dwc3->dev, dev->coherent_dma_mask);
 
-	dwc3->dev.parent = dev;
-	dwc3->dev.dma_mask = dev->dma_mask;
-	dwc3->dev.dma_parms = dev->dma_parms;
 	omap->resource_size = resource_size(res);
 	omap->context	= context;
 	omap->dev	= dev;
 	omap->irq	= irq;
 	omap->base	= base;
-	omap->dwc3	= dwc3;
 
 	reg = dwc3_omap_readl(omap->base, USBOTGSS_UTMI_OTG_STATUS);
 
@@ -332,7 +315,7 @@ static int __devinit dwc3_omap_probe(struct platform_device *pdev)
 	if (ret) {
 		dev_err(dev, "failed to request IRQ #%d --> %d\n",
 				omap->irq, ret);
-		goto err2;
+		return ret;
 	}
 
 	/* enable all IRQs */
@@ -351,35 +334,20 @@ static int __devinit dwc3_omap_probe(struct platform_device *pdev)
 
 	dwc3_omap_writel(omap->base, USBOTGSS_IRQENABLE_SET_1, reg);
 
-	ret = platform_device_add_resources(dwc3, pdev->resource,
-			pdev->num_resources);
-	if (ret) {
-		dev_err(dev, "couldn't add resources to dwc3 device\n");
-		goto err2;
-	}
-
-	ret = platform_device_add(dwc3);
-	if (ret) {
-		dev_err(dev, "failed to register dwc3 device\n");
-		goto err2;
+	if (node) {
+		ret = of_platform_populate(node, NULL, NULL, dev);
+		if (ret) {
+			dev_err(&pdev->dev,
+				"failed to add create dwc3 core\n");
+			return ret;
+		}
 	}
 
 	return 0;
-
-err2:
-	platform_device_put(dwc3);
-
-err1:
-	dwc3_put_device_id(devid);
-
-	return ret;
 }
 
 static int __devexit dwc3_omap_remove(struct platform_device *pdev)
 {
-	struct dwc3_omap	*omap = platform_get_drvdata(pdev);
