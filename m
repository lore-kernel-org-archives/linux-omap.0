From: Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 6/9] PCI: dra7xx: Replace dra7xx_pcie_readl_rc() with
 dw_pcie_readl_rc()
Date: Fri, 07 Oct 2016 11:34:38 -0500
Message-ID: <20161007163438.24926.7897.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20161007163350.24926.17545.stgit@bhelgaas-glaptop2.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <20161007163350.24926.17545.stgit@bhelgaas-glaptop2.roam.corp.google.com>
Sender: linux-pci-owner@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: linux-pci@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

The dw_pcie_readl_rc() and dw_pcie_writel_rc() interfaces do the same as
dra7xx_pcie_readl_rc() and dra7xx_pcie_writel_rc(), and they also give us a
clue that we're using the DesignWare-generic functionality.  Use the dw_*()
interfaces and remove the dra7xx-specific ones.  No functional change
intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/host/pci-dra7xx.c |   19 ++++---------------
 1 file changed, 4 insertions(+), 15 deletions(-)

diff --git a/drivers/pci/host/pci-dra7xx.c b/drivers/pci/host/pci-dra7xx.c
index 118b612..5572613 100644
--- a/drivers/pci/host/pci-dra7xx.c
+++ b/drivers/pci/host/pci-dra7xx.c
@@ -82,17 +82,6 @@ static void dra7xx_writel(struct dra7xx_pcie *dra7xx, u32 offset, u32 value)
 	writel(value, dra7xx->base + offset);
 }
 
-static u32 dra7xx_pcie_readl_rc(struct dra7xx_pcie *dra7xx, u32 offset)
-{
-	return readl(dra7xx->pp.dbi_base + offset);
-}
-
-static void dra7xx_pcie_writel_rc(struct dra7xx_pcie *dra7xx, u32 offset,
-				  u32 value)
-{
-	writel(value, dra7xx->pp.dbi_base + offset);
-}
-
 static int dra7xx_pcie_link_up(struct pcie_port *pp)
 {
 	struct dra7xx_pcie *dra7xx = to_dra7xx_pcie(pp);
@@ -448,9 +437,9 @@ static int dra7xx_pcie_suspend(struct device *dev)
 	u32 val;
 
 	/* clear MSE */
-	val = dra7xx_pcie_readl_rc(dra7xx, PCI_COMMAND);
+	val = dw_pcie_readl_rc(&dra7xx->pp, PCI_COMMAND);
 	val &= ~PCI_COMMAND_MEMORY;
-	dra7xx_pcie_writel_rc(dra7xx, PCI_COMMAND, val);
+	dw_pcie_writel_rc(&dra7xx->pp, PCI_COMMAND, val);
 
 	return 0;
 }
@@ -461,9 +450,9 @@ static int dra7xx_pcie_resume(struct device *dev)
 	u32 val;
 
 	/* set MSE */
-	val = dra7xx_pcie_readl_rc(dra7xx, PCI_COMMAND);
+	val = dw_pcie_readl_rc(&dra7xx->pp, PCI_COMMAND);
 	val |= PCI_COMMAND_MEMORY;
-	dra7xx_pcie_writel_rc(dra7xx, PCI_COMMAND, val);
+	dw_pcie_writel_rc(&dra7xx->pp, PCI_COMMAND, val);
 
 	return 0;
 }
