From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v2 01/26] PCI: keystone: Add start_link/stop_link dw_pcie_ops
Date: Mon, 25 Mar 2019 14:04:36 +0530
Message-ID: <20190325083501.8088-2-kishon@ti.com>
References: <20190325083501.8088-1-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190325083501.8088-1-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Gustavo Pimentel <gustavo.pimentel@synopsys.com>, Bjorn Helgaas <bhelgaas@google.com>, Rob Herring <robh+dt@kernel.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Arnd Bergmann <arnd@arndb.de>, Murali Karicheri <m-karicheri2@ti.com>
Cc: Kishon Vijay Abraham I <kishon@ti.com>, Jingoo Han <jingoohan1@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-arm-kernel@axis.com
List-Id: linux-omap@vger.kernel.org

Add start_link/stop_link dw_pcie_ops and invoke ks_pcie_start_link
directly from host_init. start_link/stop_link ops is required for
adding EP mode support.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/pci/controller/dwc/pci-keystone.c | 44 +++++++++++------------
 1 file changed, 22 insertions(+), 22 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
index b757692e2848..07f55b355d75 100644
--- a/drivers/pci/controller/dwc/pci-keystone.c
+++ b/drivers/pci/controller/dwc/pci-keystone.c
@@ -460,18 +460,33 @@ static int ks_pcie_link_up(struct dw_pcie *pci)
 	return (val == PORT_LOGIC_LTSSM_STATE_L0);
 }
 
-static void ks_pcie_initiate_link_train(struct keystone_pcie *ks_pcie)
+static void ks_pcie_stop_link(struct dw_pcie *pci)
 {
+	struct keystone_pcie *ks_pcie = to_keystone_pcie(pci);
 	u32 val;
 
 	/* Disable Link training */
 	val = ks_pcie_app_readl(ks_pcie, CMD_STATUS);
 	val &= ~LTSSM_EN_VAL;
 	ks_pcie_app_writel(ks_pcie, CMD_STATUS, LTSSM_EN_VAL | val);
+}
+
+static int ks_pcie_start_link(struct dw_pcie *pci)
+{
+	struct keystone_pcie *ks_pcie = to_keystone_pcie(pci);
+	struct device *dev = pci->dev;
+	u32 val;
+
+	if (dw_pcie_link_up(pci)) {
+		dev_dbg(dev, "link is already up\n");
+		return 0;
+	}
 
 	/* Initiate Link Training */
 	val = ks_pcie_app_readl(ks_pcie, CMD_STATUS);
 	ks_pcie_app_writel(ks_pcie, CMD_STATUS, LTSSM_EN_VAL | val);
+
+	return 0;
 }
 
 /**
@@ -556,26 +571,6 @@ static void ks_pcie_quirk(struct pci_dev *dev)
 }
 DECLARE_PCI_FIXUP_ENABLE(PCI_ANY_ID, PCI_ANY_ID, ks_pcie_quirk);
 
-static int ks_pcie_establish_link(struct keystone_pcie *ks_pcie)
-{
-	struct dw_pcie *pci = ks_pcie->pci;
-	struct device *dev = pci->dev;
-
-	if (dw_pcie_link_up(pci)) {
-		dev_info(dev, "Link already up\n");
-		return 0;
-	}
-
-	ks_pcie_initiate_link_train(ks_pcie);
-
-	/* check if the link is up or not */
-	if (!dw_pcie_wait_for_link(pci))
-		return 0;
-
-	dev_err(dev, "phy link never came up\n");
-	return -ETIMEDOUT;
-}
-
 static void ks_pcie_msi_irq_handler(struct irq_desc *desc)
 {
 	unsigned int irq = desc->irq_data.hwirq;
@@ -813,7 +808,7 @@ static int __init ks_pcie_host_init(struct pcie_port *pp)
 
 	dw_pcie_setup_rc(pp);
 
-	ks_pcie_establish_link(ks_pcie);
+	ks_pcie_stop_link(pci);
 	ks_pcie_setup_rc_app_regs(ks_pcie);
 	ks_pcie_setup_interrupts(ks_pcie);
 	writew(PCI_IO_RANGE_TYPE_32 | (PCI_IO_RANGE_TYPE_32 << 8),
@@ -830,6 +825,9 @@ static int __init ks_pcie_host_init(struct pcie_port *pp)
 	hook_fault_code(17, ks_pcie_fault, SIGBUS, 0,
 			"Asynchronous external abort");
 
+	ks_pcie_start_link(pci);
+	dw_pcie_wait_for_link(pci);
+
 	return 0;
 }
 
@@ -892,6 +890,8 @@ static const struct of_device_id ks_pcie_of_match[] = {
 };
 
 static const struct dw_pcie_ops ks_pcie_dw_pcie_ops = {
+	.start_link = ks_pcie_start_link,
+	.stop_link = ks_pcie_stop_link,
 	.link_up = ks_pcie_link_up,
 };
 
-- 
2.17.1
