From: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v2 2/2] usb: phy: omap-usb2: enable 960Mhz clock for omap5
Date: Thu, 27 Sep 2012 19:34:08 +0530
Message-ID: <1348754648-8315-3-git-send-email-kishon@ti.com>
References: <1348754648-8315-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1348754648-8315-1-git-send-email-kishon-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

"usb_otg_ss_refclk960m" is needed for usb2 phy present in omap5. For
omap4, the clk_get of this clock will fail since it does not have this
clock.

Signed-off-by: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
---
 drivers/usb/phy/omap-usb2.c |   18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/phy/omap-usb2.c b/drivers/usb/phy/omap-usb2.c
index d36c282..5512207 100644
--- a/drivers/usb/phy/omap-usb2.c
+++ b/drivers/usb/phy/omap-usb2.c
@@ -190,6 +190,12 @@ static int __devinit omap_usb2_probe(struct platform_device *pdev)
 	}
 	clk_prepare(phy->wkupclk);
 
+	phy->optclk = devm_clk_get(phy->dev, "usb_otg_ss_refclk960m");
+	if (IS_ERR(phy->optclk))
+		dev_vdbg(&pdev->dev, "unable to get refclk960m\n");
+	else
+		clk_prepare(phy->optclk);
+
 	usb_add_phy(&phy->phy, USB_PHY_TYPE_USB2);
 
 	platform_set_drvdata(pdev, phy);
@@ -204,6 +210,7 @@ static int __devexit omap_usb2_remove(struct platform_device *pdev)
 	struct omap_usb	*phy = platform_get_drvdata(pdev);
 
 	clk_unprepare(phy->wkupclk);
+	clk_unprepare(phy->optclk);
 	usb_remove_phy(&phy->phy);
 
 	return 0;
@@ -217,6 +224,7 @@ static int omap_usb2_runtime_suspend(struct device *dev)
 	struct omap_usb	*phy = platform_get_drvdata(pdev);
 
 	clk_disable(phy->wkupclk);
+	clk_disable(phy->optclk);
 
 	return 0;
 }
@@ -228,10 +236,16 @@ static int omap_usb2_runtime_resume(struct device *dev)
 	struct omap_usb	*phy = platform_get_drvdata(pdev);
 
 	ret = clk_enable(phy->wkupclk);
-	if (ret < 0)
+	if (ret < 0) {
 		dev_err(phy->dev, "Failed to enable wkupclk %d\n", ret);
+		return ret;
+	}
 
-	return ret;
+	ret = clk_enable(phy->optclk);
+	if (ret < 0)
+		dev_vdbg(phy->dev, "Failed to enable optclk %d\n", ret);
+
+	return 0;
 }
 
 static const struct dev_pm_ops omap_usb2_pm_ops = {
-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
