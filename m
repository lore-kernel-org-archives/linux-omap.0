From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v2 15/26] PCI: keystone: Invoke phy_reset API before enabling PHY
Date: Mon, 25 Mar 2019 14:04:50 +0530
Message-ID: <20190325083501.8088-16-kishon@ti.com>
References: <20190325083501.8088-1-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190325083501.8088-1-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Gustavo Pimentel <gustavo.pimentel@synopsys.com>, Bjorn Helgaas <bhelgaas@google.com>, Rob Herring <robh+dt@kernel.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Arnd Bergmann <arnd@arndb.de>, Murali Karicheri <m-karicheri2@ti.com>
Cc: Kishon Vijay Abraham I <kishon@ti.com>, Jingoo Han <jingoohan1@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-arm-kernel@axis.com
List-Id: linux-omap@vger.kernel.org

SERDES connected to the PCIe controller in AM654 requires
power on reset enable (POR_EN) to be set in the SERDES. The
SERDES driver sets POR_EN in the reset ops and it has to be
invoked before init or enable ops. In order for SERDES driver
to set POR_EN, invoke phy_reset API in pci-keystone driver.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/pci/controller/dwc/pci-keystone.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
index a6a482bd648f..e4a816f53b8e 100644
--- a/drivers/pci/controller/dwc/pci-keystone.c
+++ b/drivers/pci/controller/dwc/pci-keystone.c
@@ -897,6 +897,10 @@ static int ks_pcie_enable_phy(struct keystone_pcie *ks_pcie)
 	int num_lanes = ks_pcie->num_lanes;
 
 	for (i = 0; i < num_lanes; i++) {
+		ret = phy_reset(ks_pcie->phy[i]);
+		if (ret < 0)
+			goto err_phy;
+
 		ret = phy_init(ks_pcie->phy[i]);
 		if (ret < 0)
 			goto err_phy;
-- 
2.17.1
