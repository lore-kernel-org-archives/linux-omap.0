From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH 03/15] ARM: OMAP4+: PM: Consolidate and use OMAP4 PM code for OMAP5
Date: Fri, 1 Mar 2013 17:40:52 +0530
Message-ID: <1362139864-9233-4-git-send-email-santosh.shilimkar@ti.com>
References: <1362139864-9233-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:35854 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752388Ab3CAMKP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 Mar 2013 07:10:15 -0500
In-Reply-To: <1362139864-9233-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@deeprootsystems.com, linux-arm-kernel@lists.infradead.org, Santosh Shilimkar <santosh.shilimkar@ti.com>

OMAP5 has backward compatible PRCM block and it's programming
model is mostly similar to OMAP4. Same is going to be maintained
for future OMAP4 based SOCs. Hence consolidate the OMAP4 power
management code so that it can be re-used on OMAP5 and later devices.

With consolidated code, let basic power management code build
and initialise on OMAP5 devices.

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/mach-omap2/Makefile                       |    9 +-
 arch/arm/mach-omap2/{pm44xx.c => pm_omap4plus.c}   |   87 +++++++++++++-------
 .../mach-omap2/{sleep44xx.S => sleep_omap4plus.S}  |    0
 3 files changed, 60 insertions(+), 36 deletions(-)
 rename arch/arm/mach-omap2/{pm44xx.c => pm_omap4plus.c} (74%)
 rename arch/arm/mach-omap2/{sleep44xx.S => sleep_omap4plus.S} (100%)

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 947cafe..7c3c6b6 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -32,14 +32,14 @@ obj-$(CONFIG_SOC_HAS_OMAP2_SDRC)	+= sdrc.o
 obj-$(CONFIG_SMP)			+= omap-smp.o omap-headsmp.o
 obj-$(CONFIG_HOTPLUG_CPU)		+= omap-hotplug.o
 omap-4-5-common				=  omap4-common.o omap-wakeupgen.o \
-					   sleep44xx.o
+					   sleep_omap4plus.o
 obj-$(CONFIG_ARCH_OMAP4)		+= $(omap-4-5-common)
 obj-$(CONFIG_SOC_OMAP5)			+= $(omap-4-5-common)
 
 plus_sec := $(call as-instr,.arch_extension sec,+sec)
 AFLAGS_omap-headsmp.o			:=-Wa,-march=armv7-a$(plus_sec)
 AFLAGS_omap-smc.o			:=-Wa,-march=armv7-a$(plus_sec)
-AFLAGS_sleep44xx.o			:=-Wa,-march=armv7-a$(plus_sec)
+AFLAGS_sleep_omap4plus.o		:=-Wa,-march=armv7-a$(plus_sec)
 
 # Functions loaded to SRAM
 obj-$(CONFIG_SOC_OMAP2420)		+= sram242x.o
@@ -76,11 +76,12 @@ endif
 obj-$(CONFIG_OMAP_PM_NOOP)		+= omap-pm-noop.o
 
 ifeq ($(CONFIG_PM),y)
+omap4plus-common-pm			=  omap-mpuss-lowpower.o pm_omap4plus.o
 obj-$(CONFIG_ARCH_OMAP2)		+= pm24xx.o
 obj-$(CONFIG_ARCH_OMAP2)		+= sleep24xx.o
 obj-$(CONFIG_ARCH_OMAP3)		+= pm34xx.o sleep34xx.o
-obj-$(CONFIG_ARCH_OMAP4)		+= pm44xx.o omap-mpuss-lowpower.o
-obj-$(CONFIG_SOC_OMAP5)			+= omap-mpuss-lowpower.o
+obj-$(CONFIG_ARCH_OMAP4)		+= $(omap4plus-common-pm)
+obj-$(CONFIG_SOC_OMAP5)			+= $(omap4plus-common-pm)
 obj-$(CONFIG_PM_DEBUG)			+= pm-debug.o
 
 obj-$(CONFIG_POWER_AVS_OMAP)		+= sr_device.o
diff --git a/arch/arm/mach-omap2/pm44xx.c b/arch/arm/mach-omap2/pm_omap4plus.c
similarity index 74%
rename from arch/arm/mach-omap2/pm44xx.c
rename to arch/arm/mach-omap2/pm_omap4plus.c
index 1d03110..95d2712 100644
--- a/arch/arm/mach-omap2/pm44xx.c
+++ b/arch/arm/mach-omap2/pm_omap4plus.c
@@ -1,7 +1,7 @@
 /*
- * OMAP4 Power Management Routines
+ * OMAP4PLUS Power Management Routines
  *
- * Copyright (C) 2010-2011 Texas Instruments, Inc.
+ * Copyright (C) 2010-2013 Texas Instruments, Inc.
  * Rajendra Nayak <rnayak@ti.com>
  * Santosh Shilimkar <santosh.shilimkar@ti.com>
  *
@@ -125,55 +125,77 @@ static void omap_default_idle(void)
 }
 
 /**
- * omap4_pm_init - Init routine for OMAP4 PM
+ * omap4_init_static_deps - Init static clkdm dependencies on OMAP4
  *
- * Initializes all powerdomain and clockdomain target states
- * and all PRCM settings.
+ * The dynamic dependency between MPUSS -> MEMIF and
+ * MPUSS -> L4_PER/L3_* and DUCATI -> L3_* doesn't work as
+ * expected. The hardware recommendation is to enable static
+ * dependencies for these to avoid system lock ups or random crashes.
+ * The L4 wakeup depedency is added to workaround the OCP sync hardware
+ * BUG with 32K synctimer which lead to incorrect timer value read
+ * from the 32K counter. The BUG applies for GPTIMER1 and WDT2 which
+ * are part of L4 wakeup clockdomain.
  */
-int __init omap4_pm_init(void)
+static inline int omap4_init_static_deps(void)
 {
 	int ret;
-	struct clockdomain *emif_clkdm, *mpuss_clkdm, *l3_1_clkdm;
-	struct clockdomain *ducati_clkdm, *l3_2_clkdm;
+	struct clockdomain *emif_clkdm, *mpuss_clkdm, *l3_1_clkdm, *l4wkup;
+	struct clockdomain *ducati_clkdm, *l3_2_clkdm, *l4_per_clkdm;
 
-	if (omap_rev() == OMAP4430_REV_ES1_0) {
-		WARN(1, "Power Management not supported on OMAP4430 ES1.0\n");
-		return -ENODEV;
-	}
-
-	pr_err("Power Management for TI OMAP4.\n");
-
-	ret = pwrdm_for_each(pwrdms_setup, NULL);
-	if (ret) {
-		pr_err("Failed to setup powerdomains\n");
-		goto err2;
-	}
-
-	/*
-	 * The dynamic dependency between MPUSS -> MEMIF and
-	 * MPUSS -> L4_PER/L3_* and DUCATI -> L3_* doesn't work as
-	 * expected. The hardware recommendation is to enable static
-	 * dependencies for these to avoid system lock ups or random crashes.
-	 */
 	mpuss_clkdm = clkdm_lookup("mpuss_clkdm");
 	emif_clkdm = clkdm_lookup("l3_emif_clkdm");
 	l3_1_clkdm = clkdm_lookup("l3_1_clkdm");
 	l3_2_clkdm = clkdm_lookup("l3_2_clkdm");
+	l4_per_clkdm = clkdm_lookup("l4_per_clkdm");
+	l4wkup = clkdm_lookup("l4_wkup_clkdm");
 	ducati_clkdm = clkdm_lookup("ducati_clkdm");
-	if ((!mpuss_clkdm) || (!emif_clkdm) || (!l3_1_clkdm) ||
-		(!l3_2_clkdm) || (!ducati_clkdm))
-		goto err2;
+	if ((!mpuss_clkdm) || (!emif_clkdm) || (!l3_1_clkdm) || (!l4wkup) ||
+		(!l3_2_clkdm) || (!ducati_clkdm) || (!l4_per_clkdm))
+		return -EINVAL;
 
 	ret = clkdm_add_wkdep(mpuss_clkdm, emif_clkdm);
 	ret |= clkdm_add_wkdep(mpuss_clkdm, l3_1_clkdm);
 	ret |= clkdm_add_wkdep(mpuss_clkdm, l3_2_clkdm);
+	ret |= clkdm_add_wkdep(mpuss_clkdm, l4_per_clkdm);
+	ret |= clkdm_add_wkdep(mpuss_clkdm, l4wkup);
 	ret |= clkdm_add_wkdep(ducati_clkdm, l3_1_clkdm);
 	ret |= clkdm_add_wkdep(ducati_clkdm, l3_2_clkdm);
 	if (ret) {
 		pr_err("Failed to add MPUSS -> L3/EMIF/L4PER, DUCATI -> L3 wakeup dependency\n");
+	}
+
+	return ret;
+}
+
+/**
+ * omap4_pm_init - Init routine for OMAP4+ devices
+ *
+ * Initializes all powerdomain and clockdomain target states
+ * and all PRCM settings.
+ */
+int __init omap4_pm_init(void)
+{
+	int ret;
+
+	if (omap_rev() == OMAP4430_REV_ES1_0) {
+		WARN(1, "Power Management not supported on OMAP4430 ES1.0\n");
+		return -ENODEV;
+	}
+
+	pr_info("Power Management for TI OMAP4PLUS devices.\n");
+
+	ret = pwrdm_for_each(pwrdms_setup, NULL);
+	if (ret) {
+		pr_err("Failed to setup powerdomains.\n");
 		goto err2;
 	}
 
+	if (cpu_is_omap44xx()) {
+		ret = omap4_init_static_deps();
+		if (ret)
+			goto err2;
+	}
+
 	ret = omap4_mpuss_init();
 	if (ret) {
 		pr_err("Failed to initialise OMAP4 MPUSS\n");
@@ -186,10 +208,11 @@ int __init omap4_pm_init(void)
 	omap_pm_suspend = omap4_pm_suspend;
 #endif
 
-	/* Overwrite the default cpu_do_idle() */
+	/* Overwrite the default arch_idle() */
 	arm_pm_idle = omap_default_idle;
 
-	omap4_idle_init();
+	if (cpu_is_omap44xx())
+		omap4_idle_init();
 
 err2:
 	return ret;
diff --git a/arch/arm/mach-omap2/sleep44xx.S b/arch/arm/mach-omap2/sleep_omap4plus.S
similarity index 100%
rename from arch/arm/mach-omap2/sleep44xx.S
rename to arch/arm/mach-omap2/sleep_omap4plus.S
-- 
1.7.9.5

