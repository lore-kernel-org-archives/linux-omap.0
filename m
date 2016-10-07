From: Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 2/9] PCI: dra7xx: Name private struct pointer "dra7xx"
 consistently
Date: Fri, 07 Oct 2016 11:33:59 -0500
Message-ID: <20161007163359.24926.11223.stgit@bhelgaas-glaptop2.roam.corp.google.com>
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

Use a device-specific name, "dra7xx", for struct dra7xx_pcie pointers
to hint that this is device-specific information.  No functional change
intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/host/pci-dra7xx.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/host/pci-dra7xx.c b/drivers/pci/host/pci-dra7xx.c
index 765f48b..3248b32 100644
--- a/drivers/pci/host/pci-dra7xx.c
+++ b/drivers/pci/host/pci-dra7xx.c
@@ -73,14 +73,14 @@ struct dra7xx_pcie {
 
 #define to_dra7xx_pcie(x)	container_of((x), struct dra7xx_pcie, pp)
 
-static u32 dra7xx_readl(struct dra7xx_pcie *pcie, u32 offset)
+static u32 dra7xx_readl(struct dra7xx_pcie *dra7xx, u32 offset)
 {
-	return readl(pcie->base + offset);
+	return readl(dra7xx->base + offset);
 }
 
-static void dra7xx_writel(struct dra7xx_pcie *pcie, u32 offset, u32 value)
+static void dra7xx_writel(struct dra7xx_pcie *dra7xx, u32 offset, u32 value)
 {
-	writel(value, pcie->base + offset);
+	writel(value, dra7xx->base + offset);
 }
 
 static inline u32 dra7xx_pcie_readl_rc(struct pcie_port *pp, u32 offset)
