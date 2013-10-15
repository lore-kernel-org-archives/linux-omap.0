From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v2 5/7] usb: phy: omap-usb2: remove *set_suspend* callback from omap-usb2
Date: Wed, 16 Oct 2013 01:24:15 +0530
Message-ID: <1381866857-3861-6-git-send-email-kishon@ti.com>
References: <1381866857-3861-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1381866857-3861-1-git-send-email-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: kishon@ti.com, balbi@ti.com, gregkh@linuxfoundation.org
Cc: rob.herring@calxeda.com, pawel.moll@arm.com, mark.rutland@arm.com, swarren@wwwdotorg.org, ijc+devicetree@hellion.org.uk, rob@landley.net, bcousson@baylibre.com, tony@atomide.com, linux@arm.linux.org.uk, grant.likely@linaro.org, s.nawrocki@samsung.com, galak@codeaurora.org, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Now that omap-usb2 is adapted to the new generic PHY framework,
*set_suspend* ops can be removed from omap-usb2 driver.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Acked-by: Felipe Balbi <balbi@ti.com>
Reviewed-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
---
This patch was deferred from Generic PHY framework series since dwc3 uses the
same driver and it has to be adapted to the Generic PHY Framework.

 drivers/phy/phy-omap-usb2.c |   25 -------------------------
 1 file changed, 25 deletions(-)

diff --git a/drivers/phy/phy-omap-usb2.c b/drivers/phy/phy-omap-usb2.c
index bfc5c33..9b3e867 100644
--- a/drivers/phy/phy-omap-usb2.c
+++ b/drivers/phy/phy-omap-usb2.c
@@ -98,28 +98,6 @@ static int omap_usb_set_peripheral(struct usb_otg *otg,
 	return 0;
 }
 
-static int omap_usb2_suspend(struct usb_phy *x, int suspend)
-{
-	struct omap_usb *phy = phy_to_omapusb(x);
-	int ret;
-
-	if (suspend && !phy->is_suspended) {
-		omap_control_usb_phy_power(phy->control_dev, 0);
-		pm_runtime_put_sync(phy->dev);
-		phy->is_suspended = 1;
-	} else if (!suspend && phy->is_suspended) {
-		ret = pm_runtime_get_sync(phy->dev);
-		if (ret < 0) {
-			dev_err(phy->dev, "get_sync failed with err %d\n", ret);
-			return ret;
-		}
-		omap_control_usb_phy_power(phy->control_dev, 1);
-		phy->is_suspended = 0;
-	}
-
-	return 0;
-}
-
 static int omap_usb_power_off(struct phy *x)
 {
 	struct omap_usb *phy = phy_get_drvdata(x);
@@ -173,7 +151,6 @@ static int omap_usb2_probe(struct platform_device *pdev)
 
 	phy->phy.dev		= phy->dev;
 	phy->phy.label		= "omap-usb2";
-	phy->phy.set_suspend	= omap_usb2_suspend;
 	phy->phy.otg		= otg;
 	phy->phy.type		= USB_PHY_TYPE_USB2;
 
@@ -195,8 +172,6 @@ static int omap_usb2_probe(struct platform_device *pdev)
 	}
 
 	phy->control_dev = &control_pdev->dev;
-
-	phy->is_suspended	= 1;
 	omap_control_usb_phy_power(phy->control_dev, 0);
 
 	otg->set_host		= omap_usb_set_host;
-- 
1.7.10.4
