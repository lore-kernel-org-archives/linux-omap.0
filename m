From: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v2 06/13] phy: ti-pipe3: Don't get 'wkupclk' and 'refclk' for SATA PHY
Date: Thu, 6 Mar 2014 16:38:42 +0200
Message-ID: <1394116729-28811-7-git-send-email-rogerq@ti.com>
References: <1394116729-28811-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1394116729-28811-1-git-send-email-rogerq-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: kishon-l0cyMroinI0@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org
Cc: george.cherian-l0cyMroinI0@public.gmane.org, balajitk-l0cyMroinI0@public.gmane.org, hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rogerq-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

SATA PHY doesn't need 'wkupclk; and 'refclk' so don't
try to get them for SATA PHY.

Signed-off-by: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
---
 drivers/phy/phy-ti-pipe3.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/drivers/phy/phy-ti-pipe3.c b/drivers/phy/phy-ti-pipe3.c
index f141237..baa3f78d 100644
--- a/drivers/phy/phy-ti-pipe3.c
+++ b/drivers/phy/phy-ti-pipe3.c
@@ -294,16 +294,22 @@ static int ti_pipe3_probe(struct platform_device *pdev)
 
 	phy->dev		= &pdev->dev;
 
-	phy->wkupclk = devm_clk_get(phy->dev, "wkupclk");
-	if (IS_ERR(phy->wkupclk)) {
-		dev_err(&pdev->dev, "unable to get wkupclk\n");
-		return PTR_ERR(phy->wkupclk);
-	}
+	if (!of_device_is_compatible(node, "ti,phy-pipe3-sata")) {
+
+		phy->wkupclk = devm_clk_get(phy->dev, "wkupclk");
+		if (IS_ERR(phy->wkupclk)) {
+			dev_err(&pdev->dev, "unable to get wkupclk\n");
+			return PTR_ERR(phy->wkupclk);
+		}
 
-	phy->refclk = devm_clk_get(phy->dev, "refclk");
-	if (IS_ERR(phy->refclk)) {
-		dev_err(&pdev->dev, "unable to get refclk\n");
-		return PTR_ERR(phy->refclk);
+		phy->refclk = devm_clk_get(phy->dev, "refclk");
+		if (IS_ERR(phy->refclk)) {
+			dev_err(&pdev->dev, "unable to get refclk\n");
+			return PTR_ERR(phy->refclk);
+		}
+	} else {
+		phy->wkupclk = ERR_PTR(-ENODEV);
+		phy->refclk = ERR_PTR(-ENODEV);
 	}
 
 	phy->sys_clk = devm_clk_get(phy->dev, "sysclk");
-- 
1.8.3.2

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
