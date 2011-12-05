From: Benoit Cousson <b-cousson@ti.com>
Subject: [PATCH 3/3] of/irq: Add interrupts-names property to name an irq resource
Date: Mon, 5 Dec 2011 15:23:56 +0100
Message-ID: <1323095036-3739-4-git-send-email-b-cousson@ti.com>
References: <1323095036-3739-1-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:45742 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932176Ab1LEOYy (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 5 Dec 2011 09:24:54 -0500
In-Reply-To: <1323095036-3739-1-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: grant.likely@secretlab.ca, rob.herring@calxeda.com, devicetree-discuss@lists.ozlabs.org
Cc: tony@atomide.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Benoit Cousson <b-cousson@ti.com>

In a HW system, resources in general have name to identify them.
The is the case as well for IORESOURCE_IRQ resources filled by DT
"interrupts" entries.
The current DT mechanism is relying on the "interrupts" order to identify
the proper resource. This is error prone and not the natural way to
retrieve an information in general.
Moreover, the resource does support a name and an API is available to
allow a driver to retrieve the resource using the name instead of an
index.

Add a interrupts-names property to allow the possiblity to provide a name
to any interrupts entries.
If the name is available, use it to name the resource, otherwise
keep the legacy device full name.

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Cc: Grant Likely <grant.likely@secretlab.ca>
Cc: Rob Herring <rob.herring@calxeda.com>
---
 .../devicetree/bindings/interrupts-names.txt       |   50 ++++++++++++++++++++
 drivers/of/irq.c                                   |   11 ++++-
 2 files changed, 60 insertions(+), 1 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/interrupts-names.txt

diff --git a/Documentation/devicetree/bindings/interrupts-names.txt b/Documentation/devicetree/bindings/interrupts-names.txt
new file mode 100644
index 0000000..d9a796d
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupts-names.txt
@@ -0,0 +1,50 @@
+interrupts-names property
+
+In a HW system, physical resources in general have name to identify them.
+The is the case as well for interrupt lines.
+The current DT mechanism is relying on the "interrupts" order to identify
+the proper resource. The interrupts-names is adding the possiblity to
+provide a name to interrupts entries.
+
+Usage:
+
+This attribute must be used along with a regular interrupts entry. If not
+it will be simply ignored.
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
+		interrupts = <11>, <12>;
+		interrupts-names = "rx", "tx";
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
+	interrupts = <14>, <15>;
+	interrupts-names = "ohci", "ehci";
+};
+
diff --git a/drivers/of/irq.c b/drivers/of/irq.c
index 19c0115..604b53f 100644
--- a/drivers/of/irq.c
+++ b/drivers/of/irq.c
@@ -346,9 +346,18 @@ int of_irq_to_resource(struct device_node *dev, int index, struct resource *r)
 	/* Only dereference the resource if both the
 	 * resource and the irq are valid. */
 	if (r && irq != NO_IRQ) {
+		const char *name = NULL;
+
+		/*
+		 * Get optional "interrupts-names" property to add a name
+		 * to the resource.
+		 */
+		of_property_read_string_index(dev, "interrupts-names", index,
+					      &name);
+
 		r->start = r->end = irq;
 		r->flags = IORESOURCE_IRQ;
-		r->name = dev->full_name;
+		r->name = name ? name : dev->full_name;
 	}
 
 	return irq;
-- 
1.7.0.4

