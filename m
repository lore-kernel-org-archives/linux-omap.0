From: Ladislav Michl <ladis@linux-mips.org>
Subject: [RESEND PATCH] irqchip: irq-omap-intc: Remove omap3_init_irq()
Date: Mon, 16 Oct 2017 18:04:22 +0200
Message-ID: <20171016160422.uu2i7vvrgy7cc4aw@lenoch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Tony Lindgren <tony@atomide.com>
List-Id: linux-omap@vger.kernel.org

We now boot all of mach-omap2 in device tree only mode and
this is now dead code.

Signed-off-by: Ladislav Michl <ladis@linux-mips.org>
Acked-by: Tony Lindgren <tony@atomide.com>
---
 Note: Resend to 'maintainer:IRQCHIP DRIVERS', ack added

 drivers/irqchip/irq-omap-intc.c       | 12 ------------
 include/linux/irqchip/irq-omap-intc.h |  2 --
 2 files changed, 14 deletions(-)

diff --git a/drivers/irqchip/irq-omap-intc.c b/drivers/irqchip/irq-omap-intc.c
index b04a8ac6e744..05f7f06dd711 100644
--- a/drivers/irqchip/irq-omap-intc.c
+++ b/drivers/irqchip/irq-omap-intc.c
@@ -25,10 +25,6 @@
 
 #include <linux/irqchip/irq-omap-intc.h>
 
-/* Define these here for now until we drop all board-files */
-#define OMAP24XX_IC_BASE	0x480fe000
-#define OMAP34XX_IC_BASE	0x48200000
-
 /* selected INTC register offsets */
 
 #define INTC_REVISION		0x0000
@@ -364,14 +360,6 @@ omap_intc_handle_irq(struct pt_regs *regs)
 	handle_domain_irq(domain, irqnr, regs);
 }
 
-void __init omap3_init_irq(void)
-{
-	omap_nr_irqs = 96;
-	omap_nr_pending = 3;
-	omap_init_irq(OMAP34XX_IC_BASE, NULL);
-	set_handle_irq(omap_intc_handle_irq);
-}
-
 static int __init intc_of_init(struct device_node *node,
 			     struct device_node *parent)
 {
diff --git a/include/linux/irqchip/irq-omap-intc.h b/include/linux/irqchip/irq-omap-intc.h
index 2e3d1afeb674..f19ccee7749f 100644
--- a/include/linux/irqchip/irq-omap-intc.h
+++ b/include/linux/irqchip/irq-omap-intc.h
@@ -18,8 +18,6 @@
 #ifndef __INCLUDE_LINUX_IRQCHIP_IRQ_OMAP_INTC_H
 #define __INCLUDE_LINUX_IRQCHIP_IRQ_OMAP_INTC_H
 
-void omap3_init_irq(void);
-
 int omap_irq_pending(void);
 void omap_intc_save_context(void);
 void omap_intc_restore_context(void);
-- 
2.11.0
