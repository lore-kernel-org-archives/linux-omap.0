From: Marc Zyngier <marc.zyngier@arm.com>
Subject: [PATCH v4 03/21] ARM: tegra: skip gic_arch_extn setup if DT has a LIC node
Date: Mon, 19 Jan 2015 09:43:57 +0000
Message-ID: <1421660655-21394-4-git-send-email-marc.zyngier@arm.com>
References: <1421660655-21394-1-git-send-email-marc.zyngier@arm.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1421660655-21394-1-git-send-email-marc.zyngier@arm.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>, Alexandre Courbot <gnurou@gmail.com>, Benoit Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Nishanth Menon <nm@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>, Shawn Guo <shawn.guo@linaro.org>, Sascha Hauer <kernel@pengutronix.de>, Kukjin Kim <kgene.kim@samsung.com>, Pankaj Dubey <pankaj.dubey@samsung.com>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Michal Simek <michal.simek@xilinx.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jason Cooper <jason@lakedaemon.net>, Thomas Gleixner <tglx@linutronix.de>
Cc: Thierry Reding <treding@nvidia.com>, Stefan Agner <stefan@agner.ch>, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

If we detect that our DT has a LIC node, don't setup gic_arch_extn,
and skip tegra_legacy_irq_syscore_init as well.

This is only a temporary measure until that code is removed for good.

Acked-by: Thierry Reding <treding@nvidia.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/mach-tegra/irq.c   | 12 ++++++++++++
 arch/arm/mach-tegra/tegra.c |  1 -
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-tegra/irq.c b/arch/arm/mach-tegra/irq.c
index 7f87a50..1593c4c 100644
--- a/arch/arm/mach-tegra/irq.c
+++ b/arch/arm/mach-tegra/irq.c
@@ -255,11 +255,22 @@ static void tegra114_gic_cpu_pm_registration(void)
 static void tegra114_gic_cpu_pm_registration(void) { }
 #endif
 
+static const struct of_device_id tegra_ictlr_match[] __initconst = {
+	{ .compatible = "nvidia,tegra20-ictlr" },
+	{ .compatible = "nvidia,tegra30-ictlr" },
+	{ }
+};
+
 void __init tegra_init_irq(void)
 {
 	int i;
 	void __iomem *distbase;
 
+	if (of_find_matching_node(NULL, tegra_ictlr_match))
+		goto skip_extn_setup;
+
+	tegra_legacy_irq_syscore_init();
+
 	distbase = IO_ADDRESS(TEGRA_ARM_INT_DIST_BASE);
 	num_ictlrs = readl_relaxed(distbase + GIC_DIST_CTR) & 0x1f;
 
@@ -283,5 +294,6 @@ void __init tegra_init_irq(void)
 	gic_arch_extn.irq_set_wake = tegra_set_wake;
 	gic_arch_extn.flags = IRQCHIP_MASK_ON_SUSPEND;
 
+skip_extn_setup:
 	tegra114_gic_cpu_pm_registration();
 }
diff --git a/arch/arm/mach-tegra/tegra.c b/arch/arm/mach-tegra/tegra.c
index ef016af..c33fba7 100644
--- a/arch/arm/mach-tegra/tegra.c
+++ b/arch/arm/mach-tegra/tegra.c
@@ -82,7 +82,6 @@ static void __init tegra_dt_init_irq(void)
 {
 	tegra_init_irq();
 	irqchip_init();
-	tegra_legacy_irq_syscore_init();
 }
 
 static void __init tegra_dt_init(void)
-- 
2.1.4
