From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH 1/3] phy: omap-usb2: support suspend/resume
Date: Tue, 23 Aug 2016 11:57:39 +0300
Message-ID: <1471942661-1728-2-git-send-email-rogerq@ti.com>
References: <1471942661-1728-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1471942661-1728-1-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: kishon@ti.com, tony@atomide.com
Cc: robh+dt@kernel.org, nsekhar@ti.com, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

From: Sekhar Nori <nsekhar@ti.com>

Relying on PM-ops for shutting down PHY clocks was a
bad idea since the users (e.g. USB DWC3) might not
have been suspended by then.

Get rid of all PM-ops. It is the sole responsibility
of the PHY user to properly turn OFF and de-initialize
the PHY as part of its suspend routine.

Enable/disable PHY clock as part of ->init()/->exit()
call respectively. With this phy_init() and phy_exit()
can be called by PHY user during suspend/resume.

This is similar to what is done for ti-pipe3 driver.
See 31c8954efb1b ("phy: ti-pipe3: fix suspend")

The pm_runtime_enable() call in omap_usb2_probe()
is still required because without it, phy_create()
will not enable runtime PM on the phy device it
creates and phy_init() will not call
pm_runtime_get_sync().

Without pm_runtime_get_sync(), ocp2scp hwmod will
_not_ enable the IP and, thus, we will have abort
exceptions.

Signed-off-by: Sekhar Nori <nsekhar@ti.com>
Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 drivers/phy/phy-omap-usb2.c | 100 ++++++++++++++++++++------------------------
 1 file changed, 46 insertions(+), 54 deletions(-)

diff --git a/drivers/phy/phy-omap-usb2.c b/drivers/phy/phy-omap-usb2.c
index c134989..fe909fd 100644
--- a/drivers/phy/phy-omap-usb2.c
+++ b/drivers/phy/phy-omap-usb2.c
@@ -133,11 +133,49 @@ static int omap_usb_power_on(struct phy *x)
 	return omap_usb_phy_power(phy, true);
 }
 
+static int omap_usb2_disable_clocks(struct omap_usb *phy)
+{
+	clk_disable(phy->wkupclk);
+	if (!IS_ERR(phy->optclk))
+		clk_disable(phy->optclk);
+
+	return 0;
+}
+
+static int omap_usb2_enable_clocks(struct omap_usb *phy)
+{
+	int ret;
+
+	ret = clk_enable(phy->wkupclk);
+	if (ret < 0) {
+		dev_err(phy->dev, "Failed to enable wkupclk %d\n", ret);
+		goto err0;
+	}
+
+	if (!IS_ERR(phy->optclk)) {
+		ret = clk_enable(phy->optclk);
+		if (ret < 0) {
+			dev_err(phy->dev, "Failed to enable optclk %d\n", ret);
+			goto err1;
+		}
+	}
+
+	return 0;
+
+err1:
+	clk_disable(phy->wkupclk);
+
+err0:
+	return ret;
+}
+
 static int omap_usb_init(struct phy *x)
 {
 	struct omap_usb *phy = phy_get_drvdata(x);
 	u32 val;
 
+	omap_usb2_enable_clocks(phy);
+
 	if (phy->flags & OMAP_USB2_CALIBRATE_FALSE_DISCONNECT) {
 		/*
 		 *
@@ -155,8 +193,16 @@ static int omap_usb_init(struct phy *x)
 	return 0;
 }
 
+static int omap_usb_exit(struct phy *x)
+{
+	struct omap_usb *phy = phy_get_drvdata(x);
+
+	return omap_usb2_disable_clocks(phy);
+}
+
 static const struct phy_ops ops = {
 	.init		= omap_usb_init,
+	.exit		= omap_usb_exit,
 	.power_on	= omap_usb_power_on,
 	.power_off	= omap_usb_power_off,
 	.owner		= THIS_MODULE,
@@ -376,65 +422,11 @@ static int omap_usb2_remove(struct platform_device *pdev)
 	return 0;
 }
 
-#ifdef CONFIG_PM
-
-static int omap_usb2_runtime_suspend(struct device *dev)
-{
-	struct platform_device	*pdev = to_platform_device(dev);
-	struct omap_usb	*phy = platform_get_drvdata(pdev);
-
-	clk_disable(phy->wkupclk);
-	if (!IS_ERR(phy->optclk))
-		clk_disable(phy->optclk);
-
-	return 0;
-}
-
-static int omap_usb2_runtime_resume(struct device *dev)
-{
-	struct platform_device	*pdev = to_platform_device(dev);
-	struct omap_usb	*phy = platform_get_drvdata(pdev);
-	int ret;
-
-	ret = clk_enable(phy->wkupclk);
-	if (ret < 0) {
-		dev_err(phy->dev, "Failed to enable wkupclk %d\n", ret);
-		goto err0;
-	}
-
-	if (!IS_ERR(phy->optclk)) {
-		ret = clk_enable(phy->optclk);
-		if (ret < 0) {
-			dev_err(phy->dev, "Failed to enable optclk %d\n", ret);
-			goto err1;
-		}
-	}
-
-	return 0;
-
-err1:
-	clk_disable(phy->wkupclk);
-
-err0:
-	return ret;
-}
-
-static const struct dev_pm_ops omap_usb2_pm_ops = {
-	SET_RUNTIME_PM_OPS(omap_usb2_runtime_suspend, omap_usb2_runtime_resume,
-		NULL)
-};
-
-#define DEV_PM_OPS     (&omap_usb2_pm_ops)
-#else
-#define DEV_PM_OPS     NULL
-#endif
-
 static struct platform_driver omap_usb2_driver = {
 	.probe		= omap_usb2_probe,
 	.remove		= omap_usb2_remove,
 	.driver		= {
 		.name	= "omap-usb2",
-		.pm	= DEV_PM_OPS,
 		.of_match_table = omap_usb2_id_table,
 	},
 };
-- 
2.7.4
