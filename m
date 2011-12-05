From: Benoit Cousson <b-cousson@ti.com>
Subject: [PATCH 2/3] of/address: Add reg-names property to name an iomem resource
Date: Mon, 5 Dec 2011 15:23:55 +0100
Message-ID: <1323095036-3739-3-git-send-email-b-cousson@ti.com>
References: <1323095036-3739-1-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:45737 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932176Ab1LEOYx (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 5 Dec 2011 09:24:53 -0500
In-Reply-To: <1323095036-3739-1-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: grant.likely@secretlab.ca, rob.herring@calxeda.com, devicetree-discuss@lists.ozlabs.org
Cc: tony@atomide.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Benoit Cousson <b-cousson@ti.com>

In a HW system, resources in general have name to identify them.
The is the case as well for IOMEM resources filled by DT "reg" entries.
The current DT mechanism is relying on the "reg" order to identify
the proper resource. This is error prone and not the natural way to
retrieve an information in general.
Moreover, the Linux resource system does support a name and an API to
allow a driver to retrieve the resource using the name instead of an
index.

Add a reg-names property to allow the possiblity to provide a name
to any reg entries.
If the name is available, use it to name the resource, otherwise
keep the legacy device name.

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Cc: Grant Likely <grant.likely@secretlab.ca>
Cc: Rob Herring <rob.herring@calxeda.com>
---
 Documentation/devicetree/bindings/reg-names.txt |   48 +++++++++++++++++++++++
 drivers/of/address.c                            |   16 +++++--
 2 files changed, 59 insertions(+), 5 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/reg-names.txt

diff --git a/Documentation/devicetree/bindings/reg-names.txt b/Documentation/devicetree/bindings/reg-names.txt
new file mode 100644
index 0000000..5554065
--- /dev/null
+++ b/Documentation/devicetree/bindings/reg-names.txt
@@ -0,0 +1,48 @@
+reg-names property
+
+In a HW system, resources in general have name to identify them.
+The is the case as well for register entries.
+The current DT mechanism is relying on the "reg" order to identify
+the proper resource. The reg-names is adding the possiblity to
+provide a name to reg entries.
+
+Usage:
+
+This attribute must be used along with a regular reg entry. If not
+it will be simply ignored.
+The number of entry must match otherwise the default device name will
+be used to as the resource name.
+
+
+Example:
+
+
+l4-abe {
+	compatible = "simple-bus";
+	#address-cells = <2>;
+	#size-cells = <1>;
+	ranges = <0 0 0x48000000 0x00001000>, /* MPU path */
+		 <1 0 0x49000000 0x00001000>; /* L3 path */
+	mcasp {
+		compatible = "ti,mcasp";
+		reg = <0 0x10 0x10>, <0 0x20 0x10>,
+		      <1 0x10 0x10>, <1 0x20 0x10>;
+		reg-names = "mpu", "dat",
+			    "dma", "dma_dat";
+	};
+
+	timer {
+		compatible = "ti,timer";
+		reg = <0 0x40 0x10>, <1 0x40 0x10>;
+		reg-names = "mpu", "dma";
+	};
+};
+
+
+usb {
+	compatible = "ti,usb-host";
+	reg = <0x4a064000 0x800>, <0x4a064800 0x200>,
+	      <0x4a064c00 0x200>;
+	reg-names = "config", "ohci", "ehci";
+};
+
diff --git a/drivers/of/address.c b/drivers/of/address.c
index 72c33fb..66d96f1 100644
--- a/drivers/of/address.c
+++ b/drivers/of/address.c
@@ -14,7 +14,7 @@
 static struct of_bus *of_match_bus(struct device_node *np);
 static int __of_address_to_resource(struct device_node *dev,
 		const __be32 *addrp, u64 size, unsigned int flags,
-				    struct resource *r);
+		const char *name, struct resource *r);
 
 /* Debug utility */
 #ifdef DEBUG
@@ -215,7 +215,7 @@ int of_pci_address_to_resource(struct device_node *dev, int bar,
 	addrp = of_get_pci_address(dev, bar, &size, &flags);
 	if (addrp == NULL)
 		return -EINVAL;
-	return __of_address_to_resource(dev, addrp, size, flags, r);
+	return __of_address_to_resource(dev, addrp, size, flags, NULL, r);
 }
 EXPORT_SYMBOL_GPL(of_pci_address_to_resource);
 #endif /* CONFIG_PCI */
@@ -529,7 +529,7 @@ EXPORT_SYMBOL(of_get_address);
 
 static int __of_address_to_resource(struct device_node *dev,
 		const __be32 *addrp, u64 size, unsigned int flags,
-				    struct resource *r)
+		const char *name, struct resource *r)
 {
 	u64 taddr;
 
@@ -551,7 +551,8 @@ static int __of_address_to_resource(struct device_node *dev,
 		r->end = taddr + size - 1;
 	}
 	r->flags = flags;
-	r->name = dev->full_name;
+	r->name = name ? name : dev->full_name;
+
 	return 0;
 }
 
@@ -569,11 +570,16 @@ int of_address_to_resource(struct device_node *dev, int index,
 	const __be32	*addrp;
 	u64		size;
 	unsigned int	flags;
+	const char	*name = NULL;
 
 	addrp = of_get_address(dev, index, &size, &flags);
 	if (addrp == NULL)
 		return -EINVAL;
-	return __of_address_to_resource(dev, addrp, size, flags, r);
+
+	/* Get optional "reg-names" property to add a name to a resource */
+	of_property_read_string_index(dev, "reg-names",	index, &name);
+
+	return __of_address_to_resource(dev, addrp, size, flags, name, r);
 }
 EXPORT_SYMBOL_GPL(of_address_to_resource);
 
-- 
1.7.0.4

