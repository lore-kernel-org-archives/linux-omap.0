From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v2 08/26] PCI: keystone: Explicitly set the PCIe mode
Date: Mon, 25 Mar 2019 14:04:43 +0530
Message-ID: <20190325083501.8088-9-kishon@ti.com>
References: <20190325083501.8088-1-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190325083501.8088-1-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Gustavo Pimentel <gustavo.pimentel@synopsys.com>, Bjorn Helgaas <bhelgaas@google.com>, Rob Herring <robh+dt@kernel.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Arnd Bergmann <arnd@arndb.de>, Murali Karicheri <m-karicheri2@ti.com>
Cc: Kishon Vijay Abraham I <kishon@ti.com>, Jingoo Han <jingoohan1@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-arm-kernel@axis.com
List-Id: linux-omap@vger.kernel.org

Explicitly set the PCIe mode to BOOTCFG_DEVCFG instead of always
relying on the default values. This is required when EP mode has to
be explicitly written to BOOTCFG_DEVCFG register.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/pci/controller/dwc/pci-keystone.c | 37 +++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
index 95997885a05c..dfe54553d832 100644
--- a/drivers/pci/controller/dwc/pci-keystone.c
+++ b/drivers/pci/controller/dwc/pci-keystone.c
@@ -79,6 +79,15 @@
 #define PCIE_RC_K2L			0xb00a
 #define PCIE_RC_K2G			0xb00b
 
+#define KS_PCIE_DEV_TYPE_MASK		(0x3 << 1)
+#define KS_PCIE_DEV_TYPE(mode)		((mode) << 1)
+
+#define EP				0x0
+#define LEG_EP				0x1
+#define RC				0x2
+
+#define KS_PCIE_SYSCLOCKOUTEN		BIT(0)
+
 #define to_keystone_pcie(x)		dev_get_drvdata((x)->dev)
 
 struct keystone_pcie {
@@ -876,6 +885,30 @@ static int ks_pcie_enable_phy(struct keystone_pcie *ks_pcie)
 	return ret;
 }
 
+static int ks_pcie_set_mode(struct device *dev)
+{
+	struct device_node *np = dev->of_node;
+	struct regmap *syscon;
+	u32 val;
+	u32 mask;
+	int ret = 0;
+
+	syscon = syscon_regmap_lookup_by_phandle(np, "ti,syscon-pcie-mode");
+	if (IS_ERR(syscon))
+		return 0;
+
+	mask = KS_PCIE_DEV_TYPE_MASK | KS_PCIE_SYSCLOCKOUTEN;
+	val = KS_PCIE_DEV_TYPE(RC) | KS_PCIE_SYSCLOCKOUTEN;
+
+	ret = regmap_update_bits(syscon, 0, mask, val);
+	if (ret) {
+		dev_err(dev, "failed to set pcie mode\n");
+		return ret;
+	}
+
+	return 0;
+}
+
 static int __init ks_pcie_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -988,6 +1021,10 @@ static int __init ks_pcie_probe(struct platform_device *pdev)
 		goto err_get_sync;
 	}
 
+	ret = ks_pcie_set_mode(dev);
+	if (ret < 0)
+		goto err_get_sync;
+
 	ret = ks_pcie_add_pcie_port(ks_pcie, pdev);
 	if (ret < 0)
 		goto err_get_sync;
-- 
2.17.1
