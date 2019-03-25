From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v3 23/26] PCI: designware-ep: Configure RESBAR to advertise the smallest size
Date: Mon, 25 Mar 2019 15:09:44 +0530
Message-ID: <20190325093947.32633-24-kishon@ti.com>
References: <20190325093947.32633-1-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190325093947.32633-1-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Gustavo Pimentel <gustavo.pimentel@synopsys.com>, Bjorn Helgaas <bhelgaas@google.com>, Rob Herring <robh+dt@kernel.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Arnd Bergmann <arnd@arndb.de>, Murali Karicheri <m-karicheri2@ti.com>
Cc: Kishon Vijay Abraham I <kishon@ti.com>, Jingoo Han <jingoohan1@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-arm-kernel@axis.com, Minghuan Lian <minghuan.Lian@nxp.com>, Mingkai Hu <mingkai.hu@nxp.com>, Roy Zang <roy.zang@nxp.com>, Jesper Nilsson <jesper.nilsson@axis.com>
List-Id: linux-omap@vger.kernel.org

Configure RESBAR capability to advertise the smallest size (1MB) for
couple of reasons. A) Host side resource allocation of BAR fails for
larger sizes. B) Endpoint function driver does not allocate memory
for all supported sizes in RESBAR capability.
If and when there is a usecase required to add more flexibility using
RESBAR, this can be revisited.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 .../pci/controller/dwc/pcie-designware-ep.c   | 34 +++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index 74477ad7467f..0c208b9bda43 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -504,10 +504,32 @@ void dw_pcie_ep_exit(struct dw_pcie_ep *ep)
 	pci_epc_mem_exit(epc);
 }
 
+static unsigned int dw_pcie_ep_find_ext_capability(struct dw_pcie *pci, int cap)
+{
+	u32 header;
+	int pos = PCI_CFG_SPACE_SIZE;
+
+	while (pos) {
+		header = dw_pcie_readl_dbi(pci, pos);
+		if (PCI_EXT_CAP_ID(header) == cap)
+			return pos;
+
+		pos = PCI_EXT_CAP_NEXT(header);
+		if (!pos)
+			break;
+	}
+
+	return 0;
+}
+
 int dw_pcie_ep_init(struct dw_pcie_ep *ep)
 {
+	int i;
 	int ret;
+	u32 reg;
 	void *addr;
+	unsigned int nbars;
+	unsigned int offset;
 	struct pci_epc *epc;
 	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
 	struct device *dev = pci->dev;
@@ -591,6 +613,18 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
 
 	ep->msix_cap = dw_pcie_ep_find_capability(pci, PCI_CAP_ID_MSIX);
 
+	offset = dw_pcie_ep_find_ext_capability(pci, PCI_EXT_CAP_ID_REBAR);
+	if (offset) {
+		reg = dw_pcie_readl_dbi(pci, offset + PCI_REBAR_CTRL);
+		nbars = (reg & PCI_REBAR_CTRL_NBAR_MASK) >>
+			PCI_REBAR_CTRL_NBAR_SHIFT;
+
+		dw_pcie_dbi_ro_wr_en(pci);
+		for (i = 0; i < nbars; i++, offset += PCI_REBAR_CTRL)
+			dw_pcie_writel_dbi(pci, offset + PCI_REBAR_CAP, 0x0);
+		dw_pcie_dbi_ro_wr_dis(pci);
+	}
+
 	dw_pcie_setup(pci);
 
 	return 0;
-- 
2.17.1
