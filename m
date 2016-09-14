From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v4 1/2] ARM: stop *MIGHT_HAVE_PCI* config from being selected redundantly
Date: Wed, 14 Sep 2016 15:49:05 +0530
Message-ID: <1473848346-17905-2-git-send-email-kishon@ti.com>
References: <1473848346-17905-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1473848346-17905-1-git-send-email-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux@armlinux.org.uk, bcousson@baylibre.com, tony@atomide.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Cc: nicolas.ferre@atmel.com, alexandre.belloni@free-electrons.com, plagnioj@jcrosoft.com, khalasa@piap.pl, kgene@kernel.org, k.kozlowski@samsung.com, shawnguo@kernel.org, kernel@pengutronix.de, fabio.estevam@nxp.com, ssantosh@kernel.org, horms@verge.net.au, magnus.damm@gmail.com, vireshk@kernel.org, shiraz.linux.kernel@gmail.com, kishon@ti.com, nsekhar@ti.com
List-Id: linux-omap@vger.kernel.org

*MIGHT_HAVE_PCI* config is already selected in ARCH_MULTIPLATFORM.
Don't select it redundantly in all ARCH_MULTIPLATFORM based machines.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Acked-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Acked-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 arch/arm/mach-at91/Kconfig       |    1 -
 arch/arm/mach-axxia/Kconfig      |    1 -
 arch/arm/mach-exynos/Kconfig     |    1 -
 arch/arm/mach-integrator/Kconfig |    1 -
 arch/arm/mach-keystone/Kconfig   |    1 -
 arch/arm/mach-spear/Kconfig      |    1 -
 arch/arm/mach-versatile/Kconfig  |    1 -
 7 files changed, 7 deletions(-)

diff --git a/arch/arm/mach-at91/Kconfig b/arch/arm/mach-at91/Kconfig
index 5204395..841e924 100644
--- a/arch/arm/mach-at91/Kconfig
+++ b/arch/arm/mach-at91/Kconfig
@@ -55,7 +55,6 @@ config SOC_AT91RM9200
 	select ATMEL_ST
 	select CPU_ARM920T
 	select HAVE_AT91_USB_CLK
-	select MIGHT_HAVE_PCI
 	select PINCTRL_AT91
 	select SOC_SAM_V4_V5
 	select SRAM if PM
diff --git a/arch/arm/mach-axxia/Kconfig b/arch/arm/mach-axxia/Kconfig
index 6c6d5e7..ee2e131 100644
--- a/arch/arm/mach-axxia/Kconfig
+++ b/arch/arm/mach-axxia/Kconfig
@@ -7,7 +7,6 @@ config ARCH_AXXIA
 	select ARM_TIMER_SP804
 	select HAVE_ARM_ARCH_TIMER
 	select MFD_SYSCON
-	select MIGHT_HAVE_PCI
 	select PCI_DOMAINS if PCI
 	select ZONE_DMA
 	help
diff --git a/arch/arm/mach-exynos/Kconfig b/arch/arm/mach-exynos/Kconfig
index 8f820de..ee8a99c 100644
--- a/arch/arm/mach-exynos/Kconfig
+++ b/arch/arm/mach-exynos/Kconfig
@@ -126,7 +126,6 @@ config SOC_EXYNOS5440
 	select ARCH_DMA_ADDR_T_64BIT if ARM_LPAE
 	select HAVE_ARM_ARCH_TIMER
 	select AUTO_ZRELADDR
-	select MIGHT_HAVE_PCI
 	select PCI_DOMAINS if PCI
 	select PINCTRL_EXYNOS5440
 	select PM_OPP
diff --git a/arch/arm/mach-integrator/Kconfig b/arch/arm/mach-integrator/Kconfig
index 599f973..cefe44f 100644
--- a/arch/arm/mach-integrator/Kconfig
+++ b/arch/arm/mach-integrator/Kconfig
@@ -21,7 +21,6 @@ if ARCH_INTEGRATOR
 config ARCH_INTEGRATOR_AP
 	bool "Support Integrator/AP and Integrator/PP2 platforms"
 	select INTEGRATOR_AP_TIMER
-	select MIGHT_HAVE_PCI
 	select SERIAL_AMBA_PL010 if TTY
 	select SERIAL_AMBA_PL010_CONSOLE if TTY
 	select SOC_BUS
diff --git a/arch/arm/mach-keystone/Kconfig b/arch/arm/mach-keystone/Kconfig
index 8ff61be..1507287 100644
--- a/arch/arm/mach-keystone/Kconfig
+++ b/arch/arm/mach-keystone/Kconfig
@@ -8,7 +8,6 @@ config ARCH_KEYSTONE
 	select COMMON_CLK_KEYSTONE
 	select ARCH_SUPPORTS_BIG_ENDIAN
 	select ZONE_DMA if ARM_LPAE
-	select MIGHT_HAVE_PCI
 	select PCI_DOMAINS if PCI
 	select PINCTRL
 	help
diff --git a/arch/arm/mach-spear/Kconfig b/arch/arm/mach-spear/Kconfig
index b7260c2..1b6cae5 100644
--- a/arch/arm/mach-spear/Kconfig
+++ b/arch/arm/mach-spear/Kconfig
@@ -20,7 +20,6 @@ config ARCH_SPEAR13XX
 	select HAVE_ARM_TWD if SMP
 	select PINCTRL
 	select MFD_SYSCON
-	select MIGHT_HAVE_PCI
 	help
 	  Supports for ARM's SPEAR13XX family
 
diff --git a/arch/arm/mach-versatile/Kconfig b/arch/arm/mach-versatile/Kconfig
index b0cc262..c257d40 100644
--- a/arch/arm/mach-versatile/Kconfig
+++ b/arch/arm/mach-versatile/Kconfig
@@ -9,7 +9,6 @@ config ARCH_VERSATILE
 	select CPU_ARM926T
 	select ICST
 	select MFD_SYSCON
-	select MIGHT_HAVE_PCI
 	select PLAT_VERSATILE
 	select POWER_RESET
 	select POWER_RESET_VERSATILE
-- 
1.7.9.5
