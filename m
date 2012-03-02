From: Benoit Cousson <b-cousson@ti.com>
Subject: [PATCH 07/12] mfd: twl-*: Replace pr_ macros by the dev_ equivalent and do various cleanups
Date: Fri, 2 Mar 2012 21:33:44 +0100
Message-ID: <1330720424-30225-1-git-send-email-b-cousson@ti.com>
References: <1330707024-23730-1-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:56932 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752813Ab2CBUd5 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 2 Mar 2012 15:33:57 -0500
In-Reply-To: <1330707024-23730-1-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: sameo@linux.intel.com, tony@atomide.com, grant.likely@secretlab.ca
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Benoit Cousson <b-cousson@ti.com>, Felipe Balbi <balbi@ti.com>

Since a structure device is available now, use the dev_ macros instead
of the pr_ ones.

Clean some badly formatted comments.
Remove some unused variables.
Move some variable to the place they belong.
Clean some badly wrapped lines.
Align variable definition
Add missing braces in if-then-else block.
Add blank line for better readability.
Move stuff here and there...

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Cc: Felipe Balbi <balbi@ti.com>
---
 drivers/mfd/twl-core.c    |   32 ++++++++++++++++++--------------
 drivers/mfd/twl4030-irq.c |   23 +++++++++++------------
 drivers/mfd/twl6030-irq.c |   39 +++++++++++++++++++--------------------
 3 files changed, 48 insertions(+), 46 deletions(-)

diff --git a/drivers/mfd/twl-core.c b/drivers/mfd/twl-core.c
index 1c1b7d1..9bf14ef 100644
--- a/drivers/mfd/twl-core.c
+++ b/drivers/mfd/twl-core.c
@@ -1174,17 +1174,15 @@ static int twl_remove(struct i2c_client *client)
 	return 0;
 }
 
-/* NOTE:  this driver only handles a single twl4030/tps659x0 chip */
+/* NOTE: This driver only handles a single twl4030/tps659x0 chip */
 static int __devinit
 twl_probe(struct i2c_client *client, const struct i2c_device_id *id)
 {
-	int				irq_base;
-	int				status;
-	unsigned			i;
 	struct twl4030_platform_data	*pdata = client->dev.platform_data;
 	struct device_node		*node = client->dev.of_node;
-	u8 temp;
-	int ret = 0;
+	int				irq_base = 0;
+	int				status;
+	unsigned			i;
 
 	if (node && !pdata) {
 		/*
@@ -1214,12 +1212,12 @@ twl_probe(struct i2c_client *client, const struct i2c_device_id *id)
 	}
 
 	for (i = 0; i < TWL_NUM_SLAVES; i++) {
-		struct twl_client	*twl = &twl_modules[i];
+		struct twl_client *twl = &twl_modules[i];
 
 		twl->address = client->addr + i;
-		if (i == 0)
+		if (i == 0) {
 			twl->client = client;
-		else {
+		} else {
 			twl->client = i2c_new_dummy(client->adapter,
 					twl->address);
 			if (!twl->client) {
@@ -1231,7 +1229,9 @@ twl_probe(struct i2c_client *client, const struct i2c_device_id *id)
 		}
 		mutex_init(&twl->xfer_lock);
 	}
+
 	inuse = true;
+
 	if ((id->driver_data) & TWL6030_CLASS) {
 		twl_id = TWL6030_CLASS_ID;
 		twl_map = &twl6030_map[0];
@@ -1245,8 +1245,8 @@ twl_probe(struct i2c_client *client, const struct i2c_device_id *id)
 
 	/* read TWL IDCODE Register */
 	if (twl_id == TWL4030_CLASS_ID) {
-		ret = twl_read_idcode_register();
-		WARN(ret < 0, "Error: reading twl_idcode register value\n");
+		status = twl_read_idcode_register();
+		WARN(status < 0, "Error: reading twl_idcode register value\n");
 	}
 
 	/* load power event scripts */
@@ -1268,19 +1268,22 @@ twl_probe(struct i2c_client *client, const struct i2c_device_id *id)
 		}
 	}
 
-	/* Disable TWL4030/TWL5030 I2C Pull-up on I2C1 and I2C4(SR) interface.
+	/*
+	 * Disable TWL4030/TWL5030 I2C Pull-up on I2C1 and I2C4(SR) interface.
 	 * Program I2C_SCL_CTRL_PU(bit 0)=0, I2C_SDA_CTRL_PU (bit 2)=0,
 	 * SR_I2C_SCL_CTRL_PU(bit 4)=0 and SR_I2C_SDA_CTRL_PU(bit 6)=0.
 	 */
-
 	if (twl_class_is_4030()) {
+		u8 temp;
+
 		twl_i2c_read_u8(TWL4030_MODULE_INTBR, &temp, REG_GPPUPDCTR1);
 		temp &= ~(SR_I2C_SDA_CTRL_PU | SR_I2C_SCL_CTRL_PU | \
-		I2C_SDA_CTRL_PU | I2C_SCL_CTRL_PU);
+			I2C_SDA_CTRL_PU | I2C_SCL_CTRL_PU);
 		twl_i2c_write_u8(TWL4030_MODULE_INTBR, temp, REG_GPPUPDCTR1);
 	}
 
 	status = -ENODEV;
+
 	if (node)
 		status = of_platform_populate(node, NULL, NULL, &client->dev);
 	if (status)
@@ -1289,6 +1292,7 @@ twl_probe(struct i2c_client *client, const struct i2c_device_id *id)
 fail:
 	if (status < 0)
 		twl_remove(client);
+
 	return status;
 }
 
diff --git a/drivers/mfd/twl4030-irq.c b/drivers/mfd/twl4030-irq.c
index e6dc8f9..e523499 100644
--- a/drivers/mfd/twl4030-irq.c
+++ b/drivers/mfd/twl4030-irq.c
@@ -32,7 +32,6 @@
 #include <linux/interrupt.h>
 #include <linux/irq.h>
 #include <linux/slab.h>
-
 #include <linux/of.h>
 #include <linux/irqdomain.h>
 #include <linux/i2c/twl.h>
@@ -625,7 +624,8 @@ static irqreturn_t handle_twl4030_sih(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
-/* returns the first IRQ used by this SIH bank,
+/*
+ * returns the first IRQ used by this SIH bank,
  * or negative errno
  */
 int twl4030_sih_setup(struct device *dev, int module, int irq_base)
@@ -637,14 +637,14 @@ int twl4030_sih_setup(struct device *dev, int module, int irq_base)
 	int			status = -EINVAL;
 
 	/* only support modules with standard clear-on-read for now */
-	for (sih_mod = 0, sih = sih_modules;
-			sih_mod < nr_sih_modules;
+	for (sih_mod = 0, sih = sih_modules; sih_mod < nr_sih_modules;
 			sih_mod++, sih++) {
 		if (sih->module == module && sih->set_cor) {
 			status = 0;
 			break;
 		}
 	}
+
 	if (status < 0)
 		return status;
 
@@ -674,7 +674,7 @@ int twl4030_sih_setup(struct device *dev, int module, int irq_base)
 	status = request_threaded_irq(irq, NULL, handle_twl4030_sih, 0,
 				      agent->irq_name ?: sih->name, NULL);
 
-	pr_info("twl4030: %s (irq %d) chaining IRQs %d..%d\n", sih->name,
+	dev_info(dev, "%s (irq %d) chaining IRQs %d..%d\n", sih->name,
 			irq, irq_base, irq_base + i - 1);
 
 	return status < 0 ? status : irq_base;
@@ -691,12 +691,10 @@ int twl4030_sih_setup(struct device *dev, int module, int irq_base)
 int twl4030_init_irq(struct device *dev, int irq_num)
 {
 	static struct irq_chip	twl4030_irq_chip;
+	int			status, i;
 	int			irq_base, irq_end, nr_irqs;
 	struct			device_node *node = dev->of_node;
 
-	int			status;
-	int			i;
-
 	/*
 	 * TWL core and pwr interrupts must be contiguous because
 	 * the hwirqs numbers are defined contiguously from 1 to 15.
@@ -725,7 +723,8 @@ int twl4030_init_irq(struct device *dev, int irq_num)
 
 	twl4030_irq_base = irq_base;
 
-	/* install an irq handler for each of the SIH modules;
+	/*
+	 * Install an irq handler for each of the SIH modules;
 	 * clone dummy irq_chip since PIH can't *do* anything
 	 */
 	twl4030_irq_chip = dummy_irq_chip;
@@ -740,13 +739,13 @@ int twl4030_init_irq(struct device *dev, int irq_num)
 		activate_irq(i);
 	}
 
-	pr_info("twl4030: %s (irq %d) chaining IRQs %d..%d\n", "PIH",
+	dev_info(dev, "%s (irq %d) chaining IRQs %d..%d\n", "PIH",
 			irq_num, irq_base, irq_end);
 
 	/* ... and the PWR_INT module ... */
 	status = twl4030_sih_setup(dev, TWL4030_MODULE_INT, irq_end);
 	if (status < 0) {
-		pr_err("twl4030: sih_setup PWR INT --> %d\n", status);
+		dev_err(dev, "sih_setup PWR INT --> %d\n", status);
 		goto fail;
 	}
 
@@ -755,7 +754,7 @@ int twl4030_init_irq(struct device *dev, int irq_num)
 				      IRQF_ONESHOT,
 				      "TWL4030-PIH", NULL);
 	if (status < 0) {
-		pr_err("twl4030: could not claim irq%d: %d\n", irq_num, status);
+		dev_err(dev, "could not claim irq%d: %d\n", irq_num, status);
 		goto fail_rqirq;
 	}
 
diff --git a/drivers/mfd/twl6030-irq.c b/drivers/mfd/twl6030-irq.c
index b4d5e0e..a1c7183 100644
--- a/drivers/mfd/twl6030-irq.c
+++ b/drivers/mfd/twl6030-irq.c
@@ -53,7 +53,6 @@
  *
  * We set up IRQs starting at a platform-specified base. An interrupt map table,
  * specifies mapping between interrupt number and the associated module.
- *
  */
 #define TWL6030_NR_IRQS    20
 
@@ -342,14 +341,11 @@ int twl6030_init_irq(struct device *dev, int irq_num)
 {
 	struct			device_node *node = dev->of_node;
 	int			nr_irqs, irq_base, irq_end;
-
-	int	status = 0;
-	int	i;
 	struct task_struct	*task;
-	int ret;
-	u8 mask[4];
-
-	static struct irq_chip	twl6030_irq_chip;
+	static struct irq_chip  twl6030_irq_chip;
+	int			status = 0;
+	int			i;
+	u8			mask[4];
 
 	nr_irqs = TWL6030_NR_IRQS;
 
@@ -367,16 +363,18 @@ int twl6030_init_irq(struct device *dev, int irq_num)
 	mask[1] = 0xFF;
 	mask[2] = 0xFF;
 	mask[3] = 0xFF;
-	ret = twl_i2c_write(TWL_MODULE_PIH, &mask[0],
-			REG_INT_MSK_LINE_A, 3); /* MASK ALL INT LINES */
-	ret = twl_i2c_write(TWL_MODULE_PIH, &mask[0],
-			REG_INT_MSK_STS_A, 3); /* MASK ALL INT STS */
-	ret = twl_i2c_write(TWL_MODULE_PIH, &mask[0],
-			REG_INT_STS_A, 3); /* clear INT_STS_A,B,C */
+
+	/* mask all int lines */
+	twl_i2c_write(TWL_MODULE_PIH, &mask[0], REG_INT_MSK_LINE_A, 3);
+	/* mask all int sts */
+	twl_i2c_write(TWL_MODULE_PIH, &mask[0], REG_INT_MSK_STS_A, 3);
+	/* clear INT_STS_A,B,C */
+	twl_i2c_write(TWL_MODULE_PIH, &mask[0], REG_INT_STS_A, 3);
 
 	twl6030_irq_base = irq_base;
 
-	/* install an irq handler for each of the modules;
+	/*
+	 * install an irq handler for each of the modules;
 	 * clone dummy irq_chip since PIH can't *do* anything
 	 */
 	twl6030_irq_chip = dummy_irq_chip;
@@ -391,22 +389,22 @@ int twl6030_init_irq(struct device *dev, int irq_num)
 		activate_irq(i);
 	}
 
-	pr_info("twl6030: %s (irq %d) chaining IRQs %d..%d\n", "PIH",
+	dev_info(dev, "PIH (irq %d) chaining IRQs %d..%d\n",
 			irq_num, irq_base, irq_end);
 
 	/* install an irq handler to demultiplex the TWL6030 interrupt */
 	init_completion(&irq_event);
 
-	status = request_irq(irq_num, handle_twl6030_pih, 0,
-				"TWL6030-PIH", &irq_event);
+	status = request_irq(irq_num, handle_twl6030_pih, 0, "TWL6030-PIH",
+			     &irq_event);
 	if (status < 0) {
-		pr_err("twl6030: could not claim irq%d: %d\n", irq_num, status);
+		dev_err(dev, "could not claim irq %d: %d\n", irq_num, status);
 		goto fail_irq;
 	}
 
 	task = kthread_run(twl6030_irq_thread, (void *)irq_num, "twl6030-irq");
 	if (IS_ERR(task)) {
-		pr_err("twl6030: could not create irq %d thread!\n", irq_num);
+		dev_err(dev, "could not create irq %d thread!\n", irq_num);
 		status = PTR_ERR(task);
 		goto fail_kthread;
 	}
@@ -421,6 +419,7 @@ fail_kthread:
 fail_irq:
 	for (i = irq_base; i < irq_end; i++)
 		irq_set_chip_and_handler(i, NULL, NULL);
+
 	return status;
 }
 
-- 
1.7.0.4

