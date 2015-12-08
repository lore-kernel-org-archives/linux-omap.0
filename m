From: Sekhar Nori <nsekhar@ti.com>
Subject: [PATCH v2] irqchip: omap-intc: add support for spurious irq handling
Date: Tue, 8 Dec 2015 16:32:25 +0530
Message-ID: <0958510b69cf679fef64ccf535b1cdc43c5ffccc.1449572109.git.nsekhar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>
Cc: John Ogness <john.ogness@linutronix.de>, Felipe Balbi <balbi@ti.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Under some conditions, irq sorting procedure used
by INTC can go wrong resulting in a spurious irq
getting reported.

If this condition is not handled, it results in
endless stream of:

    unexpected IRQ trap at vector 00

messages from ack_bad_irq()

Handle the spurious interrupt condition in omap-intc
driver to prevent this.

Signed-off-by: Sekhar Nori <nsekhar@ti.com>
---
v2: increment error irq counter, use pr_err_once,
    add a comment on tips to debug spurious irq
    condition.

This patch results in a checkpatch warning about
extern definition of irq_err_count, but looks like
thats the prevalent method of accessing that counter.

 drivers/irqchip/irq-omap-intc.c | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-omap-intc.c b/drivers/irqchip/irq-omap-intc.c
index 8587d0f8d8c0..639708de5529 100644
--- a/drivers/irqchip/irq-omap-intc.c
+++ b/drivers/irqchip/irq-omap-intc.c
@@ -47,6 +47,7 @@
 #define INTC_ILR0		0x0100
 
 #define ACTIVEIRQ_MASK		0x7f	/* omap2/3 active interrupt bits */
+#define SPURIOUSIRQ_MASK	(0x1ffffff << 7)
 #define INTCPS_NR_ILR_REGS	128
 #define INTCPS_NR_MIR_REGS	4
 
@@ -330,11 +331,35 @@ static int __init omap_init_irq(u32 base, struct device_node *node)
 static asmlinkage void __exception_irq_entry
 omap_intc_handle_irq(struct pt_regs *regs)
 {
+	extern unsigned long irq_err_count;
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
+	 *
+	 * Many a times, a spurious interrupt situation has been fixed
+	 * by adding a flush for the posted write acking the IRQ in
+	 * the device driver. Typically, this is going be the device
+	 * driver whose interrupt was handled just before the spurious
+	 * IRQ occurred. Pay attention to those device drivers if you
+	 * run into hitting the spurious IRQ condition below.
+	 */
+	if ((irqnr & SPURIOUSIRQ_MASK) == SPURIOUSIRQ_MASK) {
+		pr_err_once("%s: spurious irq!\n", __func__);
+		irq_err_count++;
+		omap_ack_irq(NULL);
+		return;
+	}
+
 	irqnr &= ACTIVEIRQ_MASK;
-	WARN_ONCE(!irqnr, "Spurious IRQ ?\n");
 	handle_domain_irq(domain, irqnr, regs);
 }
 
-- 
2.6.3
