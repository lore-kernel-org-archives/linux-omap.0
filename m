From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCH v2 3/6] usb: phy: omap-otg: Replace the extcon API
Date: Fri, 30 Dec 2016 13:08:12 +0900
Message-ID: <1483070895-8213-4-git-send-email-cw00.choi@samsung.com>
References: <1483070895-8213-1-git-send-email-cw00.choi@samsung.com>
 <CGME20161230040816epcas5p47433110fddafafca1a8b8a64acee1835@epcas5p4.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1483070895-8213-1-git-send-email-cw00.choi@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: balbi@kernel.org, gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-renesas-soc@vger.kernel.org, chanwoo@kernel.org, Chanwoo Choi <cw00.choi@samsung.com>
List-Id: linux-omap@vger.kernel.org

This patch uses the resource-managed extcon API for extcon_register_notifier()
and replaces the deprecated extcon API as following:
- extcon_get_cable_state_() -> extcon_get_state()

Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
Acked-by: Felipe Balbi <felipe.balbi@linux.intel.com>
---
 drivers/usb/phy/phy-omap-otg.c | 24 ++++++------------------
 1 file changed, 6 insertions(+), 18 deletions(-)

diff --git a/drivers/usb/phy/phy-omap-otg.c b/drivers/usb/phy/phy-omap-otg.c
index 6523af4f8f93..800d1d90753d 100644
--- a/drivers/usb/phy/phy-omap-otg.c
+++ b/drivers/usb/phy/phy-omap-otg.c
@@ -118,19 +118,19 @@ static int omap_otg_probe(struct platform_device *pdev)
 	otg_dev->id_nb.notifier_call = omap_otg_id_notifier;
 	otg_dev->vbus_nb.notifier_call = omap_otg_vbus_notifier;
 
-	ret = extcon_register_notifier(extcon, EXTCON_USB_HOST, &otg_dev->id_nb);
+	ret = devm_extcon_register_notifier(&pdev->dev, extcon,
+					EXTCON_USB_HOST, &otg_dev->id_nb);
 	if (ret)
 		return ret;
 
-	ret = extcon_register_notifier(extcon, EXTCON_USB, &otg_dev->vbus_nb);
+	ret = devm_extcon_register_notifier(&pdev->dev, extcon,
+					EXTCON_USB, &otg_dev->vbus_nb);
 	if (ret) {
-		extcon_unregister_notifier(extcon, EXTCON_USB_HOST,
-					&otg_dev->id_nb);
 		return ret;
 	}
 
-	otg_dev->id = extcon_get_cable_state_(extcon, EXTCON_USB_HOST);
-	otg_dev->vbus = extcon_get_cable_state_(extcon, EXTCON_USB);
+	otg_dev->id = extcon_get_state(extcon, EXTCON_USB_HOST);
+	otg_dev->vbus = extcon_get_state(extcon, EXTCON_USB);
 	omap_otg_set_mode(otg_dev);
 
 	rev = readl(otg_dev->base);
@@ -145,20 +145,8 @@ static int omap_otg_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int omap_otg_remove(struct platform_device *pdev)
-{
-	struct otg_device *otg_dev = platform_get_drvdata(pdev);
-	struct extcon_dev *edev = otg_dev->extcon;
-
-	extcon_unregister_notifier(edev, EXTCON_USB_HOST, &otg_dev->id_nb);
-	extcon_unregister_notifier(edev, EXTCON_USB, &otg_dev->vbus_nb);
-
-	return 0;
-}
-
 static struct platform_driver omap_otg_driver = {
 	.probe		= omap_otg_probe,
-	.remove		= omap_otg_remove,
 	.driver		= {
 		.name	= "omap_otg",
 	},
-- 
1.9.1
