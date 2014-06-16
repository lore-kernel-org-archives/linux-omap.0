From: Sricharan R <r.sricharan@ti.com>
Subject: [PATCH V3 12/16] irqchip: crossbar: add kerneldoc for crossbar_domain_unmap callback
Date: Mon, 16 Jun 2014 16:53:12 +0530
Message-ID: <1402917796-31574-13-git-send-email-r.sricharan@ti.com>
References: <1402917796-31574-1-git-send-email-r.sricharan@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1402917796-31574-1-git-send-email-r.sricharan@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: tony@atomide.com, santosh.shilimkar@ti.com, nm@ti.com, rnayak@ti.com, linux@arm.linux.org.uk, r.sricharan@ti.com, tglx@linutronix.de, jason@lakedaemon.net, joe@perches.com
List-Id: linux-omap@vger.kernel.org

Adding kerneldoc for unmap callback function.

Signed-off-by: Sricharan R <r.sricharan@ti.com>
---
[V3] Reworded the kerneldoc

 drivers/irqchip/irq-crossbar.c |   11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/irqchip/irq-crossbar.c b/drivers/irqchip/irq-crossbar.c
index 9b4c0f1..df16ef8 100644
--- a/drivers/irqchip/irq-crossbar.c
+++ b/drivers/irqchip/irq-crossbar.c
@@ -89,6 +89,17 @@ static int crossbar_domain_map(struct irq_domain *d, unsigned int irq,
 	return 0;
 }
 
+/**
+ * crossbar_domain_unmap - unmap a crossbar<->irq connection
+ * @d: domain of irq to unmap
+ * @irq: virq number
+ *
+ * We do not maintain a use count of total number of map/unmap
+ * calls for a particular irq to find out if a irq can be really
+ * unmapped. This is because unmap is called during irq_dispose_mapping(irq),
+ * after which irq is anyways unusable. So an explicit map has to be called
+ * after that.
+ */
 static void crossbar_domain_unmap(struct irq_domain *d, unsigned int irq)
 {
 	irq_hw_number_t hw = irq_get_irq_data(irq)->hwirq;
-- 
1.7.9.5
