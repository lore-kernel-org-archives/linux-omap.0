From: Marc Zyngier <marc.zyngier@arm.com>
Subject: [PATCH v2 11/26] irqchip: s3c24xx: convert to handle_domain_irq
Date: Tue, 26 Aug 2014 11:03:26 +0100
Message-ID: <1409047421-27649-12-git-send-email-marc.zyngier@arm.com>
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
 drivers/irqchip/irq-s3c24xx.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/irqchip/irq-s3c24xx.c b/drivers/irqchip/irq-s3c24xx.c
index 78a6acc..c8d373f 100644
--- a/drivers/irqchip/irq-s3c24xx.c
+++ b/drivers/irqchip/irq-s3c24xx.c
@@ -339,7 +339,6 @@ static inline int s3c24xx_handle_intc(struct s3c_irq_intc *intc,
 {
 	int pnd;
 	int offset;
-	int irq;
 
 	pnd = __raw_readl(intc->reg_intpnd);
 	if (!pnd)
@@ -365,8 +364,7 @@ static inline int s3c24xx_handle_intc(struct s3c_irq_intc *intc,
 	if (!(pnd & (1 << offset)))
 		offset =  __ffs(pnd);
 
-	irq = irq_find_mapping(intc->domain, intc_offset + offset);
-	handle_IRQ(irq, regs);
+	handle_domain_irq(intc->domain, intc_offset + offset, regs);
 	return true;
 }
 
-- 
2.0.4
