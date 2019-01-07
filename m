From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH 02/15] PCI: dwc: Add ->get_features() callback function in dw_pcie_ep_ops
Date: Mon, 7 Jan 2019 12:11:35 +0530
Message-ID: <20190107064148.10152-3-kishon@ti.com>
References: <20190107064148.10152-1-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190107064148.10152-1-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Bjorn Helgaas <bhelgaas@google.com>, Gustavo Pimentel <gustavo.pimentel@synopsys.com>, Alan Douglas <adouglas@cadence.com>, Shawn Lin <shawn.lin@rock-chips.com>
Cc: Jingoo Han <jingoohan1@gmail.com>, Heiko Stuebner <heiko@sntech.de>, Cyrille Pitchen <cyrille.pitchen@free-electrons.com>, Jia-Ju Bai <baijiaju1990@gmail.com>, linux-omap@vger.kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org, kishon@ti.com
List-Id: linux-omap@vger.kernel.org

Each platform using Designware PCIe core can support different set of
endpoint features. Add a new callback function ->get_features() in
dw_pcie_ep_ops so that each platform using Designware PCIe core can
advertise its supported features to the endpoint function driver.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/pci/controller/dwc/pcie-designware-ep.c | 12 ++++++++++++
 drivers/pci/controller/dwc/pcie-designware.h    |  1 +
 2 files changed, 13 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index a543c45c7224..7a2925a16ab8 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -355,6 +355,17 @@ static int dw_pcie_ep_start(struct pci_epc *epc)
 	return pci->ops->start_link(pci);
 }
 
+static const struct pci_epc_features*
+dw_pcie_ep_get_features(struct pci_epc *epc, u8 func_no)
+{
+	struct dw_pcie_ep *ep = epc_get_drvdata(epc);
+
+	if (!ep->ops->get_features)
+		return NULL;
+
+	return ep->ops->get_features(ep);
+}
+
 static const struct pci_epc_ops epc_ops = {
 	.write_header		= dw_pcie_ep_write_header,
 	.set_bar		= dw_pcie_ep_set_bar,
@@ -368,6 +379,7 @@ static const struct pci_epc_ops epc_ops = {
 	.raise_irq		= dw_pcie_ep_raise_irq,
 	.start			= dw_pcie_ep_start,
 	.stop			= dw_pcie_ep_stop,
+	.get_features		= dw_pcie_ep_get_features,
 };
 
 int dw_pcie_ep_raise_legacy_irq(struct dw_pcie_ep *ep, u8 func_no)
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 9943d8c68335..1f56e6ae34ff 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -192,6 +192,7 @@ struct dw_pcie_ep_ops {
 	void	(*ep_init)(struct dw_pcie_ep *ep);
 	int	(*raise_irq)(struct dw_pcie_ep *ep, u8 func_no,
 			     enum pci_epc_irq_type type, u16 interrupt_num);
+	const struct pci_epc_features* (*get_features)(struct dw_pcie_ep *ep);
 };
 
 struct dw_pcie_ep {
-- 
2.17.1
