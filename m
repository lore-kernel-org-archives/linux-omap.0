From: Chanwoo Choi <cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 08/12] usb: phy: msm: Replace the extcon API
Date: Wed, 30 Nov 2016 14:57:36 +0900
Message-ID: <1480485460-2663-9-git-send-email-cw00.choi@samsung.com>
References: <1480485460-2663-1-git-send-email-cw00.choi@samsung.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <1480485460-2663-1-git-send-email-cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, kishon-l0cyMroinI0@public.gmane.org, sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: Peter.Chen-3arQi8VN3Tc@public.gmane.org, wens-jdAy2FN1RRM@public.gmane.org, yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org, maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, b-liu-l0cyMroinI0@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, chanwoo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
List-Id: linux-omap@vger.kernel.org

This patch uses the resource-managed extcon API for extcon_register_notifier()
and replaces the deprecated extcon API as following:
- extcon_get_cable_state_() -> extcon_get_state()

Signed-off-by: Chanwoo Choi <cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
---
 drivers/usb/phy/phy-msm-usb.c | 33 +++++++++++----------------------
 1 file changed, 11 insertions(+), 22 deletions(-)

diff --git a/drivers/usb/phy/phy-msm-usb.c b/drivers/usb/phy/phy-msm-usb.c
index 8a34759727bb..a15a89d4235d 100644
--- a/drivers/usb/phy/phy-msm-usb.c
+++ b/drivers/usb/phy/phy-msm-usb.c
@@ -1742,14 +1742,14 @@ static int msm_otg_read_dt(struct platform_device *pdev, struct msm_otg *motg)
 	if (!IS_ERR(ext_vbus)) {
 		motg->vbus.extcon = ext_vbus;
 		motg->vbus.nb.notifier_call = msm_otg_vbus_notifier;
-		ret = extcon_register_notifier(ext_vbus, EXTCON_USB,
-						&motg->vbus.nb);
+		ret = devm_extcon_register_notifier(&pdev->dev, ext_vbus,
+						EXTCON_USB, &motg->vbus.nb);
 		if (ret < 0) {
 			dev_err(&pdev->dev, "register VBUS notifier failed\n");
 			return ret;
 		}
 
-		ret = extcon_get_cable_state_(ext_vbus, EXTCON_USB);
+		ret = extcon_get_state(ext_vbus, EXTCON_USB);
 		if (ret)
 			set_bit(B_SESS_VLD, &motg->inputs);
 		else
@@ -1759,16 +1759,14 @@ static int msm_otg_read_dt(struct platform_device *pdev, struct msm_otg *motg)
 	if (!IS_ERR(ext_id)) {
 		motg->id.extcon = ext_id;
 		motg->id.nb.notifier_call = msm_otg_id_notifier;
-		ret = extcon_register_notifier(ext_id, EXTCON_USB_HOST,
-						&motg->id.nb);
+		ret = devm_extcon_register_notifier(&pdev->dev, ext_id,
+						EXTCON_USB_HOST, &motg->id.nb);
 		if (ret < 0) {
 			dev_err(&pdev->dev, "register ID notifier failed\n");
-			extcon_unregister_notifier(motg->vbus.extcon,
-						   EXTCON_USB, &motg->vbus.nb);
 			return ret;
 		}
 
-		ret = extcon_get_cable_state_(ext_id, EXTCON_USB_HOST);
+		ret = extcon_get_state(ext_id, EXTCON_USB_HOST);
 		if (ret)
 			clear_bit(ID, &motg->inputs);
 		else
@@ -1883,10 +1881,9 @@ static int msm_otg_probe(struct platform_device *pdev)
 	 */
 	if (motg->phy_number) {
 		phy_select = devm_ioremap_nocache(&pdev->dev, USB2_PHY_SEL, 4);
-		if (!phy_select) {
-			ret = -ENOMEM;
-			goto unregister_extcon;
-		}
+		if (!phy_select)
+			return -ENOMEM;
+
 		/* Enable second PHY with the OTG port */
 		writel(0x1, phy_select);
 	}
@@ -1897,7 +1894,7 @@ static int msm_otg_probe(struct platform_device *pdev)
 	if (motg->irq < 0) {
 		dev_err(&pdev->dev, "platform_get_irq failed\n");
 		ret = motg->irq;
-		goto unregister_extcon;
+		return motg->irq;
 	}
 
 	regs[0].supply = "vddcx";
@@ -1906,7 +1903,7 @@ static int msm_otg_probe(struct platform_device *pdev)
 
 	ret = devm_regulator_bulk_get(motg->phy.dev, ARRAY_SIZE(regs), regs);
 	if (ret)
-		goto unregister_extcon;
+		return ret;
 
 	motg->vddcx = regs[0].consumer;
 	motg->v3p3  = regs[1].consumer;
@@ -2003,11 +2000,6 @@ static int msm_otg_probe(struct platform_device *pdev)
 	clk_disable_unprepare(motg->clk);
 	if (!IS_ERR(motg->core_clk))
 		clk_disable_unprepare(motg->core_clk);
-unregister_extcon:
-	extcon_unregister_notifier(motg->id.extcon,
-				   EXTCON_USB_HOST, &motg->id.nb);
-	extcon_unregister_notifier(motg->vbus.extcon,
-				   EXTCON_USB, &motg->vbus.nb);
 
 	return ret;
 }
@@ -2029,9 +2021,6 @@ static int msm_otg_remove(struct platform_device *pdev)
 	 */
 	gpiod_set_value_cansleep(motg->switch_gpio, 0);
 
-	extcon_unregister_notifier(motg->id.extcon, EXTCON_USB_HOST, &motg->id.nb);
-	extcon_unregister_notifier(motg->vbus.extcon, EXTCON_USB, &motg->vbus.nb);
