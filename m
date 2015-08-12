From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [PATCH v2 4/6] irqchip: crossbar: fix arm gic irq type configuration
Date: Wed, 12 Aug 2015 20:46:00 +0300
Message-ID: <1439401562-28874-5-git-send-email-grygorii.strashko@ti.com>
References: <1439401562-28874-1-git-send-email-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1439401562-28874-1-git-send-email-grygorii.strashko@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: tglx@linutronix.de, tony@atomide.com, marc.zyngier@arm.com
Cc: linux@arm.linux.org.uk, nsekhar@ti.com, jason@lakedaemon.net, balbi@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Grygorii Strashko <grygorii.strashko@ti.com>
List-Id: linux-omap@vger.kernel.org

It's observed that ARM GIC IRQ triggering type is not configured
properly when IRQ is routed through IRQ domain hierarchy and
system started using DT. As result, system will start using default
ARM GIC configuration, ignore DT IRQ triggering configuration,
and value of desc->irq_data.state_use_accessors = 0.

In case of TI OMAP DRA7 the following IRQ hierarchy is defined:
ARM GIC <- OMAP wakeupgen <- TI CBAR

Failed call chain:
     irq_create_of_mapping
     irq_set_irq_type
     __irq_set_trigger
     if (!chip || !chip->irq_set_type) {
        return 0; <- return here
     }
Crossbar has no .irq_set_type() defined and, so, IRQ triggering
configuration will not be propagated to parent IRQ domain.

Hence, fix it by using irq_chip_set_type_parent() for
propagation IRQ triggering type to parent IRQ domains.

Fixes: 783d31863fb8 ('irqchip: crossbar: Convert dra7 crossbar...')
Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 drivers/irqchip/irq-crossbar.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/irqchip/irq-crossbar.c b/drivers/irqchip/irq-crossbar.c
index 692fe2b..3ba58e7 100644
--- a/drivers/irqchip/irq-crossbar.c
+++ b/drivers/irqchip/irq-crossbar.c
@@ -69,6 +69,7 @@ static struct irq_chip crossbar_chip = {
 	.irq_unmask		= irq_chip_unmask_parent,
 	.irq_retrigger		= irq_chip_retrigger_hierarchy,
 	.irq_set_wake		= irq_chip_set_wake_parent,
+	.irq_set_type		= irq_chip_set_type_parent,
 #ifdef CONFIG_SMP
 	.irq_set_affinity	= irq_chip_set_affinity_parent,
 #endif
-- 
2.5.0
