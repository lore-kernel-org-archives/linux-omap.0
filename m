From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [RFC PATCH 10/30] PCI: cadence: Use *_start_link() and *_wait_for_link() to establish link
Date: Tue, 4 Jun 2019 18:44:56 +0530
Message-ID: <20190604131516.13596-11-kishon@ti.com>
References: <20190604131516.13596-1-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190604131516.13596-1-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tom Joseph <tjoseph@cadence.com>, Bjorn Helgaas <bhelgaas@google.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Arnd Bergmann <arnd@arndb.de>, Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Frank Rowand <frowand.list@gmail.com>, Jingoo Han <jingoohan1@gmail.com>, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org, Kishon Vijay Abraham I <kishon@ti.com>
List-Id: linux-omap@vger.kernel.org

Use cdns_pcie_start_link() to start link training and
cdns_pcie_wait_for_link() in order to wait to establish the link.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/pci/controller/pcie-cadence-ep.c   | 11 ++++++++++-
 drivers/pci/controller/pcie-cadence-host.c | 11 +++++++++++
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pcie-cadence-ep.c b/drivers/pci/controller/pcie-cadence-ep.c
index b044167071e6..825a515821c3 100644
--- a/drivers/pci/controller/pcie-cadence-ep.c
+++ b/drivers/pci/controller/pcie-cadence-ep.c
@@ -21,6 +21,7 @@
 /**
  * struct cdns_pcie_ep - private data for this PCIe endpoint controller driver
  * @pcie: Cadence PCIe controller
+ * @dev: pointer to PCIe EP device
  * @max_regions: maximum number of regions supported by hardware
  * @ob_region_map: bitmask of mapped outbound regions
  * @ob_addr: base addresses in the AXI bus where the outbound regions start
@@ -37,6 +38,7 @@
  */
 struct cdns_pcie_ep {
 	struct cdns_pcie		pcie;
+	struct device			*dev;
 	u32				max_regions;
 	unsigned long			ob_region_map;
 	phys_addr_t			*ob_addr;
@@ -386,6 +388,7 @@ static int cdns_pcie_ep_start(struct pci_epc *epc)
 	struct cdns_pcie_ep *ep = epc_get_drvdata(epc);
 	struct cdns_pcie *pcie = &ep->pcie;
 	struct pci_epf *epf;
+	int ret = 0;
 	u32 cfg;
 
 	/*
@@ -397,7 +400,11 @@ static int cdns_pcie_ep_start(struct pci_epc *epc)
 		cfg |= BIT(epf->func_no);
 	cdns_pcie_writel(pcie, CDNS_PCIE_LM_EP_FUNC_CFG, cfg);
 
-	return 0;
+	ret = cdns_pcie_start_link(pcie, true);
+	if (ret)
+		dev_err(ep->dev, "Failed to start link\n");
+
+	return ret;
 }
 
 static const struct pci_epc_features cdns_pcie_epc_features = {
@@ -460,6 +467,8 @@ static int cdns_pcie_ep_probe(struct platform_device *pdev)
 	if (!ep)
 		return -ENOMEM;
 
+	ep->dev = dev;
+
 	pcie = &ep->pcie;
 	pcie->is_rc = false;
 	pcie->plat_data = pdev->dev.platform_data;
diff --git a/drivers/pci/controller/pcie-cadence-host.c b/drivers/pci/controller/pcie-cadence-host.c
index 2363f05e7c58..4ad8f2ece6e2 100644
--- a/drivers/pci/controller/pcie-cadence-host.c
+++ b/drivers/pci/controller/pcie-cadence-host.c
@@ -365,6 +365,14 @@ static int cdns_pcie_host_probe(struct platform_device *pdev)
 		goto err_get_sync;
 	}
 
+	ret = cdns_pcie_start_link(pcie, true);
+	if (ret) {
+		dev_err(dev, "Failed to start link\n");
+		goto err_start_link;
+	}
+
+	cdns_pcie_wait_for_link(dev, pcie);
+
 	ret = cdns_pcie_host_init(dev, &resources, rc);
 	if (ret)
 		goto err_init;
@@ -386,6 +394,9 @@ static int cdns_pcie_host_probe(struct platform_device *pdev)
 	pci_free_resource_list(&resources);
 
  err_init:
+	cdns_pcie_start_link(pcie, false);
+
+ err_start_link:
 	pm_runtime_put_sync(dev);
 
  err_get_sync:
-- 
2.17.1
