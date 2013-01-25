From: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v3 08/11] usb: dwc3-omap: stop using nop-usb-xceiv
Date: Fri, 25 Jan 2013 08:30:52 +0530
Message-ID: <1359082855-7404-9-git-send-email-kishon@ti.com>
References: <1359082855-7404-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <1359082855-7404-1-git-send-email-kishon-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Cc: gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, kishon-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Now that we have drivers for omap-usb2 phy and omap-usb3 phy, stop
using nop-usb-xceiv.

Signed-off-by: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
---
 drivers/usb/dwc3/dwc3-omap.c |   67 ------------------------------------------
 1 file changed, 67 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-omap.c b/drivers/usb/dwc3/dwc3-omap.c
index 4e96fbe..0c62e28 100644
--- a/drivers/usb/dwc3/dwc3-omap.c
+++ b/drivers/usb/dwc3/dwc3-omap.c
@@ -52,7 +52,6 @@
 #include <linux/of_platform.h>
 
 #include <linux/usb/otg.h>
-#include <linux/usb/nop-usb-xceiv.h>
 
 #include "core.h"
 
@@ -119,8 +118,6 @@ struct dwc3_omap {
 	/* device lock */
 	spinlock_t		lock;
 
-	struct platform_device	*usb2_phy;
-	struct platform_device	*usb3_phy;
 	struct device		*dev;
 
 	int			irq;
@@ -195,60 +192,6 @@ void dwc3_omap_mailbox(enum omap_dwc3_vbus_id_status status)
 }
 EXPORT_SYMBOL_GPL(dwc3_omap_mailbox);
 
-static int dwc3_omap_register_phys(struct dwc3_omap *omap)
-{
-	struct nop_usb_xceiv_platform_data pdata;
-	struct platform_device	*pdev;
-	int			ret;
-
-	memset(&pdata, 0x00, sizeof(pdata));
-
-	pdev = platform_device_alloc("nop_usb_xceiv", 0);
-	if (!pdev)
-		return -ENOMEM;
-
-	omap->usb2_phy = pdev;
-	pdata.type = USB_PHY_TYPE_USB2;
-
-	ret = platform_device_add_data(omap->usb2_phy, &pdata, sizeof(pdata));
-	if (ret)
-		goto err1;
-
-	pdev = platform_device_alloc("nop_usb_xceiv", 1);
-	if (!pdev) {
-		ret = -ENOMEM;
-		goto err1;
-	}
-
-	omap->usb3_phy = pdev;
-	pdata.type = USB_PHY_TYPE_USB3;
-
-	ret = platform_device_add_data(omap->usb3_phy, &pdata, sizeof(pdata));
-	if (ret)
-		goto err2;
-
-	ret = platform_device_add(omap->usb2_phy);
-	if (ret)
-		goto err2;
-
-	ret = platform_device_add(omap->usb3_phy);
-	if (ret)
-		goto err3;
-
-	return 0;
-
-err3:
-	platform_device_del(omap->usb2_phy);
-
-err2:
-	platform_device_put(omap->usb3_phy);
-
-err1:
-	platform_device_put(omap->usb2_phy);
-
-	return ret;
-}
-
 static irqreturn_t dwc3_omap_interrupt(int irq, void *_omap)
 {
 	struct dwc3_omap	*omap = _omap;
@@ -358,12 +301,6 @@ static int dwc3_omap_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	}
 
-	ret = dwc3_omap_register_phys(omap);
-	if (ret) {
-		dev_err(dev, "couldn't register PHYs\n");
-		return ret;
-	}
-
 	context = devm_kzalloc(dev, resource_size(res), GFP_KERNEL);
 	if (!context) {
 		dev_err(dev, "couldn't allocate dwc3 context memory\n");
@@ -447,10 +384,6 @@ static int dwc3_omap_probe(struct platform_device *pdev)
 
 static int dwc3_omap_remove(struct platform_device *pdev)
 {
-	struct dwc3_omap	*omap = platform_get_drvdata(pdev);
-
-	platform_device_unregister(omap->usb2_phy);
-	platform_device_unregister(omap->usb3_phy);
 	pm_runtime_put_sync(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 	device_for_each_child(&pdev->dev, NULL, dwc3_omap_remove_core);
-- 
1.7.9.5
