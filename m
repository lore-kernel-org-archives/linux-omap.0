From: Suman Anna <s-anna@ti.com>
Subject: [PATCH v2 3/6] irqchip/irq-pruss-intc: Add support for shared and invalid interrupts
Date: Wed, 31 Jul 2019 17:41:46 -0500
Message-ID: <20190731224149.11153-4-s-anna@ti.com>
References: <20190731224149.11153-1-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190731224149.11153-1-s-anna@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Marc Zyngier <maz@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>
Cc: Rob Herring <robh+dt@kernel.org>, David Lechner <david@lechnology.com>, Tony Lindgren <tony@atomide.com>, "Andrew F. Davis" <afd@ti.com>, Roger Quadros <rogerq@ti.com>, Lokesh Vutla <lokeshvutla@ti.com>, Grygorii Strashko <grygorii.strashko@ti.com>, Sekhar Nori <nsekhar@ti.com>, Murali Karicheri <m-karicheri2@ti.com>, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Suman Anna <s-anna@ti.com>
List-Id: linux-omap@vger.kernel.org

The PRUSS INTC has a fixed number of output interrupt lines that are
connected to a number of processors or other PRUSS instances or other
devices (like DMA) on the SoC. The output interrupt lines 2 through 9
are usually connected to the main Arm host processor and are referred
to as host interrupts 0 through 7 from ARM/MPU perspective.

All of these 8 host interrupts are not always exclusively connected
to the Arm interrupt controller. Some SoCs have some interrupt lines
not connected to the Arm interrupt controller at all, while a few others
have the interrupt lines connected to multiple processors in which they
need to be partitioned as per SoC integration needs. For example, AM437x
and 66AK2G SoCs have 2 PRUSS instances each and have the host interrupt 5
connected to the other PRUSS, while AM335x has host interrupt 0 shared
between MPU and TSC_ADC and host interrupts 6 & 7 shared between MPU and
a DMA controller.

Add support to the PRUSS INTC driver to allow both these shared and
invalid interrupts by not returning a failure if any of these interrupts
are skipped from the corresponding INTC DT node.

Signed-off-by: Suman Anna <s-anna@ti.com>
---
v2:
 - Fixed a typo in error message trace for ti,irqs-shared
 - Updated patch description to use generic "interrupt controller" instead
   of GIC
 - Revised the kerneldoc comment for invalid_intr
v1: https://patchwork.kernel.org/patch/11034559/

 drivers/irqchip/irq-pruss-intc.c | 44 +++++++++++++++++++++++++++++++-
 1 file changed, 43 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-pruss-intc.c b/drivers/irqchip/irq-pruss-intc.c
index 4a9456544fd0..3a1b8a93cfad 100644
--- a/drivers/irqchip/irq-pruss-intc.c
+++ b/drivers/irqchip/irq-pruss-intc.c
@@ -67,6 +67,8 @@
  * @irqchip: irq chip for this interrupt controller
  * @domain: irq domain for this interrupt controller
  * @lock: mutex to serialize access to INTC
+ * @shared_intr: bit-map denoting if the MPU host interrupt is shared
+ * @invalid_intr: bit-map denoting if host interrupt is not connected to MPU
  */
 struct pruss_intc {
 	unsigned int irqs[MAX_NUM_HOST_IRQS];
@@ -74,6 +76,8 @@ struct pruss_intc {
 	struct irq_chip *irqchip;
 	struct irq_domain *domain;
 	struct mutex lock; /* PRUSS INTC lock */
+	u16 shared_intr;
+	u16 invalid_intr;
 };
 
 static inline u32 pruss_intc_read_reg(struct pruss_intc *intc, unsigned int reg)
@@ -233,7 +237,8 @@ static int pruss_intc_probe(struct platform_device *pdev)
 	struct pruss_intc *intc;
 	struct resource *res;
 	struct irq_chip *irqchip;
-	int i, irq;
+	int i, irq, count;
+	u8 temp_intr[MAX_NUM_HOST_IRQS] = { 0 };
 
 	intc = devm_kzalloc(dev, sizeof(*intc), GFP_KERNEL);
 	if (!intc)
@@ -250,6 +255,39 @@ static int pruss_intc_probe(struct platform_device *pdev)
 	dev_dbg(dev, "intc memory: pa %pa size 0x%zx va %pK\n", &res->start,
 		(size_t)resource_size(res), intc->base);
 
+	count = of_property_read_variable_u8_array(dev->of_node,
+						   "ti,irqs-reserved",
+						   temp_intr, 0,
+						   MAX_NUM_HOST_IRQS);
+	if (count < 0 && count != -EINVAL)
+		return count;
+	count = (count == -EINVAL ? 0 : count);
+	for (i = 0; i < count; i++) {
+		if (temp_intr[i] < MAX_NUM_HOST_IRQS) {
+			intc->invalid_intr |= BIT(temp_intr[i]);
+		} else {
+			dev_warn(dev, "ignoring invalid reserved irq %d\n",
+				 temp_intr[i]);
+		}
+		temp_intr[i] = 0;
+	}
+
+	count = of_property_read_variable_u8_array(dev->of_node,
+						   "ti,irqs-shared",
+						   temp_intr, 0,
+						   MAX_NUM_HOST_IRQS);
+	if (count < 0 && count != -EINVAL)
+		return count;
+	count = (count == -EINVAL ? 0 : count);
+	for (i = 0; i < count; i++) {
+		if (temp_intr[i] < MAX_NUM_HOST_IRQS) {
+			intc->shared_intr |= BIT(temp_intr[i]);
+		} else {
+			dev_warn(dev, "ignoring invalid shared irq %d\n",
+				 temp_intr[i]);
+		}
+	}
+
 	mutex_init(&intc->lock);
 
 	pruss_intc_init(intc);
@@ -275,6 +313,10 @@ static int pruss_intc_probe(struct platform_device *pdev)
 	for (i = 0; i < MAX_NUM_HOST_IRQS; i++) {
 		irq = platform_get_irq_byname(pdev, irq_names[i]);
 		if (irq < 0) {
+			if (intc->shared_intr & BIT(i) ||
+			    intc->invalid_intr & BIT(i))
+				continue;
+
 			dev_err(dev, "platform_get_irq_byname failed for %s : %d\n",
 				irq_names[i], irq);
 			goto fail_irq;
-- 
2.22.0
