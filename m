From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [PATCH v2 3/6] genirq: introduce irq_chip_set_type_parent() helper
Date: Wed, 12 Aug 2015 20:45:59 +0300
Message-ID: <1439401562-28874-4-git-send-email-grygorii.strashko@ti.com>
References: <1439401562-28874-1-git-send-email-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1439401562-28874-1-git-send-email-grygorii.strashko@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: tglx@linutronix.de, tony@atomide.com, marc.zyngier@arm.com
Cc: Grygorii Strashko <grygorii.strashko@ti.com>, linux@arm.linux.org.uk, jason@lakedaemon.net, nsekhar@ti.com, linux-kernel@vger.kernel.org, balbi@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

It's expected to use this helper when the current
domain doesn't implement .irq_set_type(),  but expect
the parent to do so.

Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 include/linux/irq.h |  1 +
 kernel/irq/chip.c   | 20 ++++++++++++++++++++
 2 files changed, 21 insertions(+)

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
index bdb1b9d..b48938b 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -985,6 +985,26 @@ int irq_chip_set_affinity_parent(struct irq_data *data,
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
+	if (irq_data_get_irq_chip(data)->flags & IRQCHIP_SKIP_SET_WAKE)
+		return 0;
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
