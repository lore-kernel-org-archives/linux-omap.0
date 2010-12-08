From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 10/11] OMAP2+: powerdomain: move header file from plat-omap to
	mach-omap2
Date: Tue, 07 Dec 2010 23:18:44 -0700
Message-ID: <20101208061843.30541.23685.stgit@twilight.localdomain>
References: <20101208061657.30541.79824.stgit@twilight.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:37204 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753239Ab0LHGT5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 8 Dec 2010 01:19:57 -0500
In-Reply-To: <20101208061657.30541.79824.stgit@twilight.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Kevin Hilman <khilman@deeprootsystems.com>

The OMAP powerdomain code and data is all OMAP2+-specific.  This seems
unlikely to change any time soon.  Move plat-omap/include/plat/powerdomain.h
to mach-omap2/powerdomain.h.  The primary point of doing this is to remove
the temptation for unrelated upper-layer code to access powerdomain code
and data directly.

As part of this process, remove the references to powerdomain data from
the GPIO "driver" and the OMAP PM no-op layer, both in plat-omap.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/clockdomain.c                |    2 +
 arch/arm/mach-omap2/clockdomain.h                |    2 +
 arch/arm/mach-omap2/cpuidle34xx.c                |    2 +
 arch/arm/mach-omap2/io.c                         |    2 +
 arch/arm/mach-omap2/omap_hwmod.c                 |    2 +
 arch/arm/mach-omap2/pm-debug.c                   |    2 +
 arch/arm/mach-omap2/pm.c                         |    2 +
 arch/arm/mach-omap2/pm.h                         |    2 +
 arch/arm/mach-omap2/pm24xx.c                     |    4 +--
 arch/arm/mach-omap2/pm34xx.c                     |    6 +++-
 arch/arm/mach-omap2/pm44xx.c                     |    2 +
 arch/arm/mach-omap2/powerdomain-common.c         |    1 -
 arch/arm/mach-omap2/powerdomain.c                |    2 +
 arch/arm/mach-omap2/powerdomain.h                |   23 +++++++++++++----
 arch/arm/mach-omap2/powerdomain2xxx_3xxx.c       |    2 +
 arch/arm/mach-omap2/powerdomain44xx.c            |    3 +-
 arch/arm/mach-omap2/powerdomains.h               |   30 ----------------------
 arch/arm/mach-omap2/powerdomains2xxx_3xxx_data.c |    4 +--
 arch/arm/mach-omap2/powerdomains2xxx_3xxx_data.h |    2 +
 arch/arm/mach-omap2/powerdomains2xxx_data.c      |    3 +-
 arch/arm/mach-omap2/powerdomains3xxx_data.c      |    3 +-
 arch/arm/mach-omap2/powerdomains44xx_data.c      |    3 +-
 arch/arm/plat-omap/gpio.c                        |    5 +---
 arch/arm/plat-omap/include/plat/gpio.h           |    2 +
 arch/arm/plat-omap/include/plat/omap-pm.h        |    2 -
 arch/arm/plat-omap/omap-pm-noop.c                |    2 -
 26 files changed, 44 insertions(+), 71 deletions(-)
 rename arch/arm/{plat-omap/include/plat/powerdomain.h => mach-omap2/powerdomain.h} (92%)
 delete mode 100644 arch/arm/mach-omap2/powerdomains.h

diff --git a/arch/arm/mach-omap2/clockdomain.c b/arch/arm/mach-omap2/clockdomain.c
index dadfb3f..4ebfa26 100644
--- a/arch/arm/mach-omap2/clockdomain.c
+++ b/arch/arm/mach-omap2/clockdomain.c
@@ -34,7 +34,7 @@
 #include "prcm44xx.h"
 
 #include <plat/clock.h>
-#include <plat/powerdomain.h>
+#include "powerdomain.h"
 #include "clockdomain.h"
 #include <plat/prcm.h>
 
diff --git a/arch/arm/mach-omap2/clockdomain.h b/arch/arm/mach-omap2/clockdomain.h
index 372c646..de3faa2 100644
--- a/arch/arm/mach-omap2/clockdomain.h
+++ b/arch/arm/mach-omap2/clockdomain.h
@@ -18,7 +18,7 @@
 
 #include <linux/init.h>
 
-#include <plat/powerdomain.h>
+#include "powerdomain.h"
 #include <plat/clock.h>
 #include <plat/cpu.h>
 
diff --git a/arch/arm/mach-omap2/cpuidle34xx.c b/arch/arm/mach-omap2/cpuidle34xx.c
index 568dff7..81b0a90 100644
--- a/arch/arm/mach-omap2/cpuidle34xx.c
+++ b/arch/arm/mach-omap2/cpuidle34xx.c
@@ -27,7 +27,7 @@
 
 #include <plat/prcm.h>
 #include <plat/irqs.h>
-#include <plat/powerdomain.h>
+#include "powerdomain.h"
 #include "clockdomain.h"
 #include <plat/serial.h>
 
diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index 1151f4a..a31acff 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -39,7 +39,7 @@
 #include "io.h"
 
 #include <plat/omap-pm.h>
-#include <plat/powerdomain.h>
+#include "powerdomain.h"
 
 #include "clockdomain.h"
 #include <plat/omap_hwmod.h>
diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 10bd001..38652d0 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -139,7 +139,7 @@
 #include <plat/common.h>
 #include <plat/cpu.h>
 #include "clockdomain.h"
-#include <plat/powerdomain.h>
+#include "powerdomain.h"
 #include <plat/clock.h>
 #include <plat/omap_hwmod.h>
 #include <plat/prcm.h>
diff --git a/arch/arm/mach-omap2/pm-debug.c b/arch/arm/mach-omap2/pm-debug.c
index 3fc7707..ed892ae 100644
--- a/arch/arm/mach-omap2/pm-debug.c
+++ b/arch/arm/mach-omap2/pm-debug.c
@@ -29,7 +29,7 @@
 
 #include <plat/clock.h>
 #include <plat/board.h>
-#include <plat/powerdomain.h>
+#include "powerdomain.h"
 #include "clockdomain.h"
 #include <plat/dmtimer.h>
 
diff --git a/arch/arm/mach-omap2/pm.c b/arch/arm/mach-omap2/pm.c
index 60cfe67..cf1c4c9 100644
--- a/arch/arm/mach-omap2/pm.c
+++ b/arch/arm/mach-omap2/pm.c
@@ -18,7 +18,7 @@
 #include <plat/omap_device.h>
 #include <plat/common.h>
 
-#include <plat/powerdomain.h>
+#include "powerdomain.h"
 #include "clockdomain.h"
 
 static struct omap_device_pm_latency *pm_lats;
diff --git a/arch/arm/mach-omap2/pm.h b/arch/arm/mach-omap2/pm.h
index 0d75bfd..642e519 100644
--- a/arch/arm/mach-omap2/pm.h
+++ b/arch/arm/mach-omap2/pm.h
@@ -11,7 +11,7 @@
 #ifndef __ARCH_ARM_MACH_OMAP2_PM_H
 #define __ARCH_ARM_MACH_OMAP2_PM_H
 
-#include <plat/powerdomain.h>
+#include "powerdomain.h"
 
 extern void *omap3_secure_ram_storage;
 extern void omap3_pm_off_mode_enable(int);
diff --git a/arch/arm/mach-omap2/pm24xx.c b/arch/arm/mach-omap2/pm24xx.c
index 7d4933b..0413314 100644
--- a/arch/arm/mach-omap2/pm24xx.c
+++ b/arch/arm/mach-omap2/pm24xx.c
@@ -50,7 +50,7 @@
 #include "pm.h"
 #include "control.h"
 
-#include <plat/powerdomain.h>
+#include "powerdomain.h"
 #include "clockdomain.h"
 
 static void (*omap2_sram_idle)(void);
@@ -107,7 +107,7 @@ static void omap2_enter_full_retention(void)
 	l = omap_ctrl_readl(OMAP2_CONTROL_DEVCONF0) | OMAP24XX_USBSTANDBYCTRL;
 	omap_ctrl_writel(l, OMAP2_CONTROL_DEVCONF0);
 
-	omap2_gpio_prepare_for_idle(PWRDM_POWER_RET);
+	omap2_gpio_prepare_for_idle(0);
 
 	if (omap2_pm_debug) {
 		omap2_pm_dump(0, 0, 0);
diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 43c1a43..e804a9f 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -32,7 +32,7 @@
 
 #include <plat/sram.h>
 #include "clockdomain.h"
-#include <plat/powerdomain.h>
+#include "powerdomain.h"
 #include <plat/serial.h>
 #include <plat/sdrc.h>
 #include <plat/prcm.h>
@@ -344,6 +344,7 @@ void omap_sram_idle(void)
 	int mpu_next_state = PWRDM_POWER_ON;
 	int per_next_state = PWRDM_POWER_ON;
 	int core_next_state = PWRDM_POWER_ON;
+	int per_going_off;
 	int core_prev_state, per_prev_state;
 	u32 sdrc_pwr = 0;
 
@@ -394,9 +395,10 @@ void omap_sram_idle(void)
 
 	/* PER */
 	if (per_next_state < PWRDM_POWER_ON) {
+		per_going_off = (per_next_state == PWRDM_POWER_OFF) ? 1 : 0;
 		omap_uart_prepare_idle(2);
 		omap_uart_prepare_idle(3);
-		omap2_gpio_prepare_for_idle(per_next_state);
+		omap2_gpio_prepare_for_idle(per_going_off);
 		if (per_next_state == PWRDM_POWER_OFF)
 				omap3_per_save_context();
 	}
diff --git a/arch/arm/mach-omap2/pm44xx.c b/arch/arm/mach-omap2/pm44xx.c
index 54544b4..32d02cb 100644
--- a/arch/arm/mach-omap2/pm44xx.c
+++ b/arch/arm/mach-omap2/pm44xx.c
@@ -16,7 +16,7 @@
 #include <linux/err.h>
 #include <linux/slab.h>
 
-#include <plat/powerdomain.h>
+#include "powerdomain.h"
 #include <mach/omap4-common.h>
 
 struct power_state {
diff --git a/arch/arm/mach-omap2/powerdomain-common.c b/arch/arm/mach-omap2/powerdomain-common.c
index cb01c7a..171fccd 100644
--- a/arch/arm/mach-omap2/powerdomain-common.c
+++ b/arch/arm/mach-omap2/powerdomain-common.c
@@ -20,7 +20,6 @@
 #include "cm-regbits-44xx.h"
 #include "prm-regbits-34xx.h"
 #include "prm-regbits-44xx.h"
-#include "powerdomains.h"
 
 /*
  * OMAP3 and OMAP4 specific register bit initialisations
diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-omap2/powerdomain.c
index 7eb7ba4..06ef60ee 100644
--- a/arch/arm/mach-omap2/powerdomain.c
+++ b/arch/arm/mach-omap2/powerdomain.c
@@ -26,7 +26,7 @@
 #include "prm44xx.h"
 
 #include <plat/cpu.h>
-#include <plat/powerdomain.h>
+#include "powerdomain.h"
 #include "clockdomain.h"
 #include <plat/prcm.h>
 
diff --git a/arch/arm/plat-omap/include/plat/powerdomain.h b/arch/arm/mach-omap2/powerdomain.h
similarity index 92%
rename from arch/arm/plat-omap/include/plat/powerdomain.h
rename to arch/arm/mach-omap2/powerdomain.h
index a0d3a30..35b5b48 100644
--- a/arch/arm/plat-omap/include/plat/powerdomain.h
+++ b/arch/arm/mach-omap2/powerdomain.h
@@ -1,10 +1,10 @@
 /*
  * OMAP2/3/4 powerdomain control
  *
- * Copyright (C) 2007-2008 Texas Instruments, Inc.
+ * Copyright (C) 2007-2008, 2010 Texas Instruments, Inc.
  * Copyright (C) 2007-2010 Nokia Corporation
  *
- * Written by Paul Walmsley
+ * Paul Walmsley
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
@@ -14,13 +14,13 @@
  * opportunity.
  */
 
-#ifndef ASM_ARM_PLAT_OMAP_INCLUDE_PLAT_POWERDOMAIN
-#define ASM_ARM_PLAT_OMAP_INCLUDE_PLAT_POWERDOMAIN
+#ifndef __ARCH_ARM_MACH_OMAP2_POWERDOMAIN_H
+#define __ARCH_ARM_MACH_OMAP2_POWERDOMAIN_H
 
 #include <linux/types.h>
 #include <linux/list.h>
 
-#include <asm/atomic.h>
+#include <linux/atomic.h>
 
 #include <plat/cpu.h>
 
@@ -216,4 +216,17 @@ extern void omap2xxx_powerdomains_init(void);
 extern void omap3xxx_powerdomains_init(void);
 extern void omap44xx_powerdomains_init(void);
 
+extern struct pwrdm_ops omap2_pwrdm_operations;
+extern struct pwrdm_ops omap3_pwrdm_operations;
+extern struct pwrdm_ops omap4_pwrdm_operations;
+
+/* Common Internal functions used across OMAP rev's */
+extern u32 omap2_pwrdm_get_mem_bank_onstate_mask(u8 bank);
+extern u32 omap2_pwrdm_get_mem_bank_retst_mask(u8 bank);
+extern u32 omap2_pwrdm_get_mem_bank_stst_mask(u8 bank);
+
+extern struct powerdomain wkup_omap2_pwrdm;
+extern struct powerdomain gfx_omap2_pwrdm;
+
+
 #endif
diff --git a/arch/arm/mach-omap2/powerdomain2xxx_3xxx.c b/arch/arm/mach-omap2/powerdomain2xxx_3xxx.c
index b5e9e4d..d523389 100644
--- a/arch/arm/mach-omap2/powerdomain2xxx_3xxx.c
+++ b/arch/arm/mach-omap2/powerdomain2xxx_3xxx.c
@@ -18,8 +18,8 @@
 
 #include <plat/prcm.h>
 
+#include "powerdomain.h"
 #include "prm-regbits-34xx.h"
-#include "powerdomains.h"
 #include "prm.h"
 #include "prm-regbits-24xx.h"
 #include "prm-regbits-34xx.h"
diff --git a/arch/arm/mach-omap2/powerdomain44xx.c b/arch/arm/mach-omap2/powerdomain44xx.c
index 28bf5e3..a7880af 100644
--- a/arch/arm/mach-omap2/powerdomain44xx.c
+++ b/arch/arm/mach-omap2/powerdomain44xx.c
@@ -16,13 +16,12 @@
 #include <linux/errno.h>
 #include <linux/delay.h>
 
-#include <plat/powerdomain.h>
+#include "powerdomain.h"
 #include <plat/prcm.h>
 #include "prm2xxx_3xxx.h"
 #include "prm44xx.h"
 #include "prminst44xx.h"
 #include "prm-regbits-44xx.h"
-#include "powerdomains.h"
 
 static int omap4_pwrdm_set_next_pwrst(struct powerdomain *pwrdm, u8 pwrst)
 {
diff --git a/arch/arm/mach-omap2/powerdomains.h b/arch/arm/mach-omap2/powerdomains.h
deleted file mode 100644
index f83adaf..0000000
--- a/arch/arm/mach-omap2/powerdomains.h
+++ /dev/null
@@ -1,30 +0,0 @@
-/*
- * OMAP2+ powerdomain prototypes
- *
- * Copyright (C) 2010 Texas Instruments, Inc.
- *
- * Rajendra Nayak <rnayak@ti.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-#ifndef ARCH_ARM_MACH_OMAP2_POWERDOMAINS_H
-#define ARCH_ARM_MACH_OMAP2_POWERDOMAINS_H
-
-#include <plat/powerdomain.h>
-
-extern struct pwrdm_ops omap2_pwrdm_operations;
-extern struct pwrdm_ops omap3_pwrdm_operations;
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
-#endif
diff --git a/arch/arm/mach-omap2/powerdomains2xxx_3xxx_data.c b/arch/arm/mach-omap2/powerdomains2xxx_3xxx_data.c
index 14c6ef7..5b4dd97 100644
--- a/arch/arm/mach-omap2/powerdomains2xxx_3xxx_data.c
+++ b/arch/arm/mach-omap2/powerdomains2xxx_3xxx_data.c
@@ -45,13 +45,11 @@
  * address offset is different between the C55 and C64 DSPs.
  */
 
-#include <plat/powerdomain.h>
+#include "powerdomain.h"
 
 #include "prcm-common.h"
 #include "prm.h"
 
-#include "powerdomains.h"
-
 /* OMAP2/3-common powerdomains */
 
 /*
diff --git a/arch/arm/mach-omap2/powerdomains2xxx_3xxx_data.h b/arch/arm/mach-omap2/powerdomains2xxx_3xxx_data.h
index 45d684a..fa31166 100644
--- a/arch/arm/mach-omap2/powerdomains2xxx_3xxx_data.h
+++ b/arch/arm/mach-omap2/powerdomains2xxx_3xxx_data.h
@@ -14,7 +14,7 @@
 #ifndef __ARCH_ARM_MACH_OMAP2_POWERDOMAINS2XXX_3XXX_DATA_H
 #define __ARCH_ARM_MACH_OMAP2_POWERDOMAINS2XXX_3XXX_DATA_H
 
-#include <plat/powerdomain.h>
+#include "powerdomain.h"
 
 extern struct powerdomain gfx_omap2_pwrdm;
 extern struct powerdomain wkup_omap2_pwrdm;
diff --git a/arch/arm/mach-omap2/powerdomains2xxx_data.c b/arch/arm/mach-omap2/powerdomains2xxx_data.c
index e136895..9b1a335 100644
--- a/arch/arm/mach-omap2/powerdomains2xxx_data.c
+++ b/arch/arm/mach-omap2/powerdomains2xxx_data.c
@@ -14,9 +14,8 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 
-#include <plat/powerdomain.h>
+#include "powerdomain.h"
 #include "powerdomains2xxx_3xxx_data.h"
-#include "powerdomains.h"
 
 #include "prcm-common.h"
 #include "prm2xxx_3xxx.h"
diff --git a/arch/arm/mach-omap2/powerdomains3xxx_data.c b/arch/arm/mach-omap2/powerdomains3xxx_data.c
index f383784..7e712b0 100644
--- a/arch/arm/mach-omap2/powerdomains3xxx_data.c
+++ b/arch/arm/mach-omap2/powerdomains3xxx_data.c
@@ -14,9 +14,8 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 
-#include <plat/powerdomain.h>
+#include "powerdomain.h"
 #include "powerdomains2xxx_3xxx_data.h"
-#include "powerdomains.h"
 
 #include "prcm-common.h"
 #include "prm2xxx_3xxx.h"
diff --git a/arch/arm/mach-omap2/powerdomains44xx_data.c b/arch/arm/mach-omap2/powerdomains44xx_data.c
index 823f477..5fdf485 100644
--- a/arch/arm/mach-omap2/powerdomains44xx_data.c
+++ b/arch/arm/mach-omap2/powerdomains44xx_data.c
@@ -22,8 +22,7 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 
-#include <plat/powerdomain.h>
-#include "powerdomains.h"
+#include "powerdomain.h"
 
 #include "prcm-common.h"
 #include "prcm44xx.h"
diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
index c05c653..fa6d18d 100644
--- a/arch/arm/plat-omap/gpio.c
+++ b/arch/arm/plat-omap/gpio.c
@@ -27,7 +27,6 @@
 #include <mach/irqs.h>
 #include <mach/gpio.h>
 #include <asm/mach/irq.h>
-#include <plat/powerdomain.h>
 
 /*
  * OMAP1510 GPIO registers
@@ -2074,7 +2073,7 @@ static struct sys_device omap_gpio_device = {
 
 static int workaround_enabled;
 
-void omap2_gpio_prepare_for_idle(int power_state)
+void omap2_gpio_prepare_for_idle(int off_mode)
 {
 	int i, c = 0;
 	int min = 0;
@@ -2090,7 +2089,7 @@ void omap2_gpio_prepare_for_idle(int power_state)
 		for (j = 0; j < hweight_long(bank->dbck_enable_mask); j++)
 			clk_disable(bank->dbck);
 
-		if (power_state > PWRDM_POWER_OFF)
+		if (!off_mode)
 			continue;
 
 		/* If going to OFF, remove triggering for all
diff --git a/arch/arm/plat-omap/include/plat/gpio.h b/arch/arm/plat-omap/include/plat/gpio.h
index de1c604..d5634c5 100644
--- a/arch/arm/plat-omap/include/plat/gpio.h
+++ b/arch/arm/plat-omap/include/plat/gpio.h
@@ -72,7 +72,7 @@
 				 IH_GPIO_BASE + (nr))
 
 extern int omap_gpio_init(void);	/* Call from board init only */
-extern void omap2_gpio_prepare_for_idle(int power_state);
+extern void omap2_gpio_prepare_for_idle(int off_mode);
 extern void omap2_gpio_resume_after_idle(void);
 extern void omap_set_gpio_debounce(int gpio, int enable);
 extern void omap_set_gpio_debounce_time(int gpio, int enable);
diff --git a/arch/arm/plat-omap/include/plat/omap-pm.h b/arch/arm/plat-omap/include/plat/omap-pm.h
index 728fbb9..639bf91 100644
--- a/arch/arm/plat-omap/include/plat/omap-pm.h
+++ b/arch/arm/plat-omap/include/plat/omap-pm.h
@@ -18,8 +18,6 @@
 #include <linux/cpufreq.h>
 #include <linux/clk.h>
 
-#include "powerdomain.h"
-
 /**
  * struct omap_opp - clock frequency-to-OPP ID table for DSP, MPU
  * @rate: target clock rate
diff --git a/arch/arm/plat-omap/omap-pm-noop.c b/arch/arm/plat-omap/omap-pm-noop.c
index e129ce8..81b4ac1 100644
--- a/arch/arm/plat-omap/omap-pm-noop.c
+++ b/arch/arm/plat-omap/omap-pm-noop.c
@@ -24,8 +24,6 @@
 /* Interface documentation is in mach/omap-pm.h */
 #include <plat/omap-pm.h>
 
-#include <plat/powerdomain.h>
-
 struct omap_opp *dsp_opps;
 struct omap_opp *mpu_opps;
 struct omap_opp *l3_opps;


