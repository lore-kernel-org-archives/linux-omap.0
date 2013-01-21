From: Vivek Gautam <gautam.vivek@samsung.com>
Subject: [PATCH] usb: phy: samsung: Remove __devinit,
 __devexit_p and __exit annotations
Date: Mon, 21 Jan 2013 19:30:12 +0530
Message-ID: <1358776812-14158-1-git-send-email-gautam.vivek@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-usb@vger.kernel.org
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, gregkh@linuxfoundation.org, balbi@ti.com, p.paneri@samsung.com
List-Id: linux-omap@vger.kernel.org

Dropping __devinit, __devexit_p, __exit annotations since they are
nop and no longer supported.

Signed-off-by: Vivek Gautam <gautam.vivek@samsung.com>
---
 drivers/usb/phy/samsung-usbphy.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/phy/samsung-usbphy.c b/drivers/usb/phy/samsung-usbphy.c
index 30aebb5..6b30809 100644
--- a/drivers/usb/phy/samsung-usbphy.c
+++ b/drivers/usb/phy/samsung-usbphy.c
@@ -343,7 +343,7 @@ static inline const struct samsung_usbphy_drvdata
 				platform_get_device_id(pdev)->driver_data;
 }
 
-static int __devinit samsung_usbphy_probe(struct platform_device *pdev)
+static int samsung_usbphy_probe(struct platform_device *pdev)
 {
 	struct samsung_usbphy *sphy;
 	struct samsung_usbphy_data *pdata = pdev->dev.platform_data;
@@ -405,7 +405,7 @@ static int __devinit samsung_usbphy_probe(struct platform_device *pdev)
 	return usb_add_phy(&sphy->phy, USB_PHY_TYPE_USB2);
 }
 
-static int __exit samsung_usbphy_remove(struct platform_device *pdev)
+static int samsung_usbphy_remove(struct platform_device *pdev)
 {
 	struct samsung_usbphy *sphy = platform_get_drvdata(pdev);
 
@@ -456,7 +456,7 @@ MODULE_DEVICE_TABLE(platform, samsung_usbphy_driver_ids);
 
 static struct platform_driver samsung_usbphy_driver = {
 	.probe		= samsung_usbphy_probe,
-	.remove		= __devexit_p(samsung_usbphy_remove),
+	.remove		= samsung_usbphy_remove,
 	.id_table	= samsung_usbphy_driver_ids,
 	.driver		= {
 		.name	= "samsung-usbphy",
-- 
1.7.6.5
