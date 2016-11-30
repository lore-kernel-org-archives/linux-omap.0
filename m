From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCH 06/12] usb: dwc3: omap: Replace the extcon API
Date: Wed, 30 Nov 2016 14:57:34 +0900
Message-ID: <1480485460-2663-7-git-send-email-cw00.choi@samsung.com>
References: <1480485460-2663-1-git-send-email-cw00.choi@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
In-reply-to: <1480485460-2663-1-git-send-email-cw00.choi@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
To: balbi@kernel.org, gregkh@linuxfoundation.org, kishon@ti.com, sre@kernel.org
Cc: Peter.Chen@nxp.com, wens@csie.org, yoshihiro.shimoda.uh@renesas.com, maxime.ripard@free-electrons.com, b-liu@ti.com, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-renesas-soc@vger.kernel.org, cw00.choi@samsung.com, chanwoo@kernel.org
List-Id: linux-omap@vger.kernel.org

This patch uses the resource-managed extcon API for extcon_register_notifier()
and replaces the deprecated extcon API as following:
- extcon_get_cable_state_() -> extcon_get_state()

Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 drivers/usb/dwc3/dwc3-omap.c | 20 +++++++-------------
 1 file changed, 7 insertions(+), 13 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-omap.c b/drivers/usb/dwc3/dwc3-omap.c
index 29e80cc9b634..2d2e9aa1db08 100644
--- a/drivers/usb/dwc3/dwc3-omap.c
+++ b/drivers/usb/dwc3/dwc3-omap.c
@@ -425,20 +425,20 @@ static int dwc3_omap_extcon_register(struct dwc3_omap *omap)
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
@@ -527,17 +527,13 @@ static int dwc3_omap_probe(struct platform_device *pdev)
 	ret = of_platform_populate(node, NULL, NULL, dev);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to create dwc3 core\n");
-		goto err2;
+		goto err1;
 	}
 
 	dwc3_omap_enable_irqs(omap);
 
 	return 0;
 
-err2:
-	extcon_unregister_notifier(omap->edev, EXTCON_USB, &omap->vbus_nb);
-	extcon_unregister_notifier(omap->edev, EXTCON_USB_HOST, &omap->id_nb);
-
 err1:
 	pm_runtime_put_sync(dev);
 	pm_runtime_disable(dev);
@@ -549,8 +545,6 @@ static int dwc3_omap_remove(struct platform_device *pdev)
 {
 	struct dwc3_omap	*omap = platform_get_drvdata(pdev);
 
-	extcon_unregister_notifier(omap->edev, EXTCON_USB, &omap->vbus_nb);
-	extcon_unregister_notifier(omap->edev, EXTCON_USB_HOST, &omap->id_nb);
 	dwc3_omap_disable_irqs(omap);
 	of_platform_depopulate(omap->dev);
 	pm_runtime_put_sync(&pdev->dev);
-- 
1.9.1

