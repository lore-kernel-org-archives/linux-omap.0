From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [PATCH 2/2] ARM: config: make sure that platforms are ordered by
 option string
Date: Fri, 12 Oct 2012 14:26:40 +0100
Message-ID: <E1TMfGC-0001Kx-9v@rmk-PC.arm.linux.org.uk>
References: <20121012132553.GK28061@n2100.arm.linux.org.uk>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <20121012132553.GK28061@n2100.arm.linux.org.uk>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, davinci-linux-open-source@linux.davincidsp.com, linux-samsung-soc@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-omap@vger.kernel.org, linux-sh@vger.kernel.org, linux-tegra@vger.kernel.org, spear-devel@list.st.com
List-Id: linux-omap@vger.kernel.org

The large platform selection choice should be sorted by option string
so it's easy to find the platform you're looking for.  Fix the few
options which are out of this order.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/Kconfig |   76 +++++++++++++++++++++++++++---------------------------
 1 files changed, 38 insertions(+), 38 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index bd12ddd..1bc092e 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -348,16 +348,6 @@ config ARCH_BCM2835
 	  This enables support for the Broadcom BCM2835 SoC. This SoC is
 	  use in the Raspberry Pi, and Roku 2 devices.
 
-config ARCH_CLPS711X
-	bool "Cirrus Logic CLPS711x/EP721x/EP731x-based"
-	select ARCH_USES_GETTIMEOFFSET
-	select CLKDEV_LOOKUP
-	select COMMON_CLK
-	select CPU_ARM720T
-	select NEED_MACH_MEMORY_H
-	help
-	  Support for Cirrus Logic 711x/721x/731x based boards.
-
 config ARCH_CNS3XXX
 	bool "Cavium Networks CNS3XXX family"
 	select ARM_GIC
@@ -369,6 +359,16 @@ config ARCH_CNS3XXX
 	help
 	  Support for Cavium Networks CNS3XXX platform.
 
+config ARCH_CLPS711X
+	bool "Cirrus Logic CLPS711x/EP721x/EP731x-based"
+	select ARCH_USES_GETTIMEOFFSET
+	select CLKDEV_LOOKUP
+	select COMMON_CLK
+	select CPU_ARM720T
+	select NEED_MACH_MEMORY_H
+	help
+	  Support for Cirrus Logic 711x/721x/731x based boards.
+
 config ARCH_GEMINI
 	bool "Cortina Systems Gemini"
 	select ARCH_REQUIRE_GPIOLIB
@@ -549,21 +549,6 @@ config ARCH_KIRKWOOD
 	  Support for the following Marvell Kirkwood series SoCs:
 	  88F6180, 88F6192 and 88F6281.
 
-config ARCH_LPC32XX
-	bool "NXP LPC32XX"
-	select ARCH_REQUIRE_GPIOLIB
-	select ARM_AMBA
-	select CLKDEV_LOOKUP
-	select CLKSRC_MMIO
-	select CPU_ARM926T
-	select GENERIC_CLOCKEVENTS
-	select HAVE_IDE
-	select HAVE_PWM
-	select USB_ARCH_HAS_OHCI
-	select USE_OF
-	help
-	  Support for the NXP LPC32XX family of processors
-
 config ARCH_MV78XX0
 	bool "Marvell MV78xx0"
 	select ARCH_REQUIRE_GPIOLIB
@@ -630,6 +615,21 @@ config ARCH_W90X900
 	  <http://www.nuvoton.com/hq/enu/ProductAndSales/ProductLines/
 		ConsumerElectronicsIC/ARMMicrocontroller/ARMMicrocontroller>
 
+config ARCH_LPC32XX
+	bool "NXP LPC32XX"
+	select ARCH_REQUIRE_GPIOLIB
+	select ARM_AMBA
+	select CLKDEV_LOOKUP
+	select CLKSRC_MMIO
+	select CPU_ARM926T
+	select GENERIC_CLOCKEVENTS
+	select HAVE_IDE
+	select HAVE_PWM
+	select USB_ARCH_HAS_OHCI
+	select USE_OF
+	help
+	  Support for the NXP LPC32XX family of processors
+
 config ARCH_TEGRA
 	bool "NVIDIA Tegra"
 	select ARCH_HAS_CPUFREQ
@@ -823,7 +823,7 @@ config ARCH_S5PV210
 	  Samsung S5PV210/S5PC110 series based systems
 
 config ARCH_EXYNOS
-	bool "SAMSUNG EXYNOS"
+	bool "Samsung EXYNOS"
 	select ARCH_HAS_CPUFREQ
 	select ARCH_HAS_HOLES_MEMORYMODEL
 	select ARCH_SPARSEMEM_ENABLE
@@ -899,6 +899,18 @@ config ARCH_NOMADIK
 	help
 	  Support for the Nomadik platform by ST-Ericsson
 
+config PLAT_SPEAR
+	bool "ST SPEAr"
+	select ARCH_REQUIRE_GPIOLIB
+	select ARM_AMBA
+	select CLKDEV_LOOKUP
+	select CLKSRC_MMIO
+	select COMMON_CLK
+	select GENERIC_CLOCKEVENTS
+	select HAVE_CLK
+	help
+	  Support for ST's SPEAr platform (SPEAr3xx, SPEAr6xx and SPEAr13xx).
+
 config ARCH_DAVINCI
 	bool "TI DaVinci"
 	select ARCH_HAS_HOLES_MEMORYMODEL
@@ -926,18 +938,6 @@ config ARCH_OMAP
 	help
 	  Support for TI's OMAP platform (OMAP1/2/3/4).
 
-config PLAT_SPEAR
-	bool "ST SPEAr"
-	select ARCH_REQUIRE_GPIOLIB
-	select ARM_AMBA
-	select CLKDEV_LOOKUP
-	select CLKSRC_MMIO
-	select COMMON_CLK
-	select GENERIC_CLOCKEVENTS
-	select HAVE_CLK
-	help
-	  Support for ST's SPEAr platform (SPEAr3xx, SPEAr6xx and SPEAr13xx).
-
 config ARCH_VT8500
 	bool "VIA/WonderMedia 85xx"
 	select ARCH_HAS_CPUFREQ
-- 
1.7.4.4
