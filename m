From: Benoit Cousson <b-cousson@ti.com>
Subject: [PATCH v2 03/10] mfd: twl-core: Add initial DT support for twl4030/twl6030
Date: Fri, 9 Dec 2011 15:02:34 +0100
Message-ID: <1323439361-1647-4-git-send-email-b-cousson@ti.com>
References: <1323439361-1647-1-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:53466 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753443Ab1LIODZ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 9 Dec 2011 09:03:25 -0500
In-Reply-To: <1323439361-1647-1-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, rob.herring@calxeda.com
Cc: devicetree-discuss@lists.ozlabs.org, grant.likely@secretlab.ca, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Benoit Cousson <b-cousson@ti.com>, Balaji T K <balajitk@ti.com>, Graeme Gregory <gg@slimlogic.co.uk>, Samuel Ortiz <sameo@linux.intel.com>

Add initial device-tree support for twl familly chips.
The current version is missing the regulator entries due
to the lack of DT regulator bindings for the moment.
Only the simple sub-modules that do not depend on
platform_data information can be initialized properly.

Add documentation for the Texas Instruments TWL Integrated Chip.

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Cc: Balaji T K <balajitk@ti.com>
Cc: Graeme Gregory <gg@slimlogic.co.uk>
Cc: Samuel Ortiz <sameo@linux.intel.com>
---
 .../devicetree/bindings/mfd/twl-familly.txt        |   47 +++++++++++++++++
 drivers/mfd/twl-core.c                             |   53 ++++++++++++++++++--
 2 files changed, 96 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mfd/twl-familly.txt

diff --git a/Documentation/devicetree/bindings/mfd/twl-familly.txt b/Documentation/devicetree/bindings/mfd/twl-familly.txt
new file mode 100644
index 0000000..ff4cacd
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/twl-familly.txt
@@ -0,0 +1,47 @@
+Texas Instruments TWL family
+
+The TWLs are Integrated Power Management Chips.
+Some version might contain much more analog function like
+USB transceiver or Audio amplifier.
+These chips are connected to an i2c bus.
+
+
+Required properties:
+- compatible : Must be "ti,twl4030";
+  For Integrated power-management/audio CODEC device used in OMAP3
+  based boards
+- compatible : Must be "ti,twl6030";
+  For Integrated power-management used in OMAP4 based boards
+- interrupts : This i2c device has an IRQ line connected to the main SoC
+- interrupt-controller : Since the twl support several interrupts internally,
+  it is considered as an interrupt controller cascaded to the SoC one.
+- #interrupt-cells = <1>;
+- interrupt-parent : The parent interrupt controller.
+
+Optional node:
+- Child nodes contain in the twl. The twl family is made of severals variants
+  that support a different number of features.
+  The children nodes will thus depend of the capabilty of the variant.
+
+
+Example:
+/*
+ * Integrated Power Management Chip
+ * http://www.ti.com/lit/ds/symlink/twl6030.pdf
+ */
+twl@48 {
+    compatible = "ti,twl6030";
+    reg = <0x48>;
+    interrupts = <39>; /* IRQ_SYS_1N cascaded to gic */
+    interrupt-controller;
+    #interrupt-cells = <1>;
+    interrupt-parent = <&gic>;
+    #address-cells = <1>;
+    #size-cells = <0>;
+
+    twl_rtc {
+        compatible = "ti,twl_rtc";
+        interrupts = <11>;
+        reg = <0>;
+    };
+};
diff --git a/drivers/mfd/twl-core.c b/drivers/mfd/twl-core.c
index bfbd660..524d9d8 100644
--- a/drivers/mfd/twl-core.c
+++ b/drivers/mfd/twl-core.c
@@ -34,6 +34,10 @@
 #include <linux/platform_device.h>
 #include <linux/clk.h>
 #include <linux/err.h>
+#include <linux/slab.h>
+#include <linux/of_irq.h>
+#include <linux/of_platform.h>
+#include <linux/irqdomain.h>
 
 #include <linux/regulator/machine.h>
 
@@ -1183,22 +1187,53 @@ twl_probe(struct i2c_client *client, const struct i2c_device_id *id)
 	int				status;
 	unsigned			i;
 	struct twl4030_platform_data	*pdata = client->dev.platform_data;
+	struct device_node		*node = client->dev.of_node;
 	u8 temp;
 	int ret = 0;
 
+	if (node && !pdata) {
+		/*
+		 * XXX: Temporary fake pdata until the information
+		 * is correctly retrieved by every TWL modules from DT.
+		 */
+		pdata = kzalloc(sizeof(struct twl4030_platform_data),
+				GFP_KERNEL);
+		if (!pdata) {
+			status = -ENOMEM;
+			goto exit;
+		}
+
+		/*
+		 * XXX: For the moment the IRQs for TWL seems to be encoded in
+		 * the global OMAP space. That should be cleaned to allow
+		 * dynamically adding a new IRQ controller.
+		 */
+		if ((id->driver_data) & TWL6030_CLASS) {
+			pdata->irq_base = TWL6030_IRQ_BASE;
+			pdata->irq_end = pdata->irq_base + TWL6030_BASE_NR_IRQS;
+		} else {
+			pdata->irq_base = TWL4030_IRQ_BASE;
+			pdata->irq_end = pdata->irq_base + TWL4030_BASE_NR_IRQS;
+		}
+		irq_domain_add_simple(node, pdata->irq_base);
+	}
+
 	if (!pdata) {
 		dev_dbg(&client->dev, "no platform data?\n");
-		return -EINVAL;
+		status = -EINVAL;
+		goto fail_free;
 	}
 
 	if (i2c_check_functionality(client->adapter, I2C_FUNC_I2C) == 0) {
 		dev_dbg(&client->dev, "can't talk I2C?\n");
-		return -EIO;
+		status = -EIO;
+		goto fail_free;
 	}
 
 	if (inuse) {
 		dev_dbg(&client->dev, "driver is already in use\n");
-		return -EBUSY;
+		status = -EBUSY;
+		goto fail_free;
 	}
 
 	for (i = 0; i < TWL_NUM_SLAVES; i++) {
@@ -1270,10 +1305,20 @@ twl_probe(struct i2c_client *client, const struct i2c_device_id *id)
 		twl_i2c_write_u8(TWL4030_MODULE_INTBR, temp, REG_GPPUPDCTR1);
 	}
 
-	status = add_children(pdata, id->driver_data);
+#ifdef CONFIG_OF_DEVICE
+	if (node)
+		status = of_platform_populate(node, NULL, NULL, &client->dev);
+	else
+#endif
+		status = add_children(pdata, id->driver_data);
+
 fail:
 	if (status < 0)
 		twl_remove(client);
+fail_free:
+	if (node)
+		kfree(pdata);
+exit:
 	return status;
 }
 
-- 
1.7.0.4

