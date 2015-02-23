From: Marc Zyngier <marc.zyngier@arm.com>
Subject: [PATCH v5 1/7] genirq: Add irqchip_set_wake_parent
Date: Mon, 23 Feb 2015 17:44:13 +0000
Message-ID: <1424713459-6824-2-git-send-email-marc.zyngier@arm.com>
References: <1424713459-6824-1-git-send-email-marc.zyngier@arm.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:60552 "EHLO
	usa-sjc-mx-foss1.foss.arm.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752611AbbBWRod (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 23 Feb 2015 12:44:33 -0500
In-Reply-To: <1424713459-6824-1-git-send-email-marc.zyngier@arm.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Nishanth Menon <nm@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>, Jason Cooper <jason@lakedaemon.net>, Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

This proves to be useful with stacked domains, when the current
domain doesn't implement wake-up, but expect the parent to do so.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 include/linux/irq.h |  1 +
 kernel/irq/chip.c   | 16 ++++++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/include/linux/irq.h b/include/linux/irq.h
index d09ec7a..3057c48 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -460,6 +460,7 @@ extern void irq_chip_eoi_parent(struct irq_data *data);
 extern int irq_chip_set_affinity_parent(struct irq_data *data,
 					const struct cpumask *dest,
 					bool force);
+extern int irq_chip_set_wake_parent(struct irq_data *data, unsigned int on);
 #endif
 
 /* Handling of unhandled and spurious interrupts: */
diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
index 6f1c7a5..eb9a4ea 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -948,6 +948,22 @@ int irq_chip_retrigger_hierarchy(struct irq_data *data)
 
 	return -ENOSYS;
 }
+
+/**
+ * irq_chip_set_wake_parent - Set/reset wake-up on the parent interrupt
+ * @data:	Pointer to interrupt specific data
+ * @on:		Whether to set or reset the wake-up capability of this irq
+ *
+ * Conditional, as the underlying parent chip might not implement it.
+ */
+int irq_chip_set_wake_parent(struct irq_data *data, unsigned int on)
+{
+	data = data->parent_data;
+	if (data->chip->irq_set_wake)
+		return data->chip->irq_set_wake(data, on);
+
+	return -ENOSYS;
+}
 #endif
 
 /**
-- 
2.1.4

