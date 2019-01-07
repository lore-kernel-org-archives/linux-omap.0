From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH 04/15] PCI: pci-dra7xx: Populate ->get_features() dw_pcie_ep_ops
Date: Mon, 7 Jan 2019 12:11:37 +0530
Message-ID: <20190107064148.10152-5-kishon@ti.com>
References: <20190107064148.10152-1-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190107064148.10152-1-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Bjorn Helgaas <bhelgaas@google.com>, Gustavo Pimentel <gustavo.pimentel@synopsys.com>, Alan Douglas <adouglas@cadence.com>, Shawn Lin <shawn.lin@rock-chips.com>
Cc: Jingoo Han <jingoohan1@gmail.com>, Heiko Stuebner <heiko@sntech.de>, Cyrille Pitchen <cyrille.pitchen@free-electrons.com>, Jia-Ju Bai <baijiaju1990@gmail.com>, linux-omap@vger.kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org, kishon@ti.com
List-Id: linux-omap@vger.kernel.org

Populate ->get_features() dw_pcie_ep_ops to return the EPC features
supported by DRA7xx PCIe endpoint controller.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/pci/controller/dwc/pci-dra7xx.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/pci/controller/dwc/pci-dra7xx.c b/drivers/pci/controller/dwc/pci-dra7xx.c
index a32d6dde7a57..15620cfa617b 100644
--- a/drivers/pci/controller/dwc/pci-dra7xx.c
+++ b/drivers/pci/controller/dwc/pci-dra7xx.c
@@ -389,9 +389,22 @@ static int dra7xx_pcie_raise_irq(struct dw_pcie_ep *ep, u8 func_no,
 	return 0;
 }
 
+static const struct pci_epc_features dra7xx_pcie_epc_features = {
+	.linkup_notifier = true,
+	.msi_capable = true,
+	.msix_capable = false,
+};
+
+static const struct pci_epc_features*
+dra7xx_pcie_get_features(struct dw_pcie_ep *ep)
+{
+	return &dra7xx_pcie_epc_features;
+}
+
 static struct dw_pcie_ep_ops pcie_ep_ops = {
 	.ep_init = dra7xx_pcie_ep_init,
 	.raise_irq = dra7xx_pcie_raise_irq,
+	.get_features = dra7xx_pcie_get_features,
 };
 
 static int __init dra7xx_add_pcie_ep(struct dra7xx_pcie *dra7xx,
-- 
2.17.1
