From: Vaibhav Bedia <vaibhav.bedia@ti.com>
Subject: [RFC 9/9] ARM: OMAP2+: AM33XX: Get rid of custom PRM, CM APIs
Date: Tue, 2 Jul 2013 16:58:18 +0530
Message-ID: <1372764498-32503-10-git-send-email-vaibhav.bedia@ti.com>
References: <1372764498-32503-1-git-send-email-vaibhav.bedia@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:41807 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752421Ab3GBL3a (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 2 Jul 2013 07:29:30 -0400
In-Reply-To: <1372764498-32503-1-git-send-email-vaibhav.bedia@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: tony@atomide.com, paul@pwsan.com, rnayak@ti.com, Vaibhav Bedia <vaibhav.bedia@ti.com>

Now that we have migrated AM335x over to use OMAP4 style
PRM, CM APIs we can delete the custom APIs

To avoid build breakage the reset function is reimplemented
in the same patch.

Signed-off-by: Vaibhav Bedia <vaibhav.bedia@ti.com>
---
 arch/arm/mach-omap2/Makefile         |   3 +-
 arch/arm/mach-omap2/am33xx-restart.c |  34 ----
 arch/arm/mach-omap2/cm33xx.c         | 364 -----------------------------------
 arch/arm/mach-omap2/cm33xx.h         |  39 ----
 arch/arm/mach-omap2/omap4-common.c   |  14 ++
 arch/arm/mach-omap2/prm33xx.c        | 338 --------------------------------
 arch/arm/mach-omap2/prm33xx.h        |  11 --
 arch/arm/mach-omap2/prminst44xx.c    |  20 ++
 arch/arm/mach-omap2/prminst44xx.h    |   1 +
 9 files changed, 36 insertions(+), 788 deletions(-)
 delete mode 100644 arch/arm/mach-omap2/am33xx-restart.c
 delete mode 100644 arch/arm/mach-omap2/cm33xx.c
 delete mode 100644 arch/arm/mach-omap2/prm33xx.c

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 55a9d67..a47b517 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -56,7 +56,7 @@ AFLAGS_sram34xx.o			:=-Wa,-march=armv7-a
 # Restart code (OMAP4/5 currently in omap4-common.c)
 obj-$(CONFIG_SOC_OMAP2420)		+= omap2-restart.o
 obj-$(CONFIG_SOC_OMAP2430)		+= omap2-restart.o
-obj-$(CONFIG_SOC_AM33XX)		+= am33xx-restart.o
+obj-$(CONFIG_SOC_AM33XX)		+= omap4-common.o
 obj-$(CONFIG_ARCH_OMAP3)		+= omap3-restart.o
 
 # Pin multiplexing
@@ -109,7 +109,6 @@ obj-y					+= prm_common.o cm_common.o
 obj-$(CONFIG_ARCH_OMAP2)		+= prm2xxx_3xxx.o prm2xxx.o cm2xxx.o
 obj-$(CONFIG_ARCH_OMAP3)		+= prm2xxx_3xxx.o prm3xxx.o cm3xxx.o
 obj-$(CONFIG_ARCH_OMAP3)		+= vc3xxx_data.o vp3xxx_data.o
-obj-$(CONFIG_SOC_AM33XX)		+= prm33xx.o cm33xx.o
 omap-prcm-4-5-common			=  cminst44xx.o cm44xx.o prm44xx.o \
 					   prcm_mpu44xx.o prminst44xx.o \
 					   vc44xx_data.o vp44xx_data.o
diff --git a/arch/arm/mach-omap2/am33xx-restart.c b/arch/arm/mach-omap2/am33xx-restart.c
deleted file mode 100644
index 88e4fa8..0000000
--- a/arch/arm/mach-omap2/am33xx-restart.c
+++ /dev/null
@@ -1,34 +0,0 @@
-/*
- * am33xx-restart.c - Code common to all AM33xx machines.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-#include <linux/kernel.h>
-
-#include "common.h"
-#include "prm-regbits-33xx.h"
-#include "prm33xx.h"
-
-/**
- * am3xx_restart - trigger a software restart of the SoC
- * @mode: the "reboot mode", see arch/arm/kernel/{setup,process}.c
- * @cmd: passed from the userspace program rebooting the system (if provided)
- *
- * Resets the SoC.  For @cmd, see the 'reboot' syscall in
- * kernel/sys.c.  No return value.
- */
-void am33xx_restart(char mode, const char *cmd)
-{
-	/* TODO: Handle mode and cmd if necessary */
-
-	am33xx_prm_rmw_reg_bits(AM33XX_GLOBAL_WARM_SW_RST_MASK,
-				AM33XX_GLOBAL_WARM_SW_RST_MASK,
-				AM33XX_PRM_DEVICE_MOD,
-				AM33XX_PRM_RSTCTRL_OFFSET);
-
-	/* OCP barrier */
-	(void)am33xx_prm_read_reg(AM33XX_PRM_DEVICE_MOD,
-				  AM33XX_PRM_RSTCTRL_OFFSET);
-}
diff --git a/arch/arm/mach-omap2/cm33xx.c b/arch/arm/mach-omap2/cm33xx.c
deleted file mode 100644
index 325a515..0000000
--- a/arch/arm/mach-omap2/cm33xx.c
+++ /dev/null
@@ -1,364 +0,0 @@
-/*
- * AM33XX CM functions
- *
- * Copyright (C) 2011-2012 Texas Instruments Incorporated - http://www.ti.com/
- * Vaibhav Hiremath <hvaibhav@ti.com>
- *
- * Reference taken from from OMAP4 cminst44xx.c
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License as
- * published by the Free Software Foundation version 2.
- *
- * This program is distributed "as is" WITHOUT ANY WARRANTY of any
- * kind, whether express or implied; without even the implied warranty
- * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- */
-
-#include <linux/kernel.h>
-#include <linux/types.h>
-#include <linux/errno.h>
-#include <linux/err.h>
-#include <linux/io.h>
-
-#include "clockdomain.h"
-#include "cm.h"
-#include "cm33xx.h"
-#include "cm-regbits-34xx.h"
-#include "cm-regbits-33xx.h"
-#include "prm33xx.h"
-
-/*
- * CLKCTRL_IDLEST_*: possible values for the CM_*_CLKCTRL.IDLEST bitfield:
- *
- *   0x0 func:     Module is fully functional, including OCP
- *   0x1 trans:    Module is performing transition: wakeup, or sleep, or sleep
- *                 abortion
- *   0x2 idle:     Module is in Idle mode (only OCP part). It is functional if
- *                 using separate functional clock
- *   0x3 disabled: Module is disabled and cannot be accessed
- *
- */
-#define CLKCTRL_IDLEST_FUNCTIONAL		0x0
-#define CLKCTRL_IDLEST_INTRANSITION		0x1
-#define CLKCTRL_IDLEST_INTERFACE_IDLE		0x2
-#define CLKCTRL_IDLEST_DISABLED			0x3
-
-/* Private functions */
-
-/* Read a register in a CM instance */
-static inline u32 am33xx_cm_read_reg(s16 inst, u16 idx)
-{
-	return __raw_readl(cm_base + inst + idx);
-}
-
-/* Write into a register in a CM */
-static inline void am33xx_cm_write_reg(u32 val, s16 inst, u16 idx)
-{
-	__raw_writel(val, cm_base + inst + idx);
-}
-
-/* Read-modify-write a register in CM */
-static inline u32 am33xx_cm_rmw_reg_bits(u32 mask, u32 bits, s16 inst, s16 idx)
-{
-	u32 v;
-
-	v = am33xx_cm_read_reg(inst, idx);
-	v &= ~mask;
-	v |= bits;
-	am33xx_cm_write_reg(v, inst, idx);
-
-	return v;
-}
-
-static inline u32 am33xx_cm_set_reg_bits(u32 bits, s16 inst, s16 idx)
-{
-	return am33xx_cm_rmw_reg_bits(bits, bits, inst, idx);
-}
-
-static inline u32 am33xx_cm_clear_reg_bits(u32 bits, s16 inst, s16 idx)
-{
-	return am33xx_cm_rmw_reg_bits(bits, 0x0, inst, idx);
-}
-
-static inline u32 am33xx_cm_read_reg_bits(u16 inst, s16 idx, u32 mask)
-{
-	u32 v;
-
-	v = am33xx_cm_read_reg(inst, idx);
-	v &= mask;
-	v >>= __ffs(mask);
-
-	return v;
-}
-
-/**
- * _clkctrl_idlest - read a CM_*_CLKCTRL register; mask & shift IDLEST bitfield
- * @inst: CM instance register offset (*_INST macro)
- * @cdoffs: Clockdomain register offset (*_CDOFFS macro)
- * @clkctrl_offs: Module clock control register offset (*_CLKCTRL macro)
- *
- * Return the IDLEST bitfield of a CM_*_CLKCTRL register, shifted down to
- * bit 0.
- */
-static u32 _clkctrl_idlest(u16 inst, s16 cdoffs, u16 clkctrl_offs)
-{
-	u32 v = am33xx_cm_read_reg(inst, clkctrl_offs);
-	v &= AM33XX_IDLEST_MASK;
-	v >>= AM33XX_IDLEST_SHIFT;
-	return v;
-}
-
-/**
- * _is_module_ready - can module registers be accessed without causing an abort?
- * @inst: CM instance register offset (*_INST macro)
- * @cdoffs: Clockdomain register offset (*_CDOFFS macro)
- * @clkctrl_offs: Module clock control register offset (*_CLKCTRL macro)
- *
- * Returns true if the module's CM_*_CLKCTRL.IDLEST bitfield is either
- * *FUNCTIONAL or *INTERFACE_IDLE; false otherwise.
- */
-static bool _is_module_ready(u16 inst, s16 cdoffs, u16 clkctrl_offs)
-{
-	u32 v;
-
-	v = _clkctrl_idlest(inst, cdoffs, clkctrl_offs);
-
-	return (v == CLKCTRL_IDLEST_FUNCTIONAL ||
-		v == CLKCTRL_IDLEST_INTERFACE_IDLE) ? true : false;
-}
-
-/**
- * _clktrctrl_write - write @c to a CM_CLKSTCTRL.CLKTRCTRL register bitfield
- * @c: CLKTRCTRL register bitfield (LSB = bit 0, i.e., unshifted)
- * @inst: CM instance register offset (*_INST macro)
- * @cdoffs: Clockdomain register offset (*_CDOFFS macro)
- *
- * @c must be the unshifted value for CLKTRCTRL - i.e., this function
- * will handle the shift itself.
- */
-static void _clktrctrl_write(u8 c, s16 inst, u16 cdoffs)
-{
-	u32 v;
-
-	v = am33xx_cm_read_reg(inst, cdoffs);
-	v &= ~AM33XX_CLKTRCTRL_MASK;
-	v |= c << AM33XX_CLKTRCTRL_SHIFT;
-	am33xx_cm_write_reg(v, inst, cdoffs);
-}
-
-/* Public functions */
-
-/**
- * am33xx_cm_is_clkdm_in_hwsup - is a clockdomain in hwsup idle mode?
- * @inst: CM instance register offset (*_INST macro)
- * @cdoffs: Clockdomain register offset (*_CDOFFS macro)
- *
- * Returns true if the clockdomain referred to by (@inst, @cdoffs)
- * is in hardware-supervised idle mode, or 0 otherwise.
- */
-bool am33xx_cm_is_clkdm_in_hwsup(s16 inst, u16 cdoffs)
-{
-	u32 v;
-
-	v = am33xx_cm_read_reg(inst, cdoffs);
-	v &= AM33XX_CLKTRCTRL_MASK;
-	v >>= AM33XX_CLKTRCTRL_SHIFT;
-
-	return (v == OMAP34XX_CLKSTCTRL_ENABLE_AUTO) ? true : false;
-}
-
-/**
- * am33xx_cm_clkdm_enable_hwsup - put a clockdomain in hwsup-idle mode
- * @inst: CM instance register offset (*_INST macro)
- * @cdoffs: Clockdomain register offset (*_CDOFFS macro)
- *
- * Put a clockdomain referred to by (@inst, @cdoffs) into
- * hardware-supervised idle mode.  No return value.
- */
-void am33xx_cm_clkdm_enable_hwsup(s16 inst, u16 cdoffs)
-{
-	_clktrctrl_write(OMAP34XX_CLKSTCTRL_ENABLE_AUTO, inst, cdoffs);
-}
-
-/**
- * am33xx_cm_clkdm_disable_hwsup - put a clockdomain in swsup-idle mode
- * @inst: CM instance register offset (*_INST macro)
- * @cdoffs: Clockdomain register offset (*_CDOFFS macro)
- *
- * Put a clockdomain referred to by (@inst, @cdoffs) into
- * software-supervised idle mode, i.e., controlled manually by the
- * Linux OMAP clockdomain code.  No return value.
- */
-void am33xx_cm_clkdm_disable_hwsup(s16 inst, u16 cdoffs)
-{
-	_clktrctrl_write(OMAP34XX_CLKSTCTRL_DISABLE_AUTO, inst, cdoffs);
-}
-
-/**
- * am33xx_cm_clkdm_force_sleep - try to put a clockdomain into idle
- * @inst: CM instance register offset (*_INST macro)
- * @cdoffs: Clockdomain register offset (*_CDOFFS macro)
- *
- * Put a clockdomain referred to by (@inst, @cdoffs) into idle
- * No return value.
- */
-void am33xx_cm_clkdm_force_sleep(s16 inst, u16 cdoffs)
-{
-	_clktrctrl_write(OMAP34XX_CLKSTCTRL_FORCE_SLEEP, inst, cdoffs);
-}
-
-/**
- * am33xx_cm_clkdm_force_wakeup - try to take a clockdomain out of idle
- * @inst: CM instance register offset (*_INST macro)
- * @cdoffs: Clockdomain register offset (*_CDOFFS macro)
- *
- * Take a clockdomain referred to by (@inst, @cdoffs) out of idle,
- * waking it up.  No return value.
- */
-void am33xx_cm_clkdm_force_wakeup(s16 inst, u16 cdoffs)
-{
-	_clktrctrl_write(OMAP34XX_CLKSTCTRL_FORCE_WAKEUP, inst, cdoffs);
-}
-
-/*
- *
- */
-
-/**
- * am33xx_cm_wait_module_ready - wait for a module to be in 'func' state
- * @inst: CM instance register offset (*_INST macro)
- * @cdoffs: Clockdomain register offset (*_CDOFFS macro)
- * @clkctrl_offs: Module clock control register offset (*_CLKCTRL macro)
- *
- * Wait for the module IDLEST to be functional. If the idle state is in any
- * the non functional state (trans, idle or disabled), module and thus the
- * sysconfig cannot be accessed and will probably lead to an "imprecise
- * external abort"
- */
-int am33xx_cm_wait_module_ready(u16 inst, s16 cdoffs, u16 clkctrl_offs)
-{
-	int i = 0;
-
-	omap_test_timeout(_is_module_ready(inst, cdoffs, clkctrl_offs),
-			  MAX_MODULE_READY_TIME, i);
-
-	return (i < MAX_MODULE_READY_TIME) ? 0 : -EBUSY;
-}
-
-/**
- * am33xx_cm_wait_module_idle - wait for a module to be in 'disabled'
- * state
- * @inst: CM instance register offset (*_INST macro)
- * @cdoffs: Clockdomain register offset (*_CDOFFS macro)
- * @clkctrl_offs: Module clock control register offset (*_CLKCTRL macro)
- *
- * Wait for the module IDLEST to be disabled. Some PRCM transition,
- * like reset assertion or parent clock de-activation must wait the
- * module to be fully disabled.
- */
-int am33xx_cm_wait_module_idle(u16 inst, s16 cdoffs, u16 clkctrl_offs)
-{
-	int i = 0;
-
-	if (!clkctrl_offs)
-		return 0;
-
-	omap_test_timeout((_clkctrl_idlest(inst, cdoffs, clkctrl_offs) ==
-				CLKCTRL_IDLEST_DISABLED),
-				MAX_MODULE_READY_TIME, i);
-
-	return (i < MAX_MODULE_READY_TIME) ? 0 : -EBUSY;
-}
-
-/**
- * am33xx_cm_module_enable - Enable the modulemode inside CLKCTRL
- * @mode: Module mode (SW or HW)
- * @inst: CM instance register offset (*_INST macro)
- * @cdoffs: Clockdomain register offset (*_CDOFFS macro)
- * @clkctrl_offs: Module clock control register offset (*_CLKCTRL macro)
- *
- * No return value.
- */
-void am33xx_cm_module_enable(u8 mode, u16 inst, s16 cdoffs, u16 clkctrl_offs)
-{
-	u32 v;
-
-	v = am33xx_cm_read_reg(inst, clkctrl_offs);
-	v &= ~AM33XX_MODULEMODE_MASK;
-	v |= mode << AM33XX_MODULEMODE_SHIFT;
-	am33xx_cm_write_reg(v, inst, clkctrl_offs);
-}
-
-/**
- * am33xx_cm_module_disable - Disable the module inside CLKCTRL
- * @inst: CM instance register offset (*_INST macro)
- * @cdoffs: Clockdomain register offset (*_CDOFFS macro)
- * @clkctrl_offs: Module clock control register offset (*_CLKCTRL macro)
- *
- * No return value.
- */
-void am33xx_cm_module_disable(u16 inst, s16 cdoffs, u16 clkctrl_offs)
-{
-	u32 v;
-
-	v = am33xx_cm_read_reg(inst, clkctrl_offs);
-	v &= ~AM33XX_MODULEMODE_MASK;
-	am33xx_cm_write_reg(v, inst, clkctrl_offs);
-}
-
-/*
- * Clockdomain low-level functions
- */
-
-static int am33xx_clkdm_sleep(struct clockdomain *clkdm)
-{
-	am33xx_cm_clkdm_force_sleep(clkdm->cm_inst, clkdm->clkdm_offs);
-	return 0;
-}
-
-static int am33xx_clkdm_wakeup(struct clockdomain *clkdm)
-{
-	am33xx_cm_clkdm_force_wakeup(clkdm->cm_inst, clkdm->clkdm_offs);
-	return 0;
-}
-
-static void am33xx_clkdm_allow_idle(struct clockdomain *clkdm)
-{
-	am33xx_cm_clkdm_enable_hwsup(clkdm->cm_inst, clkdm->clkdm_offs);
-}
-
-static void am33xx_clkdm_deny_idle(struct clockdomain *clkdm)
-{
-	am33xx_cm_clkdm_disable_hwsup(clkdm->cm_inst, clkdm->clkdm_offs);
-}
-
-static int am33xx_clkdm_clk_enable(struct clockdomain *clkdm)
-{
-	if (clkdm->flags & CLKDM_CAN_FORCE_WAKEUP)
-		return am33xx_clkdm_wakeup(clkdm);
-
-	return 0;
-}
-
-static int am33xx_clkdm_clk_disable(struct clockdomain *clkdm)
-{
-	bool hwsup = false;
-
-	hwsup = am33xx_cm_is_clkdm_in_hwsup(clkdm->cm_inst, clkdm->clkdm_offs);
-
-	if (!hwsup && (clkdm->flags & CLKDM_CAN_FORCE_SLEEP))
-		am33xx_clkdm_sleep(clkdm);
-
-	return 0;
-}
-
-struct clkdm_ops am33xx_clkdm_operations = {
-	.clkdm_sleep		= am33xx_clkdm_sleep,
-	.clkdm_wakeup		= am33xx_clkdm_wakeup,
-	.clkdm_allow_idle	= am33xx_clkdm_allow_idle,
-	.clkdm_deny_idle	= am33xx_clkdm_deny_idle,
-	.clkdm_clk_enable	= am33xx_clkdm_clk_enable,
-	.clkdm_clk_disable	= am33xx_clkdm_clk_disable,
-};
diff --git a/arch/arm/mach-omap2/cm33xx.h b/arch/arm/mach-omap2/cm33xx.h
index 452351f..bce96fd 100644
--- a/arch/arm/mach-omap2/cm33xx.h
+++ b/arch/arm/mach-omap2/cm33xx.h
@@ -377,43 +377,4 @@
 #define AM33XX_CM_CEFUSE_CEFUSE_CLKCTRL_OFFSET		0x0020
 #define AM33XX_CM_CEFUSE_CEFUSE_CLKCTRL			AM33XX_CM_REGADDR(AM33XX_CM_CEFUSE_MOD, 0x0020)
 
-
-#ifndef __ASSEMBLER__
-extern bool am33xx_cm_is_clkdm_in_hwsup(s16 inst, u16 cdoffs);
-extern void am33xx_cm_clkdm_enable_hwsup(s16 inst, u16 cdoffs);
-extern void am33xx_cm_clkdm_disable_hwsup(s16 inst, u16 cdoffs);
-extern void am33xx_cm_clkdm_force_sleep(s16 inst, u16 cdoffs);
-extern void am33xx_cm_clkdm_force_wakeup(s16 inst, u16 cdoffs);
-
-#ifdef CONFIG_SOC_AM33XX
-extern int am33xx_cm_wait_module_idle(u16 inst, s16 cdoffs,
-					u16 clkctrl_offs);
-extern void am33xx_cm_module_enable(u8 mode, u16 inst, s16 cdoffs,
-					u16 clkctrl_offs);
-extern void am33xx_cm_module_disable(u16 inst, s16 cdoffs,
-					u16 clkctrl_offs);
-extern int am33xx_cm_wait_module_ready(u16 inst, s16 cdoffs,
-					u16 clkctrl_offs);
-#else
-static inline int am33xx_cm_wait_module_idle(u16 inst, s16 cdoffs,
-					u16 clkctrl_offs)
-{
-	return 0;
-}
-static inline void am33xx_cm_module_enable(u8 mode, u16 inst, s16 cdoffs,
-					u16 clkctrl_offs)
-{
-}
-static inline void am33xx_cm_module_disable(u16 inst, s16 cdoffs,
-					u16 clkctrl_offs)
-{
-}
-static inline int am33xx_cm_wait_module_ready(u16 inst, s16 cdoffs,
-					u16 clkctrl_offs)
-{
-	return 0;
-}
-#endif
-
-#endif /* ASSEMBLER */
 #endif
diff --git a/arch/arm/mach-omap2/omap4-common.c b/arch/arm/mach-omap2/omap4-common.c
index 13b27ff..aad2159 100644
--- a/arch/arm/mach-omap2/omap4-common.c
+++ b/arch/arm/mach-omap2/omap4-common.c
@@ -355,3 +355,17 @@ void omap44xx_restart(char mode, const char *cmd)
 	while (1);
 }
 
+/**
+ * omap44xx_restart - trigger a software restart of the SoC
+ * @mode: the "reboot mode", see arch/arm/kernel/{setup,process}.c
+ * @cmd: passed from the userspace program rebooting the system (if provided)
+ *
+ * Resets the SoC.  For @cmd, see the 'reboot' syscall in
+ * kernel/sys.c.  No return value.
+ */
+void am33xx_restart(char mode, const char *cmd)
+{
+	/* XXX Should save 'cmd' into scratchpad for use after reboot */
+	am33xx_prminst_global_warm_sw_reset(); /* never returns */
+	while (1);
+}
diff --git a/arch/arm/mach-omap2/prm33xx.c b/arch/arm/mach-omap2/prm33xx.c
deleted file mode 100644
index 44c0d72..0000000
--- a/arch/arm/mach-omap2/prm33xx.c
+++ /dev/null
@@ -1,338 +0,0 @@
-/*
- * AM33XX PRM functions
- *
- * Copyright (C) 2011-2012 Texas Instruments Incorporated - http://www.ti.com/
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License as
- * published by the Free Software Foundation version 2.
- *
- * This program is distributed "as is" WITHOUT ANY WARRANTY of any
- * kind, whether express or implied; without even the implied warranty
- * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- */
-
-#include <linux/kernel.h>
-#include <linux/types.h>
-#include <linux/errno.h>
-#include <linux/err.h>
-#include <linux/io.h>
-
-#include "common.h"
-#include "powerdomain.h"
-#include "prm33xx.h"
-#include "prm-regbits-33xx.h"
-
-/* Read a register in a PRM instance */
-u32 am33xx_prm_read_reg(s16 inst, u16 idx)
-{
-	return __raw_readl(prm_base + inst + idx);
-}
-
-/* Write into a register in a PRM instance */
-void am33xx_prm_write_reg(u32 val, s16 inst, u16 idx)
-{
-	__raw_writel(val, prm_base + inst + idx);
-}
-
-/* Read-modify-write a register in PRM. Caller must lock */
-u32 am33xx_prm_rmw_reg_bits(u32 mask, u32 bits, s16 inst, s16 idx)
-{
-	u32 v;
-
-	v = am33xx_prm_read_reg(inst, idx);
-	v &= ~mask;
-	v |= bits;
-	am33xx_prm_write_reg(v, inst, idx);
-
-	return v;
-}
-
-/**
- * am33xx_prm_is_hardreset_asserted - read the HW reset line state of
- * submodules contained in the hwmod module
- * @shift: register bit shift corresponding to the reset line to check
- * @inst: CM instance register offset (*_INST macro)
- * @rstctrl_offs: RM_RSTCTRL register address offset for this module
- *
- * Returns 1 if the (sub)module hardreset line is currently asserted,
- * 0 if the (sub)module hardreset line is not currently asserted, or
- * -EINVAL upon parameter error.
- */
-int am33xx_prm_is_hardreset_asserted(u8 shift, s16 inst, u16 rstctrl_offs)
-{
-	u32 v;
-
-	v = am33xx_prm_read_reg(inst, rstctrl_offs);
-	v &= 1 << shift;
-	v >>= shift;
-
-	return v;
-}
-
-/**
- * am33xx_prm_assert_hardreset - assert the HW reset line of a submodule
- * @shift: register bit shift corresponding to the reset line to assert
- * @inst: CM instance register offset (*_INST macro)
- * @rstctrl_reg: RM_RSTCTRL register address for this module
- *
- * Some IPs like dsp, ipu or iva contain processors that require an HW
- * reset line to be asserted / deasserted in order to fully enable the
- * IP.  These modules may have multiple hard-reset lines that reset
- * different 'submodules' inside the IP block.  This function will
- * place the submodule into reset.  Returns 0 upon success or -EINVAL
- * upon an argument error.
- */
-int am33xx_prm_assert_hardreset(u8 shift, s16 inst, u16 rstctrl_offs)
-{
-	u32 mask = 1 << shift;
-
-	am33xx_prm_rmw_reg_bits(mask, mask, inst, rstctrl_offs);
-
-	return 0;
-}
-
-/**
- * am33xx_prm_deassert_hardreset - deassert a submodule hardreset line and
- * wait
- * @shift: register bit shift corresponding to the reset line to deassert
- * @inst: CM instance register offset (*_INST macro)
- * @rstctrl_reg: RM_RSTCTRL register address for this module
- * @rstst_reg: RM_RSTST register address for this module
- *
- * Some IPs like dsp, ipu or iva contain processors that require an HW
- * reset line to be asserted / deasserted in order to fully enable the
- * IP.  These modules may have multiple hard-reset lines that reset
- * different 'submodules' inside the IP block.  This function will
- * take the submodule out of reset and wait until the PRCM indicates
- * that the reset has completed before returning.  Returns 0 upon success or
- * -EINVAL upon an argument error, -EEXIST if the submodule was already out
- * of reset, or -EBUSY if the submodule did not exit reset promptly.
- */
-int am33xx_prm_deassert_hardreset(u8 shift, u8 st_shift, s16 inst,
-		u16 rstctrl_offs, u16 rstst_offs)
-{
-	int c;
-	u32 mask = 1 << st_shift;
-
-	/* Check the current status to avoid  de-asserting the line twice */
-	if (am33xx_prm_is_hardreset_asserted(shift, inst, rstctrl_offs) == 0)
-		return -EEXIST;
-
-	/* Clear the reset status by writing 1 to the status bit */
-	am33xx_prm_rmw_reg_bits(0xffffffff, mask, inst, rstst_offs);
-
-	/* de-assert the reset control line */
-	mask = 1 << shift;
-
-	am33xx_prm_rmw_reg_bits(mask, 0, inst, rstctrl_offs);
-
-	/* wait the status to be set */
-	omap_test_timeout(am33xx_prm_is_hardreset_asserted(st_shift, inst,
-							   rstst_offs),
-			  MAX_MODULE_HARDRESET_WAIT, c);
-
-	return (c == MAX_MODULE_HARDRESET_WAIT) ? -EBUSY : 0;
-}
-
-static int am33xx_pwrdm_set_next_pwrst(struct powerdomain *pwrdm, u8 pwrst)
-{
-	am33xx_prm_rmw_reg_bits(OMAP_POWERSTATE_MASK,
-				(pwrst << OMAP_POWERSTATE_SHIFT),
-				pwrdm->prcm_offs, pwrdm->pwrstctrl_offs);
-	return 0;
-}
-
-static int am33xx_pwrdm_read_next_pwrst(struct powerdomain *pwrdm)
-{
-	u32 v;
-
-	v = am33xx_prm_read_reg(pwrdm->prcm_offs,  pwrdm->pwrstctrl_offs);
-	v &= OMAP_POWERSTATE_MASK;
-	v >>= OMAP_POWERSTATE_SHIFT;
-
-	return v;
-}
-
-static int am33xx_pwrdm_read_pwrst(struct powerdomain *pwrdm)
-{
-	u32 v;
-
-	v = am33xx_prm_read_reg(pwrdm->prcm_offs, pwrdm->pwrstst_offs);
-	v &= OMAP_POWERSTATEST_MASK;
-	v >>= OMAP_POWERSTATEST_SHIFT;
-
-	return v;
-}
-
-static int am33xx_pwrdm_read_prev_pwrst(struct powerdomain *pwrdm)
-{
-	u32 v;
-
-	v = am33xx_prm_read_reg(pwrdm->prcm_offs, pwrdm->pwrstst_offs);
-	v &= AM33XX_LASTPOWERSTATEENTERED_MASK;
-	v >>= AM33XX_LASTPOWERSTATEENTERED_SHIFT;
-
-	return v;
-}
-
-static int am33xx_pwrdm_set_lowpwrstchange(struct powerdomain *pwrdm)
-{
-	am33xx_prm_rmw_reg_bits(AM33XX_LOWPOWERSTATECHANGE_MASK,
-				(1 << AM33XX_LOWPOWERSTATECHANGE_SHIFT),
-				pwrdm->prcm_offs, pwrdm->pwrstctrl_offs);
-	return 0;
-}
-
-static int am33xx_pwrdm_clear_all_prev_pwrst(struct powerdomain *pwrdm)
-{
-	am33xx_prm_rmw_reg_bits(AM33XX_LASTPOWERSTATEENTERED_MASK,
-				AM33XX_LASTPOWERSTATEENTERED_MASK,
-				pwrdm->prcm_offs, pwrdm->pwrstst_offs);
-	return 0;
-}
-
-static int am33xx_pwrdm_set_logic_retst(struct powerdomain *pwrdm, u8 pwrst)
-{
-	u32 m;
-
-	m = pwrdm->logicretstate_mask;
-	if (!m)
-		return -EINVAL;
-
-	am33xx_prm_rmw_reg_bits(m, (pwrst << __ffs(m)),
-				pwrdm->prcm_offs, pwrdm->pwrstctrl_offs);
-
-	return 0;
-}
-
-static int am33xx_pwrdm_read_logic_pwrst(struct powerdomain *pwrdm)
-{
-	u32 v;
-
-	v = am33xx_prm_read_reg(pwrdm->prcm_offs, pwrdm->pwrstst_offs);
-	v &= AM33XX_LOGICSTATEST_MASK;
-	v >>= AM33XX_LOGICSTATEST_SHIFT;
-
-	return v;
-}
-
-static int am33xx_pwrdm_read_logic_retst(struct powerdomain *pwrdm)
-{
-	u32 v, m;
-
-	m = pwrdm->logicretstate_mask;
-	if (!m)
-		return -EINVAL;
-
-	v = am33xx_prm_read_reg(pwrdm->prcm_offs, pwrdm->pwrstctrl_offs);
-	v &= m;
-	v >>= __ffs(m);
-
-	return v;
-}
-
-static int am33xx_pwrdm_set_mem_onst(struct powerdomain *pwrdm, u8 bank,
-		u8 pwrst)
-{
-	u32 m;
-
-	m = pwrdm->mem_on_mask[bank];
-	if (!m)
-		return -EINVAL;
-
-	am33xx_prm_rmw_reg_bits(m, (pwrst << __ffs(m)),
-				pwrdm->prcm_offs, pwrdm->pwrstctrl_offs);
-
-	return 0;
-}
-
-static int am33xx_pwrdm_set_mem_retst(struct powerdomain *pwrdm, u8 bank,
-					u8 pwrst)
-{
-	u32 m;
-
-	m = pwrdm->mem_ret_mask[bank];
-	if (!m)
-		return -EINVAL;
-
-	am33xx_prm_rmw_reg_bits(m, (pwrst << __ffs(m)),
-				pwrdm->prcm_offs, pwrdm->pwrstctrl_offs);
-
-	return 0;
-}
-
-static int am33xx_pwrdm_read_mem_pwrst(struct powerdomain *pwrdm, u8 bank)
-{
-	u32 m, v;
-
-	m = pwrdm->mem_pwrst_mask[bank];
-	if (!m)
-		return -EINVAL;
-
-	v = am33xx_prm_read_reg(pwrdm->prcm_offs, pwrdm->pwrstst_offs);
-	v &= m;
-	v >>= __ffs(m);
-
-	return v;
-}
-
-static int am33xx_pwrdm_read_mem_retst(struct powerdomain *pwrdm, u8 bank)
-{
-	u32 m, v;
-
-	m = pwrdm->mem_retst_mask[bank];
-	if (!m)
-		return -EINVAL;
-
-	v = am33xx_prm_read_reg(pwrdm->prcm_offs, pwrdm->pwrstctrl_offs);
-	v &= m;
-	v >>= __ffs(m);
-
-	return v;
-}
-
-static int am33xx_pwrdm_wait_transition(struct powerdomain *pwrdm)
-{
-	u32 c = 0;
-
-	/*
-	 * REVISIT: pwrdm_wait_transition() may be better implemented
-	 * via a callback and a periodic timer check -- how long do we expect
-	 * powerdomain transitions to take?
-	 */
-
-	/* XXX Is this udelay() value meaningful? */
-	while ((am33xx_prm_read_reg(pwrdm->prcm_offs, pwrdm->pwrstst_offs)
-			& OMAP_INTRANSITION_MASK) &&
-			(c++ < PWRDM_TRANSITION_BAILOUT))
-		udelay(1);
-
-	if (c > PWRDM_TRANSITION_BAILOUT) {
-		pr_err("powerdomain: %s: waited too long to complete transition\n",
-		       pwrdm->name);
-		return -EAGAIN;
-	}
-
-	pr_debug("powerdomain: completed transition in %d loops\n", c);
-
-	return 0;
-}
-
-struct pwrdm_ops am33xx_pwrdm_operations = {
-	.pwrdm_set_next_pwrst		= am33xx_pwrdm_set_next_pwrst,
-	.pwrdm_read_next_pwrst		= am33xx_pwrdm_read_next_pwrst,
-	.pwrdm_read_pwrst		= am33xx_pwrdm_read_pwrst,
-	.pwrdm_read_prev_pwrst		= am33xx_pwrdm_read_prev_pwrst,
-	.pwrdm_set_logic_retst		= am33xx_pwrdm_set_logic_retst,
-	.pwrdm_read_logic_pwrst		= am33xx_pwrdm_read_logic_pwrst,
-	.pwrdm_read_logic_retst		= am33xx_pwrdm_read_logic_retst,
-	.pwrdm_clear_all_prev_pwrst	= am33xx_pwrdm_clear_all_prev_pwrst,
-	.pwrdm_set_lowpwrstchange	= am33xx_pwrdm_set_lowpwrstchange,
-	.pwrdm_read_mem_pwrst		= am33xx_pwrdm_read_mem_pwrst,
-	.pwrdm_read_mem_retst		= am33xx_pwrdm_read_mem_retst,
-	.pwrdm_set_mem_onst		= am33xx_pwrdm_set_mem_onst,
-	.pwrdm_set_mem_retst		= am33xx_pwrdm_set_mem_retst,
-	.pwrdm_wait_transition		= am33xx_pwrdm_wait_transition,
-};
diff --git a/arch/arm/mach-omap2/prm33xx.h b/arch/arm/mach-omap2/prm33xx.h
index c82b22b2..e070745 100644
--- a/arch/arm/mach-omap2/prm33xx.h
+++ b/arch/arm/mach-omap2/prm33xx.h
@@ -118,15 +118,4 @@
 #define AM33XX_PM_CEFUSE_PWRSTST_OFFSET		0x0004
 #define AM33XX_PM_CEFUSE_PWRSTST		AM33XX_PRM_REGADDR(AM33XX_PRM_CEFUSE_MOD, 0x0004)
 
-#ifndef __ASSEMBLER__
-extern u32 am33xx_prm_read_reg(s16 inst, u16 idx);
-extern void am33xx_prm_write_reg(u32 val, s16 inst, u16 idx);
-extern u32 am33xx_prm_rmw_reg_bits(u32 mask, u32 bits, s16 inst, s16 idx);
-extern void am33xx_prm_global_warm_sw_reset(void);
-extern int am33xx_prm_is_hardreset_asserted(u8 shift, s16 inst,
-		u16 rstctrl_offs);
-extern int am33xx_prm_assert_hardreset(u8 shift, s16 inst, u16 rstctrl_offs);
-extern int am33xx_prm_deassert_hardreset(u8 shift, u8 st_shift, s16 inst,
-		u16 rstctrl_offs, u16 rstst_offs);
-#endif /* ASSEMBLER */
 #endif
diff --git a/arch/arm/mach-omap2/prminst44xx.c b/arch/arm/mach-omap2/prminst44xx.c
index 5e165ea..667ffb0 100644
--- a/arch/arm/mach-omap2/prminst44xx.c
+++ b/arch/arm/mach-omap2/prminst44xx.c
@@ -19,8 +19,10 @@
 #include "iomap.h"
 #include "common.h"
 #include "prcm-common.h"
+#include "prm33xx.h"
 #include "prm44xx.h"
 #include "prminst44xx.h"
+#include "prm-regbits-33xx.h"
 #include "prm-regbits-44xx.h"
 #include "prcm44xx.h"
 #include "prcm_mpu44xx.h"
@@ -190,3 +192,21 @@ void omap4_prminst_global_warm_sw_reset(void)
 				    OMAP4430_PRM_DEVICE_INST,
 				    OMAP4_PRM_RSTCTRL_OFFSET);
 }
+
+void am33xx_prminst_global_warm_sw_reset(void)
+{
+	u32 v;
+
+	v = omap4_prminst_read_inst_reg(AM33XX_PRM_PARTITION,
+				    AM33XX_PRM_DEVICE_MOD,
+				    AM33XX_PRM_RSTCTRL_OFFSET);
+	v |= AM33XX_GLOBAL_WARM_SW_RST_MASK;
+	omap4_prminst_write_inst_reg(v, AM33XX_PRM_PARTITION,
+				 AM33XX_PRM_DEVICE_MOD,
+				 AM33XX_PRM_RSTCTRL_OFFSET);
+
+	/* OCP barrier */
+	v = omap4_prminst_read_inst_reg(AM33XX_PRM_PARTITION,
+				    AM33XX_PRM_DEVICE_MOD,
+				    AM33XX_PRM_RSTCTRL_OFFSET);
+}
diff --git a/arch/arm/mach-omap2/prminst44xx.h b/arch/arm/mach-omap2/prminst44xx.h
index 3973212..7a1fec10 100644
--- a/arch/arm/mach-omap2/prminst44xx.h
+++ b/arch/arm/mach-omap2/prminst44xx.h
@@ -22,6 +22,7 @@ extern u32 omap4_prminst_rmw_inst_reg_bits(u32 mask, u32 bits, u8 part,
 					   s16 inst, u16 idx);
 
 extern void omap4_prminst_global_warm_sw_reset(void);
+extern void am33xx_prminst_global_warm_sw_reset(void);
 
 extern int omap4_prminst_is_hardreset_asserted(u8 shift, u8 part, s16 inst,
 					       u16 rstctrl_offs);
-- 
1.8.1

