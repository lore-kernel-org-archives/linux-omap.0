From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH 02/17] phy: ti-pipe3: use *syscon* framework to power on/off
 the PHY
Date: Tue, 23 Jun 2015 17:28:47 +0530
Message-ID: <1435060743-5511-3-git-send-email-kishon@ti.com>
References: <1435060743-5511-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1435060743-5511-1-git-send-email-kishon@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: bcousson@baylibre.com, tony@atomide.com, balbi@ti.com, rogerq@ti.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org, kishon@ti.com
Cc: mark.rutland@arm.com, linux@arm.linux.org.uk, pawel.moll@arm.com, ijc+devicetree@hellion.org.uk, gregkh@linuxfoundation.org, nsekhar@ti.com, robh+dt@kernel.org, galak@codeaurora.org
List-Id: linux-omap@vger.kernel.org

Deprecate using phy-omap-control driver to power on/off the PHY and
use *syscon* framework to do the same.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 Documentation/devicetree/bindings/phy/ti-phy.txt |   10 ++-
 drivers/phy/phy-ti-pipe3.c                       |   91 ++++++++++++++++++----
 2 files changed, 86 insertions(+), 15 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/ti-phy.txt b/Documentation/devicetree/bindings/phy/ti-phy.txt
index f0f5537..d3ad3bf 100644
--- a/Documentation/devicetree/bindings/phy/ti-phy.txt
+++ b/Documentation/devicetree/bindings/phy/ti-phy.txt
@@ -77,8 +77,6 @@ Required properties:
    * "div-clk" - apll clock
 
 Optional properties:
- - ctrl-module : phandle of the control module used by PHY driver to power on
-   the PHY.
  - id: If there are multiple instance of the same type, in order to
    differentiate between each instance "id" can be used (e.g., multi-lane PCIe
    PHY). If "id" is not provided, it is set to default value of '1'.
@@ -86,6 +84,14 @@ Optional properties:
    CTRL_CORE_SMA_SW_0 register and register offset to the CTRL_CORE_SMA_SW_0
    register that contains the SATA_PLL_SOFT_RESET bit. Only valid for sata_phy.
 
+Deprecated properties:
+ - ctrl-module : phandle of the control module used by PHY driver to power on
+   the PHY.
+
+Recommended properies:
+ - syscon-phy-power : phandle/offset pair. Phandle to the system control
+   module and the register offset to power on/off the PHY.
+
 This is usually a subnode of ocp2scp to which it is connected.
 
 usb3phy@4a084400 {
diff --git a/drivers/phy/phy-ti-pipe3.c b/drivers/phy/phy-ti-pipe3.c
index d784426..78bac00 100644
--- a/drivers/phy/phy-ti-pipe3.c
+++ b/drivers/phy/phy-ti-pipe3.c
@@ -56,6 +56,15 @@
 
 #define SATA_PLL_SOFT_RESET	BIT(18)
 
+#define PIPE3_PHY_PWRCTL_CLK_CMD_MASK	0x003FC000
+#define PIPE3_PHY_PWRCTL_CLK_CMD_SHIFT	14
+
+#define PIPE3_PHY_PWRCTL_CLK_FREQ_MASK	0xFFC00000
+#define PIPE3_PHY_PWRCTL_CLK_FREQ_SHIFT	22
+
+#define PIPE3_PHY_TX_RX_POWERON		0x3
+#define PIPE3_PHY_TX_RX_POWEROFF	0x0
+
 /*
  * This is an Empirical value that works, need to confirm the actual
  * value required for the PIPE3PHY_PLL_CONFIGURATION2.PLL_IDLE status
@@ -86,8 +95,10 @@ struct ti_pipe3 {
 	struct clk		*refclk;
 	struct clk		*div_clk;
 	struct pipe3_dpll_map	*dpll_map;
+	struct regmap		*phy_power_syscon; /* ctrl. reg. acces */
 	struct regmap		*dpll_reset_syscon; /* ctrl. reg. acces */
 	unsigned int		dpll_reset_reg; /* reg. index within syscon */
+	unsigned int		power_reg; /* power reg. index within syscon */
 	bool			sata_refclk_enabled;
 };
 
@@ -144,18 +155,49 @@ static void ti_pipe3_disable_clocks(struct ti_pipe3 *phy);
 
 static int ti_pipe3_power_off(struct phy *x)
 {
+	u32 val;
+	int ret;
 	struct ti_pipe3 *phy = phy_get_drvdata(x);
 
-	omap_control_phy_power(phy->control_dev, 0);
+	if (phy->phy_power_syscon) {
+		val = PIPE3_PHY_TX_RX_POWEROFF <<
+			PIPE3_PHY_PWRCTL_CLK_CMD_SHIFT;
+
+		ret = regmap_update_bits(phy->phy_power_syscon, phy->power_reg,
+					 PIPE3_PHY_PWRCTL_CLK_CMD_MASK, val);
+		if (ret < 0)
+			return ret;
+	} else {
+		omap_control_phy_power(phy->control_dev, 0);
+	}
 
 	return 0;
 }
 
 static int ti_pipe3_power_on(struct phy *x)
 {
+	u32 val;
+	u32 mask;
+	int ret;
+	unsigned long rate;
 	struct ti_pipe3 *phy = phy_get_drvdata(x);
 
-	omap_control_phy_power(phy->control_dev, 1);
+	if (phy->phy_power_syscon) {
+		rate = clk_get_rate(phy->sys_clk);
+		rate = rate / 1000000;
+		mask = OMAP_CTRL_PIPE3_PHY_PWRCTL_CLK_CMD_MASK |
+			  OMAP_CTRL_PIPE3_PHY_PWRCTL_CLK_FREQ_MASK;
+		val = PIPE3_PHY_TX_RX_POWERON <<
+			PIPE3_PHY_PWRCTL_CLK_CMD_SHIFT;
+		val |= rate << OMAP_CTRL_PIPE3_PHY_PWRCTL_CLK_FREQ_SHIFT;
+
+		ret = regmap_update_bits(phy->phy_power_syscon, phy->power_reg,
+					 mask, val);
+		if (ret < 0)
+			return ret;
+	} else {
+		omap_control_phy_power(phy->control_dev, 1);
+	}
 
 	return 0;
 }
@@ -417,19 +459,42 @@ static int ti_pipe3_probe(struct platform_device *pdev)
 		phy->div_clk = ERR_PTR(-ENODEV);
 	}
 
-	control_node = of_parse_phandle(node, "ctrl-module", 0);
-	if (!control_node) {
-		dev_err(&pdev->dev, "Failed to get control device phandle\n");
-		return -EINVAL;
-	}
+	phy->phy_power_syscon = syscon_regmap_lookup_by_phandle(node,
+							"syscon-phy-power");
+	if (IS_ERR(phy->phy_power_syscon)) {
+		dev_info(&pdev->dev,
+			 "can't get syscon-phy-power, using control device\n");
+		phy->phy_power_syscon = NULL;
+
+		control_node = of_parse_phandle(node, "ctrl-module", 0);
+		if (!control_node) {
+			dev_err(&pdev->dev,
+				"Failed to get control device phandle\n");
+			return -EINVAL;
+		}
 
-	control_pdev = of_find_device_by_node(control_node);
-	if (!control_pdev) {
-		dev_err(&pdev->dev, "Failed to get control device\n");
-		return -EINVAL;
-	}
+		control_pdev = of_find_device_by_node(control_node);
+		if (!control_pdev) {
+			dev_err(&pdev->dev, "Failed to get control device\n");
+			return -EINVAL;
+		}
 
-	phy->control_dev = &control_pdev->dev;
+		phy->control_dev = &control_pdev->dev;
+	} else {
+		phy->sys_clk = devm_clk_get(phy->dev, "sysclk");
+		if (IS_ERR(phy->sys_clk)) {
+			dev_err(&pdev->dev, "unable to get sysclk\n");
+			return -EINVAL;
+		}
+
+		if (of_property_read_u32_index(node,
+					       "syscon-phy-power", 1,
+					       &phy->power_reg)) {
+			dev_err(&pdev->dev,
+				"couldn't get power reg. offset\n");
+			return -EINVAL;
+		}
+	}
 
 	platform_set_drvdata(pdev, phy);
 	pm_runtime_enable(phy->dev);
-- 
1.7.9.5
