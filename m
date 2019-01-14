From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v2 03/15] PCI: designware-plat: Populate ->get_features() dw_pcie_ep_ops
Date: Mon, 14 Jan 2019 16:45:01 +0530
Message-ID: <20190114111513.21618-4-kishon@ti.com>
References: <20190114111513.21618-1-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190114111513.21618-1-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Gustavo Pimentel <gustavo.pimentel@synopsys.com>, Alan Douglas <adouglas@cadence.com>, Shawn Lin <shawn.lin@rock-chips.com>, Heiko Stuebner <heiko@sntech.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>, linux-omap@vger.kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Populate ->get_features() dw_pcie_ep_ops to return the EPC features
supported by Designware PCIe endpoint controller.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/pci/controller/dwc/pcie-designware-plat.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware-plat.c b/drivers/pci/controller/dwc/pcie-designware-plat.c
index c12bf794d69c..bd0516afc86f 100644
--- a/drivers/pci/controller/dwc/pcie-designware-plat.c
+++ b/drivers/pci/controller/dwc/pcie-designware-plat.c
@@ -100,9 +100,22 @@ static int dw_plat_pcie_ep_raise_irq(struct dw_pcie_ep *ep, u8 func_no,
 	return 0;
 }
 
+static const struct pci_epc_features dw_plat_pcie_epc_features = {
+	.linkup_notifier = false,
+	.msi_capable = true,
+	.msix_capable = true,
+};
+
+static const struct pci_epc_features*
+dw_plat_pcie_get_features(struct dw_pcie_ep *ep)
+{
+	return &dw_plat_pcie_epc_features;
+}
+
 static struct dw_pcie_ep_ops pcie_ep_ops = {
 	.ep_init = dw_plat_pcie_ep_init,
 	.raise_irq = dw_plat_pcie_ep_raise_irq,
+	.get_features = dw_plat_pcie_get_features,
 };
 
 static int dw_plat_add_pcie_port(struct dw_plat_pcie *dw_plat_pcie,
-- 
2.17.1
