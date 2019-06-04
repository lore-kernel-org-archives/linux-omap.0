From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [RFC PATCH 08/30] PCI: cadence: Add support to use PCIe in J721E SoC
Date: Tue, 4 Jun 2019 18:44:54 +0530
Message-ID: <20190604131516.13596-9-kishon@ti.com>
References: <20190604131516.13596-1-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190604131516.13596-1-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tom Joseph <tjoseph@cadence.com>, Bjorn Helgaas <bhelgaas@google.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Arnd Bergmann <arnd@arndb.de>, Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Frank Rowand <frowand.list@gmail.com>, Jingoo Han <jingoohan1@gmail.com>, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org, Kishon Vijay Abraham I <kishon@ti.com>
List-Id: linux-omap@vger.kernel.org

Use J721E specific compatible in pcie-cadence-* drivers. Since PCIe in
J721E SoC has a restriction that allows only 32-bit register access,
use the 32-bit accessors for read and write.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/pci/controller/pcie-cadence-ep.c   | 12 +++++-
 drivers/pci/controller/pcie-cadence-host.c | 47 +++++++++++++++++++++-
 2 files changed, 55 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/pcie-cadence-ep.c b/drivers/pci/controller/pcie-cadence-ep.c
index 64ab5c53afb1..07f840cfba23 100644
--- a/drivers/pci/controller/pcie-cadence-ep.c
+++ b/drivers/pci/controller/pcie-cadence-ep.c
@@ -425,9 +425,17 @@ static const struct pci_epc_ops cdns_pcie_epc_ops = {
 	.get_features	= cdns_pcie_ep_get_features,
 };
 
-static const struct of_device_id cdns_pcie_ep_of_match[] = {
-	{ .compatible = "cdns,cdns-pcie-ep" },
+static struct cdns_pcie_ep_data cdns_ti_pcie_ep_data = {
+	.read = cdns_pcie_read32,
+	.write = cdns_pcie_write32,
+};
 
+static const struct of_device_id cdns_pcie_ep_of_match[] = {
+	{ .compatible = "cdns,cdns-pcie-ep",
+	},
+	{ .compatible = "ti,j721e-cdns-pcie-ep",
+	  .data = &cdns_ti_pcie_ep_data,
+	},
 	{ },
 };
 
diff --git a/drivers/pci/controller/pcie-cadence-host.c b/drivers/pci/controller/pcie-cadence-host.c
index 75cf3c312ed2..ab6491b23775 100644
--- a/drivers/pci/controller/pcie-cadence-host.c
+++ b/drivers/pci/controller/pcie-cadence-host.c
@@ -93,9 +93,52 @@ static struct pci_ops cdns_pcie_host_ops = {
 	.write		= pci_generic_config_write,
 };
 
-static const struct of_device_id cdns_pcie_host_of_match[] = {
-	{ .compatible = "cdns,cdns-pcie-host" },
+static int cdns_ti_pcie_config_read(struct pci_bus *bus, unsigned int devfn,
+				    int where, int size, u32 *value)
+{
+	struct pci_host_bridge *bridge = pci_find_host_bridge(bus);
+	struct cdns_pcie_rc *rc = pci_host_bridge_priv(bridge);
+	unsigned int busn = bus->number;
+
+	if (busn == rc->bus_range->start)
+		return pci_generic_config_read32(bus, devfn, where, size,
+						 value);
+
+	return pci_generic_config_read(bus, devfn, where, size, value);
+}
+
+static int cdns_ti_pcie_config_write(struct pci_bus *bus, unsigned int devfn,
+				     int where, int size, u32 value)
+{
+	struct pci_host_bridge *bridge = pci_find_host_bridge(bus);
+	struct cdns_pcie_rc *rc = pci_host_bridge_priv(bridge);
+	unsigned int busn = bus->number;
+
+	if (busn == rc->bus_range->start)
+		return pci_generic_config_write32(bus, devfn, where, size,
+						  value);
+
+	return pci_generic_config_write(bus, devfn, where, size, value);
+}
+
+static struct pci_ops cdns_ti_pcie_host_ops = {
+	.map_bus	= cdns_pci_map_bus,
+	.read		= cdns_ti_pcie_config_read,
+	.write		= cdns_ti_pcie_config_write,
+};
+
+static struct cdns_pcie_host_data cdns_ti_pcie_host_data = {
+	.read = cdns_pcie_read32,
+	.write = cdns_pcie_write32,
+	.ops = &cdns_ti_pcie_host_ops,
+};
 
+static const struct of_device_id cdns_pcie_host_of_match[] = {
+	{ .compatible = "cdns,cdns-pcie-host",
+	},
+	{ .compatible = "ti,j721e-cdns-pcie-host",
+	  .data = &cdns_ti_pcie_host_data,
+	},
 	{ },
 };
 
-- 
2.17.1
