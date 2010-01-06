From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 3/5] OMAP2xxx OPP: clean up comments in OPP data
Date: Wed, 06 Jan 2010 13:44:20 -0700
Message-ID: <20100106204419.15002.63262.stgit@localhost.localdomain>
References: <20100106204346.15002.89343.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:42622 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932625Ab0AFUpy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 6 Jan 2010 15:45:54 -0500
In-Reply-To: <20100106204346.15002.89343.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Richard Woodruff <r-woodruff2@ti.com>

Revise some of the comments in the OMAP2xxx OPP data for clarity.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Richard Woodruff <r-woodruff2@ti.com>
---
 arch/arm/mach-omap2/opp2420_data.c |   38 +++++++++++++++++++-----------------
 arch/arm/mach-omap2/opp2430_data.c |   30 ++++++++++++++--------------
 2 files changed, 35 insertions(+), 33 deletions(-)

diff --git a/arch/arm/mach-omap2/opp2420_data.c b/arch/arm/mach-omap2/opp2420_data.c
index 126a939..e6dda69 100644
--- a/arch/arm/mach-omap2/opp2420_data.c
+++ b/arch/arm/mach-omap2/opp2420_data.c
@@ -9,45 +9,47 @@
  * The OMAP2 processor can be run at several discrete 'PRCM configurations'.
  * These configurations are characterized by voltage and speed for clocks.
  * The device is only validated for certain combinations. One way to express
- * these combinations is via the 'ratio's' which the clocks operate with
+ * these combinations is via the 'ratios' which the clocks operate with
  * respect to each other. These ratio sets are for a given voltage/DPLL
- * setting. All configurations can be described by a DPLL setting and a ratio
- * There are 3 ratio sets for the 2430 and X ratio sets for 2420.
- *
- * 2430 differs from 2420 in that there are no more phase synchronizers used.
- * They both have a slightly different clock domain setup. 2420(iva1,dsp) vs
- * 2430 (iva2.1, NOdsp, mdm)
+ * setting. All configurations can be described by a DPLL setting and a ratio.
  *
  * XXX Missing voltage data.
+ * XXX Missing 19.2MHz sys_clk rate sets (needed for N800/N810)
  *
  * THe format described in this file is deprecated.  Once a reasonable
  * OPP API exists, the data in this file should be converted to use it.
  *
  * This is technically part of the OMAP2xxx clock code.
+ *
+ * Considerable work is still needed to fully support dynamic frequency
+ * changes on OMAP2xxx-series chips.  Readers interested in such a
+ * project are encouraged to review the Maemo Diablo RX-34 and RX-44
+ * kernel source at:
+ *     http://repository.maemo.org/pool/diablo/free/k/kernel-source-diablo/
  */
 
 #include "opp2xxx.h"
 #include "sdrc.h"
 #include "clock.h"
 
-/*-------------------------------------------------------------------------
- * Key dividers which make up a PRCM set. Ratio's for a PRCM are mandated.
+/*
+ * Key dividers which make up a PRCM set. Ratios for a PRCM are mandated.
  * xtal_speed, dpll_speed, mpu_speed, CM_CLKSEL_MPU,
  * CM_CLKSEL_DSP, CM_CLKSEL_GFX, CM_CLKSEL1_CORE, CM_CLKSEL1_PLL,
  * CM_CLKSEL2_PLL, CM_CLKSEL_MDM
  *
- * Filling in table based on H4 boards and 2430-SDPs variants available.
- * There are quite a few more rates combinations which could be defined.
+ * Filling in table based on H4 boards available.  There are quite a
+ * few more rate combinations which could be defined.
  *
- * When multiple values are defined the start up will try and choose the
- * fastest one. If a 'fast' value is defined, then automatically, the /2
- * one should be included as it can be used.	Generally having more that
- * one fast set does not make sense, as static timings need to be changed
- * to change the set.	 The exception is the bypass setting which is
- * availble for low power bypass.
+ * When multiple values are defined the start up will try and choose
+ * the fastest one. If a 'fast' value is defined, then automatically,
+ * the /2 one should be included as it can be used.  Generally having
+ * more than one fast set does not make sense, as static timings need
+ * to be changed to change the set.  The exception is the bypass
+ * setting which is available for low power bypass.
  *
  * Note: This table needs to be sorted, fastest to slowest.
- *-------------------------------------------------------------------------*/
+ **/
 const struct prcm_config omap2420_rate_table[] = {
 	/* PRCM I - FAST */
 	{S12M, S660M, S330M, RI_CM_CLKSEL_MPU_VAL,		/* 330MHz ARM */
diff --git a/arch/arm/mach-omap2/opp2430_data.c b/arch/arm/mach-omap2/opp2430_data.c
index edb8167..1b9596a 100644
--- a/arch/arm/mach-omap2/opp2430_data.c
+++ b/arch/arm/mach-omap2/opp2430_data.c
@@ -1,5 +1,5 @@
 /*
- * opp2420_data.c - old-style "OPP" table for OMAP2420
+ * opp2430_data.c - old-style "OPP" table for OMAP2430
  *
  * Copyright (C) 2005-2009 Texas Instruments, Inc.
  * Copyright (C) 2004-2009 Nokia Corporation
@@ -9,16 +9,16 @@
  * The OMAP2 processor can be run at several discrete 'PRCM configurations'.
  * These configurations are characterized by voltage and speed for clocks.
  * The device is only validated for certain combinations. One way to express
- * these combinations is via the 'ratio's' which the clocks operate with
+ * these combinations is via the 'ratios' which the clocks operate with
  * respect to each other. These ratio sets are for a given voltage/DPLL
- * setting. All configurations can be described by a DPLL setting and a ratio
- * There are 3 ratio sets for the 2430 and X ratio sets for 2420.
+ * setting. All configurations can be described by a DPLL setting and a ratio.
  *
  * 2430 differs from 2420 in that there are no more phase synchronizers used.
  * They both have a slightly different clock domain setup. 2420(iva1,dsp) vs
  * 2430 (iva2.1, NOdsp, mdm)
  *
  * XXX Missing voltage data.
+ * XXX Missing 19.2MHz sys_clk rate sets.
  *
  * THe format described in this file is deprecated.  Once a reasonable
  * OPP API exists, the data in this file should be converted to use it.
@@ -30,24 +30,24 @@
 #include "sdrc.h"
 #include "clock.h"
 
-/*-------------------------------------------------------------------------
- * Key dividers which make up a PRCM set. Ratio's for a PRCM are mandated.
+/*
+ * Key dividers which make up a PRCM set. Ratios for a PRCM are mandated.
  * xtal_speed, dpll_speed, mpu_speed, CM_CLKSEL_MPU,
  * CM_CLKSEL_DSP, CM_CLKSEL_GFX, CM_CLKSEL1_CORE, CM_CLKSEL1_PLL,
  * CM_CLKSEL2_PLL, CM_CLKSEL_MDM
  *
- * Filling in table based on H4 boards and 2430-SDPs variants available.
- * There are quite a few more rates combinations which could be defined.
+ * Filling in table based on 2430-SDPs variants available.  There are
+ * quite a few more rate combinations which could be defined.
  *
- * When multiple values are defined the start up will try and choose the
- * fastest one. If a 'fast' value is defined, then automatically, the /2
- * one should be included as it can be used.	Generally having more that
- * one fast set does not make sense, as static timings need to be changed
- * to change the set.	 The exception is the bypass setting which is
- * availble for low power bypass.
+ * When multiple values are defined the start up will try and choose
+ * the fastest one. If a 'fast' value is defined, then automatically,
+ * the /2 one should be included as it can be used.  Generally having
+ * more than one fast set does not make sense, as static timings need
+ * to be changed to change the set.  The exception is the bypass
+ * setting which is available for low power bypass.
  *
  * Note: This table needs to be sorted, fastest to slowest.
- *-------------------------------------------------------------------------*/
+ */
 const struct prcm_config omap2430_rate_table[] = {
 	/* PRCM #4 - ratio2 (ES2.1) - FAST */
 	{S13M, S798M, S399M, R2_CM_CLKSEL_MPU_VAL,		/* 399MHz ARM */


