From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCH v2 4/6] usb: phy: qcom-8x16-usb: Replace the extcon API
Date: Fri, 30 Dec 2016 13:08:13 +0900
Message-ID: <1483070895-8213-5-git-send-email-cw00.choi@samsung.com>
References: <1483070895-8213-1-git-send-email-cw00.choi@samsung.com>
 <CGME20161230040817epcas5p430bfef6b76d46ab5e69d5f45816b1af4@epcas5p4.samsung.com>
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
