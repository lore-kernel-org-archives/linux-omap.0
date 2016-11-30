From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCH 09/12] usb: phy: omap-otg: Replace the extcon API
Date: Wed, 30 Nov 2016 14:57:37 +0900
Message-ID: <1480485460-2663-10-git-send-email-cw00.choi@samsung.com>
References: <1480485460-2663-1-git-send-email-cw00.choi@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1480485460-2663-1-git-send-email-cw00.choi@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: balbi@kernel.org, gregkh@linuxfoundation.org, kishon@ti.com, sre@kernel.org
Cc: Peter.Chen@nxp.com, wens@csie.org, yoshihiro.shimoda.uh@renesas.com, maxime.ripard@free-electrons.com, b-liu@ti.com, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-renesas-soc@vger.kernel.org, cw00.choi@samsung.com, chanwoo@kernel.org
List-Id: linux-omap@vger.kernel.org

This patch uses the resource-managed extcon API for extcon_register_notifier()
and replaces the deprecated extcon API as following:
- extcon_get_cable_state_() -> extcon_get_state()

Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
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
