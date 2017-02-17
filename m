From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v2 10/22] PCI: dwc: dra7xx: Facilitate wrapper and msi interrupts to be enabled independently
Date: Fri, 17 Feb 2017 15:20:30 +0530
Message-ID: <1487325042-28227-11-git-send-email-kishon@ti.com>
References: <1487325042-28227-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <1487325042-28227-1-git-send-email-kishon@ti.com>
Sender: linux-pci-owner@vger.kernel.org
To: Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>, Joao Pinto <Joao.Pinto@synopsys.com>
Cc: linux-pci@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, nsekhar@ti.com, Kishon Vijay Abraham I <kishon@ti.com>
List-Id: linux-omap@vger.kernel.org

No functional change. Split dra7xx_pcie_enable_interrupts into
dra7xx_pcie_enable_wrapper_interrupts and dra7xx_pcie_enable_msi_interrupts
so that wrapper interrupts and msi interrupts can be enabled independently.
This is in preparation for adding EP mode support to dra7xx driver since
EP mode doesn't have to enable msi_interrupts.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/pci/dwc/pci-dra7xx.c |   24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/dwc/pci-dra7xx.c b/drivers/pci/dwc/pci-dra7xx.c
index c6fef0a..8d2d02f 100644
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
1.7.9.5
