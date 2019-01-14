From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH 02/24] PCI: keystone: Cleanup error_irq configuration
Date: Mon, 14 Jan 2019 18:54:02 +0530
Message-ID: <20190114132424.6445-3-kishon@ti.com>
References: <20190114132424.6445-1-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190114132424.6445-1-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Gustavo Pimentel <gustavo.pimentel@synopsys.com>, Rob Herring <robh+dt@kernel.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Kishon Vijay Abraham I <kishon@ti.com>, Jingoo Han <jingoohan1@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>, Mark Rutland <mark.rutland@arm.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Murali Karicheri <m-karicheri2@ti.com>, Jesper Nilsson <jesper.nilsson@axis.com>, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-arm-kernel@axis.com
List-Id: linux-omap@vger.kernel.org

pci-keystone driver uses irq_of_parse_and_map to get irq number of
error_irq. Use platform_get_irq instead and move platform_get_irq()
and request_irq() of error_irq from ks_pcie_add_pcie_port to ks_pcie_probe
since error_irq is common to both RC mode and EP mode.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/pci/controller/dwc/pci-keystone.c | 43 +++++++++--------------
 1 file changed, 17 insertions(+), 26 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
index 24c38ae570b5..f63268aee2de 100644
--- a/drivers/pci/controller/dwc/pci-keystone.c
+++ b/drivers/pci/controller/dwc/pci-keystone.c
@@ -97,8 +97,6 @@ struct keystone_pcie {
 	struct irq_domain	*legacy_irq_domain;
 	struct device_node	*np;
 
-	int error_irq;
-
 	/* Application register space */
 	void __iomem		*va_app_base;	/* DT 1st resource */
 	struct resource		app;
@@ -726,12 +724,6 @@ static int ks_pcie_config_legacy_irq(struct keystone_pcie *ks_pcie)
 	return ret;
 }
 
-static void ks_pcie_setup_interrupts(struct keystone_pcie *ks_pcie)
-{
-	if (ks_pcie->error_irq > 0)
-		ks_pcie_enable_error_irq(ks_pcie);
-}
-
 /*
  * When a PCI device does not exist during config cycles, keystone host gets a
  * bus error instead of returning 0xffffffff. This handler always returns 0
@@ -793,7 +785,6 @@ static int __init ks_pcie_host_init(struct pcie_port *pp)
 
 	ks_pcie_stop_link(pci);
 	ks_pcie_setup_rc_app_regs(ks_pcie);
-	ks_pcie_setup_interrupts(ks_pcie);
 	writew(PCI_IO_RANGE_TYPE_32 | (PCI_IO_RANGE_TYPE_32 << 8),
 			pci->dbi_base + PCI_IO_BASE);
 
@@ -837,23 +828,6 @@ static int __init ks_pcie_add_pcie_port(struct keystone_pcie *ks_pcie,
 	struct device *dev = &pdev->dev;
 	int ret;
 
-	/*
-	 * Index 0 is the platform interrupt for error interrupt
-	 * from RC.  This is optional.
-	 */
-	ks_pcie->error_irq = irq_of_parse_and_map(ks_pcie->np, 0);
-	if (ks_pcie->error_irq <= 0)
-		dev_info(dev, "no error IRQ defined\n");
-	else {
-		ret = request_irq(ks_pcie->error_irq, ks_pcie_err_irq_handler,
-				  IRQF_SHARED, "pcie-error-irq", ks_pcie);
-		if (ret < 0) {
-			dev_err(dev, "failed to request error IRQ %d\n",
-				ks_pcie->error_irq);
-			return ret;
-		}
-	}
-
 	pp->ops = &ks_pcie_host_ops;
 	ret = ks_pcie_dw_host_init(ks_pcie);
 	if (ret) {
@@ -929,6 +903,7 @@ static int __init ks_pcie_probe(struct platform_device *pdev)
 	u32 num_lanes;
 	char name[10];
 	int ret;
+	int irq;
 	int i;
 
 	ks_pcie = devm_kzalloc(dev, sizeof(*ks_pcie), GFP_KERNEL);
@@ -948,6 +923,20 @@ static int __init ks_pcie_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0) {
+		dev_err(dev, "missing IRQ resource: %d\n", irq);
+		return irq;
+	}
+
+	ret = request_irq(irq, ks_pcie_err_irq_handler, IRQF_SHARED,
+			  "ks-pcie-error-irq", ks_pcie);
+	if (ret < 0) {
+		dev_err(dev, "failed to request error IRQ %d\n",
+			irq);
+		return ret;
+	}
+
 	ret = of_property_read_u32(np, "num-lanes", &num_lanes);
 	if (ret)
 		num_lanes = 1;
@@ -1003,6 +992,8 @@ static int __init ks_pcie_probe(struct platform_device *pdev)
 	if (ret < 0)
 		goto err_get_sync;
 
+	ks_pcie_enable_error_irq(ks_pcie);
+
 	return 0;
 
 err_get_sync:
-- 
2.17.1
