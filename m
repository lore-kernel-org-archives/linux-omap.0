From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 1/6] ARM: OMAP2+: clean up whitespace in Makefile
Date: Fri, 07 Sep 2012 18:39:38 -0600
Message-ID: <20120908003936.4648.75602.stgit@dusk.lan>
References: <20120908002614.4648.31150.stgit@dusk.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:59124 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752780Ab2IHAlq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Sep 2012 20:41:46 -0400
In-Reply-To: <20120908002614.4648.31150.stgit@dusk.lan>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Convert spaces that should be tabs into tabs.  Fix another minor
formatting issue.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/Makefile |   16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index f6a24b3..22ee340 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -23,7 +23,7 @@ ifneq ($(CONFIG_SND_OMAP_SOC_MCBSP),)
 obj-y += mcbsp.o
 endif
 
-obj-$(CONFIG_TWL4030_CORE) += omap_twl.o
+obj-$(CONFIG_TWL4030_CORE)		+= omap_twl.o
 obj-$(CONFIG_SOC_HAS_OMAP2_SDRC)	+= sdrc.o
 
 # SMP support ONLY available for OMAP4
@@ -76,7 +76,7 @@ obj-$(CONFIG_SOC_OMAP5)			+= omap-mpuss-lowpower.o
 obj-$(CONFIG_PM_DEBUG)			+= pm-debug.o
 
 obj-$(CONFIG_POWER_AVS_OMAP)		+= sr_device.o
-obj-$(CONFIG_POWER_AVS_OMAP_CLASS3)    += smartreflex-class3.o
+obj-$(CONFIG_POWER_AVS_OMAP_CLASS3)	+= smartreflex-class3.o
 
 AFLAGS_sleep24xx.o			:=-Wa,-march=armv6
 AFLAGS_sleep34xx.o			:=-Wa,-march=armv7-a$(plus_sec)
@@ -88,8 +88,8 @@ endif
 endif
 
 ifeq ($(CONFIG_CPU_IDLE),y)
-obj-$(CONFIG_ARCH_OMAP3)                += cpuidle34xx.o
-obj-$(CONFIG_ARCH_OMAP4)                += cpuidle44xx.o
+obj-$(CONFIG_ARCH_OMAP3)		+= cpuidle34xx.o
+obj-$(CONFIG_ARCH_OMAP4)		+= cpuidle44xx.o
 endif
 
 # PRCM
@@ -113,7 +113,7 @@ obj-$(CONFIG_ARCH_OMAP3)		+= voltagedomains3xxx_data.o
 obj-$(CONFIG_ARCH_OMAP4)		+= $(voltagedomain-common)
 obj-$(CONFIG_ARCH_OMAP4)		+= voltagedomains44xx_data.o
 obj-$(CONFIG_SOC_AM33XX)		+= $(voltagedomain-common)
-obj-$(CONFIG_SOC_AM33XX)                += voltagedomains33xx_data.o
+obj-$(CONFIG_SOC_AM33XX)		+= voltagedomains33xx_data.o
 obj-$(CONFIG_SOC_OMAP5)			+= $(voltagedomain-common)
 
 # OMAP powerdomain framework
@@ -229,10 +229,10 @@ obj-$(CONFIG_MACH_OMAP_H4)		+= board-h4.o
 obj-$(CONFIG_MACH_OMAP_2430SDP)		+= board-2430sdp.o
 obj-$(CONFIG_MACH_OMAP_APOLLON)		+= board-apollon.o
 obj-$(CONFIG_MACH_OMAP3_BEAGLE)		+= board-omap3beagle.o
-obj-$(CONFIG_MACH_DEVKIT8000)     	+= board-devkit8000.o
+obj-$(CONFIG_MACH_DEVKIT8000)		+= board-devkit8000.o
 obj-$(CONFIG_MACH_OMAP_LDP)		+= board-ldp.o
-obj-$(CONFIG_MACH_OMAP3530_LV_SOM)      += board-omap3logic.o
-obj-$(CONFIG_MACH_OMAP3_TORPEDO)        += board-omap3logic.o
+obj-$(CONFIG_MACH_OMAP3530_LV_SOM)	+= board-omap3logic.o
+obj-$(CONFIG_MACH_OMAP3_TORPEDO)	+= board-omap3logic.o
 obj-$(CONFIG_MACH_ENCORE)		+= board-omap3encore.o
 obj-$(CONFIG_MACH_OVERO)		+= board-overo.o
 obj-$(CONFIG_MACH_OMAP3EVM)		+= board-omap3evm.o


