From: Suman Anna <s-anna@ti.com>
Subject: [PATCH 5/6] irqchip/irq-pruss-intc: Add API to trigger a PRU sysevent
Date: Sun, 7 Jul 2019 22:52:42 -0500
Message-ID: <20190708035243.12170-6-s-anna@ti.com>
References: <20190708035243.12170-1-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190708035243.12170-1-s-anna@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Marc Zyngier <marc.zyngier@arm.com>, Rob Herring <robh+dt@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>
Cc: Tony Lindgren <tony@atomide.com>, "Andrew F. Davis" <afd@ti.com>, Roger Quadros <rogerq@ti.com>, Lokesh Vutla <lokeshvutla@ti.com>, Grygorii Strashko <grygorii.strashko@ti.com>, Sekhar Nori <nsekhar@ti.com>, David Lechner <david@lechnology.com>, Murali Karicheri <m-karicheri2@ti.com>, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Suman Anna <s-anna@ti.com>
List-Id: linux-omap@vger.kernel.org

From: "Andrew F. Davis" <afd@ti.com>

The PRUSS INTC can generate an interrupt to various processor
subsystems on the SoC through a set of 64 possible PRU system
events. These system events can be used by PRU client drivers
or applications for event notifications/signalling between PRUs
and MPU or other processors. A new API, pruss_intc_trigger() is
provided to MPU-side PRU client drivers/applications to be able
to trigger an event/interrupt using IRQ numbers provided by the
PRUSS-INTC irqdomain chip.

Signed-off-by: Andrew F. Davis <afd@ti.com>
Signed-off-by: Suman Anna <s-anna@ti.com>
Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 drivers/irqchip/irq-pruss-intc.c | 31 +++++++++++++++++++++++++++++++
 include/linux/pruss_intc.h       | 26 ++++++++++++++++++++++++++
 2 files changed, 57 insertions(+)
 create mode 100644 include/linux/pruss_intc.h

diff --git a/drivers/irqchip/irq-pruss-intc.c b/drivers/irqchip/irq-pruss-intc.c
index 8118c2a2ac43..a0ad50b95cd5 100644
--- a/drivers/irqchip/irq-pruss-intc.c
+++ b/drivers/irqchip/irq-pruss-intc.c
@@ -421,6 +421,37 @@ static void pruss_intc_irq_relres(struct irq_data *data)
 	module_put(THIS_MODULE);
 }
 
+/**
+ * pruss_intc_trigger() - trigger a PRU system event
+ * @irq: linux IRQ number associated with a PRU system event
+ *
+ * Trigger an interrupt by signalling a specific PRU system event.
+ * This can be used by PRUSS client users to raise/send an event to
+ * a PRU or any other core that is listening on the host interrupt
+ * mapped to that specific PRU system event. The @irq variable is the
+ * Linux IRQ number associated with a specific PRU system event that
+ * a client user/application uses. The interrupt mappings for this is
+ * provided by the PRUSS INTC irqchip instance.
+ *
+ * Returns 0 on success, or an error value upon failure.
+ */
+int pruss_intc_trigger(unsigned int irq)
+{
+	struct irq_desc *desc;
+
+	if (irq <= 0)
+		return -EINVAL;
+
+	desc = irq_to_desc(irq);
+	if (!desc)
+		return -EINVAL;
+
+	pruss_intc_irq_retrigger(&desc->irq_data);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(pruss_intc_trigger);
+
 static int pruss_intc_irq_domain_map(struct irq_domain *d, unsigned int virq,
 				     irq_hw_number_t hw)
 {
diff --git a/include/linux/pruss_intc.h b/include/linux/pruss_intc.h
new file mode 100644
index 000000000000..84aa7f7edf42
--- /dev/null
+++ b/include/linux/pruss_intc.h
@@ -0,0 +1,26 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/**
+ * TI PRU-ICSS Subsystem user interfaces
+ *
+ * Copyright (C) 2019 Texas Instruments Incorporated - http://www.ti.com
+ *	Andrew F. Davis <afd@ti.com>
+ *	Suman Anna <s-anna@ti.com>
+ */
+
+#ifndef __LINUX_PRUSS_INTC_H
+#define __LINUX_PRUSS_INTC_H
+
+#if IS_ENABLED(CONFIG_TI_PRUSS_INTC)
+
+int pruss_intc_trigger(unsigned int irq);
+
+#else
+
+static inline int pruss_intc_trigger(unsigned int irq)
+{
+	return -ENOTSUPP;
+}
+
+#endif /* CONFIG_TI_PRUSS_INTC */
+
+#endif /* __LINUX_PRUSS_INTC_H */
-- 
2.22.0
