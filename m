From: Benoit Cousson <b-cousson@ti.com>
Subject: [PATCH 05/12] mfd: twl4030-irq: Make SIH SPARSE_IRQ capable
Date: Fri, 2 Mar 2012 17:50:17 +0100
Message-ID: <1330707024-23730-6-git-send-email-b-cousson@ti.com>
References: <1330707024-23730-1-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:44287 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752985Ab2CBQvQ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 2 Mar 2012 11:51:16 -0500
In-Reply-To: <1330707024-23730-1-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: sameo@linux.intel.com, tony@atomide.com, grant.likely@secretlab.ca
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Benoit Cousson <b-cousson@ti.com>, Felipe Balbi <balbi@ti.com>

twl4030 is using a two level irq controllers infrastruture.
So far, only the first level was using dynamic irq_desc allocation
to be able to have irq_domain support for device tree.
There is a need to allocate separate irq_descs for the SIH too to
avoid hacking the first level with interrupts from the second level.

Add an irq_base parameter to allow the caller to provide the base from
pdata or from dynamic allocation.

Affect TWL4030_NR_IRQS to the twl-core IRQs only.

Moreover that will allow the extraction of the of_node pointer for further
Device Tree conversion.

Signed-off-by: Felipe Balbi <balbi@ti.com>
Signed-off-by: Benoit Cousson <b-cousson@ti.com>
---
 drivers/gpio/gpio-twl4030.c |    3 ++-
 drivers/mfd/twl4030-irq.c   |   23 ++++++-----------------
 include/linux/i2c/twl.h     |    2 +-
 3 files changed, 9 insertions(+), 19 deletions(-)

diff --git a/drivers/gpio/gpio-twl4030.c b/drivers/gpio/gpio-twl4030.c
index b8b4f22..697396c 100644
--- a/drivers/gpio/gpio-twl4030.c
+++ b/drivers/gpio/gpio-twl4030.c
@@ -404,7 +404,8 @@ static int __devinit gpio_twl4030_probe(struct platform_device *pdev)
 				"can't dispatch IRQs from modules\n");
 			goto no_irqs;
 		}
-		ret = twl4030_sih_setup(TWL4030_MODULE_GPIO);
+		ret = twl4030_sih_setup(&pdev->dev, TWL4030_MODULE_GPIO,
+					pdata->irq_base);
 		if (ret < 0)
 			return ret;
 		WARN_ON(ret != pdata->irq_base);
diff --git a/drivers/mfd/twl4030-irq.c b/drivers/mfd/twl4030-irq.c
index 3b34531..faf3318 100644
--- a/drivers/mfd/twl4030-irq.c
+++ b/drivers/mfd/twl4030-irq.c
@@ -625,30 +625,23 @@ static irqreturn_t handle_twl4030_sih(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
-static unsigned twl4030_irq_next;
-
 /* returns the first IRQ used by this SIH bank,
  * or negative errno
  */
-int twl4030_sih_setup(int module)
+int twl4030_sih_setup(struct device *dev, int module, int irq_base)
 {
 	int			sih_mod;
 	const struct sih	*sih = NULL;
 	struct sih_agent	*agent;
 	int			i, irq;
 	int			status = -EINVAL;
-	unsigned		irq_base = twl4030_irq_next;
 
 	/* only support modules with standard clear-on-read for now */
 	for (sih_mod = 0, sih = sih_modules;
 			sih_mod < nr_sih_modules;
 			sih_mod++, sih++) {
 		if (sih->module == module && sih->set_cor) {
-			if (!WARN((irq_base + sih->bits) > NR_IRQS,
-					"irq %d for %s too big\n",
-					irq_base + sih->bits,
-					sih->name))
-				status = 0;
+			status = 0;
 			break;
 		}
 	}
@@ -659,8 +652,6 @@ int twl4030_sih_setup(int module)
 	if (!agent)
 		return -ENOMEM;
 
-	status = 0;
-
 	agent->irq_base = irq_base;
 	agent->sih = sih;
 	agent->imr = ~0;
@@ -676,8 +667,6 @@ int twl4030_sih_setup(int module)
 		activate_irq(irq);
 	}
 
-	twl4030_irq_next += i;
-
 	/* replace generic PIH handler (handle_simple_irq) */
 	irq = sih_mod + twl4030_irq_base;
 	irq_set_handler_data(irq, agent);
@@ -686,7 +675,7 @@ int twl4030_sih_setup(int module)
 				      agent->irq_name ?: sih->name, NULL);
 
 	pr_info("twl4030: %s (irq %d) chaining IRQs %d..%d\n", sih->name,
-			irq, irq_base, twl4030_irq_next - 1);
+			irq, irq_base, irq_base + i - 1);
 
 	return status < 0 ? status : irq_base;
 }
@@ -750,12 +739,12 @@ int twl4030_init_irq(struct device *dev, int irq_num)
 		irq_set_nested_thread(i, 1);
 		activate_irq(i);
 	}
-	twl4030_irq_next = i;
+
 	pr_info("twl4030: %s (irq %d) chaining IRQs %d..%d\n", "PIH",
-			irq_num, irq_base, twl4030_irq_next - 1);
+			irq_num, irq_base, irq_end);
 
 	/* ... and the PWR_INT module ... */
-	status = twl4030_sih_setup(TWL4030_MODULE_INT);
+	status = twl4030_sih_setup(dev, TWL4030_MODULE_INT, irq_end);
 	if (status < 0) {
 		pr_err("twl4030: sih_setup PWR INT --> %d\n", status);
 		goto fail;
diff --git a/include/linux/i2c/twl.h b/include/linux/i2c/twl.h
index 78d3465..8b9904a 100644
--- a/include/linux/i2c/twl.h
+++ b/include/linux/i2c/twl.h
@@ -751,7 +751,7 @@ struct twl4030_platform_data {
 
 /*----------------------------------------------------------------------*/
 
-int twl4030_sih_setup(int module);
+int twl4030_sih_setup(struct device *dev, int module, int irq_base);
 
 /* Offsets to Power Registers */
 #define TWL4030_VDAC_DEV_GRP		0x3B
-- 
1.7.0.4

