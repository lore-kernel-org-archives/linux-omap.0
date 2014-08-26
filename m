From: Marc Zyngier <marc.zyngier@arm.com>
Subject: [PATCH v2 06/26] irqchip: armada-370-xp: convert to handle_domain_irq
Date: Tue, 26 Aug 2014 11:03:21 +0100
Message-ID: <1409047421-27649-7-git-send-email-marc.zyngier@arm.com>
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
 drivers/irqchip/irq-armada-370-xp.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/irqchip/irq-armada-370-xp.c b/drivers/irqchip/irq-armada-370-xp.c
index 574aba0..fa75a29 100644
--- a/drivers/irqchip/irq-armada-370-xp.c
+++ b/drivers/irqchip/irq-armada-370-xp.c
@@ -393,13 +393,15 @@ static void armada_370_xp_handle_msi_irq(struct pt_regs *regs, bool is_chained)
 		if (!(msimask & BIT(msinr)))
 			continue;
 
-		irq = irq_find_mapping(armada_370_xp_msi_domain,
-				       msinr - 16);
-
-		if (is_chained)
+		if (is_chained) {
+			irq = irq_find_mapping(armada_370_xp_msi_domain,
+					       msinr - 16);
 			generic_handle_irq(irq);
-		else
-			handle_IRQ(irq, regs);
+		} else {
+			irq = msinr - 16;
+			handle_domain_irq(armada_370_xp_msi_domain,
+					  irq, regs);
+		}
 	}
 }
 #else
@@ -444,9 +446,8 @@ armada_370_xp_handle_irq(struct pt_regs *regs)
 			break;
 
 		if (irqnr > 1) {
-			irqnr =	irq_find_mapping(armada_370_xp_mpic_domain,
-					irqnr);
-			handle_IRQ(irqnr, regs);
+			handle_domain_irq(armada_370_xp_mpic_domain,
+					  irqnr, regs);
 			continue;
 		}
 
-- 
2.0.4
