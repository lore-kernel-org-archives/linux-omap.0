From: Rajendra Nayak <rnayak@ti.com>
Subject: [RFC PATCH 11/11] DT: regulator: register regulators as platform devices
Date: Thu, 15 Sep 2011 16:52:07 +0530
Message-ID: <1316085727-15023-12-git-send-email-rnayak@ti.com>
References: <1316085727-15023-1-git-send-email-rnayak@ti.com>
 <1316085727-15023-2-git-send-email-rnayak@ti.com>
 <1316085727-15023-3-git-send-email-rnayak@ti.com>
 <1316085727-15023-4-git-send-email-rnayak@ti.com>
 <1316085727-15023-5-git-send-email-rnayak@ti.com>
 <1316085727-15023-6-git-send-email-rnayak@ti.com>
 <1316085727-15023-7-git-send-email-rnayak@ti.com>
 <1316085727-15023-8-git-send-email-rnayak@ti.com>
 <1316085727-15023-9-git-send-email-rnayak@ti.com>
 <1316085727-15023-10-git-send-email-rnayak@ti.com>
 <1316085727-15023-11-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:59765 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933293Ab1IOLWj (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 15 Sep 2011 07:22:39 -0400
In-Reply-To: <1316085727-15023-11-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: broonie@opensource.wolfsonmicro.com, grant.likely@secretlab.ca
Cc: devicetree-discuss@lists.ozlabs.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com, lrg@ti.com, b-cousson@ti.com, Rajendra Nayak <rnayak@ti.com>

of_regulator_register_devices() registers all regulators
as platform devices. Use this to register all twl regulators
from the twl driver probe.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 drivers/mfd/twl-core.c       |    3 +++
 drivers/of/of_regulator.c    |   30 ++++++++++++++++++++++++++++++
 include/linux/of_regulator.h |    5 +++++
 3 files changed, 38 insertions(+), 0 deletions(-)

diff --git a/drivers/mfd/twl-core.c b/drivers/mfd/twl-core.c
index a12af12..f210e28 100644
--- a/drivers/mfd/twl-core.c
+++ b/drivers/mfd/twl-core.c
@@ -36,6 +36,7 @@
 #include <linux/slab.h>
 #include <linux/of_irq.h>
 #include <linux/irqdomain.h>
+#include <linux/of_regulator.h>
 
 #include <linux/regulator/machine.h>
 
@@ -1357,6 +1358,8 @@ twl_probe(struct i2c_client *client, const struct i2c_device_id *id)
 	else
 		status = add_children(pdata, id->driver_data);
 
+	of_regulator_register_devices(node);
+
 fail:
 	if (status < 0)
 		twl_remove(client);
diff --git a/drivers/of/of_regulator.c b/drivers/of/of_regulator.c
index 6f8fd4e..0312a6a 100644
--- a/drivers/of/of_regulator.c
+++ b/drivers/of/of_regulator.c
@@ -12,6 +12,7 @@
 
 #include <linux/slab.h>
 #include <linux/of.h>
+#include <linux/of_platform.h>
 #include <linux/regulator/machine.h>
 #include <linux/regulator/fixed.h>
 
@@ -151,3 +152,32 @@ struct device_node *of_get_regulator(struct device *dev, const char *supply)
 	return regnode;
 }
 EXPORT_SYMBOL(of_get_regulator);
+
+/**
+ * of_regulator_register_devices - Register regulator devices to platform bus
+ * @np:	Parent device node with regulator child nodes
+ *
+ * Registers all the regulator and regulator-fixed nodes as platform devices
+ *
+ */
+void of_regulator_register_devices(struct device_node *np)
+{
+	struct device_node *child;
+	struct platform_device *dev;
+
+	for_each_child_of_node(np, child) {
+		if (of_device_is_compatible(child, "regulator")
+			|| of_device_is_compatible(child, "regulator-fixed")) {
+			dev = of_device_alloc(child, NULL, NULL);
+			if (!dev)
+				return;
+			dev->dev.bus = &platform_bus_type;
+			if (of_device_add(dev) != 0) {
+				platform_device_put(dev);
+				return;
+			}
+		}
+	}
+	return;
+}
+
diff --git a/include/linux/of_regulator.h b/include/linux/of_regulator.h
index 5fc7329..38cf7e3 100644
--- a/include/linux/of_regulator.h
+++ b/include/linux/of_regulator.h
@@ -15,6 +15,7 @@ extern struct fixed_voltage_config
 	*of_get_fixed_voltage_config(struct device_node *np);
 extern struct device_node *of_get_regulator(struct device *dev,
 	const char *id);
+extern void of_regulator_register_devices(struct device_node *np);
 #else
 static inline struct regulator_init_data
 	*of_get_regulator_init_data(struct device_node *np)
@@ -31,6 +32,10 @@ static inline struct device_node *of_get_regulator(struct device *dev,
 {
 	return NULL;
 }
+static inline void of_regulator_register_devices(struct device_node *np)
+{
+	return NULL;
+}
 #endif /* CONFIG_OF_REGULATOR */
 
 #endif /* __LINUX_OF_REG_H */
-- 
1.7.1

