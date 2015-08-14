From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [PATCH v3 2/6] genirq: introduce irq_chip_set_type_parent() helper
Date: Fri, 14 Aug 2015 15:20:26 +0300
Message-ID: <1439554830-19502-3-git-send-email-grygorii.strashko@ti.com>
References: <1439554830-19502-1-git-send-email-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1439554830-19502-1-git-send-email-grygorii.strashko@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: tglx@linutronix.de, tony@atomide.com, marc.zyngier@arm.com
Cc: linux@arm.linux.org.uk, nsekhar@ti.com, jason@lakedaemon.net, balbi@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Grygorii Strashko <grygorii.strashko@ti.com>, Sudeep Holla <sudeep.holla@arm.com>
List-Id: linux-omap@vger.kernel.org

It's expected to use this helper when the current
domain doesn't implement .irq_set_type(),  but expect
the parent to do so.

Cc: Sudeep Holla <sudeep.holla@arm.com>
Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 include/linux/irq.h |  1 +
 kernel/irq/chip.c   | 17 +++++++++++++++++
 2 files changed, 18 insertions(+)

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
index 6de638b..ae21682 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -985,6 +985,23 @@ int irq_chip_set_affinity_parent(struct irq_data *data,
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
+
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
