From: Marc Zyngier <marc.zyngier@arm.com>
Subject: [PATCH v2 26/26] openrisc: get rid of handle_IRQ
Date: Tue, 26 Aug 2014 11:03:41 +0100
Message-ID: <1409047421-27649-27-git-send-email-marc.zyngier@arm.com>
References: <1409047421-27649-1-git-send-email-marc.zyngier@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1409047421-27649-1-git-send-email-marc.zyngier@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux@lists.openrisc.net
Cc: linux@arm.linux.org.uk, shawn.guo@freescale.com, kernel@pengutronix.de, tony@atomide.com, catalin.marinas@arm.com, will.deacon@arm.com, jonas@southpole.se, tglx@linutronix.de, jason@lakedaemon.net, shc_work@mail.ru, baohua@kernel.org, maxime.ripard@free-electrons.com, marc.zyngier@arm.com, khilman@linaro.org, sboyd@codeaurora.org, lorenzo.pieralisi@arm.com, larry.bassel@linaro.org, mark.rutland@arm.com, sudeep.holla@arm.com, stefan.kristiansson@saunalahti.fi, vkale@apm.com, schwidefsky@de.ibm.com
List-Id: linux-omap@vger.kernel.org

The openrisc irqchip driver has been converted to handle_domain_irq,
making it possible to remove the handle_IRQ stub entierely.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/openrisc/include/asm/irq.h | 1 -
 arch/openrisc/kernel/irq.c      | 5 -----
 2 files changed, 6 deletions(-)

diff --git a/arch/openrisc/include/asm/irq.h b/arch/openrisc/include/asm/irq.h
index b84634c..d9eee0a 100644
--- a/arch/openrisc/include/asm/irq.h
+++ b/arch/openrisc/include/asm/irq.h
@@ -24,7 +24,6 @@
 
 #define NO_IRQ		(-1)
 
-void handle_IRQ(unsigned int, struct pt_regs *);
 extern void set_handle_irq(void (*handle_irq)(struct pt_regs *));
 
 #endif /* __ASM_OPENRISC_IRQ_H__ */
diff --git a/arch/openrisc/kernel/irq.c b/arch/openrisc/kernel/irq.c
index e9aaf28..35e478a 100644
--- a/arch/openrisc/kernel/irq.c
+++ b/arch/openrisc/kernel/irq.c
@@ -48,11 +48,6 @@ void __init set_handle_irq(void (*handle_irq)(struct pt_regs *))
 	handle_arch_irq = handle_irq;
 }
 
-void handle_IRQ(unsigned int irq, struct pt_regs *regs)
-{
-	__handle_domain_irq(NULL, irq, false, regs);
-}
-
 void __irq_entry do_IRQ(struct pt_regs *regs)
 {
 	handle_arch_irq(regs);
-- 
2.0.4
