From: Dave Martin <dave.martin@linaro.org>
Subject: [PATCH v4 REPOST 1/5] ARM: l2x0/pl310: Refactor Kconfig to be more maintainable
Date: Wed, 14 Dec 2011 11:39:37 +0000
Message-ID: <1323862781-3465-2-git-send-email-dave.martin@linaro.org>
References: <1323862781-3465-1-git-send-email-dave.martin@linaro.org>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1323862781-3465-1-git-send-email-dave.martin@linaro.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: patches@linaro.org, Anton Vorontsov <avorontsov@mvista.com>, Barry Song <baohua.song@csr.com>, Catalin Marinas <catalin.marinas@arm.com>, Colin Cross <ccross@google.com>, Haojian Zhuang <haojian.zhuang@marvell.com>, John Linn <john.linn@xilinx.com>, Kukjin Kim <kgene.kim@samsung.com>, Linus Walleij <linus.walleij@linaro.org>, linux-omap@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-sh@vger.kernel.org, linux-tegra@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Paul Mundt <lethal@linux-sh.org>, Pawel Moll <pawel.moll@arm.com>, Rob Herring <rob.herring@calxeda.com>, Sascha Hauer <kernel@pengutronix.de>, Shawn Guo <shawn.guo@linaro.org>, Tony Lindgren <tony@atomide.com>, Will Deacon <will.deacon@arm.com>
List-Id: linux-omap@vger.kernel.org

Making CACHE_L2X0 depend on (huge list of MACH_ and ARCH_ configs)
is bothersome to maintain and likely to lead to merge conflicts.

This patch moves the knowledge of which platforms have a L2x0 or
PL310 cache controller to the individual machines.  To enable this,
a new MIGHT_HAVE_CACHE_L2X0 config option is introduced to allow
machines to indicate that they may have such a cache controller
independently of each other.

Boards/SoCs which cannot reliably operate without the L2 cache
controller support will need to select CACHE_L2X0 directly from
their own Kconfigs instead.  This applies to some TrustZone-enabled
boards where Linux runs in the Normal World, for example.

Signed-off-by: Dave Martin <dave.martin@linaro.org>
---
 arch/arm/Kconfig               |    8 ++++++++
 arch/arm/mach-exynos/Kconfig   |    1 +
 arch/arm/mach-omap2/Kconfig    |    1 +
 arch/arm/mach-realview/Kconfig |    5 +++++
 arch/arm/mach-vexpress/Kconfig |    1 +
 arch/arm/mm/Kconfig            |   15 ++++++++-------
 arch/arm/plat-mxc/Kconfig      |    1 +
 7 files changed, 25 insertions(+), 7 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 44789ef..16a4b9e 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -344,6 +344,7 @@ config ARCH_HIGHBANK
 	select CPU_V7
 	select GENERIC_CLOCKEVENTS
 	select HAVE_ARM_SCU
+	select MIGHT_HAVE_CACHE_L2X0
 	select USE_OF
 	help
 	  Support for the Calxeda Highbank SoC based boards.
@@ -361,6 +362,7 @@ config ARCH_CNS3XXX
 	select CPU_V6K
 	select GENERIC_CLOCKEVENTS
 	select ARM_GIC
+	select MIGHT_HAVE_CACHE_L2X0
 	select MIGHT_HAVE_PCI
 	select PCI_DOMAINS if PCI
 	help
@@ -381,6 +383,7 @@ config ARCH_PRIMA2
 	select GENERIC_CLOCKEVENTS
 	select CLKDEV_LOOKUP
 	select GENERIC_IRQ_CHIP
+	select MIGHT_HAVE_CACHE_L2X0
 	select USE_OF
 	select ZONE_DMA
 	help
@@ -633,6 +636,7 @@ config ARCH_TEGRA
 	select GENERIC_GPIO
 	select HAVE_CLK
 	select HAVE_SCHED_CLOCK
+	select MIGHT_HAVE_CACHE_L2X0
 	select ARCH_HAS_CPUFREQ
 	help
 	  This enables support for NVIDIA Tegra based systems (Tegra APX,
@@ -703,6 +707,7 @@ config ARCH_SHMOBILE
 	select CLKDEV_LOOKUP
 	select HAVE_MACH_CLKDEV
 	select GENERIC_CLOCKEVENTS
+	select MIGHT_HAVE_CACHE_L2X0
 	select NO_IOPORT
 	select SPARSE_IRQ
 	select MULTI_IRQ_HANDLER
@@ -904,6 +909,7 @@ config ARCH_U8500
 	select CLKDEV_LOOKUP
 	select ARCH_REQUIRE_GPIOLIB
 	select ARCH_HAS_CPUFREQ
+	select MIGHT_HAVE_CACHE_L2X0
 	help
 	  Support for ST-Ericsson's Ux500 architecture
 
@@ -914,6 +920,7 @@ config ARCH_NOMADIK
 	select CPU_ARM926T
 	select CLKDEV_LOOKUP
 	select GENERIC_CLOCKEVENTS
+	select MIGHT_HAVE_CACHE_L2X0
 	select ARCH_REQUIRE_GPIOLIB
 	help
 	  Support for the Nomadik platform by ST-Ericsson
@@ -973,6 +980,7 @@ config ARCH_ZYNQ
 	select ARM_GIC
 	select ARM_AMBA
 	select ICST
+	select MIGHT_HAVE_CACHE_L2X0
 	select USE_OF
 	help
 	  Support for Xilinx Zynq ARM Cortex A9 Platform
diff --git a/arch/arm/mach-exynos/Kconfig b/arch/arm/mach-exynos/Kconfig
index 724ec0f..7f2347b 100644
--- a/arch/arm/mach-exynos/Kconfig
+++ b/arch/arm/mach-exynos/Kconfig
@@ -17,6 +17,7 @@ choice
 
 config ARCH_EXYNOS4
 	bool "SAMSUNG EXYNOS4"
+	select MIGHT_HAVE_CACHE_L2X0
 	help
 	  Samsung EXYNOS4 SoCs based systems
 
diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index 5034147..c841578 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -44,6 +44,7 @@ config ARCH_OMAP4
 	select CPU_V7
 	select ARM_GIC
 	select LOCAL_TIMERS if SMP
+	select MIGHT_HAVE_CACHE_L2X0
 	select PL310_ERRATA_588369
 	select PL310_ERRATA_727915
 	select ARM_ERRATA_720789
diff --git a/arch/arm/mach-realview/Kconfig b/arch/arm/mach-realview/Kconfig
index dba6d0c..3dd620f 100644
--- a/arch/arm/mach-realview/Kconfig
+++ b/arch/arm/mach-realview/Kconfig
@@ -12,6 +12,7 @@ config REALVIEW_EB_A9MP
 	bool "Support Multicore Cortex-A9 Tile"
 	depends on MACH_REALVIEW_EB
 	select CPU_V7
+	select MIGHT_HAVE_CACHE_L2X0
 	help
 	  Enable support for the Cortex-A9MPCore tile fitted to the
 	  Realview(R) Emulation Baseboard platform.
@@ -21,6 +22,7 @@ config REALVIEW_EB_ARM11MP
 	depends on MACH_REALVIEW_EB
 	select CPU_V6K
 	select ARCH_HAS_BARRIERS if SMP
+	select MIGHT_HAVE_CACHE_L2X0
 	help
 	  Enable support for the ARM11MPCore tile fitted to the Realview(R)
 	  Emulation Baseboard platform.
@@ -39,6 +41,7 @@ config MACH_REALVIEW_PB11MP
 	select CPU_V6K
 	select ARM_GIC
 	select HAVE_PATA_PLATFORM
+	select MIGHT_HAVE_CACHE_L2X0
 	select ARCH_HAS_BARRIERS if SMP
 	help
 	  Include support for the ARM(R) RealView(R) Platform Baseboard for
@@ -51,6 +54,7 @@ config MACH_REALVIEW_PB1176
 	select CPU_V6
 	select ARM_GIC
 	select HAVE_TCM
+	select MIGHT_HAVE_CACHE_L2X0
 	help
 	  Include support for the ARM(R) RealView(R) Platform Baseboard for
 	  ARM1176JZF-S.
@@ -78,6 +82,7 @@ config MACH_REALVIEW_PBX
 	bool "Support RealView(R) Platform Baseboard Explore"
 	select ARM_GIC
 	select HAVE_PATA_PLATFORM
+	select MIGHT_HAVE_CACHE_L2X0
 	select ARCH_SPARSEMEM_ENABLE if CPU_V7 && !REALVIEW_HIGH_PHYS_OFFSET
 	select ZONE_DMA if SPARSEMEM
 	help
diff --git a/arch/arm/mach-vexpress/Kconfig b/arch/arm/mach-vexpress/Kconfig
index 9311484..a8aefc8 100644
--- a/arch/arm/mach-vexpress/Kconfig
+++ b/arch/arm/mach-vexpress/Kconfig
@@ -8,5 +8,6 @@ config ARCH_VEXPRESS_CA9X4
 	select ARM_ERRATA_720789
 	select ARM_ERRATA_751472
 	select ARM_ERRATA_753970
+	select MIGHT_HAVE_CACHE_L2X0
 
 endmenu
diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
index 67f75a0..d92aa3b 100644
--- a/arch/arm/mm/Kconfig
+++ b/arch/arm/mm/Kconfig
@@ -816,14 +816,15 @@ config CACHE_FEROCEON_L2_WRITETHROUGH
 	  Say Y here to use the Feroceon L2 cache in writethrough mode.
 	  Unless you specifically require this, say N for writeback mode.
 
+config MIGHT_HAVE_CACHE_L2X0
+	bool
+	help
+	  This option should be selected by machines which have a L2x0
+	  or PL310 cache controller.
+
 config CACHE_L2X0
-	bool "Enable the L2x0 outer cache controller"
-	depends on REALVIEW_EB_ARM11MP || MACH_REALVIEW_PB11MP || MACH_REALVIEW_PB1176 || \
-		   REALVIEW_EB_A9MP || ARCH_IMX_V6_V7 || MACH_REALVIEW_PBX || \
-		   ARCH_NOMADIK || ARCH_OMAP4 || ARCH_EXYNOS4 || ARCH_TEGRA || \
-		   ARCH_U8500 || ARCH_VEXPRESS_CA9X4 || ARCH_SHMOBILE || \
-		   ARCH_PRIMA2 || ARCH_ZYNQ || ARCH_CNS3XXX || ARCH_HIGHBANK
-	default y
+	bool "Enable the L2x0 outer cache controller" if MIGHT_HAVE_CACHE_L2X0
+	default MIGHT_HAVE_CACHE_L2X0
 	select OUTER_CACHE
 	select OUTER_CACHE_SYNC
 	help
diff --git a/arch/arm/plat-mxc/Kconfig b/arch/arm/plat-mxc/Kconfig
index b3a1f2b..b30708e 100644
--- a/arch/arm/plat-mxc/Kconfig
+++ b/arch/arm/plat-mxc/Kconfig
@@ -20,6 +20,7 @@ config ARCH_IMX_V6_V7
 	bool "i.MX3, i.MX6"
 	select AUTO_ZRELADDR if !ZBOOT_ROM
 	select ARM_PATCH_PHYS_VIRT
+	select MIGHT_HAVE_CACHE_L2X0
 	help
 	  This enables support for systems based on the Freescale i.MX3 and i.MX6
 	  family.
-- 
1.7.4.1
