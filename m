From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v4 2/7] PCI: dwc: dra7xx: Populate cpu_addr_fixup ops
Date: Mon, 13 Mar 2017 19:13:23 +0530
Message-ID: <20170313134328.1588-3-kishon@ti.com>
References: <20170313134328.1588-1-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <20170313134328.1588-1-kishon@ti.com>
Sender: linux-pci-owner@vger.kernel.org
To: Bjorn Helgaas <bhelgaas@google.com>, Joao Pinto <Joao.Pinto@synopsys.com>, Niklas Cassel <niklas.cassel@axis.com>, linux-omap@vger.kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: kishon@ti.com, nsekhar@ti.com
List-Id: linux-omap@vger.kernel.org

Populate cpu_addr_fixup ops to extract the least 28 bits of the
corresponding cpu address.

Acked-by: Joao Pinto <jpinto@synopsys.com>
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/pci/dwc/pci-dra7xx.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/dwc/pci-dra7xx.c b/drivers/pci/dwc/pci-dra7xx.c
index 0984baff07e3..07c45ec07662 100644
--- a/drivers/pci/dwc/pci-dra7xx.c
+++ b/drivers/pci/dwc/pci-dra7xx.c
@@ -88,6 +88,11 @@ static inline void dra7xx_pcie_writel(struct dra7xx_pcie *pcie, u32 offset,
 	writel(value, pcie->base + offset);
 }
 
+static u64 dra7xx_pcie_cpu_addr_fixup(u64 pci_addr)
+{
+	return pci_addr & DRA7XX_CPU_TO_BUS_ADDR;
+}
+
 static int dra7xx_pcie_link_up(struct dw_pcie *pci)
 {
 	struct dra7xx_pcie *dra7xx = to_dra7xx_pcie(pci);
@@ -152,11 +157,6 @@ static void dra7xx_pcie_host_init(struct pcie_port *pp)
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
 	struct dra7xx_pcie *dra7xx = to_dra7xx_pcie(pci);
 
-	pp->io_base &= DRA7XX_CPU_TO_BUS_ADDR;
-	pp->mem_base &= DRA7XX_CPU_TO_BUS_ADDR;
-	pp->cfg0_base &= DRA7XX_CPU_TO_BUS_ADDR;
-	pp->cfg1_base &= DRA7XX_CPU_TO_BUS_ADDR;
-
 	dw_pcie_setup_rc(pp);
 
 	dra7xx_pcie_establish_link(dra7xx);
@@ -329,6 +329,7 @@ static int __init dra7xx_add_pcie_port(struct dra7xx_pcie *dra7xx,
 }
 
 static const struct dw_pcie_ops dw_pcie_ops = {
+	.cpu_addr_fixup = dra7xx_pcie_cpu_addr_fixup,
 	.link_up = dra7xx_pcie_link_up,
 };
 
-- 
2.11.0
