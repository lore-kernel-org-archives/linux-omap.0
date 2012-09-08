From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 2/6] ARM: OMAP2+: clean up omap_hwmod.o build directives in
 Makefile
Date: Fri, 07 Sep 2012 18:39:48 -0600
Message-ID: <20120908003938.4648.33787.stgit@dusk.lan>
References: <20120908002614.4648.31150.stgit@dusk.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:59127 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755603Ab2IHAlq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Sep 2012 20:41:46 -0400
In-Reply-To: <20120908002614.4648.31150.stgit@dusk.lan>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Move the omap_hwmod_common_data.o build directive down to the hwmod
data Makefile section where it belongs.  Move the omap_hwmod.o build
directive to the top 'Common support' line, since we have no separate
hwmod code Makefile section, and it's currently needed for all OMAP2+.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/Makefile |   15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 22ee340..bdcf508 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -4,20 +4,18 @@
 
 # Common support
 obj-y := id.o io.o control.o mux.o devices.o serial.o gpmc.o timer.o pm.o \
-	 common.o gpio.o dma.o wd_timer.o display.o i2c.o hdq1w.o
+	 common.o gpio.o dma.o wd_timer.o display.o i2c.o hdq1w.o omap_hwmod.o
 
 omap-2-3-common				= irq.o
-hwmod-common				= omap_hwmod.o \
-					  omap_hwmod_common_data.o
 clock-common				= clock.o clock_common_data.o \
 					  clkt_dpll.o clkt_clksel.o
 secure-common				= omap-smc.o omap-secure.o
 
-obj-$(CONFIG_ARCH_OMAP2) += $(omap-2-3-common) $(hwmod-common)
-obj-$(CONFIG_ARCH_OMAP3) += $(omap-2-3-common) $(hwmod-common) $(secure-common)
-obj-$(CONFIG_ARCH_OMAP4) += prm44xx.o $(hwmod-common) $(secure-common)
-obj-$(CONFIG_SOC_AM33XX) += irq.o $(hwmod-common)
-obj-$(CONFIG_SOC_OMAP5)	 += prm44xx.o $(hwmod-common) $(secure-common)
+obj-$(CONFIG_ARCH_OMAP2) += $(omap-2-3-common)
+obj-$(CONFIG_ARCH_OMAP3) += $(omap-2-3-common) $(secure-common)
+obj-$(CONFIG_ARCH_OMAP4) += prm44xx.o $(secure-common)
+obj-$(CONFIG_SOC_AM33XX) += irq.o
+obj-$(CONFIG_SOC_OMAP5)	 += prm44xx.o $(secure-common)
 
 ifneq ($(CONFIG_SND_OMAP_SOC_MCBSP),)
 obj-y += mcbsp.o
@@ -181,6 +179,7 @@ obj-$(CONFIG_SOC_OMAP2420)		+= opp2420_data.o
 obj-$(CONFIG_SOC_OMAP2430)		+= opp2430_data.o
 
 # hwmod data
+obj-y					+= omap_hwmod_common_data.o
 obj-$(CONFIG_SOC_OMAP2420)		+= omap_hwmod_2xxx_ipblock_data.o
 obj-$(CONFIG_SOC_OMAP2420)		+= omap_hwmod_2xxx_3xxx_ipblock_data.o
 obj-$(CONFIG_SOC_OMAP2420)		+= omap_hwmod_2xxx_interconnect_data.o


