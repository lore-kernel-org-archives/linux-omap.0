From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 32/55] ARM: OMAP2+: PRM: move prm2xxx_3xxx.h to public location
Date: Mon, 31 Mar 2014 18:16:11 +0300
Message-ID: <1396278994-12624-33-git-send-email-t-kristo@ti.com>
References: <1396278994-12624-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:49898 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753914AbaCaPSn (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 31 Mar 2014 11:18:43 -0400
In-Reply-To: <1396278994-12624-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, tony@atomide.com, paul@pwsan.com
Cc: linux-arm-kernel@lists.infradead.org

This file needs to be accessible from the PRCM core and mach-omap2 board
support code.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/clock3xxx.c                  |    2 +-
 arch/arm/mach-omap2/clockdomains2420_data.c      |    2 +-
 arch/arm/mach-omap2/clockdomains2430_data.c      |    2 +-
 arch/arm/mach-omap2/clockdomains2xxx_3xxx_data.c |    2 +-
 arch/arm/mach-omap2/clockdomains3xxx_data.c      |    2 +-
 arch/arm/mach-omap2/cm2xxx.c                     |    2 +-
 arch/arm/mach-omap2/cm3xxx.c                     |    3 +-
 arch/arm/mach-omap2/dsp.c                        |    2 +-
 arch/arm/mach-omap2/pm-debug.c                   |    2 +-
 arch/arm/mach-omap2/powerdomain.c                |    2 +-
 arch/arm/mach-omap2/powerdomains2xxx_data.c      |    2 +-
 arch/arm/mach-omap2/powerdomains3xxx_data.c      |    2 +-
 arch/arm/mach-omap2/prm2xxx.h                    |    2 +-
 arch/arm/mach-omap2/prm2xxx_3xxx.h               |  198 ----------------------
 arch/arm/mach-omap2/prm2xxx_3xxx_private.h       |    2 +-
 arch/arm/mach-omap2/prm3xxx.h                    |    2 +-
 arch/arm/mach-omap2/prm_common.c                 |    2 +-
 arch/arm/mach-omap2/serial.c                     |    2 +-
 arch/arm/mach-omap2/sram.c                       |    2 +-
 arch/arm/mach-omap2/vp3xxx_data.c                |    2 +-
 include/linux/power/omap/prm2xxx_3xxx.h          |  197 +++++++++++++++++++++
 21 files changed, 217 insertions(+), 217 deletions(-)
 delete mode 100644 arch/arm/mach-omap2/prm2xxx_3xxx.h
 create mode 100644 include/linux/power/omap/prm2xxx_3xxx.h

diff --git a/arch/arm/mach-omap2/clock3xxx.c b/arch/arm/mach-omap2/clock3xxx.c
index 4706f2f..aebe66b 100644
--- a/arch/arm/mach-omap2/clock3xxx.c
+++ b/arch/arm/mach-omap2/clock3xxx.c
@@ -24,7 +24,7 @@
 #include "soc.h"
 #include "clock.h"
 #include "clock3xxx.h"
-#include "prm2xxx_3xxx.h"
+#include <linux/power/omap/prm2xxx_3xxx.h>
 #include "prm-regbits-34xx.h"
 #include <linux/power/omap/cm2xxx_3xxx.h>
 #include "cm-regbits-34xx.h"
diff --git a/arch/arm/mach-omap2/clockdomains2420_data.c b/arch/arm/mach-omap2/clockdomains2420_data.c
index 7931fd1..432cb14 100644
--- a/arch/arm/mach-omap2/clockdomains2420_data.c
+++ b/arch/arm/mach-omap2/clockdomains2420_data.c
@@ -37,7 +37,7 @@
 
 #include "soc.h"
 #include "clockdomain.h"
-#include "prm2xxx_3xxx.h"
+#include <linux/power/omap/prm2xxx_3xxx.h>
 #include <linux/power/omap/cm2xxx_3xxx.h>
 #include "cm-regbits-24xx.h"
 #include "prm-regbits-24xx.h"
diff --git a/arch/arm/mach-omap2/clockdomains2430_data.c b/arch/arm/mach-omap2/clockdomains2430_data.c
index 2e3918c..48df0fb 100644
--- a/arch/arm/mach-omap2/clockdomains2430_data.c
+++ b/arch/arm/mach-omap2/clockdomains2430_data.c
@@ -37,7 +37,7 @@
 
 #include "soc.h"
 #include "clockdomain.h"
-#include "prm2xxx_3xxx.h"
+#include <linux/power/omap/prm2xxx_3xxx.h>
 #include <linux/power/omap/cm2xxx_3xxx.h>
 #include "cm-regbits-24xx.h"
 #include "prm-regbits-24xx.h"
diff --git a/arch/arm/mach-omap2/clockdomains2xxx_3xxx_data.c b/arch/arm/mach-omap2/clockdomains2xxx_3xxx_data.c
index b728d6e..435e5c3 100644
--- a/arch/arm/mach-omap2/clockdomains2xxx_3xxx_data.c
+++ b/arch/arm/mach-omap2/clockdomains2xxx_3xxx_data.c
@@ -36,7 +36,7 @@
 #include <linux/io.h>
 
 #include "clockdomain.h"
-#include "prm2xxx_3xxx.h"
+#include <linux/power/omap/prm2xxx_3xxx.h>
 #include <linux/power/omap/cm2xxx_3xxx.h>
 #include "cm-regbits-24xx.h"
 #include "cm-regbits-34xx.h"
diff --git a/arch/arm/mach-omap2/clockdomains3xxx_data.c b/arch/arm/mach-omap2/clockdomains3xxx_data.c
index 27851ac..9272baf 100644
--- a/arch/arm/mach-omap2/clockdomains3xxx_data.c
+++ b/arch/arm/mach-omap2/clockdomains3xxx_data.c
@@ -35,7 +35,7 @@
 
 #include "soc.h"
 #include "clockdomain.h"
-#include "prm2xxx_3xxx.h"
+#include <linux/power/omap/prm2xxx_3xxx.h>
 #include <linux/power/omap/cm2xxx_3xxx.h>
 #include "cm-regbits-34xx.h"
 #include "prm-regbits-34xx.h"
diff --git a/arch/arm/mach-omap2/cm2xxx.c b/arch/arm/mach-omap2/cm2xxx.c
index b37783a..2385498 100644
--- a/arch/arm/mach-omap2/cm2xxx.c
+++ b/arch/arm/mach-omap2/cm2xxx.c
@@ -24,7 +24,7 @@
 #include <linux/power/omap/cm2xxx.h>
 #include "clockdomain.h"
 #include "prcm-common.h"
-#include "prm2xxx_3xxx.h"
+#include <linux/power/omap/prm2xxx_3xxx.h>
 
 /* CM_AUTOIDLE_PLL.AUTO_* bit values for DPLLs */
 #define DPLL_AUTOIDLE_DISABLE				0x0
diff --git a/arch/arm/mach-omap2/cm3xxx.c b/arch/arm/mach-omap2/cm3xxx.c
index 0818156..a80cd3e 100644
--- a/arch/arm/mach-omap2/cm3xxx.c
+++ b/arch/arm/mach-omap2/cm3xxx.c
@@ -18,11 +18,12 @@
 #include <linux/err.h>
 #include <linux/io.h>
 
-#include "prm2xxx_3xxx.h"
+#include <linux/power/omap/prm2xxx_3xxx.h>
 #include <linux/power/omap/cm.h>
 #include "cm2xxx_3xxx_private.h"
 #include <linux/power/omap/cm3xxx.h>
 #include "clockdomain.h"
+#include "prcm-common.h"
 
 #define OMAP34XX_CLKSTCTRL_DISABLE_AUTO		0x0
 #define OMAP34XX_CLKSTCTRL_FORCE_SLEEP		0x1
diff --git a/arch/arm/mach-omap2/dsp.c b/arch/arm/mach-omap2/dsp.c
index 1d802fe..a48b6d9 100644
--- a/arch/arm/mach-omap2/dsp.c
+++ b/arch/arm/mach-omap2/dsp.c
@@ -25,7 +25,7 @@
 
 #include "control.h"
 #include <linux/power/omap/cm2xxx_3xxx.h>
-#include "prm2xxx_3xxx.h"
+#include <linux/power/omap/prm2xxx_3xxx.h>
 #ifdef CONFIG_TIDSPBRIDGE_DVFS
 #include "omap-pm.h"
 #endif
diff --git a/arch/arm/mach-omap2/pm-debug.c b/arch/arm/mach-omap2/pm-debug.c
index 95f28b2..d2e4fb8 100644
--- a/arch/arm/mach-omap2/pm-debug.c
+++ b/arch/arm/mach-omap2/pm-debug.c
@@ -34,7 +34,7 @@
 
 #include "soc.h"
 #include <linux/power/omap/cm2xxx_3xxx.h>
-#include "prm2xxx_3xxx.h"
+#include <linux/power/omap/prm2xxx_3xxx.h>
 #include "pm.h"
 
 u32 enable_off_mode;
diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-omap2/powerdomain.c
index e532d2b..fdb6172 100644
--- a/arch/arm/mach-omap2/powerdomain.c
+++ b/arch/arm/mach-omap2/powerdomain.c
@@ -24,7 +24,7 @@
 
 #include <linux/power/omap/cm2xxx_3xxx.h>
 #include "prcm44xx.h"
-#include "prm2xxx_3xxx.h"
+#include <linux/power/omap/prm2xxx_3xxx.h>
 #include "prm44xx.h"
 
 #include <asm/cpu.h>
diff --git a/arch/arm/mach-omap2/powerdomains2xxx_data.c b/arch/arm/mach-omap2/powerdomains2xxx_data.c
index 578eef8..266bd96 100644
--- a/arch/arm/mach-omap2/powerdomains2xxx_data.c
+++ b/arch/arm/mach-omap2/powerdomains2xxx_data.c
@@ -19,7 +19,7 @@
 #include "powerdomains2xxx_3xxx_data.h"
 
 #include "prcm-common.h"
-#include "prm2xxx_3xxx.h"
+#include <linux/power/omap/prm2xxx_3xxx.h>
 #include "prm-regbits-24xx.h"
 
 /* 24XX powerdomains and dependencies */
diff --git a/arch/arm/mach-omap2/powerdomains3xxx_data.c b/arch/arm/mach-omap2/powerdomains3xxx_data.c
index 9db6a8e..7ba44db 100644
--- a/arch/arm/mach-omap2/powerdomains3xxx_data.c
+++ b/arch/arm/mach-omap2/powerdomains3xxx_data.c
@@ -19,7 +19,7 @@
 #include "powerdomain.h"
 #include "powerdomains2xxx_3xxx_data.h"
 #include "prcm-common.h"
-#include "prm2xxx_3xxx.h"
+#include <linux/power/omap/prm2xxx_3xxx.h>
 #include "prm-regbits-34xx.h"
 #include <linux/power/omap/cm2xxx_3xxx.h>
 #include "cm-regbits-34xx.h"
diff --git a/arch/arm/mach-omap2/prm2xxx.h b/arch/arm/mach-omap2/prm2xxx.h
index 19ff266..feeaf00 100644
--- a/arch/arm/mach-omap2/prm2xxx.h
+++ b/arch/arm/mach-omap2/prm2xxx.h
@@ -18,8 +18,8 @@
 
 #include "prcm-common.h"
 #include "prm.h"
-#include "prm2xxx_3xxx.h"
 #include <linux/power/omap/prm2xxx.h>
+#include <linux/power/omap/prm2xxx_3xxx.h>
 
 #define OMAP2420_PRM_REGADDR(module, reg)				\
 		OMAP2_L4_IO_ADDRESS(OMAP2420_PRM_BASE + (module) + (reg))
diff --git a/arch/arm/mach-omap2/prm2xxx_3xxx.h b/arch/arm/mach-omap2/prm2xxx_3xxx.h
deleted file mode 100644
index 1c5d998..0000000
--- a/arch/arm/mach-omap2/prm2xxx_3xxx.h
+++ /dev/null
@@ -1,198 +0,0 @@
-/*
- * OMAP2xxx/3xxx-common Power/Reset Management (PRM) register definitions
- *
- * Copyright (C) 2007-2009, 2011-2012 Texas Instruments, Inc.
- * Copyright (C) 2008-2010 Nokia Corporation
- * Paul Walmsley
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- * The PRM hardware modules on the OMAP2/3 are quite similar to each
- * other.  The PRM on OMAP4 has a new register layout, and is handled
- * in a separate file.
- */
-#ifndef __ARCH_ARM_MACH_OMAP2_PRM2XXX_3XXX_H
-#define __ARCH_ARM_MACH_OMAP2_PRM2XXX_3XXX_H
-
-#include "prcm-common.h"
-#include "prm.h"
-
-/*
- * Module specific PRM register offsets from PRM_BASE + domain offset
- *
- * Use prm_{read,write}_mod_reg() with these registers.
- *
- * With a few exceptions, these are the register names beginning with
- * {PM,RM}_* on both OMAP2/3 SoC families..  (The exceptions are the
- * IRQSTATUS and IRQENABLE bits.)
- */
-
-/* Register offsets appearing on both OMAP2 and OMAP3 */
-
-#define OMAP2_RM_RSTCTRL				0x0050
-#define OMAP2_RM_RSTTIME				0x0054
-#define OMAP2_RM_RSTST					0x0058
-#define OMAP2_PM_PWSTCTRL				0x00e0
-#define OMAP2_PM_PWSTST					0x00e4
-
-#define PM_WKEN						0x00a0
-#define PM_WKEN1					PM_WKEN
-#define PM_WKST						0x00b0
-#define PM_WKST1					PM_WKST
-#define PM_WKDEP					0x00c8
-#define PM_EVGENCTRL					0x00d4
-#define PM_EVGENONTIM					0x00d8
-#define PM_EVGENOFFTIM					0x00dc
-
-
-#ifndef __ASSEMBLER__
-
-#include <linux/io.h>
-#include "powerdomain.h"
-
-/* These omap2_ PRM functions apply to both OMAP2 and 3 */
-extern int omap2_prm_is_hardreset_asserted(s16 prm_mod, u8 shift);
-extern int omap2_prm_assert_hardreset(s16 prm_mod, u8 shift);
-extern int omap2_prm_deassert_hardreset(s16 prm_mod, u8 rst_shift, u8 st_shift);
-
-extern int omap2_pwrdm_set_next_pwrst(struct powerdomain *pwrdm, u8 pwrst);
-extern int omap2_pwrdm_read_next_pwrst(struct powerdomain *pwrdm);
-extern int omap2_pwrdm_read_pwrst(struct powerdomain *pwrdm);
-extern int omap2_pwrdm_set_mem_onst(struct powerdomain *pwrdm, u8 bank,
-				    u8 pwrst);
-extern int omap2_pwrdm_set_mem_retst(struct powerdomain *pwrdm, u8 bank,
-				     u8 pwrst);
-extern int omap2_pwrdm_read_mem_pwrst(struct powerdomain *pwrdm, u8 bank);
-extern int omap2_pwrdm_read_mem_retst(struct powerdomain *pwrdm, u8 bank);
-extern int omap2_pwrdm_set_logic_retst(struct powerdomain *pwrdm, u8 pwrst);
-extern int omap2_pwrdm_wait_transition(struct powerdomain *pwrdm);
-
-extern int omap2_clkdm_add_wkdep(struct clockdomain *clkdm1,
-				 struct clockdomain *clkdm2);
-extern int omap2_clkdm_del_wkdep(struct clockdomain *clkdm1,
-				 struct clockdomain *clkdm2);
-extern int omap2_clkdm_read_wkdep(struct clockdomain *clkdm1,
-				  struct clockdomain *clkdm2);
-extern int omap2_clkdm_clear_all_wkdeps(struct clockdomain *clkdm);
-
-#endif /* __ASSEMBLER */
-
-/*
- * Bits common to specific registers
- *
- * The 3430 register and bit names are generally used,
- * since they tend to make more sense
- */
-
-/* PM_EVGENONTIM_MPU */
-/* Named PM_EVEGENONTIM_MPU on the 24XX */
-#define OMAP_ONTIMEVAL_SHIFT				0
-#define OMAP_ONTIMEVAL_MASK				(0xffffffff << 0)
-
-/* PM_EVGENOFFTIM_MPU */
-/* Named PM_EVEGENOFFTIM_MPU on the 24XX */
-#define OMAP_OFFTIMEVAL_SHIFT				0
-#define OMAP_OFFTIMEVAL_MASK				(0xffffffff << 0)
-
-/* PRM_CLKSETUP and PRCM_VOLTSETUP */
-/* Named PRCM_CLKSSETUP on the 24XX */
-#define OMAP_SETUP_TIME_SHIFT				0
-#define OMAP_SETUP_TIME_MASK				(0xffff << 0)
-
-/* PRM_CLKSRC_CTRL */
-/* Named PRCM_CLKSRC_CTRL on the 24XX */
-#define OMAP_SYSCLKDIV_SHIFT				6
-#define OMAP_SYSCLKDIV_MASK				(0x3 << 6)
-#define OMAP_SYSCLKDIV_WIDTH				2
-#define OMAP_AUTOEXTCLKMODE_SHIFT			3
-#define OMAP_AUTOEXTCLKMODE_MASK			(0x3 << 3)
-#define OMAP_SYSCLKSEL_SHIFT				0
-#define OMAP_SYSCLKSEL_MASK				(0x3 << 0)
-
-/* PM_EVGENCTRL_MPU */
-#define OMAP_OFFLOADMODE_SHIFT				3
-#define OMAP_OFFLOADMODE_MASK				(0x3 << 3)
-#define OMAP_ONLOADMODE_SHIFT				1
-#define OMAP_ONLOADMODE_MASK				(0x3 << 1)
-#define OMAP_ENABLE_MASK				(1 << 0)
-
-/* PRM_RSTTIME */
-/* Named RM_RSTTIME_WKUP on the 24xx */
-#define OMAP_RSTTIME2_SHIFT				8
-#define OMAP_RSTTIME2_MASK				(0x1f << 8)
-#define OMAP_RSTTIME1_SHIFT				0
-#define OMAP_RSTTIME1_MASK				(0xff << 0)
-
-/* PRM_RSTCTRL */
-/* Named RM_RSTCTRL_WKUP on the 24xx */
-/* 2420 calls RST_DPLL3 'RST_DPLL' */
-#define OMAP_RST_DPLL3_MASK				(1 << 2)
-#define OMAP_RST_GS_MASK				(1 << 1)
-
-
-/*
- * Bits common to module-shared registers
- *
- * Not all registers of a particular type support all of these bits -
- * check TRM if you are unsure
- */
-
-/*
- * 24XX: RM_RSTST_MPU and RM_RSTST_DSP - on 24XX, 'COREDOMAINWKUP_RST' is
- *	 called 'COREWKUP_RST'
- *
- * 3430: RM_RSTST_IVA2, RM_RSTST_MPU, RM_RSTST_GFX, RM_RSTST_DSS,
- *	 RM_RSTST_CAM, RM_RSTST_PER, RM_RSTST_NEON
- */
-#define OMAP_COREDOMAINWKUP_RST_MASK			(1 << 3)
-
-/*
- * 24XX: RM_RSTST_MPU, RM_RSTST_GFX, RM_RSTST_DSP
- *
- * 2430: RM_RSTST_MDM
- *
- * 3430: RM_RSTST_CORE, RM_RSTST_EMU
- */
-#define OMAP_DOMAINWKUP_RST_MASK			(1 << 2)
-
-/*
- * 24XX: RM_RSTST_MPU, RM_RSTST_WKUP, RM_RSTST_DSP
- *	 On 24XX, 'GLOBALWARM_RST' is called 'GLOBALWMPU_RST'.
- *
- * 2430: RM_RSTST_MDM
- *
- * 3430: RM_RSTST_CORE, RM_RSTST_EMU
- */
-#define OMAP_GLOBALWARM_RST_SHIFT			1
-#define OMAP_GLOBALWARM_RST_MASK			(1 << 1)
-#define OMAP_GLOBALCOLD_RST_SHIFT			0
-#define OMAP_GLOBALCOLD_RST_MASK			(1 << 0)
-
-/*
- * 24XX: PM_WKDEP_GFX, PM_WKDEP_MPU, PM_WKDEP_CORE, PM_WKDEP_DSP
- *	 2420 TRM sometimes uses "EN_WAKEUP" instead of "EN_WKUP"
- *
- * 2430: PM_WKDEP_MDM
- *
- * 3430: PM_WKDEP_IVA2, PM_WKDEP_GFX, PM_WKDEP_DSS, PM_WKDEP_CAM,
- *	 PM_WKDEP_PER
- */
-#define OMAP_EN_WKUP_SHIFT				4
-#define OMAP_EN_WKUP_MASK				(1 << 4)
-
-/*
- * 24XX: PM_PWSTCTRL_MPU, PM_PWSTCTRL_CORE, PM_PWSTCTRL_GFX,
- *	 PM_PWSTCTRL_DSP
- *
- * 2430: PM_PWSTCTRL_MDM
- *
- * 3430: PM_PWSTCTRL_IVA2, PM_PWSTCTRL_CORE, PM_PWSTCTRL_GFX,
- *	 PM_PWSTCTRL_DSS, PM_PWSTCTRL_CAM, PM_PWSTCTRL_PER,
- *	 PM_PWSTCTRL_NEON
- */
-#define OMAP_LOGICRETSTATE_MASK				(1 << 2)
-
-
-#endif
diff --git a/arch/arm/mach-omap2/prm2xxx_3xxx_private.h b/arch/arm/mach-omap2/prm2xxx_3xxx_private.h
index 6e007e9..ebd6a09 100644
--- a/arch/arm/mach-omap2/prm2xxx_3xxx_private.h
+++ b/arch/arm/mach-omap2/prm2xxx_3xxx_private.h
@@ -18,7 +18,7 @@
 
 #include "prcm-common.h"
 #include "prm.h"
-#include "prm2xxx_3xxx.h"
+#include <linux/power/omap/prm2xxx_3xxx.h>
 
 #ifndef __ASSEMBLER__
 
diff --git a/arch/arm/mach-omap2/prm3xxx.h b/arch/arm/mach-omap2/prm3xxx.h
index 0e759bc..c79f4c6 100644
--- a/arch/arm/mach-omap2/prm3xxx.h
+++ b/arch/arm/mach-omap2/prm3xxx.h
@@ -18,7 +18,7 @@
 
 #include "prcm-common.h"
 #include "prm.h"
-#include "prm2xxx_3xxx.h"
+#include <linux/power/omap/prm2xxx_3xxx.h>
 
 #define OMAP34XX_PRM_REGADDR(module, reg)				\
 		OMAP2_L4_IO_ADDRESS(OMAP3430_PRM_BASE + (module) + (reg))
diff --git a/arch/arm/mach-omap2/prm_common.c b/arch/arm/mach-omap2/prm_common.c
index 273a338..c3eef62 100644
--- a/arch/arm/mach-omap2/prm_common.c
+++ b/arch/arm/mach-omap2/prm_common.c
@@ -28,7 +28,7 @@
 #include <linux/clk-provider.h>
 #include <linux/clk/ti.h>
 
-#include "prm2xxx_3xxx.h"
+#include <linux/power/omap/prm2xxx_3xxx.h>
 #include <linux/power/omap/prm2xxx.h>
 #include "prm3xxx.h"
 #include "prm44xx.h"
diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
index 90e06b3..0413d7e 100644
--- a/arch/arm/mach-omap2/serial.c
+++ b/arch/arm/mach-omap2/serial.c
@@ -34,7 +34,7 @@
 #include "omap_device.h"
 #include "omap-pm.h"
 #include "soc.h"
-#include "prm2xxx_3xxx.h"
+#include <linux/power/omap/prm2xxx_3xxx.h>
 #include "pm.h"
 #include <linux/power/omap/cm2xxx_3xxx.h>
 #include "prm-regbits-34xx.h"
diff --git a/arch/arm/mach-omap2/sram.c b/arch/arm/mach-omap2/sram.c
index 4bd0968..d18dc7b 100644
--- a/arch/arm/mach-omap2/sram.c
+++ b/arch/arm/mach-omap2/sram.c
@@ -26,7 +26,7 @@
 
 #include "soc.h"
 #include "iomap.h"
-#include "prm2xxx_3xxx.h"
+#include <linux/power/omap/prm2xxx_3xxx.h>
 #include "sdrc.h"
 #include "sram.h"
 
diff --git a/arch/arm/mach-omap2/vp3xxx_data.c b/arch/arm/mach-omap2/vp3xxx_data.c
index 1914e02..8507479 100644
--- a/arch/arm/mach-omap2/vp3xxx_data.c
+++ b/arch/arm/mach-omap2/vp3xxx_data.c
@@ -25,7 +25,7 @@
 #include "voltage.h"
 
 #include "vp.h"
-#include "prm2xxx_3xxx.h"
+#include <linux/power/omap/prm2xxx_3xxx.h>
 
 static const struct omap_vp_ops omap3_vp_ops = {
 	.check_txdone = omap3_prm_vp_check_txdone,
diff --git a/include/linux/power/omap/prm2xxx_3xxx.h b/include/linux/power/omap/prm2xxx_3xxx.h
new file mode 100644
index 0000000..26a7ba1
--- /dev/null
+++ b/include/linux/power/omap/prm2xxx_3xxx.h
@@ -0,0 +1,197 @@
+/*
+ * OMAP2xxx/3xxx-common Power/Reset Management (PRM) register definitions
+ *
+ * Copyright (C) 2007-2009, 2011-2012 Texas Instruments, Inc.
+ * Copyright (C) 2008-2010 Nokia Corporation
+ * Paul Walmsley
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * The PRM hardware modules on the OMAP2/3 are quite similar to each
+ * other.  The PRM on OMAP4 has a new register layout, and is handled
+ * in a separate file.
+ */
+#ifndef __LINUX_POWER_OMAP_PRM2XXX_3XXX_H
+#define __LINUX_POWER_OMAP_PRM2XXX_3XXX_H
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
+
+#ifndef __ASSEMBLER__
+
+#include <linux/io.h>
+
+struct powerdomain;
+struct clockdomain;
+
+/* These omap2_ PRM functions apply to both OMAP2 and 3 */
+int omap2_prm_is_hardreset_asserted(s16 prm_mod, u8 shift);
+int omap2_prm_assert_hardreset(s16 prm_mod, u8 shift);
+int omap2_prm_deassert_hardreset(s16 prm_mod, u8 rst_shift, u8 st_shift);
+
+int omap2_pwrdm_set_next_pwrst(struct powerdomain *pwrdm, u8 pwrst);
+int omap2_pwrdm_read_next_pwrst(struct powerdomain *pwrdm);
+int omap2_pwrdm_read_pwrst(struct powerdomain *pwrdm);
+int omap2_pwrdm_set_mem_onst(struct powerdomain *pwrdm, u8 bank,
+			     u8 pwrst);
+int omap2_pwrdm_set_mem_retst(struct powerdomain *pwrdm, u8 bank,
+			      u8 pwrst);
+int omap2_pwrdm_read_mem_pwrst(struct powerdomain *pwrdm, u8 bank);
+int omap2_pwrdm_read_mem_retst(struct powerdomain *pwrdm, u8 bank);
+int omap2_pwrdm_set_logic_retst(struct powerdomain *pwrdm, u8 pwrst);
+int omap2_pwrdm_wait_transition(struct powerdomain *pwrdm);
+
+int omap2_clkdm_add_wkdep(struct clockdomain *clkdm1,
+			  struct clockdomain *clkdm2);
+int omap2_clkdm_del_wkdep(struct clockdomain *clkdm1,
+			  struct clockdomain *clkdm2);
+int omap2_clkdm_read_wkdep(struct clockdomain *clkdm1,
+			   struct clockdomain *clkdm2);
+int omap2_clkdm_clear_all_wkdeps(struct clockdomain *clkdm);
+
+#endif /* __ASSEMBLER */
+
+/*
+ * Bits common to specific registers
+ *
+ * The 3430 register and bit names are generally used,
+ * since they tend to make more sense
+ */
+
+/* PM_EVGENONTIM_MPU */
+/* Named PM_EVEGENONTIM_MPU on the 24XX */
+#define OMAP_ONTIMEVAL_SHIFT				0
+#define OMAP_ONTIMEVAL_MASK				(0xffffffff << 0)
+
+/* PM_EVGENOFFTIM_MPU */
+/* Named PM_EVEGENOFFTIM_MPU on the 24XX */
+#define OMAP_OFFTIMEVAL_SHIFT				0
+#define OMAP_OFFTIMEVAL_MASK				(0xffffffff << 0)
+
+/* PRM_CLKSETUP and PRCM_VOLTSETUP */
+/* Named PRCM_CLKSSETUP on the 24XX */
+#define OMAP_SETUP_TIME_SHIFT				0
+#define OMAP_SETUP_TIME_MASK				(0xffff << 0)
+
+/* PRM_CLKSRC_CTRL */
+/* Named PRCM_CLKSRC_CTRL on the 24XX */
+#define OMAP_SYSCLKDIV_SHIFT				6
+#define OMAP_SYSCLKDIV_MASK				(0x3 << 6)
+#define OMAP_SYSCLKDIV_WIDTH				2
+#define OMAP_AUTOEXTCLKMODE_SHIFT			3
+#define OMAP_AUTOEXTCLKMODE_MASK			(0x3 << 3)
+#define OMAP_SYSCLKSEL_SHIFT				0
+#define OMAP_SYSCLKSEL_MASK				(0x3 << 0)
+
+/* PM_EVGENCTRL_MPU */
+#define OMAP_OFFLOADMODE_SHIFT				3
+#define OMAP_OFFLOADMODE_MASK				(0x3 << 3)
+#define OMAP_ONLOADMODE_SHIFT				1
+#define OMAP_ONLOADMODE_MASK				(0x3 << 1)
+#define OMAP_ENABLE_MASK				(1 << 0)
+
+/* PRM_RSTTIME */
+/* Named RM_RSTTIME_WKUP on the 24xx */
+#define OMAP_RSTTIME2_SHIFT				8
+#define OMAP_RSTTIME2_MASK				(0x1f << 8)
+#define OMAP_RSTTIME1_SHIFT				0
+#define OMAP_RSTTIME1_MASK				(0xff << 0)
+
+/* PRM_RSTCTRL */
+/* Named RM_RSTCTRL_WKUP on the 24xx */
+/* 2420 calls RST_DPLL3 'RST_DPLL' */
+#define OMAP_RST_DPLL3_MASK				(1 << 2)
+#define OMAP_RST_GS_MASK				(1 << 1)
+
+
+/*
+ * Bits common to module-shared registers
+ *
+ * Not all registers of a particular type support all of these bits -
+ * check TRM if you are unsure
+ */
+
+/*
+ * 24XX: RM_RSTST_MPU and RM_RSTST_DSP - on 24XX, 'COREDOMAINWKUP_RST' is
+ *	 called 'COREWKUP_RST'
+ *
+ * 3430: RM_RSTST_IVA2, RM_RSTST_MPU, RM_RSTST_GFX, RM_RSTST_DSS,
+ *	 RM_RSTST_CAM, RM_RSTST_PER, RM_RSTST_NEON
+ */
+#define OMAP_COREDOMAINWKUP_RST_MASK			(1 << 3)
+
+/*
+ * 24XX: RM_RSTST_MPU, RM_RSTST_GFX, RM_RSTST_DSP
+ *
+ * 2430: RM_RSTST_MDM
+ *
+ * 3430: RM_RSTST_CORE, RM_RSTST_EMU
+ */
+#define OMAP_DOMAINWKUP_RST_MASK			(1 << 2)
+
+/*
+ * 24XX: RM_RSTST_MPU, RM_RSTST_WKUP, RM_RSTST_DSP
+ *	 On 24XX, 'GLOBALWARM_RST' is called 'GLOBALWMPU_RST'.
+ *
+ * 2430: RM_RSTST_MDM
+ *
+ * 3430: RM_RSTST_CORE, RM_RSTST_EMU
+ */
+#define OMAP_GLOBALWARM_RST_SHIFT			1
+#define OMAP_GLOBALWARM_RST_MASK			(1 << 1)
+#define OMAP_GLOBALCOLD_RST_SHIFT			0
+#define OMAP_GLOBALCOLD_RST_MASK			(1 << 0)
+
+/*
+ * 24XX: PM_WKDEP_GFX, PM_WKDEP_MPU, PM_WKDEP_CORE, PM_WKDEP_DSP
+ *	 2420 TRM sometimes uses "EN_WAKEUP" instead of "EN_WKUP"
+ *
+ * 2430: PM_WKDEP_MDM
+ *
+ * 3430: PM_WKDEP_IVA2, PM_WKDEP_GFX, PM_WKDEP_DSS, PM_WKDEP_CAM,
+ *	 PM_WKDEP_PER
+ */
+#define OMAP_EN_WKUP_SHIFT				4
+#define OMAP_EN_WKUP_MASK				(1 << 4)
+
+/*
+ * 24XX: PM_PWSTCTRL_MPU, PM_PWSTCTRL_CORE, PM_PWSTCTRL_GFX,
+ *	 PM_PWSTCTRL_DSP
+ *
+ * 2430: PM_PWSTCTRL_MDM
+ *
+ * 3430: PM_PWSTCTRL_IVA2, PM_PWSTCTRL_CORE, PM_PWSTCTRL_GFX,
+ *	 PM_PWSTCTRL_DSS, PM_PWSTCTRL_CAM, PM_PWSTCTRL_PER,
+ *	 PM_PWSTCTRL_NEON
+ */
+#define OMAP_LOGICRETSTATE_MASK				(1 << 2)
+
+
+#endif
-- 
1.7.9.5

