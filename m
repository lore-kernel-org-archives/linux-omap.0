From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 14/14] ARM: OMAP2+: Drop legacy sdram timings
Date: Fri, 11 Nov 2016 11:17:11 -0800
Message-ID: <20161111191711.5079-15-tony@atomide.com>
References: <20161111191711.5079-1-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20161111191711.5079-1-tony@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-omap@vger.kernel.org
Cc: Paul Walmsley <paul@pwsan.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

These are no longer used. If somebody needs to configure
memory timings for various idle modes, they should be
implemented as a device driver callbacks from the PM
code.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/sdram-hynix-h8mbx00u0mer-0em.h |  51 ----
 arch/arm/mach-omap2/sdram-micron-mt46h32m32lf-6.h  |  55 ----
 arch/arm/mach-omap2/sdram-nokia.c                  | 299 ---------------------
 arch/arm/mach-omap2/sdram-nokia.h                  |  12 -
 arch/arm/mach-omap2/sdram-numonyx-m65kxxxxam.h     |  51 ----
 .../mach-omap2/sdram-qimonda-hyb18m512160af-6.h    |  54 ----
 6 files changed, 522 deletions(-)
 delete mode 100644 arch/arm/mach-omap2/sdram-hynix-h8mbx00u0mer-0em.h
 delete mode 100644 arch/arm/mach-omap2/sdram-micron-mt46h32m32lf-6.h
 delete mode 100644 arch/arm/mach-omap2/sdram-nokia.c
 delete mode 100644 arch/arm/mach-omap2/sdram-nokia.h
 delete mode 100644 arch/arm/mach-omap2/sdram-numonyx-m65kxxxxam.h
 delete mode 100644 arch/arm/mach-omap2/sdram-qimonda-hyb18m512160af-6.h

diff --git a/arch/arm/mach-omap2/sdram-hynix-h8mbx00u0mer-0em.h b/arch/arm/mach-omap2/sdram-hynix-h8mbx00u0mer-0em.h
deleted file mode 100644
--- a/arch/arm/mach-omap2/sdram-hynix-h8mbx00u0mer-0em.h
+++ /dev/null
@@ -1,51 +0,0 @@
-/*
- * SDRC register values for the Hynix H8MBX00U0MER-0EM
- *
- * Copyright (C) 2009 Texas Instruments, Inc.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-#ifndef __ARCH_ARM_MACH_OMAP2_SDRAM_HYNIX_H8MBX00U0MER0EM
-#define __ARCH_ARM_MACH_OMAP2_SDRAM_HYNIX_H8MBX00U0MER0EM
-
-#include "sdrc.h"
-
-/* Hynix H8MBX00U0MER-0EM */
-static struct omap_sdrc_params h8mbx00u0mer0em_sdrc_params[] = {
-	[0] = {
-		.rate        = 200000000,
-		.actim_ctrla = 0xa2e1b4c6,
-		.actim_ctrlb = 0x0002131c,
-		.rfr_ctrl    = 0x0005e601,
-		.mr          = 0x00000032,
-	},
-	[1] = {
-		.rate        = 166000000,
-		.actim_ctrla = 0x629db4c6,
-		.actim_ctrlb = 0x00012214,
-		.rfr_ctrl    = 0x0004dc01,
-		.mr          = 0x00000032,
-	},
-	[2] = {
-		.rate        = 100000000,
-		.actim_ctrla = 0x51912284,
-		.actim_ctrlb = 0x0002120e,
-		.rfr_ctrl    = 0x0002d101,
-		.mr          = 0x00000022,
-	},
-	[3] = {
-		.rate        = 83000000,
-		.actim_ctrla = 0x31512283,
-		.actim_ctrlb = 0x0001220a,
-		.rfr_ctrl    = 0x00025501,
-		.mr          = 0x00000022,
-	},
-	[4] = {
-		.rate        = 0
-	},
-};
-
-#endif
diff --git a/arch/arm/mach-omap2/sdram-micron-mt46h32m32lf-6.h b/arch/arm/mach-omap2/sdram-micron-mt46h32m32lf-6.h
deleted file mode 100644
--- a/arch/arm/mach-omap2/sdram-micron-mt46h32m32lf-6.h
+++ /dev/null
@@ -1,55 +0,0 @@
-/*
- * SDRC register values for the Micron MT46H32M32LF-6
- *
- * Copyright (C) 2008 Texas Instruments, Inc.
- * Copyright (C) 2008-2009 Nokia Corporation
- *
- * Paul Walmsley
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-#ifndef ARCH_ARM_MACH_OMAP2_SDRAM_MICRON_MT46H32M32LF
-#define ARCH_ARM_MACH_OMAP2_SDRAM_MICRON_MT46H32M32LF
-
-#include "sdrc.h"
-
-/* Micron MT46H32M32LF-6 */
-/* XXX Using ARE = 0x1 (no autorefresh burst) -- can this be changed? */
-static struct omap_sdrc_params mt46h32m32lf6_sdrc_params[] = {
-	[0] = {
-		.rate	     = 166000000,
-		.actim_ctrla = 0x9a9db4c6,
-		.actim_ctrlb = 0x00011217,
-		.rfr_ctrl    = 0x0004dc01,
-		.mr	     = 0x00000032,
-	},
-	[1] = {
-		.rate	     = 165941176,
-		.actim_ctrla = 0x9a9db4c6,
-		.actim_ctrlb = 0x00011217,
-		.rfr_ctrl    = 0x0004dc01,
-		.mr	     = 0x00000032,
-	},
-	[2] = {
-		.rate	     = 83000000,
-		.actim_ctrla = 0x51512283,
-		.actim_ctrlb = 0x0001120c,
-		.rfr_ctrl    = 0x00025501,
-		.mr	     = 0x00000032,
-	},
-	[3] = {
-		.rate	     = 82970588,
-		.actim_ctrla = 0x51512283,
-		.actim_ctrlb = 0x0001120c,
-		.rfr_ctrl    = 0x00025501,
-		.mr	     = 0x00000032,
-	},
-	[4] = {
-		.rate	     = 0
-	},
-};
-
-#endif
diff --git a/arch/arm/mach-omap2/sdram-nokia.c b/arch/arm/mach-omap2/sdram-nokia.c
deleted file mode 100644
--- a/arch/arm/mach-omap2/sdram-nokia.c
+++ /dev/null
@@ -1,299 +0,0 @@
-/*
- * SDRC register values for Nokia boards
- *
- * Copyright (C) 2008, 2010-2011 Nokia Corporation
- *
- * Lauri Leukkunen <lauri.leukkunen@nokia.com>
- *
- * Original code by Juha Yrjola <juha.yrjola@solidboot.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-#include <linux/kernel.h>
-#include <linux/clk.h>
-#include <linux/err.h>
-#include <linux/io.h>
-
-#include "common.h"
-#include "sdram-nokia.h"
-#include "sdrc.h"
-
-/* In picoseconds, except for tREF (ns), tXP, tCKE, tWTR (clks) */
-struct sdram_timings {
-	u32 casl;
-	u32 tDAL;
-	u32 tDPL;
-	u32 tRRD;
-	u32 tRCD;
-	u32 tRP;
-	u32 tRAS;
-	u32 tRC;
-	u32 tRFC;
-	u32 tXSR;
-
-	u32 tREF; /* in ns */
-
-	u32 tXP;
-	u32 tCKE;
-	u32 tWTR;
-};
-
-static const struct sdram_timings nokia_97dot6mhz_timings[] = {
-	{
-		.casl = 3,
-		.tDAL = 30725,
-		.tDPL = 15362,
-		.tRRD = 10241,
-		.tRCD = 20483,
-		.tRP = 15362,
-		.tRAS = 40967,
-		.tRC = 56330,
-		.tRFC = 138266,
-		.tXSR = 204839,
-
-		.tREF = 7798,
-
-		.tXP = 2,
-		.tCKE = 4,
-		.tWTR = 2,
-	},
-};
-
-static const struct sdram_timings nokia_166mhz_timings[] = {
-	{
-		.casl = 3,
-		.tDAL = 33000,
-		.tDPL = 15000,
-		.tRRD = 12000,
-		.tRCD = 22500,
-		.tRP = 18000,
-		.tRAS = 42000,
-		.tRC = 66000,
-		.tRFC = 138000,
-		.tXSR = 200000,
-
-		.tREF = 7800,
-
-		.tXP = 2,
-		.tCKE = 2,
-		.tWTR = 2
-	},
-};
-
-static const struct sdram_timings nokia_195dot2mhz_timings[] = {
-	{
-		.casl = 3,
-		.tDAL = 30725,
-		.tDPL = 15362,
-		.tRRD = 10241,
-		.tRCD = 20483,
-		.tRP = 15362,
-		.tRAS = 40967,
-		.tRC = 56330,
-		.tRFC = 138266,
-		.tXSR = 204839,
-
-		.tREF = 7752,
-
-		.tXP = 2,
-		.tCKE = 4,
-		.tWTR = 2,
-	},
-};
-
-static const struct sdram_timings nokia_200mhz_timings[] = {
-	{
-		.casl = 3,
-		.tDAL = 30000,
-		.tDPL = 15000,
-		.tRRD = 10000,
-		.tRCD = 20000,
-		.tRP = 15000,
-		.tRAS = 40000,
-		.tRC = 55000,
-		.tRFC = 140000,
-		.tXSR = 200000,
-
-		.tREF = 7800,
-
-		.tXP = 2,
-		.tCKE = 4,
-		.tWTR = 2
-	},
-};
-
-static const struct {
-	long rate;
-	struct sdram_timings const *data;
-} nokia_timings[] = {
-	{ 83000000, nokia_166mhz_timings },
-	{ 97600000, nokia_97dot6mhz_timings },
-	{ 100000000, nokia_200mhz_timings },
-	{ 166000000, nokia_166mhz_timings },
-	{ 195200000, nokia_195dot2mhz_timings },
-	{ 200000000, nokia_200mhz_timings },
-};
-static struct omap_sdrc_params nokia_sdrc_params[ARRAY_SIZE(nokia_timings) + 1];
-
-static unsigned long sdrc_get_fclk_period(long rate)
-{
-	/* In picoseconds */
-	return 1000000000 / rate;
-}
-
-static unsigned int sdrc_ps_to_ticks(unsigned int time_ps, long rate)
-{
-	unsigned long tick_ps;
-
-	/* Calculate in picosecs to yield more exact results */
-	tick_ps = sdrc_get_fclk_period(rate);
-
-	return (time_ps + tick_ps - 1) / tick_ps;
-}
-#undef DEBUG
-#ifdef DEBUG
-static int set_sdrc_timing_regval(u32 *regval, int st_bit, int end_bit,
-				int ticks, long rate, const char *name)
-#else
-static int set_sdrc_timing_regval(u32 *regval, int st_bit, int end_bit,
-			       int ticks)
-#endif
-{
-	int mask, nr_bits;
-
-	nr_bits = end_bit - st_bit + 1;
-	if (ticks >= 1 << nr_bits)
-		return -1;
-	mask = (1 << nr_bits) - 1;
-	*regval &= ~(mask << st_bit);
-	*regval |= ticks << st_bit;
-#ifdef DEBUG
-	printk(KERN_INFO "SDRC %s: %i ticks %i ns\n", name, ticks,
-			(unsigned int)sdrc_get_fclk_period(rate) * ticks /
-			1000);
-#endif
-
-	return 0;
-}
-
-#ifdef DEBUG
-#define SDRC_SET_ONE(reg, st, end, field, rate) \
-	if (set_sdrc_timing_regval((reg), (st), (end), \
-			memory_timings->field, (rate), #field) < 0) \
-		err = -1;
-#else
-#define SDRC_SET_ONE(reg, st, end, field, rate) \
-	if (set_sdrc_timing_regval((reg), (st), (end), \
-			memory_timings->field) < 0) \
-		err = -1;
-#endif
-
-#ifdef DEBUG
-static int set_sdrc_timing_regval_ps(u32 *regval, int st_bit, int end_bit,
-				int time, long rate, const char *name)
-#else
-static int set_sdrc_timing_regval_ps(u32 *regval, int st_bit, int end_bit,
-				int time, long rate)
-#endif
-{
-	int ticks, ret;
-	ret = 0;
-
-	if (time == 0)
-		ticks = 0;
-	else
-		ticks = sdrc_ps_to_ticks(time, rate);
-
-#ifdef DEBUG
-	ret = set_sdrc_timing_regval(regval, st_bit, end_bit, ticks,
-				     rate, name);
-#else
-	ret = set_sdrc_timing_regval(regval, st_bit, end_bit, ticks);
-#endif
-
-	return ret;
-}
-
-#ifdef DEBUG
-#define SDRC_SET_ONE_PS(reg, st, end, field, rate) \
-	if (set_sdrc_timing_regval_ps((reg), (st), (end), \
-			memory_timings->field, \
-			(rate), #field) < 0) \
-		err = -1;
-
-#else
-#define SDRC_SET_ONE_PS(reg, st, end, field, rate) \
-	if (set_sdrc_timing_regval_ps((reg), (st), (end), \
-			memory_timings->field, (rate)) < 0) \
-		err = -1;
-#endif
-
-static int sdrc_timings(int id, long rate,
-			const struct sdram_timings *memory_timings)
-{
-	u32 ticks_per_ms;
-	u32 rfr, l;
-	u32 actim_ctrla = 0, actim_ctrlb = 0;
-	u32 rfr_ctrl;
-	int err = 0;
-	long l3_rate = rate / 1000;
-
-	SDRC_SET_ONE_PS(&actim_ctrla,  0,  4, tDAL, l3_rate);
-	SDRC_SET_ONE_PS(&actim_ctrla,  6,  8, tDPL, l3_rate);
-	SDRC_SET_ONE_PS(&actim_ctrla,  9, 11, tRRD, l3_rate);
-	SDRC_SET_ONE_PS(&actim_ctrla, 12, 14, tRCD, l3_rate);
-	SDRC_SET_ONE_PS(&actim_ctrla, 15, 17, tRP, l3_rate);
-	SDRC_SET_ONE_PS(&actim_ctrla, 18, 21, tRAS, l3_rate);
-	SDRC_SET_ONE_PS(&actim_ctrla, 22, 26, tRC, l3_rate);
-	SDRC_SET_ONE_PS(&actim_ctrla, 27, 31, tRFC, l3_rate);
-
-	SDRC_SET_ONE_PS(&actim_ctrlb,  0,  7, tXSR, l3_rate);
-
-	SDRC_SET_ONE(&actim_ctrlb,  8, 10, tXP, l3_rate);
-	SDRC_SET_ONE(&actim_ctrlb, 12, 14, tCKE, l3_rate);
-	SDRC_SET_ONE(&actim_ctrlb, 16, 17, tWTR, l3_rate);
-
-	ticks_per_ms = l3_rate;
-	rfr = memory_timings[0].tREF * ticks_per_ms / 1000000;
-	if (rfr > 65535 + 50)
-		rfr = 65535;
-	else
-		rfr -= 50;
-
-#ifdef DEBUG
-	printk(KERN_INFO "SDRC tREF: %i ticks\n", rfr);
-#endif
-
-	l = rfr << 8;
-	rfr_ctrl = l | 0x1; /* autorefresh, reload counter with 1xARCV */
-
-	nokia_sdrc_params[id].rate = rate;
-	nokia_sdrc_params[id].actim_ctrla = actim_ctrla;
-	nokia_sdrc_params[id].actim_ctrlb = actim_ctrlb;
-	nokia_sdrc_params[id].rfr_ctrl = rfr_ctrl;
-	nokia_sdrc_params[id].mr = 0x32;
-
-	nokia_sdrc_params[id + 1].rate = 0;
-
-	return err;
-}
-
-struct omap_sdrc_params *nokia_get_sdram_timings(void)
-{
-	int err = 0;
-	int i;
-
-	for (i = 0; i < ARRAY_SIZE(nokia_timings); i++) {
-		err |= sdrc_timings(i, nokia_timings[i].rate,
-				       nokia_timings[i].data);
-		if (err)
-			pr_err("%s: error with rate %ld: %d\n", __func__,
-			       nokia_timings[i].rate, err);
-	}
-
-	return err ? NULL : nokia_sdrc_params;
-}
-
diff --git a/arch/arm/mach-omap2/sdram-nokia.h b/arch/arm/mach-omap2/sdram-nokia.h
deleted file mode 100644
--- a/arch/arm/mach-omap2/sdram-nokia.h
+++ /dev/null
@@ -1,12 +0,0 @@
-/*
- * SDRC register values for Nokia boards
- *
- * Copyright (C) 2010 Nokia
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-struct omap_sdrc_params *nokia_get_sdram_timings(void);
-
diff --git a/arch/arm/mach-omap2/sdram-numonyx-m65kxxxxam.h b/arch/arm/mach-omap2/sdram-numonyx-m65kxxxxam.h
deleted file mode 100644
--- a/arch/arm/mach-omap2/sdram-numonyx-m65kxxxxam.h
+++ /dev/null
@@ -1,51 +0,0 @@
-/*
- * SDRC register values for the Numonyx M65KXXXXAM
- *
- * Copyright (C) 2009 Integration Software and Electronic Engineering.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-#ifndef __ARCH_ARM_MACH_OMAP2_SDRAM_NUMONYX_M65KXXXXAM
-#define __ARCH_ARM_MACH_OMAP2_SDRAM_NUMONYX_M65KXXXXAM
-
-#include "sdrc.h"
-
-/* Numonyx  M65KXXXXAM */
-static struct omap_sdrc_params m65kxxxxam_sdrc_params[] = {
-	[0] = {
-		.rate		= 200000000,
-		.actim_ctrla	= 0xe321d4c6,
-		.actim_ctrlb	= 0x00022328,
-		.rfr_ctrl	= 0x0005e601,
-		.mr		= 0x00000032,
-	},
-	[1] = {
-		.rate		= 166000000,
-		.actim_ctrla	= 0xba9dc485,
-		.actim_ctrlb	= 0x00022321,
-		.rfr_ctrl	= 0x0004dc01,
-		.mr		= 0x00000032,
-	},
-	[2] = {
-		.rate		= 133000000,
-		.actim_ctrla	= 0x9a19b485,
-		.actim_ctrlb	= 0x0002231b,
-		.rfr_ctrl	= 0x0003de01,
-		.mr		= 0x00000032,
-	},
-	[3] = {
-		.rate		= 83000000,
-		.actim_ctrla	= 0x594ca242,
-		.actim_ctrlb	= 0x00022310,
-		.rfr_ctrl	= 0x00025501,
-		.mr		= 0x00000032,
-	},
-	[4] = {
-		.rate			= 0
-	},
-};
-
-#endif
diff --git a/arch/arm/mach-omap2/sdram-qimonda-hyb18m512160af-6.h b/arch/arm/mach-omap2/sdram-qimonda-hyb18m512160af-6.h
deleted file mode 100644
--- a/arch/arm/mach-omap2/sdram-qimonda-hyb18m512160af-6.h
+++ /dev/null
@@ -1,54 +0,0 @@
-/*
- * SDRC register values for the Qimonda HYB18M512160AF-6
- *
- * Copyright (C) 2008-2009 Texas Instruments, Inc.
- * Copyright (C) 2008-2009 Nokia Corporation
- *
- * Paul Walmsley
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-#ifndef ARCH_ARM_MACH_OMAP2_SDRAM_QIMONDA_HYB18M512160AF6
-#define ARCH_ARM_MACH_OMAP2_SDRAM_QIMONDA_HYB18M512160AF6
-
-#include "sdrc.h"
-
-/* Qimonda HYB18M512160AF-6 */
-static struct omap_sdrc_params hyb18m512160af6_sdrc_params[] = {
-	[0] = {
-		.rate	     = 166000000,
-		.actim_ctrla = 0x629db4c6,
-		.actim_ctrlb = 0x00012214,
-		.rfr_ctrl    = 0x0004dc01,
-		.mr	     = 0x00000032,
-	},
-	[1] = {
-		.rate	     = 165941176,
-		.actim_ctrla = 0x629db4c6,
-		.actim_ctrlb = 0x00012214,
-		.rfr_ctrl    = 0x0004dc01,
-		.mr	     = 0x00000032,
-	},
-	[2] = {
-		.rate	     = 83000000,
-		.actim_ctrla = 0x31512283,
-		.actim_ctrlb = 0x0001220a,
-		.rfr_ctrl    = 0x00025501,
-		.mr	     = 0x00000022,
-	},
-	[3] = {
-		.rate	     = 82970588,
-		.actim_ctrla = 0x31512283,
-		.actim_ctrlb = 0x0001220a,
-		.rfr_ctrl    = 0x00025501,
-		.mr	     = 0x00000022,
-	},
-	[4] = {
-		.rate	     = 0
-	},
-};
-
-#endif
-- 
2.10.2
