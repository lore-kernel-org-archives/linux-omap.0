From: Suman Anna <s-anna@ti.com>
Subject: [PATCH v2 5/6] irqchip/irq-pruss-intc: Implement irq_{get,set}_irqchip_state ops
Date: Wed, 31 Jul 2019 17:41:48 -0500
Message-ID: <20190731224149.11153-6-s-anna@ti.com>
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

From: David Lechner <david@lechnology.com>

This implements the irq_get_irqchip_state and irq_set_irqchip_state
callbacks for the TI PRUSS INTC driver. The set callback can be used
by drivers to "kick" a PRU by enabling a PRU system event.

Example:
     irq_set_irqchip_state(irq, IRQCHIP_STATE_PENDING, true);

Signed-off-by: David Lechner <david@lechnology.com>
Signed-off-by: Suman Anna <s-anna@ti.com>
---
v2: New patch from David replacing an exported API from v1,
    https://patchwork.kernel.org/patch/11034565/

 drivers/irqchip/irq-pruss-intc.c | 41 ++++++++++++++++++++++++++++++--
 1 file changed, 39 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-pruss-intc.c b/drivers/irqchip/irq-pruss-intc.c
index 63cfc665be1e..59e26dfbb179 100644
--- a/drivers/irqchip/irq-pruss-intc.c
+++ b/drivers/irqchip/irq-pruss-intc.c
@@ -7,6 +7,7 @@
  *	Suman Anna <s-anna@ti.com>
  */
 
+#include <linux/interrupt.h>
 #include <linux/irq.h>
 #include <linux/irqchip/chained_irq.h>
 #include <linux/irqchip/irq-pruss-intc.h>
@@ -40,8 +41,7 @@
 #define PRU_INTC_HIEISR		0x0034
 #define PRU_INTC_HIDISR		0x0038
 #define PRU_INTC_GPIR		0x0080
-#define PRU_INTC_SRSR0		0x0200
-#define PRU_INTC_SRSR1		0x0204
+#define PRU_INTC_SRSR(x)	(0x0200 + (x) * 4)
 #define PRU_INTC_SECR0		0x0280
 #define PRU_INTC_SECR1		0x0284
 #define PRU_INTC_ESR0		0x0300
@@ -439,6 +439,41 @@ static void pruss_intc_irq_relres(struct irq_data *data)
 	module_put(THIS_MODULE);
 }
 
+static int pruss_intc_irq_get_irqchip_state(struct irq_data *data,
+					    enum irqchip_irq_state which,
+					    bool *state)
+{
+	struct pruss_intc *intc = irq_data_get_irq_chip_data(data);
+	u32 reg, mask, srsr;
+
+	if (which != IRQCHIP_STATE_PENDING)
+		return -EINVAL;
+
+	reg = PRU_INTC_SRSR(data->hwirq / 32);
+	mask = BIT(data->hwirq % 32);
+
+	srsr = pruss_intc_read_reg(intc, reg);
+
+	*state = !!(srsr & mask);
+
+	return 0;
+}
+
+static int pruss_intc_irq_set_irqchip_state(struct irq_data *data,
+					    enum irqchip_irq_state which,
+					    bool state)
+{
+	struct pruss_intc *intc = irq_data_get_irq_chip_data(data);
+
+	if (which != IRQCHIP_STATE_PENDING)
+		return -EINVAL;
+
+	if (state)
+		return pruss_intc_check_write(intc, PRU_INTC_SISR, data->hwirq);
+
+	return pruss_intc_check_write(intc, PRU_INTC_SICR, data->hwirq);
+}
+
 static int pruss_intc_irq_domain_map(struct irq_domain *d, unsigned int virq,
 				     irq_hw_number_t hw)
 {
@@ -583,6 +618,8 @@ static int pruss_intc_probe(struct platform_device *pdev)
 	irqchip->irq_unmask = pruss_intc_irq_unmask;
 	irqchip->irq_request_resources = pruss_intc_irq_reqres;
 	irqchip->irq_release_resources = pruss_intc_irq_relres;
+	irqchip->irq_get_irqchip_state = pruss_intc_irq_get_irqchip_state;
+	irqchip->irq_set_irqchip_state = pruss_intc_irq_set_irqchip_state;
 	irqchip->name = dev_name(dev);
 	intc->irqchip = irqchip;
 
-- 
2.22.0
