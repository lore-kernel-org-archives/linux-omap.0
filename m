From: Sricharan R <r.sricharan@ti.com>
Subject: [PATCH V3 04/16] irqchip: crossbar: initialise the crossbar with a
 safe value
Date: Mon, 16 Jun 2014 16:53:04 +0530
Message-ID: <1402917796-31574-5-git-send-email-r.sricharan@ti.com>
References: <1402917796-31574-1-git-send-email-r.sricharan@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1402917796-31574-1-git-send-email-r.sricharan@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: nm@ti.com, linux@arm.linux.org.uk, jason@lakedaemon.net, tony@atomide.com, rnayak@ti.com, r.sricharan@ti.com, santosh.shilimkar@ti.com, joe@perches.com, tglx@linutronix.de
List-Id: linux-omap@vger.kernel.org

From: Nishanth Menon <nm@ti.com>

Since crossbar is s/w configurable, the initial settings of the
crossbar cannot be assumed to be sane. This implies that:
a) On initialization all un-reserved crossbars must be initialized to
   a known 'safe' value.
b) When unmapping the interrupt, the safe value must be written to
   ensure that the crossbar mapping matches with interrupt controller
   usage.

So provide a safe value in the dt data to map if
'0' is not safe for the platform and use it during init and unmap

While at this, fix the below checkpatch warning.
Fixes checkpatch warning:
WARNING: Unnecessary space before function pointer arguments
 #37: FILE: drivers/irqchip/irq-crossbar.c:37:
 +	void (*write) (int, int);

Signed-off-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Sricharan R <r.sricharan@ti.com>
---
[V3] introduced ti,irqs-safe-map which defines a safe value
     to initialize the crossbar.

 .../devicetree/bindings/arm/omap/crossbar.txt      |    3 +++
 drivers/irqchip/irq-crossbar.c                     |   19 +++++++++++++++++--
 2 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/omap/crossbar.txt b/Documentation/devicetree/bindings/arm/omap/crossbar.txt
index cfcbd52..e54d1fb 100644
--- a/Documentation/devicetree/bindings/arm/omap/crossbar.txt
+++ b/Documentation/devicetree/bindings/arm/omap/crossbar.txt
@@ -21,6 +21,9 @@ Optional properties:
 - ti,irqs-skip: This is similar to "ti,irqs-reserved", but are irq mappings
   which are not supposed to be used for errata or other reasons(virtualization).
 
+- ti,irqs-safe-map: integer which maps to a safe configuration to use
+  when the interrupt controller irq is unused (when not provided, default is 0)
+
 Examples:
 		crossbar_mpu: @4a020000 {
 			compatible = "ti,irq-crossbar";
diff --git a/drivers/irqchip/irq-crossbar.c b/drivers/irqchip/irq-crossbar.c
index 27049de..d1f67f6 100644
--- a/drivers/irqchip/irq-crossbar.c
+++ b/drivers/irqchip/irq-crossbar.c
@@ -23,16 +23,18 @@
 
 /*
  * @int_max: maximum number of supported interrupts
+ * @safe_map: safe default value to initialize the crossbar
  * @irq_map: array of interrupts to crossbar number mapping
  * @crossbar_base: crossbar base address
  * @register_offsets: offsets for each irq number
  */
 struct crossbar_device {
 	uint int_max;
+	uint safe_map;
 	uint *irq_map;
 	void __iomem *crossbar_base;
 	int *register_offsets;
-	void (*write) (int, int);
+	void (*write)(int, int);
 };
 
 static struct crossbar_device *cb;
@@ -88,8 +90,10 @@ static void crossbar_domain_unmap(struct irq_domain *d, unsigned int irq)
 {
 	irq_hw_number_t hw = irq_get_irq_data(irq)->hwirq;
 
-	if (hw > GIC_IRQ_START)
+	if (hw > GIC_IRQ_START) {
 		cb->irq_map[hw - GIC_IRQ_START] = IRQ_FREE;
+		cb->write(hw - GIC_IRQ_START, cb->safe_map);
+	}
 }
 
 static int crossbar_domain_xlate(struct irq_domain *d,
@@ -214,6 +218,17 @@ static int __init crossbar_of_init(struct device_node *node)
 		reserved += size;
 	}
 
+	of_property_read_u32(node, "ti,irqs-safe-map", &cb->safe_map);
+
+	/* Initialize the crossbar with safe map to start with */
+	for (i = 0; i < max; i++) {
+		if (cb->irq_map[i] == IRQ_RESERVED ||
+		    cb->irq_map[i] == IRQ_SKIP)
+			continue;
+
+		cb->write(i, cb->safe_map);
+	}
+
 	register_routable_domain_ops(&routable_irq_domain_ops);
 	return 0;
 
-- 
1.7.9.5
