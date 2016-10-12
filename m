From: Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v2 7/7] PCI: dra7xx: Reorder struct dra7xx_pcie
Date: Wed, 12 Oct 2016 08:33:30 -0500
Message-ID: <20161012133330.27714.77069.stgit@bhelgaas-glaptop2.roam.corp.google.com>
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

Reorder struct dra7xx_pcie to put generic fields first.  No functional
change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/host/pci-dra7xx.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/host/pci-dra7xx.c b/drivers/pci/host/pci-dra7xx.c
index bb77c35..9595fad 100644
--- a/drivers/pci/host/pci-dra7xx.c
+++ b/drivers/pci/host/pci-dra7xx.c
@@ -64,10 +64,10 @@
 #define	DRA7XX_CPU_TO_BUS_ADDR				0x0FFFFFFF
 
 struct dra7xx_pcie {
-	void __iomem		*base;
-	struct phy		**phy;
-	int			phy_count;
 	struct pcie_port	pp;
+	void __iomem		*base;		/* DT ti_conf */
+	int			phy_count;	/* DT phy-names count */
+	struct phy		**phy;
 };
 
 #define to_dra7xx_pcie(x)	container_of((x), struct dra7xx_pcie, pp)
