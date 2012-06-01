From: Rajendra Nayak <rnayak@ti.com>
Subject: [RFC 16/24] ARM: omap: clk: Switch to COMMON clk
Date: Fri, 1 Jun 2012 17:37:57 +0530
Message-ID: <1338552485-31325-17-git-send-email-rnayak@ti.com>
References: <1338552485-31325-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:47203 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759512Ab2FAMIv (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 1 Jun 2012 08:08:51 -0400
In-Reply-To: <1338552485-31325-1-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: mturquette@ti.com, paul@pwsan.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Rajendra Nayak <rnayak@ti.com>

Select COMMON_CLK for ARCH_OMAP2 and switch
over to using new data files for OMAP2/3/4.

The older data files which get removed in subsequent
patches.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/Kconfig  |    1 +
 arch/arm/mach-omap2/Makefile |    8 ++++----
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index 8141b76..b5b7b76 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -17,6 +17,7 @@ config ARCH_OMAP2PLUS_TYPICAL
 	select MENELAUS if ARCH_OMAP2
 	select TWL4030_CORE if ARCH_OMAP3 || ARCH_OMAP4
 	select TWL4030_POWER if ARCH_OMAP3 || ARCH_OMAP4
+	select COMMON_CLK
 	help
 	  Compile a kernel suitable for booting most boards
 
diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 49f92bc..785b861 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -138,14 +138,14 @@ obj-$(CONFIG_ARCH_OMAP2)		+= $(clock-common) clock2xxx.o \
 					   clkt2xxx_virt_prcm_set.o \
 					   clkt2xxx_apll.o clkt2xxx_osc.o \
 					   clkt2xxx_dpll.o clkt_iclk.o
-obj-$(CONFIG_SOC_OMAP2420)		+= clock2420_data.o
-obj-$(CONFIG_SOC_OMAP2430)		+= clock2430.o clock2430_data.o
+obj-$(CONFIG_SOC_OMAP2420)		+= cclock2420_data.o
+obj-$(CONFIG_SOC_OMAP2430)		+= clock2430.o cclock2430_data.o
 obj-$(CONFIG_ARCH_OMAP3)		+= $(clock-common) clock3xxx.o \
 					   clock34xx.o clkt34xx_dpll3m2.o \
 					   clock3517.o clock36xx.o \
-					   dpll3xxx.o clock3xxx_data.o \
+					   dpll3xxx.o cclock3xxx_data.o \
 					   clkt_iclk.o
-obj-$(CONFIG_ARCH_OMAP4)		+= $(clock-common) clock44xx_data.o \
+obj-$(CONFIG_ARCH_OMAP4)		+= $(clock-common) cclock44xx_data.o \
 					   dpll3xxx.o dpll44xx.o
 
 # OMAP2 clock rate set data (old "OPP" data)
-- 
1.7.1

