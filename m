From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH 06/24] PCI: keystone: Move initializations to appropriate places
Date: Mon, 14 Jan 2019 18:54:06 +0530
Message-ID: <20190114132424.6445-7-kishon@ti.com>
References: <20190114132424.6445-1-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190114132424.6445-1-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Gustavo Pimentel <gustavo.pimentel@synopsys.com>, Rob Herring <robh+dt@kernel.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Kishon Vijay Abraham I <kishon@ti.com>, Jingoo Han <jingoohan1@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>, Mark Rutland <mark.rutland@arm.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Murali Karicheri <m-karicheri2@ti.com>, Jesper Nilsson <jesper.nilsson@axis.com>, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-arm-kernel@axis.com
List-Id: linux-omap@vger.kernel.org

No functional change. Move host specific platform_get_resource to
ks_add_pcie_port and the common platform_get_resource (applicable
to both host and endpoint) to probe. This is in preparation for
adding endpoint support to pci-keystone driver.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/pci/controller/dwc/pci-keystone.c | 27 +++++++++++++----------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
index 88766d4cb50c..ce2f5c25f7a3 100644
--- a/drivers/pci/controller/dwc/pci-keystone.c
+++ b/drivers/pci/controller/dwc/pci-keystone.c
@@ -789,11 +789,6 @@ static int __init ks_pcie_add_pcie_port(struct keystone_pcie *ks_pcie,
 	struct resource *res;
 	int ret;
 
-	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "dbics");
-	pci->dbi_base = devm_pci_remap_cfg_resource(dev, res);
-	if (IS_ERR(pci->dbi_base))
-		return PTR_ERR(pci->dbi_base);
-
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "config");
 	pp->va_cfg0_base = devm_pci_remap_cfg_resource(dev, res);
 	if (IS_ERR(pp->va_cfg0_base))
@@ -801,13 +796,6 @@ static int __init ks_pcie_add_pcie_port(struct keystone_pcie *ks_pcie,
 
 	pp->va_cfg1_base = pp->va_cfg0_base;
 
-	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "app");
-	ks_pcie->va_app_base = devm_ioremap_resource(dev, res);
-	if (IS_ERR(ks_pcie->va_app_base))
-		return PTR_ERR(ks_pcie->va_app_base);
-
-	ks_pcie->app = *res;
-
 	pp->ops = &ks_pcie_host_ops;
 	ret = dw_pcie_host_init(pp);
 	if (ret) {
@@ -878,6 +866,8 @@ static int __init ks_pcie_probe(struct platform_device *pdev)
 	struct dw_pcie *pci;
 	struct keystone_pcie *ks_pcie;
 	struct device_link **link;
+	struct resource *res;
+	void __iomem *base;
 	u32 num_viewport;
 	struct phy **phy;
 	u32 num_lanes;
@@ -894,6 +884,19 @@ static int __init ks_pcie_probe(struct platform_device *pdev)
 	if (!pci)
 		return -ENOMEM;
 
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "app");
+	ks_pcie->va_app_base = devm_ioremap_resource(dev, res);
+	if (IS_ERR(ks_pcie->va_app_base))
+		return PTR_ERR(ks_pcie->va_app_base);
+
+	ks_pcie->app = *res;
+
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "dbics");
+	base = devm_pci_remap_cfg_resource(dev, res);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
+
+	pci->dbi_base = base;
 	pci->dev = dev;
 	pci->ops = &ks_pcie_dw_pcie_ops;
 
-- 
2.17.1
