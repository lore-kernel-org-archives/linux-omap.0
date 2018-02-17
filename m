From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH] phy: dm816x-usb: Remove unused phy_data
Date: Sat, 17 Feb 2018 12:47:09 -0800
Message-ID: <20180217204709.27265-1-tony@atomide.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

This is used by some TI USB PHY drivers but not this one, so we
can just remove it.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/phy/ti/phy-dm816x-usb.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/phy/ti/phy-dm816x-usb.c b/drivers/phy/ti/phy-dm816x-usb.c
--- a/drivers/phy/ti/phy-dm816x-usb.c
+++ b/drivers/phy/ti/phy-dm816x-usb.c
@@ -189,7 +189,6 @@ static int dm816x_usb_phy_probe(struct platform_device *pdev)
 	struct phy_provider *phy_provider;
 	struct usb_otg *otg;
 	const struct of_device_id *of_id;
-	const struct usb_phy_data *phy_data;
 	int error;
 
 	of_id = of_match_device(of_match_ptr(dm816x_usb_phy_id_table),
@@ -220,8 +219,6 @@ static int dm816x_usb_phy_probe(struct platform_device *pdev)
 	if (phy->usbphy_ctrl == 0x2c)
 		phy->instance = 1;
 
-	phy_data = of_id->data;
-
 	otg = devm_kzalloc(&pdev->dev, sizeof(*otg), GFP_KERNEL);
 	if (!otg)
 		return -ENOMEM;
-- 
2.16.1
