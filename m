From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 03/10 V3] omap3: pm: use opp accessor functions for omap34xx
Date: Wed, 25 Nov 2009 09:27:05 -0800
Message-ID: <87ocmqh5w6.fsf@deeprootsystems.com>
References: <1259122159-1583-1-git-send-email-nm@ti.com>
	<1259122159-1583-2-git-send-email-nm@ti.com>
	<1259122159-1583-3-git-send-email-nm@ti.com>
	<1259122159-1583-4-git-send-email-nm@ti.com>
	<87tywih64f.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f42.google.com ([209.85.160.42]:62022 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758839AbZKYR1B (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 25 Nov 2009 12:27:01 -0500
Received: by pwi3 with SMTP id 3so5008303pwi.21
        for <linux-omap@vger.kernel.org>; Wed, 25 Nov 2009 09:27:07 -0800 (PST)
In-Reply-To: <87tywih64f.fsf@deeprootsystems.com> (Kevin Hilman's message of "Wed\, 25 Nov 2009 09\:22\:08 -0800")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>

Kevin Hilman <khilman@deeprootsystems.com> writes:

[...]

> I've attached a patch that applies on top of your series 

Forgot the patch.  Here it is.

Kevin

commit 2979ad2ad596618e179f1292e6e7e37d55830096
Author: Kevin Hilman <khilman@deeprootsystems.com>
Date:   Wed Nov 25 09:12:17 2009 -0800

    OMAP3: PM: remove OPP interfaces from OMAP PM layer

diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index 91bcfbf..e2f44ec 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -319,7 +319,7 @@ void __init omap2_init_common_hw(struct omap_sdrc_params *sdrc_cs0,
 	/* The OPP tables have to be registered before a clk init */
 	omap_hwmod_init(hwmods);
 	omap2_mux_init();
-	omap_pm_if_early_init(mpu_opps, dsp_opps, l3_opps);
+	omap_pm_if_early_init();
 	pwrdm_init(powerdomains_omap);
 	clkdm_init(clockdomains_omap, clkdm_pwrdm_autodeps);
 	omap2_clk_init();
diff --git a/arch/arm/mach-omap2/resource34xx.h b/arch/arm/mach-omap2/resource34xx.h
index b6f31a9..0b4e76e 100644
--- a/arch/arm/mach-omap2/resource34xx.h
+++ b/arch/arm/mach-omap2/resource34xx.h
@@ -27,7 +27,7 @@
 #include <plat/powerdomain.h>
 #include <plat/resource.h>
 #include <plat/clock.h>
-#include <plat/omap-pm.h>
+#include <plat/opp.h>
 #include <plat/omap34xx.h>
 
 extern int sr_voltagescale_vcbypass(u32 t_opp, u32 c_opp, u8 t_vsel, u8 c_vsel);
diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/smartreflex.c
index 6f8b7cc..c399aea 100644
--- a/arch/arm/mach-omap2/smartreflex.c
+++ b/arch/arm/mach-omap2/smartreflex.c
@@ -30,7 +30,7 @@
 #include <plat/omap34xx.h>
 #include <plat/control.h>
 #include <plat/clock.h>
-#include <plat/omap-pm.h>
+#include <plat/opp.h>
 
 #include "prm.h"
 #include "smartreflex.h"
diff --git a/arch/arm/plat-omap/cpu-omap.c b/arch/arm/plat-omap/cpu-omap.c
index 7b3ca11..29e4826 100644
--- a/arch/arm/plat-omap/cpu-omap.c
+++ b/arch/arm/plat-omap/cpu-omap.c
@@ -32,6 +32,7 @@
 
 #if defined(CONFIG_ARCH_OMAP3) && !defined(CONFIG_OMAP_PM_NONE)
 #include <plat/omap-pm.h>
+#include <plat/opp.h>
 #endif
 
 #define VERY_HI_RATE	900000000
diff --git a/arch/arm/plat-omap/include/plat/omap-pm.h b/arch/arm/plat-omap/include/plat/omap-pm.h
index aa36339..bdc11f2 100644
--- a/arch/arm/plat-omap/include/plat/omap-pm.h
+++ b/arch/arm/plat-omap/include/plat/omap-pm.h
@@ -20,10 +20,6 @@
 #include "powerdomain.h"
 #include <plat/opp.h>
 
-extern struct omap_opp *mpu_opps;
-extern struct omap_opp *dsp_opps;
-extern struct omap_opp *l3_opps;
-
 /*
  * agent_id values for use with omap_pm_set_min_bus_tput():
  *
@@ -46,11 +42,9 @@ extern struct omap_opp *l3_opps;
  * PM idle-loop code.
  */
 #ifdef CONFIG_OMAP_PM_NONE
-#define omap_pm_if_early_init(a, b, c) 0
+#define omap_pm_if_early_init() 0
 #else
-int __init omap_pm_if_early_init(struct omap_opp *mpu_opp_table,
-				 struct omap_opp *dsp_opp_table,
-				 struct omap_opp *l3_opp_table);
+int __init omap_pm_if_early_init(void);
 #endif
 
 /**
@@ -197,68 +191,6 @@ void omap_pm_set_max_dev_wakeup_lat(struct device *dev, long t);
  */
 void omap_pm_set_max_sdma_lat(struct device *dev, long t);
 
-
-/*
- * DSP Bridge-specific constraints
- */
-
-/**
- * omap_pm_dsp_get_opp_table - get OPP->DSP clock frequency table
- *
- * Intended for use by DSPBridge.  Returns an array of OPP->DSP clock
- * frequency entries.  The final item in the array should have .rate =
- * .opp_id = 0.
- */
-const struct omap_opp *omap_pm_dsp_get_opp_table(void);
-
-/**
- * omap_pm_dsp_set_min_opp - receive desired OPP target ID from DSP Bridge
- * @opp_id: target DSP OPP ID
- *
- * Set a minimum OPP ID for the DSP.  This is intended to be called
- * only from the DSP Bridge MPU-side driver.  Unfortunately, the only
- * information that code receives from the DSP/BIOS load estimator is the
- * target OPP ID; hence, this interface.  No return value.
- */
-void omap_pm_dsp_set_min_opp(u8 opp_id);
-
-/**
- * omap_pm_dsp_get_opp - report the current DSP OPP ID
- *
- * Report the current OPP for the DSP.  Since on OMAP3, the DSP and
- * MPU share a single voltage domain, the OPP ID returned back may
- * represent a higher DSP speed than the OPP requested via
- * omap_pm_dsp_set_min_opp().
- *
- * Returns the current VDD1 OPP ID, or 0 upon error.
- */
-u8 omap_pm_dsp_get_opp(void);
-
-/**
- * omap_pm_vdd1_get_opp - report the current VDD1 OPP
- *
- * Report the current VDD1 OPP number.
- *
- * Returns the current VDD1 OPP ID, or 0 upon error.
- */
-u8 omap_pm_vdd1_get_opp(void);
-
-/**
- * omap_pm_vdd2_get_opp - report the current VDD2 OPP
- *
- * Report the current VDD2 OPP number.
- *
- * Returns the current VDD2 OPP ID, or 0 upon error.
- */
-u8 omap_pm_vdd2_get_opp(void);
-
-/*
- * CPUFreq-originated constraint
- *
- * In the future, this should be handled by custom OPP clocktype
- * functions.
- */
-
 /**
  * omap_pm_cpu_get_freq_table - return a cpufreq_frequency_table array ptr
  *
diff --git a/arch/arm/plat-omap/include/plat/opp.h b/arch/arm/plat-omap/include/plat/opp.h
index d8ae2d3..fedbf44 100644
--- a/arch/arm/plat-omap/include/plat/opp.h
+++ b/arch/arm/plat-omap/include/plat/opp.h
@@ -13,6 +13,10 @@
 #ifndef __ASM_ARM_OMAP_OPP_H
 #define __ASM_ARM_OMAP_OPP_H
 
+extern struct omap_opp *mpu_opps;
+extern struct omap_opp *dsp_opps;
+extern struct omap_opp *l3_opps;
+
 /**
  * struct omap_opp - OMAP OPP description structure
  * @enabled:	true/false - marking this OPP as enabled/disabled
diff --git a/arch/arm/plat-omap/omap-pm-noop.c b/arch/arm/plat-omap/omap-pm-noop.c
index cab105f..7932241 100644
--- a/arch/arm/plat-omap/omap-pm-noop.c
+++ b/arch/arm/plat-omap/omap-pm-noop.c
@@ -299,13 +299,8 @@ int omap_pm_get_dev_context_loss_count(struct device *dev)
 
 
 /* Should be called before clk framework init */
-int __init omap_pm_if_early_init(struct omap_opp *mpu_opp_table,
-				 struct omap_opp *dsp_opp_table,
-				 struct omap_opp *l3_opp_table)
+int __init omap_pm_if_early_init()
 {
-	mpu_opps = mpu_opp_table;
-	dsp_opps = dsp_opp_table;
-	l3_opps = l3_opp_table;
 	return 0;
 }
 
diff --git a/arch/arm/plat-omap/omap-pm-srf.c b/arch/arm/plat-omap/omap-pm-srf.c
index 4a0bfbe..5cfefbd 100644
--- a/arch/arm/plat-omap/omap-pm-srf.c
+++ b/arch/arm/plat-omap/omap-pm-srf.c
@@ -296,13 +296,8 @@ int omap_pm_get_dev_context_loss_count(struct device *dev)
 /*
  * Must be called before clk framework init
  */
-int __init omap_pm_if_early_init(struct omap_opp *mpu_opp_table,
-				 struct omap_opp *dsp_opp_table,
-				 struct omap_opp *l3_opp_table)
+int __init omap_pm_if_early_init(void)
 {
-	mpu_opps = mpu_opp_table;
-	dsp_opps = dsp_opp_table;
-	l3_opps = l3_opp_table;
 	return 0;
 }
 


