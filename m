From: Milo Kim <milo.kim@ti.com>
Subject: [PATCH] irqchip: omap-intc: Remove duplicate setup for IRQ chip type handler
Date: Mon, 21 Dec 2015 17:53:14 +0900
Message-ID: <1450687994-12580-1-git-send-email-milo.kim@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: tony@atomide.com, tglx@linutronix.de
Cc: Milo Kim <milo.kim@ti.com>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Some OMAP interrupt controllers use generic level detection, so
handle_level_irq() is used as the chip type handler.
Allocated IRQ chip type handler doesn't need to set it again because
irq_alloc_domain_generic_chips() has already registered it.

Tested with BeagleBoneBlack Rev C.

Cc: Tony Lindgren <tony@atomide.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: linux-omap@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Milo Kim <milo.kim@ti.com>
---
 drivers/irqchip/irq-omap-intc.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/irqchip/irq-omap-intc.c b/drivers/irqchip/irq-omap-intc.c
index 8587d0f..ed25175 100644
--- a/drivers/irqchip/irq-omap-intc.c
+++ b/drivers/irqchip/irq-omap-intc.c
@@ -207,7 +207,6 @@ static int __init omap_alloc_gc_of(struct irq_domain *d, void __iomem *base)
 		ct = gc->chip_types;
 
 		ct->type = IRQ_TYPE_LEVEL_MASK;
-		ct->handler = handle_level_irq;
 
 		ct->chip.irq_ack = omap_mask_ack_irq;
 		ct->chip.irq_mask = irq_gc_mask_disable_reg;
-- 
1.9.1
