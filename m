From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH 2/7] ARM: OMAP2+: Clean up wrapping multiple objects in Makefile
Date: Wed, 2 May 2012 15:18:08 +0530
Message-ID: <1335952093-12541-3-git-send-email-santosh.shilimkar@ti.com>
References: <1335952093-12541-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:36370 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751927Ab2EBJsd (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 2 May 2012 05:48:33 -0400
In-Reply-To: <1335952093-12541-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, tony@atomide.com, Santosh Shilimkar <santosh.shilimkar@ti.com>

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/mach-omap2/Makefile |  160 ++++++++++++++++++++---------------------
 1 files changed, 78 insertions(+), 82 deletions(-)

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 56ed62e..669e2b1 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -24,10 +24,11 @@ endif
 obj-$(CONFIG_TWL4030_CORE) += omap_twl.o
 
 # SMP support ONLY available for OMAP4
+
 obj-$(CONFIG_SMP)			+= omap-smp.o omap-headsmp.o
 obj-$(CONFIG_HOTPLUG_CPU)		+= omap-hotplug.o
-obj-$(CONFIG_ARCH_OMAP4)		+= omap4-common.o omap-wakeupgen.o \
-					   sleep44xx.o
+obj-$(CONFIG_ARCH_OMAP4)		+= omap4-common.o omap-wakeupgen.o
+obj-$(CONFIG_ARCH_OMAP4)		+= sleep44xx.o
 
 plus_sec := $(call as-instr,.arch_extension sec,+sec)
 AFLAGS_omap-headsmp.o			:=-Wa,-march=armv7-a$(plus_sec)
@@ -64,10 +65,10 @@ endif
 ifeq ($(CONFIG_PM),y)
 obj-$(CONFIG_ARCH_OMAP2)		+= pm24xx.o
 obj-$(CONFIG_ARCH_OMAP2)		+= sleep24xx.o
-obj-$(CONFIG_ARCH_OMAP3)		+= pm34xx.o sleep34xx.o \
-					   cpuidle34xx.o
-obj-$(CONFIG_ARCH_OMAP4)		+= pm44xx.o omap-mpuss-lowpower.o \
-					   cpuidle44xx.o
+obj-$(CONFIG_ARCH_OMAP3)		+= pm34xx.o sleep34xx.o
+obj-$(CONFIG_ARCH_OMAP3)		+= cpuidle34xx.o
+obj-$(CONFIG_ARCH_OMAP4)		+= pm44xx.o omap-mpuss-lowpower.o
+obj-$(CONFIG_ARCH_OMAP4)		+= cpuidle44xx.o
 obj-$(CONFIG_PM_DEBUG)			+= pm-debug.o
 obj-$(CONFIG_OMAP_SMARTREFLEX)          += sr_device.o smartreflex.o
 obj-$(CONFIG_OMAP_SMARTREFLEX_CLASS3)	+= smartreflex-class3.o
@@ -84,85 +85,84 @@ endif
 # PRCM
 obj-y					+= prm_common.o
 obj-$(CONFIG_ARCH_OMAP2)		+= prcm.o cm2xxx_3xxx.o prm2xxx_3xxx.o
-obj-$(CONFIG_ARCH_OMAP3)		+= prcm.o cm2xxx_3xxx.o prm2xxx_3xxx.o \
-					   vc3xxx_data.o vp3xxx_data.o
-obj-$(CONFIG_ARCH_OMAP4)		+= prcm.o cminst44xx.o \
-					   cm44xx.o prcm_mpu44xx.o \
-					   prminst44xx.o vc44xx_data.o \
-					   vp44xx_data.o prm44xx.o
+obj-$(CONFIG_ARCH_OMAP3)		+= prcm.o cm2xxx_3xxx.o prm2xxx_3xxx.o
+obj-$(CONFIG_ARCH_OMAP3)		+= vc3xxx_data.o vp3xxx_data.o
+obj-$(CONFIG_ARCH_OMAP4)		+= prcm.o cminst44xx.o cm44xx.o
+obj-$(CONFIG_ARCH_OMAP4)		+= prcm_mpu44xx.o prminst44xx.o
+obj-$(CONFIG_ARCH_OMAP4)		+= vc44xx_data.o vp44xx_data.o prm44xx.o
 
 # OMAP voltage domains
 voltagedomain-common			:= voltage.o vc.o vp.o
-obj-$(CONFIG_ARCH_OMAP2)		+= $(voltagedomain-common) \
-					   voltagedomains2xxx_data.o
-obj-$(CONFIG_ARCH_OMAP3)		+= $(voltagedomain-common) \
-					   voltagedomains3xxx_data.o
-obj-$(CONFIG_ARCH_OMAP4)		+= $(voltagedomain-common) \
-					   voltagedomains44xx_data.o
+obj-$(CONFIG_ARCH_OMAP2)		+= $(voltagedomain-common)
+obj-$(CONFIG_ARCH_OMAP2)		+= voltagedomains2xxx_data.o
+obj-$(CONFIG_ARCH_OMAP3)		+= $(voltagedomain-common)
+obj-$(CONFIG_ARCH_OMAP3)		+= voltagedomains3xxx_data.o
+obj-$(CONFIG_ARCH_OMAP4)		+= $(voltagedomain-common)
+obj-$(CONFIG_ARCH_OMAP4)		+= voltagedomains44xx_data.o
 
 # OMAP powerdomain framework
 powerdomain-common			+= powerdomain.o powerdomain-common.o
-obj-$(CONFIG_ARCH_OMAP2)		+= $(powerdomain-common) \
-					   powerdomain2xxx_3xxx.o \
-					   powerdomains2xxx_data.o \
-					   powerdomains2xxx_3xxx_data.o
-obj-$(CONFIG_ARCH_OMAP3)		+= $(powerdomain-common) \
-					   powerdomain2xxx_3xxx.o \
-					   powerdomains3xxx_data.o \
-					   powerdomains2xxx_3xxx_data.o
-obj-$(CONFIG_ARCH_OMAP4)		+= $(powerdomain-common) \
-					   powerdomain44xx.o \
-					   powerdomains44xx_data.o
+obj-$(CONFIG_ARCH_OMAP2)		+= $(powerdomain-common)
+obj-$(CONFIG_ARCH_OMAP2)		+= powerdomains2xxx_data.o
+obj-$(CONFIG_ARCH_OMAP2)		+= powerdomain2xxx_3xxx.o
+obj-$(CONFIG_ARCH_OMAP2)		+= powerdomains2xxx_3xxx_data.o
+obj-$(CONFIG_ARCH_OMAP3)		+= $(powerdomain-common)
+obj-$(CONFIG_ARCH_OMAP3)		+= powerdomain2xxx_3xxx.o
+obj-$(CONFIG_ARCH_OMAP3)		+= powerdomains3xxx_data.o
+obj-$(CONFIG_ARCH_OMAP3)		+= powerdomains2xxx_3xxx_data.o
+obj-$(CONFIG_ARCH_OMAP4)		+= $(powerdomain-common)
+obj-$(CONFIG_ARCH_OMAP4)		+= powerdomain44xx.o
+obj-$(CONFIG_ARCH_OMAP4)		+= powerdomains44xx_data.o
 
 # PRCM clockdomain control
-obj-$(CONFIG_ARCH_OMAP2)		+= clockdomain.o \
-					   clockdomain2xxx_3xxx.o \
-					   clockdomains2xxx_3xxx_data.o
+obj-$(CONFIG_ARCH_OMAP2)		+= clockdomain.o
+obj-$(CONFIG_ARCH_OMAP2)		+= clockdomain2xxx_3xxx.o
+obj-$(CONFIG_ARCH_OMAP2)		+= clockdomains2xxx_3xxx_data.o
 obj-$(CONFIG_SOC_OMAP2420)		+= clockdomains2420_data.o
 obj-$(CONFIG_SOC_OMAP2430)		+= clockdomains2430_data.o
-obj-$(CONFIG_ARCH_OMAP3)		+= clockdomain.o \
-					   clockdomain2xxx_3xxx.o \
-					   clockdomains2xxx_3xxx_data.o \
-					   clockdomains3xxx_data.o
-obj-$(CONFIG_ARCH_OMAP4)		+= clockdomain.o \
-					   clockdomain44xx.o \
-					   clockdomains44xx_data.o
+obj-$(CONFIG_ARCH_OMAP3)		+= clockdomain.o
+obj-$(CONFIG_ARCH_OMAP3)		+= clockdomain2xxx_3xxx.o
+obj-$(CONFIG_ARCH_OMAP3)		+= clockdomains2xxx_3xxx_data.o
+obj-$(CONFIG_ARCH_OMAP3)		+= clockdomains3xxx_data.o
+obj-$(CONFIG_ARCH_OMAP4)		+= clockdomain.o
+obj-$(CONFIG_ARCH_OMAP4)		+= clockdomain44xx.o
+obj-$(CONFIG_ARCH_OMAP4)		+= clockdomains44xx_data.o
 
 # Clock framework
-obj-$(CONFIG_ARCH_OMAP2)		+= $(clock-common) clock2xxx.o \
-					   clkt2xxx_sys.o \
-					   clkt2xxx_dpllcore.o \
-					   clkt2xxx_virt_prcm_set.o \
-					   clkt2xxx_apll.o clkt2xxx_osc.o \
-					   clkt2xxx_dpll.o clkt_iclk.o
+obj-$(CONFIG_ARCH_OMAP2)		+= $(clock-common) clock2xxx.o
+obj-$(CONFIG_ARCH_OMAP2)		+= clkt2xxx_sys.o
+obj-$(CONFIG_ARCH_OMAP2)		+= clkt2xxx_dpllcore.o
+obj-$(CONFIG_ARCH_OMAP2)		+= clkt2xxx_virt_prcm_set.o
+obj-$(CONFIG_ARCH_OMAP2)		+= clkt2xxx_apll.o clkt2xxx_osc.o
+obj-$(CONFIG_ARCH_OMAP2)		+= clkt2xxx_dpll.o clkt_iclk.o
 obj-$(CONFIG_SOC_OMAP2420)		+= clock2420_data.o
 obj-$(CONFIG_SOC_OMAP2430)		+= clock2430.o clock2430_data.o
-obj-$(CONFIG_ARCH_OMAP3)		+= $(clock-common) clock3xxx.o \
-					   clock34xx.o clkt34xx_dpll3m2.o \
-					   clock3517.o clock36xx.o \
-					   dpll3xxx.o clock3xxx_data.o \
-					   clkt_iclk.o
-obj-$(CONFIG_ARCH_OMAP4)		+= $(clock-common) clock44xx_data.o \
-					   dpll3xxx.o dpll44xx.o
+obj-$(CONFIG_ARCH_OMAP3)		+= $(clock-common) clock3xxx.o
+obj-$(CONFIG_ARCH_OMAP3)		+= clock34xx.o clkt34xx_dpll3m2.o
+obj-$(CONFIG_ARCH_OMAP3)		+= clock3517.o clock36xx.o
+obj-$(CONFIG_ARCH_OMAP3)		+= dpll3xxx.o clock3xxx_data.o
+obj-$(CONFIG_ARCH_OMAP3)		+= clkt_iclk.o
+obj-$(CONFIG_ARCH_OMAP4)		+= $(clock-common) clock44xx_data.o
+obj-$(CONFIG_ARCH_OMAP4)		+= dpll3xxx.o dpll44xx.o
 
 # OMAP2 clock rate set data (old "OPP" data)
 obj-$(CONFIG_SOC_OMAP2420)		+= opp2420_data.o
 obj-$(CONFIG_SOC_OMAP2430)		+= opp2430_data.o
 
 # hwmod data
-obj-$(CONFIG_SOC_OMAP2420)		+= omap_hwmod_2xxx_ipblock_data.o \
-					   omap_hwmod_2xxx_3xxx_ipblock_data.o \
-					   omap_hwmod_2xxx_interconnect_data.o \
-					   omap_hwmod_2xxx_3xxx_interconnect_data.o \
-					   omap_hwmod_2420_data.o
-obj-$(CONFIG_SOC_OMAP2430)		+= omap_hwmod_2xxx_ipblock_data.o \
-					   omap_hwmod_2xxx_3xxx_ipblock_data.o \
-					   omap_hwmod_2xxx_interconnect_data.o \
-					   omap_hwmod_2xxx_3xxx_interconnect_data.o \
-					   omap_hwmod_2430_data.o
-obj-$(CONFIG_ARCH_OMAP3)		+= omap_hwmod_2xxx_3xxx_ipblock_data.o \
-					   omap_hwmod_2xxx_3xxx_interconnect_data.o \
-					   omap_hwmod_3xxx_data.o
+obj-$(CONFIG_SOC_OMAP2420)		+= omap_hwmod_2xxx_ipblock_data.o
+obj-$(CONFIG_SOC_OMAP2420)		+= omap_hwmod_2xxx_3xxx_ipblock_data.o
+obj-$(CONFIG_SOC_OMAP2420)		+= omap_hwmod_2xxx_interconnect_data.o
+obj-$(CONFIG_SOC_OMAP2420)		+= omap_hwmod_2xxx_3xxx_interconnect_data.o
+obj-$(CONFIG_SOC_OMAP2420)		+= omap_hwmod_2420_data.o
+obj-$(CONFIG_SOC_OMAP2430)		+= omap_hwmod_2xxx_ipblock_data.o
+obj-$(CONFIG_SOC_OMAP2430)		+= omap_hwmod_2xxx_3xxx_ipblock_data.o
+obj-$(CONFIG_SOC_OMAP2430)		+= omap_hwmod_2xxx_interconnect_data.o
+obj-$(CONFIG_SOC_OMAP2430)		+= omap_hwmod_2xxx_3xxx_interconnect_data.o
+obj-$(CONFIG_SOC_OMAP2430)		+= omap_hwmod_2430_data.o
+obj-$(CONFIG_ARCH_OMAP3)		+= omap_hwmod_2xxx_3xxx_ipblock_data.o
+obj-$(CONFIG_ARCH_OMAP3)		+= omap_hwmod_2xxx_3xxx_interconnect_data.o
+obj-$(CONFIG_ARCH_OMAP3)		+= omap_hwmod_3xxx_data.o
 obj-$(CONFIG_ARCH_OMAP4)		+= omap_hwmod_44xx_data.o
 
 # EMU peripherals
@@ -200,23 +200,19 @@ obj-$(CONFIG_MACH_OMAP3EVM)		+= board-omap3evm.o
 obj-$(CONFIG_MACH_OMAP3_PANDORA)	+= board-omap3pandora.o
 obj-$(CONFIG_MACH_OMAP_3430SDP)		+= board-3430sdp.o
 obj-$(CONFIG_MACH_NOKIA_N8X0)		+= board-n8x0.o
-obj-$(CONFIG_MACH_NOKIA_RM680)		+= board-rm680.o \
-					   sdram-nokia.o
-obj-$(CONFIG_MACH_NOKIA_RX51)		+= board-rx51.o \
-					   sdram-nokia.o \
-					   board-rx51-peripherals.o \
-					   board-rx51-video.o
-obj-$(CONFIG_MACH_OMAP_ZOOM2)		+= board-zoom.o \
-					   board-zoom-peripherals.o \
-					   board-zoom-display.o \
-					   board-zoom-debugboard.o
-obj-$(CONFIG_MACH_OMAP_ZOOM3)		+= board-zoom.o \
-					   board-zoom-peripherals.o \
-					   board-zoom-display.o \
-					   board-zoom-debugboard.o
-obj-$(CONFIG_MACH_OMAP_3630SDP)		+= board-3630sdp.o \
-					   board-zoom-peripherals.o \
-					   board-zoom-display.o
+obj-$(CONFIG_MACH_NOKIA_RM680)		+= board-rm680.o sdram-nokia.o
+obj-$(CONFIG_MACH_NOKIA_RX51)		+= board-rx51.o sdram-nokia.o
+obj-$(CONFIG_MACH_NOKIA_RX51)		+= board-rx51-peripherals.o
+obj-$(CONFIG_MACH_NOKIA_RX51)		+= board-rx51-video.o
+obj-$(CONFIG_MACH_OMAP_ZOOM2)		+= board-zoom.o board-zoom-peripherals.o
+obj-$(CONFIG_MACH_OMAP_ZOOM2)		+= board-zoom-display.o
+obj-$(CONFIG_MACH_OMAP_ZOOM2)		+= board-zoom-debugboard.o
+obj-$(CONFIG_MACH_OMAP_ZOOM3)		+= board-zoom.o board-zoom-peripherals.o
+obj-$(CONFIG_MACH_OMAP_ZOOM3)		+= board-zoom-display.o
+obj-$(CONFIG_MACH_OMAP_ZOOM3)		+= board-zoom-debugboard.o
+obj-$(CONFIG_MACH_OMAP_3630SDP)		+= board-3630sdp.o
+obj-$(CONFIG_MACH_OMAP_3630SDP)		+= board-zoom-peripherals.o
+obj-$(CONFIG_MACH_OMAP_3630SDP)		+= board-zoom-display.o
 obj-$(CONFIG_MACH_CM_T35)		+= board-cm-t35.o
 obj-$(CONFIG_MACH_CM_T3517)		+= board-cm-t3517.o
 obj-$(CONFIG_MACH_IGEP0020)		+= board-igep0020.o
-- 
1.7.5.4

