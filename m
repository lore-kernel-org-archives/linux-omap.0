From: Benoit Cousson <b-cousson@ti.com>
Subject: [PATCH 04/13] mfd: twl-core: Add initial DT support for twl4030/twl6030
Date: Thu, 1 Sep 2011 19:21:20 +0200
Message-ID: <1314897689-17791-5-git-send-email-b-cousson@ti.com>
References: <1314897689-17791-1-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:38033 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756057Ab1IARWk (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 1 Sep 2011 13:22:40 -0400
In-Reply-To: <1314897689-17791-1-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: grant.likely@secretlab.ca, tony@atomide.com
Cc: linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, manjugk@ti.com, Benoit Cousson <b-cousson@ti.com>, Balaji T K <balajitk@ti.com>, Graeme Gregory <gg@slimlogic.co.uk>, Samuel Ortiz <sameo@linux.intel.com>

Add initial device-tree support for twl familly chips.
The current version is missing the regulator entries due
to the lack of DT regulator bindings for the moment.
Only the simple sub-modules that do not depend on
platform_data information can be initialized properly.

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Cc: Balaji T K <balajitk@ti.com>
Cc: Graeme Gregory <gg@slimlogic.co.uk>
Cc: Samuel Ortiz <sameo@linux.intel.com>
---
 drivers/mfd/twl-core.c |   99 ++++++++++++++++++++++++++++++++++++++++++++++--
 1 files changed, 95 insertions(+), 4 deletions(-)

diff --git a/drivers/mfd/twl-core.c b/drivers/mfd/twl-core.c
index 01ecfee..a12af12 100644
--- a/drivers/mfd/twl-core.c
+++ b/drivers/mfd/twl-core.c
@@ -33,6 +33,9 @@
 #include <linux/platform_device.h>
 #include <linux/clk.h>
 #include <linux/err.h>
+#include <linux/slab.h>
+#include <linux/of_irq.h>
+#include <linux/irqdomain.h>
 
 #include <linux/regulator/machine.h>
 
@@ -633,6 +636,55 @@ add_regulator(int num, struct regulator_init_data *pdata,
 	return add_regulator_linked(num, pdata, NULL, 0, features);
 }
 
+#ifdef CONFIG_OF
+#define MODALIAS_SIZE 32
+
+static int add_of_children(struct i2c_client *client, unsigned long features)
+{
+	u32 reg;
+	struct device *child, *dev = &client->dev;
+	struct device_node *node, *parent = client->dev.of_node;
+	int irq;
+	char alias[MODALIAS_SIZE];
+
+	for_each_child_of_node(parent, node) {
+		if (of_property_read_u32(node, "reg", &reg)) {
+			dev_err(dev, "%s(): invalid reg on %s\n", __func__,
+				node->full_name);
+			continue;
+		}
+
+		irq = irq_of_parse_and_map(node, 0);
+
+		if (of_modalias_node(node, alias, MODALIAS_SIZE)) {
+			dev_err(dev, "%s(): modalias failure on %s\n", __func__,
+				node->full_name);
+			continue;
+		}
+
+		if (of_device_is_compatible(node, "ti,twl_reg")) {
+			dev_dbg(dev, " %s(): add_regulator\n", __func__);
+			child = NULL;
+		} else {
+			dev_dbg(dev, " %s(): add_child\n", __func__);
+			child = add_child(reg, alias, NULL, 0, true, irq, 0);
+		}
+
+		if (IS_ERR(child)) {
+			dev_err(dev, " %s(): add_child failed: %ld\n", __func__,
+				PTR_ERR(child));
+			continue;
+		}
+	}
+	return 0;
+}
+#else
+static int add_of_children(struct device_node *parent, unsigned long features)
+{
+	return 0;
+}
+#endif
+
 /*
  * NOTE:  We know the first 8 IRQs after pdata->base_irq are
  * for the PIH, and the next are for the PWR_INT SIH, since
@@ -1182,22 +1234,53 @@ twl_probe(struct i2c_client *client, const struct i2c_device_id *id)
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
@@ -1269,10 +1352,18 @@ twl_probe(struct i2c_client *client, const struct i2c_device_id *id)
 		twl_i2c_write_u8(TWL4030_MODULE_INTBR, temp, REG_GPPUPDCTR1);
 	}
 
-	status = add_children(pdata, id->driver_data);
+	if (node)
+		status = add_of_children(client, id->driver_data);
+	else
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

