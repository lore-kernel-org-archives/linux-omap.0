From: Marc Zyngier <marc.zyngier@arm.com>
Subject: [PATCH v4 01/21] ARM: tegra: irq: nuke leftovers from non-DT support
Date: Mon, 19 Jan 2015 09:43:55 +0000
Message-ID: <1421660655-21394-2-git-send-email-marc.zyngier@arm.com>
References: <1421660655-21394-1-git-send-email-marc.zyngier@arm.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from foss-mx-na.foss.arm.com ([217.140.108.86]:37247 "EHLO
	foss-mx-na.foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751767AbbASJo3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 19 Jan 2015 04:44:29 -0500
In-Reply-To: <1421660655-21394-1-git-send-email-marc.zyngier@arm.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>, Alexandre Courbot <gnurou@gmail.com>, Benoit Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Nishanth Menon <nm@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>, Shawn Guo <shawn.guo@linaro.org>, Sascha Hauer <kernel@pengutronix.de>, Kukjin Kim <kgene.kim@samsung.com>, Pankaj Dubey <pankaj.dubey@samsung.com>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Michal Simek <michal.simek@xilinx.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jason Cooper <jason@lakedaemon.net>, Thomas Gleixner <tglx@linutronix.de>
Cc: Thierry Reding <treding@nvidia.com>, Stefan Agner <stefan@agner.ch>, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-omap@vger.kernel.org

The GIC is now always initialized from DT on tegra, and there is
no point in keeping non-DT init code.

Acked-by: Thierry Reding <treding@nvidia.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/mach-tegra/irq.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/arch/arm/mach-tegra/irq.c b/arch/arm/mach-tegra/irq.c
index ab95f53..7f87a50 100644
--- a/arch/arm/mach-tegra/irq.c
+++ b/arch/arm/mach-tegra/irq.c
@@ -283,13 +283,5 @@ void __init tegra_init_irq(void)
 	gic_arch_extn.irq_set_wake = tegra_set_wake;
 	gic_arch_extn.flags = IRQCHIP_MASK_ON_SUSPEND;
 
-	/*
-	 * Check if there is a devicetree present, since the GIC will be
-	 * initialized elsewhere under DT.
-	 */
-	if (!of_have_populated_dt())
-		gic_init(0, 29, distbase,
-			IO_ADDRESS(TEGRA_ARM_PERIF_BASE + 0x100));
-
 	tegra114_gic_cpu_pm_registration();
 }
-- 
2.1.4

