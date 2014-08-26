From: Marc Zyngier <marc.zyngier@arm.com>
Subject: [PATCH v2 14/26] irqchip: versatile-fpga: convert to handle_domain_irq
Date: Tue, 26 Aug 2014 11:03:29 +0100
Message-ID: <1409047421-27649-15-git-send-email-marc.zyngier@arm.com>
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
 drivers/irqchip/irq-versatile-fpga.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-versatile-fpga.c b/drivers/irqchip/irq-versatile-fpga.c
index ccf5854..1ab4517 100644
--- a/drivers/irqchip/irq-versatile-fpga.c
+++ b/drivers/irqchip/irq-versatile-fpga.c
@@ -96,7 +96,7 @@ static int handle_one_fpga(struct fpga_irq_data *f, struct pt_regs *regs)
 
 	while ((status  = readl(f->base + IRQ_STATUS))) {
 		irq = ffs(status) - 1;
-		handle_IRQ(irq_find_mapping(f->domain, irq), regs);
+		handle_domain_irq(f->domain, irq, regs);
 		handled = 1;
 	}
 
-- 
2.0.4
