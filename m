From: Nicolae Rosia <Nicolae_Rosia@mentor.com>
Subject: [PATCH] phy: twl4030-usb: make driver DT only
Date: Sat, 12 Nov 2016 12:39:51 +0200
Message-ID: <1478947191-30532-1-git-send-email-Nicolae_Rosia@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: linux-kernel@vger.kernel.org, Felipe Balbi <balbi@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Nicolae Rosia <Nicolae_Rosia@mentor.com>
List-Id: linux-omap@vger.kernel.org

All users are DT-only and it makes no sense to keep
unused code

Signed-off-by: Nicolae Rosia <Nicolae_Rosia@mentor.com>
---
 drivers/phy/Kconfig           |  1 +
 drivers/phy/phy-twl4030-usb.c | 22 +++++++---------------
 2 files changed, 8 insertions(+), 15 deletions(-)

diff --git a/drivers/phy/Kconfig b/drivers/phy/Kconfig
index fe00f91..265391e 100644
--- a/drivers/phy/Kconfig
+++ b/drivers/phy/Kconfig
@@ -196,6 +196,7 @@ config TWL4030_USB
 	depends on TWL4030_CORE && REGULATOR_TWL4030 && USB_MUSB_OMAP2PLUS
 	depends on USB_SUPPORT
 	depends on USB_GADGET || !USB_GADGET # if USB_GADGET=m, this can't 'y'
+	depends on OF
 	select GENERIC_PHY
 	select USB_PHY
 	help
diff --git a/drivers/phy/phy-twl4030-usb.c b/drivers/phy/phy-twl4030-usb.c
index 87e6334..a5e4927 100644
--- a/drivers/phy/phy-twl4030-usb.c
+++ b/drivers/phy/phy-twl4030-usb.c
@@ -656,7 +656,6 @@ static const struct dev_pm_ops twl4030_usb_pm_ops = {
 
 static int twl4030_usb_probe(struct platform_device *pdev)
 {
-	struct twl4030_usb_data *pdata = dev_get_platdata(&pdev->dev);
 	struct twl4030_usb	*twl;
 	struct phy		*phy;
 	int			status, err;
@@ -664,19 +663,17 @@ static int twl4030_usb_probe(struct platform_device *pdev)
 	struct device_node	*np = pdev->dev.of_node;
 	struct phy_provider	*phy_provider;
 
+	if (!np) {
+		dev_err(&pdev->dev, "no DT info\n");
+		return -EINVAL;
+	}
+
 	twl = devm_kzalloc(&pdev->dev, sizeof(*twl), GFP_KERNEL);
 	if (!twl)
 		return -ENOMEM;
 
-	if (np)
-		of_property_read_u32(np, "usb_mode",
-				(enum twl4030_usb_mode *)&twl->usb_mode);
-	else if (pdata) {
-		twl->usb_mode = pdata->usb_mode;
-	} else {
-		dev_err(&pdev->dev, "twl4030 initialized without pdata\n");
-		return -EINVAL;
-	}
+	of_property_read_u32(np, "usb_mode",
+			(enum twl4030_usb_mode *)&twl->usb_mode);
 
 	otg = devm_kzalloc(&pdev->dev, sizeof(*otg), GFP_KERNEL);
 	if (!otg)
@@ -750,11 +747,6 @@ static int twl4030_usb_probe(struct platform_device *pdev)
 		return status;
 	}
 
-	if (pdata)
-		err = phy_create_lookup(phy, "usb", "musb-hdrc.0");
-	if (err)
-		return err;
-
 	pm_runtime_mark_last_busy(&pdev->dev);
 	pm_runtime_put_autosuspend(twl->dev);
 
-- 
2.5.5
