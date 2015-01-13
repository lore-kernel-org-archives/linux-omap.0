From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 2/2] irqchip: omap-intc: Remove unused legacy interface for omap2
Date: Tue, 13 Jan 2015 14:23:26 -0800
Message-ID: <1421187806-6804-3-git-send-email-tony@atomide.com>
References: <1421187806-6804-1-git-send-email-tony@atomide.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1421187806-6804-1-git-send-email-tony@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Felipe Balbi <balbi@ti.com>
List-Id: linux-omap@vger.kernel.org

Nowadays omap2 is booting in device tree only mode so there is no
need to keep the legacy interface around for omap2_init_irq().

Cc: Felipe Balbi <balbi@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/irqchip/irq-omap-intc.c       | 8 --------
 include/linux/irqchip/irq-omap-intc.h | 1 -
 2 files changed, 9 deletions(-)

diff --git a/drivers/irqchip/irq-omap-intc.c b/drivers/irqchip/irq-omap-intc.c
index b75a44a..ece8624 100644
--- a/drivers/irqchip/irq-omap-intc.c
+++ b/drivers/irqchip/irq-omap-intc.c
@@ -348,14 +348,6 @@ out:
 		omap_ack_irq(NULL);
 }
 
-void __init omap2_init_irq(void)
-{
-	omap_nr_irqs = 96;
-	omap_nr_pending = 3;
-	omap_init_irq(OMAP24XX_IC_BASE, NULL);
-	set_handle_irq(omap_intc_handle_irq);
-}
-
 void __init omap3_init_irq(void)
 {
 	omap_nr_irqs = 96;
diff --git a/include/linux/irqchip/irq-omap-intc.h b/include/linux/irqchip/irq-omap-intc.h
index bda426a..2e3d1af 100644
--- a/include/linux/irqchip/irq-omap-intc.h
+++ b/include/linux/irqchip/irq-omap-intc.h
@@ -18,7 +18,6 @@
 #ifndef __INCLUDE_LINUX_IRQCHIP_IRQ_OMAP_INTC_H
 #define __INCLUDE_LINUX_IRQCHIP_IRQ_OMAP_INTC_H
 
-void omap2_init_irq(void);
 void omap3_init_irq(void);
 
 int omap_irq_pending(void);
-- 
2.1.4
