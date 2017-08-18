From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH 12/18] PCI: dwc: designware-ep: Do not disable BARs during initialization
Date: Fri, 18 Aug 2017 20:28:04 +0530
Message-ID: <20170818145810.17649-13-kishon@ti.com>
References: <20170818145810.17649-1-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170818145810.17649-1-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Joao Pinto <Joao.Pinto@synopsys.com>, Arnd Bergmann <arnd@arndb.de>, gregkh@linuxfoundation.org, kishon@ti.com, nsekhar@ti.com, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Some platforms like K2G has reserved use of BAR_0 which shouldn't be
disabled by software. Avoid disabling all BARs during initialization.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/pci/dwc/pcie-designware-ep.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/pci/dwc/pcie-designware-ep.c b/drivers/pci/dwc/pcie-designware-ep.c
index e70ebe3b9b6f..b3205df38d52 100644
--- a/drivers/pci/dwc/pcie-designware-ep.c
+++ b/drivers/pci/dwc/pcie-designware-ep.c
@@ -283,7 +283,6 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
 {
 	int ret;
 	void *addr;
-	enum pci_barno bar;
 	struct pci_epc *epc;
 	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
 	struct device *dev = pci->dev;
@@ -312,9 +311,6 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
 		return -ENOMEM;
 	ep->outbound_addr = addr;
 
-	for (bar = BAR_0; bar <= BAR_5; bar++)
-		dw_pcie_ep_reset_bar(pci, bar);
-
 	if (ep->ops->ep_init)
 		ep->ops->ep_init(ep);
 
-- 
2.11.0
