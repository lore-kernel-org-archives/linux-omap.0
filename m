From: Marc Zyngier <marc.zyngier@arm.com>
Subject: [PATCH v2 20/26] irqchip: atmel-aic5: convert to handle_domain_irq
Date: Tue, 26 Aug 2014 11:03:35 +0100
Message-ID: <1409047421-27649-21-git-send-email-marc.zyngier@arm.com>
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
 drivers/irqchip/irq-atmel-aic5.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/irqchip/irq-atmel-aic5.c b/drivers/irqchip/irq-atmel-aic5.c
index edb2270..04fe2c1 100644
--- a/drivers/irqchip/irq-atmel-aic5.c
+++ b/drivers/irqchip/irq-atmel-aic5.c
@@ -78,12 +78,10 @@ aic5_handle(struct pt_regs *regs)
 	irqnr = irq_reg_readl(gc->reg_base + AT91_AIC5_IVR);
 	irqstat = irq_reg_readl(gc->reg_base + AT91_AIC5_ISR);
 
-	irqnr = irq_find_mapping(aic5_domain, irqnr);
-
 	if (!irqstat)
 		irq_reg_writel(0, gc->reg_base + AT91_AIC5_EOICR);
 	else
-		handle_IRQ(irqnr, regs);
+		handle_domain_irq(aic5_domain, irqnr, regs);
 }
 
 static void aic5_mask(struct irq_data *d)
-- 
2.0.4
