From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [PATCH 51/75] ARM: l2c: remove platforms/SoCs setting early BRESP
Date: Fri, 28 Mar 2014 15:18:47 +0000
Message-ID: <E1WTYYR-0007GJ-Ai@rmk-PC.arm.linux.org.uk>
References: <20140328151249.GJ7528@n2100.arm.linux.org.uk>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from gw-1.arm.linux.org.uk ([78.32.30.217]:41466 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751373AbaC1PTJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 28 Mar 2014 11:19:09 -0400
In-Reply-To: <20140328151249.GJ7528@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Kukjin Kim <kgene.kim@samsung.com>, Tony Lindgren <tony@atomide.com>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Viresh Kumar <viresh.linux@gmail.com>, Shiraz Hashim <shiraz.hashim@st.com>, Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>, linux-samsung-soc@vger.kernel.org, linux-omap@vger.kernel.org, linux-sh@vger.kernel.org, spear-devel@list.st.com, linux-tegra@vger.kernel.org

Since we now automatically enable early BRESP in core L2C-310 code when
we detect a Cortex-A9, we don't need platforms/SoCs to set this bit
explicitly.  Instead, they should seek to preserve the value of bit 30
in the auxiliary control register.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-berlin/berlin.c                            | 2 +-
 arch/arm/mach-exynos/common.c                            | 4 ++--
 arch/arm/mach-omap2/omap4-common.c                       | 3 +--
 arch/arm/mach-shmobile/board-armadillo800eva-reference.c | 4 ++--
 arch/arm/mach-shmobile/board-armadillo800eva.c           | 4 ++--
 arch/arm/mach-shmobile/board-kzm9g-reference.c           | 4 ++--
 arch/arm/mach-shmobile/board-kzm9g.c                     | 4 ++--
 arch/arm/mach-shmobile/setup-r8a7778.c                   | 4 ++--
 arch/arm/mach-shmobile/setup-r8a7779.c                   | 4 ++--
 arch/arm/mach-spear/spear13xx.c                          | 2 +-
 arch/arm/mach-tegra/tegra.c                              | 4 ++--
 11 files changed, 19 insertions(+), 20 deletions(-)

diff --git a/arch/arm/mach-berlin/berlin.c b/arch/arm/mach-berlin/berlin.c
index 025bcb5473eb..6709d2a6bec8 100644
--- a/arch/arm/mach-berlin/berlin.c
+++ b/arch/arm/mach-berlin/berlin.c
@@ -24,7 +24,7 @@ static void __init berlin_init_machine(void)
 	 * with DT probing for L2CCs, berlin_init_machine can be removed.
 	 * Note: 88DE3005 (Armada 1500-mini) uses pl310 l2cc
 	 */
-	l2x0_of_init(0x70c00000, 0xfeffffff);
+	l2x0_of_init(0x30c00000, 0xfeffffff);
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
 }
 
diff --git a/arch/arm/mach-exynos/common.c b/arch/arm/mach-exynos/common.c
index f18be40e5b21..cd53b72449a0 100644
--- a/arch/arm/mach-exynos/common.c
+++ b/arch/arm/mach-exynos/common.c
@@ -45,8 +45,8 @@
 #include "common.h"
 #include "regs-pmu.h"
 
-#define L2_AUX_VAL 0x7C470001
-#define L2_AUX_MASK 0xC200ffff
+#define L2_AUX_VAL 0x3c470001
+#define L2_AUX_MASK 0xc200ffff
 
 static const char name_exynos4210[] = "EXYNOS4210";
 static const char name_exynos4212[] = "EXYNOS4212";
diff --git a/arch/arm/mach-omap2/omap4-common.c b/arch/arm/mach-omap2/omap4-common.c
index 84e097f5fdf4..ce2fad84a43c 100644
--- a/arch/arm/mach-omap2/omap4-common.c
+++ b/arch/arm/mach-omap2/omap4-common.c
@@ -219,8 +219,7 @@ static int __init omap_l2_cache_init(void)
 		   L2C_AUX_CTRL_WAY_SIZE(3) |
 		   L2C_AUX_CTRL_SHARED_OVERRIDE |
 		   L310_AUX_CTRL_DATA_PREFETCH |
-		   L310_AUX_CTRL_INSTR_PREFETCH |
-		   L310_AUX_CTRL_EARLY_BRESP;
+		   L310_AUX_CTRL_INSTR_PREFETCH;
 
 	outer_cache.write_sec = omap4_l2c310_write_sec;
 	if (of_have_populated_dt())
diff --git a/arch/arm/mach-shmobile/board-armadillo800eva-reference.c b/arch/arm/mach-shmobile/board-armadillo800eva-reference.c
index 57d1a78367b6..34e7f3c17dd2 100644
--- a/arch/arm/mach-shmobile/board-armadillo800eva-reference.c
+++ b/arch/arm/mach-shmobile/board-armadillo800eva-reference.c
@@ -164,8 +164,8 @@ static void __init eva_init(void)
 	r8a7740_meram_workaround();
 
 #ifdef CONFIG_CACHE_L2X0
-	/* Early BRESP enable, Shared attribute override enable, 32K*8way */
-	l2x0_init(IOMEM(0xf0002000), 0x40440000, 0x82000fff);
+	/* Shared attribute override enable, 32K*8way */
+	l2x0_init(IOMEM(0xf0002000), 0x00440000, 0xc2000fff);
 #endif
 
 	r8a7740_add_standard_devices_dt();
diff --git a/arch/arm/mach-shmobile/board-armadillo800eva.c b/arch/arm/mach-shmobile/board-armadillo800eva.c
index 93533e2710a8..69ec71038ec7 100644
--- a/arch/arm/mach-shmobile/board-armadillo800eva.c
+++ b/arch/arm/mach-shmobile/board-armadillo800eva.c
@@ -1270,8 +1270,8 @@ static void __init eva_init(void)
 
 
 #ifdef CONFIG_CACHE_L2X0
-	/* Early BRESP enable, Shared attribute override enable, 32K*8way */
-	l2x0_init(IOMEM(0xf0002000), 0x40440000, 0x82000fff);
+	/* Shared attribute override enable, 32K*8way */
+	l2x0_init(IOMEM(0xf0002000), 0x00440000, 0xc2000fff);
 #endif
 
 	i2c_register_board_info(0, i2c0_devices, ARRAY_SIZE(i2c0_devices));
diff --git a/arch/arm/mach-shmobile/board-kzm9g-reference.c b/arch/arm/mach-shmobile/board-kzm9g-reference.c
index 598e32488410..85873f186d77 100644
--- a/arch/arm/mach-shmobile/board-kzm9g-reference.c
+++ b/arch/arm/mach-shmobile/board-kzm9g-reference.c
@@ -36,8 +36,8 @@ static void __init kzm_init(void)
 	sh73a0_add_standard_devices_dt();
 
 #ifdef CONFIG_CACHE_L2X0
-	/* Early BRESP enable, Shared attribute override enable, 64K*8way */
-	l2x0_init(IOMEM(0xf0100000), 0x40460000, 0x82000fff);
+	/* Shared attribute override enable, 64K*8way */
+	l2x0_init(IOMEM(0xf0100000), 0x00460000, 0xc2000fff);
 #endif
 }
 
diff --git a/arch/arm/mach-shmobile/board-kzm9g.c b/arch/arm/mach-shmobile/board-kzm9g.c
index bc40b853ffd3..bd9931f223ae 100644
--- a/arch/arm/mach-shmobile/board-kzm9g.c
+++ b/arch/arm/mach-shmobile/board-kzm9g.c
@@ -878,8 +878,8 @@ static void __init kzm_init(void)
 	gpio_request_one(223, GPIOF_IN, NULL); /* IRQ8 */
 
 #ifdef CONFIG_CACHE_L2X0
-	/* Early BRESP enable, Shared attribute override enable, 64K*8way */
-	l2x0_init(IOMEM(0xf0100000), 0x40460000, 0x82000fff);
+	/* Shared attribute override enable, 64K*8way */
+	l2x0_init(IOMEM(0xf0100000), 0x00460000, 0xc2000fff);
 #endif
 
 	i2c_register_board_info(0, i2c0_devices, ARRAY_SIZE(i2c0_devices));
diff --git a/arch/arm/mach-shmobile/setup-r8a7778.c b/arch/arm/mach-shmobile/setup-r8a7778.c
index 6d694526e4ca..3a8e5316671e 100644
--- a/arch/arm/mach-shmobile/setup-r8a7778.c
+++ b/arch/arm/mach-shmobile/setup-r8a7778.c
@@ -298,10 +298,10 @@ void __init r8a7778_add_dt_devices(void)
 	void __iomem *base = ioremap_nocache(0xf0100000, 0x1000);
 	if (base) {
 		/*
-		 * Early BRESP enable, Shared attribute override enable, 64K*16way
+		 * Shared attribute override enable, 64K*16way
 		 * don't call iounmap(base)
 		 */
-		l2x0_init(base, 0x40470000, 0x82000fff);
+		l2x0_init(base, 0x00470000, 0xc2000fff);
 	}
 #endif
 
diff --git a/arch/arm/mach-shmobile/setup-r8a7779.c b/arch/arm/mach-shmobile/setup-r8a7779.c
index 8e860b36997a..91c90bf0ae83 100644
--- a/arch/arm/mach-shmobile/setup-r8a7779.c
+++ b/arch/arm/mach-shmobile/setup-r8a7779.c
@@ -700,8 +700,8 @@ static struct platform_device *r8a7779_standard_devices[] __initdata = {
 void __init r8a7779_add_standard_devices(void)
 {
 #ifdef CONFIG_CACHE_L2X0
-	/* Early BRESP enable, Shared attribute override enable, 64K*16way */
-	l2x0_init(IOMEM(0xf0100000), 0x40470000, 0x82000fff);
+	/* Shared attribute override enable, 64K*16way */
+	l2x0_init(IOMEM(0xf0100000), 0x00470000, 0xc2000fff);
 #endif
 	r8a7779_pm_init();
 
diff --git a/arch/arm/mach-spear/spear13xx.c b/arch/arm/mach-spear/spear13xx.c
index 92860fa01668..dcb300443b66 100644
--- a/arch/arm/mach-spear/spear13xx.c
+++ b/arch/arm/mach-spear/spear13xx.c
@@ -46,7 +46,7 @@ void __init spear13xx_l2x0_init(void)
 	 */
 	writel_relaxed(0x221, VA_L2CC_BASE + L310_TAG_LATENCY_CTRL);
 	writel_relaxed(0x441, VA_L2CC_BASE + L310_DATA_LATENCY_CTRL);
-	l2x0_init(VA_L2CC_BASE, 0x70A60001, 0xfe00ffff);
+	l2x0_init(VA_L2CC_BASE, 0x30a60001, 0xfe00ffff);
 }
 
 /*
diff --git a/arch/arm/mach-tegra/tegra.c b/arch/arm/mach-tegra/tegra.c
index 6191603379e1..ecbb5411a104 100644
--- a/arch/arm/mach-tegra/tegra.c
+++ b/arch/arm/mach-tegra/tegra.c
@@ -89,9 +89,9 @@ static void __init tegra_init_cache(void)
 
 	cache_type = readl(p + L2X0_CACHE_TYPE);
 	aux_ctrl = (cache_type & 0x700) << (17-8);
-	aux_ctrl |= 0x7C400001;
+	aux_ctrl |= 0x3c400001;
 
-	ret = l2x0_of_init(aux_ctrl, 0x8200c3fe);
+	ret = l2x0_of_init(aux_ctrl, 0xc200c3fe);
 	if (!ret)
 		l2x0_saved_regs_addr = virt_to_phys(&l2x0_saved_regs);
 #endif
-- 
1.8.3.1

