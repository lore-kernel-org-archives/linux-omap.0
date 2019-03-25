From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v2 16/26] PCI: OF: Allow of_pci_get_max_link_speed() to be used by PCI Endpoint drivers
Date: Mon, 25 Mar 2019 14:04:51 +0530
Message-ID: <20190325083501.8088-17-kishon@ti.com>
References: <20190325083501.8088-1-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190325083501.8088-1-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Gustavo Pimentel <gustavo.pimentel@synopsys.com>, Bjorn Helgaas <bhelgaas@google.com>, Rob Herring <robh+dt@kernel.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Arnd Bergmann <arnd@arndb.de>, Murali Karicheri <m-karicheri2@ti.com>
Cc: Kishon Vijay Abraham I <kishon@ti.com>, Jingoo Han <jingoohan1@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-arm-kernel@axis.com, Sekhar Nori <nsekhar@ti.com>
List-Id: linux-omap@vger.kernel.org

of_pci_get_max_link_speed() is built only if CONFIG_PCI is enabled.
Make of_pci_get_max_link_speed() to be also used by PCI Endpoint
controllers with just CONFIG_PCI_ENDPOINT enabled.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Sekhar Nori <nsekhar@ti.com>
---
 drivers/pci/Makefile |  2 +-
 drivers/pci/of.c     | 44 +++++++++++++++++++++++---------------------
 2 files changed, 24 insertions(+), 22 deletions(-)

diff --git a/drivers/pci/Makefile b/drivers/pci/Makefile
index 657d642fcc67..28cdd8c0213a 100644
--- a/drivers/pci/Makefile
+++ b/drivers/pci/Makefile
@@ -10,10 +10,10 @@ obj-$(CONFIG_PCI)		+= access.o bus.o probe.o host-bridge.o \
 ifdef CONFIG_PCI
 obj-$(CONFIG_PROC_FS)		+= proc.o
 obj-$(CONFIG_SYSFS)		+= slot.o
-obj-$(CONFIG_OF)		+= of.o
 obj-$(CONFIG_ACPI)		+= pci-acpi.o
 endif
 
+obj-$(CONFIG_OF)		+= of.o
 obj-$(CONFIG_PCI_QUIRKS)	+= quirks.o
 obj-$(CONFIG_PCIEPORTBUS)	+= pcie/
 obj-$(CONFIG_HOTPLUG_PCI)	+= hotplug/
diff --git a/drivers/pci/of.c b/drivers/pci/of.c
index 3d32da15c215..8095933f8452 100644
--- a/drivers/pci/of.c
+++ b/drivers/pci/of.c
@@ -15,6 +15,7 @@
 #include <linux/of_pci.h>
 #include "pci.h"
 
+#ifdef CONFIG_PCI
 void pci_set_of_node(struct pci_dev *dev)
 {
 	if (!dev->bus->dev.of_node)
@@ -196,27 +197,6 @@ int of_get_pci_domain_nr(struct device_node *node)
 }
 EXPORT_SYMBOL_GPL(of_get_pci_domain_nr);
 
-/**
- * This function will try to find the limitation of link speed by finding
- * a property called "max-link-speed" of the given device node.
- *
- * @node: device tree node with the max link speed information
- *
- * Returns the associated max link speed from DT, or a negative value if the
- * required property is not found or is invalid.
- */
-int of_pci_get_max_link_speed(struct device_node *node)
-{
-	u32 max_link_speed;
-
-	if (of_property_read_u32(node, "max-link-speed", &max_link_speed) ||
-	    max_link_speed > 4)
-		return -EINVAL;
-
-	return max_link_speed;
-}
-EXPORT_SYMBOL_GPL(of_pci_get_max_link_speed);
-
 /**
  * of_pci_check_probe_only - Setup probe only mode if linux,pci-probe-only
  *                           is present and valid
@@ -537,3 +517,25 @@ int pci_parse_request_of_pci_ranges(struct device *dev,
 	return err;
 }
 
+#endif /* CONFIG_PCI */
+
+/**
+ * This function will try to find the limitation of link speed by finding
+ * a property called "max-link-speed" of the given device node.
+ *
+ * @node: device tree node with the max link speed information
+ *
+ * Returns the associated max link speed from DT, or a negative value if the
+ * required property is not found or is invalid.
+ */
+int of_pci_get_max_link_speed(struct device_node *node)
+{
+	u32 max_link_speed;
+
+	if (of_property_read_u32(node, "max-link-speed", &max_link_speed) ||
+	    max_link_speed > 4)
+		return -EINVAL;
+
+	return max_link_speed;
+}
+EXPORT_SYMBOL_GPL(of_pci_get_max_link_speed);
-- 
2.17.1
