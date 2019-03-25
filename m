From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v3 17/26] PCI: keystone: Add support to set the max link speed from DT
Date: Mon, 25 Mar 2019 15:09:38 +0530
Message-ID: <20190325093947.32633-18-kishon@ti.com>
References: <20190325093947.32633-1-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190325093947.32633-1-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Gustavo Pimentel <gustavo.pimentel@synopsys.com>, Bjorn Helgaas <bhelgaas@google.com>, Rob Herring <robh+dt@kernel.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Arnd Bergmann <arnd@arndb.de>, Murali Karicheri <m-karicheri2@ti.com>
Cc: Kishon Vijay Abraham I <kishon@ti.com>, Jingoo Han <jingoohan1@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-arm-kernel@axis.com, Minghuan Lian <minghuan.Lian@nxp.com>, Mingkai Hu <mingkai.hu@nxp.com>, Roy Zang <roy.zang@nxp.com>, Jesper Nilsson <jesper.nilsson@axis.com>
List-Id: linux-omap@vger.kernel.org

PCIe in TI's AM654 devices is by default configured to work in GEN3 mode.
However PCIe doesn't work reliably in GEN3 mode because of SERDES
configuration.

Add support to set the link speed to GEN1, GEN2 or GEN3 based on
"max-link-speed" dt property with GEN2 as the default speed if
"max-link-speed" is absent.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/pci/controller/dwc/pci-keystone.c | 35 +++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
index e4a816f53b8e..312fd0c49bbb 100644
--- a/drivers/pci/controller/dwc/pci-keystone.c
+++ b/drivers/pci/controller/dwc/pci-keystone.c
@@ -28,6 +28,7 @@
 #include <linux/resource.h>
 #include <linux/signal.h>
 
+#include "../../pci.h"
 #include "pcie-designware.h"
 
 #define PCIE_VENDORID_MASK	0xffff
@@ -89,6 +90,8 @@
 #define LEG_EP				0x1
 #define RC				0x2
 
+#define EXP_CAP_ID_OFFSET		0x70
+
 #define KS_PCIE_SYSCLOCKOUTEN		BIT(0)
 
 #define AM654_PCIE_DEV_TYPE_MASK	0x3
@@ -971,6 +974,31 @@ static int ks_pcie_am654_set_mode(struct device *dev)
 	return 0;
 }
 
+static void ks_pcie_set_link_speed(struct dw_pcie *pci, int link_speed)
+{
+	u32 val;
+
+	dw_pcie_dbi_ro_wr_en(pci);
+
+	val = dw_pcie_readl_dbi(pci, EXP_CAP_ID_OFFSET + PCI_EXP_LNKCAP);
+	if ((val & PCI_EXP_LNKCAP_SLS) != link_speed) {
+		val &= ~((u32)PCI_EXP_LNKCAP_SLS);
+		val |= link_speed;
+		dw_pcie_writel_dbi(pci, EXP_CAP_ID_OFFSET + PCI_EXP_LNKCAP,
+				   val);
+	}
+
+	val = dw_pcie_readl_dbi(pci, EXP_CAP_ID_OFFSET + PCI_EXP_LNKCTL2);
+	if ((val & PCI_EXP_LNKCAP_SLS) != link_speed) {
+		val &= ~((u32)PCI_EXP_LNKCAP_SLS);
+		val |= link_speed;
+		dw_pcie_writel_dbi(pci, EXP_CAP_ID_OFFSET + PCI_EXP_LNKCTL2,
+				   val);
+	}
+
+	dw_pcie_dbi_ro_wr_dis(pci);
+}
+
 static const struct ks_pcie_of_data ks_pcie_rc_of_data = {
 	.host_ops = &ks_pcie_host_ops,
 	.version = 0x365A,
@@ -1011,6 +1039,7 @@ static int __init ks_pcie_probe(struct platform_device *pdev)
 	void __iomem *base;
 	u32 num_viewport;
 	struct phy **phy;
+	int link_speed;
 	u32 num_lanes;
 	char name[10];
 	int ret;
@@ -1165,6 +1194,12 @@ static int __init ks_pcie_probe(struct platform_device *pdev)
 		gpiod_set_value_cansleep(gpiod, 1);
 	}
 
+	link_speed = of_pci_get_max_link_speed(np);
+	if (link_speed < 0)
+		link_speed = 2;
+
+	ks_pcie_set_link_speed(pci, link_speed);
+
 	pci->pp.ops = host_ops;
 	ret = ks_pcie_add_pcie_port(ks_pcie, pdev);
 	if (ret < 0)
-- 
2.17.1
