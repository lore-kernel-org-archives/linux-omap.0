From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [RFT RESEND PATCH v3 2/3] ARM: Fix *MIGHT_HAVE_PCI* config from being
 selected redundantly
Date: Wed, 10 Aug 2016 18:03:19 +0530
Message-ID: <1470832400-11929-3-git-send-email-kishon@ti.com>
References: <1470832400-11929-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1470832400-11929-1-git-send-email-kishon@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Russell King <linux@armlinux.org.uk>, Benoit Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Cc: Mark Rutland <mark.rutland@arm.com>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Shawn Guo <shawnguo@kernel.org>, Nicolas Ferre <nicolas.ferre@atmel.com>, nsekhar@ti.com, kishon@ti.com, Rob Herring <robh+dt@kernel.org>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Kukjin Kim <kgene@kernel.org>, Sascha Hauer <kernel@pengutronix.de>, Santosh Shilimkar <ssantosh@kernel.org>, Fabio Estevam <fabio.estevam@nxp.com>, Krzysztof Halasa <khalasa@piap.pl>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Shiraz Hashim <shiraz.linux.kernel@gmail.com>, Viresh Kumar <vireshk@kernel.org>
List-Id: linux-omap@vger.kernel.org

*MIGHT_HAVE_PCI* config is already selected in ARCH_MULTIPLATFORM.
Fix it from getting redundantly selected in all
ARCH_MULTIPLATFORM based machines.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Acked-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
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
