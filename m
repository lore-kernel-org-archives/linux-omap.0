From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v4 2/2] ARM: select PCI_DOMAINS config from ARCH_MULTIPLATFORM
Date: Wed, 14 Sep 2016 15:49:06 +0530
Message-ID: <1473848346-17905-3-git-send-email-kishon@ti.com>
References: <1473848346-17905-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1473848346-17905-1-git-send-email-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux@armlinux.org.uk, bcousson@baylibre.com, tony@atomide.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Cc: nicolas.ferre@atmel.com, alexandre.belloni@free-electrons.com, plagnioj@jcrosoft.com, khalasa@piap.pl, kgene@kernel.org, k.kozlowski@samsung.com, shawnguo@kernel.org, kernel@pengutronix.de, fabio.estevam@nxp.com, ssantosh@kernel.org, horms@verge.net.au, magnus.damm@gmail.com, vireshk@kernel.org, shiraz.linux.kernel@gmail.com, kishon@ti.com, nsekhar@ti.com
List-Id: linux-omap@vger.kernel.org

PCI_DOMAINS config should be selected for any SoCs
having more than a single PCIe controller. Without PCI_DOMAINS
config, only one PCIe controller gets registered.

Select PCI_DOMAINS in ARCH_MULTIPLATFORM if PCI is selected, since
it doesn't harm even if a platform has a single PCIe port.
Also remove PCI_DOMAINS being selected from other platform
specific configs.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Acked-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 arch/arm/Kconfig               |    1 +
 arch/arm/mach-axxia/Kconfig    |    1 -
 arch/arm/mach-cns3xxx/Kconfig  |    1 -
 arch/arm/mach-exynos/Kconfig   |    1 -
 arch/arm/mach-imx/Kconfig      |    2 --
 arch/arm/mach-keystone/Kconfig |    1 -
 arch/arm/mach-shmobile/Kconfig |    1 -
 7 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index a9c4e48..fb1b867 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -337,6 +337,7 @@ config ARCH_MULTIPLATFORM
 	select GENERIC_CLOCKEVENTS
 	select MIGHT_HAVE_PCI
 	select MULTI_IRQ_HANDLER
+	select PCI_DOMAINS if PCI
 	select SPARSE_IRQ
 	select USE_OF
 
diff --git a/arch/arm/mach-axxia/Kconfig b/arch/arm/mach-axxia/Kconfig
index ee2e131..fe627cb 100644
--- a/arch/arm/mach-axxia/Kconfig
+++ b/arch/arm/mach-axxia/Kconfig
@@ -7,7 +7,6 @@ config ARCH_AXXIA
 	select ARM_TIMER_SP804
 	select HAVE_ARM_ARCH_TIMER
 	select MFD_SYSCON
-	select PCI_DOMAINS if PCI
 	select ZONE_DMA
 	help
 	  This enables support for the LSI Axxia devices.
diff --git a/arch/arm/mach-cns3xxx/Kconfig b/arch/arm/mach-cns3xxx/Kconfig
index eb14a0f..5fd836b 100644
--- a/arch/arm/mach-cns3xxx/Kconfig
+++ b/arch/arm/mach-cns3xxx/Kconfig
@@ -2,7 +2,6 @@ menuconfig ARCH_CNS3XXX
 	bool "Cavium Networks CNS3XXX family"
 	depends on ARCH_MULTI_V6
 	select ARM_GIC
-	select PCI_DOMAINS if PCI
 	help
 	  Support for Cavium Networks CNS3XXX platform.
 
diff --git a/arch/arm/mach-exynos/Kconfig b/arch/arm/mach-exynos/Kconfig
index ee8a99c..18f0c85 100644
--- a/arch/arm/mach-exynos/Kconfig
+++ b/arch/arm/mach-exynos/Kconfig
@@ -126,7 +126,6 @@ config SOC_EXYNOS5440
 	select ARCH_DMA_ADDR_T_64BIT if ARM_LPAE
 	select HAVE_ARM_ARCH_TIMER
 	select AUTO_ZRELADDR
-	select PCI_DOMAINS if PCI
 	select PINCTRL_EXYNOS5440
 	select PM_OPP
 	help
diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index ee9a318..757cd11 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -523,7 +523,6 @@ config SOC_IMX6Q
 	select ARM_ERRATA_764369 if SMP
 	select HAVE_ARM_SCU if SMP
 	select HAVE_ARM_TWD
-	select PCI_DOMAINS if PCI
 	select PINCTRL_IMX6Q
 	select SOC_IMX6
 
@@ -569,7 +568,6 @@ config SOC_LS1021A
 	bool "Freescale LS1021A support"
 	select ARM_GIC
 	select HAVE_ARM_ARCH_TIMER
-	select PCI_DOMAINS if PCI
 	select ZONE_DMA if ARM_LPAE
 	help
 	  This enables support for Freescale LS1021A processor.
diff --git a/arch/arm/mach-keystone/Kconfig b/arch/arm/mach-keystone/Kconfig
index 1507287..24bd64d 100644
--- a/arch/arm/mach-keystone/Kconfig
+++ b/arch/arm/mach-keystone/Kconfig
@@ -8,7 +8,6 @@ config ARCH_KEYSTONE
 	select COMMON_CLK_KEYSTONE
 	select ARCH_SUPPORTS_BIG_ENDIAN
 	select ZONE_DMA if ARM_LPAE
-	select PCI_DOMAINS if PCI
 	select PINCTRL
 	help
 	  Support for boards based on the Texas Instruments Keystone family of
diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
index 4a48c9f..09817ba 100644
--- a/arch/arm/mach-shmobile/Kconfig
+++ b/arch/arm/mach-shmobile/Kconfig
@@ -22,7 +22,6 @@ config ARCH_RCAR_GEN2
 	select PM_GENERIC_DOMAINS
 	select RENESAS_IRQC
 	select SYS_SUPPORTS_SH_CMT
-	select PCI_DOMAINS if PCI
 
 config ARCH_RMOBILE
 	bool
-- 
1.7.9.5
