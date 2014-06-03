From: Sricharan R <r.sricharan@ti.com>
Subject: [PATCH 10/14] irqchip: crossbar: Add kerneldoc for crossbar_domain_unmap callback
Date: Tue, 3 Jun 2014 13:13:02 +0530
Message-ID: <1401781386-4982-11-git-send-email-r.sricharan@ti.com>
References: <1401781386-4982-1-git-send-email-r.sricharan@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:50375 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932130AbaFCHq1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 3 Jun 2014 03:46:27 -0400
In-Reply-To: <1401781386-4982-1-git-send-email-r.sricharan@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Cc: tony@atomide.com, santosh.shilimkar@ti.com, nm@ti.com, rnayak@ti.com, tglx@linutronix.de, linux@arm.linux.org.uk, r.sricharan@ti.com

The crossbar_domain_map/unmap callbacks need not be called same number
of times for a particular irq. But still use counting is not needed
here, because unmap(irq) gets called when irq_desc(irq) is disposed.
After this the irq is anyways unusable and have to mapped again.

Adding the above kerneldoc for unmap callback clarity.

Signed-off-by: Sricharan R <r.sricharan@ti.com>
---
 drivers/irqchip/irq-crossbar.c |   10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/irqchip/irq-crossbar.c b/drivers/irqchip/irq-crossbar.c
index 5f3e75a..2a73a66 100644
--- a/drivers/irqchip/irq-crossbar.c
+++ b/drivers/irqchip/irq-crossbar.c
@@ -101,6 +101,16 @@ static int crossbar_domain_map(struct irq_domain *d, unsigned int irq,
 	return 0;
 }
 
+/**
+ * crossbar_domain_unmap - unmap a crossbar<->irq connection
+ * @d: domain of irq to unmap
+ * @irq: virq number
+ *
+ * The map/unmap callbacks need not be called same number of times for
+ * a particular irq. But still use counting is not needed here, because
+ * unmap(irq) gets called when irq_desc(irq) is disposed. After this the
+ * irq is anyways unusuable and have to be mapped again.
+ */
 static void crossbar_domain_unmap(struct irq_domain *d, unsigned int irq)
 {
 	irq_hw_number_t hw = irq_get_irq_data(irq)->hwirq;
-- 
1.7.9.5

