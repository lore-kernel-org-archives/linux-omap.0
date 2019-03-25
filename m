From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v2 05/26] PCI: keystone: Use platform_get_resource_byname to get memory resources
Date: Mon, 25 Mar 2019 14:04:40 +0530
Message-ID: <20190325083501.8088-6-kishon@ti.com>
References: <20190325083501.8088-1-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190325083501.8088-1-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Gustavo Pimentel <gustavo.pimentel@synopsys.com>, Bjorn Helgaas <bhelgaas@google.com>, Rob Herring <robh+dt@kernel.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Arnd Bergmann <arnd@arndb.de>, Murali Karicheri <m-karicheri2@ti.com>
Cc: Kishon Vijay Abraham I <kishon@ti.com>, Jingoo Han <jingoohan1@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-arm-kernel@axis.com
List-Id: linux-omap@vger.kernel.org

Use platform_get_resource_byname() instead of platform_get_resource() which
uses index to get memory resources. While at that get the memory resource
defined specifically for configuration space instead of deriving the
configuration space address from dbics address space. Since pci-keystone
driver has never worked out of the box in mainline kernel, dt backward
compatibility is ignored.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/pci/controller/dwc/pci-keystone.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
index 566718ea7ebf..5eebef9b9ada 100644
--- a/drivers/pci/controller/dwc/pci-keystone.c
+++ b/drivers/pci/controller/dwc/pci-keystone.c
@@ -44,7 +44,6 @@
 #define CFG_TYPE1			BIT(24)
 
 #define OB_SIZE				0x030
-#define SPACE0_REMOTE_CFG_OFFSET	0x1000
 #define OB_OFFSET_INDEX(n)		(0x200 + (8 * (n)))
 #define OB_OFFSET_HI(n)			(0x204 + (8 * (n)))
 #define OB_ENABLEN			BIT(0)
@@ -807,21 +806,19 @@ static int __init ks_pcie_add_pcie_port(struct keystone_pcie *ks_pcie,
 	struct resource *res;
 	int ret;
 
-	/* Index 0 is the config reg. space address */
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "dbics");
 	pci->dbi_base = devm_pci_remap_cfg_resource(dev, res);
 	if (IS_ERR(pci->dbi_base))
 		return PTR_ERR(pci->dbi_base);
 
-	/*
-	 * We set these same and is used in pcie rd/wr_other_conf
-	 * functions
-	 */
-	pp->va_cfg0_base = pci->dbi_base + SPACE0_REMOTE_CFG_OFFSET;
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "config");
+	pp->va_cfg0_base = devm_pci_remap_cfg_resource(dev, res);
+	if (IS_ERR(pp->va_cfg0_base))
+		return PTR_ERR(pp->va_cfg0_base);
+
 	pp->va_cfg1_base = pp->va_cfg0_base;
 
-	/* Index 1 is the application reg. space address */
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "app");
 	ks_pcie->va_app_base = devm_ioremap_resource(dev, res);
 	if (IS_ERR(ks_pcie->va_app_base))
 		return PTR_ERR(ks_pcie->va_app_base);
-- 
2.17.1
