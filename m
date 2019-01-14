From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH 15/24] PCI: keystone: Invoke phy_reset API before enabling PHY
Date: Mon, 14 Jan 2019 18:54:15 +0530
Message-ID: <20190114132424.6445-16-kishon@ti.com>
References: <20190114132424.6445-1-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190114132424.6445-1-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Gustavo Pimentel <gustavo.pimentel@synopsys.com>, Rob Herring <robh+dt@kernel.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Kishon Vijay Abraham I <kishon@ti.com>, Jingoo Han <jingoohan1@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>, Mark Rutland <mark.rutland@arm.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Murali Karicheri <m-karicheri2@ti.com>, Jesper Nilsson <jesper.nilsson@axis.com>, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-arm-kernel@axis.com
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
index c2873339809a..e2f4e7c01b5a 100644
--- a/drivers/pci/controller/dwc/pci-keystone.c
+++ b/drivers/pci/controller/dwc/pci-keystone.c
@@ -873,6 +873,10 @@ static int ks_pcie_enable_phy(struct keystone_pcie *ks_pcie)
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
