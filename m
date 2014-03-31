From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 51/55] ARM: OMAP2+: powerdomain: move powerdomain.h header to public location
Date: Mon, 31 Mar 2014 18:16:30 +0300
Message-ID: <1396278994-12624-52-git-send-email-t-kristo@ti.com>
References: <1396278994-12624-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:59007 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752442AbaCaPUU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 31 Mar 2014 11:20:20 -0400
In-Reply-To: <1396278994-12624-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, tony@atomide.com, paul@pwsan.com
Cc: linux-arm-kernel@lists.infradead.org

This file needs to be accessible from the PRCM core and mach-omap2 board
support code.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/clockdomain.c                |    2 +-
 arch/arm/mach-omap2/cm2xxx.c                     |    2 +-
 arch/arm/mach-omap2/cm3xxx.c                     |    2 +-
 arch/arm/mach-omap2/cpuidle34xx.c                |    2 +-
 arch/arm/mach-omap2/gpio.c                       |    2 +-
 arch/arm/mach-omap2/io.c                         |    2 +-
 arch/arm/mach-omap2/omap-hotplug.c               |    2 +-
 arch/arm/mach-omap2/omap_hwmod.c                 |    2 +-
 arch/arm/mach-omap2/pm-debug.c                   |    2 +-
 arch/arm/mach-omap2/pm.c                         |    2 +-
 arch/arm/mach-omap2/pm.h                         |    2 +-
 arch/arm/mach-omap2/pm24xx.c                     |    2 +-
 arch/arm/mach-omap2/pm34xx.c                     |    2 +-
 arch/arm/mach-omap2/pm44xx.c                     |    2 +-
 arch/arm/mach-omap2/powerdomain.c                |    2 +-
 arch/arm/mach-omap2/powerdomain.h                |  277 ---------------------
 arch/arm/mach-omap2/powerdomains2xxx_3xxx_data.c |    2 +-
 arch/arm/mach-omap2/powerdomains2xxx_3xxx_data.h |    2 +-
 arch/arm/mach-omap2/powerdomains2xxx_data.c      |    2 +-
 arch/arm/mach-omap2/powerdomains33xx_data.c      |    2 +-
 arch/arm/mach-omap2/powerdomains3xxx_data.c      |    2 +-
 arch/arm/mach-omap2/powerdomains43xx_data.c      |    2 +-
 arch/arm/mach-omap2/powerdomains44xx_data.c      |    2 +-
 arch/arm/mach-omap2/powerdomains54xx_data.c      |    2 +-
 arch/arm/mach-omap2/powerdomains7xx_data.c       |    2 +-
 arch/arm/mach-omap2/prm2xxx.c                    |    2 +-
 arch/arm/mach-omap2/prm2xxx_3xxx.c               |    2 +-
 arch/arm/mach-omap2/prm2xxx_3xxx_private.h       |    2 +-
 arch/arm/mach-omap2/prm33xx.c                    |    2 +-
 arch/arm/mach-omap2/prm3xxx.c                    |    2 +-
 arch/arm/mach-omap2/prm44xx.c                    |    2 +-
 arch/arm/mach-omap2/timer.c                      |    2 +-
 arch/arm/mach-omap2/voltage.c                    |    2 +-
 include/linux/power/omap/powerdomain.h           |  280 ++++++++++++++++++++++
 34 files changed, 312 insertions(+), 309 deletions(-)
 delete mode 100644 arch/arm/mach-omap2/powerdomain.h
 create mode 100644 include/linux/power/omap/powerdomain.h

diff --git a/arch/arm/mach-omap2/clockdomain.c b/arch/arm/mach-omap2/clockdomain.c
index 298fb05..26d28c7 100644
--- a/arch/arm/mach-omap2/clockdomain.c
+++ b/arch/arm/mach-omap2/clockdomain.c
@@ -30,7 +30,7 @@
 
 #include "soc.h"
 #include <linux/power/omap/clockdomain.h>
-#include "powerdomain.h"
+#include <linux/power/omap/powerdomain.h>
 
 /* clkdm_list contains all registered struct clockdomains */
 static LIST_HEAD(clkdm_list);
diff --git a/arch/arm/mach-omap2/cm2xxx.c b/arch/arm/mach-omap2/cm2xxx.c
index 93efae1..c0aec2c 100644
--- a/arch/arm/mach-omap2/cm2xxx.c
+++ b/arch/arm/mach-omap2/cm2xxx.c
@@ -25,7 +25,7 @@
 #include <linux/power/omap/clockdomain.h>
 #include <linux/power/omap/prcm-common.h>
 #include <linux/power/omap/prm2xxx_3xxx.h>
-#include "powerdomain.h"
+#include <linux/power/omap/powerdomain.h>
 
 /* CM_AUTOIDLE_PLL.AUTO_* bit values for DPLLs */
 #define DPLL_AUTOIDLE_DISABLE				0x0
diff --git a/arch/arm/mach-omap2/cm3xxx.c b/arch/arm/mach-omap2/cm3xxx.c
index 47d0e49..d1b65ab 100644
--- a/arch/arm/mach-omap2/cm3xxx.c
+++ b/arch/arm/mach-omap2/cm3xxx.c
@@ -24,7 +24,7 @@
 #include <linux/power/omap/cm3xxx.h>
 #include <linux/power/omap/clockdomain.h>
 #include <linux/power/omap/prcm-common.h>
-#include "powerdomain.h"
+#include <linux/power/omap/powerdomain.h>
 
 #define OMAP34XX_CLKSTCTRL_DISABLE_AUTO		0x0
 #define OMAP34XX_CLKSTCTRL_FORCE_SLEEP		0x1
diff --git a/arch/arm/mach-omap2/cpuidle34xx.c b/arch/arm/mach-omap2/cpuidle34xx.c
index 858a28a..cb4f96a 100644
--- a/arch/arm/mach-omap2/cpuidle34xx.c
+++ b/arch/arm/mach-omap2/cpuidle34xx.c
@@ -28,7 +28,7 @@
 #include <linux/cpu_pm.h>
 #include <asm/cpuidle.h>
 
-#include "powerdomain.h"
+#include <linux/power/omap/powerdomain.h>
 #include <linux/power/omap/clockdomain.h>
 
 #include "pm.h"
diff --git a/arch/arm/mach-omap2/gpio.c b/arch/arm/mach-omap2/gpio.c
index 7a57714..7d37e50 100644
--- a/arch/arm/mach-omap2/gpio.c
+++ b/arch/arm/mach-omap2/gpio.c
@@ -28,7 +28,7 @@
 #include "omap_device.h"
 #include "omap-pm.h"
 
-#include "powerdomain.h"
+#include <linux/power/omap/powerdomain.h>
 
 static int __init omap2_gpio_dev_init(struct omap_hwmod *oh, void *unused)
 {
diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index b12ca79..08dd6de 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -31,7 +31,7 @@
 #include "soc.h"
 #include "iomap.h"
 #include "voltage.h"
-#include "powerdomain.h"
+#include <linux/power/omap/powerdomain.h>
 #include <linux/power/omap/clockdomain.h>
 #include "common.h"
 #include "clock.h"
diff --git a/arch/arm/mach-omap2/omap-hotplug.c b/arch/arm/mach-omap2/omap-hotplug.c
index 458f72f..5360d37 100644
--- a/arch/arm/mach-omap2/omap-hotplug.c
+++ b/arch/arm/mach-omap2/omap-hotplug.c
@@ -21,7 +21,7 @@
 
 #include "omap-wakeupgen.h"
 #include "common.h"
-#include "powerdomain.h"
+#include <linux/power/omap/powerdomain.h>
 
 /*
  * platform-specific code to shutdown a CPU
diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index bfd3c19..d152ddc 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -150,7 +150,7 @@
 #include "soc.h"
 #include "common.h"
 #include <linux/power/omap/clockdomain.h>
-#include "powerdomain.h"
+#include <linux/power/omap/powerdomain.h>
 #include "cm2xxx.h"
 #include "cm3xxx.h"
 #include <linux/power/omap/cm44xx.h>
diff --git a/arch/arm/mach-omap2/pm-debug.c b/arch/arm/mach-omap2/pm-debug.c
index 766012e..5ef4c7d 100644
--- a/arch/arm/mach-omap2/pm-debug.c
+++ b/arch/arm/mach-omap2/pm-debug.c
@@ -28,7 +28,7 @@
 #include <linux/slab.h>
 
 #include "clock.h"
-#include "powerdomain.h"
+#include <linux/power/omap/powerdomain.h>
 #include <linux/power/omap/clockdomain.h>
 #include "omap-pm.h"
 
diff --git a/arch/arm/mach-omap2/pm.c b/arch/arm/mach-omap2/pm.c
index 8ee7b14..ea6b5ad 100644
--- a/arch/arm/mach-omap2/pm.c
+++ b/arch/arm/mach-omap2/pm.c
@@ -27,7 +27,7 @@
 #include "soc.h"
 #include <linux/power/omap/prcm-common.h>
 #include "voltage.h"
-#include "powerdomain.h"
+#include <linux/power/omap/powerdomain.h>
 #include <linux/power/omap/clockdomain.h>
 #include "pm.h"
 #include "twl-common.h"
diff --git a/arch/arm/mach-omap2/pm.h b/arch/arm/mach-omap2/pm.h
index 7bdd22a..b63bd1f 100644
--- a/arch/arm/mach-omap2/pm.h
+++ b/arch/arm/mach-omap2/pm.h
@@ -13,7 +13,7 @@
 
 #include <linux/err.h>
 
-#include "powerdomain.h"
+#include <linux/power/omap/powerdomain.h>
 
 #ifdef CONFIG_CPU_IDLE
 extern int __init omap3_idle_init(void);
diff --git a/arch/arm/mach-omap2/pm24xx.c b/arch/arm/mach-omap2/pm24xx.c
index 6c1b8d6..788ec5e 100644
--- a/arch/arm/mach-omap2/pm24xx.c
+++ b/arch/arm/mach-omap2/pm24xx.c
@@ -51,7 +51,7 @@
 #include "sram.h"
 #include "pm.h"
 #include "control.h"
-#include "powerdomain.h"
+#include <linux/power/omap/powerdomain.h>
 #include <linux/power/omap/clockdomain.h>
 
 static void (*omap2_sram_suspend)(u32 dllctrl, void __iomem *sdrc_dlla_ctrl,
diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 119b9ff..ca3724c 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -38,7 +38,7 @@
 #include <asm/system_misc.h>
 
 #include <linux/power/omap/clockdomain.h>
-#include "powerdomain.h"
+#include <linux/power/omap/powerdomain.h>
 #include "soc.h"
 #include "common.h"
 #include "cm3xxx.h"
diff --git a/arch/arm/mach-omap2/pm44xx.c b/arch/arm/mach-omap2/pm44xx.c
index 47f664f..d7b8d33 100644
--- a/arch/arm/mach-omap2/pm44xx.c
+++ b/arch/arm/mach-omap2/pm44xx.c
@@ -21,7 +21,7 @@
 #include "soc.h"
 #include "common.h"
 #include <linux/power/omap/clockdomain.h>
-#include "powerdomain.h"
+#include <linux/power/omap/powerdomain.h>
 #include "pm.h"
 
 u16 pm44xx_errata;
diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-omap2/powerdomain.c
index 63fd500..11a5359 100644
--- a/arch/arm/mach-omap2/powerdomain.c
+++ b/arch/arm/mach-omap2/powerdomain.c
@@ -30,7 +30,7 @@
 #include <asm/cpu.h>
 
 #include <linux/power/omap/prm.h>
-#include "powerdomain.h"
+#include <linux/power/omap/powerdomain.h>
 #include <linux/power/omap/clockdomain.h>
 #include "voltage.h"
 
diff --git a/arch/arm/mach-omap2/powerdomain.h b/arch/arm/mach-omap2/powerdomain.h
deleted file mode 100644
index f472711..0000000
--- a/arch/arm/mach-omap2/powerdomain.h
+++ /dev/null
@@ -1,277 +0,0 @@
-/*
- * OMAP2/3/4 powerdomain control
- *
- * Copyright (C) 2007-2008, 2010 Texas Instruments, Inc.
- * Copyright (C) 2007-2011 Nokia Corporation
- *
- * Paul Walmsley
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- * XXX This should be moved to the mach-omap2/ directory at the earliest
- * opportunity.
- */
-
-#ifndef __ARCH_ARM_MACH_OMAP2_POWERDOMAIN_H
-#define __ARCH_ARM_MACH_OMAP2_POWERDOMAIN_H
-
-#include <linux/types.h>
-#include <linux/list.h>
-#include <linux/spinlock.h>
-
-/* Powerdomain basic power states */
-#define PWRDM_POWER_OFF		0x0
-#define PWRDM_POWER_RET		0x1
-#define PWRDM_POWER_INACTIVE	0x2
-#define PWRDM_POWER_ON		0x3
-
-#define PWRDM_MAX_PWRSTS	4
-
-/* Powerdomain allowable state bitfields */
-#define PWRSTS_ON		(1 << PWRDM_POWER_ON)
-#define PWRSTS_INACTIVE		(1 << PWRDM_POWER_INACTIVE)
-#define PWRSTS_RET		(1 << PWRDM_POWER_RET)
-#define PWRSTS_OFF		(1 << PWRDM_POWER_OFF)
-
-#define PWRSTS_OFF_ON		(PWRSTS_OFF | PWRSTS_ON)
-#define PWRSTS_OFF_RET		(PWRSTS_OFF | PWRSTS_RET)
-#define PWRSTS_RET_ON		(PWRSTS_RET | PWRSTS_ON)
-#define PWRSTS_OFF_RET_ON	(PWRSTS_OFF_RET | PWRSTS_ON)
-
-
-/*
- * Powerdomain flags (struct powerdomain.flags)
- *
- * PWRDM_HAS_HDWR_SAR - powerdomain has hardware save-and-restore support
- *
- * PWRDM_HAS_MPU_QUIRK - MPU pwr domain has MEM bank 0 bits in MEM
- * bank 1 position. This is true for OMAP3430
- *
- * PWRDM_HAS_LOWPOWERSTATECHANGE - can transition from a sleep state
- * to a lower sleep state without waking up the powerdomain
- */
-#define PWRDM_HAS_HDWR_SAR		BIT(0)
-#define PWRDM_HAS_MPU_QUIRK		BIT(1)
-#define PWRDM_HAS_LOWPOWERSTATECHANGE	BIT(2)
-
-/*
- * Number of memory banks that are power-controllable.	On OMAP4430, the
- * maximum is 5.
- */
-#define PWRDM_MAX_MEM_BANKS	5
-
-/*
- * Maximum number of clockdomains that can be associated with a powerdomain.
- * PER powerdomain on AM33XX is the worst case
- */
-#define PWRDM_MAX_CLKDMS	11
-
-/* XXX A completely arbitrary number. What is reasonable here? */
-#define PWRDM_TRANSITION_BAILOUT 100000
-
-struct clockdomain;
-struct powerdomain;
-struct voltagedomain;
-
-/**
- * struct powerdomain - OMAP powerdomain
- * @name: Powerdomain name
- * @voltdm: voltagedomain containing this powerdomain
- * @prcm_offs: the address offset from CM_BASE/PRM_BASE
- * @prcm_partition: (OMAP4 only) the PRCM partition ID containing @prcm_offs
- * @pwrsts: Possible powerdomain power states
- * @pwrsts_logic_ret: Possible logic power states when pwrdm in RETENTION
- * @flags: Powerdomain flags
- * @banks: Number of software-controllable memory banks in this powerdomain
- * @pwrsts_mem_ret: Possible memory bank pwrstates when pwrdm in RETENTION
- * @pwrsts_mem_on: Possible memory bank pwrstates when pwrdm in ON
- * @pwrdm_clkdms: Clockdomains in this powerdomain
- * @node: list_head linking all powerdomains
- * @voltdm_node: list_head linking all powerdomains in a voltagedomain
- * @pwrstctrl_offs: (AM33XX only) XXX_PWRSTCTRL reg offset from prcm_offs
- * @pwrstst_offs: (AM33XX only) XXX_PWRSTST reg offset from prcm_offs
- * @logicretstate_mask: (AM33XX only) mask for logic retention bitfield
- *	in @pwrstctrl_offs
- * @mem_on_mask: (AM33XX only) mask for mem on bitfield in @pwrstctrl_offs
- * @mem_ret_mask: (AM33XX only) mask for mem ret bitfield in @pwrstctrl_offs
- * @mem_pwrst_mask: (AM33XX only) mask for mem state bitfield in @pwrstst_offs
- * @mem_retst_mask: (AM33XX only) mask for mem retention state bitfield
- *	in @pwrstctrl_offs
- * @state:
- * @state_counter:
- * @timer:
- * @state_timer:
- * @_lock: spinlock used to serialize powerdomain and some clockdomain ops
- * @_lock_flags: stored flags when @_lock is taken
- *
- * @prcm_partition possible values are defined in mach-omap2/prcm44xx.h.
- */
-struct powerdomain {
-	const char *name;
-	union {
-		const char *name;
-		struct voltagedomain *ptr;
-	} voltdm;
-	const s16 prcm_offs;
-	const u8 pwrsts;
-	const u8 pwrsts_logic_ret;
-	const u8 flags;
-	const u8 banks;
-	const u8 pwrsts_mem_ret[PWRDM_MAX_MEM_BANKS];
-	const u8 pwrsts_mem_on[PWRDM_MAX_MEM_BANKS];
-	const u8 prcm_partition;
-	struct clockdomain *pwrdm_clkdms[PWRDM_MAX_CLKDMS];
-	struct list_head node;
-	struct list_head voltdm_node;
-	int state;
-	unsigned state_counter[PWRDM_MAX_PWRSTS];
-	unsigned ret_logic_off_counter;
-	unsigned ret_mem_off_counter[PWRDM_MAX_MEM_BANKS];
-	spinlock_t _lock;
-	unsigned long _lock_flags;
-	const u8 pwrstctrl_offs;
-	const u8 pwrstst_offs;
-	const u32 logicretstate_mask;
-	const u32 mem_on_mask[PWRDM_MAX_MEM_BANKS];
-	const u32 mem_ret_mask[PWRDM_MAX_MEM_BANKS];
-	const u32 mem_pwrst_mask[PWRDM_MAX_MEM_BANKS];
-	const u32 mem_retst_mask[PWRDM_MAX_MEM_BANKS];
-
-#ifdef CONFIG_PM_DEBUG
-	s64 timer;
-	s64 state_timer[PWRDM_MAX_PWRSTS];
-#endif
-};
-
-/**
- * struct pwrdm_ops - Arch specific function implementations
- * @pwrdm_set_next_pwrst: Set the target power state for a pd
- * @pwrdm_read_next_pwrst: Read the target power state set for a pd
- * @pwrdm_read_pwrst: Read the current power state of a pd
- * @pwrdm_read_prev_pwrst: Read the prev power state entered by the pd
- * @pwrdm_set_logic_retst: Set the logic state in RET for a pd
- * @pwrdm_set_mem_onst: Set the Memory state in ON for a pd
- * @pwrdm_set_mem_retst: Set the Memory state in RET for a pd
- * @pwrdm_read_logic_pwrst: Read the current logic state of a pd
- * @pwrdm_read_prev_logic_pwrst: Read the previous logic state entered by a pd
- * @pwrdm_read_logic_retst: Read the logic state in RET for a pd
- * @pwrdm_read_mem_pwrst: Read the current memory state of a pd
- * @pwrdm_read_prev_mem_pwrst: Read the previous memory state entered by a pd
- * @pwrdm_read_mem_retst: Read the memory state in RET for a pd
- * @pwrdm_clear_all_prev_pwrst: Clear all previous power states logged for a pd
- * @pwrdm_enable_hdwr_sar: Enable Hardware Save-Restore feature for the pd
- * @pwrdm_disable_hdwr_sar: Disable Hardware Save-Restore feature for a pd
- * @pwrdm_set_lowpwrstchange: Enable pd transitions from a shallow to deep sleep
- * @pwrdm_wait_transition: Wait for a pd state transition to complete
- * @pwrdm_has_voltdm: Check if a voltdm association is needed
- *
- * Regarding @pwrdm_set_lowpwrstchange: On the OMAP2 and 3-family
- * chips, a powerdomain's power state is not allowed to directly
- * transition from one low-power state (e.g., CSWR) to another
- * low-power state (e.g., OFF) without first waking up the
- * powerdomain.  This wastes energy.  So OMAP4 chips support the
- * ability to transition a powerdomain power state directly from one
- * low-power state to another.  The function pointed to by
- * @pwrdm_set_lowpwrstchange is intended to configure the OMAP4
- * hardware powerdomain state machine to enable this feature.
- */
-struct pwrdm_ops {
-	int	(*pwrdm_set_next_pwrst)(struct powerdomain *pwrdm, u8 pwrst);
-	int	(*pwrdm_read_next_pwrst)(struct powerdomain *pwrdm);
-	int	(*pwrdm_read_pwrst)(struct powerdomain *pwrdm);
-	int	(*pwrdm_read_prev_pwrst)(struct powerdomain *pwrdm);
-	int	(*pwrdm_set_logic_retst)(struct powerdomain *pwrdm, u8 pwrst);
-	int	(*pwrdm_set_mem_onst)(struct powerdomain *pwrdm, u8 bank, u8 pwrst);
-	int	(*pwrdm_set_mem_retst)(struct powerdomain *pwrdm, u8 bank, u8 pwrst);
-	int	(*pwrdm_read_logic_pwrst)(struct powerdomain *pwrdm);
-	int	(*pwrdm_read_prev_logic_pwrst)(struct powerdomain *pwrdm);
-	int	(*pwrdm_read_logic_retst)(struct powerdomain *pwrdm);
-	int	(*pwrdm_read_mem_pwrst)(struct powerdomain *pwrdm, u8 bank);
-	int	(*pwrdm_read_prev_mem_pwrst)(struct powerdomain *pwrdm, u8 bank);
-	int	(*pwrdm_read_mem_retst)(struct powerdomain *pwrdm, u8 bank);
-	int	(*pwrdm_clear_all_prev_pwrst)(struct powerdomain *pwrdm);
-	int	(*pwrdm_enable_hdwr_sar)(struct powerdomain *pwrdm);
-	int	(*pwrdm_disable_hdwr_sar)(struct powerdomain *pwrdm);
-	int	(*pwrdm_set_lowpwrstchange)(struct powerdomain *pwrdm);
-	int	(*pwrdm_wait_transition)(struct powerdomain *pwrdm);
-	int	(*pwrdm_has_voltdm)(void);
-};
-
-int pwrdm_register_platform_funcs(struct pwrdm_ops *custom_funcs);
-int pwrdm_register_pwrdms(struct powerdomain **pwrdm_list);
-int pwrdm_complete_init(void);
-
-struct powerdomain *pwrdm_lookup(const char *name);
-
-int pwrdm_for_each(int (*fn)(struct powerdomain *pwrdm, void *user),
-			void *user);
-int pwrdm_for_each_nolock(int (*fn)(struct powerdomain *pwrdm, void *user),
-			void *user);
-
-int pwrdm_add_clkdm(struct powerdomain *pwrdm, struct clockdomain *clkdm);
-int pwrdm_del_clkdm(struct powerdomain *pwrdm, struct clockdomain *clkdm);
-int pwrdm_for_each_clkdm(struct powerdomain *pwrdm,
-			 int (*fn)(struct powerdomain *pwrdm,
-				   struct clockdomain *clkdm));
-struct voltagedomain *pwrdm_get_voltdm(struct powerdomain *pwrdm);
-
-int pwrdm_get_mem_bank_count(struct powerdomain *pwrdm);
-
-int pwrdm_set_next_pwrst(struct powerdomain *pwrdm, u8 pwrst);
-int pwrdm_read_next_pwrst(struct powerdomain *pwrdm);
-int pwrdm_read_pwrst(struct powerdomain *pwrdm);
-int pwrdm_read_prev_pwrst(struct powerdomain *pwrdm);
-int pwrdm_clear_all_prev_pwrst(struct powerdomain *pwrdm);
-
-int pwrdm_set_logic_retst(struct powerdomain *pwrdm, u8 pwrst);
-int pwrdm_set_mem_onst(struct powerdomain *pwrdm, u8 bank, u8 pwrst);
-int pwrdm_set_mem_retst(struct powerdomain *pwrdm, u8 bank, u8 pwrst);
-
-int pwrdm_read_logic_pwrst(struct powerdomain *pwrdm);
-int pwrdm_read_prev_logic_pwrst(struct powerdomain *pwrdm);
-int pwrdm_read_logic_retst(struct powerdomain *pwrdm);
-int pwrdm_read_mem_pwrst(struct powerdomain *pwrdm, u8 bank);
-int pwrdm_read_prev_mem_pwrst(struct powerdomain *pwrdm, u8 bank);
-int pwrdm_read_mem_retst(struct powerdomain *pwrdm, u8 bank);
-
-int pwrdm_enable_hdwr_sar(struct powerdomain *pwrdm);
-int pwrdm_disable_hdwr_sar(struct powerdomain *pwrdm);
-bool pwrdm_has_hdwr_sar(struct powerdomain *pwrdm);
-
-int pwrdm_state_switch_nolock(struct powerdomain *pwrdm);
-int pwrdm_state_switch(struct powerdomain *pwrdm);
-int pwrdm_pre_transition(struct powerdomain *pwrdm);
-int pwrdm_post_transition(struct powerdomain *pwrdm);
-int pwrdm_get_context_loss_count(struct powerdomain *pwrdm);
-bool pwrdm_can_ever_lose_context(struct powerdomain *pwrdm);
-
-extern int omap_set_pwrdm_state(struct powerdomain *pwrdm, u8 state);
-
-extern void omap242x_powerdomains_init(void);
-extern void omap243x_powerdomains_init(void);
-extern void omap3xxx_powerdomains_init(void);
-extern void am33xx_powerdomains_init(void);
-extern void omap44xx_powerdomains_init(void);
-extern void omap54xx_powerdomains_init(void);
-extern void dra7xx_powerdomains_init(void);
-void am43xx_powerdomains_init(void);
-
-extern struct pwrdm_ops omap2_pwrdm_operations;
-extern struct pwrdm_ops omap3_pwrdm_operations;
-extern struct pwrdm_ops am33xx_pwrdm_operations;
-extern struct pwrdm_ops omap4_pwrdm_operations;
-
-/* Common Internal functions used across OMAP rev's */
-extern u32 omap2_pwrdm_get_mem_bank_onstate_mask(u8 bank);
-extern u32 omap2_pwrdm_get_mem_bank_retst_mask(u8 bank);
-extern u32 omap2_pwrdm_get_mem_bank_stst_mask(u8 bank);
-
-extern struct powerdomain wkup_omap2_pwrdm;
-extern struct powerdomain gfx_omap2_pwrdm;
-
-extern void pwrdm_lock(struct powerdomain *pwrdm);
-extern void pwrdm_unlock(struct powerdomain *pwrdm);
-
-#endif
diff --git a/arch/arm/mach-omap2/powerdomains2xxx_3xxx_data.c b/arch/arm/mach-omap2/powerdomains2xxx_3xxx_data.c
index 823bc4d..c3d2e8a 100644
--- a/arch/arm/mach-omap2/powerdomains2xxx_3xxx_data.c
+++ b/arch/arm/mach-omap2/powerdomains2xxx_3xxx_data.c
@@ -31,7 +31,7 @@
  * address offset is different between the C55 and C64 DSPs.
  */
 
-#include "powerdomain.h"
+#include <linux/power/omap/powerdomain.h>
 
 #include <linux/power/omap/prcm-common.h>
 #include <linux/power/omap/prm.h>
diff --git a/arch/arm/mach-omap2/powerdomains2xxx_3xxx_data.h b/arch/arm/mach-omap2/powerdomains2xxx_3xxx_data.h
index fa31166..b22c174 100644
--- a/arch/arm/mach-omap2/powerdomains2xxx_3xxx_data.h
+++ b/arch/arm/mach-omap2/powerdomains2xxx_3xxx_data.h
@@ -14,7 +14,7 @@
 #ifndef __ARCH_ARM_MACH_OMAP2_POWERDOMAINS2XXX_3XXX_DATA_H
 #define __ARCH_ARM_MACH_OMAP2_POWERDOMAINS2XXX_3XXX_DATA_H
 
-#include "powerdomain.h"
+#include <linux/power/omap/powerdomain.h>
 
 extern struct powerdomain gfx_omap2_pwrdm;
 extern struct powerdomain wkup_omap2_pwrdm;
diff --git a/arch/arm/mach-omap2/powerdomains2xxx_data.c b/arch/arm/mach-omap2/powerdomains2xxx_data.c
index 9506c0e..7fced02 100644
--- a/arch/arm/mach-omap2/powerdomains2xxx_data.c
+++ b/arch/arm/mach-omap2/powerdomains2xxx_data.c
@@ -15,7 +15,7 @@
 #include <linux/init.h>
 
 #include "soc.h"
-#include "powerdomain.h"
+#include <linux/power/omap/powerdomain.h>
 #include "powerdomains2xxx_3xxx_data.h"
 
 #include <linux/power/omap/prcm-common.h>
diff --git a/arch/arm/mach-omap2/powerdomains33xx_data.c b/arch/arm/mach-omap2/powerdomains33xx_data.c
index 0a7a5ca..719c541 100644
--- a/arch/arm/mach-omap2/powerdomains33xx_data.c
+++ b/arch/arm/mach-omap2/powerdomains33xx_data.c
@@ -16,7 +16,7 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 
-#include "powerdomain.h"
+#include <linux/power/omap/powerdomain.h>
 #include <linux/power/omap/prcm-common.h>
 #include "prm-regbits-33xx.h"
 #include "prm33xx.h"
diff --git a/arch/arm/mach-omap2/powerdomains3xxx_data.c b/arch/arm/mach-omap2/powerdomains3xxx_data.c
index be12876..01c43d4 100644
--- a/arch/arm/mach-omap2/powerdomains3xxx_data.c
+++ b/arch/arm/mach-omap2/powerdomains3xxx_data.c
@@ -16,7 +16,7 @@
 #include <linux/bug.h>
 
 #include "soc.h"
-#include "powerdomain.h"
+#include <linux/power/omap/powerdomain.h>
 #include "powerdomains2xxx_3xxx_data.h"
 #include <linux/power/omap/prcm-common.h>
 #include <linux/power/omap/prm2xxx_3xxx.h>
diff --git a/arch/arm/mach-omap2/powerdomains43xx_data.c b/arch/arm/mach-omap2/powerdomains43xx_data.c
index 91802f1..922d6ea 100644
--- a/arch/arm/mach-omap2/powerdomains43xx_data.c
+++ b/arch/arm/mach-omap2/powerdomains43xx_data.c
@@ -11,7 +11,7 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 
-#include "powerdomain.h"
+#include <linux/power/omap/powerdomain.h>
 
 #include <linux/power/omap/prcm-common.h>
 #include "prcm43xx.h"
diff --git a/arch/arm/mach-omap2/powerdomains44xx_data.c b/arch/arm/mach-omap2/powerdomains44xx_data.c
index 793c611..290d68d 100644
--- a/arch/arm/mach-omap2/powerdomains44xx_data.c
+++ b/arch/arm/mach-omap2/powerdomains44xx_data.c
@@ -22,7 +22,7 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 
-#include "powerdomain.h"
+#include <linux/power/omap/powerdomain.h>
 
 #include <linux/power/omap/prcm-common.h>
 #include <linux/power/omap/prcm44xx.h>
diff --git a/arch/arm/mach-omap2/powerdomains54xx_data.c b/arch/arm/mach-omap2/powerdomains54xx_data.c
index 37017f2..c24a991 100644
--- a/arch/arm/mach-omap2/powerdomains54xx_data.c
+++ b/arch/arm/mach-omap2/powerdomains54xx_data.c
@@ -21,7 +21,7 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 
-#include "powerdomain.h"
+#include <linux/power/omap/powerdomain.h>
 
 #include <linux/power/omap/prcm-common.h>
 #include <linux/power/omap/prcm44xx.h>
diff --git a/arch/arm/mach-omap2/powerdomains7xx_data.c b/arch/arm/mach-omap2/powerdomains7xx_data.c
index cedc84b..35f6ca1 100644
--- a/arch/arm/mach-omap2/powerdomains7xx_data.c
+++ b/arch/arm/mach-omap2/powerdomains7xx_data.c
@@ -23,7 +23,7 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 
-#include "powerdomain.h"
+#include <linux/power/omap/powerdomain.h>
 
 #include <linux/power/omap/prcm-common.h>
 #include <linux/power/omap/prcm44xx.h>
diff --git a/arch/arm/mach-omap2/prm2xxx.c b/arch/arm/mach-omap2/prm2xxx.c
index 7969cb9..735ee33 100644
--- a/arch/arm/mach-omap2/prm2xxx.c
+++ b/arch/arm/mach-omap2/prm2xxx.c
@@ -18,7 +18,7 @@
 #include <linux/io.h>
 #include <linux/irq.h>
 
-#include "powerdomain.h"
+#include <linux/power/omap/powerdomain.h>
 #include <linux/power/omap/clockdomain.h>
 #include <linux/power/omap/prm2xxx.h>
 #include "prm2xxx_3xxx_private.h"
diff --git a/arch/arm/mach-omap2/prm2xxx_3xxx.c b/arch/arm/mach-omap2/prm2xxx_3xxx.c
index a25d1d0..27828d0 100644
--- a/arch/arm/mach-omap2/prm2xxx_3xxx.c
+++ b/arch/arm/mach-omap2/prm2xxx_3xxx.c
@@ -16,7 +16,7 @@
 #include <linux/err.h>
 #include <linux/io.h>
 
-#include "powerdomain.h"
+#include <linux/power/omap/powerdomain.h>
 #include "prm2xxx_3xxx_private.h"
 #include <linux/power/omap/clockdomain.h>
 
diff --git a/arch/arm/mach-omap2/prm2xxx_3xxx_private.h b/arch/arm/mach-omap2/prm2xxx_3xxx_private.h
index 5d6861a..52537fd 100644
--- a/arch/arm/mach-omap2/prm2xxx_3xxx_private.h
+++ b/arch/arm/mach-omap2/prm2xxx_3xxx_private.h
@@ -23,7 +23,7 @@
 #ifndef __ASSEMBLER__
 
 #include <linux/io.h>
-#include "powerdomain.h"
+#include <linux/power/omap/powerdomain.h>
 
 /* Power/reset management domain register get/set */
 static inline u32 omap2_prm_read_mod_reg(s16 module, u16 idx)
diff --git a/arch/arm/mach-omap2/prm33xx.c b/arch/arm/mach-omap2/prm33xx.c
index b5864c9..05356a3 100644
--- a/arch/arm/mach-omap2/prm33xx.c
+++ b/arch/arm/mach-omap2/prm33xx.c
@@ -20,7 +20,7 @@
 #include <linux/io.h>
 #include <linux/power/omap/prm33xx.h>
 
-#include "powerdomain.h"
+#include <linux/power/omap/powerdomain.h>
 #include <linux/power/omap/prm.h>
 
 #define AM33XX_LASTPOWERSTATEENTERED_SHIFT	24
diff --git a/arch/arm/mach-omap2/prm3xxx.c b/arch/arm/mach-omap2/prm3xxx.c
index e7d409c..be4c3ef 100644
--- a/arch/arm/mach-omap2/prm3xxx.c
+++ b/arch/arm/mach-omap2/prm3xxx.c
@@ -18,7 +18,7 @@
 #include <linux/io.h>
 #include <linux/irq.h>
 
-#include "powerdomain.h"
+#include <linux/power/omap/powerdomain.h>
 #include <linux/power/omap/prm3xxx.h>
 #include "prm2xxx_3xxx_private.h"
 #include "cm2xxx_3xxx_private.h"
diff --git a/arch/arm/mach-omap2/prm44xx.c b/arch/arm/mach-omap2/prm44xx.c
index 69a974b..ab04ce8 100644
--- a/arch/arm/mach-omap2/prm44xx.c
+++ b/arch/arm/mach-omap2/prm44xx.c
@@ -24,7 +24,7 @@
 #include <linux/power/omap/prm7xx.h>
 #include <linux/power/omap/prcm44xx.h>
 #include "prminst44xx_private.h"
-#include "powerdomain.h"
+#include <linux/power/omap/powerdomain.h>
 #include <linux/power/omap/prm.h>
 #include <linux/power/omap/prcm-common.h>
 #include <linux/power/omap/prm44xx_54xx.h>
diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
index 74044aa..f10ca44 100644
--- a/arch/arm/mach-omap2/timer.c
+++ b/arch/arm/mach-omap2/timer.c
@@ -54,7 +54,7 @@
 
 #include "soc.h"
 #include "common.h"
-#include "powerdomain.h"
+#include <linux/power/omap/powerdomain.h>
 #include "omap-secure.h"
 
 #define REALTIME_COUNTER_BASE				0x48243200
diff --git a/arch/arm/mach-omap2/voltage.c b/arch/arm/mach-omap2/voltage.c
index b707328..17df5e7 100644
--- a/arch/arm/mach-omap2/voltage.c
+++ b/arch/arm/mach-omap2/voltage.c
@@ -36,7 +36,7 @@
 #include "control.h"
 
 #include "voltage.h"
-#include "powerdomain.h"
+#include <linux/power/omap/powerdomain.h>
 
 #include "vc.h"
 #include "vp.h"
diff --git a/include/linux/power/omap/powerdomain.h b/include/linux/power/omap/powerdomain.h
new file mode 100644
index 0000000..27f2750
--- /dev/null
+++ b/include/linux/power/omap/powerdomain.h
@@ -0,0 +1,280 @@
+/*
+ * OMAP2/3/4 powerdomain control
+ *
+ * Copyright (C) 2007-2008, 2010 Texas Instruments, Inc.
+ * Copyright (C) 2007-2011 Nokia Corporation
+ *
+ * Paul Walmsley
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * XXX This should be moved to the mach-omap2/ directory at the earliest
+ * opportunity.
+ */
+
+#ifndef __LINUX_POWER_OMAP_POWERDOMAIN_H
+#define __LINUX_POWER_OMAP_POWERDOMAIN_H
+
+#include <linux/types.h>
+#include <linux/list.h>
+#include <linux/spinlock.h>
+
+/* Powerdomain basic power states */
+#define PWRDM_POWER_OFF		0x0
+#define PWRDM_POWER_RET		0x1
+#define PWRDM_POWER_INACTIVE	0x2
+#define PWRDM_POWER_ON		0x3
+
+#define PWRDM_MAX_PWRSTS	4
+
+/* Powerdomain allowable state bitfields */
+#define PWRSTS_ON		(1 << PWRDM_POWER_ON)
+#define PWRSTS_INACTIVE		(1 << PWRDM_POWER_INACTIVE)
+#define PWRSTS_RET		(1 << PWRDM_POWER_RET)
+#define PWRSTS_OFF		(1 << PWRDM_POWER_OFF)
+
+#define PWRSTS_OFF_ON		(PWRSTS_OFF | PWRSTS_ON)
+#define PWRSTS_OFF_RET		(PWRSTS_OFF | PWRSTS_RET)
+#define PWRSTS_RET_ON		(PWRSTS_RET | PWRSTS_ON)
+#define PWRSTS_OFF_RET_ON	(PWRSTS_OFF_RET | PWRSTS_ON)
+
+
+/*
+ * Powerdomain flags (struct powerdomain.flags)
+ *
+ * PWRDM_HAS_HDWR_SAR - powerdomain has hardware save-and-restore support
+ *
+ * PWRDM_HAS_MPU_QUIRK - MPU pwr domain has MEM bank 0 bits in MEM
+ * bank 1 position. This is true for OMAP3430
+ *
+ * PWRDM_HAS_LOWPOWERSTATECHANGE - can transition from a sleep state
+ * to a lower sleep state without waking up the powerdomain
+ */
+#define PWRDM_HAS_HDWR_SAR		BIT(0)
+#define PWRDM_HAS_MPU_QUIRK		BIT(1)
+#define PWRDM_HAS_LOWPOWERSTATECHANGE	BIT(2)
+
+/*
+ * Number of memory banks that are power-controllable.	On OMAP4430, the
+ * maximum is 5.
+ */
+#define PWRDM_MAX_MEM_BANKS	5
+
+/*
+ * Maximum number of clockdomains that can be associated with a powerdomain.
+ * PER powerdomain on AM33XX is the worst case
+ */
+#define PWRDM_MAX_CLKDMS	11
+
+/* XXX A completely arbitrary number. What is reasonable here? */
+#define PWRDM_TRANSITION_BAILOUT 100000
+
+struct clockdomain;
+struct powerdomain;
+struct voltagedomain;
+
+/**
+ * struct powerdomain - OMAP powerdomain
+ * @name: Powerdomain name
+ * @voltdm: voltagedomain containing this powerdomain
+ * @prcm_offs: the address offset from CM_BASE/PRM_BASE
+ * @prcm_partition: (OMAP4 only) the PRCM partition ID containing @prcm_offs
+ * @pwrsts: Possible powerdomain power states
+ * @pwrsts_logic_ret: Possible logic power states when pwrdm in RETENTION
+ * @flags: Powerdomain flags
+ * @banks: Number of software-controllable memory banks in this powerdomain
+ * @pwrsts_mem_ret: Possible memory bank pwrstates when pwrdm in RETENTION
+ * @pwrsts_mem_on: Possible memory bank pwrstates when pwrdm in ON
+ * @pwrdm_clkdms: Clockdomains in this powerdomain
+ * @node: list_head linking all powerdomains
+ * @voltdm_node: list_head linking all powerdomains in a voltagedomain
+ * @pwrstctrl_offs: (AM33XX only) XXX_PWRSTCTRL reg offset from prcm_offs
+ * @pwrstst_offs: (AM33XX only) XXX_PWRSTST reg offset from prcm_offs
+ * @logicretstate_mask: (AM33XX only) mask for logic retention bitfield
+ *	in @pwrstctrl_offs
+ * @mem_on_mask: (AM33XX only) mask for mem on bitfield in @pwrstctrl_offs
+ * @mem_ret_mask: (AM33XX only) mask for mem ret bitfield in @pwrstctrl_offs
+ * @mem_pwrst_mask: (AM33XX only) mask for mem state bitfield in @pwrstst_offs
+ * @mem_retst_mask: (AM33XX only) mask for mem retention state bitfield
+ *	in @pwrstctrl_offs
+ * @state:
+ * @state_counter:
+ * @timer:
+ * @state_timer:
+ * @_lock: spinlock used to serialize powerdomain and some clockdomain ops
+ * @_lock_flags: stored flags when @_lock is taken
+ *
+ * @prcm_partition possible values are defined in mach-omap2/prcm44xx.h.
+ */
+struct powerdomain {
+	const char *name;
+	union {
+		const char *name;
+		struct voltagedomain *ptr;
+	} voltdm;
+	const s16 prcm_offs;
+	const u8 pwrsts;
+	const u8 pwrsts_logic_ret;
+	const u8 flags;
+	const u8 banks;
+	const u8 pwrsts_mem_ret[PWRDM_MAX_MEM_BANKS];
+	const u8 pwrsts_mem_on[PWRDM_MAX_MEM_BANKS];
+	const u8 prcm_partition;
+	struct clockdomain *pwrdm_clkdms[PWRDM_MAX_CLKDMS];
+	struct list_head node;
+	struct list_head voltdm_node;
+	int state;
+	unsigned state_counter[PWRDM_MAX_PWRSTS];
+	unsigned ret_logic_off_counter;
+	unsigned ret_mem_off_counter[PWRDM_MAX_MEM_BANKS];
+	spinlock_t _lock;
+	unsigned long _lock_flags;
+	const u8 pwrstctrl_offs;
+	const u8 pwrstst_offs;
+	const u32 logicretstate_mask;
+	const u32 mem_on_mask[PWRDM_MAX_MEM_BANKS];
+	const u32 mem_ret_mask[PWRDM_MAX_MEM_BANKS];
+	const u32 mem_pwrst_mask[PWRDM_MAX_MEM_BANKS];
+	const u32 mem_retst_mask[PWRDM_MAX_MEM_BANKS];
+
+#ifdef CONFIG_PM_DEBUG
+	s64 timer;
+	s64 state_timer[PWRDM_MAX_PWRSTS];
+#endif
+};
+
+/**
+ * struct pwrdm_ops - Arch specific function implementations
+ * @pwrdm_set_next_pwrst: Set the target power state for a pd
+ * @pwrdm_read_next_pwrst: Read the target power state set for a pd
+ * @pwrdm_read_pwrst: Read the current power state of a pd
+ * @pwrdm_read_prev_pwrst: Read the prev power state entered by the pd
+ * @pwrdm_set_logic_retst: Set the logic state in RET for a pd
+ * @pwrdm_set_mem_onst: Set the Memory state in ON for a pd
+ * @pwrdm_set_mem_retst: Set the Memory state in RET for a pd
+ * @pwrdm_read_logic_pwrst: Read the current logic state of a pd
+ * @pwrdm_read_prev_logic_pwrst: Read the previous logic state entered by a pd
+ * @pwrdm_read_logic_retst: Read the logic state in RET for a pd
+ * @pwrdm_read_mem_pwrst: Read the current memory state of a pd
+ * @pwrdm_read_prev_mem_pwrst: Read the previous memory state entered by a pd
+ * @pwrdm_read_mem_retst: Read the memory state in RET for a pd
+ * @pwrdm_clear_all_prev_pwrst: Clear all previous power states logged for a pd
+ * @pwrdm_enable_hdwr_sar: Enable Hardware Save-Restore feature for the pd
+ * @pwrdm_disable_hdwr_sar: Disable Hardware Save-Restore feature for a pd
+ * @pwrdm_set_lowpwrstchange: Enable pd transitions from a shallow to deep sleep
+ * @pwrdm_wait_transition: Wait for a pd state transition to complete
+ * @pwrdm_has_voltdm: Check if a voltdm association is needed
+ *
+ * Regarding @pwrdm_set_lowpwrstchange: On the OMAP2 and 3-family
+ * chips, a powerdomain's power state is not allowed to directly
+ * transition from one low-power state (e.g., CSWR) to another
+ * low-power state (e.g., OFF) without first waking up the
+ * powerdomain.  This wastes energy.  So OMAP4 chips support the
+ * ability to transition a powerdomain power state directly from one
+ * low-power state to another.  The function pointed to by
+ * @pwrdm_set_lowpwrstchange is intended to configure the OMAP4
+ * hardware powerdomain state machine to enable this feature.
+ */
+struct pwrdm_ops {
+	int	(*pwrdm_set_next_pwrst)(struct powerdomain *pwrdm, u8 pwrst);
+	int	(*pwrdm_read_next_pwrst)(struct powerdomain *pwrdm);
+	int	(*pwrdm_read_pwrst)(struct powerdomain *pwrdm);
+	int	(*pwrdm_read_prev_pwrst)(struct powerdomain *pwrdm);
+	int	(*pwrdm_set_logic_retst)(struct powerdomain *pwrdm, u8 pwrst);
+	int	(*pwrdm_set_mem_onst)(struct powerdomain *pwrdm, u8 bank,
+				      u8 pwrst);
+	int	(*pwrdm_set_mem_retst)(struct powerdomain *pwrdm, u8 bank,
+				       u8 pwrst);
+	int	(*pwrdm_read_logic_pwrst)(struct powerdomain *pwrdm);
+	int	(*pwrdm_read_prev_logic_pwrst)(struct powerdomain *pwrdm);
+	int	(*pwrdm_read_logic_retst)(struct powerdomain *pwrdm);
+	int	(*pwrdm_read_mem_pwrst)(struct powerdomain *pwrdm, u8 bank);
+	int	(*pwrdm_read_prev_mem_pwrst)(struct powerdomain *pwrdm,
+					     u8 bank);
+	int	(*pwrdm_read_mem_retst)(struct powerdomain *pwrdm, u8 bank);
+	int	(*pwrdm_clear_all_prev_pwrst)(struct powerdomain *pwrdm);
+	int	(*pwrdm_enable_hdwr_sar)(struct powerdomain *pwrdm);
+	int	(*pwrdm_disable_hdwr_sar)(struct powerdomain *pwrdm);
+	int	(*pwrdm_set_lowpwrstchange)(struct powerdomain *pwrdm);
+	int	(*pwrdm_wait_transition)(struct powerdomain *pwrdm);
+	int	(*pwrdm_has_voltdm)(void);
+};
+
+int pwrdm_register_platform_funcs(struct pwrdm_ops *custom_funcs);
+int pwrdm_register_pwrdms(struct powerdomain **pwrdm_list);
+int pwrdm_complete_init(void);
+
+struct powerdomain *pwrdm_lookup(const char *name);
+
+int pwrdm_for_each(int (*fn)(struct powerdomain *pwrdm, void *user),
+			void *user);
+int pwrdm_for_each_nolock(int (*fn)(struct powerdomain *pwrdm, void *user),
+			void *user);
+
+int pwrdm_add_clkdm(struct powerdomain *pwrdm, struct clockdomain *clkdm);
+int pwrdm_del_clkdm(struct powerdomain *pwrdm, struct clockdomain *clkdm);
+int pwrdm_for_each_clkdm(struct powerdomain *pwrdm,
+			 int (*fn)(struct powerdomain *pwrdm,
+				   struct clockdomain *clkdm));
+struct voltagedomain *pwrdm_get_voltdm(struct powerdomain *pwrdm);
+
+int pwrdm_get_mem_bank_count(struct powerdomain *pwrdm);
+
+int pwrdm_set_next_pwrst(struct powerdomain *pwrdm, u8 pwrst);
+int pwrdm_read_next_pwrst(struct powerdomain *pwrdm);
+int pwrdm_read_pwrst(struct powerdomain *pwrdm);
+int pwrdm_read_prev_pwrst(struct powerdomain *pwrdm);
+int pwrdm_clear_all_prev_pwrst(struct powerdomain *pwrdm);
+
+int pwrdm_set_logic_retst(struct powerdomain *pwrdm, u8 pwrst);
+int pwrdm_set_mem_onst(struct powerdomain *pwrdm, u8 bank, u8 pwrst);
+int pwrdm_set_mem_retst(struct powerdomain *pwrdm, u8 bank, u8 pwrst);
+
+int pwrdm_read_logic_pwrst(struct powerdomain *pwrdm);
+int pwrdm_read_prev_logic_pwrst(struct powerdomain *pwrdm);
+int pwrdm_read_logic_retst(struct powerdomain *pwrdm);
+int pwrdm_read_mem_pwrst(struct powerdomain *pwrdm, u8 bank);
+int pwrdm_read_prev_mem_pwrst(struct powerdomain *pwrdm, u8 bank);
+int pwrdm_read_mem_retst(struct powerdomain *pwrdm, u8 bank);
+
+int pwrdm_enable_hdwr_sar(struct powerdomain *pwrdm);
+int pwrdm_disable_hdwr_sar(struct powerdomain *pwrdm);
+bool pwrdm_has_hdwr_sar(struct powerdomain *pwrdm);
+
+int pwrdm_state_switch_nolock(struct powerdomain *pwrdm);
+int pwrdm_state_switch(struct powerdomain *pwrdm);
+int pwrdm_pre_transition(struct powerdomain *pwrdm);
+int pwrdm_post_transition(struct powerdomain *pwrdm);
+int pwrdm_get_context_loss_count(struct powerdomain *pwrdm);
+bool pwrdm_can_ever_lose_context(struct powerdomain *pwrdm);
+
+int omap_set_pwrdm_state(struct powerdomain *pwrdm, u8 state);
+
+void omap242x_powerdomains_init(void);
+void omap243x_powerdomains_init(void);
+void omap3xxx_powerdomains_init(void);
+void am33xx_powerdomains_init(void);
+void omap44xx_powerdomains_init(void);
+void omap54xx_powerdomains_init(void);
+void dra7xx_powerdomains_init(void);
+void am43xx_powerdomains_init(void);
+
+extern struct pwrdm_ops omap2_pwrdm_operations;
+extern struct pwrdm_ops omap3_pwrdm_operations;
+extern struct pwrdm_ops am33xx_pwrdm_operations;
+extern struct pwrdm_ops omap4_pwrdm_operations;
+
+/* Common Internal functions used across OMAP rev's */
+u32 omap2_pwrdm_get_mem_bank_onstate_mask(u8 bank);
+u32 omap2_pwrdm_get_mem_bank_retst_mask(u8 bank);
+u32 omap2_pwrdm_get_mem_bank_stst_mask(u8 bank);
+
+extern struct powerdomain wkup_omap2_pwrdm;
+extern struct powerdomain gfx_omap2_pwrdm;
+
+void pwrdm_lock(struct powerdomain *pwrdm);
+void pwrdm_unlock(struct powerdomain *pwrdm);
+
+#endif
-- 
1.7.9.5

