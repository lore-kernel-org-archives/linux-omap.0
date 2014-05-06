From: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 03/17] phy: ti-pipe3: add external clock support for PCIe PHY
Date: Tue, 6 May 2014 19:03:49 +0530
Message-ID: <1399383244-14556-4-git-send-email-kishon@ti.com>
References: <1399383244-14556-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1399383244-14556-1-git-send-email-kishon-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: rogerq-l0cyMroinI0@public.gmane.org, balajitk-l0cyMroinI0@public.gmane.org, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>, Rajendra Nayak <rnayak-l0cyMroinI0@public.gmane.org>, Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>, Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

APLL used by PCIE phy can either use external clock as input or the clock
from DPLL. Added support for the APLL to use external clock as input here.

Cc: Rajendra Nayak <rnayak-l0cyMroinI0@public.gmane.org>
Cc: Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>
Cc: Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>
Signed-off-by: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
---
 Documentation/devicetree/bindings/phy/ti-phy.txt |    4 ++
 drivers/phy/phy-ti-pipe3.c                       |   75 ++++++++++++++--------
 2 files changed, 52 insertions(+), 27 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/ti-phy.txt b/Documentation/devicetree/bindings/phy/ti-phy.txt
index bc9afb5..d50f8ee 100644
--- a/Documentation/devicetree/bindings/phy/ti-phy.txt
+++ b/Documentation/devicetree/bindings/phy/ti-phy.txt
@@ -76,6 +76,10 @@ Required properties:
    * "dpll_ref_m2" - external dpll ref clk
    * "phy-div" - divider for apll
    * "div-clk" - apll clock
+   * "apll_mux" - mux for pcie apll
+   * "refclk_ext" - external reference clock for pcie apll
+ - ti,ext-clk: To specifiy if PCIE apll should use external clock. Applicable
+   only to PCIE PHY.
 
 Optional properties:
  - ctrl-module : phandle of the control module used by PHY driver to power on
diff --git a/drivers/phy/phy-ti-pipe3.c b/drivers/phy/phy-ti-pipe3.c
index d43019d..5513aa0 100644
--- a/drivers/phy/phy-ti-pipe3.c
+++ b/drivers/phy/phy-ti-pipe3.c
@@ -293,7 +293,7 @@ static int ti_pipe3_probe(struct platform_device *pdev)
 	struct device_node *control_node;
 	struct platform_device *control_pdev;
 	const struct of_device_id *match;
-	struct clk *clk;
+	struct clk *clk, *pclk;
 
 	phy = devm_kzalloc(&pdev->dev, sizeof(*phy), GFP_KERNEL);
 	if (!phy) {
@@ -302,6 +302,20 @@ static int ti_pipe3_probe(struct platform_device *pdev)
 	}
 	phy->dev		= &pdev->dev;
 
+	control_node = of_parse_phandle(node, "ctrl-module", 0);
+	if (!control_node) {
+		dev_err(&pdev->dev, "Failed to get control device phandle\n");
+		return -EINVAL;
+	}
+
+	control_pdev = of_find_device_by_node(control_node);
+	if (!control_pdev) {
+		dev_err(&pdev->dev, "Failed to get control device\n");
+		return -EINVAL;
+	}
+
+	phy->control_dev = &control_pdev->dev;
+
 	if (!of_device_is_compatible(node, "ti,phy-pipe3-pcie")) {
 		match = of_match_device(of_match_ptr(ti_pipe3_id_table),
 					&pdev->dev);
@@ -345,19 +359,40 @@ static int ti_pipe3_probe(struct platform_device *pdev)
 	}
 
 	if (of_device_is_compatible(node, "ti,phy-pipe3-pcie")) {
-		clk = devm_clk_get(phy->dev, "dpll_ref");
-		if (IS_ERR(clk)) {
-			dev_err(&pdev->dev, "unable to get dpll ref clk\n");
-			return PTR_ERR(clk);
+		if (!of_property_read_bool(node, "ti,ext-clk")) {
+			clk = devm_clk_get(phy->dev, "dpll_ref");
+			if (IS_ERR(clk)) {
+				dev_err(&pdev->dev,
+					"unable to get dpll ref clk\n");
+				return PTR_ERR(clk);
+			}
+			clk_set_rate(clk, 1500000000);
+
+			clk = devm_clk_get(phy->dev, "dpll_ref_m2");
+			if (IS_ERR(clk)) {
+				dev_err(&pdev->dev,
+					"unable to get dpll ref m2 clk\n");
+				return PTR_ERR(clk);
+			}
+			clk_set_rate(clk, 100000000);
+		} else {
+			omap_control_pcie_tx_rx_control(phy->control_dev,
+						OMAP_CTRL_PCIE_PHY_RX_ACSPCIE);
+
+			clk = clk_get(phy->dev, "apll_mux");
+			if (IS_ERR(clk)) {
+				dev_err(&pdev->dev, "unable to get apll mux clk\n");
+				return PTR_ERR(clk);
+			}
+
+			pclk = clk_get(phy->dev, "refclk_ext");
+			if (IS_ERR(pclk)) {
+				dev_err(&pdev->dev, "unable to get ext ref clk for apll\n");
+				return PTR_ERR(pclk);
+			}
+
+			clk_set_parent(clk, pclk);
 		}
-		clk_set_rate(clk, 1500000000);
-
-		clk = devm_clk_get(phy->dev, "dpll_ref_m2");
-		if (IS_ERR(clk)) {
-			dev_err(&pdev->dev, "unable to get dpll ref m2 clk\n");
-			return PTR_ERR(clk);
-		}
-		clk_set_rate(clk, 100000000);
 
 		clk = devm_clk_get(phy->dev, "phy-div");
 		if (IS_ERR(clk)) {
@@ -375,20 +410,6 @@ static int ti_pipe3_probe(struct platform_device *pdev)
 		phy->div_clk = ERR_PTR(-ENODEV);
 	}
 
-	control_node = of_parse_phandle(node, "ctrl-module", 0);
-	if (!control_node) {
-		dev_err(&pdev->dev, "Failed to get control device phandle\n");
-		return -EINVAL;
-	}
-
-	control_pdev = of_find_device_by_node(control_node);
-	if (!control_pdev) {
-		dev_err(&pdev->dev, "Failed to get control device\n");
-		return -EINVAL;
-	}
-
-	phy->control_dev = &control_pdev->dev;
-
 	omap_control_phy_power(phy->control_dev, 0);
 
 	platform_set_drvdata(pdev, phy);
-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
