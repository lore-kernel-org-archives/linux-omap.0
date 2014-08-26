From: Marc Zyngier <marc.zyngier@arm.com>
Subject: [PATCH v2 10/26] irqchip: orion: convert to handle_domain_irq
Date: Tue, 26 Aug 2014 11:03:25 +0100
Message-ID: <1409047421-27649-11-git-send-email-marc.zyngier@arm.com>
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
 drivers/irqchip/irq-orion.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/irqchip/irq-orion.c b/drivers/irqchip/irq-orion.c
index 34d18b4..ad0c0f6 100644
--- a/drivers/irqchip/irq-orion.c
+++ b/drivers/irqchip/irq-orion.c
@@ -43,9 +43,8 @@ __exception_irq_entry orion_handle_irq(struct pt_regs *regs)
 			gc->mask_cache;
 		while (stat) {
 			u32 hwirq = __fls(stat);
-			u32 irq = irq_find_mapping(orion_irq_domain,
-						   gc->irq_base + hwirq);
-			handle_IRQ(irq, regs);
+			handle_domain_irq(orion_irq_domain,
+					  gc->irq_base + hwirq, regs);
 			stat &= ~(1 << hwirq);
 		}
 	}
-- 
2.0.4
