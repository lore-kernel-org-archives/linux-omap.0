From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v3 3/3] PCI: dra7xx: Enable x2 mode support for dra74x, dra76x and dra72x
Date: Thu, 24 Jan 2019 13:59:57 +0530
Message-ID: <20190124082957.29077-4-kishon@ti.com>
References: <20190124082957.29077-1-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190124082957.29077-1-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Rob Herring <robh+dt@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Mark Rutland <mark.rutland@arm.com>, linux-omap@vger.kernel.org, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

dra74x/dra76x and dra72x have separate compatible strings. Add support
for these compatible strings in pci-dra7xx driver to perform syscon
configurations required to get x2 mode working.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/pci/controller/dwc/pci-dra7xx.c | 77 +++++++++++++++++++++++++
 1 file changed, 77 insertions(+)

diff --git a/drivers/pci/controller/dwc/pci-dra7xx.c b/drivers/pci/controller/dwc/pci-dra7xx.c
index b4fbb4be212f..efb26096ccb5 100644
--- a/drivers/pci/controller/dwc/pci-dra7xx.c
+++ b/drivers/pci/controller/dwc/pci-dra7xx.c
@@ -81,6 +81,10 @@
 #define MSI_REQ_GRANT					BIT(0)
 #define MSI_VECTOR_SHIFT				7
 
+#define PCIE_1LANE_2LANE_SELECTION			BIT(13)
+#define PCIE_B1C0_MODE_SEL				BIT(2)
+#define PCIE_B0_B1_TSYNCEN				BIT(0)
+
 struct dra7xx_pcie {
 	struct dw_pcie		*pci;
 	void __iomem		*base;		/* DT ti_conf */
@@ -93,6 +97,7 @@ struct dra7xx_pcie {
 
 struct dra7xx_pcie_of_data {
 	enum dw_pcie_device_mode mode;
+	u32 b1co_mode_sel_mask;
 };
 
 #define to_dra7xx_pcie(x)	dev_get_drvdata((x)->dev)
@@ -542,6 +547,26 @@ static const struct dra7xx_pcie_of_data dra7xx_pcie_ep_of_data = {
 	.mode = DW_PCIE_EP_TYPE,
 };
 
+static const struct dra7xx_pcie_of_data dra746_pcie_rc_of_data = {
+	.b1co_mode_sel_mask = BIT(2),
+	.mode = DW_PCIE_RC_TYPE,
+};
+
+static const struct dra7xx_pcie_of_data dra726_pcie_rc_of_data = {
+	.b1co_mode_sel_mask = GENMASK(3, 2),
+	.mode = DW_PCIE_RC_TYPE,
+};
+
+static const struct dra7xx_pcie_of_data dra746_pcie_ep_of_data = {
+	.b1co_mode_sel_mask = BIT(2),
+	.mode = DW_PCIE_EP_TYPE,
+};
+
+static const struct dra7xx_pcie_of_data dra726_pcie_ep_of_data = {
+	.b1co_mode_sel_mask = GENMASK(3, 2),
+	.mode = DW_PCIE_EP_TYPE,
+};
+
 static const struct of_device_id of_dra7xx_pcie_match[] = {
 	{
 		.compatible = "ti,dra7-pcie",
@@ -551,6 +576,22 @@ static const struct of_device_id of_dra7xx_pcie_match[] = {
 		.compatible = "ti,dra7-pcie-ep",
 		.data = &dra7xx_pcie_ep_of_data,
 	},
+	{
+		.compatible = "ti,dra746-pcie-rc",
+		.data = &dra746_pcie_rc_of_data,
+	},
+	{
+		.compatible = "ti,dra726-pcie-rc",
+		.data = &dra726_pcie_rc_of_data,
+	},
+	{
+		.compatible = "ti,dra746-pcie-ep",
+		.data = &dra746_pcie_ep_of_data,
+	},
+	{
+		.compatible = "ti,dra726-pcie-ep",
+		.data = &dra726_pcie_ep_of_data,
+	},
 	{},
 };
 
@@ -596,6 +637,34 @@ static int dra7xx_pcie_unaligned_memaccess(struct device *dev)
 	return ret;
 }
 
+static int dra7xx_pcie_configure_two_lane(struct device *dev,
+					  u32 b1co_mode_sel_mask)
+{
+	struct device_node *np = dev->of_node;
+	struct regmap *pcie_syscon;
+	unsigned int pcie_reg;
+	u32 mask;
+	u32 val;
+
+	pcie_syscon = syscon_regmap_lookup_by_phandle(np, "ti,syscon-lane-sel");
+	if (IS_ERR(pcie_syscon)) {
+		dev_err(dev, "unable to get ti,syscon-lane-sel\n");
+		return -EINVAL;
+	}
+
+	if (of_property_read_u32_index(np, "ti,syscon-lane-sel", 1,
+				       &pcie_reg)) {
+		dev_err(dev, "couldn't get lane selection reg offset\n");
+		return -EINVAL;
+	}
+
+	mask = b1co_mode_sel_mask | PCIE_B0_B1_TSYNCEN;
+	val = PCIE_B1C0_MODE_SEL | PCIE_B0_B1_TSYNCEN;
+	regmap_update_bits(pcie_syscon, pcie_reg, mask, val);
+
+	return 0;
+}
+
 static int __init dra7xx_pcie_probe(struct platform_device *pdev)
 {
 	u32 reg;
@@ -616,6 +685,7 @@ static int __init dra7xx_pcie_probe(struct platform_device *pdev)
 	const struct of_device_id *match;
 	const struct dra7xx_pcie_of_data *data;
 	enum dw_pcie_device_mode mode;
+	u32 b1co_mode_sel_mask;
 
 	match = of_match_device(of_match_ptr(of_dra7xx_pcie_match), dev);
 	if (!match)
@@ -623,6 +693,7 @@ static int __init dra7xx_pcie_probe(struct platform_device *pdev)
 
 	data = (struct dra7xx_pcie_of_data *)match->data;
 	mode = (enum dw_pcie_device_mode)data->mode;
+	b1co_mode_sel_mask = data->b1co_mode_sel_mask;
 
 	dra7xx = devm_kzalloc(dev, sizeof(*dra7xx), GFP_KERNEL);
 	if (!dra7xx)
@@ -678,6 +749,12 @@ static int __init dra7xx_pcie_probe(struct platform_device *pdev)
 	dra7xx->pci = pci;
 	dra7xx->phy_count = phy_count;
 
+	if (phy_count == 2) {
+		ret = dra7xx_pcie_configure_two_lane(dev, b1co_mode_sel_mask);
+		if (ret < 0)
+			dra7xx->phy_count = 1; /* Fallback to x1 lane mode */
+	}
+
 	ret = dra7xx_pcie_enable_phy(dra7xx);
 	if (ret) {
 		dev_err(dev, "failed to enable phy\n");
-- 
2.17.1
