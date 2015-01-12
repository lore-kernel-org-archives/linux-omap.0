From: Marc Zyngier <marc.zyngier@arm.com>
Subject: [PATCH v3 19/21] ARM: ux500: switch from gic_arch_extn to gic_set_irqchip_flags
Date: Mon, 12 Jan 2015 18:26:25 +0000
Message-ID: <1421087187-26988-20-git-send-email-marc.zyngier@arm.com>
References: <1421087187-26988-1-git-send-email-marc.zyngier@arm.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from foss-mx-na.foss.arm.com ([217.140.108.86]:60564 "EHLO
	foss-mx-na.foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753405AbbALS1d (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 12 Jan 2015 13:27:33 -0500
In-Reply-To: <1421087187-26988-1-git-send-email-marc.zyngier@arm.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>, Alexandre Courbot <gnurou@gmail.com>, Benoit Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Nishanth Menon <nm@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>, Shawn Guo <shawn.guo@linaro.org>, Sascha Hauer <kernel@pengutronix.de>, Kukjin Kim <kgene.kim@samsung.com>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Michal Simek <michal.simek@xilinx.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jason Cooper <jason@lakedaemon.net>, Thomas Gleixner <tglx@linutronix.de>
Cc: Stefan Agner <stefan@agner.ch>, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-omap@vger.kernel.org

Instead of directly touching gic_arch_extn, which is about to
be removed, use gic_set_irqchip_flags instead.

Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/mach-ux500/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-ux500/cpu.c b/arch/arm/mach-ux500/cpu.c
index dbb2970..6ced0f6 100644
--- a/arch/arm/mach-ux500/cpu.c
+++ b/arch/arm/mach-ux500/cpu.c
@@ -52,7 +52,7 @@ void ux500_restart(enum reboot_mode mode, const char *cmd)
 */
 void __init ux500_init_irq(void)
 {
-	gic_arch_extn.flags = IRQCHIP_SKIP_SET_WAKE | IRQCHIP_MASK_ON_SUSPEND;
+	gic_set_irqchip_flags(IRQCHIP_SKIP_SET_WAKE | IRQCHIP_MASK_ON_SUSPEND);
 	irqchip_init();
 
 	/*
-- 
2.1.4

