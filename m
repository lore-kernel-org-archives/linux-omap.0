From: Marc Zyngier <marc.zyngier@arm.com>
Subject: [PATCH v2 16/26] irqchip: vt8500: convert to handle_domain_irq
Date: Tue, 26 Aug 2014 11:03:31 +0100
Message-ID: <1409047421-27649-17-git-send-email-marc.zyngier@arm.com>
References: <1409047421-27649-1-git-send-email-marc.zyngier@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1409047421-27649-1-git-send-email-marc.zyngier@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux@lists.openrisc.net
Cc: linux@arm.linux.org.uk, shawn.guo@freescale.com, kernel@pengutronix.de, tony@atomide.com, catalin.marinas@arm.com, will.deacon@arm.com, jonas@southpole.se, tglx@linutronix.de, jason@lakedaemon.net, shc_work@mail.ru, baohua@kernel.org, maxime.ripard@free-electrons.com, marc.zyngier@arm.com, khilman@linaro.org, sboyd@codeaurora.org, lorenzo.pieralisi@arm.com, larry.bassel@linaro.org, mark.rutland@arm.com, sudeep.holla@arm.com, stefan.kristiansson@saunalahti.fi, vkale@apm.com, schwidefsky@de.ibm.com
List-Id: linux-omap@vger.kernel.org

Use the new handle_domain_irq method to handle interrupts.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/irqchip/irq-vt8500.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/irqchip/irq-vt8500.c b/drivers/irqchip/irq-vt8500.c
index eb6e91e..b7af816 100644
--- a/drivers/irqchip/irq-vt8500.c
+++ b/drivers/irqchip/irq-vt8500.c
@@ -181,7 +181,7 @@ static struct irq_domain_ops vt8500_irq_domain_ops = {
 static void __exception_irq_entry vt8500_handle_irq(struct pt_regs *regs)
 {
 	u32 stat, i;
-	int irqnr, virq;
+	int irqnr;
 	void __iomem *base;
 
 	/* Loop through each active controller */
@@ -198,8 +198,7 @@ static void __exception_irq_entry vt8500_handle_irq(struct pt_regs *regs)
 				continue;
 		}
 
-		virq = irq_find_mapping(intc[i].domain, irqnr);
-		handle_IRQ(virq, regs);
+		handle_domain_irq(intc[i].domain, irqnr, regs);
 	}
 }
 
-- 
2.0.4
