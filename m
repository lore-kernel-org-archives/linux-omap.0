From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v2 19/26] PCI: dwc: Add const qualifier to struct dw_pcie_ep_ops
Date: Mon, 25 Mar 2019 14:04:54 +0530
Message-ID: <20190325083501.8088-20-kishon@ti.com>
References: <20190325083501.8088-1-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190325083501.8088-1-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Gustavo Pimentel <gustavo.pimentel@synopsys.com>, Bjorn Helgaas <bhelgaas@google.com>, Rob Herring <robh+dt@kernel.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Arnd Bergmann <arnd@arndb.de>, Murali Karicheri <m-karicheri2@ti.com>
Cc: Kishon Vijay Abraham I <kishon@ti.com>, Jingoo Han <jingoohan1@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-arm-kernel@axis.com
List-Id: linux-omap@vger.kernel.org

Add const qualifier to struct dw_pcie_ep_ops member of
struct dw_pcie_ep.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/pci/controller/dwc/pci-dra7xx.c           | 2 +-
 drivers/pci/controller/dwc/pcie-artpec6.c         | 2 +-
 drivers/pci/controller/dwc/pcie-designware-plat.c | 2 +-
 drivers/pci/controller/dwc/pcie-designware.h      | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-dra7xx.c b/drivers/pci/controller/dwc/pci-dra7xx.c
index ae84a69ae63a..b287dbf6914c 100644
--- a/drivers/pci/controller/dwc/pci-dra7xx.c
+++ b/drivers/pci/controller/dwc/pci-dra7xx.c
@@ -406,7 +406,7 @@ dra7xx_pcie_get_features(struct dw_pcie_ep *ep)
 	return &dra7xx_pcie_epc_features;
 }
 
-static struct dw_pcie_ep_ops pcie_ep_ops = {
+static const struct dw_pcie_ep_ops pcie_ep_ops = {
 	.ep_init = dra7xx_pcie_ep_init,
 	.raise_irq = dra7xx_pcie_raise_irq,
 	.get_features = dra7xx_pcie_get_features,
diff --git a/drivers/pci/controller/dwc/pcie-artpec6.c b/drivers/pci/controller/dwc/pcie-artpec6.c
index dba83abfe764..d00252bd8fae 100644
--- a/drivers/pci/controller/dwc/pcie-artpec6.c
+++ b/drivers/pci/controller/dwc/pcie-artpec6.c
@@ -444,7 +444,7 @@ static int artpec6_pcie_raise_irq(struct dw_pcie_ep *ep, u8 func_no,
 	return 0;
 }
 
-static struct dw_pcie_ep_ops pcie_ep_ops = {
+static const struct dw_pcie_ep_ops pcie_ep_ops = {
 	.ep_init = artpec6_pcie_ep_init,
 	.raise_irq = artpec6_pcie_raise_irq,
 };
diff --git a/drivers/pci/controller/dwc/pcie-designware-plat.c b/drivers/pci/controller/dwc/pcie-designware-plat.c
index 932dbd0b34b6..b58fdcbc664b 100644
--- a/drivers/pci/controller/dwc/pcie-designware-plat.c
+++ b/drivers/pci/controller/dwc/pcie-designware-plat.c
@@ -106,7 +106,7 @@ dw_plat_pcie_get_features(struct dw_pcie_ep *ep)
 	return &dw_plat_pcie_epc_features;
 }
 
-static struct dw_pcie_ep_ops pcie_ep_ops = {
+static const struct dw_pcie_ep_ops pcie_ep_ops = {
 	.ep_init = dw_plat_pcie_ep_init,
 	.raise_irq = dw_plat_pcie_ep_raise_irq,
 	.get_features = dw_plat_pcie_get_features,
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 90a5b1215344..e36941ff7cf6 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -196,7 +196,7 @@ struct dw_pcie_ep_ops {
 
 struct dw_pcie_ep {
 	struct pci_epc		*epc;
-	struct dw_pcie_ep_ops	*ops;
+	const struct dw_pcie_ep_ops *ops;
 	phys_addr_t		phys_base;
 	size_t			addr_size;
 	size_t			page_size;
-- 
2.17.1
