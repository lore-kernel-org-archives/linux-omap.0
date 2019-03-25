From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v3 10/26] PCI: dwc: Enable iATU unroll for endpoint too
Date: Mon, 25 Mar 2019 15:09:31 +0530
Message-ID: <20190325093947.32633-11-kishon@ti.com>
References: <20190325093947.32633-1-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190325093947.32633-1-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Gustavo Pimentel <gustavo.pimentel@synopsys.com>, Bjorn Helgaas <bhelgaas@google.com>, Rob Herring <robh+dt@kernel.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Arnd Bergmann <arnd@arndb.de>, Murali Karicheri <m-karicheri2@ti.com>
Cc: Kishon Vijay Abraham I <kishon@ti.com>, Jingoo Han <jingoohan1@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-arm-kernel@axis.com, Minghuan Lian <minghuan.Lian@nxp.com>, Mingkai Hu <mingkai.hu@nxp.com>, Roy Zang <roy.zang@nxp.com>, Jesper Nilsson <jesper.nilsson@axis.com>
List-Id: linux-omap@vger.kernel.org

iatu_unroll_enabled flag is set only for Designware in host mode.
However iATU unroll can be applicable for endpoint mode too. Set
iatu_unroll_enabled flag in dw_pcie_setup which is common for
both host mode and endpoint mode.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 .../pci/controller/dwc/pcie-designware-ep.c   |  4 ----
 .../pci/controller/dwc/pcie-designware-host.c | 19 -------------------
 drivers/pci/controller/dwc/pcie-designware.c  | 19 +++++++++++++++++++
 3 files changed, 19 insertions(+), 23 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index 24f5a775ad34..dc6a4bbd3ace 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -517,10 +517,6 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
 		dev_err(dev, "dbi_base/dbi_base2 is not populated\n");
 		return -EINVAL;
 	}
-	if (pci->iatu_unroll_enabled && !pci->atu_base) {
-		dev_err(dev, "atu_base is not populated\n");
-		return -EINVAL;
-	}
 
 	ret = of_property_read_u32(np, "num-ib-windows", &ep->num_ib_windows);
 	if (ret < 0) {
diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 7e0ff7d428a9..7bf6558341b6 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -608,17 +608,6 @@ static struct pci_ops dw_pcie_ops = {
 	.write = dw_pcie_wr_conf,
 };
 
-static u8 dw_pcie_iatu_unroll_enabled(struct dw_pcie *pci)
-{
-	u32 val;
-
-	val = dw_pcie_readl_dbi(pci, PCIE_ATU_VIEWPORT);
-	if (val == 0xffffffff)
-		return 1;
-
-	return 0;
-}
-
 void dw_pcie_setup_rc(struct pcie_port *pp)
 {
 	u32 val, ctrl, num_ctrls;
@@ -672,14 +661,6 @@ void dw_pcie_setup_rc(struct pcie_port *pp)
 	 * we should not program the ATU here.
 	 */
 	if (!pp->ops->rd_other_conf) {
-		/* Get iATU unroll support */
-		pci->iatu_unroll_enabled = dw_pcie_iatu_unroll_enabled(pci);
-		dev_dbg(pci->dev, "iATU unroll: %s\n",
-			pci->iatu_unroll_enabled ? "enabled" : "disabled");
-
-		if (pci->iatu_unroll_enabled && !pci->atu_base)
-			pci->atu_base = pci->dbi_base + DEFAULT_DBI_ATU_OFFSET;
-
 		dw_pcie_prog_outbound_atu(pci, PCIE_ATU_REGION_INDEX0,
 					  PCIE_ATU_TYPE_MEM, pp->mem_base,
 					  pp->mem_bus_addr, pp->mem_size);
diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index 31f6331ca46f..a14ca00f72aa 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -339,6 +339,17 @@ int dw_pcie_link_up(struct dw_pcie *pci)
 		(!(val & PCIE_PHY_DEBUG_R1_LINK_IN_TRAINING)));
 }
 
+static u8 dw_pcie_iatu_unroll_enabled(struct dw_pcie *pci)
+{
+	u32 val;
+
+	val = dw_pcie_readl_dbi(pci, PCIE_ATU_VIEWPORT);
+	if (val == 0xffffffff)
+		return 1;
+
+	return 0;
+}
+
 void dw_pcie_setup(struct dw_pcie *pci)
 {
 	int ret;
@@ -347,6 +358,14 @@ void dw_pcie_setup(struct dw_pcie *pci)
 	struct device *dev = pci->dev;
 	struct device_node *np = dev->of_node;
 
+	/* Get iATU unroll support */
+	pci->iatu_unroll_enabled = dw_pcie_iatu_unroll_enabled(pci);
+	dev_dbg(pci->dev, "iATU unroll: %s\n",
+		pci->iatu_unroll_enabled ? "enabled" : "disabled");
+
+	if (pci->iatu_unroll_enabled && !pci->atu_base)
+		pci->atu_base = pci->dbi_base + DEFAULT_DBI_ATU_OFFSET;
+
 	ret = of_property_read_u32(np, "num-lanes", &lanes);
 	if (ret)
 		lanes = 0;
-- 
2.17.1
