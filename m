From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] omap: Enable GPMC clock in gpmc_init
Date: Wed, 20 Jan 2010 18:32:04 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1001201831141.3977@utopia.booyaka.com>
References: <20100120223929.GA10739@lixom.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:60097 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751433Ab0AUBcM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 20 Jan 2010 20:32:12 -0500
In-Reply-To: <20100120223929.GA10739@lixom.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Olof Johansson <olof@lixom.net>
Cc: tony@atomide.com, linux-omap@vger.kernel.org

Hello Olof,

On Wed, 20 Jan 2010, Olof Johansson wrote:

> Don't assume that gpmc_l3_clk is on, enable it before touching
> configuration registers.
> 
> Signed-off-by: Olof Johansson <olof@lixom.net>
> 
> 
> diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
> index e86f5ca..dea72f3 100644
> --- a/arch/arm/mach-omap2/gpmc.c
> +++ b/arch/arm/mach-omap2/gpmc.c
> @@ -534,6 +534,8 @@ void __init gpmc_init(void)
>  		BUG();
>  	}
>  
> +	clk_enable(gpmc_l3_clk);
> +
>  	l = gpmc_read_reg(GPMC_REVISION);
>  	printk(KERN_INFO "GPMC revision %d.%d\n", (l >> 4) & 0x0f, l & 0x0f);
>  	/* Set smart idle mode and automatic L3 clock gating */

Care to try an approach similar to the following?  Compile-tested, but 
otherwise untested.


- Paul

>From 93bef5c90eed5247cfeada601beacdc734891924 Mon Sep 17 00:00:00 2001
From: Paul Walmsley <paul@pwsan.com>
Date: Wed, 20 Jan 2010 18:16:18 -0700
Subject: [PATCH] OMAP GPMC: add fine-grained clock control

OMAP4 GPMC has a software-controllable GPMC clock gate, so, take
advantage of it by only enabling the GPMC clock when needed.  Since
OMAP2xxx/3 don't have a separate software-controllable GPMC clock,
this change should not affect these platforms, aside from slowing some
of the gpmc.c functions down slightly.

Also rename "gpmc_l3_clk" to the more generic "gpmc_clk".

Since the GPMC clock is now enabled and disabled on demand, the
ENABLE_ON_INIT clock flag can be removed from the GPMC clocks; do so.

While here, add some to-do items to the initial comment block.

Finally, add a gpmc_ocp_barrier() function, intended to ensure that
all register writes to the GPMC are complete before disabling the GPMC
clock.  Barriers are added where they appear to be needed.
---
 arch/arm/mach-omap2/clock2xxx_data.c |    1 -
 arch/arm/mach-omap2/clock34xx_data.c |    1 -
 arch/arm/mach-omap2/gpmc.c           |   92 ++++++++++++++++++++++++++++------
 3 files changed, 76 insertions(+), 18 deletions(-)

diff --git a/arch/arm/mach-omap2/clock2xxx_data.c b/arch/arm/mach-omap2/clock2xxx_data.c
index 97dc7cf..0997104 100644
--- a/arch/arm/mach-omap2/clock2xxx_data.c
+++ b/arch/arm/mach-omap2/clock2xxx_data.c
@@ -1804,7 +1804,6 @@ static struct clk gpmc_fck = {
 	.name		= "gpmc_fck",
 	.ops		= &clkops_null, /* RMK: missing? */
 	.parent		= &core_l3_ck,
-	.flags		= ENABLE_ON_INIT,
 	.clkdm_name	= "core_l3_clkdm",
 	.recalc		= &followparent_recalc,
 };
diff --git a/arch/arm/mach-omap2/clock34xx_data.c b/arch/arm/mach-omap2/clock34xx_data.c
index c6031d7..fab9e5b 100644
--- a/arch/arm/mach-omap2/clock34xx_data.c
+++ b/arch/arm/mach-omap2/clock34xx_data.c
@@ -1654,7 +1654,6 @@ static struct clk gpmc_fck = {
 	.name		= "gpmc_fck",
 	.ops		= &clkops_null,
 	.parent		= &core_l3_ick,
-	.flags		= ENABLE_ON_INIT, /* huh? */
 	.clkdm_name	= "core_l3_clkdm",
 	.recalc		= &followparent_recalc,
 };
diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
index 3f1334f..3ccd1d5 100644
--- a/arch/arm/mach-omap2/gpmc.c
+++ b/arch/arm/mach-omap2/gpmc.c
@@ -1,7 +1,7 @@
 /*
  * GPMC support functions
  *
- * Copyright (C) 2005-2006 Nokia Corporation
+ * Copyright (C) 2005-2006, 2010 Nokia Corporation
  *
  * Author: Juha Yrjola
  *
@@ -11,6 +11,20 @@
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
+ *
+ * XXX Convert this to an early platform driver or something similar
+ *
+ * XXX This code is missing support for some of the OMAP3 GPMC features,
+ * such as CYCLE2CYCLESAMECSEN, CYCLE2CYCLEDIFFCSEN, CYCLE2CYCLEDELAY,
+ * BUSTURNAROUND, etc.
+ *
+ * XXX It's insufficient for the GPMC timing setup code to only take
+ * into account the target chip timing parameters - it must also take
+ * into consideration board timing parameters.  For example, bus level
+ * translators between the OMAP and the target chip can introduce
+ * latency that can affect timings.  In some extreme cases, PCB
+ * transmission line effects (e.g., rise time, fall time) may also
+ * need to be taken into account.
  */
 #undef DEBUG
 
@@ -96,7 +110,7 @@ static unsigned		gpmc_cs_map;
 
 static void __iomem *gpmc_base;
 
-static struct clk *gpmc_l3_clk;
+static struct clk *gpmc_clk;
 
 static void gpmc_write_reg(int idx, u32 val)
 {
@@ -108,6 +122,11 @@ static u32 gpmc_read_reg(int idx)
 	return __raw_readl(gpmc_base + idx);
 }
 
+static void gpmc_ocp_barrier(void)
+{
+	gpmc_read_reg(GPMC_REVISION);
+}
+
 void gpmc_cs_write_reg(int cs, int idx, u32 val)
 {
 	void __iomem *reg_addr;
@@ -124,13 +143,12 @@ u32 gpmc_cs_read_reg(int cs, int idx)
 	return __raw_readl(reg_addr);
 }
 
-/* TODO: Add support for gpmc_fck to clock framework and use it */
 unsigned long gpmc_get_fclk_period(void)
 {
-	unsigned long rate = clk_get_rate(gpmc_l3_clk);
+	unsigned long rate = clk_get_rate(gpmc_clk);
 
 	if (rate == 0) {
-		printk(KERN_WARNING "gpmc_l3_clk not enabled\n");
+		printk(KERN_WARNING "gpmc_clk not enabled\n");
 		return 0;
 	}
 
@@ -212,6 +230,7 @@ static int set_gpmc_timing_reg(int cs, int reg, int st_bit, int end_bit,
 		return -1
 #endif
 
+/* XXX static? */
 int gpmc_cs_calc_divider(int cs, unsigned int sync_clk)
 {
 	int div;
@@ -232,6 +251,8 @@ int gpmc_cs_set_timings(int cs, const struct gpmc_timings *t)
 	int div;
 	u32 l;
 
+	clk_enable(gpmc_clk);
+
 	div = gpmc_cs_calc_divider(cs, t->sync_clk);
 	if (div < 0)
 		return -1;
@@ -274,6 +295,8 @@ int gpmc_cs_set_timings(int cs, const struct gpmc_timings *t)
 		gpmc_cs_write_reg(cs, GPMC_CS_CONFIG1, l);
 	}
 
+	clk_disable(gpmc_clk);
+
 	return 0;
 }
 
@@ -380,6 +403,8 @@ int gpmc_cs_request(int cs, unsigned long size, unsigned long *base)
 	if (size > (1 << GPMC_SECTION_SHIFT))
 		return -ENOMEM;
 
+	clk_enable(gpmc_clk);
+
 	spin_lock(&gpmc_mem_lock);
 	if (gpmc_cs_reserved(cs)) {
 		r = -EBUSY;
@@ -398,23 +423,26 @@ int gpmc_cs_request(int cs, unsigned long size, unsigned long *base)
 	gpmc_cs_set_reserved(cs, 1);
 out:
 	spin_unlock(&gpmc_mem_lock);
+	clk_disable(gpmc_clk);
 	return r;
 }
 EXPORT_SYMBOL(gpmc_cs_request);
 
 void gpmc_cs_free(int cs)
 {
+	clk_enable(gpmc_clk);
 	spin_lock(&gpmc_mem_lock);
 	if (cs >= GPMC_CS_NUM || cs < 0 || !gpmc_cs_reserved(cs)) {
 		printk(KERN_ERR "Trying to free non-reserved GPMC CS%d\n", cs);
 		BUG();
-		spin_unlock(&gpmc_mem_lock);
-		return;
+		goto gcf_exit;
 	}
 	gpmc_cs_disable_mem(cs);
 	release_resource(&gpmc_cs_mem[cs]);
 	gpmc_cs_set_reserved(cs, 0);
+gcf_exit:
 	spin_unlock(&gpmc_mem_lock);
+	clk_disable(gpmc_clk);
 }
 EXPORT_SYMBOL(gpmc_cs_free);
 
@@ -430,6 +458,8 @@ int gpmc_prefetch_enable(int cs, int dma_mode,
 {
 	uint32_t prefetch_config1;
 
+	clk_enable(gpmc_clk);
+
 	if (!(gpmc_read_reg(GPMC_PREFETCH_CONTROL))) {
 		/* Set the amount of bytes to be prefetched */
 		gpmc_write_reg(GPMC_PREFETCH_CONFIG2, u32_count);
@@ -463,15 +493,30 @@ void gpmc_prefetch_reset(void)
 
 	/* Reset/disable the PFPW engine */
 	gpmc_write_reg(GPMC_PREFETCH_CONFIG1, 0x0);
+
+	/*
+	 * Ensure the register write completes before disabling the
+	 * functional clock.  XXX Is some additional delay needed here
+	 * to wait for the PFPW engine to fully stop?
+	 */
+	gpmc_ocp_barrier();
+
+	clk_disable(gpmc_clk);
 }
 EXPORT_SYMBOL(gpmc_prefetch_reset);
 
 /**
  * gpmc_prefetch_status - reads prefetch status of engine
  */
-int  gpmc_prefetch_status(void)
+int gpmc_prefetch_status(void)
 {
-	return gpmc_read_reg(GPMC_PREFETCH_STATUS);
+	u32 v;
+
+	clk_enable(gpmc_clk);
+	v = gpmc_read_reg(GPMC_PREFETCH_STATUS);
+	clk_disable(gpmc_clk);
+
+	return v;
 }
 EXPORT_SYMBOL(gpmc_prefetch_status);
 
@@ -499,42 +544,41 @@ static void __init gpmc_mem_init(void)
 		gpmc_cs_get_memconf(cs, &base, &size);
 		if (gpmc_cs_insert_mem(cs, base, size) < 0)
 			BUG();
+		clk_enable(gpmc_clk);
 	}
 }
 
 void __init gpmc_init(void)
 {
 	u32 l;
-	char *ck;
+	char *ck = "gpmc_fck";
 
 	if (cpu_is_omap24xx()) {
-		ck = "core_l3_ck";
 		if (cpu_is_omap2420())
 			l = OMAP2420_GPMC_BASE;
 		else
 			l = OMAP34XX_GPMC_BASE;
 	} else if (cpu_is_omap34xx()) {
-		ck = "gpmc_fck";
 		l = OMAP34XX_GPMC_BASE;
 	} else if (cpu_is_omap44xx()) {
 		ck = "gpmc_ck";
 		l = OMAP44XX_GPMC_BASE;
 	}
 
-	gpmc_l3_clk = clk_get(NULL, ck);
-	if (IS_ERR(gpmc_l3_clk)) {
+	gpmc_clk = clk_get(NULL, ck);
+	if (IS_ERR(gpmc_clk)) {
 		printk(KERN_ERR "Could not get GPMC clock %s\n", ck);
 		BUG();
 	}
 
 	gpmc_base = ioremap(l, SZ_4K);
 	if (!gpmc_base) {
-		clk_put(gpmc_l3_clk);
+		clk_put(gpmc_clk);
 		printk(KERN_ERR "Could not get GPMC register memory\n");
 		BUG();
 	}
 
-	clk_enable(gpmc_l3_clk);
+	clk_enable(gpmc_clk);
 
 	l = gpmc_read_reg(GPMC_REVISION);
 	printk(KERN_INFO "GPMC revision %d.%d\n", (l >> 4) & 0x0f, l & 0x0f);
@@ -544,6 +588,8 @@ void __init gpmc_init(void)
 	l |= (0x02 << 3) | (1 << 0);
 	gpmc_write_reg(GPMC_SYSCONFIG, l);
 	gpmc_mem_init();
+
+	clk_disable(gpmc_clk);
 }
 
 #ifdef CONFIG_ARCH_OMAP3
@@ -552,6 +598,9 @@ static struct omap3_gpmc_regs gpmc_context;
 void omap3_gpmc_save_context()
 {
 	int i;
+
+	clk_enable(gpmc_clk);
+
 	gpmc_context.sysconfig = gpmc_read_reg(GPMC_SYSCONFIG);
 	gpmc_context.irqenable = gpmc_read_reg(GPMC_IRQENABLE);
 	gpmc_context.timeout_ctrl = gpmc_read_reg(GPMC_TIMEOUT_CONTROL);
@@ -559,6 +608,7 @@ void omap3_gpmc_save_context()
 	gpmc_context.prefetch_config1 = gpmc_read_reg(GPMC_PREFETCH_CONFIG1);
 	gpmc_context.prefetch_config2 = gpmc_read_reg(GPMC_PREFETCH_CONFIG2);
 	gpmc_context.prefetch_control = gpmc_read_reg(GPMC_PREFETCH_CONTROL);
+
 	for (i = 0; i < GPMC_CS_NUM; i++) {
 		gpmc_context.cs_context[i].is_valid = gpmc_cs_mem_enabled(i);
 		if (gpmc_context.cs_context[i].is_valid) {
@@ -578,11 +628,16 @@ void omap3_gpmc_save_context()
 				gpmc_cs_read_reg(i, GPMC_CS_CONFIG7);
 		}
 	}
+
+	clk_disable(gpmc_clk);
 }
 
 void omap3_gpmc_restore_context()
 {
 	int i;
+
+	clk_enable(gpmc_clk);
+
 	gpmc_write_reg(GPMC_SYSCONFIG, gpmc_context.sysconfig);
 	gpmc_write_reg(GPMC_IRQENABLE, gpmc_context.irqenable);
 	gpmc_write_reg(GPMC_TIMEOUT_CONTROL, gpmc_context.timeout_ctrl);
@@ -608,5 +663,10 @@ void omap3_gpmc_restore_context()
 				gpmc_context.cs_context[i].config7);
 		}
 	}
+
+	/* Make sure all writes to the GPMC complete before turning off clock */
+	gpmc_ocp_barrier();
+
+	clk_disable(gpmc_clk);
 }
 #endif /* CONFIG_ARCH_OMAP3 */
-- 
1.6.6.rc2.5.g49666

