From: Sandhya Bankar <bankarsandhya512@gmail.com>
Subject: [PATCH] usb: phy-omap-otg: Space required after that ','.
Date: Tue, 31 May 2016 08:59:44 -0400
Message-ID: <20160531125944.GA19123@sandhya>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: balbi@kernel.org, gregkh@linuxfoundation.org, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Space required after that ','.

Signed-off-by: Sandhya Bankar <bankarsandhya512@gmail.com>
---
 drivers/usb/phy/phy-omap-otg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/phy/phy-omap-otg.c b/drivers/usb/phy/phy-omap-otg.c
index c4bf2de..6f6d2a7 100644
--- a/drivers/usb/phy/phy-omap-otg.c
+++ b/drivers/usb/phy/phy-omap-otg.c
@@ -148,7 +148,7 @@ static int omap_otg_remove(struct platform_device *pdev)
 	struct otg_device *otg_dev = platform_get_drvdata(pdev);
 	struct extcon_dev *edev = otg_dev->extcon;
 
-	extcon_unregister_notifier(edev, EXTCON_USB_HOST,&otg_dev->id_nb);
+	extcon_unregister_notifier(edev, EXTCON_USB_HOST, &otg_dev->id_nb);
 	extcon_unregister_notifier(edev, EXTCON_USB, &otg_dev->vbus_nb);
 
 	return 0;
-- 
1.8.3.4
