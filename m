From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 01/12] bus: ti-sysc: Add fck clock alias for children with
 notifier_block
Date: Fri, 23 Feb 2018 13:00:49 -0800
Message-ID: <20180223210100.86732-2-tony@atomide.com>
References: <20180223210100.86732-1-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180223210100.86732-1-tony@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-omap@vger.kernel.org
Cc: Nishanth Menon <nm@ti.com>, Dave Gerlach <d-gerlach@ti.com>, linux-kernel@vger.kernel.org, Tero Kristo <t-kristo@ti.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

The functional clock is used by several child device drivers to query
the rate for the child device internal configuration. The functional
clock is really for the whole interconnect target module, and not just
for the child device, and can also be shared across multiple children.
At least the timers, i2c and mmc driver query the fck for rate.

So let's just create a clock alias for the child fck if it does not
yet exits. We can do this with the BUS_NOTIFY_ADD_DEVICE before the
child is probed.

Note that we need to now also remove the legacy mode check for getting
the dts clocks in ti-sysc driver.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/bus/ti-sysc.c | 91 ++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 87 insertions(+), 4 deletions(-)

diff --git a/drivers/bus/ti-sysc.c b/drivers/bus/ti-sysc.c
--- a/drivers/bus/ti-sysc.c
+++ b/drivers/bus/ti-sysc.c
@@ -13,11 +13,14 @@
 
 #include <linux/io.h>
 #include <linux/clk.h>
+#include <linux/clkdev.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/of_address.h>
 #include <linux/of_platform.h>
+#include <linux/slab.h>
+
 #include <linux/platform_data/ti-sysc.h>
 
 #include <dt-bindings/bus/ti-sysc.h>
@@ -136,9 +139,6 @@ static int sysc_get_clocks(struct sysc *ddata)
 {
 	int i, error;
 
-	if (ddata->legacy_mode)
-		return 0;
-
 	for (i = 0; i < SYSC_MAX_CLOCKS; i++) {
 		error = sysc_get_one_clock(ddata, i);
 		if (error && error != -ENOENT)
@@ -605,6 +605,74 @@ static int sysc_init_syss_mask(struct sysc *ddata)
 	return 0;
 }
 
+/*
+ * Many child device drivers need to have fck available to get the clock
+ * rate for device internal configuration.
+ */
+static int sysc_child_add_fck(struct sysc *ddata,
+			      struct device *child)
+{
+	struct clk *fck;
+	struct clk_lookup *l;
+	const char *name = clock_names[SYSC_FCK];
+
+	if (IS_ERR_OR_NULL(ddata->clocks[SYSC_FCK]))
+		return 0;
+
+	fck = clk_get(child, name);
+	if (!IS_ERR(fck)) {
+		clk_put(fck);
+
+		return -EEXIST;
+	}
+
+	l = clkdev_create(ddata->clocks[SYSC_FCK], name, dev_name(child));
+
+	return l ? 0 : -ENODEV;
+}
+
+static struct device_type sysc_device_type = {
+};
+
+static struct sysc *sysc_child_to_parent(struct device *dev)
+{
+	struct device *parent = dev->parent;
+
+	if (!parent || parent->type != &sysc_device_type)
+		return NULL;
+
+	return dev_get_drvdata(parent);
+}
+
+static int sysc_notifier_call(struct notifier_block *nb,
+			      unsigned long event, void *device)
+{
+	struct device *dev = device;
+	struct sysc *ddata;
+	int error;
+
+	ddata = sysc_child_to_parent(dev);
+	if (!ddata)
+		return NOTIFY_DONE;
+
+	switch (event) {
+	case BUS_NOTIFY_ADD_DEVICE:
+		error = sysc_child_add_fck(ddata, dev);
+		if (error && error != -EEXIST)
+			dev_warn(ddata->dev, "could not add %s fck: %i\n",
+				 dev_name(dev), error);
+		break;
+	default:
+		break;
+	}
+
+	return NOTIFY_DONE;
+}
+
+static struct notifier_block sysc_nb = {
+	.notifier_call = sysc_notifier_call,
+};
+
 /* Device tree configured quirks */
 struct sysc_dts_quirk {
 	const char *name;
@@ -937,6 +1005,7 @@ static int sysc_probe(struct platform_device *pdev)
 
 	sysc_show_registers(ddata);
 
+	ddata->dev->type = &sysc_device_type;
 	error = of_platform_populate(ddata->dev->of_node,
 				     NULL, NULL, ddata->dev);
 	if (error)
@@ -1008,7 +1077,21 @@ static struct platform_driver sysc_driver = {
 		.pm = &sysc_pm_ops,
 	},
 };
-module_platform_driver(sysc_driver);
+
+static int __init sysc_init(void)
+{
+	bus_register_notifier(&platform_bus_type, &sysc_nb);
+
+	return platform_driver_register(&sysc_driver);
+}
+module_init(sysc_init);
+
+static void __exit sysc_exit(void)
+{
+	bus_unregister_notifier(&platform_bus_type, &sysc_nb);
+	platform_driver_unregister(&sysc_driver);
+}
+module_exit(sysc_exit);
 
 MODULE_DESCRIPTION("TI sysc interconnect target driver");
 MODULE_LICENSE("GPL v2");
-- 
2.16.2
