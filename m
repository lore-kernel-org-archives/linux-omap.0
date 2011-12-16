From: Dave Martin <dave.martin@linaro.org>
Subject: [PATCH v5 REPOST 1/5] ARM: l2x0/pl310: Refactor Kconfig to be more
 maintainable
Date: Fri, 16 Dec 2011 16:35:28 +0000
Message-ID: <1324053332-6431-2-git-send-email-dave.martin@linaro.org>
References: <1324053332-6431-1-git-send-email-dave.martin@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1324053332-6431-1-git-send-email-dave.martin@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-sh@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Catalin Marinas <catalin.marinas@arm.com>, Linus Walleij <linus.walleij@linaro.org>, Anton Vorontsov <cbouatmailru@gmail.com>, Will Deacon <will.deacon@arm.com>, Daniel Walker <dwalker@fifo99.com>, John Linn <john.linn@xilinx.com>, Kukjin Kim <kgene.kim@samsung.com>, Magnus Damm <magnus.damm@gmail.com>, Haojian Zhuang <haojian.zhuang@marvell.com>, =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, David Brown <davidb@codeaurora.org>, Pawel Moll <pawel.moll@arm.com>, patches@linaro.org, linux-arm-msm@vger.kernel.org, Sascha Hauer <s.hauer@pengutronix.de>, Rob Herring <rob.herring@calxeda.com>, linux-samsung-soc@vger.kernel.org, Barry Song <baohua.song@csr.com>, linux-tegra@vger.kernel.org, linux-omap@vger.kernel.org, Fabio Estevam <fabio.estevam@freescale.com>, Colin Cross <ccross@google.com>
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
Acked-by: Anton Vorontsov <cbouatmailru@gmail.com>
        (for cns3xxx)
Acked-by: Tony Lindgren <tony@atomide.com>
        (for omap)
Acked-by: Shawn Guo <shawn.guo@linaro.org>
        (for imx)
---
 arch/arm/Kconfig               |    8 ++++++++
 arch/arm/mach-exynos/Kconfig   |    1 +
 arch/arm/mach-omap2/Kconfig    |    1 +
 arch/arm/mach-realview/Kconfig |    5 +++++
 arch/arm/mach-vexpress/Kconfig |    1 +
 arch/arm/mm/Kconfig            |   23 ++++++++++++++++-------
 arch/arm/plat-mxc/Kconfig      |    1 +
 7 files changed, 33 insertions(+), 7 deletions(-)

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
index 67f75a0..acb1c36 100644
--- a/arch/arm/mm/Kconfig
+++ b/arch/arm/mm/Kconfig
@@ -816,14 +816,23 @@ config CACHE_FEROCEON_L2_WRITETHROUGH
 	  Say Y here to use the Feroceon L2 cache in writethrough mode.
 	  Unless you specifically require this, say N for writeback mode.
 
+config MIGHT_HAVE_CACHE_L2X0
+	bool
+	help
+	  This option should be selected by machines which have a L2x0
+	  or PL310 cache controller, but where its use is optional.
+
+	  The only effect of this option is to make CACHE_L2X0 and
+	  related options available to the user for configuration.
+
+	  Boards or SoCs which always require the cache controller
+	  support to be present should select CACHE_L2X0 directly
+	  instead of this option, thus preventing the user from
+	  inadvertently configuring a broken kernel.
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
