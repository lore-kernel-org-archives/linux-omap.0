From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 3/6] ARM: OMAP2+: move MPU INTCPS, secure monitor,
 SDRC build directives in Makefile
Date: Fri, 07 Sep 2012 18:39:52 -0600
Message-ID: <20120908003948.4648.90831.stgit@dusk.lan>
References: <20120908002614.4648.31150.stgit@dusk.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:59129 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756733Ab2IHAlr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Sep 2012 20:41:47 -0400
In-Reply-To: <20120908002614.4648.31150.stgit@dusk.lan>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Move MPU INTCPS (interrupt controller) and secure monitor code build
directives to their own Makefile sections, for clarity.  Coalesce
SDRC-related Makefile directives into the SDRC Makefile section.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/Makefile |   21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index bdcf508..437ca322 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -6,23 +6,27 @@
 obj-y := id.o io.o control.o mux.o devices.o serial.o gpmc.o timer.o pm.o \
 	 common.o gpio.o dma.o wd_timer.o display.o i2c.o hdq1w.o omap_hwmod.o
 
-omap-2-3-common				= irq.o
 clock-common				= clock.o clock_common_data.o \
 					  clkt_dpll.o clkt_clksel.o
-secure-common				= omap-smc.o omap-secure.o
 
-obj-$(CONFIG_ARCH_OMAP2) += $(omap-2-3-common)
-obj-$(CONFIG_ARCH_OMAP3) += $(omap-2-3-common) $(secure-common)
-obj-$(CONFIG_ARCH_OMAP4) += prm44xx.o $(secure-common)
-obj-$(CONFIG_SOC_AM33XX) += irq.o
-obj-$(CONFIG_SOC_OMAP5)	 += prm44xx.o $(secure-common)
+# INTCPS IP block support - XXX should be moved to drivers/
+obj-$(CONFIG_ARCH_OMAP2)		+= irq.o
+obj-$(CONFIG_ARCH_OMAP3)		+= irq.o
+obj-$(CONFIG_SOC_AM33XX)		+= irq.o
+
+# Secure monitor API support
+obj-$(CONFIG_ARCH_OMAP3)		+= omap-smc.o omap-secure.o
+obj-$(CONFIG_ARCH_OMAP4)		+= omap-smc.o omap-secure.o
+obj-$(CONFIG_SOC_OMAP5)			+= omap-smc.o omap-secure.o
+
+obj-$(CONFIG_ARCH_OMAP4) += prm44xx.o
+obj-$(CONFIG_SOC_OMAP5)	 += prm44xx.o
 
 ifneq ($(CONFIG_SND_OMAP_SOC_MCBSP),)
 obj-y += mcbsp.o
 endif
 
 obj-$(CONFIG_TWL4030_CORE)		+= omap_twl.o
-obj-$(CONFIG_SOC_HAS_OMAP2_SDRC)	+= sdrc.o
 
 # SMP support ONLY available for OMAP4
 
@@ -56,6 +60,7 @@ obj-$(CONFIG_ARCH_OMAP4)		+= mux44xx.o
 # SMS/SDRC
 obj-$(CONFIG_ARCH_OMAP2)		+= sdrc2xxx.o
 # obj-$(CONFIG_ARCH_OMAP3)		+= sdrc3xxx.o
+obj-$(CONFIG_SOC_HAS_OMAP2_SDRC)	+= sdrc.o
 
 # OPP table initialization
 ifeq ($(CONFIG_PM_OPP),y)


