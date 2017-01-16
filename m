From: Chanwoo Choi <cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH v3 3/6] usb: phy: omap-otg: Replace the extcon API
Date: Mon, 16 Jan 2017 21:36:59 +0900
Message-ID: <1484570222-30522-4-git-send-email-cw00.choi@samsung.com>
References: <1484570222-30522-1-git-send-email-cw00.choi@samsung.com>
 <CGME20170116123713epcas1p12ccac45604795c862e272534be38788e@epcas1p1.samsung.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <1484570222-30522-1-git-send-email-cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, chanwoo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, Chanwoo Choi <cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

This patch uses the resource-managed extcon API for extcon_register_notifier()
and replaces the deprecated extcon API as following:
- extcon_get_cable_state_() -> extcon_get_state()

Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Signed-off-by: Chanwoo Choi <cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Acked-by: Felipe Balbi <felipe.balbi-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
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
