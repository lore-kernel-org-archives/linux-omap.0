From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH 1/7] phy: ti-pipe3: cleanup ti_pipe3_probe()
Date: Tue, 4 Aug 2015 20:50:40 +0530
Message-ID: <1438701646-7876-2-git-send-email-kishon@ti.com>
References: <1438701646-7876-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1438701646-7876-1-git-send-email-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: rogerq@ti.com, tony@atomide.com, t-kristo@ti.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, kishon@ti.com
Cc: balbi@ti.com, nsekhar@ti.com
List-Id: linux-omap@vger.kernel.org

No functional change. Add separate functions for pll,
clocks and syscon to make ti_pipe3_probe clean.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/phy/phy-ti-pipe3.c |  165 ++++++++++++++++++++++++++++----------------
 1 file changed, 104 insertions(+), 61 deletions(-)

diff --git a/drivers/phy/phy-ti-pipe3.c b/drivers/phy/phy-ti-pipe3.c
index 08020dc..072d308 100644
--- a/drivers/phy/phy-ti-pipe3.c
+++ b/drivers/phy/phy-ti-pipe3.c
@@ -308,51 +308,45 @@ static struct phy_ops ops = {
 
 static const struct of_device_id ti_pipe3_id_table[];
 
-static int ti_pipe3_probe(struct platform_device *pdev)
+static int ti_pipe3_get_pll_base(struct ti_pipe3 *phy)
 {
-	struct ti_pipe3 *phy;
-	struct phy *generic_phy;
-	struct phy_provider *phy_provider;
 	struct resource *res;
-	struct device_node *node = pdev->dev.of_node;
-	struct device_node *control_node;
-	struct platform_device *control_pdev;
 	const struct of_device_id *match;
-	struct clk *clk;
+	struct device *dev = phy->dev;
+	struct device_node *node = dev->of_node;
+	struct platform_device *pdev = to_platform_device(dev);
 
-	phy = devm_kzalloc(&pdev->dev, sizeof(*phy), GFP_KERNEL);
-	if (!phy)
-		return -ENOMEM;
+	if (of_device_is_compatible(node, "ti,phy-pipe3-pcie"))
+		return 0;
 
-	phy->dev		= &pdev->dev;
+	match = of_match_device(ti_pipe3_id_table, dev);
+	if (!match)
+		return -EINVAL;
 
-	if (!of_device_is_compatible(node, "ti,phy-pipe3-pcie")) {
-		match = of_match_device(ti_pipe3_id_table, &pdev->dev);
-		if (!match)
-			return -EINVAL;
+	phy->dpll_map = (struct pipe3_dpll_map *)match->data;
+	if (!phy->dpll_map) {
+		dev_err(dev, "no DPLL data\n");
+		return -EINVAL;
+	}
 
-		phy->dpll_map = (struct pipe3_dpll_map *)match->data;
-		if (!phy->dpll_map) {
-			dev_err(&pdev->dev, "no DPLL data\n");
-			return -EINVAL;
-		}
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
+					   "pll_ctrl");
+	phy->pll_ctrl_base = devm_ioremap_resource(dev, res);
+	if (IS_ERR(phy->pll_ctrl_base))
+		return PTR_ERR(phy->pll_ctrl_base);
 
-		res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
-						   "pll_ctrl");
-		phy->pll_ctrl_base = devm_ioremap_resource(&pdev->dev, res);
-		if (IS_ERR(phy->pll_ctrl_base))
-			return PTR_ERR(phy->pll_ctrl_base);
+	return 0;
+}
 
-		phy->sys_clk = devm_clk_get(phy->dev, "sysclk");
-		if (IS_ERR(phy->sys_clk)) {
-			dev_err(&pdev->dev, "unable to get sysclk\n");
-			return -EINVAL;
-		}
-	}
+static int ti_pipe3_get_clk(struct ti_pipe3 *phy)
+{
+	struct clk *clk;
+	struct device *dev = phy->dev;
+	struct device_node *node = dev->of_node;
 
-	phy->refclk = devm_clk_get(phy->dev, "refclk");
+	phy->refclk = devm_clk_get(dev, "refclk");
 	if (IS_ERR(phy->refclk)) {
-		dev_err(&pdev->dev, "unable to get refclk\n");
+		dev_err(dev, "unable to get refclk\n");
 		/* older DTBs have missing refclk in SATA PHY
 		 * so don't bail out in case of SATA PHY.
 		 */
@@ -361,76 +355,125 @@ static int ti_pipe3_probe(struct platform_device *pdev)
 	}
 
 	if (!of_device_is_compatible(node, "ti,phy-pipe3-sata")) {
-		phy->wkupclk = devm_clk_get(phy->dev, "wkupclk");
+		phy->wkupclk = devm_clk_get(dev, "wkupclk");
 		if (IS_ERR(phy->wkupclk)) {
-			dev_err(&pdev->dev, "unable to get wkupclk\n");
+			dev_err(dev, "unable to get wkupclk\n");
 			return PTR_ERR(phy->wkupclk);
 		}
 	} else {
 		phy->wkupclk = ERR_PTR(-ENODEV);
-		phy->dpll_reset_syscon = syscon_regmap_lookup_by_phandle(node,
-							"syscon-pllreset");
-		if (IS_ERR(phy->dpll_reset_syscon)) {
-			dev_info(&pdev->dev,
-				 "can't get syscon-pllreset, sata dpll won't idle\n");
-			phy->dpll_reset_syscon = NULL;
-		} else {
-			if (of_property_read_u32_index(node,
-						       "syscon-pllreset", 1,
-						       &phy->dpll_reset_reg)) {
-				dev_err(&pdev->dev,
-					"couldn't get pllreset reg. offset\n");
-				return -EINVAL;
-			}
+	}
+
+	if (!of_device_is_compatible(node, "ti,phy-pipe3-pcie")) {
+		phy->sys_clk = devm_clk_get(dev, "sysclk");
+		if (IS_ERR(phy->sys_clk)) {
+			dev_err(dev, "unable to get sysclk\n");
+			return -EINVAL;
 		}
 	}
 
 	if (of_device_is_compatible(node, "ti,phy-pipe3-pcie")) {
-
-		clk = devm_clk_get(phy->dev, "dpll_ref");
+		clk = devm_clk_get(dev, "dpll_ref");
 		if (IS_ERR(clk)) {
-			dev_err(&pdev->dev, "unable to get dpll ref clk\n");
+			dev_err(dev, "unable to get dpll ref clk\n");
 			return PTR_ERR(clk);
 		}
 		clk_set_rate(clk, 1500000000);
 
-		clk = devm_clk_get(phy->dev, "dpll_ref_m2");
+		clk = devm_clk_get(dev, "dpll_ref_m2");
 		if (IS_ERR(clk)) {
-			dev_err(&pdev->dev, "unable to get dpll ref m2 clk\n");
+			dev_err(dev, "unable to get dpll ref m2 clk\n");
 			return PTR_ERR(clk);
 		}
 		clk_set_rate(clk, 100000000);
 
-		clk = devm_clk_get(phy->dev, "phy-div");
+		clk = devm_clk_get(dev, "phy-div");
 		if (IS_ERR(clk)) {
-			dev_err(&pdev->dev, "unable to get phy-div clk\n");
+			dev_err(dev, "unable to get phy-div clk\n");
 			return PTR_ERR(clk);
 		}
 		clk_set_rate(clk, 100000000);
 
-		phy->div_clk = devm_clk_get(phy->dev, "div-clk");
+		phy->div_clk = devm_clk_get(dev, "div-clk");
 		if (IS_ERR(phy->div_clk)) {
-			dev_err(&pdev->dev, "unable to get div-clk\n");
+			dev_err(dev, "unable to get div-clk\n");
 			return PTR_ERR(phy->div_clk);
 		}
 	} else {
 		phy->div_clk = ERR_PTR(-ENODEV);
 	}
 
+	return 0;
+}
+
+static int ti_pipe3_get_sysctrl(struct ti_pipe3 *phy)
+{
+	struct device *dev = phy->dev;
+	struct device_node *node = dev->of_node;
+	struct device_node *control_node;
+	struct platform_device *control_pdev;
+
 	control_node = of_parse_phandle(node, "ctrl-module", 0);
 	if (!control_node) {
-		dev_err(&pdev->dev, "Failed to get control device phandle\n");
+		dev_err(dev, "Failed to get control device phandle\n");
 		return -EINVAL;
 	}
 
 	control_pdev = of_find_device_by_node(control_node);
 	if (!control_pdev) {
-		dev_err(&pdev->dev, "Failed to get control device\n");
+		dev_err(dev, "Failed to get control device\n");
 		return -EINVAL;
 	}
 
 	phy->control_dev = &control_pdev->dev;
 
+	if (of_device_is_compatible(node, "ti,phy-pipe3-sata")) {
+		phy->dpll_reset_syscon = syscon_regmap_lookup_by_phandle(node,
+							"syscon-pllreset");
+		if (IS_ERR(phy->dpll_reset_syscon)) {
+			dev_info(dev,
+				 "can't get syscon-pllreset, sata dpll won't idle\n");
+			phy->dpll_reset_syscon = NULL;
+		} else {
+			if (of_property_read_u32_index(node, "syscon-pllreset",
+						       1,
+						       &phy->dpll_reset_reg)) {
+				dev_err(dev,
+					"can't get pllreset reg. offset\n");
+				return -EINVAL;
+			}
+		}
+	}
+
+	return 0;
+}
+
+static int ti_pipe3_probe(struct platform_device *pdev)
+{
+	int ret;
+	struct ti_pipe3 *phy;
+	struct phy *generic_phy;
+	struct phy_provider *phy_provider;
+	struct device_node *node = pdev->dev.of_node;
+
+	phy = devm_kzalloc(&pdev->dev, sizeof(*phy), GFP_KERNEL);
+	if (!phy)
+		return -ENOMEM;
+
+	phy->dev		= &pdev->dev;
+
+	ret = ti_pipe3_get_pll_base(phy);
+	if (ret)
+		return ret;
+
+	ret = ti_pipe3_get_sysctrl(phy);
+	if (ret)
+		return ret;
+
+	ret = ti_pipe3_get_clk(phy);
+	if (ret)
+		return ret;
+
 	omap_control_phy_power(phy->control_dev, 0);
 
 	platform_set_drvdata(pdev, phy);
-- 
1.7.9.5
