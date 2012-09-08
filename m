From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 5/6] ARM: OMAP2+: clean up OMAP clock Makefile sections
Date: Fri, 07 Sep 2012 18:39:56 -0600
Message-ID: <20120908003954.4648.5528.stgit@dusk.lan>
References: <20120908002614.4648.31150.stgit@dusk.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:59134 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759333Ab2IHAlr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Sep 2012 20:41:47 -0400
In-Reply-To: <20120908002614.4648.31150.stgit@dusk.lan>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Clean up the OMAP clock code sections of the Makefile to save
some lines of diff.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/Makefile |   21 ++++++++-------------
 1 file changed, 8 insertions(+), 13 deletions(-)

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index e9de8d2..89e0daf 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -6,9 +6,6 @@
 obj-y := id.o io.o control.o mux.o devices.o serial.o gpmc.o timer.o pm.o \
 	 common.o gpio.o dma.o wd_timer.o display.o i2c.o hdq1w.o omap_hwmod.o
 
-clock-common				= clock.o clock_common_data.o \
-					  clkt_dpll.o clkt_clksel.o
-
 # INTCPS IP block support - XXX should be moved to drivers/
 obj-$(CONFIG_ARCH_OMAP2)		+= irq.o
 obj-$(CONFIG_ARCH_OMAP3)		+= irq.o
@@ -155,24 +152,22 @@ obj-$(CONFIG_SOC_OMAP5)			+= $(clockdomain-common)
 obj-$(CONFIG_SOC_OMAP5)			+= clockdomain44xx.o
 
 # Clock framework
-obj-$(CONFIG_ARCH_OMAP2)		+= $(clock-common) clock2xxx.o
-obj-$(CONFIG_ARCH_OMAP2)		+= clkt2xxx_sys.o
-obj-$(CONFIG_ARCH_OMAP2)		+= clkt2xxx_dpllcore.o
+obj-y					+= clock.o clock_common_data.o \
+					   clkt_dpll.o clkt_clksel.o
+obj-$(CONFIG_ARCH_OMAP2)		+= clock2xxx.o
+obj-$(CONFIG_ARCH_OMAP2)		+= clkt2xxx_dpllcore.o clkt2xxx_sys.o
 obj-$(CONFIG_ARCH_OMAP2)		+= clkt2xxx_virt_prcm_set.o
 obj-$(CONFIG_ARCH_OMAP2)		+= clkt2xxx_apll.o clkt2xxx_osc.o
 obj-$(CONFIG_ARCH_OMAP2)		+= clkt2xxx_dpll.o clkt_iclk.o
 obj-$(CONFIG_SOC_OMAP2420)		+= clock2420_data.o
 obj-$(CONFIG_SOC_OMAP2430)		+= clock2430.o clock2430_data.o
-obj-$(CONFIG_ARCH_OMAP3)		+= $(clock-common) clock3xxx.o
+obj-$(CONFIG_ARCH_OMAP3)		+= clock3xxx.o
 obj-$(CONFIG_ARCH_OMAP3)		+= clock34xx.o clkt34xx_dpll3m2.o
-obj-$(CONFIG_ARCH_OMAP3)		+= clock3517.o clock36xx.o
+obj-$(CONFIG_ARCH_OMAP3)		+= clock3517.o clock36xx.o clkt_iclk.o
 obj-$(CONFIG_ARCH_OMAP3)		+= dpll3xxx.o clock3xxx_data.o
-obj-$(CONFIG_ARCH_OMAP3)		+= clkt_iclk.o
-obj-$(CONFIG_ARCH_OMAP4)		+= $(clock-common) clock44xx_data.o
+obj-$(CONFIG_ARCH_OMAP4)		+= clock44xx_data.o
 obj-$(CONFIG_ARCH_OMAP4)		+= dpll3xxx.o dpll44xx.o
-obj-$(CONFIG_SOC_AM33XX)		+= $(clock-common) dpll3xxx.o
-obj-$(CONFIG_SOC_AM33XX)		+= clock33xx_data.o
-obj-$(CONFIG_SOC_OMAP5)			+= $(clock-common)
+obj-$(CONFIG_SOC_AM33XX)		+= dpll3xxx.o clock33xx_data.o
 obj-$(CONFIG_SOC_OMAP5)			+= dpll3xxx.o dpll44xx.o
 
 # OMAP2 clock rate set data (old "OPP" data)


