From: Sekhar Nori <nsekhar@ti.com>
Subject: [PATCH] irqchip: omap-intc: fix spurious irq handling
Date: Mon, 19 Oct 2015 15:16:31 +0530
Message-ID: <3d433cfeeb93366cadbb1668ebeac2e8006b0fd5.1445247844.git.nsekhar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>, Tony Lindgren <tony@atomide.com>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>
Cc: John Ogness <john.ogness@linutronix.de>, Felipe Balbi <balbi@ti.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Under some conditions, irq sorting procedure used by INTC can go wrong
resulting in a spurious irq getting reported.

This condition is flagged by INTC by setting "Spurious IRQ Flag" in SIR
register to 0x1ffffff. Section 6.2.5 of AM335x TRM revised Jun 2014
describes this.

Using IRQ number 0 for checking this condition is wrong. 0 is a valid
INTC IRQ. For example, on AM335x, it is the emulation interrupt.

Fix handing of spurious interrupt condition in omap-intc driver by
correct detection of spurious interrupt condition.

Since spurious IRQ condition can happen under genuine conditions (see
the section of AM335x TRM for details) and is recoverable, we do not
need a warning splat for users to report. It can however result in
reduced performance so we add a ratelimited debug print to aid
developers.

Signed-off-by: Sekhar Nori <nsekhar@ti.com>
---
 drivers/irqchip/irq-omap-intc.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-omap-intc.c b/drivers/irqchip/irq-omap-intc.c
index 8587d0f8d8c0..739725515fab 100644
--- a/drivers/irqchip/irq-omap-intc.c
+++ b/drivers/irqchip/irq-omap-intc.c
@@ -22,6 +22,8 @@
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
+#include <linux/ratelimit.h>
+#include <linux/printk.h>
 
 /* Define these here for now until we drop all board-files */
 #define OMAP24XX_IC_BASE	0x480fe000
@@ -47,6 +49,7 @@
 #define INTC_ILR0		0x0100
 
 #define ACTIVEIRQ_MASK		0x7f	/* omap2/3 active interrupt bits */
+#define SPURIOUSIRQ_MASK	(0x1ffffff << 7)
 #define INTCPS_NR_ILR_REGS	128
 #define INTCPS_NR_MIR_REGS	4
 
@@ -333,8 +336,23 @@ omap_intc_handle_irq(struct pt_regs *regs)
 	u32 irqnr;
 
 	irqnr = intc_readl(INTC_SIR);
+
+	/*
+	 * A spurious IRQ can result if interrupt that triggered the
+	 * sorting is no longer active during the sorting (10 INTC
+	 * functional clock cycles after interrupt assertion). Or a
+	 * change in interrupt mask affected the result during sorting
+	 * time. There is no special handling required except ignoring
+	 * the SIR register value just read and retrying.
+	 * See section 6.2.5 of AM335x TRM Literature Number: SPRUH73K
+	 */
+	if ((irqnr & SPURIOUSIRQ_MASK) == SPURIOUSIRQ_MASK) {
+		pr_debug_ratelimited("%s: spurious irq!\n", __func__);
+		omap_ack_irq(NULL);
+		return;
+	}
+
 	irqnr &= ACTIVEIRQ_MASK;
-	WARN_ONCE(!irqnr, "Spurious IRQ ?\n");
 	handle_domain_irq(domain, irqnr, regs);
 }
 
-- 
2.4.4.408.g16da57c
