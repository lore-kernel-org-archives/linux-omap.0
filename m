From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [PATCH] ARM: OMAP: irqdomain_hierarchy: fix arm gic irq type configuration
Date: Tue, 11 Aug 2015 12:25:47 +0300
Message-ID: <1439285147-20027-1-git-send-email-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>, Tony Lindgren <tony@atomide.com>, Marc Zyngier <marc.zyngier@arm.com>
Cc: Russell King <linux@arm.linux.org.uk>, Jason Cooper <jason@lakedaemon.net>, balbi@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Grygorii Strashko <grygorii.strashko@ti.com>
List-Id: linux-omap@vger.kernel.org

It's observed that ARM GIC IRQ triggering type is not configured
properly when IRQ is routed through IRQ domains hierarchy and
system started using DT. As result, system will start using default
ARM GIC configuration, ignore DT IRQ type configuration,
and value of desc->irq_data.state_use_accessors = 0.

In case of TI OMAP the following IRQ hierarchy is defined:
ARM GIC <- OMAP wakeupgen <- TI CBAR

Failed call chain:
 irq_create_of_mapping
 irq_set_irq_type
 __irq_set_trigger
 if (!chip || !chip->irq_set_type) {
    return 0; <- return here
 }
 CBAR has no .irq_set_type() defined and, so, IRQ triggering
 configuration will not be propagated to parent IRQ domain.

Hence, fix it by introducing irq_chip_set_type_parent(), in the
same manner as irq_chip_set_wake_parent(), and use it for IRQ 
triggering type propagation to the parent IRQ domain in
irq-crossbar and omap-wakeupgen.

/ # cat /proc/interrupts -- before
230:          0          0      CBAR  30 Edge    -00000000  48051000.gpio
263:          0          0      CBAR 116 Edge    -00000000  48053000.gpio
296:        246          0      CBAR  67 Edge    -00000000  OMAP UART0
311:        341          0      CBAR  51 Edge    -00000000  48070000.i2c
312:          3          0      CBAR  52 Edge    -00000000  48072000.i2c
313:          0          0      CBAR  56 Edge    -00000000  48060000.i2c
314:        255          0      CBAR  78 Edge    -00000000  mmc0
315:         40          0      CBAR  81 Edge    -00000000  mmc1
316:         13          0      CBAR  91 Edge    -00000000  mmc2
320:          0          0      CBAR  49 Edge    -00000000  4a140000.sata
324:          0          0      CBAR   1 Edge    -00000000  48078000.elm
325:          0          0      CBAR  15 Edge    -00000000  gpmc
333:          0          0      CBAR 335 Edge    -00000000  48484000.ethernet
334:          0          0      CBAR 336 Edge    -00000000  48484000.ethernet
415:          0          0   pcf857x   2 Edge    -00000000  btnUser1
416:          0          0   pcf857x   3 Edge    -00000000  btnUser2
445:          0          0   pinctrl 992 Edge    -00010000  4806a000.seria

/ # cat /proc/interrupts -- after
230:          0          0      CBAR  30 Level   -00002004  48051000.gpio
263:          0          0      CBAR 116 Level   -00002004  48053000.gpio
296:        567          0      CBAR  67 Level   -00002004  OMAP UART0
311:        363          0      CBAR  51 Level   -00002004  48070000.i2c
312:          3          0      CBAR  52 Level   -00002004  48072000.i2c
313:          0          0      CBAR  56 Level   -00002004  48060000.i2c
314:        197          0      CBAR  78 Level   -00002004  mmc0
315:         40          0      CBAR  81 Level   -00002004  mmc1
316:         13          0      CBAR  91 Level   -00002004  mmc2
320:          0          0      CBAR  49 Level   -00002004  4a140000.sata
324:          0          0      CBAR   1 Level   -00002004  48078000.elm
325:          0          0      CBAR  15 Level   -00002004  gpmc
333:          0          0      CBAR 335 Level   -00002004  48484000.ethernet
334:          0          0      CBAR 336 Level   -00002004  48484000.ethernet
415:          0          0   pcf857x   2 Edge    -00000000  btnUser1
416:          4          2   pcf857x   3 Edge    -00000000  btnUser2
445:          0          0   pinctrl 992 Edge    -00010000  4806a000.serial

Fixes: 783d31863fb8 ('irqchip: crossbar: Convert dra7 crossbar to stacked domains')
Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
Hi All,

I can split patch if required and overall solution acceptable.


 arch/arm/mach-omap2/omap-wakeupgen.c |  1 +
 drivers/irqchip/irq-crossbar.c       |  1 +
 include/linux/irq.h                  |  1 +
 kernel/irq/chip.c                    | 16 ++++++++++++++++
 4 files changed, 19 insertions(+)

diff --git a/arch/arm/mach-omap2/omap-wakeupgen.c b/arch/arm/mach-omap2/omap-wakeupgen.c
index 8e52621..e1d2e99 100644
--- a/arch/arm/mach-omap2/omap-wakeupgen.c
+++ b/arch/arm/mach-omap2/omap-wakeupgen.c
@@ -392,6 +392,7 @@ static struct irq_chip wakeupgen_chip = {
 	.irq_mask		= wakeupgen_mask,
 	.irq_unmask		= wakeupgen_unmask,
 	.irq_retrigger		= irq_chip_retrigger_hierarchy,
+	.irq_set_type		= irq_chip_set_type_parent,
 	.flags			= IRQCHIP_SKIP_SET_WAKE | IRQCHIP_MASK_ON_SUSPEND,
 #ifdef CONFIG_SMP
 	.irq_set_affinity	= irq_chip_set_affinity_parent,
diff --git a/drivers/irqchip/irq-crossbar.c b/drivers/irqchip/irq-crossbar.c
index 692fe2b..3ba58e7 100644
--- a/drivers/irqchip/irq-crossbar.c
+++ b/drivers/irqchip/irq-crossbar.c
@@ -69,6 +69,7 @@ static struct irq_chip crossbar_chip = {
 	.irq_unmask		= irq_chip_unmask_parent,
 	.irq_retrigger		= irq_chip_retrigger_hierarchy,
 	.irq_set_wake		= irq_chip_set_wake_parent,
+	.irq_set_type		= irq_chip_set_type_parent,
 #ifdef CONFIG_SMP
 	.irq_set_affinity	= irq_chip_set_affinity_parent,
 #endif
diff --git a/include/linux/irq.h b/include/linux/irq.h
index 92188b0..51744bc 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -484,6 +484,7 @@ extern int irq_chip_set_affinity_parent(struct irq_data *data,
 extern int irq_chip_set_wake_parent(struct irq_data *data, unsigned int on);
 extern int irq_chip_set_vcpu_affinity_parent(struct irq_data *data,
 					     void *vcpu_info);
+extern int irq_chip_set_type_parent(struct irq_data *data, unsigned int type);
 #endif
 
 /* Handling of unhandled and spurious interrupts: */
diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
index 27f4332..ac3ff8a 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -985,6 +985,22 @@ int irq_chip_set_affinity_parent(struct irq_data *data,
 }
 
 /**
+ * irq_chip_set_type_parent - Set IRQ type on the parent interrupt
+ * @data:	Pointer to interrupt specific data
+ * @type:	IRQ_TYPE_{LEVEL,EDGE}_* value - see include/linux/irq.h
+ *
+ * Conditional, as the underlying parent chip might not implement it.
+ */
+int irq_chip_set_type_parent(struct irq_data *data, unsigned int type)
+{
+	data = data->parent_data;
+	if (data->chip->irq_set_type)
+		return data->chip->irq_set_type(data, type);
+
+	return -ENOSYS;
+}
+
+/**
  * irq_chip_retrigger_hierarchy - Retrigger an interrupt in hardware
  * @data:	Pointer to interrupt specific data
  *
-- 
2.5.0
