From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH v3 17/27] memory: omap-gpmc: Add irqchip support to the gpiochip
Date: Fri, 18 Sep 2015 17:53:39 +0300
Message-ID: <1442588029-13769-18-git-send-email-rogerq@ti.com>
References: <1442588029-13769-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1442588029-13769-1-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: tony@atomide.com
Cc: dwmw2@infradead.org, computersforpeace@gmail.com, ezequiel@vanguardiasur.com.ar, javier@dowhile0.org, fcooper@ti.com, nsekhar@ti.com, linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

The WAIT pins support either rising or falling edge interrupts
so add irqchip support to the gpiochip model.

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 drivers/memory/omap-gpmc.c | 132 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 132 insertions(+)

diff --git a/drivers/memory/omap-gpmc.c b/drivers/memory/omap-gpmc.c
index fdf19eeb..764e24a 100644
--- a/drivers/memory/omap-gpmc.c
+++ b/drivers/memory/omap-gpmc.c
@@ -13,6 +13,7 @@
  * published by the Free Software Foundation.
  */
 #include <linux/irq.h>
+#include <linux/irqdomain.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/err.h>
@@ -227,6 +228,7 @@ struct omap3_gpmc_regs {
 struct gpmc_device {
 	struct device *dev;
 	struct gpio_chip gpio_chip;
+	struct irq_chip	irq_chip;
 };
 
 static struct resource	gpmc_mem_root;
@@ -1944,6 +1946,99 @@ err:
 	return ret;
 }
 
+static int gpmc_irq_endis(unsigned long hwirq, bool endis)
+{
+	u32 regval;
+
+	/* WAITPIN starts at BIT 8 */
+	hwirq += 8;
+
+	regval = gpmc_read_reg(GPMC_IRQENABLE);
+	if (endis)
+		regval |= BIT(hwirq);
+	else
+		regval &= ~BIT(hwirq);
+	gpmc_write_reg(GPMC_IRQENABLE, regval);
+
+	return 0;
+}
+
+static void gpmc_irq_edge_config(unsigned long hwirq, bool rising_edge)
+{
+	u32 regval;
+
+	/* WAITPIN starts at BIT 8 */
+	hwirq += 8;
+
+	regval = gpmc_read_reg(GPMC_CONFIG);
+	if (rising_edge)
+		regval &= ~BIT(hwirq);
+	else
+		regval |= BIT(hwirq);
+
+	gpmc_write_reg(GPMC_CONFIG, regval);
+}
+
+static void gpmc_irq_mask(struct irq_data *d)
+{
+	gpmc_irq_endis(d->hwirq, false);
+}
+
+static void gpmc_irq_unmask(struct irq_data *d)
+{
+	gpmc_irq_endis(d->hwirq, true);
+}
+
+static void gpmc_irq_ack(struct irq_data *d)
+{
+	unsigned hwirq = d->hwirq + 8;
+
+	/* Setting bit to 1 clears (or Acks) the interrupt */
+	gpmc_write_reg(GPMC_IRQSTATUS, BIT(hwirq));
+}
+
+static int gpmc_irq_set_type(struct irq_data *d, unsigned trigger)
+{
+	/* We can support either rising or falling edge at a time */
+	if (trigger == IRQ_TYPE_EDGE_FALLING)
+		gpmc_irq_edge_config(d->hwirq, false);
+	else if (trigger == IRQ_TYPE_EDGE_RISING)
+		gpmc_irq_edge_config(d->hwirq, true);
+	else
+		return -EINVAL;
+
+	return 0;
+}
+
+static irqreturn_t gpmc_handle_irq(int irq, void *data)
+{
+	int hwirq, virq;
+	u32 regval;
+	struct gpmc_device *gpmc = data;
+
+	regval = gpmc_read_reg(GPMC_IRQSTATUS);
+	regval >>= 8;	/* we're only interested in WAIT pins */
+
+	if (!regval)
+		return IRQ_NONE;
+
+	for (hwirq = 0; hwirq < gpmc->gpio_chip.ngpio; hwirq++) {
+		if (regval & BIT(hwirq)) {
+			virq = irq_find_mapping(gpmc->gpio_chip.irqdomain,
+						hwirq);
+			if (!virq) {
+				dev_warn(gpmc_dev,
+					 "spurious irq detected hwirq %d, virq %d\n",
+					 hwirq, virq);
+			}
+
+			generic_handle_irq(virq);
+		}
+	}
+
+	return IRQ_HANDLED;
+}
+
 static int gpmc_gpio_get_direction(struct gpio_chip *chip, unsigned offset)
 {
 	return 1;	/* we're input only */
@@ -1978,6 +2073,7 @@ static int gpmc_gpio_get(struct gpio_chip *chip, unsigned offset)
 static int gpmc_gpio_init(struct gpmc_device *gpmc)
 {
 	int ret;
+	u32 regval;
 
 	gpmc->gpio_chip.dev = gpmc->dev;
 	gpmc->gpio_chip.owner = THIS_MODULE;
@@ -1996,7 +2092,43 @@ static int gpmc_gpio_init(struct gpmc_device *gpmc)
 		return ret;
 	}
 
+	/* Disable interrupts */
+	gpmc_write_reg(GPMC_IRQENABLE, 0);
+
+	/* clear interrupts */
+	regval = gpmc_read_reg(GPMC_IRQSTATUS);
+	gpmc_write_reg(GPMC_IRQSTATUS, regval);
+
+	gpmc->irq_chip.name = DEVICE_NAME;
+	gpmc->irq_chip.irq_ack = gpmc_irq_ack;
+	gpmc->irq_chip.irq_mask = gpmc_irq_mask;
+	gpmc->irq_chip.irq_unmask = gpmc_irq_unmask;
+	gpmc->irq_chip.irq_set_type = gpmc_irq_set_type;
+
+	ret = gpiochip_irqchip_add(&gpmc->gpio_chip, &gpmc->irq_chip, 0,
+				   handle_edge_irq, IRQ_TYPE_NONE);
+
+	if (ret) {
+		dev_err(gpmc->dev, "could not add irqchip to gpiochip: %d\n",
+			ret);
+		goto fail;
+	}
+
+	/* We're sharing this IRQ with OMAP NAND driver */
+	ret = devm_request_irq(gpmc->dev, gpmc_irq, gpmc_handle_irq,
+			       IRQF_SHARED, DEVICE_NAME, gpmc);
+	if (ret) {
+		dev_err(gpmc->dev, "could not request gpmc irq (%d): %d\n",
+			gpmc_irq, ret);
+		goto fail;
+	}
+
 	return 0;
+
+fail:
+	gpiochip_remove(&gpmc->gpio_chip);
+
+	return ret;
 }
 
 static void gpmc_gpio_exit(struct gpmc_device *gpmc)
-- 
2.1.4
