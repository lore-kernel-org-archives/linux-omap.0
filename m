From: Rob Herring <robh@kernel.org>
Subject: [PATCH v2] ARM: Convert to using %pOF instead of full_name
Date: Fri, 21 Jul 2017 14:28:32 -0500
Message-ID: <20170721192835.25555-1-robh@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: arm@kernel.org
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Russell King <linux@armlinux.org.uk>, Kukjin Kim <kgene@kernel.org>, Javier Martinez Canillas <javier@osg.samsung.com>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <kernel@pengutronix.de>, Fabio Estevam <fabio.estevam@nxp.com>, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Tony Lindgren <tony@atomide.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Paul Walmsley <paul@pwsan.com>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-omap@vger.kernel.org, linux-rockchip@lists.infradead.orglinux-
List-Id: linux-omap@vger.kernel.org

Now that we have a custom printf format specifier, convert users of
full_name to use %pOF instead. This is preparation to remove storing
of the full path string for each node.

Signed-off-by: Rob Herring <robh@kernel.org>
Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
Acked-by: Heiko Stuebner <heiko@sntech.de>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Kukjin Kim <kgene@kernel.org>
Cc: Javier Martinez Canillas <javier@osg.samsung.com>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: Fabio Estevam <fabio.estevam@nxp.com>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: "Benoît Cousson" <bcousson@baylibre.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Simon Horman <horms@verge.net.au>
Cc: Magnus Damm <magnus.damm@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-samsung-soc@vger.kernel.org
Cc: linux-omap@vger.kernel.org
Cc: linux-rockchip@lists.infradead.org
Cc: linux-renesas-soc@vger.kernel.org
---
v2:
- Merge several 2 line prints to single line.
- Add acks

 arch/arm/kernel/cpuidle.c            | 4 ++--
 arch/arm/kernel/devtree.c            | 5 ++---
 arch/arm/kernel/topology.c           | 3 +--
 arch/arm/mach-exynos/suspend.c       | 7 +++----
 arch/arm/mach-imx/gpc.c              | 4 ++--
 arch/arm/mach-mvebu/kirkwood.c       | 3 +--
 arch/arm/mach-omap2/omap-wakeupgen.c | 4 ++--
 arch/arm/mach-omap2/omap_hwmod.c     | 4 ++--
 arch/arm/mach-rockchip/platsmp.c     | 4 ++--
 arch/arm/mach-shmobile/pm-rmobile.c  | 7 +++----
 10 files changed, 20 insertions(+), 25 deletions(-)

diff --git a/arch/arm/kernel/cpuidle.c b/arch/arm/kernel/cpuidle.c
index a3308ad1a024..fda5579123a8 100644
--- a/arch/arm/kernel/cpuidle.c
+++ b/arch/arm/kernel/cpuidle.c
@@ -101,8 +101,8 @@ static int __init arm_cpuidle_read_ops(struct device_node *dn, int cpu)
 
 	ops = arm_cpuidle_get_ops(enable_method);
 	if (!ops) {
-		pr_warn("%s: unsupported enable-method property: %s\n",
-			dn->full_name, enable_method);
+		pr_warn("%pOF: unsupported enable-method property: %s\n",
+			dn, enable_method);
 		return -EOPNOTSUPP;
 	}
 
diff --git a/arch/arm/kernel/devtree.c b/arch/arm/kernel/devtree.c
index f676febbb270..ecaa68dd1af5 100644
--- a/arch/arm/kernel/devtree.c
+++ b/arch/arm/kernel/devtree.c
@@ -95,7 +95,7 @@ void __init arm_dt_init_cpu_maps(void)
 		if (of_node_cmp(cpu->type, "cpu"))
 			continue;
 
-		pr_debug(" * %s...\n", cpu->full_name);
+		pr_debug(" * %pOF...\n", cpu);
 		/*
 		 * A device tree containing CPU nodes with missing "reg"
 		 * properties is considered invalid to build the
@@ -103,8 +103,7 @@ void __init arm_dt_init_cpu_maps(void)
 		 */
 		cell = of_get_property(cpu, "reg", &prop_bytes);
 		if (!cell || prop_bytes < sizeof(*cell)) {
-			pr_debug(" * %s missing reg property\n",
-				     cpu->full_name);
+			pr_debug(" * %pOF missing reg property\n", cpu);
 			of_node_put(cpu);
 			return;
 		}
diff --git a/arch/arm/kernel/topology.c b/arch/arm/kernel/topology.c
index bf949a763dbe..24ac3cab411d 100644
--- a/arch/arm/kernel/topology.c
+++ b/arch/arm/kernel/topology.c
@@ -127,8 +127,7 @@ static void __init parse_dt_topology(void)
 
 		rate = of_get_property(cn, "clock-frequency", &len);
 		if (!rate || len != 4) {
-			pr_err("%s missing clock-frequency property\n",
-				cn->full_name);
+			pr_err("%pOF missing clock-frequency property\n", cn);
 			continue;
 		}
 
diff --git a/arch/arm/mach-exynos/suspend.c b/arch/arm/mach-exynos/suspend.c
index 748cfb8d5212..b529ba04ed16 100644
--- a/arch/arm/mach-exynos/suspend.c
+++ b/arch/arm/mach-exynos/suspend.c
@@ -187,21 +187,20 @@ static int __init exynos_pmu_irq_init(struct device_node *node,
 	struct irq_domain *parent_domain, *domain;
 
 	if (!parent) {
-		pr_err("%s: no parent, giving up\n", node->full_name);
+		pr_err("%pOF: no parent, giving up\n", node);
 		return -ENODEV;
 	}
 
 	parent_domain = irq_find_host(parent);
 	if (!parent_domain) {
-		pr_err("%s: unable to obtain parent domain\n", node->full_name);
+		pr_err("%pOF: unable to obtain parent domain\n", node);
 		return -ENXIO;
 	}
 
 	pmu_base_addr = of_iomap(node, 0);
 
 	if (!pmu_base_addr) {
-		pr_err("%s: failed to find exynos pmu register\n",
-		       node->full_name);
+		pr_err("%pOF: failed to find exynos pmu register\n", node);
 		return -ENOMEM;
 	}
 
diff --git a/arch/arm/mach-imx/gpc.c b/arch/arm/mach-imx/gpc.c
index 93f584ba0130..de535cb679b3 100644
--- a/arch/arm/mach-imx/gpc.c
+++ b/arch/arm/mach-imx/gpc.c
@@ -224,13 +224,13 @@ static int __init imx_gpc_init(struct device_node *node,
 	int i;
 
 	if (!parent) {
-		pr_err("%s: no parent, giving up\n", node->full_name);
+		pr_err("%pOF: no parent, giving up\n", node);
 		return -ENODEV;
 	}
 
 	parent_domain = irq_find_host(parent);
 	if (!parent_domain) {
-		pr_err("%s: unable to obtain parent domain\n", node->full_name);
+		pr_err("%pOF: unable to obtain parent domain\n", node);
 		return -ENXIO;
 	}
 
diff --git a/arch/arm/mach-mvebu/kirkwood.c b/arch/arm/mach-mvebu/kirkwood.c
index 7d9f2fd9e450..0aa88105d46e 100644
--- a/arch/arm/mach-mvebu/kirkwood.c
+++ b/arch/arm/mach-mvebu/kirkwood.c
@@ -107,8 +107,7 @@ static void __init kirkwood_dt_eth_fixup(void)
 		clk_prepare_enable(clk);
 
 		/* store MAC address register contents in local-mac-address */
-		pr_err(FW_INFO "%s: local-mac-address is not set\n",
-		       np->full_name);
+		pr_err(FW_INFO "%pOF: local-mac-address is not set\n", np);
 
 		pmac = kzalloc(sizeof(*pmac) + 6, GFP_KERNEL);
 		if (!pmac)
diff --git a/arch/arm/mach-omap2/omap-wakeupgen.c b/arch/arm/mach-omap2/omap-wakeupgen.c
index 33ed5d53fa45..4bb6751864a5 100644
--- a/arch/arm/mach-omap2/omap-wakeupgen.c
+++ b/arch/arm/mach-omap2/omap-wakeupgen.c
@@ -522,13 +522,13 @@ static int __init wakeupgen_init(struct device_node *node,
 	u32 val;
 
 	if (!parent) {
-		pr_err("%s: no parent, giving up\n", node->full_name);
+		pr_err("%pOF: no parent, giving up\n", node);
 		return -ENODEV;
 	}
 
 	parent_domain = irq_find_host(parent);
 	if (!parent_domain) {
-		pr_err("%s: unable to obtain parent domain\n", node->full_name);
+		pr_err("%pOF: unable to obtain parent domain\n", node);
 		return -ENXIO;
 	}
 	/* Not supported on OMAP4 ES1.0 silicon */
diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 3b47ded5fa0c..2dbd63239c54 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -2417,8 +2417,8 @@ static int __init _init_mpu_rt_base(struct omap_hwmod *oh, void *data,
 		if (mem)
 			pr_err("omap_hwmod: %s: Could not ioremap\n", oh->name);
 		else
-			pr_err("omap_hwmod: %s: Missing dt reg%i for %s\n",
-			       oh->name, index, np->full_name);
+			pr_err("omap_hwmod: %s: Missing dt reg%i for %pOF\n",
+			       oh->name, index, np);
 		return -ENXIO;
 	}
 
diff --git a/arch/arm/mach-rockchip/platsmp.c b/arch/arm/mach-rockchip/platsmp.c
index 3abafdbdd7f4..2b5b0e43d657 100644
--- a/arch/arm/mach-rockchip/platsmp.c
+++ b/arch/arm/mach-rockchip/platsmp.c
@@ -182,8 +182,8 @@ static int __init rockchip_smp_prepare_sram(struct device_node *node)
 
 	ret = of_address_to_resource(node, 0, &res);
 	if (ret < 0) {
-		pr_err("%s: could not get address for node %s\n",
-		       __func__, node->full_name);
+		pr_err("%s: could not get address for node %pOF\n",
+		       __func__, node);
 		return ret;
 	}
 
diff --git a/arch/arm/mach-shmobile/pm-rmobile.c b/arch/arm/mach-shmobile/pm-rmobile.c
index 699429f28b73..3a4ed4c33a68 100644
--- a/arch/arm/mach-shmobile/pm-rmobile.c
+++ b/arch/arm/mach-shmobile/pm-rmobile.c
@@ -195,8 +195,7 @@ static void __init add_special_pd(struct device_node *np, enum pd_types type)
 		return;
 	}
 
-	pr_debug("Special PM domain %s type %d for %s\n", pd->name, type,
-		 np->full_name);
+	pr_debug("Special PM domain %s type %d for %pOF\n", pd->name, type, np);
 
 	special_pds[num_special_pds].pd = pd;
 	special_pds[num_special_pds].type = type;
@@ -331,13 +330,13 @@ static int __init rmobile_init_pm_domains(void)
 	for_each_compatible_node(np, NULL, "renesas,sysc-rmobile") {
 		base = of_iomap(np, 0);
 		if (!base) {
-			pr_warn("%s cannot map reg 0\n", np->full_name);
+			pr_warn("%pOF cannot map reg 0\n", np);
 			continue;
 		}
 
 		pmd = of_get_child_by_name(np, "pm-domains");
 		if (!pmd) {
-			pr_warn("%s lacks pm-domains node\n", np->full_name);
+			pr_warn("%pOF lacks pm-domains node\n", np);
 			continue;
 		}
 
-- 
2.11.0
