From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCH 10/12] usb: phy: qcom-8x16-usb: Replace the extcon API
Date: Wed, 30 Nov 2016 14:57:38 +0900
Message-ID: <1480485460-2663-11-git-send-email-cw00.choi@samsung.com>
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
 drivers/usb/phy/phy-qcom-8x16-usb.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/usb/phy/phy-qcom-8x16-usb.c b/drivers/usb/phy/phy-qcom-8x16-usb.c
index d8593adb3621..fdf686398772 100644
--- a/drivers/usb/phy/phy-qcom-8x16-usb.c
+++ b/drivers/usb/phy/phy-qcom-8x16-usb.c
@@ -187,7 +187,7 @@ static int phy_8x16_init(struct usb_phy *phy)
 	val = ULPI_PWR_OTG_COMP_DISABLE;
 	usb_phy_io_write(phy, val, ULPI_SET(ULPI_PWR_CLK_MNG_REG));
 
-	state = extcon_get_cable_state_(qphy->vbus_edev, EXTCON_USB);
+	state = extcon_get_state(qphy->vbus_edev, EXTCON_USB);
 	if (state)
 		phy_8x16_vbus_on(qphy);
 	else
@@ -316,23 +316,20 @@ static int phy_8x16_probe(struct platform_device *pdev)
 		goto off_clks;
 
 	qphy->vbus_notify.notifier_call = phy_8x16_vbus_notify;
-	ret = extcon_register_notifier(qphy->vbus_edev, EXTCON_USB,
-				       &qphy->vbus_notify);
+	ret = devm_extcon_register_notifier(&pdev->dev, qphy->vbus_edev,
+					EXTCON_USB, &qphy->vbus_notify);
 	if (ret < 0)
 		goto off_power;
 
 	ret = usb_add_phy_dev(&qphy->phy);
 	if (ret)
-		goto off_extcon;
+		goto off_power;
 
 	qphy->reboot_notify.notifier_call = phy_8x16_reboot_notify;
 	register_reboot_notifier(&qphy->reboot_notify);
 
 	return 0;
 
-off_extcon:
-	extcon_unregister_notifier(qphy->vbus_edev, EXTCON_USB,
-				   &qphy->vbus_notify);
 off_power:
 	regulator_bulk_disable(ARRAY_SIZE(qphy->regulator), qphy->regulator);
 off_clks:
@@ -347,8 +344,6 @@ static int phy_8x16_remove(struct platform_device *pdev)
 	struct phy_8x16 *qphy = platform_get_drvdata(pdev);
 
 	unregister_reboot_notifier(&qphy->reboot_notify);
-	extcon_unregister_notifier(qphy->vbus_edev, EXTCON_USB,
-				   &qphy->vbus_notify);
 
 	/*
 	 * Ensure that D+/D- lines are routed to uB connector, so
-- 
1.9.1

