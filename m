From: Mike Turquette <mturquette@ti.com>
Subject: [PATCH 16/26] ARM: OMAP: clock: Switch to COMMON clk
Date: Wed, 7 Nov 2012 17:12:51 -0800
Message-ID: <1352337181-29427-17-git-send-email-mturquette@ti.com>
References: <1352337181-29427-1-git-send-email-mturquette@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:52130 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754162Ab2KHBNl (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 7 Nov 2012 20:13:41 -0500
In-Reply-To: <1352337181-29427-1-git-send-email-mturquette@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: paul@pwsan.com
Cc: rnayak@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@vger.kernel.org, patches@linaro.org, Mike Turquette <mturquette@ti.com>

From: Rajendra Nayak <rnayak@ti.com>

Select COMMON_CLK for all OMAP2+ SoCs and switch over to using new
data files for OMAP2/3/4.

The older data files will get removed in subsequent patches.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
[paul@pwsan.com: move 'select COMMON_CLK' from ARCH_OMAP2PLUS_TYPICAL to
 the per-SoC and per-"arch" Kconfig sections]
Signed-off-by: Mike Turquette <mturquette@ti.com>
[mturquette@ti.com: fixed up #ifdef mismatch in clock.h in previous
  patch which drops that change from this patch]
---
 arch/arm/mach-omap2/Kconfig  |    5 +++++
 arch/arm/mach-omap2/Makefile |   10 +++++-----
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index 2a1a898..98268fa 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -35,6 +35,7 @@ config ARCH_OMAP2
 	select CPU_V6
 	select MULTI_IRQ_HANDLER
 	select SOC_HAS_OMAP2_SDRC
+	select COMMON_CLK
 
 config ARCH_OMAP3
 	bool "TI OMAP3"
@@ -48,6 +49,7 @@ config ARCH_OMAP3
 	select PM_OPP if PM
 	select PM_RUNTIME if CPU_IDLE
 	select SOC_HAS_OMAP2_SDRC
+	select COMMON_CLK
 	select USB_ARCH_HAS_EHCI if USB_SUPPORT
 
 config ARCH_OMAP4
@@ -69,6 +71,7 @@ config ARCH_OMAP4
 	select PM_OPP if PM
 	select PM_RUNTIME if CPU_IDLE
 	select USB_ARCH_HAS_EHCI if USB_SUPPORT
+	select COMMON_CLK
 
 config SOC_OMAP5
 	bool "TI OMAP5"
@@ -78,6 +81,7 @@ config SOC_OMAP5
 	select CPU_V7
 	select HAVE_SMP
 	select SOC_HAS_REALTIME_COUNTER
+	select COMMON_CLK
 
 comment "OMAP Core Type"
 	depends on ARCH_OMAP2
@@ -112,6 +116,7 @@ config SOC_AM33XX
 	select ARM_CPU_SUSPEND if PM
 	select CPU_V7
 	select MULTI_IRQ_HANDLER
+	select COMMON_CLK
 
 config OMAP_PACKAGE_ZAF
        bool
diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index ae87a3e..f8dbf0c 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -153,17 +153,17 @@ obj-$(CONFIG_ARCH_OMAP2)		+= clkt2xxx_dpllcore.o
 obj-$(CONFIG_ARCH_OMAP2)		+= clkt2xxx_virt_prcm_set.o
 obj-$(CONFIG_ARCH_OMAP2)		+= clkt2xxx_apll.o clkt2xxx_osc.o
 obj-$(CONFIG_ARCH_OMAP2)		+= clkt2xxx_dpll.o clkt_iclk.o
-obj-$(CONFIG_SOC_OMAP2420)		+= clock2420_data.o
-obj-$(CONFIG_SOC_OMAP2430)		+= clock2430.o clock2430_data.o
+obj-$(CONFIG_SOC_OMAP2420)		+= cclock2420_data.o
+obj-$(CONFIG_SOC_OMAP2430)		+= clock2430.o cclock2430_data.o
 obj-$(CONFIG_ARCH_OMAP3)		+= $(clock-common) clock3xxx.o
 obj-$(CONFIG_ARCH_OMAP3)		+= clock34xx.o clkt34xx_dpll3m2.o
 obj-$(CONFIG_ARCH_OMAP3)		+= clock3517.o clock36xx.o
-obj-$(CONFIG_ARCH_OMAP3)		+= dpll3xxx.o clock3xxx_data.o
+obj-$(CONFIG_ARCH_OMAP3)		+= dpll3xxx.o cclock3xxx_data.o
 obj-$(CONFIG_ARCH_OMAP3)		+= clkt_iclk.o
-obj-$(CONFIG_ARCH_OMAP4)		+= $(clock-common) clock44xx_data.o
+obj-$(CONFIG_ARCH_OMAP4)		+= $(clock-common) cclock44xx_data.o
 obj-$(CONFIG_ARCH_OMAP4)		+= dpll3xxx.o dpll44xx.o
 obj-$(CONFIG_SOC_AM33XX)		+= $(clock-common) dpll3xxx.o
-obj-$(CONFIG_SOC_AM33XX)		+= clock33xx_data.o
+obj-$(CONFIG_SOC_AM33XX)		+= cclock33xx_data.o
 obj-$(CONFIG_SOC_OMAP5)			+= $(clock-common)
 obj-$(CONFIG_SOC_OMAP5)			+= dpll3xxx.o dpll44xx.o
 
-- 
1.7.9.5

