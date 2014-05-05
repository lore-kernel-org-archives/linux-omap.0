From: Sricharan R <r.sricharan@ti.com>
Subject: [PATCH 2/5] irqchip: crossbar: check for premapped crossbar before allocating
Date: Mon, 5 May 2014 19:48:44 +0530
Message-ID: <1399299527-10955-3-git-send-email-r.sricharan@ti.com>
References: <1399299527-10955-1-git-send-email-r.sricharan@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:43390 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932760AbaEEOUb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 5 May 2014 10:20:31 -0400
In-Reply-To: <1399299527-10955-1-git-send-email-r.sricharan@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: nm@ti.com, rnayak@ti.com, santosh.shilimkar@ti.com, tony@atomide.com

From: Nishanth Menon <nm@ti.com>

If irq_of_parse_and_map is executed twice, the same crossbar is mapped to two
different GIC interrupts. This is completely undesirable. Instead, check
if the requested crossbar event is pre-allocated and provide that GIC
mapping back to caller if already allocated.

Signed-off-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Sricharan R <r.sricharan@ti.com>
---
 drivers/irqchip/irq-crossbar.c |   16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/irqchip/irq-crossbar.c b/drivers/irqchip/irq-crossbar.c
index 20105bc..51d4b87 100644
--- a/drivers/irqchip/irq-crossbar.c
+++ b/drivers/irqchip/irq-crossbar.c
@@ -51,6 +51,17 @@ static inline void crossbar_writeb(int irq_no, int cb_no)
 	writeb(cb_no, cb->crossbar_base + cb->register_offsets[irq_no]);
 }
 
+static inline int get_prev_map_irq(int cb_no)
+{
+	int i;
+
+	for (i = 0; i < cb->int_max; i++)
+		if (cb->irq_map[i] == cb_no)
+			return i;
+
+	return -ENODEV;
+}
+
 static inline int allocate_free_irq(int cb_no)
 {
 	int i;
@@ -88,11 +99,16 @@ static int crossbar_domain_xlate(struct irq_domain *d,
 {
 	unsigned long ret;
 
+	ret = get_prev_map_irq(intspec[1]);
+	if (!IS_ERR_VALUE(ret))
+		goto found;
+
 	ret = allocate_free_irq(intspec[1]);
 
 	if (IS_ERR_VALUE(ret))
 		return ret;
 
+found:
 	*out_hwirq = ret + GIC_IRQ_START;
 	return 0;
 }
-- 
1.7.9.5

