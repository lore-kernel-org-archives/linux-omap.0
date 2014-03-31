From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 50/55] ARM: OMAP2+: clockdomain: move clockdomain.h header to public location
Date: Mon, 31 Mar 2014 18:16:29 +0300
Message-ID: <1396278994-12624-51-git-send-email-t-kristo@ti.com>
References: <1396278994-12624-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:39223 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753970AbaCaPTB (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 31 Mar 2014 11:19:01 -0400
In-Reply-To: <1396278994-12624-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, tony@atomide.com, paul@pwsan.com
Cc: linux-arm-kernel@lists.infradead.org

This file needs to be accessible from the PRCM core and mach-omap2 board
support code.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/clock.c                      |    2 +-
 arch/arm/mach-omap2/clockdomain.c                |    3 +-
 arch/arm/mach-omap2/clockdomain.h                |  237 ---------------------
 arch/arm/mach-omap2/clockdomains2420_data.c      |    2 +-
 arch/arm/mach-omap2/clockdomains2430_data.c      |    2 +-
 arch/arm/mach-omap2/clockdomains2xxx_3xxx_data.c |    2 +-
 arch/arm/mach-omap2/clockdomains33xx_data.c      |    2 +-
 arch/arm/mach-omap2/clockdomains3xxx_data.c      |    2 +-
 arch/arm/mach-omap2/clockdomains43xx_data.c      |    2 +-
 arch/arm/mach-omap2/clockdomains44xx_data.c      |    2 +-
 arch/arm/mach-omap2/clockdomains54xx_data.c      |    2 +-
 arch/arm/mach-omap2/clockdomains7xx_data.c       |    2 +-
 arch/arm/mach-omap2/cm2xxx.c                     |    3 +-
 arch/arm/mach-omap2/cm33xx.c                     |    2 +-
 arch/arm/mach-omap2/cm3xxx.c                     |    3 +-
 arch/arm/mach-omap2/cminst44xx.c                 |    2 +-
 arch/arm/mach-omap2/cpuidle34xx.c                |    2 +-
 arch/arm/mach-omap2/cpuidle44xx.c                |    2 +-
 arch/arm/mach-omap2/dpll3xxx.c                   |    2 +-
 arch/arm/mach-omap2/io.c                         |    2 +-
 arch/arm/mach-omap2/omap-smp.c                   |    2 +-
 arch/arm/mach-omap2/omap_hwmod.c                 |    2 +-
 arch/arm/mach-omap2/pm-debug.c                   |    2 +-
 arch/arm/mach-omap2/pm.c                         |    2 +-
 arch/arm/mach-omap2/pm24xx.c                     |    2 +-
 arch/arm/mach-omap2/pm34xx.c                     |    2 +-
 arch/arm/mach-omap2/pm44xx.c                     |    2 +-
 arch/arm/mach-omap2/powerdomain.c                |    2 +-
 arch/arm/mach-omap2/prm2xxx.c                    |    2 +-
 arch/arm/mach-omap2/prm2xxx_3xxx.c               |    2 +-
 include/linux/power/omap/clockdomain.h           |  242 ++++++++++++++++++++++
 31 files changed, 274 insertions(+), 266 deletions(-)
 delete mode 100644 arch/arm/mach-omap2/clockdomain.h
 create mode 100644 include/linux/power/omap/clockdomain.h

diff --git a/arch/arm/mach-omap2/clock.c b/arch/arm/mach-omap2/clock.c
index 4276c46..035f413 100644
--- a/arch/arm/mach-omap2/clock.c
+++ b/arch/arm/mach-omap2/clock.c
@@ -29,7 +29,7 @@
 #include <trace/events/power.h>
 
 #include "soc.h"
-#include "clockdomain.h"
+#include <linux/power/omap/clockdomain.h>
 #include "clock.h"
 #include <linux/power/omap/cm.h>
 #include "cm2xxx.h"
diff --git a/arch/arm/mach-omap2/clockdomain.c b/arch/arm/mach-omap2/clockdomain.c
index 9a59efb..298fb05 100644
--- a/arch/arm/mach-omap2/clockdomain.c
+++ b/arch/arm/mach-omap2/clockdomain.c
@@ -29,7 +29,8 @@
 #include <linux/bitops.h>
 
 #include "soc.h"
-#include "clockdomain.h"
+#include <linux/power/omap/clockdomain.h>
+#include "powerdomain.h"
 
 /* clkdm_list contains all registered struct clockdomains */
 static LIST_HEAD(clkdm_list);
diff --git a/arch/arm/mach-omap2/clockdomain.h b/arch/arm/mach-omap2/clockdomain.h
deleted file mode 100644
index 4322a28..0000000
--- a/arch/arm/mach-omap2/clockdomain.h
+++ /dev/null
@@ -1,237 +0,0 @@
-/*
- * OMAP2/3 clockdomain framework functions
- *
- * Copyright (C) 2008, 2012 Texas Instruments, Inc.
- * Copyright (C) 2008-2011 Nokia Corporation
- *
- * Paul Walmsley
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-#ifndef __ARCH_ARM_MACH_OMAP2_CLOCKDOMAIN_H
-#define __ARCH_ARM_MACH_OMAP2_CLOCKDOMAIN_H
-
-#include <linux/init.h>
-
-#include "powerdomain.h"
-
-/*
- * Clockdomain flags
- *
- * XXX Document CLKDM_CAN_* flags
- *
- * CLKDM_NO_AUTODEPS: Prevent "autodeps" from being added/removed from this
- *     clockdomain.  (Currently, this applies to OMAP3 clockdomains only.)
- * CLKDM_ACTIVE_WITH_MPU: The PRCM guarantees that this clockdomain is
- *     active whenever the MPU is active.  True for interconnects and
- *     the WKUP clockdomains.
- * CLKDM_MISSING_IDLE_REPORTING: The idle status of the IP blocks and
- *     clocks inside this clockdomain are not taken into account by
- *     the PRCM when determining whether the clockdomain is idle.
- *     Without this flag, if the clockdomain is set to
- *     hardware-supervised idle mode, the PRCM may transition the
- *     enclosing powerdomain to a low power state, even when devices
- *     inside the clockdomain and powerdomain are in use.  (An example
- *     of such a clockdomain is the EMU clockdomain on OMAP3/4.)  If
- *     this flag is set, and the clockdomain does not support the
- *     force-sleep mode, then the HW_AUTO mode will be used to put the
- *     clockdomain to sleep.  Similarly, if the clockdomain supports
- *     the force-wakeup mode, then it will be used whenever a clock or
- *     IP block inside the clockdomain is active, rather than the
- *     HW_AUTO mode.
- */
-#define CLKDM_CAN_FORCE_SLEEP			(1 << 0)
-#define CLKDM_CAN_FORCE_WAKEUP			(1 << 1)
-#define CLKDM_CAN_ENABLE_AUTO			(1 << 2)
-#define CLKDM_CAN_DISABLE_AUTO			(1 << 3)
-#define CLKDM_NO_AUTODEPS			(1 << 4)
-#define CLKDM_ACTIVE_WITH_MPU			(1 << 5)
-#define CLKDM_MISSING_IDLE_REPORTING		(1 << 6)
-
-#define CLKDM_CAN_HWSUP		(CLKDM_CAN_ENABLE_AUTO | CLKDM_CAN_DISABLE_AUTO)
-#define CLKDM_CAN_SWSUP		(CLKDM_CAN_FORCE_SLEEP | CLKDM_CAN_FORCE_WAKEUP)
-#define CLKDM_CAN_HWSUP_SWSUP	(CLKDM_CAN_SWSUP | CLKDM_CAN_HWSUP)
-
-/**
- * struct clkdm_autodep - clkdm deps to add when entering/exiting hwsup mode
- * @clkdm: clockdomain to add wkdep+sleepdep on - set name member only
- *
- * A clockdomain that should have wkdeps and sleepdeps added when a
- * clockdomain should stay active in hwsup mode; and conversely,
- * removed when the clockdomain should be allowed to go inactive in
- * hwsup mode.
- *
- * Autodeps are deprecated and should be removed after
- * omap_hwmod-based fine-grained module idle control is added.
- */
-struct clkdm_autodep {
-	union {
-		const char *name;
-		struct clockdomain *ptr;
-	} clkdm;
-};
-
-/**
- * struct clkdm_dep - encode dependencies between clockdomains
- * @clkdm_name: clockdomain name
- * @clkdm: pointer to the struct clockdomain of @clkdm_name
- * @wkdep_usecount: Number of wakeup dependencies causing this clkdm to wake
- * @sleepdep_usecount: Number of sleep deps that could prevent clkdm from idle
- *
- * Statically defined.  @clkdm is resolved from @clkdm_name at runtime and
- * should not be pre-initialized.
- *
- * XXX Should also include hardware (fixed) dependencies.
- */
-struct clkdm_dep {
-	const char *clkdm_name;
-	struct clockdomain *clkdm;
-	s16 wkdep_usecount;
-	s16 sleepdep_usecount;
-};
-
-/* Possible flags for struct clockdomain._flags */
-#define _CLKDM_FLAG_HWSUP_ENABLED		BIT(0)
-
-struct omap_hwmod;
-struct clk;
-
-/**
- * struct clockdomain - OMAP clockdomain
- * @name: clockdomain name
- * @pwrdm: powerdomain containing this clockdomain
- * @clktrctrl_reg: CLKSTCTRL reg for the given clock domain
- * @clktrctrl_mask: CLKTRCTRL/AUTOSTATE field mask in CM_CLKSTCTRL reg
- * @flags: Clockdomain capability flags
- * @_flags: Flags for use only by internal clockdomain code
- * @dep_bit: Bit shift of this clockdomain's PM_WKDEP/CM_SLEEPDEP bit
- * @prcm_partition: (OMAP4 only) PRCM partition ID for this clkdm's registers
- * @cm_inst: (OMAP4 only) CM instance register offset
- * @clkdm_offs: (OMAP4 only) CM clockdomain register offset
- * @wkdep_srcs: Clockdomains that can be told to wake this powerdomain up
- * @sleepdep_srcs: Clockdomains that can be told to keep this clkdm from inact
- * @usecount: Usecount tracking
- * @node: list_head to link all clockdomains together
- *
- * @prcm_partition should be a macro from mach-omap2/prcm44xx.h (OMAP4 only)
- * @cm_inst should be a macro ending in _INST from the OMAP4 CM instance
- *     definitions (OMAP4 only)
- * @clkdm_offs should be a macro ending in _CDOFFS from the OMAP4 CM instance
- *     definitions (OMAP4 only)
- */
-struct clockdomain {
-	const char *name;
-	union {
-		const char *name;
-		struct powerdomain *ptr;
-	} pwrdm;
-	const u16 clktrctrl_mask;
-	const u8 flags;
-	u8 _flags;
-	const u8 dep_bit;
-	const u8 prcm_partition;
-	const u16 cm_inst;
-	const u16 clkdm_offs;
-	struct clkdm_dep *wkdep_srcs;
-	struct clkdm_dep *sleepdep_srcs;
-	int usecount;
-	struct list_head node;
-};
-
-/**
- * struct clkdm_ops - Arch specific function implementations
- * @clkdm_add_wkdep: Add a wakeup dependency between clk domains
- * @clkdm_del_wkdep: Delete a wakeup dependency between clk domains
- * @clkdm_read_wkdep: Read wakeup dependency state between clk domains
- * @clkdm_clear_all_wkdeps: Remove all wakeup dependencies from the clk domain
- * @clkdm_add_sleepdep: Add a sleep dependency between clk domains
- * @clkdm_del_sleepdep: Delete a sleep dependency between clk domains
- * @clkdm_read_sleepdep: Read sleep dependency state between clk domains
- * @clkdm_clear_all_sleepdeps: Remove all sleep dependencies from the clk domain
- * @clkdm_sleep: Force a clockdomain to sleep
- * @clkdm_wakeup: Force a clockdomain to wakeup
- * @clkdm_allow_idle: Enable hw supervised idle transitions for clock domain
- * @clkdm_deny_idle: Disable hw supervised idle transitions for clock domain
- * @clkdm_clk_enable: Put the clkdm in right state for a clock enable
- * @clkdm_clk_disable: Put the clkdm in right state for a clock disable
- */
-struct clkdm_ops {
-	int	(*clkdm_add_wkdep)(struct clockdomain *clkdm1, struct clockdomain *clkdm2);
-	int	(*clkdm_del_wkdep)(struct clockdomain *clkdm1, struct clockdomain *clkdm2);
-	int	(*clkdm_read_wkdep)(struct clockdomain *clkdm1, struct clockdomain *clkdm2);
-	int	(*clkdm_clear_all_wkdeps)(struct clockdomain *clkdm);
-	int	(*clkdm_add_sleepdep)(struct clockdomain *clkdm1, struct clockdomain *clkdm2);
-	int	(*clkdm_del_sleepdep)(struct clockdomain *clkdm1, struct clockdomain *clkdm2);
-	int	(*clkdm_read_sleepdep)(struct clockdomain *clkdm1, struct clockdomain *clkdm2);
-	int	(*clkdm_clear_all_sleepdeps)(struct clockdomain *clkdm);
-	int	(*clkdm_sleep)(struct clockdomain *clkdm);
-	int	(*clkdm_wakeup)(struct clockdomain *clkdm);
-	void	(*clkdm_allow_idle)(struct clockdomain *clkdm);
-	void	(*clkdm_deny_idle)(struct clockdomain *clkdm);
-	int	(*clkdm_clk_enable)(struct clockdomain *clkdm);
-	int	(*clkdm_clk_disable)(struct clockdomain *clkdm);
-};
-
-int clkdm_register_platform_funcs(struct clkdm_ops *co);
-int clkdm_register_autodeps(struct clkdm_autodep *ia);
-int clkdm_register_clkdms(struct clockdomain **c);
-int clkdm_complete_init(void);
-
-struct clockdomain *clkdm_lookup(const char *name);
-
-int clkdm_for_each(int (*fn)(struct clockdomain *clkdm, void *user),
-			void *user);
-struct powerdomain *clkdm_get_pwrdm(struct clockdomain *clkdm);
-
-int clkdm_add_wkdep(struct clockdomain *clkdm1, struct clockdomain *clkdm2);
-int clkdm_del_wkdep(struct clockdomain *clkdm1, struct clockdomain *clkdm2);
-int clkdm_read_wkdep(struct clockdomain *clkdm1, struct clockdomain *clkdm2);
-int clkdm_clear_all_wkdeps(struct clockdomain *clkdm);
-int clkdm_add_sleepdep(struct clockdomain *clkdm1, struct clockdomain *clkdm2);
-int clkdm_del_sleepdep(struct clockdomain *clkdm1, struct clockdomain *clkdm2);
-int clkdm_read_sleepdep(struct clockdomain *clkdm1, struct clockdomain *clkdm2);
-int clkdm_clear_all_sleepdeps(struct clockdomain *clkdm);
-
-void clkdm_allow_idle_nolock(struct clockdomain *clkdm);
-void clkdm_allow_idle(struct clockdomain *clkdm);
-void clkdm_deny_idle_nolock(struct clockdomain *clkdm);
-void clkdm_deny_idle(struct clockdomain *clkdm);
-bool clkdm_in_hwsup(struct clockdomain *clkdm);
-bool clkdm_missing_idle_reporting(struct clockdomain *clkdm);
-
-int clkdm_wakeup_nolock(struct clockdomain *clkdm);
-int clkdm_wakeup(struct clockdomain *clkdm);
-int clkdm_sleep_nolock(struct clockdomain *clkdm);
-int clkdm_sleep(struct clockdomain *clkdm);
-
-int clkdm_clk_enable(struct clockdomain *clkdm, struct clk *clk);
-int clkdm_clk_disable(struct clockdomain *clkdm, struct clk *clk);
-int clkdm_hwmod_enable(struct clockdomain *clkdm, struct omap_hwmod *oh);
-int clkdm_hwmod_disable(struct clockdomain *clkdm, struct omap_hwmod *oh);
-
-extern void __init omap242x_clockdomains_init(void);
-extern void __init omap243x_clockdomains_init(void);
-extern void __init omap3xxx_clockdomains_init(void);
-extern void __init am33xx_clockdomains_init(void);
-extern void __init omap44xx_clockdomains_init(void);
-extern void __init omap54xx_clockdomains_init(void);
-extern void __init dra7xx_clockdomains_init(void);
-void am43xx_clockdomains_init(void);
-
-extern void clkdm_add_autodeps(struct clockdomain *clkdm);
-extern void clkdm_del_autodeps(struct clockdomain *clkdm);
-
-extern struct clkdm_ops omap2_clkdm_operations;
-extern struct clkdm_ops omap3_clkdm_operations;
-extern struct clkdm_ops omap4_clkdm_operations;
-extern struct clkdm_ops am33xx_clkdm_operations;
-extern struct clkdm_ops am43xx_clkdm_operations;
-
-extern struct clkdm_dep gfx_24xx_wkdeps[];
-extern struct clkdm_dep dsp_24xx_wkdeps[];
-extern struct clockdomain wkup_common_clkdm;
-
-#endif
diff --git a/arch/arm/mach-omap2/clockdomains2420_data.c b/arch/arm/mach-omap2/clockdomains2420_data.c
index 432cb14..b54a3e8 100644
--- a/arch/arm/mach-omap2/clockdomains2420_data.c
+++ b/arch/arm/mach-omap2/clockdomains2420_data.c
@@ -36,7 +36,7 @@
 #include <linux/io.h>
 
 #include "soc.h"
-#include "clockdomain.h"
+#include <linux/power/omap/clockdomain.h>
 #include <linux/power/omap/prm2xxx_3xxx.h>
 #include <linux/power/omap/cm2xxx_3xxx.h>
 #include "cm-regbits-24xx.h"
diff --git a/arch/arm/mach-omap2/clockdomains2430_data.c b/arch/arm/mach-omap2/clockdomains2430_data.c
index 48df0fb..c0030bc 100644
--- a/arch/arm/mach-omap2/clockdomains2430_data.c
+++ b/arch/arm/mach-omap2/clockdomains2430_data.c
@@ -36,7 +36,7 @@
 #include <linux/io.h>
 
 #include "soc.h"
-#include "clockdomain.h"
+#include <linux/power/omap/clockdomain.h>
 #include <linux/power/omap/prm2xxx_3xxx.h>
 #include <linux/power/omap/cm2xxx_3xxx.h>
 #include "cm-regbits-24xx.h"
diff --git a/arch/arm/mach-omap2/clockdomains2xxx_3xxx_data.c b/arch/arm/mach-omap2/clockdomains2xxx_3xxx_data.c
index 435e5c3..f8666d7 100644
--- a/arch/arm/mach-omap2/clockdomains2xxx_3xxx_data.c
+++ b/arch/arm/mach-omap2/clockdomains2xxx_3xxx_data.c
@@ -35,7 +35,7 @@
 #include <linux/kernel.h>
 #include <linux/io.h>
 
-#include "clockdomain.h"
+#include <linux/power/omap/clockdomain.h>
 #include <linux/power/omap/prm2xxx_3xxx.h>
 #include <linux/power/omap/cm2xxx_3xxx.h>
 #include "cm-regbits-24xx.h"
diff --git a/arch/arm/mach-omap2/clockdomains33xx_data.c b/arch/arm/mach-omap2/clockdomains33xx_data.c
index e86f84e..0a6160b 100644
--- a/arch/arm/mach-omap2/clockdomains33xx_data.c
+++ b/arch/arm/mach-omap2/clockdomains33xx_data.c
@@ -17,7 +17,7 @@
 #include <linux/kernel.h>
 #include <linux/io.h>
 
-#include "clockdomain.h"
+#include <linux/power/omap/clockdomain.h>
 #include <linux/power/omap/cm.h>
 #include "cm33xx.h"
 #include "cm-regbits-33xx.h"
diff --git a/arch/arm/mach-omap2/clockdomains3xxx_data.c b/arch/arm/mach-omap2/clockdomains3xxx_data.c
index 9272baf..fcdee72 100644
--- a/arch/arm/mach-omap2/clockdomains3xxx_data.c
+++ b/arch/arm/mach-omap2/clockdomains3xxx_data.c
@@ -34,7 +34,7 @@
 #include <linux/io.h>
 
 #include "soc.h"
-#include "clockdomain.h"
+#include <linux/power/omap/clockdomain.h>
 #include <linux/power/omap/prm2xxx_3xxx.h>
 #include <linux/power/omap/cm2xxx_3xxx.h>
 #include "cm-regbits-34xx.h"
diff --git a/arch/arm/mach-omap2/clockdomains43xx_data.c b/arch/arm/mach-omap2/clockdomains43xx_data.c
index 11a319b..5f1ddb9 100644
--- a/arch/arm/mach-omap2/clockdomains43xx_data.c
+++ b/arch/arm/mach-omap2/clockdomains43xx_data.c
@@ -11,7 +11,7 @@
 #include <linux/kernel.h>
 #include <linux/io.h>
 
-#include "clockdomain.h"
+#include <linux/power/omap/clockdomain.h>
 #include "prcm43xx.h"
 
 static struct clockdomain l4_cefuse_43xx_clkdm = {
diff --git a/arch/arm/mach-omap2/clockdomains44xx_data.c b/arch/arm/mach-omap2/clockdomains44xx_data.c
index a335303..965d56f 100644
--- a/arch/arm/mach-omap2/clockdomains44xx_data.c
+++ b/arch/arm/mach-omap2/clockdomains44xx_data.c
@@ -22,7 +22,7 @@
 #include <linux/kernel.h>
 #include <linux/io.h>
 
-#include "clockdomain.h"
+#include <linux/power/omap/clockdomain.h>
 #include "cm1_44xx.h"
 #include "cm2_44xx.h"
 
diff --git a/arch/arm/mach-omap2/clockdomains54xx_data.c b/arch/arm/mach-omap2/clockdomains54xx_data.c
index 59ea31e..6699aaf6 100644
--- a/arch/arm/mach-omap2/clockdomains54xx_data.c
+++ b/arch/arm/mach-omap2/clockdomains54xx_data.c
@@ -21,7 +21,7 @@
 #include <linux/kernel.h>
 #include <linux/io.h>
 
-#include "clockdomain.h"
+#include <linux/power/omap/clockdomain.h>
 #include "cm1_54xx.h"
 #include "cm2_54xx.h"
 
diff --git a/arch/arm/mach-omap2/clockdomains7xx_data.c b/arch/arm/mach-omap2/clockdomains7xx_data.c
index b169667..52d1226 100644
--- a/arch/arm/mach-omap2/clockdomains7xx_data.c
+++ b/arch/arm/mach-omap2/clockdomains7xx_data.c
@@ -23,7 +23,7 @@
 #include <linux/kernel.h>
 #include <linux/io.h>
 
-#include "clockdomain.h"
+#include <linux/power/omap/clockdomain.h>
 #include "cm1_7xx.h"
 #include "cm2_7xx.h"
 
diff --git a/arch/arm/mach-omap2/cm2xxx.c b/arch/arm/mach-omap2/cm2xxx.c
index f7365c7..93efae1 100644
--- a/arch/arm/mach-omap2/cm2xxx.c
+++ b/arch/arm/mach-omap2/cm2xxx.c
@@ -22,9 +22,10 @@
 #include <linux/power/omap/cm.h>
 #include "cm2xxx_3xxx_private.h"
 #include <linux/power/omap/cm2xxx.h>
-#include "clockdomain.h"
+#include <linux/power/omap/clockdomain.h>
 #include <linux/power/omap/prcm-common.h>
 #include <linux/power/omap/prm2xxx_3xxx.h>
+#include "powerdomain.h"
 
 /* CM_AUTOIDLE_PLL.AUTO_* bit values for DPLLs */
 #define DPLL_AUTOIDLE_DISABLE				0x0
diff --git a/arch/arm/mach-omap2/cm33xx.c b/arch/arm/mach-omap2/cm33xx.c
index 1f68cde..ea9598c 100644
--- a/arch/arm/mach-omap2/cm33xx.c
+++ b/arch/arm/mach-omap2/cm33xx.c
@@ -22,7 +22,7 @@
 #include <linux/err.h>
 #include <linux/io.h>
 
-#include "clockdomain.h"
+#include <linux/power/omap/clockdomain.h>
 #include <linux/power/omap/cm.h>
 #include <linux/power/omap/cm33xx.h>
 #include <linux/power/omap/prm33xx.h>
diff --git a/arch/arm/mach-omap2/cm3xxx.c b/arch/arm/mach-omap2/cm3xxx.c
index 01c69f2..47d0e49 100644
--- a/arch/arm/mach-omap2/cm3xxx.c
+++ b/arch/arm/mach-omap2/cm3xxx.c
@@ -22,8 +22,9 @@
 #include <linux/power/omap/cm.h>
 #include "cm2xxx_3xxx_private.h"
 #include <linux/power/omap/cm3xxx.h>
-#include "clockdomain.h"
+#include <linux/power/omap/clockdomain.h>
 #include <linux/power/omap/prcm-common.h>
+#include "powerdomain.h"
 
 #define OMAP34XX_CLKSTCTRL_DISABLE_AUTO		0x0
 #define OMAP34XX_CLKSTCTRL_FORCE_SLEEP		0x1
diff --git a/arch/arm/mach-omap2/cminst44xx.c b/arch/arm/mach-omap2/cminst44xx.c
index 3b95fc6..13c4e0b 100644
--- a/arch/arm/mach-omap2/cminst44xx.c
+++ b/arch/arm/mach-omap2/cminst44xx.c
@@ -22,7 +22,7 @@
 #include <linux/io.h>
 
 #include <linux/power/omap/prm.h>
-#include "clockdomain.h"
+#include <linux/power/omap/clockdomain.h>
 #include <linux/power/omap/cm.h>
 #include "cm1_44xx.h"
 #include "cm2_44xx.h"
diff --git a/arch/arm/mach-omap2/cpuidle34xx.c b/arch/arm/mach-omap2/cpuidle34xx.c
index e18709d..858a28a 100644
--- a/arch/arm/mach-omap2/cpuidle34xx.c
+++ b/arch/arm/mach-omap2/cpuidle34xx.c
@@ -29,7 +29,7 @@
 #include <asm/cpuidle.h>
 
 #include "powerdomain.h"
-#include "clockdomain.h"
+#include <linux/power/omap/clockdomain.h>
 
 #include "pm.h"
 #include "control.h"
diff --git a/arch/arm/mach-omap2/cpuidle44xx.c b/arch/arm/mach-omap2/cpuidle44xx.c
index 4324e4e..1ddc4fe 100644
--- a/arch/arm/mach-omap2/cpuidle44xx.c
+++ b/arch/arm/mach-omap2/cpuidle44xx.c
@@ -21,7 +21,7 @@
 #include "common.h"
 #include "pm.h"
 #include <linux/power/omap/prm.h>
-#include "clockdomain.h"
+#include <linux/power/omap/clockdomain.h>
 
 /* Machine specific information */
 struct idle_statedata {
diff --git a/arch/arm/mach-omap2/dpll3xxx.c b/arch/arm/mach-omap2/dpll3xxx.c
index 79ce6e8..60a58ff 100644
--- a/arch/arm/mach-omap2/dpll3xxx.c
+++ b/arch/arm/mach-omap2/dpll3xxx.c
@@ -29,7 +29,7 @@
 #include <linux/clkdev.h>
 
 #include "soc.h"
-#include "clockdomain.h"
+#include <linux/power/omap/clockdomain.h>
 #include "clock.h"
 #include <linux/power/omap/cm2xxx_3xxx.h>
 #include "cm-regbits-34xx.h"
diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index e9f7db9..b12ca79 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -32,7 +32,7 @@
 #include "iomap.h"
 #include "voltage.h"
 #include "powerdomain.h"
-#include "clockdomain.h"
+#include <linux/power/omap/clockdomain.h>
 #include "common.h"
 #include "clock.h"
 #include "clock2xxx.h"
diff --git a/arch/arm/mach-omap2/omap-smp.c b/arch/arm/mach-omap2/omap-smp.c
index 17550aa..a9f4979 100644
--- a/arch/arm/mach-omap2/omap-smp.c
+++ b/arch/arm/mach-omap2/omap-smp.c
@@ -30,7 +30,7 @@
 #include "soc.h"
 #include "iomap.h"
 #include "common.h"
-#include "clockdomain.h"
+#include <linux/power/omap/clockdomain.h>
 #include "pm.h"
 
 #define CPU_MASK		0xff0ffff0
diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index df0c2a0..bfd3c19 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -149,7 +149,7 @@
 
 #include "soc.h"
 #include "common.h"
-#include "clockdomain.h"
+#include <linux/power/omap/clockdomain.h>
 #include "powerdomain.h"
 #include "cm2xxx.h"
 #include "cm3xxx.h"
diff --git a/arch/arm/mach-omap2/pm-debug.c b/arch/arm/mach-omap2/pm-debug.c
index d2e4fb8..766012e 100644
--- a/arch/arm/mach-omap2/pm-debug.c
+++ b/arch/arm/mach-omap2/pm-debug.c
@@ -29,7 +29,7 @@
 
 #include "clock.h"
 #include "powerdomain.h"
-#include "clockdomain.h"
+#include <linux/power/omap/clockdomain.h>
 #include "omap-pm.h"
 
 #include "soc.h"
diff --git a/arch/arm/mach-omap2/pm.c b/arch/arm/mach-omap2/pm.c
index f464aed..8ee7b14 100644
--- a/arch/arm/mach-omap2/pm.c
+++ b/arch/arm/mach-omap2/pm.c
@@ -28,7 +28,7 @@
 #include <linux/power/omap/prcm-common.h>
 #include "voltage.h"
 #include "powerdomain.h"
-#include "clockdomain.h"
+#include <linux/power/omap/clockdomain.h>
 #include "pm.h"
 #include "twl-common.h"
 
diff --git a/arch/arm/mach-omap2/pm24xx.c b/arch/arm/mach-omap2/pm24xx.c
index 97b3831..6c1b8d6 100644
--- a/arch/arm/mach-omap2/pm24xx.c
+++ b/arch/arm/mach-omap2/pm24xx.c
@@ -52,7 +52,7 @@
 #include "pm.h"
 #include "control.h"
 #include "powerdomain.h"
-#include "clockdomain.h"
+#include <linux/power/omap/clockdomain.h>
 
 static void (*omap2_sram_suspend)(u32 dllctrl, void __iomem *sdrc_dlla_ctrl,
 				  void __iomem *sdrc_power);
diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 4ba0cce..119b9ff 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -37,7 +37,7 @@
 #include <asm/suspend.h>
 #include <asm/system_misc.h>
 
-#include "clockdomain.h"
+#include <linux/power/omap/clockdomain.h>
 #include "powerdomain.h"
 #include "soc.h"
 #include "common.h"
diff --git a/arch/arm/mach-omap2/pm44xx.c b/arch/arm/mach-omap2/pm44xx.c
index eefb30c..47f664f 100644
--- a/arch/arm/mach-omap2/pm44xx.c
+++ b/arch/arm/mach-omap2/pm44xx.c
@@ -20,7 +20,7 @@
 
 #include "soc.h"
 #include "common.h"
-#include "clockdomain.h"
+#include <linux/power/omap/clockdomain.h>
 #include "powerdomain.h"
 #include "pm.h"
 
diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-omap2/powerdomain.c
index 86ef5f6..63fd500 100644
--- a/arch/arm/mach-omap2/powerdomain.c
+++ b/arch/arm/mach-omap2/powerdomain.c
@@ -31,7 +31,7 @@
 
 #include <linux/power/omap/prm.h>
 #include "powerdomain.h"
-#include "clockdomain.h"
+#include <linux/power/omap/clockdomain.h>
 #include "voltage.h"
 
 #include "soc.h"
diff --git a/arch/arm/mach-omap2/prm2xxx.c b/arch/arm/mach-omap2/prm2xxx.c
index 849b415..7969cb9 100644
--- a/arch/arm/mach-omap2/prm2xxx.c
+++ b/arch/arm/mach-omap2/prm2xxx.c
@@ -19,7 +19,7 @@
 #include <linux/irq.h>
 
 #include "powerdomain.h"
-#include "clockdomain.h"
+#include <linux/power/omap/clockdomain.h>
 #include <linux/power/omap/prm2xxx.h>
 #include "prm2xxx_3xxx_private.h"
 #include <linux/power/omap/cm2xxx_3xxx.h>
diff --git a/arch/arm/mach-omap2/prm2xxx_3xxx.c b/arch/arm/mach-omap2/prm2xxx_3xxx.c
index d8044f9..a25d1d0 100644
--- a/arch/arm/mach-omap2/prm2xxx_3xxx.c
+++ b/arch/arm/mach-omap2/prm2xxx_3xxx.c
@@ -18,7 +18,7 @@
 
 #include "powerdomain.h"
 #include "prm2xxx_3xxx_private.h"
-#include "clockdomain.h"
+#include <linux/power/omap/clockdomain.h>
 
 /**
  * omap2_prm_is_hardreset_asserted - read the HW reset line state of
diff --git a/include/linux/power/omap/clockdomain.h b/include/linux/power/omap/clockdomain.h
new file mode 100644
index 0000000..96f1dc7
--- /dev/null
+++ b/include/linux/power/omap/clockdomain.h
@@ -0,0 +1,242 @@
+/*
+ * OMAP2/3 clockdomain framework functions
+ *
+ * Copyright (C) 2008, 2012 Texas Instruments, Inc.
+ * Copyright (C) 2008-2011 Nokia Corporation
+ *
+ * Paul Walmsley
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef __LINUX_POWER_OMAP_CLOCKDOMAIN_H
+#define __LINUX_POWER_OMAP_CLOCKDOMAIN_H
+
+#include <linux/init.h>
+
+/*
+ * Clockdomain flags
+ *
+ * XXX Document CLKDM_CAN_* flags
+ *
+ * CLKDM_NO_AUTODEPS: Prevent "autodeps" from being added/removed from this
+ *     clockdomain.  (Currently, this applies to OMAP3 clockdomains only.)
+ * CLKDM_ACTIVE_WITH_MPU: The PRCM guarantees that this clockdomain is
+ *     active whenever the MPU is active.  True for interconnects and
+ *     the WKUP clockdomains.
+ * CLKDM_MISSING_IDLE_REPORTING: The idle status of the IP blocks and
+ *     clocks inside this clockdomain are not taken into account by
+ *     the PRCM when determining whether the clockdomain is idle.
+ *     Without this flag, if the clockdomain is set to
+ *     hardware-supervised idle mode, the PRCM may transition the
+ *     enclosing powerdomain to a low power state, even when devices
+ *     inside the clockdomain and powerdomain are in use.  (An example
+ *     of such a clockdomain is the EMU clockdomain on OMAP3/4.)  If
+ *     this flag is set, and the clockdomain does not support the
+ *     force-sleep mode, then the HW_AUTO mode will be used to put the
+ *     clockdomain to sleep.  Similarly, if the clockdomain supports
+ *     the force-wakeup mode, then it will be used whenever a clock or
+ *     IP block inside the clockdomain is active, rather than the
+ *     HW_AUTO mode.
+ */
+#define CLKDM_CAN_FORCE_SLEEP			(1 << 0)
+#define CLKDM_CAN_FORCE_WAKEUP			(1 << 1)
+#define CLKDM_CAN_ENABLE_AUTO			(1 << 2)
+#define CLKDM_CAN_DISABLE_AUTO			(1 << 3)
+#define CLKDM_NO_AUTODEPS			(1 << 4)
+#define CLKDM_ACTIVE_WITH_MPU			(1 << 5)
+#define CLKDM_MISSING_IDLE_REPORTING		(1 << 6)
+
+#define CLKDM_CAN_HWSUP		(CLKDM_CAN_ENABLE_AUTO | CLKDM_CAN_DISABLE_AUTO)
+#define CLKDM_CAN_SWSUP		(CLKDM_CAN_FORCE_SLEEP | CLKDM_CAN_FORCE_WAKEUP)
+#define CLKDM_CAN_HWSUP_SWSUP	(CLKDM_CAN_SWSUP | CLKDM_CAN_HWSUP)
+
+/**
+ * struct clkdm_autodep - clkdm deps to add when entering/exiting hwsup mode
+ * @clkdm: clockdomain to add wkdep+sleepdep on - set name member only
+ *
+ * A clockdomain that should have wkdeps and sleepdeps added when a
+ * clockdomain should stay active in hwsup mode; and conversely,
+ * removed when the clockdomain should be allowed to go inactive in
+ * hwsup mode.
+ *
+ * Autodeps are deprecated and should be removed after
+ * omap_hwmod-based fine-grained module idle control is added.
+ */
+struct clkdm_autodep {
+	union {
+		const char *name;
+		struct clockdomain *ptr;
+	} clkdm;
+};
+
+/**
+ * struct clkdm_dep - encode dependencies between clockdomains
+ * @clkdm_name: clockdomain name
+ * @clkdm: pointer to the struct clockdomain of @clkdm_name
+ * @wkdep_usecount: Number of wakeup dependencies causing this clkdm to wake
+ * @sleepdep_usecount: Number of sleep deps that could prevent clkdm from idle
+ *
+ * Statically defined.  @clkdm is resolved from @clkdm_name at runtime and
+ * should not be pre-initialized.
+ *
+ * XXX Should also include hardware (fixed) dependencies.
+ */
+struct clkdm_dep {
+	const char *clkdm_name;
+	struct clockdomain *clkdm;
+	s16 wkdep_usecount;
+	s16 sleepdep_usecount;
+};
+
+/* Possible flags for struct clockdomain._flags */
+#define _CLKDM_FLAG_HWSUP_ENABLED		BIT(0)
+
+struct omap_hwmod;
+struct clk;
+struct powerdomain;
+
+/**
+ * struct clockdomain - OMAP clockdomain
+ * @name: clockdomain name
+ * @pwrdm: powerdomain containing this clockdomain
+ * @clktrctrl_reg: CLKSTCTRL reg for the given clock domain
+ * @clktrctrl_mask: CLKTRCTRL/AUTOSTATE field mask in CM_CLKSTCTRL reg
+ * @flags: Clockdomain capability flags
+ * @_flags: Flags for use only by internal clockdomain code
+ * @dep_bit: Bit shift of this clockdomain's PM_WKDEP/CM_SLEEPDEP bit
+ * @prcm_partition: (OMAP4 only) PRCM partition ID for this clkdm's registers
+ * @cm_inst: (OMAP4 only) CM instance register offset
+ * @clkdm_offs: (OMAP4 only) CM clockdomain register offset
+ * @wkdep_srcs: Clockdomains that can be told to wake this powerdomain up
+ * @sleepdep_srcs: Clockdomains that can be told to keep this clkdm from inact
+ * @usecount: Usecount tracking
+ * @node: list_head to link all clockdomains together
+ *
+ * @prcm_partition should be a macro from mach-omap2/prcm44xx.h (OMAP4 only)
+ * @cm_inst should be a macro ending in _INST from the OMAP4 CM instance
+ *     definitions (OMAP4 only)
+ * @clkdm_offs should be a macro ending in _CDOFFS from the OMAP4 CM instance
+ *     definitions (OMAP4 only)
+ */
+struct clockdomain {
+	const char *name;
+	union {
+		const char *name;
+		struct powerdomain *ptr;
+	} pwrdm;
+	const u16 clktrctrl_mask;
+	const u8 flags;
+	u8 _flags;
+	const u8 dep_bit;
+	const u8 prcm_partition;
+	const u16 cm_inst;
+	const u16 clkdm_offs;
+	struct clkdm_dep *wkdep_srcs;
+	struct clkdm_dep *sleepdep_srcs;
+	int usecount;
+	struct list_head node;
+};
+
+/**
+ * struct clkdm_ops - Arch specific function implementations
+ * @clkdm_add_wkdep: Add a wakeup dependency between clk domains
+ * @clkdm_del_wkdep: Delete a wakeup dependency between clk domains
+ * @clkdm_read_wkdep: Read wakeup dependency state between clk domains
+ * @clkdm_clear_all_wkdeps: Remove all wakeup dependencies from the clk domain
+ * @clkdm_add_sleepdep: Add a sleep dependency between clk domains
+ * @clkdm_del_sleepdep: Delete a sleep dependency between clk domains
+ * @clkdm_read_sleepdep: Read sleep dependency state between clk domains
+ * @clkdm_clear_all_sleepdeps: Remove all sleep dependencies from the clk domain
+ * @clkdm_sleep: Force a clockdomain to sleep
+ * @clkdm_wakeup: Force a clockdomain to wakeup
+ * @clkdm_allow_idle: Enable hw supervised idle transitions for clock domain
+ * @clkdm_deny_idle: Disable hw supervised idle transitions for clock domain
+ * @clkdm_clk_enable: Put the clkdm in right state for a clock enable
+ * @clkdm_clk_disable: Put the clkdm in right state for a clock disable
+ */
+struct clkdm_ops {
+	int	(*clkdm_add_wkdep)(struct clockdomain *clkdm1,
+				   struct clockdomain *clkdm2);
+	int	(*clkdm_del_wkdep)(struct clockdomain *clkdm1,
+				   struct clockdomain *clkdm2);
+	int	(*clkdm_read_wkdep)(struct clockdomain *clkdm1,
+				    struct clockdomain *clkdm2);
+	int	(*clkdm_clear_all_wkdeps)(struct clockdomain *clkdm);
+	int	(*clkdm_add_sleepdep)(struct clockdomain *clkdm1,
+				      struct clockdomain *clkdm2);
+	int	(*clkdm_del_sleepdep)(struct clockdomain *clkdm1,
+				      struct clockdomain *clkdm2);
+	int	(*clkdm_read_sleepdep)(struct clockdomain *clkdm1,
+				       struct clockdomain *clkdm2);
+	int	(*clkdm_clear_all_sleepdeps)(struct clockdomain *clkdm);
+	int	(*clkdm_sleep)(struct clockdomain *clkdm);
+	int	(*clkdm_wakeup)(struct clockdomain *clkdm);
+	void	(*clkdm_allow_idle)(struct clockdomain *clkdm);
+	void	(*clkdm_deny_idle)(struct clockdomain *clkdm);
+	int	(*clkdm_clk_enable)(struct clockdomain *clkdm);
+	int	(*clkdm_clk_disable)(struct clockdomain *clkdm);
+};
+
+int clkdm_register_platform_funcs(struct clkdm_ops *co);
+int clkdm_register_autodeps(struct clkdm_autodep *ia);
+int clkdm_register_clkdms(struct clockdomain **c);
+int clkdm_complete_init(void);
+
+struct clockdomain *clkdm_lookup(const char *name);
+
+int clkdm_for_each(int (*fn)(struct clockdomain *clkdm, void *user),
+			void *user);
+struct powerdomain *clkdm_get_pwrdm(struct clockdomain *clkdm);
+
+int clkdm_add_wkdep(struct clockdomain *clkdm1, struct clockdomain *clkdm2);
+int clkdm_del_wkdep(struct clockdomain *clkdm1, struct clockdomain *clkdm2);
+int clkdm_read_wkdep(struct clockdomain *clkdm1, struct clockdomain *clkdm2);
+int clkdm_clear_all_wkdeps(struct clockdomain *clkdm);
+int clkdm_add_sleepdep(struct clockdomain *clkdm1, struct clockdomain *clkdm2);
+int clkdm_del_sleepdep(struct clockdomain *clkdm1, struct clockdomain *clkdm2);
+int clkdm_read_sleepdep(struct clockdomain *clkdm1, struct clockdomain *clkdm2);
+int clkdm_clear_all_sleepdeps(struct clockdomain *clkdm);
+
+void clkdm_allow_idle_nolock(struct clockdomain *clkdm);
+void clkdm_allow_idle(struct clockdomain *clkdm);
+void clkdm_deny_idle_nolock(struct clockdomain *clkdm);
+void clkdm_deny_idle(struct clockdomain *clkdm);
+bool clkdm_in_hwsup(struct clockdomain *clkdm);
+bool clkdm_missing_idle_reporting(struct clockdomain *clkdm);
+
+int clkdm_wakeup_nolock(struct clockdomain *clkdm);
+int clkdm_wakeup(struct clockdomain *clkdm);
+int clkdm_sleep_nolock(struct clockdomain *clkdm);
+int clkdm_sleep(struct clockdomain *clkdm);
+
+int clkdm_clk_enable(struct clockdomain *clkdm, struct clk *clk);
+int clkdm_clk_disable(struct clockdomain *clkdm, struct clk *clk);
+int clkdm_hwmod_enable(struct clockdomain *clkdm, struct omap_hwmod *oh);
+int clkdm_hwmod_disable(struct clockdomain *clkdm, struct omap_hwmod *oh);
+
+void __init omap242x_clockdomains_init(void);
+void __init omap243x_clockdomains_init(void);
+void __init omap3xxx_clockdomains_init(void);
+void __init am33xx_clockdomains_init(void);
+void __init omap44xx_clockdomains_init(void);
+void __init omap54xx_clockdomains_init(void);
+void __init dra7xx_clockdomains_init(void);
+void am43xx_clockdomains_init(void);
+
+void clkdm_add_autodeps(struct clockdomain *clkdm);
+void clkdm_del_autodeps(struct clockdomain *clkdm);
+
+extern struct clkdm_ops omap2_clkdm_operations;
+extern struct clkdm_ops omap3_clkdm_operations;
+extern struct clkdm_ops omap4_clkdm_operations;
+extern struct clkdm_ops am33xx_clkdm_operations;
+extern struct clkdm_ops am43xx_clkdm_operations;
+
+extern struct clkdm_dep gfx_24xx_wkdeps[];
+extern struct clkdm_dep dsp_24xx_wkdeps[];
+extern struct clockdomain wkup_common_clkdm;
+
+#endif
-- 
1.7.9.5

