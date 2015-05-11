From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv2 11/27] ARM: OMAP2+: clock: remove support for legacy mpurate command line param
Date: Mon, 11 May 2015 11:54:37 +0300
Message-ID: <1431334493-24455-12-git-send-email-t-kristo@ti.com>
References: <1431334493-24455-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:45731 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753264AbbEKIzL (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 11 May 2015 04:55:11 -0400
In-Reply-To: <1431334493-24455-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: mturquette@linaro.org, tony@atomide.com, linux-omap@vger.kernel.org, linux-clk@vger.kernel.org, sboyd@codeaurora.org, paul@pwsan.com
Cc: linux-arm-kernel@lists.infradead.org

The legacy support is wrong and dangerous, as it doesn't take any
OPPs into account and does not scale voltages. Switching mpurate should
be handled through cpufreq.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/Makefile    |    2 +-
 arch/arm/mach-omap2/clock.c     |   41 ----------------------------
 arch/arm/mach-omap2/clock.h     |    1 -
 arch/arm/mach-omap2/clock2xxx.c |   57 ---------------------------------------
 arch/arm/mach-omap2/clock3xxx.c |   25 -----------------
 5 files changed, 1 insertion(+), 125 deletions(-)
 delete mode 100644 arch/arm/mach-omap2/clock2xxx.c

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index f33d011..bf5d71d 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -181,7 +181,7 @@ obj-$(CONFIG_SOC_DRA7XX)		+= $(clockdomain-common)
 obj-$(CONFIG_SOC_DRA7XX)		+= clockdomains7xx_data.o
 
 # Clock framework
-obj-$(CONFIG_ARCH_OMAP2)		+= $(clock-common) clock2xxx.o
+obj-$(CONFIG_ARCH_OMAP2)		+= $(clock-common)
 obj-$(CONFIG_ARCH_OMAP2)		+= clkt2xxx_dpllcore.o
 obj-$(CONFIG_ARCH_OMAP2)		+= clkt2xxx_virt_prcm_set.o
 obj-$(CONFIG_ARCH_OMAP2)		+= clkt2xxx_dpll.o
diff --git a/arch/arm/mach-omap2/clock.c b/arch/arm/mach-omap2/clock.c
index 234cedf..94a4949 100644
--- a/arch/arm/mach-omap2/clock.c
+++ b/arch/arm/mach-omap2/clock.c
@@ -582,47 +582,6 @@ const struct clk_hw_omap_ops clkhwops_wait = {
 };
 
 /**
- * omap2_clk_switch_mpurate_at_boot - switch ARM MPU rate by boot-time argument
- * @mpurate_ck_name: clk name of the clock to change rate
- *
- * Change the ARM MPU clock rate to the rate specified on the command
- * line, if one was specified.  @mpurate_ck_name should be
- * "virt_prcm_set" on OMAP2xxx and "dpll1_ck" on OMAP34xx/OMAP36xx.
- * XXX Does not handle voltage scaling - on OMAP2xxx this is currently
- * handled by the virt_prcm_set clock, but this should be handled by
- * the OPP layer.  XXX This is intended to be handled by the OPP layer
- * code in the near future and should be removed from the clock code.
- * Returns -EINVAL if 'mpurate' is zero or if clk_set_rate() rejects
- * the rate, -ENOENT if the struct clk referred to by @mpurate_ck_name
- * cannot be found, or 0 upon success.
- */
-int __init omap2_clk_switch_mpurate_at_boot(const char *mpurate_ck_name)
-{
-	struct clk *mpurate_ck;
-	int r;
-
-	if (!mpurate)
-		return -EINVAL;
-
-	mpurate_ck = clk_get(NULL, mpurate_ck_name);
-	if (WARN(IS_ERR(mpurate_ck), "Failed to get %s.\n", mpurate_ck_name))
-		return -ENOENT;
-
-	r = clk_set_rate(mpurate_ck, mpurate);
-	if (r < 0) {
-		WARN(1, "clock: %s: unable to set MPU rate to %d: %d\n",
-		     mpurate_ck_name, mpurate, r);
-		clk_put(mpurate_ck);
-		return -EINVAL;
-	}
-
-	calibrate_delay();
-	clk_put(mpurate_ck);
-
-	return 0;
-}
-
-/**
  * omap2_clk_print_new_rates - print summary of current clock tree rates
  * @hfclkin_ck_name: clk name for the off-chip HF oscillator
  * @core_ck_name: clk name for the on-chip CORE_CLK
diff --git a/arch/arm/mach-omap2/clock.h b/arch/arm/mach-omap2/clock.h
index 950a17a..e2781b4 100644
--- a/arch/arm/mach-omap2/clock.h
+++ b/arch/arm/mach-omap2/clock.h
@@ -186,7 +186,6 @@ void omap3_dpll_deny_idle(struct clk_hw_omap *clk);
 
 void __init omap2_clk_disable_clkdm_control(void);
 
-int omap2_clk_switch_mpurate_at_boot(const char *mpurate_ck_name);
 void omap2_clk_print_new_rates(const char *hfclkin_ck_name,
 			       const char *core_ck_name,
 			       const char *mpu_ck_name);
diff --git a/arch/arm/mach-omap2/clock2xxx.c b/arch/arm/mach-omap2/clock2xxx.c
deleted file mode 100644
index b870f6a..0000000
--- a/arch/arm/mach-omap2/clock2xxx.c
+++ /dev/null
@@ -1,57 +0,0 @@
-/*
- * clock2xxx.c - OMAP2xxx-specific clock integration code
- *
- * Copyright (C) 2005-2008 Texas Instruments, Inc.
- * Copyright (C) 2004-2010 Nokia Corporation
- *
- * Contacts:
- * Richard Woodruff <r-woodruff2@ti.com>
- * Paul Walmsley
- *
- * Based on earlier work by Tuukka Tikkanen, Tony Lindgren,
- * Gordon McNutt and RidgeRun, Inc.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-#undef DEBUG
-
-#include <linux/kernel.h>
-#include <linux/errno.h>
-#include <linux/clk.h>
-#include <linux/io.h>
-
-#include "soc.h"
-#include "clock.h"
-#include "clock2xxx.h"
-#include "cm.h"
-#include "cm-regbits-24xx.h"
-
-struct clk_hw *dclk_hw;
-/*
- * Omap24xx specific clock functions
- */
-
-/*
- * Switch the MPU rate if specified on cmdline.  We cannot do this
- * early until cmdline is parsed.  XXX This should be removed from the
- * clock code and handled by the OPP layer code in the near future.
- */
-static int __init omap2xxx_clk_arch_init(void)
-{
-	int ret;
-
-	if (!cpu_is_omap24xx())
-		return 0;
-
-	ret = omap2_clk_switch_mpurate_at_boot("virt_prcm_set");
-	if (!ret)
-		omap2_clk_print_new_rates("sys_ck", "dpll_ck", "mpu_ck");
-
-	return ret;
-}
-
-omap_arch_initcall(omap2xxx_clk_arch_init);
-
-
diff --git a/arch/arm/mach-omap2/clock3xxx.c b/arch/arm/mach-omap2/clock3xxx.c
index 8bede6a..4bd6122 100644
--- a/arch/arm/mach-omap2/clock3xxx.c
+++ b/arch/arm/mach-omap2/clock3xxx.c
@@ -108,28 +108,3 @@ void __init omap3_clk_lock_dpll5(void)
 	clk_disable_unprepare(dpll5_clk);
 	return;
 }
-
-/* Common clock code */
-
-/*
- * Switch the MPU rate if specified on cmdline.  We cannot do this
- * early until cmdline is parsed.  XXX This should be removed from the
- * clock code and handled by the OPP layer code in the near future.
- */
-static int __init omap3xxx_clk_arch_init(void)
-{
-	int ret;
-
-	if (!cpu_is_omap34xx())
-		return 0;
-
-	ret = omap2_clk_switch_mpurate_at_boot("dpll1_ck");
-	if (!ret)
-		omap2_clk_print_new_rates("osc_sys_ck", "core_ck", "arm_fck");
-
-	return ret;
-}
-
-omap_arch_initcall(omap3xxx_clk_arch_init);
-
-
-- 
1.7.9.5

