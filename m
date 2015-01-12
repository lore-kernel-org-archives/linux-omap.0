From: Marc Zyngier <marc.zyngier@arm.com>
Subject: [PATCH v3 18/21] ARM: shmobile: remove use of gic_arch_extn.irq_set_wake
Date: Mon, 12 Jan 2015 18:26:24 +0000
Message-ID: <1421087187-26988-19-git-send-email-marc.zyngier@arm.com>
References: <1421087187-26988-1-git-send-email-marc.zyngier@arm.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from foss-mx-na.foss.arm.com ([217.140.108.86]:60542 "EHLO
	foss-mx-na.foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752617AbbALS1a (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 12 Jan 2015 13:27:30 -0500
In-Reply-To: <1421087187-26988-1-git-send-email-marc.zyngier@arm.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>, Alexandre Courbot <gnurou@gmail.com>, Benoit Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Nishanth Menon <nm@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>, Shawn Guo <shawn.guo@linaro.org>, Sascha Hauer <kernel@pengutronix.de>, Kukjin Kim <kgene.kim@samsung.com>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Michal Simek <michal.simek@xilinx.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jason Cooper <jason@lakedaemon.net>, Thomas Gleixner <tglx@linutronix.de>
Cc: Simon Horman <horms+renesas@verge.net.au>, Stefan Agner <stefan@agner.ch>, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-omap@vger.kernel.org

shmobile only uses gic_arch_extn.irq_set_wake to prevent the GIC
from returning -ENXIO when receiving a wake-up configuration request.

It is a lot simpler to tell the irq layer that we don't need any
configuration by using the IRQCHIP_SKIP_SET_WAKE, thanks to the
new gic_set_irqchip_flags function.

Acked-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/mach-shmobile/intc-sh73a0.c   | 7 +------
 arch/arm/mach-shmobile/setup-r8a7779.c | 7 +------
 2 files changed, 2 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mach-shmobile/intc-sh73a0.c b/arch/arm/mach-shmobile/intc-sh73a0.c
index 9e36180..fd63ae6 100644
--- a/arch/arm/mach-shmobile/intc-sh73a0.c
+++ b/arch/arm/mach-shmobile/intc-sh73a0.c
@@ -252,11 +252,6 @@ static irqreturn_t sh73a0_intcs_demux(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static int sh73a0_set_wake(struct irq_data *data, unsigned int on)
-{
-	return 0; /* always allow wakeup */
-}
-
 #define PINTER0_PHYS 0xe69000a0
 #define PINTER1_PHYS 0xe69000a4
 #define PINTER0_VIRT IOMEM(0xe69000a0)
@@ -318,8 +313,8 @@ void __init sh73a0_init_irq(void)
 	void __iomem *gic_cpu_base = IOMEM(0xf0000100);
 	void __iomem *intevtsa = ioremap_nocache(0xffd20100, PAGE_SIZE);
 
+	gic_set_irqchip_flags(IRQCHIP_SKIP_SET_WAKE);
 	gic_init(0, 29, gic_dist_base, gic_cpu_base);
-	gic_arch_extn.irq_set_wake = sh73a0_set_wake;
 
 	register_intc_controller(&intcs_desc);
 	register_intc_controller(&intc_pint0_desc);
diff --git a/arch/arm/mach-shmobile/setup-r8a7779.c b/arch/arm/mach-shmobile/setup-r8a7779.c
index 6156d17..989de2d 100644
--- a/arch/arm/mach-shmobile/setup-r8a7779.c
+++ b/arch/arm/mach-shmobile/setup-r8a7779.c
@@ -713,14 +713,9 @@ void __init r8a7779_init_late(void)
 }
 
 #ifdef CONFIG_USE_OF
-static int r8a7779_set_wake(struct irq_data *data, unsigned int on)
-{
-	return 0; /* always allow wakeup */
-}
-
 void __init r8a7779_init_irq_dt(void)
 {
-	gic_arch_extn.irq_set_wake = r8a7779_set_wake;
+	gic_set_irqchip_flags(IRQCHIP_SKIP_SET_WAKE);
 
 	irqchip_init();
 
-- 
2.1.4

