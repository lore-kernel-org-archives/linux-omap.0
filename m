From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [RFC PATCH 09/30] PCI: cadence: Add platform_data to start link and check link status
Date: Tue, 4 Jun 2019 18:44:55 +0530
Message-ID: <20190604131516.13596-10-kishon@ti.com>
References: <20190604131516.13596-1-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190604131516.13596-1-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tom Joseph <tjoseph@cadence.com>, Bjorn Helgaas <bhelgaas@google.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Arnd Bergmann <arnd@arndb.de>, Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Frank Rowand <frowand.list@gmail.com>, Jingoo Han <jingoohan1@gmail.com>, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org, Kishon Vijay Abraham I <kishon@ti.com>
List-Id: linux-omap@vger.kernel.org

Add support in cadence driver to read platform_data passed to it from
platform specific drivers. The platform_data right now contains two
ops, one to start link and the other to check the link status.
This is required since the registers for starting a link and for
checking link status is in the wrapper and not in Cadence PCIe core.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/pci/controller/pcie-cadence-ep.c   |  1 +
 drivers/pci/controller/pcie-cadence-host.c |  1 +
 drivers/pci/controller/pcie-cadence.c      | 41 ++++++++++++++++++++++
 drivers/pci/controller/pcie-cadence.h      | 13 +++++++
 4 files changed, 56 insertions(+)

diff --git a/drivers/pci/controller/pcie-cadence-ep.c b/drivers/pci/controller/pcie-cadence-ep.c
index 07f840cfba23..b044167071e6 100644
--- a/drivers/pci/controller/pcie-cadence-ep.c
+++ b/drivers/pci/controller/pcie-cadence-ep.c
@@ -462,6 +462,7 @@ static int cdns_pcie_ep_probe(struct platform_device *pdev)
 
 	pcie = &ep->pcie;
 	pcie->is_rc = false;
+	pcie->plat_data = pdev->dev.platform_data;
 
 	data = (struct cdns_pcie_ep_data *)match->data;
 	if (data) {
diff --git a/drivers/pci/controller/pcie-cadence-host.c b/drivers/pci/controller/pcie-cadence-host.c
index ab6491b23775..2363f05e7c58 100644
--- a/drivers/pci/controller/pcie-cadence-host.c
+++ b/drivers/pci/controller/pcie-cadence-host.c
@@ -304,6 +304,7 @@ static int cdns_pcie_host_probe(struct platform_device *pdev)
 	rc->dev = dev;
 
 	pcie = &rc->pcie;
+	pcie->plat_data = pdev->dev.platform_data;
 	pcie->is_rc = true;
 
 	data = (struct cdns_pcie_host_data *)match->data;
diff --git a/drivers/pci/controller/pcie-cadence.c b/drivers/pci/controller/pcie-cadence.c
index de5b3b06f2d0..5ac42b19bb63 100644
--- a/drivers/pci/controller/pcie-cadence.c
+++ b/drivers/pci/controller/pcie-cadence.c
@@ -3,6 +3,7 @@
 // Cadence PCIe controller driver.
 // Author: Cyrille Pitchen <cyrille.pitchen@free-electrons.com>
 
+#include <linux/delay.h>
 #include <linux/kernel.h>
 
 #include "pcie-cadence.h"
@@ -47,6 +48,46 @@ void cdns_pcie_write32(void __iomem *addr, int size, u32 value)
 	writel(val, aligned_addr);
 }
 
+int cdns_pcie_start_link(struct cdns_pcie *pci, bool start)
+{
+	struct cdns_pcie_plat_data *plat_data;
+
+	plat_data = pci->plat_data;
+	if (!plat_data)
+		return 0;
+
+	return plat_data->start_link(plat_data, start);
+}
+
+static bool cdns_pcie_is_link_up(struct cdns_pcie *pci)
+{
+	struct cdns_pcie_plat_data *plat_data;
+
+	plat_data = pci->plat_data;
+	if (!plat_data)
+		return true;
+
+	return plat_data->is_link_up(plat_data);
+}
+
+int cdns_pcie_wait_for_link(struct device *dev, struct cdns_pcie *pci)
+{
+	int retries;
+
+	/* Check if the link is up or not */
+	for (retries = 0; retries < LINK_WAIT_MAX_RETRIES; retries++) {
+		if (cdns_pcie_is_link_up(pci)) {
+			dev_info(dev, "Link up\n");
+			return 0;
+		}
+		usleep_range(LINK_WAIT_USLEEP_MIN, LINK_WAIT_USLEEP_MAX);
+	}
+
+	dev_err(dev, "Phy link never came up\n");
+
+	return -ETIMEDOUT;
+}
+
 void cdns_pcie_set_outbound_region(struct cdns_pcie *pcie, u8 fn,
 				   u32 r, bool is_io,
 				   u64 cpu_addr, u64 pci_addr, size_t size)
diff --git a/drivers/pci/controller/pcie-cadence.h b/drivers/pci/controller/pcie-cadence.h
index d157bf5eabd5..3cef398b50da 100644
--- a/drivers/pci/controller/pcie-cadence.h
+++ b/drivers/pci/controller/pcie-cadence.h
@@ -10,6 +10,11 @@
 #include <linux/pci.h>
 #include <linux/phy/phy.h>
 
+/* Parameters for the waiting for link up routine */
+#define LINK_WAIT_MAX_RETRIES	10
+#define LINK_WAIT_USLEEP_MIN	90000
+#define LINK_WAIT_USLEEP_MAX	100000
+
 /*
  * Local Management Registers
  */
@@ -221,6 +226,11 @@ enum cdns_pcie_msg_routing {
 	MSG_ROUTING_GATHER,
 };
 
+struct cdns_pcie_plat_data {
+	int (*start_link)(struct cdns_pcie_plat_data *data, bool start);
+	bool (*is_link_up)(struct cdns_pcie_plat_data *data);
+};
+
 /**
  * struct cdns_pcie - private data for Cadence PCIe controller drivers
  * @reg_base: IO mapped register base
@@ -236,6 +246,7 @@ struct cdns_pcie {
 	int			phy_count;
 	struct phy		**phy;
 	struct device_link	**link;
+	struct cdns_pcie_plat_data *plat_data;
 	u32 (*read)(void __iomem *addr, int size);
 	void (*write)(void __iomem *addr, int size, u32 value);
 };
@@ -408,6 +419,8 @@ int cdns_pcie_enable_phy(struct cdns_pcie *pcie);
 int cdns_pcie_init_phy(struct device *dev, struct cdns_pcie *pcie);
 u32 cdns_pcie_read32(void __iomem *addr, int size);
 void cdns_pcie_write32(void __iomem *addr, int size, u32 value);
+int cdns_pcie_start_link(struct cdns_pcie *pci, bool start);
+int cdns_pcie_wait_for_link(struct device *dev, struct cdns_pcie *pci);
 extern const struct dev_pm_ops cdns_pcie_pm_ops;
 
 #endif /* _PCIE_CADENCE_H */
-- 
2.17.1
