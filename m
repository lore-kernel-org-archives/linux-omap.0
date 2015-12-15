From: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v3 3/9] phy: ti-pipe3: move sysctrl initialization to a separate function
Date: Tue, 15 Dec 2015 14:46:02 +0530
Message-ID: <1450170968-11282-4-git-send-email-kishon@ti.com>
References: <1450170968-11282-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1450170968-11282-1-git-send-email-kishon-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: kishon-l0cyMroinI0@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, rogerq-l0cyMroinI0@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, t-kristo-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

No functional change. Moved sysctrl initialization done in probe to a
separate function as part of cleaning up ti_pipe3_probe.

Signed-off-by: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
---
 drivers/phy/phy-ti-pipe3.c |   78 +++++++++++++++++++++++++-------------------
 1 file changed, 45 insertions(+), 33 deletions(-)

diff --git a/drivers/phy/phy-ti-pipe3.c b/drivers/phy/phy-ti-pipe3.c
index 3379a4d..3154da0 100644
--- a/drivers/phy/phy-ti-pipe3.c
+++ b/drivers/phy/phy-ti-pipe3.c
@@ -376,6 +376,48 @@ static int ti_pipe3_get_clk(struct ti_pipe3 *phy)
 	return 0;
 }
 
+static int ti_pipe3_get_sysctrl(struct ti_pipe3 *phy)
+{
+	struct device *dev = phy->dev;
+	struct device_node *node = dev->of_node;
+	struct device_node *control_node;
+	struct platform_device *control_pdev;
+
+	control_node = of_parse_phandle(node, "ctrl-module", 0);
+	if (!control_node) {
+		dev_err(dev, "Failed to get control device phandle\n");
+		return -EINVAL;
+	}
+
+	control_pdev = of_find_device_by_node(control_node);
+	if (!control_pdev) {
+		dev_err(dev, "Failed to get control device\n");
+		return -EINVAL;
+	}
+
+	phy->control_dev = &control_pdev->dev;
+
+	if (of_device_is_compatible(node, "ti,phy-pipe3-sata")) {
+		phy->dpll_reset_syscon = syscon_regmap_lookup_by_phandle(node,
+							"syscon-pllreset");
+		if (IS_ERR(phy->dpll_reset_syscon)) {
+			dev_info(dev,
+				 "can't get syscon-pllreset, sata dpll won't idle\n");
+			phy->dpll_reset_syscon = NULL;
+		} else {
+			if (of_property_read_u32_index(node,
+						       "syscon-pllreset", 1,
+						       &phy->dpll_reset_reg)) {
+				dev_err(dev,
+					"couldn't get pllreset reg. offset\n");
+				return -EINVAL;
+			}
+		}
+	}
+
+	return 0;
+}
+
 static int ti_pipe3_probe(struct platform_device *pdev)
 {
 	struct ti_pipe3 *phy;
@@ -383,8 +425,6 @@ static int ti_pipe3_probe(struct platform_device *pdev)
 	struct phy_provider *phy_provider;
 	struct resource *res;
 	struct device_node *node = pdev->dev.of_node;
-	struct device_node *control_node;
-	struct platform_device *control_pdev;
 	const struct of_device_id *match;
 	struct device *dev = &pdev->dev;
 	int ret;
@@ -413,42 +453,14 @@ static int ti_pipe3_probe(struct platform_device *pdev)
 			return PTR_ERR(phy->pll_ctrl_base);
 	}
 
-	if (of_device_is_compatible(node, "ti,phy-pipe3-sata")) {
-		phy->dpll_reset_syscon = syscon_regmap_lookup_by_phandle(node,
-							"syscon-pllreset");
-		if (IS_ERR(phy->dpll_reset_syscon)) {
-			dev_info(dev,
-				 "can't get syscon-pllreset, sata dpll won't idle\n");
-			phy->dpll_reset_syscon = NULL;
-		} else {
-			if (of_property_read_u32_index(node,
-						       "syscon-pllreset", 1,
-						       &phy->dpll_reset_reg)) {
-				dev_err(dev,
-					"couldn't get pllreset reg. offset\n");
-				return -EINVAL;
-			}
-		}
-	}
+	ret = ti_pipe3_get_sysctrl(phy);
+	if (ret)
+		return ret;
 
 	ret = ti_pipe3_get_clk(phy);
 	if (ret)
 		return ret;
 
-	control_node = of_parse_phandle(node, "ctrl-module", 0);
-	if (!control_node) {
-		dev_err(dev, "Failed to get control device phandle\n");
-		return -EINVAL;
-	}
-
-	control_pdev = of_find_device_by_node(control_node);
-	if (!control_pdev) {
-		dev_err(dev, "Failed to get control device\n");
-		return -EINVAL;
-	}
-
-	phy->control_dev = &control_pdev->dev;
