From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH 1/3] phy: ti-pipe3: fix suspend
Date: Tue, 12 May 2015 19:07:06 +0300
Message-ID: <1431446828-5473-2-git-send-email-rogerq@ti.com>
References: <1431446828-5473-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1431446828-5473-1-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: kishon@ti.com, tony@atomide.com
Cc: nm@ti.com, nsekhar@ti.com, balbi@ti.com, grygorii.strashko@ti.com, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

Relying on PM-ops for shutting down PHY clocks was a
bad idea since the users (e.g. PCIe/SATA) might not
have been suspended by then.

The main culprit for not shutting down the clocks was
the stray pm_runtime_get() call in probe.

Fix the whole thing in the right way by getting rid
of that pm_runtime_get() call from probe and
removing all PM-ops. It is the sole responsibility
of the PHY user to properly turn OFF and de-initialize
the PHY as part of its suspend routine.

As PHY core serializes init/exit we don't need
to use a spinlock in this driver. So get rid of it.

Signed-off-by: Roger Quadros <rogerq@ti.com>
Signed-off-by: Sekhar Nori <nsekhar@ti.com>
---
 drivers/phy/phy-ti-pipe3.c | 112 ++++++++-------------------------------------
 1 file changed, 18 insertions(+), 94 deletions(-)

diff --git a/drivers/phy/phy-ti-pipe3.c b/drivers/phy/phy-ti-pipe3.c
index 53f295c..e13a306 100644
--- a/drivers/phy/phy-ti-pipe3.c
+++ b/drivers/phy/phy-ti-pipe3.c
@@ -28,7 +28,6 @@
 #include <linux/delay.h>
 #include <linux/phy/omap_control_phy.h>
 #include <linux/of_platform.h>
-#include <linux/spinlock.h>
 
 #define	PLL_STATUS		0x00000004
 #define	PLL_GO			0x00000008
@@ -83,10 +82,6 @@ struct ti_pipe3 {
 	struct clk		*refclk;
 	struct clk		*div_clk;
 	struct pipe3_dpll_map	*dpll_map;
-	bool			enabled;
-	spinlock_t		lock;	/* serialize clock enable/disable */
-	/* the below flag is needed specifically for SATA */
-	bool			refclk_enabled;
 };
 
 static struct pipe3_dpll_map dpll_map_usb[] = {
@@ -137,6 +132,9 @@ static struct pipe3_dpll_params *ti_pipe3_get_dpll_params(struct ti_pipe3 *phy)
 	return NULL;
 }
 
+static int ti_pipe3_enable_clocks(struct ti_pipe3 *phy);
+static void ti_pipe3_disable_clocks(struct ti_pipe3 *phy);
+
 static int ti_pipe3_power_off(struct phy *x)
 {
 	struct ti_pipe3 *phy = phy_get_drvdata(x);
@@ -217,6 +215,7 @@ static int ti_pipe3_init(struct phy *x)
 	u32 val;
 	int ret = 0;
 
+	ti_pipe3_enable_clocks(phy);
 	/*
 	 * Set pcie_pcs register to 0x96 for proper functioning of phy
 	 * as recommended in AM572x TRM SPRUHZ6, section 18.5.2.2, table
@@ -277,6 +276,8 @@ static int ti_pipe3_exit(struct phy *x)
 		return -EBUSY;
 	}
 
+	ti_pipe3_disable_clocks(phy);
+
 	return 0;
 }
 static struct phy_ops ops = {
@@ -305,8 +306,7 @@ static int ti_pipe3_probe(struct platform_device *pdev)
 	if (!phy)
 		return -ENOMEM;
 
-	phy->dev		= &pdev->dev;
-	spin_lock_init(&phy->lock);
+	phy->dev = &pdev->dev;
 
 	if (!of_device_is_compatible(node, "ti,phy-pipe3-pcie")) {
 		match = of_match_device(ti_pipe3_id_table, &pdev->dev);
@@ -402,6 +402,9 @@ static int ti_pipe3_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, phy);
 	pm_runtime_enable(phy->dev);
+	/* Prevent auto-disable of refclk for SATA PHY due to Errata i783 */
+	if (of_device_is_compatible(node, "ti,phy-pipe3-sata"))
+		clk_prepare_enable(phy->refclk);
 
 	generic_phy = devm_phy_create(phy->dev, NULL, &ops);
 	if (IS_ERR(generic_phy))
@@ -413,24 +416,19 @@ static int ti_pipe3_probe(struct platform_device *pdev)
 	if (IS_ERR(phy_provider))
 		return PTR_ERR(phy_provider);
 
-	pm_runtime_get(&pdev->dev);
-
 	return 0;
 }
 
 static int ti_pipe3_remove(struct platform_device *pdev)
 {
-	if (!pm_runtime_suspended(&pdev->dev))
-		pm_runtime_put(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 
 	return 0;
 }
 
-#ifdef CONFIG_PM
 static int ti_pipe3_enable_refclk(struct ti_pipe3 *phy)
 {
-	if (!IS_ERR(phy->refclk) && !phy->refclk_enabled) {
+	if (!IS_ERR(phy->refclk)) {
 		int ret;
 
 		ret = clk_prepare_enable(phy->refclk);
@@ -438,7 +436,6 @@ static int ti_pipe3_enable_refclk(struct ti_pipe3 *phy)
 			dev_err(phy->dev, "Failed to enable refclk %d\n", ret);
 			return ret;
 		}
-		phy->refclk_enabled = true;
 	}
 
 	return 0;
@@ -448,28 +445,21 @@ static void ti_pipe3_disable_refclk(struct ti_pipe3 *phy)
 {
 	if (!IS_ERR(phy->refclk))
 		clk_disable_unprepare(phy->refclk);
-
-	phy->refclk_enabled = false;
 }
 
 static int ti_pipe3_enable_clocks(struct ti_pipe3 *phy)
 {
 	int ret = 0;
-	unsigned long flags;
-
-	spin_lock_irqsave(&phy->lock, flags);
-	if (phy->enabled)
-		goto err1;
 
 	ret = ti_pipe3_enable_refclk(phy);
 	if (ret)
-		goto err1;
+		return ret;
 
 	if (!IS_ERR(phy->wkupclk)) {
 		ret = clk_prepare_enable(phy->wkupclk);
 		if (ret) {
 			dev_err(phy->dev, "Failed to enable wkupclk %d\n", ret);
-			goto err2;
+			goto disable_refclk;
 		}
 	}
 
@@ -477,96 +467,31 @@ static int ti_pipe3_enable_clocks(struct ti_pipe3 *phy)
 		ret = clk_prepare_enable(phy->div_clk);
 		if (ret) {
 			dev_err(phy->dev, "Failed to enable div_clk %d\n", ret);
-			goto err3;
+			goto disable_wkupclk;
 		}
 	}
 
-	phy->enabled = true;
-	spin_unlock_irqrestore(&phy->lock, flags);
 	return 0;
 
-err3:
+disable_wkupclk:
 	if (!IS_ERR(phy->wkupclk))
 		clk_disable_unprepare(phy->wkupclk);
 
-err2:
-	if (!IS_ERR(phy->refclk))
-		clk_disable_unprepare(phy->refclk);
-
+disable_refclk:
 	ti_pipe3_disable_refclk(phy);
-err1:
-	spin_unlock_irqrestore(&phy->lock, flags);
+
 	return ret;
 }
 
 static void ti_pipe3_disable_clocks(struct ti_pipe3 *phy)
 {
-	unsigned long flags;
-
-	spin_lock_irqsave(&phy->lock, flags);
-	if (!phy->enabled) {
-		spin_unlock_irqrestore(&phy->lock, flags);
-		return;
-	}
-
 	if (!IS_ERR(phy->wkupclk))
 		clk_disable_unprepare(phy->wkupclk);
-	/* Don't disable refclk for SATA PHY due to Errata i783 */
-	if (!of_device_is_compatible(phy->dev->of_node, "ti,phy-pipe3-sata"))
-		ti_pipe3_disable_refclk(phy);
+	ti_pipe3_disable_refclk(phy);
 	if (!IS_ERR(phy->div_clk))
 		clk_disable_unprepare(phy->div_clk);
-	phy->enabled = false;
-	spin_unlock_irqrestore(&phy->lock, flags);
 }
 
-static int ti_pipe3_runtime_suspend(struct device *dev)
-{
-	struct ti_pipe3	*phy = dev_get_drvdata(dev);
-
-	ti_pipe3_disable_clocks(phy);
-	return 0;
-}
-
-static int ti_pipe3_runtime_resume(struct device *dev)
-{
-	struct ti_pipe3	*phy = dev_get_drvdata(dev);
-	int ret = 0;
-
-	ret = ti_pipe3_enable_clocks(phy);
-	return ret;
-}
-
-static int ti_pipe3_suspend(struct device *dev)
-{
-	struct ti_pipe3	*phy = dev_get_drvdata(dev);
-
-	ti_pipe3_disable_clocks(phy);
-	return 0;
-}
-
-static int ti_pipe3_resume(struct device *dev)
-{
-	struct ti_pipe3	*phy = dev_get_drvdata(dev);
-	int ret;
-
-	ret = ti_pipe3_enable_clocks(phy);
-	if (ret)
-		return ret;
-
-	pm_runtime_disable(dev);
-	pm_runtime_set_active(dev);
-	pm_runtime_enable(dev);
-	return 0;
-}
-#endif
-
-static const struct dev_pm_ops ti_pipe3_pm_ops = {
-	SET_RUNTIME_PM_OPS(ti_pipe3_runtime_suspend,
-			   ti_pipe3_runtime_resume, NULL)
-	SET_SYSTEM_SLEEP_PM_OPS(ti_pipe3_suspend, ti_pipe3_resume)
-};
-
 static const struct of_device_id ti_pipe3_id_table[] = {
 	{
 		.compatible = "ti,phy-usb3",
@@ -592,7 +517,6 @@ static struct platform_driver ti_pipe3_driver = {
 	.remove		= ti_pipe3_remove,
 	.driver		= {
 		.name	= "ti-pipe3",
-		.pm	= &ti_pipe3_pm_ops,
 		.of_match_table = ti_pipe3_id_table,
 	},
 };
-- 
2.1.4
