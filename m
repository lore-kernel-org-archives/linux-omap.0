From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH RESEND] irqchip: omap-intc: improve IRQ handler
Date: Mon, 20 Jul 2015 11:45:59 -0500
Message-ID: <1437410759-4945-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Tony Lindgren <tony@atomide.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Felipe Balbi <balbi@ti.com>
List-Id: linux-omap@vger.kernel.org

as it turns out the current IRQ number will
*always* be available from SIR register which
renders the reads of PENDING registers as plain
unnecessary overhead.

In order to catch any situation where SIR reads
as zero, we're adding a WARN() to turn it into
a very verbose error and users actually report
it.

With this patch average running time of
omap_intc_handle_irq() reduced from about 28.5us
to 19.8us as measured by the kernel function
profiler.

Tested with BeagleBoneBlack Rev A5C.

Tested-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/irqchip/irq-omap-intc.c | 35 +++++------------------------------
 1 file changed, 5 insertions(+), 30 deletions(-)

diff --git a/drivers/irqchip/irq-omap-intc.c b/drivers/irqchip/irq-omap-intc.c
index a569c6dbd1d1..0706db624213 100644
--- a/drivers/irqchip/irq-omap-intc.c
+++ b/drivers/irqchip/irq-omap-intc.c
@@ -331,37 +331,12 @@ static int __init omap_init_irq(u32 base, struct device_node *node)
 static asmlinkage void __exception_irq_entry
 omap_intc_handle_irq(struct pt_regs *regs)
 {
-	u32 irqnr = 0;
-	int handled_irq = 0;
-	int i;
-
-	do {
-		for (i = 0; i < omap_nr_pending; i++) {
-			irqnr = intc_readl(INTC_PENDING_IRQ0 + (0x20 * i));
-			if (irqnr)
-				goto out;
-		}
-
-out:
-		if (!irqnr)
-			break;
-
-		irqnr = intc_readl(INTC_SIR);
-		irqnr &= ACTIVEIRQ_MASK;
+	u32 irqnr;
 
-		if (irqnr) {
-			handle_domain_irq(domain, irqnr, regs);
-			handled_irq = 1;
-		}
-	} while (irqnr);
-
-	/*
-	 * If an irq is masked or deasserted while active, we will
-	 * keep ending up here with no irq handled. So remove it from
-	 * the INTC with an ack.
-	 */
-	if (!handled_irq)
-		omap_ack_irq(NULL);
+	irqnr = intc_readl(INTC_SIR);
+	irqnr &= ACTIVEIRQ_MASK;
+	WARN(!irqnr, "Spurious IRQ ?\n");
+	handle_domain_irq(domain, irqnr, regs);
 }
 
 void __init omap3_init_irq(void)
-- 
2.4.4
