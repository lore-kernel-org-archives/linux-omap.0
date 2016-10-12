From: Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v2 2/7] PCI: dra7xx: Remove redundant struct device pointer
 from dra7xx_pcie
Date: Wed, 12 Oct 2016 08:32:50 -0500
Message-ID: <20161012133250.27714.23262.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20161012133112.27714.93244.stgit@bhelgaas-glaptop2.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <20161012133112.27714.93244.stgit@bhelgaas-glaptop2.roam.corp.google.com>
Sender: linux-pci-owner@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: linux-pci@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

The DesignWare core already stores the struct device pointer in struct
pcie_port.  Remove the redundant copy from struct dra7xx_pcie.dev.  No
functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/host/pci-dra7xx.c |    2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/pci/host/pci-dra7xx.c b/drivers/pci/host/pci-dra7xx.c
index 2323679..1c24f34 100644
--- a/drivers/pci/host/pci-dra7xx.c
+++ b/drivers/pci/host/pci-dra7xx.c
@@ -67,7 +67,6 @@ struct dra7xx_pcie {
 	void __iomem		*base;
 	struct phy		**phy;
 	int			phy_count;
-	struct device		*dev;
 	struct pcie_port	pp;
 };
 
@@ -390,7 +389,6 @@ static int __init dra7xx_pcie_probe(struct platform_device *pdev)
 
 	dra7xx->base = base;
 	dra7xx->phy = phy;
-	dra7xx->dev = dev;
 	dra7xx->phy_count = phy_count;
 
 	pm_runtime_enable(dev);
