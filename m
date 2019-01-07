From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH 12/15] PCI: cadence: Remove pci_epf_linkup from Cadence EP driver
Date: Mon, 7 Jan 2019 12:11:45 +0530
Message-ID: <20190107064148.10152-13-kishon@ti.com>
References: <20190107064148.10152-1-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190107064148.10152-1-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Bjorn Helgaas <bhelgaas@google.com>, Gustavo Pimentel <gustavo.pimentel@synopsys.com>, Alan Douglas <adouglas@cadence.com>, Shawn Lin <shawn.lin@rock-chips.com>
Cc: Jingoo Han <jingoohan1@gmail.com>, Heiko Stuebner <heiko@sntech.de>, Cyrille Pitchen <cyrille.pitchen@free-electrons.com>, Jia-Ju Bai <baijiaju1990@gmail.com>, linux-omap@vger.kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org, kishon@ti.com
List-Id: linux-omap@vger.kernel.org

pci_epf_linkup is intended to be invoked if the EPC supports linkup
notification. Now that pci-epf-test uses get_features callback, which
indicates Cadence EP driver doesn't support linkup notification, remove
pci_epf_linkup from Cadence EP driver.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/pci/controller/pcie-cadence-ep.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/drivers/pci/controller/pcie-cadence-ep.c b/drivers/pci/controller/pcie-cadence-ep.c
index 14c2545bb17e..def7820cb824 100644
--- a/drivers/pci/controller/pcie-cadence-ep.c
+++ b/drivers/pci/controller/pcie-cadence-ep.c
@@ -396,18 +396,6 @@ static int cdns_pcie_ep_start(struct pci_epc *epc)
 		cfg |= BIT(epf->func_no);
 	cdns_pcie_writel(pcie, CDNS_PCIE_LM_EP_FUNC_CFG, cfg);
 
-	/*
-	 * The PCIe links are automatically established by the controller
-	 * once for all at powerup: the software can neither start nor stop
-	 * those links later at runtime.
-	 *
-	 * Then we only have to notify the EP core that our links are already
-	 * established. However we don't call directly pci_epc_linkup() because
-	 * we've already locked the epc->lock.
-	 */
-	list_for_each_entry(epf, &epc->pci_epf, list)
-		pci_epf_linkup(epf);
-
 	return 0;
 }
 
-- 
2.17.1
