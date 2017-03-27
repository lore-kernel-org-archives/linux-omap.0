From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v5 11/24] PCI: dwc: dra7xx: Facilitate wrapper and msi interrupts to be enabled independently
Date: Mon, 27 Mar 2017 15:15:07 +0530
Message-ID: <20170327094520.3129-12-kishon@ti.com>
References: <20170327094520.3129-1-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <20170327094520.3129-1-kishon@ti.com>
Sender: linux-pci-owner@vger.kernel.org
To: Bjorn Helgaas <bhelgaas@google.com>, Joao Pinto <Joao.Pinto@synopsys.com>, linux-pci@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: hch@infradead.org, nsekhar@ti.com, kishon@ti.com
List-Id: linux-omap@vger.kernel.org

No functional change. Split dra7xx_pcie_enable_interrupts into
dra7xx_pcie_enable_wrapper_interrupts and dra7xx_pcie_enable_msi_interrupts
so that wrapper interrupts and msi interrupts can be enabled independently.
This is in preparation for adding EP mode support to dra7xx driver since
EP mode doesn't have to enable msi_interrupts.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/pci/dwc/pci-dra7xx.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/dwc/pci-dra7xx.c b/drivers/pci/dwc/pci-dra7xx.c
index 7c9ed6a6675c..d78974d20360 100644
--- a/drivers/pci/dwc/pci-dra7xx.c
+++ b/drivers/pci/dwc/pci-dra7xx.c
@@ -140,18 +140,30 @@ static int dra7xx_pcie_establish_link(struct dra7xx_pcie *dra7xx)
 	return dw_pcie_wait_for_link(pci);
 }
 
-static void dra7xx_pcie_enable_interrupts(struct dra7xx_pcie *dra7xx)
+static void dra7xx_pcie_enable_msi_interrupts(struct dra7xx_pcie *dra7xx)
 {
-	dra7xx_pcie_writel(dra7xx, PCIECTRL_DRA7XX_CONF_IRQSTATUS_MAIN,
-			   ~INTERRUPTS);
-	dra7xx_pcie_writel(dra7xx,
-			   PCIECTRL_DRA7XX_CONF_IRQENABLE_SET_MAIN, INTERRUPTS);
 	dra7xx_pcie_writel(dra7xx, PCIECTRL_DRA7XX_CONF_IRQSTATUS_MSI,
 			   ~LEG_EP_INTERRUPTS & ~MSI);
-	dra7xx_pcie_writel(dra7xx, PCIECTRL_DRA7XX_CONF_IRQENABLE_SET_MSI,
+
+	dra7xx_pcie_writel(dra7xx,
+			   PCIECTRL_DRA7XX_CONF_IRQENABLE_SET_MSI,
 			   MSI | LEG_EP_INTERRUPTS);
 }
 
+static void dra7xx_pcie_enable_wrapper_interrupts(struct dra7xx_pcie *dra7xx)
+{
+	dra7xx_pcie_writel(dra7xx, PCIECTRL_DRA7XX_CONF_IRQSTATUS_MAIN,
+			   ~INTERRUPTS);
+	dra7xx_pcie_writel(dra7xx, PCIECTRL_DRA7XX_CONF_IRQENABLE_SET_MAIN,
+			   INTERRUPTS);
+}
+
+static void dra7xx_pcie_enable_interrupts(struct dra7xx_pcie *dra7xx)
+{
+	dra7xx_pcie_enable_wrapper_interrupts(dra7xx);
+	dra7xx_pcie_enable_msi_interrupts(dra7xx);
+}
+
 static void dra7xx_pcie_host_init(struct pcie_port *pp)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
-- 
2.11.0
