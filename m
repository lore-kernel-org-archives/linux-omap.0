From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 2/5] ARM: OMAP2+: PRM: split PRM functions into OMAP2,
 OMAP3-specific files
Date: Mon, 15 Oct 2012 17:05:42 -0600
Message-ID: <20121015230541.18306.61050.stgit@dusk.lan>
References: <20121015224455.18306.89030.stgit@dusk.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:42503 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752975Ab2JOXG5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 15 Oct 2012 19:06:57 -0400
In-Reply-To: <20121015224455.18306.89030.stgit@dusk.lan>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Move OMAP3xxx-specific PRM functions & macros into prm3xxx.[ch] and
OMAP2xxx-specific macros into prm2xxx.h.  (prm2xxx.c will be created
by a subsequent patch when it's needed.)  Move basic PRM register
access functions into static inline functions in prm2xxx_3xxx.h, leavin=
g
only OMAP2/3 hardreset functions in prm2xxx_3xxx.c.

Also clarify the initcall function naming to reinforce that this code
is specifically for the PRM IP block.

This is in preparation for the upcoming powerdomain series and the
upcoming move of this code to drivers/.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/Makefile           |  100 +++++++-----
 arch/arm/mach-omap2/control.c          |    2=20
 arch/arm/mach-omap2/omap_hwmod.c       |    2=20
 arch/arm/mach-omap2/pm24xx.c           |    2=20
 arch/arm/mach-omap2/pm34xx.c           |    2=20
 arch/arm/mach-omap2/prm-regbits-24xx.h |    2=20
 arch/arm/mach-omap2/prm-regbits-34xx.h |    2=20
 arch/arm/mach-omap2/prm2xxx.h          |  122 +++++++++++++++
 arch/arm/mach-omap2/prm2xxx_3xxx.c     |  265 ------------------------=
--------
 arch/arm/mach-omap2/prm2xxx_3xxx.h     |  256 ++++++------------------=
-------
 arch/arm/mach-omap2/prm3xxx.c          |  164 ++------------------
 arch/arm/mach-omap2/prm3xxx.h          |  158 +++++++++++++++++++
 arch/arm/mach-omap2/prm44xx.c          |   15 +-
 arch/arm/mach-omap2/sdrc2xxx.c         |    2=20
 arch/arm/mach-omap2/sleep34xx.S        |    2=20
 arch/arm/mach-omap2/sram242x.S         |    2=20
 arch/arm/mach-omap2/sram243x.S         |    2=20
 17 files changed, 421 insertions(+), 679 deletions(-)
 create mode 100644 arch/arm/mach-omap2/prm2xxx.h
 copy arch/arm/mach-omap2/{prm2xxx_3xxx.c =3D> prm3xxx.c} (57%)
 create mode 100644 arch/arm/mach-omap2/prm3xxx.h

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefil=
e
index fe40d9e..20849604 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -4,30 +4,36 @@
=20
 # Common support
 obj-y :=3D id.o io.o control.o mux.o devices.o serial.o gpmc.o timer.o=
 pm.o \
-	 common.o gpio.o dma.o wd_timer.o display.o i2c.o hdq1w.o omap_hwmod.=
o
+	 common.o gpio.o dma.o wd_timer.o display.o i2c.o hdq1w.o
=20
-# INTCPS IP block support - XXX should be moved to drivers/
-obj-$(CONFIG_ARCH_OMAP2)		+=3D irq.o
-obj-$(CONFIG_ARCH_OMAP3)		+=3D irq.o
-obj-$(CONFIG_SOC_AM33XX)		+=3D irq.o
+omap-2-3-common				=3D irq.o
+hwmod-common				=3D omap_hwmod.o \
+					  omap_hwmod_common_data.o
+clock-common				=3D clock.o clock_common_data.o \
+					  clkt_dpll.o clkt_clksel.o
+secure-common				=3D omap-smc.o omap-secure.o
=20
-# Secure monitor API support
-obj-$(CONFIG_ARCH_OMAP3)		+=3D omap-smc.o omap-secure.o
-obj-$(CONFIG_ARCH_OMAP4)		+=3D omap-smc.o omap-secure.o
-obj-$(CONFIG_SOC_OMAP5)			+=3D omap-smc.o omap-secure.o
+obj-$(CONFIG_ARCH_OMAP2) +=3D $(omap-2-3-common) $(hwmod-common)
+obj-$(CONFIG_ARCH_OMAP3) +=3D $(omap-2-3-common) $(hwmod-common) $(sec=
ure-common)
+obj-$(CONFIG_ARCH_OMAP4) +=3D prm44xx.o $(hwmod-common) $(secure-commo=
n)
+obj-$(CONFIG_SOC_AM33XX) +=3D irq.o $(hwmod-common)
+obj-$(CONFIG_SOC_OMAP5)	 +=3D prm44xx.o $(hwmod-common) $(secure-commo=
n)
=20
 ifneq ($(CONFIG_SND_OMAP_SOC_MCBSP),)
 obj-y +=3D mcbsp.o
 endif
=20
-obj-$(CONFIG_TWL4030_CORE)		+=3D omap_twl.o
+obj-$(CONFIG_TWL4030_CORE) +=3D omap_twl.o
+obj-$(CONFIG_SOC_HAS_OMAP2_SDRC)	+=3D sdrc.o
=20
 # SMP support ONLY available for OMAP4
=20
 obj-$(CONFIG_SMP)			+=3D omap-smp.o omap-headsmp.o
 obj-$(CONFIG_HOTPLUG_CPU)		+=3D omap-hotplug.o
-obj-$(CONFIG_ARCH_OMAP4)		+=3D omap4-common.o omap-wakeupgen.o
-obj-$(CONFIG_SOC_OMAP5)			+=3D omap4-common.o omap-wakeupgen.o
+omap-4-5-common				=3D  omap4-common.o omap-wakeupgen.o \
+					   sleep44xx.o
+obj-$(CONFIG_ARCH_OMAP4)		+=3D $(omap-4-5-common)
+obj-$(CONFIG_SOC_OMAP5)			+=3D $(omap-4-5-common)
=20
 plus_sec :=3D $(call as-instr,.arch_extension sec,+sec)
 AFLAGS_omap-headsmp.o			:=3D-Wa,-march=3Darmv7-a$(plus_sec)
@@ -52,7 +58,6 @@ obj-$(CONFIG_ARCH_OMAP4)		+=3D mux44xx.o
 # SMS/SDRC
 obj-$(CONFIG_ARCH_OMAP2)		+=3D sdrc2xxx.o
 # obj-$(CONFIG_ARCH_OMAP3)		+=3D sdrc3xxx.o
-obj-$(CONFIG_SOC_HAS_OMAP2_SDRC)	+=3D sdrc.o
=20
 # OPP table initialization
 ifeq ($(CONFIG_PM_OPP),y)
@@ -63,15 +68,15 @@ endif
=20
 # Power Management
 ifeq ($(CONFIG_PM),y)
-obj-$(CONFIG_ARCH_OMAP2)		+=3D pm24xx.o sleep24xx.o
+obj-$(CONFIG_ARCH_OMAP2)		+=3D pm24xx.o
+obj-$(CONFIG_ARCH_OMAP2)		+=3D sleep24xx.o
 obj-$(CONFIG_ARCH_OMAP3)		+=3D pm34xx.o sleep34xx.o
 obj-$(CONFIG_ARCH_OMAP4)		+=3D pm44xx.o omap-mpuss-lowpower.o
-obj-$(CONFIG_ARCH_OMAP4)		+=3D sleep44xx.o
-obj-$(CONFIG_SOC_OMAP5)			+=3D omap-mpuss-lowpower.o sleep44xx.o
+obj-$(CONFIG_SOC_OMAP5)			+=3D omap-mpuss-lowpower.o
 obj-$(CONFIG_PM_DEBUG)			+=3D pm-debug.o
=20
 obj-$(CONFIG_POWER_AVS_OMAP)		+=3D sr_device.o
-obj-$(CONFIG_POWER_AVS_OMAP_CLASS3)	+=3D smartreflex-class3.o
+obj-$(CONFIG_POWER_AVS_OMAP_CLASS3)    +=3D smartreflex-class3.o
=20
 AFLAGS_sleep24xx.o			:=3D-Wa,-march=3Darmv6
 AFLAGS_sleep34xx.o			:=3D-Wa,-march=3Darmv7-a$(plus_sec)
@@ -83,76 +88,88 @@ endif
 endif
=20
 ifeq ($(CONFIG_CPU_IDLE),y)
-obj-$(CONFIG_ARCH_OMAP3)		+=3D cpuidle34xx.o
-obj-$(CONFIG_ARCH_OMAP4)		+=3D cpuidle44xx.o
+obj-$(CONFIG_ARCH_OMAP3)                +=3D cpuidle34xx.o
+obj-$(CONFIG_ARCH_OMAP4)                +=3D cpuidle44xx.o
 endif
=20
 # PRCM
 obj-y					+=3D prcm.o prm_common.o
 obj-$(CONFIG_ARCH_OMAP2)		+=3D cm2xxx_3xxx.o prm2xxx_3xxx.o
 obj-$(CONFIG_ARCH_OMAP3)		+=3D cm2xxx_3xxx.o prm2xxx_3xxx.o
+obj-$(CONFIG_ARCH_OMAP3)		+=3D prm3xxx.o
 obj-$(CONFIG_ARCH_OMAP3)		+=3D vc3xxx_data.o vp3xxx_data.o
 obj-$(CONFIG_SOC_AM33XX)		+=3D prm33xx.o cm33xx.o
 omap-prcm-4-5-common			=3D  cminst44xx.o cm44xx.o prm44xx.o \
 					   prcm_mpu44xx.o prminst44xx.o \
-					   vc44xx_data.o vp44xx_data.o \
-					   prm44xx.o
+					   vc44xx_data.o vp44xx_data.o
 obj-$(CONFIG_ARCH_OMAP4)		+=3D $(omap-prcm-4-5-common)
 obj-$(CONFIG_SOC_OMAP5)			+=3D $(omap-prcm-4-5-common)
=20
 # OMAP voltage domains
-obj-y					+=3D voltage.o vc.o vp.o
+voltagedomain-common			:=3D voltage.o vc.o vp.o
+obj-$(CONFIG_ARCH_OMAP2)		+=3D $(voltagedomain-common)
 obj-$(CONFIG_ARCH_OMAP2)		+=3D voltagedomains2xxx_data.o
+obj-$(CONFIG_ARCH_OMAP3)		+=3D $(voltagedomain-common)
 obj-$(CONFIG_ARCH_OMAP3)		+=3D voltagedomains3xxx_data.o
+obj-$(CONFIG_ARCH_OMAP4)		+=3D $(voltagedomain-common)
 obj-$(CONFIG_ARCH_OMAP4)		+=3D voltagedomains44xx_data.o
-obj-$(CONFIG_SOC_AM33XX)		+=3D voltagedomains33xx_data.o
+obj-$(CONFIG_SOC_AM33XX)		+=3D $(voltagedomain-common)
+obj-$(CONFIG_SOC_AM33XX)                +=3D voltagedomains33xx_data.o
+obj-$(CONFIG_SOC_OMAP5)			+=3D $(voltagedomain-common)
=20
 # OMAP powerdomain framework
-obj-y					+=3D powerdomain.o powerdomain-common.o
+powerdomain-common			+=3D powerdomain.o powerdomain-common.o
+obj-$(CONFIG_ARCH_OMAP2)		+=3D $(powerdomain-common)
 obj-$(CONFIG_ARCH_OMAP2)		+=3D powerdomains2xxx_data.o
-obj-$(CONFIG_ARCH_OMAP2)		+=3D powerdomain2xxx_3xxx.o
 obj-$(CONFIG_ARCH_OMAP2)		+=3D powerdomains2xxx_3xxx_data.o
-obj-$(CONFIG_ARCH_OMAP3)		+=3D powerdomain2xxx_3xxx.o
+obj-$(CONFIG_ARCH_OMAP3)		+=3D $(powerdomain-common)
 obj-$(CONFIG_ARCH_OMAP3)		+=3D powerdomains3xxx_data.o
 obj-$(CONFIG_ARCH_OMAP3)		+=3D powerdomains2xxx_3xxx_data.o
-obj-$(CONFIG_ARCH_OMAP4)		+=3D powerdomain44xx.o
+obj-$(CONFIG_ARCH_OMAP4)		+=3D $(powerdomain-common)
 obj-$(CONFIG_ARCH_OMAP4)		+=3D powerdomains44xx_data.o
-obj-$(CONFIG_SOC_AM33XX)		+=3D powerdomain33xx.o
+obj-$(CONFIG_SOC_AM33XX)		+=3D $(powerdomain-common)
 obj-$(CONFIG_SOC_AM33XX)		+=3D powerdomains33xx_data.o
-obj-$(CONFIG_SOC_OMAP5)			+=3D powerdomain44xx.o
+obj-$(CONFIG_SOC_OMAP5)			+=3D $(powerdomain-common)
=20
 # PRCM clockdomain control
-obj-y					+=3D clockdomain.o
+clockdomain-common			+=3D clockdomain.o
+obj-$(CONFIG_ARCH_OMAP2)		+=3D $(clockdomain-common)
 obj-$(CONFIG_ARCH_OMAP2)		+=3D clockdomain2xxx_3xxx.o
 obj-$(CONFIG_ARCH_OMAP2)		+=3D clockdomains2xxx_3xxx_data.o
 obj-$(CONFIG_SOC_OMAP2420)		+=3D clockdomains2420_data.o
 obj-$(CONFIG_SOC_OMAP2430)		+=3D clockdomains2430_data.o
+obj-$(CONFIG_ARCH_OMAP3)		+=3D $(clockdomain-common)
 obj-$(CONFIG_ARCH_OMAP3)		+=3D clockdomain2xxx_3xxx.o
 obj-$(CONFIG_ARCH_OMAP3)		+=3D clockdomains2xxx_3xxx_data.o
 obj-$(CONFIG_ARCH_OMAP3)		+=3D clockdomains3xxx_data.o
+obj-$(CONFIG_ARCH_OMAP4)		+=3D $(clockdomain-common)
 obj-$(CONFIG_ARCH_OMAP4)		+=3D clockdomain44xx.o
 obj-$(CONFIG_ARCH_OMAP4)		+=3D clockdomains44xx_data.o
+obj-$(CONFIG_SOC_AM33XX)		+=3D $(clockdomain-common)
 obj-$(CONFIG_SOC_AM33XX)		+=3D clockdomain33xx.o
 obj-$(CONFIG_SOC_AM33XX)		+=3D clockdomains33xx_data.o
+obj-$(CONFIG_SOC_OMAP5)			+=3D $(clockdomain-common)
 obj-$(CONFIG_SOC_OMAP5)			+=3D clockdomain44xx.o
=20
 # Clock framework
-obj-y					+=3D clock.o clock_common_data.o \
-					   clkt_dpll.o clkt_clksel.o
-obj-$(CONFIG_ARCH_OMAP2)		+=3D clock2xxx.o
-obj-$(CONFIG_ARCH_OMAP2)		+=3D clkt2xxx_dpllcore.o clkt2xxx_sys.o
+obj-$(CONFIG_ARCH_OMAP2)		+=3D $(clock-common) clock2xxx.o
+obj-$(CONFIG_ARCH_OMAP2)		+=3D clkt2xxx_sys.o
+obj-$(CONFIG_ARCH_OMAP2)		+=3D clkt2xxx_dpllcore.o
 obj-$(CONFIG_ARCH_OMAP2)		+=3D clkt2xxx_virt_prcm_set.o
 obj-$(CONFIG_ARCH_OMAP2)		+=3D clkt2xxx_apll.o clkt2xxx_osc.o
 obj-$(CONFIG_ARCH_OMAP2)		+=3D clkt2xxx_dpll.o clkt_iclk.o
 obj-$(CONFIG_SOC_OMAP2420)		+=3D clock2420_data.o
 obj-$(CONFIG_SOC_OMAP2430)		+=3D clock2430.o clock2430_data.o
-obj-$(CONFIG_ARCH_OMAP3)		+=3D clock3xxx.o
+obj-$(CONFIG_ARCH_OMAP3)		+=3D $(clock-common) clock3xxx.o
 obj-$(CONFIG_ARCH_OMAP3)		+=3D clock34xx.o clkt34xx_dpll3m2.o
-obj-$(CONFIG_ARCH_OMAP3)		+=3D clock3517.o clock36xx.o clkt_iclk.o
+obj-$(CONFIG_ARCH_OMAP3)		+=3D clock3517.o clock36xx.o
 obj-$(CONFIG_ARCH_OMAP3)		+=3D dpll3xxx.o clock3xxx_data.o
-obj-$(CONFIG_ARCH_OMAP4)		+=3D clock44xx_data.o
+obj-$(CONFIG_ARCH_OMAP3)		+=3D clkt_iclk.o
+obj-$(CONFIG_ARCH_OMAP4)		+=3D $(clock-common) clock44xx_data.o
 obj-$(CONFIG_ARCH_OMAP4)		+=3D dpll3xxx.o dpll44xx.o
-obj-$(CONFIG_SOC_AM33XX)		+=3D dpll3xxx.o clock33xx_data.o
+obj-$(CONFIG_SOC_AM33XX)		+=3D $(clock-common) dpll3xxx.o
+obj-$(CONFIG_SOC_AM33XX)		+=3D clock33xx_data.o
+obj-$(CONFIG_SOC_OMAP5)			+=3D $(clock-common)
 obj-$(CONFIG_SOC_OMAP5)			+=3D dpll3xxx.o dpll44xx.o
=20
 # OMAP2 clock rate set data (old "OPP" data)
@@ -160,7 +177,6 @@ obj-$(CONFIG_SOC_OMAP2420)		+=3D opp2420_data.o
 obj-$(CONFIG_SOC_OMAP2430)		+=3D opp2430_data.o
=20
 # hwmod data
-obj-y					+=3D omap_hwmod_common_data.o
 obj-$(CONFIG_SOC_OMAP2420)		+=3D omap_hwmod_2xxx_ipblock_data.o
 obj-$(CONFIG_SOC_OMAP2420)		+=3D omap_hwmod_2xxx_3xxx_ipblock_data.o
 obj-$(CONFIG_SOC_OMAP2420)		+=3D omap_hwmod_2xxx_interconnect_data.o
@@ -206,10 +222,10 @@ obj-$(CONFIG_MACH_OMAP_H4)		+=3D board-h4.o
 obj-$(CONFIG_MACH_OMAP_2430SDP)		+=3D board-2430sdp.o
 obj-$(CONFIG_MACH_OMAP_APOLLON)		+=3D board-apollon.o
 obj-$(CONFIG_MACH_OMAP3_BEAGLE)		+=3D board-omap3beagle.o
-obj-$(CONFIG_MACH_DEVKIT8000)		+=3D board-devkit8000.o
+obj-$(CONFIG_MACH_DEVKIT8000)     	+=3D board-devkit8000.o
 obj-$(CONFIG_MACH_OMAP_LDP)		+=3D board-ldp.o
-obj-$(CONFIG_MACH_OMAP3530_LV_SOM)	+=3D board-omap3logic.o
-obj-$(CONFIG_MACH_OMAP3_TORPEDO)	+=3D board-omap3logic.o
+obj-$(CONFIG_MACH_OMAP3530_LV_SOM)      +=3D board-omap3logic.o
+obj-$(CONFIG_MACH_OMAP3_TORPEDO)        +=3D board-omap3logic.o
 obj-$(CONFIG_MACH_ENCORE)		+=3D board-omap3encore.o
 obj-$(CONFIG_MACH_OVERO)		+=3D board-overo.o
 obj-$(CONFIG_MACH_OMAP3EVM)		+=3D board-omap3evm.o
diff --git a/arch/arm/mach-omap2/control.c b/arch/arm/mach-omap2/contro=
l.c
index d1ff839..1220e0e 100644
--- a/arch/arm/mach-omap2/control.c
+++ b/arch/arm/mach-omap2/control.c
@@ -22,7 +22,7 @@
 #include "common.h"
 #include "cm-regbits-34xx.h"
 #include "prm-regbits-34xx.h"
-#include "prm2xxx_3xxx.h"
+#include "prm3xxx.h"
 #include "cm2xxx_3xxx.h"
 #include "sdrc.h"
 #include "pm.h"
diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/oma=
p_hwmod.c
index b969ab1..525c58d 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -150,7 +150,7 @@
 #include "cm2xxx_3xxx.h"
 #include "cminst44xx.h"
 #include "cm33xx.h"
-#include "prm2xxx_3xxx.h"
+#include "prm3xxx.h"
 #include "prm44xx.h"
 #include "prm33xx.h"
 #include "prminst44xx.h"
diff --git a/arch/arm/mach-omap2/pm24xx.c b/arch/arm/mach-omap2/pm24xx.=
c
index 8af6cd6..78405a7 100644
--- a/arch/arm/mach-omap2/pm24xx.c
+++ b/arch/arm/mach-omap2/pm24xx.c
@@ -41,7 +41,7 @@
 #include <plat/dma.h>
=20
 #include "common.h"
-#include "prm2xxx_3xxx.h"
+#include "prm2xxx.h"
 #include "prm-regbits-24xx.h"
 #include "cm2xxx_3xxx.h"
 #include "cm-regbits-24xx.h"
diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.=
c
index ba670db..c02c9ca 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -48,7 +48,7 @@
 #include "cm-regbits-34xx.h"
 #include "prm-regbits-34xx.h"
=20
-#include "prm2xxx_3xxx.h"
+#include "prm3xxx.h"
 #include "pm.h"
 #include "sdrc.h"
 #include "control.h"
diff --git a/arch/arm/mach-omap2/prm-regbits-24xx.h b/arch/arm/mach-oma=
p2/prm-regbits-24xx.h
index 6ac9661..bd70a5a 100644
--- a/arch/arm/mach-omap2/prm-regbits-24xx.h
+++ b/arch/arm/mach-omap2/prm-regbits-24xx.h
@@ -14,7 +14,7 @@
  * published by the Free Software Foundation.
  */
=20
-#include "prm2xxx_3xxx.h"
+#include "prm2xxx.h"
=20
 /* Bits shared between registers */
=20
diff --git a/arch/arm/mach-omap2/prm-regbits-34xx.h b/arch/arm/mach-oma=
p2/prm-regbits-34xx.h
index 64c087a..073d4db 100644
--- a/arch/arm/mach-omap2/prm-regbits-34xx.h
+++ b/arch/arm/mach-omap2/prm-regbits-34xx.h
@@ -14,7 +14,7 @@
 #define __ARCH_ARM_MACH_OMAP2_PRM_REGBITS_34XX_H
=20
=20
-#include "prm2xxx_3xxx.h"
+#include "prm3xxx.h"
=20
 /* Shared register bits */
=20
diff --git a/arch/arm/mach-omap2/prm2xxx.h b/arch/arm/mach-omap2/prm2xx=
x.h
new file mode 100644
index 0000000..6490e1a
--- /dev/null
+++ b/arch/arm/mach-omap2/prm2xxx.h
@@ -0,0 +1,122 @@
+/*
+ * OMAP2xxx Power/Reset Management (PRM) register definitions
+ *
+ * Copyright (C) 2007-2009, 2011-2012 Texas Instruments, Inc.
+ * Copyright (C) 2008-2010 Nokia Corporation
+ * Paul Walmsley
+ *
+ * This program is free software; you can redistribute it and/or modif=
y
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * The PRM hardware modules on the OMAP2/3 are quite similar to each
+ * other.  The PRM on OMAP4 has a new register layout, and is handled
+ * in a separate file.
+ */
+#ifndef __ARCH_ARM_MACH_OMAP2_PRM2XXX_H
+#define __ARCH_ARM_MACH_OMAP2_PRM2XXX_H
+
+#include "prcm-common.h"
+#include "prm.h"
+#include "prm2xxx_3xxx.h"
+
+#define OMAP2420_PRM_REGADDR(module, reg)				\
+		OMAP2_L4_IO_ADDRESS(OMAP2420_PRM_BASE + (module) + (reg))
+#define OMAP2430_PRM_REGADDR(module, reg)				\
+		OMAP2_L4_IO_ADDRESS(OMAP2430_PRM_BASE + (module) + (reg))
+
+/*
+ * OMAP2-specific global PRM registers
+ * Use __raw_{read,write}l() with these registers.
+ *
+ * With a few exceptions, these are the register names beginning with
+ * PRCM_* on 24xx.  (The exceptions are the IRQSTATUS and IRQENABLE
+ * bits.)
+ *
+ */
+
+#define OMAP2_PRCM_REVISION_OFFSET	0x0000
+#define OMAP2420_PRCM_REVISION		OMAP2420_PRM_REGADDR(OCP_MOD, 0x0000)
+#define OMAP2_PRCM_SYSCONFIG_OFFSET	0x0010
+#define OMAP2420_PRCM_SYSCONFIG		OMAP2420_PRM_REGADDR(OCP_MOD, 0x0010)
+
+#define OMAP2_PRCM_IRQSTATUS_MPU_OFFSET	0x0018
+#define OMAP2420_PRCM_IRQSTATUS_MPU	OMAP2420_PRM_REGADDR(OCP_MOD, 0x00=
18)
+#define OMAP2_PRCM_IRQENABLE_MPU_OFFSET	0x001c
+#define OMAP2420_PRCM_IRQENABLE_MPU	OMAP2420_PRM_REGADDR(OCP_MOD, 0x00=
1c)
+
+#define OMAP2_PRCM_VOLTCTRL_OFFSET	0x0050
+#define OMAP2420_PRCM_VOLTCTRL		OMAP2420_PRM_REGADDR(OCP_MOD, 0x0050)
+#define OMAP2_PRCM_VOLTST_OFFSET	0x0054
+#define OMAP2420_PRCM_VOLTST		OMAP2420_PRM_REGADDR(OCP_MOD, 0x0054)
+#define OMAP2_PRCM_CLKSRC_CTRL_OFFSET	0x0060
+#define OMAP2420_PRCM_CLKSRC_CTRL	OMAP2420_PRM_REGADDR(OCP_MOD, 0x0060=
)
+#define OMAP2_PRCM_CLKOUT_CTRL_OFFSET	0x0070
+#define OMAP2420_PRCM_CLKOUT_CTRL	OMAP2420_PRM_REGADDR(OCP_MOD, 0x0070=
)
+#define OMAP2_PRCM_CLKEMUL_CTRL_OFFSET	0x0078
+#define OMAP2420_PRCM_CLKEMUL_CTRL	OMAP2420_PRM_REGADDR(OCP_MOD, 0x007=
8)
+#define OMAP2_PRCM_CLKCFG_CTRL_OFFSET	0x0080
+#define OMAP2420_PRCM_CLKCFG_CTRL	OMAP2420_PRM_REGADDR(OCP_MOD, 0x0080=
)
+#define OMAP2_PRCM_CLKCFG_STATUS_OFFSET	0x0084
+#define OMAP2420_PRCM_CLKCFG_STATUS	OMAP2420_PRM_REGADDR(OCP_MOD, 0x00=
84)
+#define OMAP2_PRCM_VOLTSETUP_OFFSET	0x0090
+#define OMAP2420_PRCM_VOLTSETUP		OMAP2420_PRM_REGADDR(OCP_MOD, 0x0090)
+#define OMAP2_PRCM_CLKSSETUP_OFFSET	0x0094
+#define OMAP2420_PRCM_CLKSSETUP		OMAP2420_PRM_REGADDR(OCP_MOD, 0x0094)
+#define OMAP2_PRCM_POLCTRL_OFFSET	0x0098
+#define OMAP2420_PRCM_POLCTRL		OMAP2420_PRM_REGADDR(OCP_MOD, 0x0098)
+
+#define OMAP2430_PRCM_REVISION		OMAP2430_PRM_REGADDR(OCP_MOD, 0x0000)
+#define OMAP2430_PRCM_SYSCONFIG		OMAP2430_PRM_REGADDR(OCP_MOD, 0x0010)
+
+#define OMAP2430_PRCM_IRQSTATUS_MPU	OMAP2430_PRM_REGADDR(OCP_MOD, 0x00=
18)
+#define OMAP2430_PRCM_IRQENABLE_MPU	OMAP2430_PRM_REGADDR(OCP_MOD, 0x00=
1c)
+
+#define OMAP2430_PRCM_VOLTCTRL		OMAP2430_PRM_REGADDR(OCP_MOD, 0x0050)
+#define OMAP2430_PRCM_VOLTST		OMAP2430_PRM_REGADDR(OCP_MOD, 0x0054)
+#define OMAP2430_PRCM_CLKSRC_CTRL	OMAP2430_PRM_REGADDR(OCP_MOD, 0x0060=
)
+#define OMAP2430_PRCM_CLKOUT_CTRL	OMAP2430_PRM_REGADDR(OCP_MOD, 0x0070=
)
+#define OMAP2430_PRCM_CLKEMUL_CTRL	OMAP2430_PRM_REGADDR(OCP_MOD, 0x007=
8)
+#define OMAP2430_PRCM_CLKCFG_CTRL	OMAP2430_PRM_REGADDR(OCP_MOD, 0x0080=
)
+#define OMAP2430_PRCM_CLKCFG_STATUS	OMAP2430_PRM_REGADDR(OCP_MOD, 0x00=
84)
+#define OMAP2430_PRCM_VOLTSETUP		OMAP2430_PRM_REGADDR(OCP_MOD, 0x0090)
+#define OMAP2430_PRCM_CLKSSETUP		OMAP2430_PRM_REGADDR(OCP_MOD, 0x0094)
+#define OMAP2430_PRCM_POLCTRL		OMAP2430_PRM_REGADDR(OCP_MOD, 0x0098)
+
+/*
+ * Module specific PRM register offsets from PRM_BASE + domain offset
+ *
+ * Use prm_{read,write}_mod_reg() with these registers.
+ *
+ * With a few exceptions, these are the register names beginning with
+ * {PM,RM}_* on both OMAP2/3 SoC families..  (The exceptions are the
+ * IRQSTATUS and IRQENABLE bits.)
+ */
+
+/* Register offsets appearing on both OMAP2 and OMAP3 */
+
+#define OMAP2_RM_RSTCTRL				0x0050
+#define OMAP2_RM_RSTTIME				0x0054
+#define OMAP2_RM_RSTST					0x0058
+#define OMAP2_PM_PWSTCTRL				0x00e0
+#define OMAP2_PM_PWSTST					0x00e4
+
+#define PM_WKEN						0x00a0
+#define PM_WKEN1					PM_WKEN
+#define PM_WKST						0x00b0
+#define PM_WKST1					PM_WKST
+#define PM_WKDEP					0x00c8
+#define PM_EVGENCTRL					0x00d4
+#define PM_EVGENONTIM					0x00d8
+#define PM_EVGENOFFTIM					0x00dc
+
+/* OMAP2xxx specific register offsets */
+#define OMAP24XX_PM_WKEN2				0x00a4
+#define OMAP24XX_PM_WKST2				0x00b4
+
+#define OMAP24XX_PRCM_IRQSTATUS_DSP			0x00f0	/* IVA mod */
+#define OMAP24XX_PRCM_IRQENABLE_DSP			0x00f4	/* IVA mod */
+#define OMAP24XX_PRCM_IRQSTATUS_IVA			0x00f8
+#define OMAP24XX_PRCM_IRQENABLE_IVA			0x00fc
+
+#endif
diff --git a/arch/arm/mach-omap2/prm2xxx_3xxx.c b/arch/arm/mach-omap2/p=
rm2xxx_3xxx.c
index 9529984..0d6cc54 100644
--- a/arch/arm/mach-omap2/prm2xxx_3xxx.c
+++ b/arch/arm/mach-omap2/prm2xxx_3xxx.c
@@ -15,82 +15,11 @@
 #include <linux/errno.h>
 #include <linux/err.h>
 #include <linux/io.h>
-#include <linux/irq.h>
=20
-#include <plat/prcm.h>
-
-#include "soc.h"
 #include "common.h"
-#include "vp.h"
=20
 #include "prm2xxx_3xxx.h"
-#include "cm2xxx_3xxx.h"
 #include "prm-regbits-24xx.h"
-#include "prm-regbits-34xx.h"
-
-static const struct omap_prcm_irq omap3_prcm_irqs[] =3D {
-	OMAP_PRCM_IRQ("wkup",	0,	0),
-	OMAP_PRCM_IRQ("io",	9,	1),
-};
-
-static struct omap_prcm_irq_setup omap3_prcm_irq_setup =3D {
-	.ack			=3D OMAP3_PRM_IRQSTATUS_MPU_OFFSET,
-	.mask			=3D OMAP3_PRM_IRQENABLE_MPU_OFFSET,
-	.nr_regs		=3D 1,
-	.irqs			=3D omap3_prcm_irqs,
-	.nr_irqs		=3D ARRAY_SIZE(omap3_prcm_irqs),
-	.irq			=3D 11 + OMAP_INTC_START,
-	.read_pending_irqs	=3D &omap3xxx_prm_read_pending_irqs,
-	.ocp_barrier		=3D &omap3xxx_prm_ocp_barrier,
-	.save_and_clear_irqen	=3D &omap3xxx_prm_save_and_clear_irqen,
-	.restore_irqen		=3D &omap3xxx_prm_restore_irqen,
-};
-
-u32 omap2_prm_read_mod_reg(s16 module, u16 idx)
-{
-	return __raw_readl(prm_base + module + idx);
-}
-
-void omap2_prm_write_mod_reg(u32 val, s16 module, u16 idx)
-{
-	__raw_writel(val, prm_base + module + idx);
-}
-
-/* Read-modify-write a register in a PRM module. Caller must lock */
-u32 omap2_prm_rmw_mod_reg_bits(u32 mask, u32 bits, s16 module, s16 idx=
)
-{
-	u32 v;
-
-	v =3D omap2_prm_read_mod_reg(module, idx);
-	v &=3D ~mask;
-	v |=3D bits;
-	omap2_prm_write_mod_reg(v, module, idx);
-
-	return v;
-}
-
-/* Read a PRM register, AND it, and shift the result down to bit 0 */
-u32 omap2_prm_read_mod_bits_shift(s16 domain, s16 idx, u32 mask)
-{
-	u32 v;
-
-	v =3D omap2_prm_read_mod_reg(domain, idx);
-	v &=3D mask;
-	v >>=3D __ffs(mask);
-
-	return v;
-}
-
-u32 omap2_prm_set_mod_reg_bits(u32 bits, s16 module, s16 idx)
-{
-	return omap2_prm_rmw_mod_reg_bits(bits, bits, module, idx);
-}
-
-u32 omap2_prm_clear_mod_reg_bits(u32 bits, s16 module, s16 idx)
-{
-	return omap2_prm_rmw_mod_reg_bits(bits, 0x0, module, idx);
-}
-
=20
 /**
  * omap2_prm_is_hardreset_asserted - read the HW reset line state of
@@ -104,9 +33,6 @@ u32 omap2_prm_clear_mod_reg_bits(u32 bits, s16 modul=
e, s16 idx)
  */
 int omap2_prm_is_hardreset_asserted(s16 prm_mod, u8 shift)
 {
-	if (!(cpu_is_omap24xx() || cpu_is_omap34xx()))
-		return -EINVAL;
-
 	return omap2_prm_read_mod_bits_shift(prm_mod, OMAP2_RM_RSTCTRL,
 				       (1 << shift));
 }
@@ -127,9 +53,6 @@ int omap2_prm_assert_hardreset(s16 prm_mod, u8 shift=
)
 {
 	u32 mask;
=20
-	if (!(cpu_is_omap24xx() || cpu_is_omap34xx()))
-		return -EINVAL;
-
 	mask =3D 1 << shift;
 	omap2_prm_rmw_mod_reg_bits(mask, mask, prm_mod, OMAP2_RM_RSTCTRL);
=20
@@ -156,9 +79,6 @@ int omap2_prm_deassert_hardreset(s16 prm_mod, u8 rst=
_shift, u8 st_shift)
 	u32 rst, st;
 	int c;
=20
-	if (!(cpu_is_omap24xx() || cpu_is_omap34xx()))
-		return -EINVAL;
-
 	rst =3D 1 << rst_shift;
 	st =3D 1 << st_shift;
=20
@@ -178,188 +98,3 @@ int omap2_prm_deassert_hardreset(s16 prm_mod, u8 r=
st_shift, u8 st_shift)
 	return (c =3D=3D MAX_MODULE_HARDRESET_WAIT) ? -EBUSY : 0;
 }
=20
-/* PRM VP */
-
-/*
- * struct omap3_vp - OMAP3 VP register access description.
- * @tranxdone_status: VP_TRANXDONE_ST bitmask in PRM_IRQSTATUS_MPU reg
- */
-struct omap3_vp {
-	u32 tranxdone_status;
-};
-
-static struct omap3_vp omap3_vp[] =3D {
-	[OMAP3_VP_VDD_MPU_ID] =3D {
-		.tranxdone_status =3D OMAP3430_VP1_TRANXDONE_ST_MASK,
-	},
-	[OMAP3_VP_VDD_CORE_ID] =3D {
-		.tranxdone_status =3D OMAP3430_VP2_TRANXDONE_ST_MASK,
-	},
-};
-
-#define MAX_VP_ID ARRAY_SIZE(omap3_vp);
-
-u32 omap3_prm_vp_check_txdone(u8 vp_id)
-{
-	struct omap3_vp *vp =3D &omap3_vp[vp_id];
-	u32 irqstatus;
-
-	irqstatus =3D omap2_prm_read_mod_reg(OCP_MOD,
-					   OMAP3_PRM_IRQSTATUS_MPU_OFFSET);
-	return irqstatus & vp->tranxdone_status;
-}
-
-void omap3_prm_vp_clear_txdone(u8 vp_id)
-{
-	struct omap3_vp *vp =3D &omap3_vp[vp_id];
-
-	omap2_prm_write_mod_reg(vp->tranxdone_status,
-				OCP_MOD, OMAP3_PRM_IRQSTATUS_MPU_OFFSET);
-}
-
-u32 omap3_prm_vcvp_read(u8 offset)
-{
-	return omap2_prm_read_mod_reg(OMAP3430_GR_MOD, offset);
-}
-
-void omap3_prm_vcvp_write(u32 val, u8 offset)
-{
-	omap2_prm_write_mod_reg(val, OMAP3430_GR_MOD, offset);
-}
-
-u32 omap3_prm_vcvp_rmw(u32 mask, u32 bits, u8 offset)
-{
-	return omap2_prm_rmw_mod_reg_bits(mask, bits, OMAP3430_GR_MOD, offset=
);
-}
-
-/**
- * omap3xxx_prm_read_pending_irqs - read pending PRM MPU IRQs into @ev=
ents
- * @events: ptr to a u32, preallocated by caller
- *
- * Read PRM_IRQSTATUS_MPU bits, AND'ed with the currently-enabled PRM
- * MPU IRQs, and store the result into the u32 pointed to by @events.
- * No return value.
- */
-void omap3xxx_prm_read_pending_irqs(unsigned long *events)
-{
-	u32 mask, st;
-
-	/* XXX Can the mask read be avoided (e.g., can it come from RAM?) */
-	mask =3D omap2_prm_read_mod_reg(OCP_MOD, OMAP3_PRM_IRQENABLE_MPU_OFFS=
ET);
-	st =3D omap2_prm_read_mod_reg(OCP_MOD, OMAP3_PRM_IRQSTATUS_MPU_OFFSET=
);
-
-	events[0] =3D mask & st;
-}
-
-/**
- * omap3xxx_prm_ocp_barrier - force buffered MPU writes to the PRM to =
complete
- *
- * Force any buffered writes to the PRM IP block to complete.  Needed
- * by the PRM IRQ handler, which reads and writes directly to the IP
- * block, to avoid race conditions after acknowledging or clearing IRQ
- * bits.  No return value.
- */
-void omap3xxx_prm_ocp_barrier(void)
-{
-	omap2_prm_read_mod_reg(OCP_MOD, OMAP3_PRM_REVISION_OFFSET);
-}
-
-/**
- * omap3xxx_prm_save_and_clear_irqen - save/clear PRM_IRQENABLE_MPU re=
g
- * @saved_mask: ptr to a u32 array to save IRQENABLE bits
- *
- * Save the PRM_IRQENABLE_MPU register to @saved_mask.  @saved_mask
- * must be allocated by the caller.  Intended to be used in the PRM
- * interrupt handler suspend callback.  The OCP barrier is needed to
- * ensure the write to disable PRM interrupts reaches the PRM before
- * returning; otherwise, spurious interrupts might occur.  No return
- * value.
- */
-void omap3xxx_prm_save_and_clear_irqen(u32 *saved_mask)
-{
-	saved_mask[0] =3D omap2_prm_read_mod_reg(OCP_MOD,
-					       OMAP3_PRM_IRQENABLE_MPU_OFFSET);
-	omap2_prm_write_mod_reg(0, OCP_MOD, OMAP3_PRM_IRQENABLE_MPU_OFFSET);
-
-	/* OCP barrier */
-	omap2_prm_read_mod_reg(OCP_MOD, OMAP3_PRM_REVISION_OFFSET);
-}
-
-/**
- * omap3xxx_prm_restore_irqen - set PRM_IRQENABLE_MPU register from ar=
gs
- * @saved_mask: ptr to a u32 array of IRQENABLE bits saved previously
- *
- * Restore the PRM_IRQENABLE_MPU register from @saved_mask.  Intended
- * to be used in the PRM interrupt handler resume callback to restore
- * values saved by omap3xxx_prm_save_and_clear_irqen().  No OCP
- * barrier should be needed here; any pending PRM interrupts will fire
- * once the writes reach the PRM.  No return value.
- */
-void omap3xxx_prm_restore_irqen(u32 *saved_mask)
-{
-	omap2_prm_write_mod_reg(saved_mask[0], OCP_MOD,
-				OMAP3_PRM_IRQENABLE_MPU_OFFSET);
-}
-
-/**
- * omap3xxx_prm_reconfigure_io_chain - clear latches and reconfigure I=
/O chain
- *
- * Clear any previously-latched I/O wakeup events and ensure that the
- * I/O wakeup gates are aligned with the current mux settings.  Works
- * by asserting WUCLKIN, waiting for WUCLKOUT to be asserted, and then
- * deasserting WUCLKIN and clearing the ST_IO_CHAIN WKST bit.  No
- * return value.
- */
-void omap3xxx_prm_reconfigure_io_chain(void)
-{
-	int i =3D 0;
-
-	omap2_prm_set_mod_reg_bits(OMAP3430_EN_IO_CHAIN_MASK, WKUP_MOD,
-				   PM_WKEN);
-
-	omap_test_timeout(omap2_prm_read_mod_reg(WKUP_MOD, PM_WKST) &
-			  OMAP3430_ST_IO_CHAIN_MASK,
-			  MAX_IOPAD_LATCH_TIME, i);
-	if (i =3D=3D MAX_IOPAD_LATCH_TIME)
-		pr_warn("PRM: I/O chain clock line assertion timed out\n");
-
-	omap2_prm_clear_mod_reg_bits(OMAP3430_EN_IO_CHAIN_MASK, WKUP_MOD,
-				     PM_WKEN);
-
-	omap2_prm_set_mod_reg_bits(OMAP3430_ST_IO_CHAIN_MASK, WKUP_MOD,
-				   PM_WKST);
-
-	omap2_prm_read_mod_reg(WKUP_MOD, PM_WKST);
-}
-
-/**
- * omap3xxx_prm_enable_io_wakeup - enable wakeup events from I/O wakeu=
p latches
- *
- * Activates the I/O wakeup event latches and allows events logged by
- * those latches to signal a wakeup event to the PRCM.  For I/O
- * wakeups to occur, WAKEUPENABLE bits must be set in the pad mux
- * registers, and omap3xxx_prm_reconfigure_io_chain() must be called.
- * No return value.
- */
-static void __init omap3xxx_prm_enable_io_wakeup(void)
-{
-	if (omap3_has_io_wakeup())
-		omap2_prm_set_mod_reg_bits(OMAP3430_EN_IO_MASK, WKUP_MOD,
-					   PM_WKEN);
-}
-
-static int __init omap3xxx_prcm_init(void)
-{
-	int ret =3D 0;
-
-	if (cpu_is_omap34xx()) {
-		omap3xxx_prm_enable_io_wakeup();
-		ret =3D omap_prcm_register_chain_handler(&omap3_prcm_irq_setup);
-		if (!ret)
-			irq_set_status_flags(omap_prcm_event_to_irq("io"),
-					     IRQ_NOAUTOEN);
-	}
-
-	return ret;
-}
-subsys_initcall(omap3xxx_prcm_init);
diff --git a/arch/arm/mach-omap2/prm2xxx_3xxx.h b/arch/arm/mach-omap2/p=
rm2xxx_3xxx.h
index c19d249..8d09a1a 100644
--- a/arch/arm/mach-omap2/prm2xxx_3xxx.h
+++ b/arch/arm/mach-omap2/prm2xxx_3xxx.h
@@ -1,7 +1,7 @@
 /*
- * OMAP2/3 Power/Reset Management (PRM) register definitions
+ * OMAP2xxx/3xxx-common Power/Reset Management (PRM) register definiti=
ons
  *
- * Copyright (C) 2007-2009, 2011 Texas Instruments, Inc.
+ * Copyright (C) 2007-2009, 2011-2012 Texas Instruments, Inc.
  * Copyright (C) 2008-2010 Nokia Corporation
  * Paul Walmsley
  *
@@ -19,160 +19,6 @@
 #include "prcm-common.h"
 #include "prm.h"
=20
-#define OMAP2420_PRM_REGADDR(module, reg)				\
-		OMAP2_L4_IO_ADDRESS(OMAP2420_PRM_BASE + (module) + (reg))
-#define OMAP2430_PRM_REGADDR(module, reg)				\
-		OMAP2_L4_IO_ADDRESS(OMAP2430_PRM_BASE + (module) + (reg))
-#define OMAP34XX_PRM_REGADDR(module, reg)				\
-		OMAP2_L4_IO_ADDRESS(OMAP3430_PRM_BASE + (module) + (reg))
-
-
-/*
- * OMAP2-specific global PRM registers
- * Use __raw_{read,write}l() with these registers.
- *
- * With a few exceptions, these are the register names beginning with
- * PRCM_* on 24xx.  (The exceptions are the IRQSTATUS and IRQENABLE
- * bits.)
- *
- */
-
-#define OMAP2_PRCM_REVISION_OFFSET	0x0000
-#define OMAP2420_PRCM_REVISION		OMAP2420_PRM_REGADDR(OCP_MOD, 0x0000)
-#define OMAP2_PRCM_SYSCONFIG_OFFSET	0x0010
-#define OMAP2420_PRCM_SYSCONFIG		OMAP2420_PRM_REGADDR(OCP_MOD, 0x0010)
-
-#define OMAP2_PRCM_IRQSTATUS_MPU_OFFSET	0x0018
-#define OMAP2420_PRCM_IRQSTATUS_MPU	OMAP2420_PRM_REGADDR(OCP_MOD, 0x00=
18)
-#define OMAP2_PRCM_IRQENABLE_MPU_OFFSET	0x001c
-#define OMAP2420_PRCM_IRQENABLE_MPU	OMAP2420_PRM_REGADDR(OCP_MOD, 0x00=
1c)
-
-#define OMAP2_PRCM_VOLTCTRL_OFFSET	0x0050
-#define OMAP2420_PRCM_VOLTCTRL		OMAP2420_PRM_REGADDR(OCP_MOD, 0x0050)
-#define OMAP2_PRCM_VOLTST_OFFSET	0x0054
-#define OMAP2420_PRCM_VOLTST		OMAP2420_PRM_REGADDR(OCP_MOD, 0x0054)
-#define OMAP2_PRCM_CLKSRC_CTRL_OFFSET	0x0060
-#define OMAP2420_PRCM_CLKSRC_CTRL	OMAP2420_PRM_REGADDR(OCP_MOD, 0x0060=
)
-#define OMAP2_PRCM_CLKOUT_CTRL_OFFSET	0x0070
-#define OMAP2420_PRCM_CLKOUT_CTRL	OMAP2420_PRM_REGADDR(OCP_MOD, 0x0070=
)
-#define OMAP2_PRCM_CLKEMUL_CTRL_OFFSET	0x0078
-#define OMAP2420_PRCM_CLKEMUL_CTRL	OMAP2420_PRM_REGADDR(OCP_MOD, 0x007=
8)
-#define OMAP2_PRCM_CLKCFG_CTRL_OFFSET	0x0080
-#define OMAP2420_PRCM_CLKCFG_CTRL	OMAP2420_PRM_REGADDR(OCP_MOD, 0x0080=
)
-#define OMAP2_PRCM_CLKCFG_STATUS_OFFSET	0x0084
-#define OMAP2420_PRCM_CLKCFG_STATUS	OMAP2420_PRM_REGADDR(OCP_MOD, 0x00=
84)
-#define OMAP2_PRCM_VOLTSETUP_OFFSET	0x0090
-#define OMAP2420_PRCM_VOLTSETUP		OMAP2420_PRM_REGADDR(OCP_MOD, 0x0090)
-#define OMAP2_PRCM_CLKSSETUP_OFFSET	0x0094
-#define OMAP2420_PRCM_CLKSSETUP		OMAP2420_PRM_REGADDR(OCP_MOD, 0x0094)
-#define OMAP2_PRCM_POLCTRL_OFFSET	0x0098
-#define OMAP2420_PRCM_POLCTRL		OMAP2420_PRM_REGADDR(OCP_MOD, 0x0098)
-
-#define OMAP2430_PRCM_REVISION		OMAP2430_PRM_REGADDR(OCP_MOD, 0x0000)
-#define OMAP2430_PRCM_SYSCONFIG		OMAP2430_PRM_REGADDR(OCP_MOD, 0x0010)
-
-#define OMAP2430_PRCM_IRQSTATUS_MPU	OMAP2430_PRM_REGADDR(OCP_MOD, 0x00=
18)
-#define OMAP2430_PRCM_IRQENABLE_MPU	OMAP2430_PRM_REGADDR(OCP_MOD, 0x00=
1c)
-
-#define OMAP2430_PRCM_VOLTCTRL		OMAP2430_PRM_REGADDR(OCP_MOD, 0x0050)
-#define OMAP2430_PRCM_VOLTST		OMAP2430_PRM_REGADDR(OCP_MOD, 0x0054)
-#define OMAP2430_PRCM_CLKSRC_CTRL	OMAP2430_PRM_REGADDR(OCP_MOD, 0x0060=
)
-#define OMAP2430_PRCM_CLKOUT_CTRL	OMAP2430_PRM_REGADDR(OCP_MOD, 0x0070=
)
-#define OMAP2430_PRCM_CLKEMUL_CTRL	OMAP2430_PRM_REGADDR(OCP_MOD, 0x007=
8)
-#define OMAP2430_PRCM_CLKCFG_CTRL	OMAP2430_PRM_REGADDR(OCP_MOD, 0x0080=
)
-#define OMAP2430_PRCM_CLKCFG_STATUS	OMAP2430_PRM_REGADDR(OCP_MOD, 0x00=
84)
-#define OMAP2430_PRCM_VOLTSETUP		OMAP2430_PRM_REGADDR(OCP_MOD, 0x0090)
-#define OMAP2430_PRCM_CLKSSETUP		OMAP2430_PRM_REGADDR(OCP_MOD, 0x0094)
-#define OMAP2430_PRCM_POLCTRL		OMAP2430_PRM_REGADDR(OCP_MOD, 0x0098)
-
-/*
- * OMAP3-specific global PRM registers
- * Use __raw_{read,write}l() with these registers.
- *
- * With a few exceptions, these are the register names beginning with
- * PRM_* on 34xx.  (The exceptions are the IRQSTATUS and IRQENABLE
- * bits.)
- */
-
-#define OMAP3_PRM_REVISION_OFFSET	0x0004
-#define OMAP3430_PRM_REVISION		OMAP34XX_PRM_REGADDR(OCP_MOD, 0x0004)
-#define OMAP3_PRM_SYSCONFIG_OFFSET	0x0014
-#define OMAP3430_PRM_SYSCONFIG		OMAP34XX_PRM_REGADDR(OCP_MOD, 0x0014)
-
-#define OMAP3_PRM_IRQSTATUS_MPU_OFFSET	0x0018
-#define OMAP3430_PRM_IRQSTATUS_MPU	OMAP34XX_PRM_REGADDR(OCP_MOD, 0x001=
8)
-#define OMAP3_PRM_IRQENABLE_MPU_OFFSET	0x001c
-#define OMAP3430_PRM_IRQENABLE_MPU	OMAP34XX_PRM_REGADDR(OCP_MOD, 0x001=
c)
-
-
-#define OMAP3_PRM_VC_SMPS_SA_OFFSET	0x0020
-#define OMAP3430_PRM_VC_SMPS_SA		OMAP34XX_PRM_REGADDR(OMAP3430_GR_MOD,=
 0x0020)
-#define OMAP3_PRM_VC_SMPS_VOL_RA_OFFSET	0x0024
-#define OMAP3430_PRM_VC_SMPS_VOL_RA	OMAP34XX_PRM_REGADDR(OMAP3430_GR_M=
OD, 0x0024)
-#define OMAP3_PRM_VC_SMPS_CMD_RA_OFFSET	0x0028
-#define OMAP3430_PRM_VC_SMPS_CMD_RA	OMAP34XX_PRM_REGADDR(OMAP3430_GR_M=
OD, 0x0028)
-#define OMAP3_PRM_VC_CMD_VAL_0_OFFSET	0x002c
-#define OMAP3430_PRM_VC_CMD_VAL_0	OMAP34XX_PRM_REGADDR(OMAP3430_GR_MOD=
, 0x002c)
-#define OMAP3_PRM_VC_CMD_VAL_1_OFFSET	0x0030
-#define OMAP3430_PRM_VC_CMD_VAL_1	OMAP34XX_PRM_REGADDR(OMAP3430_GR_MOD=
, 0x0030)
-#define OMAP3_PRM_VC_CH_CONF_OFFSET	0x0034
-#define OMAP3430_PRM_VC_CH_CONF		OMAP34XX_PRM_REGADDR(OMAP3430_GR_MOD,=
 0x0034)
-#define OMAP3_PRM_VC_I2C_CFG_OFFSET	0x0038
-#define OMAP3430_PRM_VC_I2C_CFG		OMAP34XX_PRM_REGADDR(OMAP3430_GR_MOD,=
 0x0038)
-#define OMAP3_PRM_VC_BYPASS_VAL_OFFSET	0x003c
-#define OMAP3430_PRM_VC_BYPASS_VAL	OMAP34XX_PRM_REGADDR(OMAP3430_GR_MO=
D, 0x003c)
-#define OMAP3_PRM_RSTCTRL_OFFSET	0x0050
-#define OMAP3430_PRM_RSTCTRL		OMAP34XX_PRM_REGADDR(OMAP3430_GR_MOD, 0x=
0050)
-#define OMAP3_PRM_RSTTIME_OFFSET	0x0054
-#define OMAP3430_PRM_RSTTIME		OMAP34XX_PRM_REGADDR(OMAP3430_GR_MOD, 0x=
0054)
-#define OMAP3_PRM_RSTST_OFFSET	0x0058
-#define OMAP3430_PRM_RSTST		OMAP34XX_PRM_REGADDR(OMAP3430_GR_MOD, 0x00=
58)
-#define OMAP3_PRM_VOLTCTRL_OFFSET	0x0060
-#define OMAP3430_PRM_VOLTCTRL		OMAP34XX_PRM_REGADDR(OMAP3430_GR_MOD, 0=
x0060)
-#define OMAP3_PRM_SRAM_PCHARGE_OFFSET	0x0064
-#define OMAP3430_PRM_SRAM_PCHARGE	OMAP34XX_PRM_REGADDR(OMAP3430_GR_MOD=
, 0x0064)
-#define OMAP3_PRM_CLKSRC_CTRL_OFFSET	0x0070
-#define OMAP3430_PRM_CLKSRC_CTRL	OMAP34XX_PRM_REGADDR(OMAP3430_GR_MOD,=
 0x0070)
-#define OMAP3_PRM_VOLTSETUP1_OFFSET	0x0090
-#define OMAP3430_PRM_VOLTSETUP1		OMAP34XX_PRM_REGADDR(OMAP3430_GR_MOD,=
 0x0090)
-#define OMAP3_PRM_VOLTOFFSET_OFFSET	0x0094
-#define OMAP3430_PRM_VOLTOFFSET		OMAP34XX_PRM_REGADDR(OMAP3430_GR_MOD,=
 0x0094)
-#define OMAP3_PRM_CLKSETUP_OFFSET	0x0098
-#define OMAP3430_PRM_CLKSETUP		OMAP34XX_PRM_REGADDR(OMAP3430_GR_MOD, 0=
x0098)
-#define OMAP3_PRM_POLCTRL_OFFSET	0x009c
-#define OMAP3430_PRM_POLCTRL		OMAP34XX_PRM_REGADDR(OMAP3430_GR_MOD, 0x=
009c)
-#define OMAP3_PRM_VOLTSETUP2_OFFSET	0x00a0
-#define OMAP3430_PRM_VOLTSETUP2		OMAP34XX_PRM_REGADDR(OMAP3430_GR_MOD,=
 0x00a0)
-#define OMAP3_PRM_VP1_CONFIG_OFFSET	0x00b0
-#define OMAP3430_PRM_VP1_CONFIG		OMAP34XX_PRM_REGADDR(OMAP3430_GR_MOD,=
 0x00b0)
-#define OMAP3_PRM_VP1_VSTEPMIN_OFFSET	0x00b4
-#define OMAP3430_PRM_VP1_VSTEPMIN	OMAP34XX_PRM_REGADDR(OMAP3430_GR_MOD=
, 0x00b4)
-#define OMAP3_PRM_VP1_VSTEPMAX_OFFSET	0x00b8
-#define OMAP3430_PRM_VP1_VSTEPMAX	OMAP34XX_PRM_REGADDR(OMAP3430_GR_MOD=
, 0x00b8)
-#define OMAP3_PRM_VP1_VLIMITTO_OFFSET	0x00bc
-#define OMAP3430_PRM_VP1_VLIMITTO	OMAP34XX_PRM_REGADDR(OMAP3430_GR_MOD=
, 0x00bc)
-#define OMAP3_PRM_VP1_VOLTAGE_OFFSET	0x00c0
-#define OMAP3430_PRM_VP1_VOLTAGE	OMAP34XX_PRM_REGADDR(OMAP3430_GR_MOD,=
 0x00c0)
-#define OMAP3_PRM_VP1_STATUS_OFFSET	0x00c4
-#define OMAP3430_PRM_VP1_STATUS		OMAP34XX_PRM_REGADDR(OMAP3430_GR_MOD,=
 0x00c4)
-#define OMAP3_PRM_VP2_CONFIG_OFFSET	0x00d0
-#define OMAP3430_PRM_VP2_CONFIG		OMAP34XX_PRM_REGADDR(OMAP3430_GR_MOD,=
 0x00d0)
-#define OMAP3_PRM_VP2_VSTEPMIN_OFFSET	0x00d4
-#define OMAP3430_PRM_VP2_VSTEPMIN	OMAP34XX_PRM_REGADDR(OMAP3430_GR_MOD=
, 0x00d4)
-#define OMAP3_PRM_VP2_VSTEPMAX_OFFSET	0x00d8
-#define OMAP3430_PRM_VP2_VSTEPMAX	OMAP34XX_PRM_REGADDR(OMAP3430_GR_MOD=
, 0x00d8)
-#define OMAP3_PRM_VP2_VLIMITTO_OFFSET	0x00dc
-#define OMAP3430_PRM_VP2_VLIMITTO	OMAP34XX_PRM_REGADDR(OMAP3430_GR_MOD=
, 0x00dc)
-#define OMAP3_PRM_VP2_VOLTAGE_OFFSET	0x00e0
-#define OMAP3430_PRM_VP2_VOLTAGE	OMAP34XX_PRM_REGADDR(OMAP3430_GR_MOD,=
 0x00e0)
-#define OMAP3_PRM_VP2_STATUS_OFFSET	0x00e4
-#define OMAP3430_PRM_VP2_STATUS		OMAP34XX_PRM_REGADDR(OMAP3430_GR_MOD,=
 0x00e4)
-
-#define OMAP3_PRM_CLKSEL_OFFSET	0x0040
-#define OMAP3430_PRM_CLKSEL		OMAP34XX_PRM_REGADDR(OMAP3430_CCR_MOD, 0x=
0040)
-#define OMAP3_PRM_CLKOUT_CTRL_OFFSET	0x0070
-#define OMAP3430_PRM_CLKOUT_CTRL	OMAP34XX_PRM_REGADDR(OMAP3430_CCR_MOD=
, 0x0070)
-
 /*
  * Module specific PRM register offsets from PRM_BASE + domain offset
  *
@@ -200,67 +46,63 @@
 #define PM_EVGENONTIM					0x00d8
 #define PM_EVGENOFFTIM					0x00dc
=20
-/* OMAP2xxx specific register offsets */
-#define OMAP24XX_PM_WKEN2				0x00a4
-#define OMAP24XX_PM_WKST2				0x00b4
-
-#define OMAP24XX_PRCM_IRQSTATUS_DSP			0x00f0	/* IVA mod */
-#define OMAP24XX_PRCM_IRQENABLE_DSP			0x00f4	/* IVA mod */
-#define OMAP24XX_PRCM_IRQSTATUS_IVA			0x00f8
-#define OMAP24XX_PRCM_IRQENABLE_IVA			0x00fc
-
-/* OMAP3 specific register offsets */
-#define OMAP3430ES2_PM_WKEN3				0x00f0
-#define OMAP3430ES2_PM_WKST3				0x00b8
-
-#define OMAP3430_PM_MPUGRPSEL				0x00a4
-#define OMAP3430_PM_MPUGRPSEL1				OMAP3430_PM_MPUGRPSEL
-#define OMAP3430ES2_PM_MPUGRPSEL3			0x00f8
=20
-#define OMAP3430_PM_IVAGRPSEL				0x00a8
-#define OMAP3430_PM_IVAGRPSEL1				OMAP3430_PM_IVAGRPSEL
-#define OMAP3430ES2_PM_IVAGRPSEL3			0x00f4
-
-#define OMAP3430_PM_PREPWSTST				0x00e8
-
-#define OMAP3430_PRM_IRQSTATUS_IVA2			0x00f8
-#define OMAP3430_PRM_IRQENABLE_IVA2			0x00fc
+#ifndef __ASSEMBLER__
=20
+#include <linux/io.h>
=20
-#ifndef __ASSEMBLER__
 /* Power/reset management domain register get/set */
-extern u32 omap2_prm_read_mod_reg(s16 module, u16 idx);
-extern void omap2_prm_write_mod_reg(u32 val, s16 module, u16 idx);
-extern u32 omap2_prm_rmw_mod_reg_bits(u32 mask, u32 bits, s16 module, =
s16 idx);
-extern u32 omap2_prm_set_mod_reg_bits(u32 bits, s16 module, s16 idx);
-extern u32 omap2_prm_clear_mod_reg_bits(u32 bits, s16 module, s16 idx)=
;
-extern u32 omap2_prm_read_mod_bits_shift(s16 domain, s16 idx, u32 mask=
);
+static inline u32 omap2_prm_read_mod_reg(s16 module, u16 idx)
+{
+	return __raw_readl(prm_base + module + idx);
+}
+
+static inline void omap2_prm_write_mod_reg(u32 val, s16 module, u16 id=
x)
+{
+	__raw_writel(val, prm_base + module + idx);
+}
+
+/* Read-modify-write a register in a PRM module. Caller must lock */
+static inline u32 omap2_prm_rmw_mod_reg_bits(u32 mask, u32 bits, s16 m=
odule,
+					     s16 idx)
+{
+	u32 v;
+
+	v =3D omap2_prm_read_mod_reg(module, idx);
+	v &=3D ~mask;
+	v |=3D bits;
+	omap2_prm_write_mod_reg(v, module, idx);
+
+	return v;
+}
+
+/* Read a PRM register, AND it, and shift the result down to bit 0 */
+static inline u32 omap2_prm_read_mod_bits_shift(s16 domain, s16 idx, u=
32 mask)
+{
+	u32 v;
+
+	v =3D omap2_prm_read_mod_reg(domain, idx);
+	v &=3D mask;
+	v >>=3D __ffs(mask);
+
+	return v;
+}
+
+static inline u32 omap2_prm_set_mod_reg_bits(u32 bits, s16 module, s16=
 idx)
+{
+	return omap2_prm_rmw_mod_reg_bits(bits, bits, module, idx);
+}
+
+static inline u32 omap2_prm_clear_mod_reg_bits(u32 bits, s16 module, s=
16 idx)
+{
+	return omap2_prm_rmw_mod_reg_bits(bits, 0x0, module, idx);
+}
=20
 /* These omap2_ PRM functions apply to both OMAP2 and 3 */
 extern int omap2_prm_is_hardreset_asserted(s16 prm_mod, u8 shift);
 extern int omap2_prm_assert_hardreset(s16 prm_mod, u8 shift);
 extern int omap2_prm_deassert_hardreset(s16 prm_mod, u8 rst_shift, u8 =
st_shift);
=20
-/* OMAP3-specific VP functions */
-u32 omap3_prm_vp_check_txdone(u8 vp_id);
-void omap3_prm_vp_clear_txdone(u8 vp_id);
-
-/*
- * OMAP3 access functions for voltage controller (VC) and
- * voltage proccessor (VP) in the PRM.
- */
-extern u32 omap3_prm_vcvp_read(u8 offset);
-extern void omap3_prm_vcvp_write(u32 val, u8 offset);
-extern u32 omap3_prm_vcvp_rmw(u32 mask, u32 bits, u8 offset);
-
-extern void omap3xxx_prm_reconfigure_io_chain(void);
-
-/* PRM interrupt-related functions */
-extern void omap3xxx_prm_read_pending_irqs(unsigned long *events);
-extern void omap3xxx_prm_ocp_barrier(void);
-extern void omap3xxx_prm_save_and_clear_irqen(u32 *saved_mask);
-extern void omap3xxx_prm_restore_irqen(u32 *saved_mask);
-
 #endif /* __ASSEMBLER */
=20
 /*
diff --git a/arch/arm/mach-omap2/prm2xxx_3xxx.c b/arch/arm/mach-omap2/p=
rm3xxx.c
similarity index 57%
copy from arch/arm/mach-omap2/prm2xxx_3xxx.c
copy to arch/arm/mach-omap2/prm3xxx.c
index 9529984..88f7d8d 100644
--- a/arch/arm/mach-omap2/prm2xxx_3xxx.c
+++ b/arch/arm/mach-omap2/prm3xxx.c
@@ -1,7 +1,7 @@
 /*
- * OMAP2/3 PRM module functions
+ * OMAP3xxx PRM module functions
  *
- * Copyright (C) 2010-2011 Texas Instruments, Inc.
+ * Copyright (C) 2010-2012 Texas Instruments, Inc.
  * Copyright (C) 2010 Nokia Corporation
  * Beno=C3=AEt Cousson
  * Paul Walmsley
@@ -17,15 +17,14 @@
 #include <linux/io.h>
 #include <linux/irq.h>
=20
+#include "common.h"
+#include <plat/cpu.h>
 #include <plat/prcm.h>
=20
-#include "soc.h"
-#include "common.h"
 #include "vp.h"
=20
-#include "prm2xxx_3xxx.h"
+#include "prm3xxx.h"
 #include "cm2xxx_3xxx.h"
-#include "prm-regbits-24xx.h"
 #include "prm-regbits-34xx.h"
=20
 static const struct omap_prcm_irq omap3_prcm_irqs[] =3D {
@@ -46,138 +45,6 @@ static struct omap_prcm_irq_setup omap3_prcm_irq_se=
tup =3D {
 	.restore_irqen		=3D &omap3xxx_prm_restore_irqen,
 };
=20
-u32 omap2_prm_read_mod_reg(s16 module, u16 idx)
-{
-	return __raw_readl(prm_base + module + idx);
-}
-
-void omap2_prm_write_mod_reg(u32 val, s16 module, u16 idx)
-{
-	__raw_writel(val, prm_base + module + idx);
-}
-
-/* Read-modify-write a register in a PRM module. Caller must lock */
-u32 omap2_prm_rmw_mod_reg_bits(u32 mask, u32 bits, s16 module, s16 idx=
)
-{
-	u32 v;
-
-	v =3D omap2_prm_read_mod_reg(module, idx);
-	v &=3D ~mask;
-	v |=3D bits;
-	omap2_prm_write_mod_reg(v, module, idx);
-
-	return v;
-}
-
-/* Read a PRM register, AND it, and shift the result down to bit 0 */
-u32 omap2_prm_read_mod_bits_shift(s16 domain, s16 idx, u32 mask)
-{
-	u32 v;
-
-	v =3D omap2_prm_read_mod_reg(domain, idx);
-	v &=3D mask;
-	v >>=3D __ffs(mask);
-
-	return v;
-}
-
-u32 omap2_prm_set_mod_reg_bits(u32 bits, s16 module, s16 idx)
-{
-	return omap2_prm_rmw_mod_reg_bits(bits, bits, module, idx);
-}
-
-u32 omap2_prm_clear_mod_reg_bits(u32 bits, s16 module, s16 idx)
-{
-	return omap2_prm_rmw_mod_reg_bits(bits, 0x0, module, idx);
-}
-
-
-/**
- * omap2_prm_is_hardreset_asserted - read the HW reset line state of
- * submodules contained in the hwmod module
- * @prm_mod: PRM submodule base (e.g. CORE_MOD)
- * @shift: register bit shift corresponding to the reset line to check
- *
- * Returns 1 if the (sub)module hardreset line is currently asserted,
- * 0 if the (sub)module hardreset line is not currently asserted, or
- * -EINVAL if called while running on a non-OMAP2/3 chip.
- */
-int omap2_prm_is_hardreset_asserted(s16 prm_mod, u8 shift)
-{
-	if (!(cpu_is_omap24xx() || cpu_is_omap34xx()))
-		return -EINVAL;
-
-	return omap2_prm_read_mod_bits_shift(prm_mod, OMAP2_RM_RSTCTRL,
-				       (1 << shift));
-}
-
-/**
- * omap2_prm_assert_hardreset - assert the HW reset line of a submodul=
e
- * @prm_mod: PRM submodule base (e.g. CORE_MOD)
- * @shift: register bit shift corresponding to the reset line to asser=
t
- *
- * Some IPs like dsp or iva contain processors that require an HW
- * reset line to be asserted / deasserted in order to fully enable the
- * IP.  These modules may have multiple hard-reset lines that reset
- * different 'submodules' inside the IP block.  This function will
- * place the submodule into reset.  Returns 0 upon success or -EINVAL
- * upon an argument error.
- */
-int omap2_prm_assert_hardreset(s16 prm_mod, u8 shift)
-{
-	u32 mask;
-
-	if (!(cpu_is_omap24xx() || cpu_is_omap34xx()))
-		return -EINVAL;
-
-	mask =3D 1 << shift;
-	omap2_prm_rmw_mod_reg_bits(mask, mask, prm_mod, OMAP2_RM_RSTCTRL);
-
-	return 0;
-}
-
-/**
- * omap2_prm_deassert_hardreset - deassert a submodule hardreset line =
and wait
- * @prm_mod: PRM submodule base (e.g. CORE_MOD)
- * @rst_shift: register bit shift corresponding to the reset line to d=
eassert
- * @st_shift: register bit shift for the status of the deasserted subm=
odule
- *
- * Some IPs like dsp or iva contain processors that require an HW
- * reset line to be asserted / deasserted in order to fully enable the
- * IP.  These modules may have multiple hard-reset lines that reset
- * different 'submodules' inside the IP block.  This function will
- * take the submodule out of reset and wait until the PRCM indicates
- * that the reset has completed before returning.  Returns 0 upon succ=
ess or
- * -EINVAL upon an argument error, -EEXIST if the submodule was alread=
y out
- * of reset, or -EBUSY if the submodule did not exit reset promptly.
- */
-int omap2_prm_deassert_hardreset(s16 prm_mod, u8 rst_shift, u8 st_shif=
t)
-{
-	u32 rst, st;
-	int c;
-
-	if (!(cpu_is_omap24xx() || cpu_is_omap34xx()))
-		return -EINVAL;
-
-	rst =3D 1 << rst_shift;
-	st =3D 1 << st_shift;
-
-	/* Check the current status to avoid de-asserting the line twice */
-	if (omap2_prm_read_mod_bits_shift(prm_mod, OMAP2_RM_RSTCTRL, rst) =3D=
=3D 0)
-		return -EEXIST;
-
-	/* Clear the reset status by writing 1 to the status bit */
-	omap2_prm_rmw_mod_reg_bits(0xffffffff, st, prm_mod, OMAP2_RM_RSTST);
-	/* de-assert the reset control line */
-	omap2_prm_rmw_mod_reg_bits(rst, 0, prm_mod, OMAP2_RM_RSTCTRL);
-	/* wait the status to be set */
-	omap_test_timeout(omap2_prm_read_mod_bits_shift(prm_mod, OMAP2_RM_RST=
ST,
-						  st),
-			  MAX_MODULE_HARDRESET_WAIT, c);
-
-	return (c =3D=3D MAX_MODULE_HARDRESET_WAIT) ? -EBUSY : 0;
-}
-
 /* PRM VP */
=20
 /*
@@ -348,18 +215,19 @@ static void __init omap3xxx_prm_enable_io_wakeup(=
void)
 					   PM_WKEN);
 }
=20
-static int __init omap3xxx_prcm_init(void)
+static int __init omap3xxx_prm_init(void)
 {
-	int ret =3D 0;
+	int ret;
+
+	if (!cpu_is_omap34xx())
+		return 0;
=20
-	if (cpu_is_omap34xx()) {
-		omap3xxx_prm_enable_io_wakeup();
-		ret =3D omap_prcm_register_chain_handler(&omap3_prcm_irq_setup);
-		if (!ret)
-			irq_set_status_flags(omap_prcm_event_to_irq("io"),
-					     IRQ_NOAUTOEN);
-	}
+	omap3xxx_prm_enable_io_wakeup();
+	ret =3D omap_prcm_register_chain_handler(&omap3_prcm_irq_setup);
+	if (!ret)
+		irq_set_status_flags(omap_prcm_event_to_irq("io"),
+				     IRQ_NOAUTOEN);
=20
 	return ret;
 }
-subsys_initcall(omap3xxx_prcm_init);
+subsys_initcall(omap3xxx_prm_init);
diff --git a/arch/arm/mach-omap2/prm3xxx.h b/arch/arm/mach-omap2/prm3xx=
x.h
new file mode 100644
index 0000000..6821e83
--- /dev/null
+++ b/arch/arm/mach-omap2/prm3xxx.h
@@ -0,0 +1,158 @@
+/*
+ * OMAP3xxx Power/Reset Management (PRM) register definitions
+ *
+ * Copyright (C) 2007-2009, 2011-2012 Texas Instruments, Inc.
+ * Copyright (C) 2008-2010 Nokia Corporation
+ * Paul Walmsley
+ *
+ * This program is free software; you can redistribute it and/or modif=
y
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * The PRM hardware modules on the OMAP2/3 are quite similar to each
+ * other.  The PRM on OMAP4 has a new register layout, and is handled
+ * in a separate file.
+ */
+#ifndef __ARCH_ARM_MACH_OMAP2_PRM3XXX_H
+#define __ARCH_ARM_MACH_OMAP2_PRM3XXX_H
+
+#include "prcm-common.h"
+#include "prm.h"
+#include "prm2xxx_3xxx.h"
+
+#define OMAP34XX_PRM_REGADDR(module, reg)				\
+		OMAP2_L4_IO_ADDRESS(OMAP3430_PRM_BASE + (module) + (reg))
+
+
+/*
+ * OMAP3-specific global PRM registers
+ * Use __raw_{read,write}l() with these registers.
+ *
+ * With a few exceptions, these are the register names beginning with
+ * PRM_* on 34xx.  (The exceptions are the IRQSTATUS and IRQENABLE
+ * bits.)
+ */
+
+#define OMAP3_PRM_REVISION_OFFSET	0x0004
+#define OMAP3430_PRM_REVISION		OMAP34XX_PRM_REGADDR(OCP_MOD, 0x0004)
+#define OMAP3_PRM_SYSCONFIG_OFFSET	0x0014
+#define OMAP3430_PRM_SYSCONFIG		OMAP34XX_PRM_REGADDR(OCP_MOD, 0x0014)
+
+#define OMAP3_PRM_IRQSTATUS_MPU_OFFSET	0x0018
+#define OMAP3430_PRM_IRQSTATUS_MPU	OMAP34XX_PRM_REGADDR(OCP_MOD, 0x001=
8)
+#define OMAP3_PRM_IRQENABLE_MPU_OFFSET	0x001c
+#define OMAP3430_PRM_IRQENABLE_MPU	OMAP34XX_PRM_REGADDR(OCP_MOD, 0x001=
c)
+
+
+#define OMAP3_PRM_VC_SMPS_SA_OFFSET	0x0020
+#define OMAP3430_PRM_VC_SMPS_SA		OMAP34XX_PRM_REGADDR(OMAP3430_GR_MOD,=
 0x0020)
+#define OMAP3_PRM_VC_SMPS_VOL_RA_OFFSET	0x0024
+#define OMAP3430_PRM_VC_SMPS_VOL_RA	OMAP34XX_PRM_REGADDR(OMAP3430_GR_M=
OD, 0x0024)
+#define OMAP3_PRM_VC_SMPS_CMD_RA_OFFSET	0x0028
+#define OMAP3430_PRM_VC_SMPS_CMD_RA	OMAP34XX_PRM_REGADDR(OMAP3430_GR_M=
OD, 0x0028)
+#define OMAP3_PRM_VC_CMD_VAL_0_OFFSET	0x002c
+#define OMAP3430_PRM_VC_CMD_VAL_0	OMAP34XX_PRM_REGADDR(OMAP3430_GR_MOD=
, 0x002c)
+#define OMAP3_PRM_VC_CMD_VAL_1_OFFSET	0x0030
+#define OMAP3430_PRM_VC_CMD_VAL_1	OMAP34XX_PRM_REGADDR(OMAP3430_GR_MOD=
, 0x0030)
+#define OMAP3_PRM_VC_CH_CONF_OFFSET	0x0034
+#define OMAP3430_PRM_VC_CH_CONF		OMAP34XX_PRM_REGADDR(OMAP3430_GR_MOD,=
 0x0034)
+#define OMAP3_PRM_VC_I2C_CFG_OFFSET	0x0038
+#define OMAP3430_PRM_VC_I2C_CFG		OMAP34XX_PRM_REGADDR(OMAP3430_GR_MOD,=
 0x0038)
+#define OMAP3_PRM_VC_BYPASS_VAL_OFFSET	0x003c
+#define OMAP3430_PRM_VC_BYPASS_VAL	OMAP34XX_PRM_REGADDR(OMAP3430_GR_MO=
D, 0x003c)
+#define OMAP3_PRM_RSTCTRL_OFFSET	0x0050
+#define OMAP3430_PRM_RSTCTRL		OMAP34XX_PRM_REGADDR(OMAP3430_GR_MOD, 0x=
0050)
+#define OMAP3_PRM_RSTTIME_OFFSET	0x0054
+#define OMAP3430_PRM_RSTTIME		OMAP34XX_PRM_REGADDR(OMAP3430_GR_MOD, 0x=
0054)
+#define OMAP3_PRM_RSTST_OFFSET	0x0058
+#define OMAP3430_PRM_RSTST		OMAP34XX_PRM_REGADDR(OMAP3430_GR_MOD, 0x00=
58)
+#define OMAP3_PRM_VOLTCTRL_OFFSET	0x0060
+#define OMAP3430_PRM_VOLTCTRL		OMAP34XX_PRM_REGADDR(OMAP3430_GR_MOD, 0=
x0060)
+#define OMAP3_PRM_SRAM_PCHARGE_OFFSET	0x0064
+#define OMAP3430_PRM_SRAM_PCHARGE	OMAP34XX_PRM_REGADDR(OMAP3430_GR_MOD=
, 0x0064)
+#define OMAP3_PRM_CLKSRC_CTRL_OFFSET	0x0070
+#define OMAP3430_PRM_CLKSRC_CTRL	OMAP34XX_PRM_REGADDR(OMAP3430_GR_MOD,=
 0x0070)
+#define OMAP3_PRM_VOLTSETUP1_OFFSET	0x0090
+#define OMAP3430_PRM_VOLTSETUP1		OMAP34XX_PRM_REGADDR(OMAP3430_GR_MOD,=
 0x0090)
+#define OMAP3_PRM_VOLTOFFSET_OFFSET	0x0094
+#define OMAP3430_PRM_VOLTOFFSET		OMAP34XX_PRM_REGADDR(OMAP3430_GR_MOD,=
 0x0094)
+#define OMAP3_PRM_CLKSETUP_OFFSET	0x0098
+#define OMAP3430_PRM_CLKSETUP		OMAP34XX_PRM_REGADDR(OMAP3430_GR_MOD, 0=
x0098)
+#define OMAP3_PRM_POLCTRL_OFFSET	0x009c
+#define OMAP3430_PRM_POLCTRL		OMAP34XX_PRM_REGADDR(OMAP3430_GR_MOD, 0x=
009c)
+#define OMAP3_PRM_VOLTSETUP2_OFFSET	0x00a0
+#define OMAP3430_PRM_VOLTSETUP2		OMAP34XX_PRM_REGADDR(OMAP3430_GR_MOD,=
 0x00a0)
+#define OMAP3_PRM_VP1_CONFIG_OFFSET	0x00b0
+#define OMAP3430_PRM_VP1_CONFIG		OMAP34XX_PRM_REGADDR(OMAP3430_GR_MOD,=
 0x00b0)
+#define OMAP3_PRM_VP1_VSTEPMIN_OFFSET	0x00b4
+#define OMAP3430_PRM_VP1_VSTEPMIN	OMAP34XX_PRM_REGADDR(OMAP3430_GR_MOD=
, 0x00b4)
+#define OMAP3_PRM_VP1_VSTEPMAX_OFFSET	0x00b8
+#define OMAP3430_PRM_VP1_VSTEPMAX	OMAP34XX_PRM_REGADDR(OMAP3430_GR_MOD=
, 0x00b8)
+#define OMAP3_PRM_VP1_VLIMITTO_OFFSET	0x00bc
+#define OMAP3430_PRM_VP1_VLIMITTO	OMAP34XX_PRM_REGADDR(OMAP3430_GR_MOD=
, 0x00bc)
+#define OMAP3_PRM_VP1_VOLTAGE_OFFSET	0x00c0
+#define OMAP3430_PRM_VP1_VOLTAGE	OMAP34XX_PRM_REGADDR(OMAP3430_GR_MOD,=
 0x00c0)
+#define OMAP3_PRM_VP1_STATUS_OFFSET	0x00c4
+#define OMAP3430_PRM_VP1_STATUS		OMAP34XX_PRM_REGADDR(OMAP3430_GR_MOD,=
 0x00c4)
+#define OMAP3_PRM_VP2_CONFIG_OFFSET	0x00d0
+#define OMAP3430_PRM_VP2_CONFIG		OMAP34XX_PRM_REGADDR(OMAP3430_GR_MOD,=
 0x00d0)
+#define OMAP3_PRM_VP2_VSTEPMIN_OFFSET	0x00d4
+#define OMAP3430_PRM_VP2_VSTEPMIN	OMAP34XX_PRM_REGADDR(OMAP3430_GR_MOD=
, 0x00d4)
+#define OMAP3_PRM_VP2_VSTEPMAX_OFFSET	0x00d8
+#define OMAP3430_PRM_VP2_VSTEPMAX	OMAP34XX_PRM_REGADDR(OMAP3430_GR_MOD=
, 0x00d8)
+#define OMAP3_PRM_VP2_VLIMITTO_OFFSET	0x00dc
+#define OMAP3430_PRM_VP2_VLIMITTO	OMAP34XX_PRM_REGADDR(OMAP3430_GR_MOD=
, 0x00dc)
+#define OMAP3_PRM_VP2_VOLTAGE_OFFSET	0x00e0
+#define OMAP3430_PRM_VP2_VOLTAGE	OMAP34XX_PRM_REGADDR(OMAP3430_GR_MOD,=
 0x00e0)
+#define OMAP3_PRM_VP2_STATUS_OFFSET	0x00e4
+#define OMAP3430_PRM_VP2_STATUS		OMAP34XX_PRM_REGADDR(OMAP3430_GR_MOD,=
 0x00e4)
+
+#define OMAP3_PRM_CLKSEL_OFFSET	0x0040
+#define OMAP3430_PRM_CLKSEL		OMAP34XX_PRM_REGADDR(OMAP3430_CCR_MOD, 0x=
0040)
+#define OMAP3_PRM_CLKOUT_CTRL_OFFSET	0x0070
+#define OMAP3430_PRM_CLKOUT_CTRL	OMAP34XX_PRM_REGADDR(OMAP3430_CCR_MOD=
, 0x0070)
+
+/* OMAP3 specific register offsets */
+#define OMAP3430ES2_PM_WKEN3				0x00f0
+#define OMAP3430ES2_PM_WKST3				0x00b8
+
+#define OMAP3430_PM_MPUGRPSEL				0x00a4
+#define OMAP3430_PM_MPUGRPSEL1				OMAP3430_PM_MPUGRPSEL
+#define OMAP3430ES2_PM_MPUGRPSEL3			0x00f8
+
+#define OMAP3430_PM_IVAGRPSEL				0x00a8
+#define OMAP3430_PM_IVAGRPSEL1				OMAP3430_PM_IVAGRPSEL
+#define OMAP3430ES2_PM_IVAGRPSEL3			0x00f4
+
+#define OMAP3430_PM_PREPWSTST				0x00e8
+
+#define OMAP3430_PRM_IRQSTATUS_IVA2			0x00f8
+#define OMAP3430_PRM_IRQENABLE_IVA2			0x00fc
+
+
+#ifndef __ASSEMBLER__
+
+/* OMAP3-specific VP functions */
+u32 omap3_prm_vp_check_txdone(u8 vp_id);
+void omap3_prm_vp_clear_txdone(u8 vp_id);
+
+/*
+ * OMAP3 access functions for voltage controller (VC) and
+ * voltage proccessor (VP) in the PRM.
+ */
+extern u32 omap3_prm_vcvp_read(u8 offset);
+extern void omap3_prm_vcvp_write(u32 val, u8 offset);
+extern u32 omap3_prm_vcvp_rmw(u32 mask, u32 bits, u8 offset);
+
+extern void omap3xxx_prm_reconfigure_io_chain(void);
+
+/* PRM interrupt-related functions */
+extern void omap3xxx_prm_read_pending_irqs(unsigned long *events);
+extern void omap3xxx_prm_ocp_barrier(void);
+extern void omap3xxx_prm_save_and_clear_irqen(u32 *saved_mask);
+extern void omap3xxx_prm_restore_irqen(u32 *saved_mask);
+
+#endif /* __ASSEMBLER */
+
+
+#endif
diff --git a/arch/arm/mach-omap2/prm44xx.c b/arch/arm/mach-omap2/prm44x=
x.c
index f0c4d5f..06bb679 100644
--- a/arch/arm/mach-omap2/prm44xx.c
+++ b/arch/arm/mach-omap2/prm44xx.c
@@ -291,12 +291,13 @@ static void __init omap44xx_prm_enable_io_wakeup(=
void)
 				    OMAP4_PRM_IO_PMCTRL_OFFSET);
 }
=20
-static int __init omap4xxx_prcm_init(void)
+static int __init omap4xxx_prm_init(void)
 {
-	if (cpu_is_omap44xx()) {
-		omap44xx_prm_enable_io_wakeup();
-		return omap_prcm_register_chain_handler(&omap4_prcm_irq_setup);
-	}
-	return 0;
+	if (!cpu_is_omap44xx())
+		return 0;
+
+	omap44xx_prm_enable_io_wakeup();
+
+	return omap_prcm_register_chain_handler(&omap4_prcm_irq_setup);
 }
-subsys_initcall(omap4xxx_prcm_init);
+subsys_initcall(omap4xxx_prm_init);
diff --git a/arch/arm/mach-omap2/sdrc2xxx.c b/arch/arm/mach-omap2/sdrc2=
xxx.c
index 73e55e4..9abd6e2 100644
--- a/arch/arm/mach-omap2/sdrc2xxx.c
+++ b/arch/arm/mach-omap2/sdrc2xxx.c
@@ -31,7 +31,7 @@
 #include "soc.h"
 #include "iomap.h"
 #include "common.h"
-#include "prm2xxx_3xxx.h"
+#include "prm2xxx.h"
 #include "clock.h"
 #include "sdrc.h"
=20
diff --git a/arch/arm/mach-omap2/sleep34xx.S b/arch/arm/mach-omap2/slee=
p34xx.S
index 5069879..d83b918 100644
--- a/arch/arm/mach-omap2/sleep34xx.S
+++ b/arch/arm/mach-omap2/sleep34xx.S
@@ -31,7 +31,7 @@
 #include "omap34xx.h"
 #include "iomap.h"
 #include "cm2xxx_3xxx.h"
-#include "prm2xxx_3xxx.h"
+#include "prm3xxx.h"
 #include "sdrc.h"
 #include "control.h"
=20
diff --git a/arch/arm/mach-omap2/sram242x.S b/arch/arm/mach-omap2/sram2=
42x.S
index 8f7326c..c720443 100644
--- a/arch/arm/mach-omap2/sram242x.S
+++ b/arch/arm/mach-omap2/sram242x.S
@@ -34,7 +34,7 @@
=20
 #include "soc.h"
 #include "iomap.h"
-#include "prm2xxx_3xxx.h"
+#include "prm2xxx.h"
 #include "cm2xxx_3xxx.h"
 #include "sdrc.h"
=20
diff --git a/arch/arm/mach-omap2/sram243x.S b/arch/arm/mach-omap2/sram2=
43x.S
index b140d65..cfdc0bc 100644
--- a/arch/arm/mach-omap2/sram243x.S
+++ b/arch/arm/mach-omap2/sram243x.S
@@ -34,7 +34,7 @@
=20
 #include "soc.h"
 #include "iomap.h"
-#include "prm2xxx_3xxx.h"
+#include "prm2xxx.h"
 #include "cm2xxx_3xxx.h"
 #include "sdrc.h"
=20


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
