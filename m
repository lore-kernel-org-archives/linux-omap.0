From: Benoit Cousson <b-cousson@ti.com>
Subject: [PATCH 04/12] mfd: twl-core: Move IRQ allocation into twl[4030|6030]-irq files
Date: Fri, 2 Mar 2012 17:50:16 +0100
Message-ID: <1330707024-23730-5-git-send-email-b-cousson@ti.com>
References: <1330707024-23730-1-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:44303 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030333Ab2CBQvW (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 2 Mar 2012 11:51:22 -0500
In-Reply-To: <1330707024-23730-1-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: sameo@linux.intel.com, tony@atomide.com, grant.likely@secretlab.ca
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Benoit Cousson <b-cousson@ti.com>

During DT adaptation, the irq_alloc_desc was added into twl-core, but
due to the rather different and weird IRQ management required by the twl4030,
it is much better to have a different approach for it.
The issue is that twl4030 uses a two level IRQ mechanism but handles all the
PWR interrupts as part of the twl-core interrupt range. It ends up with a
range of 16 interrupts total for CORE and PWR.

The other twl4030 functionalities already have a dedicated driver and thus
their IRQs and irqdomain can and should be defined localy.

twl6030 is using a single level IRQ controller and thus does not require any
trick.

Move the irq_alloc_desc and irq_domain_add_legacy in twl4030-irq and
twl6030-irq.

Allocate together CORE and PWR IRQs for twl4030-irq.

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Acked-by: Felipe Balbi <balbi@ti.com>
---
 drivers/mfd/twl-core.c    |   29 +++++------------------------
 drivers/mfd/twl-core.h    |    4 ++--
 drivers/mfd/twl4030-irq.c |   29 +++++++++++++++++++++++++++--
 drivers/mfd/twl6030-irq.c |   31 ++++++++++++++++++++++---------
 4 files changed, 56 insertions(+), 37 deletions(-)

diff --git a/drivers/mfd/twl-core.c b/drivers/mfd/twl-core.c
index d0f08b0..1c1b7d1 100644
--- a/drivers/mfd/twl-core.c
+++ b/drivers/mfd/twl-core.c
@@ -147,9 +147,6 @@
 
 #define TWL_MODULE_LAST TWL4030_MODULE_LAST
 
-#define TWL4030_NR_IRQS    34 /* core:8, power:8, gpio: 18 */
-#define TWL6030_NR_IRQS    20
-
 /* Base Address defns for twl4030_map[] */
 
 /* subchip/slave 0 - USB ID */
@@ -1182,17 +1179,12 @@ static int __devinit
 twl_probe(struct i2c_client *client, const struct i2c_device_id *id)
 {
 	int				irq_base;
-	int				irq_end;
 	int				status;
 	unsigned			i;
 	struct twl4030_platform_data	*pdata = client->dev.platform_data;
 	struct device_node		*node = client->dev.of_node;
 	u8 temp;
 	int ret = 0;
-	int nr_irqs = TWL4030_NR_IRQS;
-
-	if ((id->driver_data) & TWL6030_CLASS)
-		nr_irqs = TWL6030_NR_IRQS;
 
 	if (node && !pdata) {
 		/*
@@ -1211,17 +1203,6 @@ twl_probe(struct i2c_client *client, const struct i2c_device_id *id)
 		return -EINVAL;
 	}
 
-	status = irq_alloc_descs(-1, 0, nr_irqs, 0);
-	if (IS_ERR_VALUE(status)) {
-		dev_err(&client->dev, "Fail to allocate IRQ descs\n");
-		return status;
-	}
-
-	irq_base = status;
-	irq_end = irq_base + nr_irqs;
-	irq_domain_add_legacy(node, nr_irqs, irq_base, 0,
-			      &irq_domain_simple_ops, NULL);
-
 	if (i2c_check_functionality(client->adapter, I2C_FUNC_I2C) == 0) {
 		dev_dbg(&client->dev, "can't talk I2C?\n");
 		return -EIO;
@@ -1276,15 +1257,15 @@ twl_probe(struct i2c_client *client, const struct i2c_device_id *id)
 	if (client->irq) {
 		if (twl_class_is_4030()) {
 			twl4030_init_chip_irq(id->name);
-			status = twl4030_init_irq(client->irq, irq_base,
-			irq_end);
+			irq_base = twl4030_init_irq(&client->dev, client->irq);
 		} else {
-			status = twl6030_init_irq(client->irq, irq_base,
-			irq_end);
+			irq_base = twl6030_init_irq(&client->dev, client->irq);
 		}
 
-		if (status < 0)
+		if (irq_base < 0) {
+			status = irq_base;
 			goto fail;
+		}
 	}
 
 	/* Disable TWL4030/TWL5030 I2C Pull-up on I2C1 and I2C4(SR) interface.
diff --git a/drivers/mfd/twl-core.h b/drivers/mfd/twl-core.h
index 8c50a55..6ff99dc 100644
--- a/drivers/mfd/twl-core.h
+++ b/drivers/mfd/twl-core.h
@@ -1,9 +1,9 @@
 #ifndef __TWL_CORE_H__
 #define __TWL_CORE_H__
 
-extern int twl6030_init_irq(int irq_num, unsigned irq_base, unsigned irq_end);
+extern int twl6030_init_irq(struct device *dev, int irq_num);
 extern int twl6030_exit_irq(void);
-extern int twl4030_init_irq(int irq_num, unsigned irq_base, unsigned irq_end);
+extern int twl4030_init_irq(struct device *dev, int irq_num);
 extern int twl4030_exit_irq(void);
 extern int twl4030_init_chip_irq(const char *chip);
 
diff --git a/drivers/mfd/twl4030-irq.c b/drivers/mfd/twl4030-irq.c
index b69bb51..3b34531 100644
--- a/drivers/mfd/twl4030-irq.c
+++ b/drivers/mfd/twl4030-irq.c
@@ -28,10 +28,13 @@
  */
 
 #include <linux/init.h>
+#include <linux/export.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
 #include <linux/slab.h>
 
+#include <linux/of.h>
+#include <linux/irqdomain.h>
 #include <linux/i2c/twl.h>
 
 #include "twl-core.h"
@@ -53,6 +56,8 @@
  *	base + 8  .. base + 15	SIH for PWR_INT
  *	base + 16 .. base + 33	SIH for GPIO
  */
+#define TWL4030_CORE_NR_IRQS	8
+#define TWL4030_PWR_NR_IRQS	8
 
 /* PIH register offsets */
 #define REG_PIH_ISR_P1			0x01
@@ -694,14 +699,34 @@ int twl4030_sih_setup(int module)
 /* FIXME pass in which interrupt line we'll use ... */
 #define twl_irq_line	0
 
-int twl4030_init_irq(int irq_num, unsigned irq_base, unsigned irq_end)
+int twl4030_init_irq(struct device *dev, int irq_num)
 {
 	static struct irq_chip	twl4030_irq_chip;
+	int			irq_base, irq_end, nr_irqs;
+	struct			device_node *node = dev->of_node;
 
 	int			status;
 	int			i;
 
 	/*
+	 * TWL core and pwr interrupts must be contiguous because
+	 * the hwirqs numbers are defined contiguously from 1 to 15.
+	 * Create only one domain for both.
+	 */
+	nr_irqs = TWL4030_PWR_NR_IRQS + TWL4030_CORE_NR_IRQS;
+
+	irq_base = irq_alloc_descs(-1, 0, nr_irqs, 0);
+	if (IS_ERR_VALUE(irq_base)) {
+		dev_err(dev, "Fail to allocate IRQ descs\n");
+		return irq_base;
+	}
+
+	irq_domain_add_legacy(node, nr_irqs, irq_base, 0,
+			      &irq_domain_simple_ops, NULL);
+
+	irq_end = irq_base + TWL4030_CORE_NR_IRQS;
+
+	/*
 	 * Mask and clear all TWL4030 interrupts since initially we do
 	 * not have any TWL4030 module interrupt handlers present
 	 */
@@ -745,7 +770,7 @@ int twl4030_init_irq(int irq_num, unsigned irq_base, unsigned irq_end)
 		goto fail_rqirq;
 	}
 
-	return status;
+	return irq_base;
 fail_rqirq:
 	/* clean up twl4030_sih_setup */
 fail:
diff --git a/drivers/mfd/twl6030-irq.c b/drivers/mfd/twl6030-irq.c
index c6b456a..b4d5e0e 100644
--- a/drivers/mfd/twl6030-irq.c
+++ b/drivers/mfd/twl6030-irq.c
@@ -39,6 +39,8 @@
 #include <linux/i2c/twl.h>
 #include <linux/platform_device.h>
 #include <linux/suspend.h>
+#include <linux/of.h>
+#include <linux/irqdomain.h>
 
 #include "twl-core.h"
 
@@ -53,6 +55,7 @@
  * specifies mapping between interrupt number and the associated module.
  *
  */
+#define TWL6030_NR_IRQS    20
 
 static int twl6030_interrupt_mapping[24] = {
 	PWR_INTR_OFFSET,	/* Bit 0	PWRON			*/
@@ -237,11 +240,6 @@ int twl6030_irq_set_wake(struct irq_data *d, unsigned int on)
 	return 0;
 }
 
-/*----------------------------------------------------------------------*/
-
-static unsigned twl6030_irq_next;
-
-/*----------------------------------------------------------------------*/
 int twl6030_interrupt_unmask(u8 bit_mask, u8 offset)
 {
 	int ret;
@@ -340,8 +338,10 @@ int twl6030_mmc_card_detect(struct device *dev, int slot)
 }
 EXPORT_SYMBOL(twl6030_mmc_card_detect);
 
-int twl6030_init_irq(int irq_num, unsigned irq_base, unsigned irq_end)
+int twl6030_init_irq(struct device *dev, int irq_num)
 {
+	struct			device_node *node = dev->of_node;
+	int			nr_irqs, irq_base, irq_end;
 
 	int	status = 0;
 	int	i;
@@ -350,6 +350,20 @@ int twl6030_init_irq(int irq_num, unsigned irq_base, unsigned irq_end)
 	u8 mask[4];
 
 	static struct irq_chip	twl6030_irq_chip;
+
+	nr_irqs = TWL6030_NR_IRQS;
+
+	irq_base = irq_alloc_descs(-1, 0, nr_irqs, 0);
+	if (IS_ERR_VALUE(irq_base)) {
+		dev_err(dev, "Fail to allocate IRQ descs\n");
+		return irq_base;
+	}
+
+	irq_domain_add_legacy(node, nr_irqs, irq_base, 0,
+			      &irq_domain_simple_ops, NULL);
+
+	irq_end = irq_base + nr_irqs;
+
 	mask[1] = 0xFF;
 	mask[2] = 0xFF;
 	mask[3] = 0xFF;
@@ -377,9 +391,8 @@ int twl6030_init_irq(int irq_num, unsigned irq_base, unsigned irq_end)
 		activate_irq(i);
 	}
 
-	twl6030_irq_next = i;
 	pr_info("twl6030: %s (irq %d) chaining IRQs %d..%d\n", "PIH",
-			irq_num, irq_base, twl6030_irq_next - 1);
+			irq_num, irq_base, irq_end);
 
 	/* install an irq handler to demultiplex the TWL6030 interrupt */
 	init_completion(&irq_event);
@@ -400,7 +413,7 @@ int twl6030_init_irq(int irq_num, unsigned irq_base, unsigned irq_end)
 
 	twl_irq = irq_num;
 	register_pm_notifier(&twl6030_irq_pm_notifier_block);
-	return status;
+	return irq_base;
 
 fail_kthread:
 	free_irq(irq_num, &irq_event);
-- 
1.7.0.4

