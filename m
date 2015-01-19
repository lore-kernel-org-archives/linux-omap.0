From: Marc Zyngier <marc.zyngier@arm.com>
Subject: [PATCH v4 15/21] ARM: exynos4/5: convert pmu wakeup to stacked domains
Date: Mon, 19 Jan 2015 09:44:09 +0000
Message-ID: <1421660655-21394-16-git-send-email-marc.zyngier@arm.com>
References: <1421660655-21394-1-git-send-email-marc.zyngier@arm.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from foss-mx-na.foss.arm.com ([217.140.108.86]:37468 "EHLO
	foss-mx-na.foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752004AbbASJpM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 19 Jan 2015 04:45:12 -0500
In-Reply-To: <1421660655-21394-1-git-send-email-marc.zyngier@arm.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>, Alexandre Courbot <gnurou@gmail.com>, Benoit Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Nishanth Menon <nm@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>, Shawn Guo <shawn.guo@linaro.org>, Sascha Hauer <kernel@pengutronix.de>, Kukjin Kim <kgene.kim@samsung.com>, Pankaj Dubey <pankaj.dubey@samsung.com>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Michal Simek <michal.simek@xilinx.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jason Cooper <jason@lakedaemon.net>, Thomas Gleixner <tglx@linutronix.de>
Cc: Stefan Agner <stefan@agner.ch>, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-omap@vger.kernel.org

Exynos has been (ab)using the gic_arch_extn to provide
wakeup from suspend, and it makes a lot of sense to convert
this code to use stacked domains instead.

This patch does just this, updating the DT files to actually
reflect what the HW provides.

BIG FAT WARNING: because the DTs were so far lying by not
exposing the fact that the PMU block is actually the first
interrupt controller in the chain for RTC, kernels with this patch
applied wont have any suspend-resume facility when booted
with old DTs, and old kernels with updated DTs may not even boot.

Also, I stronly suspect that there is more than two wake-up
interrupts on these platforms, but I leave it to the maintainers
to fix their mess.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/boot/dts/exynos4.dtsi    |   4 ++
 arch/arm/boot/dts/exynos5250.dtsi |   4 ++
 arch/arm/boot/dts/exynos5420.dtsi |   4 ++
 arch/arm/mach-exynos/exynos.c     |  14 ++---
 arch/arm/mach-exynos/suspend.c    | 122 ++++++++++++++++++++++++++++++++++----
 5 files changed, 129 insertions(+), 19 deletions(-)

diff --git a/arch/arm/boot/dts/exynos4.dtsi b/arch/arm/boot/dts/exynos4.dtsi
index b8168f1..0e7d74e 100644
--- a/arch/arm/boot/dts/exynos4.dtsi
+++ b/arch/arm/boot/dts/exynos4.dtsi
@@ -141,6 +141,9 @@
 	pmu_system_controller: system-controller@10020000 {
 		compatible = "samsung,exynos4210-pmu", "syscon";
 		reg = <0x10020000 0x4000>;
+		interrupt-controller;
+		#interrupt-cells = <3>;
+		interrupt-parent = <&gic>;
 	};
 
 	dsi_0: dsi@11C80000 {
@@ -253,6 +256,7 @@
 	rtc@10070000 {
 		compatible = "samsung,s3c6410-rtc";
 		reg = <0x10070000 0x100>;
+		interrupt-parent = <&pmu_system_controller>;
 		interrupts = <0 44 0>, <0 45 0>;
 		clocks = <&clock CLK_RTC>;
 		clock-names = "rtc";
diff --git a/arch/arm/boot/dts/exynos5250.dtsi b/arch/arm/boot/dts/exynos5250.dtsi
index 0a229fc..1dc5f6b 100644
--- a/arch/arm/boot/dts/exynos5250.dtsi
+++ b/arch/arm/boot/dts/exynos5250.dtsi
@@ -194,6 +194,9 @@
 		clock-names = "clkout16";
 		clocks = <&clock CLK_FIN_PLL>;
 		#clock-cells = <1>;
+		interrupt-controller;
+		#interrupt-cells = <3>;
+		interrupt-parent = <&gic>;
 	};
 
 	sysreg_system_controller: syscon@10050000 {
@@ -230,6 +233,7 @@
 	rtc: rtc@101E0000 {
 		clocks = <&clock CLK_RTC>;
 		clock-names = "rtc";
+		interrupt-parent = <&pmu_system_controller>;
 		status = "disabled";
 	};
 
diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
index 517e50f..35ecd36 100644
--- a/arch/arm/boot/dts/exynos5420.dtsi
+++ b/arch/arm/boot/dts/exynos5420.dtsi
@@ -309,6 +309,7 @@
 	rtc: rtc@101E0000 {
 		clocks = <&clock CLK_RTC>;
 		clock-names = "rtc";
+		interrupt-parent = <&pmu_system_controller>;
 		status = "disabled";
 	};
 
@@ -748,6 +749,9 @@
 		clock-names = "clkout16";
 		clocks = <&clock CLK_FIN_PLL>;
 		#clock-cells = <1>;
+		interrupt-controller;
+		#interrupt-cells = <3>;
+		interrupt-parent = <&gic>;
 	};
 
 	sysreg_system_controller: syscon@10050000 {
diff --git a/arch/arm/mach-exynos/exynos.c b/arch/arm/mach-exynos/exynos.c
index c13d083..e417fdc 100644
--- a/arch/arm/mach-exynos/exynos.c
+++ b/arch/arm/mach-exynos/exynos.c
@@ -175,16 +175,15 @@ static void __init exynos_init_io(void)
 	exynos_map_io();
 }
 
+/*
+ * Apparently, these SoCs are not able to wake-up from suspend using
+ * the PMU. Too bad. Should they suddenly become capable of such a
+ * feat, the matches below should be moved to suspend.c.
+ */
 static const struct of_device_id exynos_dt_pmu_match[] = {
 	{ .compatible = "samsung,exynos3250-pmu" },
-	{ .compatible = "samsung,exynos4210-pmu" },
-	{ .compatible = "samsung,exynos4212-pmu" },
-	{ .compatible = "samsung,exynos4412-pmu" },
-	{ .compatible = "samsung,exynos4415-pmu" },
-	{ .compatible = "samsung,exynos5250-pmu" },
 	{ .compatible = "samsung,exynos5260-pmu" },
 	{ .compatible = "samsung,exynos5410-pmu" },
-	{ .compatible = "samsung,exynos5420-pmu" },
 	{ /*sentinel*/ },
 };
 
@@ -195,9 +194,6 @@ static void exynos_map_pmu(void)
 	np = of_find_matching_node(NULL, exynos_dt_pmu_match);
 	if (np)
 		pmu_base_addr = of_iomap(np, 0);
-
-	if (!pmu_base_addr)
-		panic("failed to find exynos pmu register\n");
 }
 
 static void __init exynos_init_irq(void)
diff --git a/arch/arm/mach-exynos/suspend.c b/arch/arm/mach-exynos/suspend.c
index f8e7dcd..b325ecd 100644
--- a/arch/arm/mach-exynos/suspend.c
+++ b/arch/arm/mach-exynos/suspend.c
@@ -18,7 +18,9 @@
 #include <linux/syscore_ops.h>
 #include <linux/cpu_pm.h>
 #include <linux/io.h>
-#include <linux/irqchip/arm-gic.h>
+#include <linux/irq.h>
+#include <linux/irqdomain.h>
+#include <linux/of_address.h>
 #include <linux/err.h>
 #include <linux/regulator/machine.h>
 
@@ -44,8 +46,8 @@
 #define EXYNOS5420_CPU_STATE	0x28
 
 /**
- * struct exynos_wkup_irq - Exynos GIC to PMU IRQ mapping
- * @hwirq: Hardware IRQ signal of the GIC
+ * struct exynos_wkup_irq - PMU IRQ to mask mapping
+ * @hwirq: Hardware IRQ signal of the PMU
  * @mask: Mask in PMU wake-up mask register
  */
 struct exynos_wkup_irq {
@@ -92,14 +94,14 @@ static unsigned int exynos_pmu_spare3;
 static u32 exynos_irqwake_intmask = 0xffffffff;
 
 static const struct exynos_wkup_irq exynos4_wkup_irq[] = {
-	{ 76, BIT(1) }, /* RTC alarm */
-	{ 77, BIT(2) }, /* RTC tick */
+	{ 44, BIT(1) }, /* RTC alarm */
+	{ 45, BIT(2) }, /* RTC tick */
 	{ /* sentinel */ },
 };
 
 static const struct exynos_wkup_irq exynos5250_wkup_irq[] = {
-	{ 75, BIT(1) }, /* RTC alarm */
-	{ 76, BIT(2) }, /* RTC tick */
+	{ 43, BIT(1) }, /* RTC alarm */
+	{ 44, BIT(2) }, /* RTC tick */
 	{ /* sentinel */ },
 };
 
@@ -153,6 +155,109 @@ static int exynos_irq_set_wake(struct irq_data *data, unsigned int state)
 	return -ENOENT;
 }
 
+static struct irq_chip exynos_pmu_chip = {
+	.name		= "PMU",
+	.irq_eoi	= irq_chip_eoi_parent,
+	.irq_mask	= irq_chip_mask_parent,
+	.irq_unmask	= irq_chip_unmask_parent,
+	.irq_retrigger	= irq_chip_retrigger_hierarchy,
+	.irq_set_wake	= exynos_irq_set_wake,
+};
+
+static int exynos_pmu_domain_xlate(struct irq_domain *domain,
+				   struct device_node *controller,
+				   const u32 *intspec,
+				   unsigned int intsize,
+				   unsigned long *out_hwirq,
+				   unsigned int *out_type)
+{
+	if (domain->of_node != controller)
+		return -EINVAL;	/* Shouldn't happen, really... */
+	if (intsize != 3)
+		return -EINVAL;	/* Not GIC compliant */
+	if (intspec[0] != 0)
+		return -EINVAL;	/* No PPI should point to this domain */
+
+	*out_hwirq = intspec[1];
+	*out_type = intspec[2];
+	return 0;
+}
+
+static int exynos_pmu_domain_alloc(struct irq_domain *domain,
+				   unsigned int virq,
+				   unsigned int nr_irqs, void *data)
+{
+	struct of_phandle_args *args = data;
+	struct of_phandle_args parent_args;
+	irq_hw_number_t hwirq;
+	int i;
+
+	if (args->args_count != 3)
+		return -EINVAL;	/* Not GIC compliant */
+	if (args->args[0] != 0)
+		return -EINVAL;	/* No PPI should point to this domain */
+
+	hwirq = args->args[1];
+
+	for (i = 0; i < nr_irqs; i++)
+		irq_domain_set_hwirq_and_chip(domain, virq + i, hwirq + i,
+					      &exynos_pmu_chip, NULL);
+
+	parent_args = *args;
+	parent_args.np = domain->parent->of_node;
+	return irq_domain_alloc_irqs_parent(domain, virq, nr_irqs, &parent_args);
+}
+
+static struct irq_domain_ops exynos_pmu_domain_ops = {
+	.xlate	= exynos_pmu_domain_xlate,
+	.alloc	= exynos_pmu_domain_alloc,
+	.free	= irq_domain_free_irqs_common,
+};
+
+static int __init exynos_pmu_irq_init(struct device_node *node,
+				      struct device_node *parent)
+{
+	struct irq_domain *parent_domain, *domain;
+
+	if (!parent) {
+		pr_err("%s: no parent, giving up\n", node->full_name);
+		return -ENODEV;
+	}
+
+	parent_domain = irq_find_host(parent);
+	if (!parent_domain) {
+		pr_err("%s: unable to obtain parent domain\n", node->full_name);
+		return -ENXIO;
+	}
+
+	pmu_base_addr = of_iomap(node, 0);
+
+	if (!pmu_base_addr) {
+		pr_err("%s: failed to find exynos pmu register\n",
+		       node->full_name);
+		return -ENOMEM;
+	}
+
+	domain = irq_domain_add_hierarchy(parent_domain, 0, 0,
+					  node, &exynos_pmu_domain_ops,
+					  NULL);
+	if (!domain) {
+		iounmap(pmu_base_addr);
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+
+#define EXYNOS_PMU_IRQ(symbol, name)	OF_DECLARE_2(irqchip, symbol, name, exynos_pmu_irq_init)
+
+EXYNOS_PMU_IRQ(exynos4210_pmu_irq, "samsung,exynos4210-pmu");
+EXYNOS_PMU_IRQ(exynos4212_pmu_irq, "samsung,exynos4212-pmu");
+EXYNOS_PMU_IRQ(exynos4412_pmu_irq, "samsung,exynos4412-pmu");
+EXYNOS_PMU_IRQ(exynos4415_pmu_irq, "samsung,exynos4415-pmu");
+EXYNOS_PMU_IRQ(exynos5250_pmu_irq, "samsung,exynos5250-pmu");
+EXYNOS_PMU_IRQ(exynos5420_pmu_irq, "samsung,exynos5420-pmu");
+
 static int exynos_cpu_do_idle(void)
 {
 	/* issue the standby signal into the pm unit. */
@@ -550,9 +655,6 @@ void __init exynos_pm_init(void)
 	}
 	pm_data = (struct exynos_pm_data *) match->data;
 
-	/* Platform-specific GIC callback */
-	gic_arch_extn.irq_set_wake = exynos_irq_set_wake;
-
 	/* All wakeup disable */
 	tmp = pmu_raw_readl(S5P_WAKEUP_MASK);
 	tmp |= pm_data->wake_disable_mask;
-- 
2.1.4

