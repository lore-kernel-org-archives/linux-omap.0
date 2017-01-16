From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCH v3 1/6] usb: dwc3: omap: Replace the extcon API
Date: Mon, 16 Jan 2017 21:36:57 +0900
Message-ID: <1484570222-30522-2-git-send-email-cw00.choi@samsung.com>
References: <1484570222-30522-1-git-send-email-cw00.choi@samsung.com>
 <CGME20170116123713epcas1p1ebe3e43a7a3cf20c0981966842a3992f@epcas1p1.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-reply-to: <1484570222-30522-1-git-send-email-cw00.choi@samsung.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: balbi@kernel.org, gregkh@linuxfoundation.org
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, Chanwoo Choi <cw00.choi@samsung.com>, chanwoo@kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

This patch uses the resource-managed extcon API for extcon_register_notifier()
and replaces the deprecated extcon API as following:
- extcon_get_cable_state_() -> extcon_get_state()

Cc: linux-omap@vger.kernel.org
Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
Acked-by: Felipe Balbi <felipe.balbi@linux.intel.com>
---
 drivers/usb/dwc3/dwc3-omap.c | 20 +++++++-------------
 1 file changed, 7 insertions(+), 13 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-omap.c b/drivers/usb/dwc3/dwc3-omap.c
index eb1b9cb3f9d1..2092e46b1380 100644
--- a/drivers/usb/dwc3/dwc3-omap.c
+++ b/drivers/usb/dwc3/dwc3-omap.c
@@ -426,20 +426,20 @@ static int dwc3_omap_extcon_register(struct dwc3_omap *omap)
 		}
 
 		omap->vbus_nb.notifier_call = dwc3_omap_vbus_notifier;
-		ret = extcon_register_notifier(edev, EXTCON_USB,
-						&omap->vbus_nb);
+		ret = devm_extcon_register_notifier(omap->dev, edev,
+						EXTCON_USB, &omap->vbus_nb);
 		if (ret < 0)
 			dev_vdbg(omap->dev, "failed to register notifier for USB\n");
 
 		omap->id_nb.notifier_call = dwc3_omap_id_notifier;
-		ret = extcon_register_notifier(edev, EXTCON_USB_HOST,
-						&omap->id_nb);
+		ret = devm_extcon_register_notifier(omap->dev, edev,
+						EXTCON_USB_HOST, &omap->id_nb);
 		if (ret < 0)
 			dev_vdbg(omap->dev, "failed to register notifier for USB-HOST\n");
 
-		if (extcon_get_cable_state_(edev, EXTCON_USB) == true)
+		if (extcon_get_state(edev, EXTCON_USB) == true)
 			dwc3_omap_set_mailbox(omap, OMAP_DWC3_VBUS_VALID);
-		if (extcon_get_cable_state_(edev, EXTCON_USB_HOST) == true)
+		if (extcon_get_state(edev, EXTCON_USB_HOST) == true)
 			dwc3_omap_set_mailbox(omap, OMAP_DWC3_ID_GROUND);
 
 		omap->edev = edev;
@@ -528,17 +528,13 @@ static int dwc3_omap_probe(struct platform_device *pdev)
 	ret = of_platform_populate(node, NULL, NULL, dev);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to create dwc3 core\n");
-		goto err2;
+		goto err1;
 	}
 
 	dwc3_omap_enable_irqs(omap);
 	enable_irq(omap->irq);
 	return 0;
 
-err2:
-	extcon_unregister_notifier(omap->edev, EXTCON_USB, &omap->vbus_nb);
-	extcon_unregister_notifier(omap->edev, EXTCON_USB_HOST, &omap->id_nb);
-
 err1:
 	pm_runtime_put_sync(dev);
 	pm_runtime_disable(dev);
@@ -550,8 +546,6 @@ static int dwc3_omap_remove(struct platform_device *pdev)
 {
 	struct dwc3_omap	*omap = platform_get_drvdata(pdev);
 
-	extcon_unregister_notifier(omap->edev, EXTCON_USB, &omap->vbus_nb);
-	extcon_unregister_notifier(omap->edev, EXTCON_USB_HOST, &omap->id_nb);
 	dwc3_omap_disable_irqs(omap);
 	disable_irq(omap->irq);
 	of_platform_depopulate(omap->dev);
-- 
1.9.1
