From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 6/6] ARM: OMAP2+: Drop legacy struct omap_hwmod_addr_space
Date: Wed, 30 Aug 2017 08:41:49 -0700
Message-ID: <20170830154148.GH6008@atomide.com>
References: <20170829173001.20358-1-tony@atomide.com>
 <20170829173001.20358-7-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20170829173001.20358-7-tony@atomide.com>
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
Cc: Nishanth Menon <nm@ti.com>, Paul Walmsley <paul@pwsan.com>, Lokesh Vutla <lokeshvutla@ti.com>, Tero Kristo <t-kristo@ti.com>, Marc Zyngier <marc.zyngier@arm.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [170829 10:30]:
> With all of mach-omap2 booting now in device tree only mode,
> we can get the module IO range from device tree and just drop
> the legacy hwmod struct omap_hwmod_addr_space.
...

> --- a/arch/arm/mach-omap2/Makefile
> +++ b/arch/arm/mach-omap2/Makefile
> @@ -200,7 +200,6 @@ obj-y					+= omap_hwmod_common_ipblock_data.o
>  obj-$(CONFIG_SOC_OMAP2420)		+= omap_hwmod_2xxx_ipblock_data.o
>  obj-$(CONFIG_SOC_OMAP2420)		+= omap_hwmod_2xxx_3xxx_ipblock_data.o
>  obj-$(CONFIG_SOC_OMAP2420)		+= omap_hwmod_2xxx_interconnect_data.o
> -obj-$(CONFIG_SOC_OMAP2420)		+= omap_hwmod_2xxx_3xxx_interconnect_data.o
>  obj-$(CONFIG_SOC_OMAP2420)		+= omap_hwmod_2420_data.o
>  obj-$(CONFIG_SOC_OMAP2430)		+= omap_hwmod_2xxx_ipblock_data.o
>  obj-$(CONFIG_SOC_OMAP2430)		+= omap_hwmod_2xxx_3xxx_ipblock_data.o

Looks like the Makefile is missing changes related to dropping
omap_hwmod_2xxx_3xxx_interconnect_data for 2430 and omap3.
I was probably compile testing this with my LPAE .config.

Updated patch below.

Regards,

Tony

8< --------------------
>From tony Mon Sep 17 00:00:00 2001
From: Tony Lindgren <tony@atomide.com>
Date: Wed, 30 Aug 2017 08:07:58 -0700
Subject: [PATCH] ARM: OMAP2+: Drop legacy struct omap_hwmod_addr_space

With all of mach-omap2 booting now in device tree only mode,
we can get the module IO range from device tree and just drop
the legacy hwmod struct omap_hwmod_addr_space.

Cc: Lokesh Vutla <lokeshvutla@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Tero Kristo <t-kristo@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/Makefile                       |   3 -
 arch/arm/mach-omap2/omap_hwmod.c                   | 239 +-----------
 arch/arm/mach-omap2/omap_hwmod.h                   |  28 --
 arch/arm/mach-omap2/omap_hwmod_2420_data.c         |   1 -
 arch/arm/mach-omap2/omap_hwmod_2430_data.c         |   1 -
 .../omap_hwmod_2xxx_3xxx_interconnect_data.c       |  27 --
 .../omap_hwmod_33xx_43xx_interconnect_data.c       | 100 -----
 arch/arm/mach-omap2/omap_hwmod_33xx_data.c         |  39 --
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c         |  33 +-
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c         | 402 ---------------------
 arch/arm/mach-omap2/omap_hwmod_54xx_data.c         |  10 -
 arch/arm/mach-omap2/omap_hwmod_7xx_data.c          |  32 --
 arch/arm/mach-omap2/omap_hwmod_81xx_data.c         |  44 ---
 arch/arm/mach-omap2/omap_hwmod_common_data.h       |   6 -
 14 files changed, 7 insertions(+), 958 deletions(-)
 delete mode 100644 arch/arm/mach-omap2/omap_hwmod_2xxx_3xxx_interconnect_data.c

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -200,15 +200,12 @@ obj-y					+= omap_hwmod_common_ipblock_data.o
 obj-$(CONFIG_SOC_OMAP2420)		+= omap_hwmod_2xxx_ipblock_data.o
 obj-$(CONFIG_SOC_OMAP2420)		+= omap_hwmod_2xxx_3xxx_ipblock_data.o
 obj-$(CONFIG_SOC_OMAP2420)		+= omap_hwmod_2xxx_interconnect_data.o
-obj-$(CONFIG_SOC_OMAP2420)		+= omap_hwmod_2xxx_3xxx_interconnect_data.o
 obj-$(CONFIG_SOC_OMAP2420)		+= omap_hwmod_2420_data.o
 obj-$(CONFIG_SOC_OMAP2430)		+= omap_hwmod_2xxx_ipblock_data.o
 obj-$(CONFIG_SOC_OMAP2430)		+= omap_hwmod_2xxx_3xxx_ipblock_data.o
 obj-$(CONFIG_SOC_OMAP2430)		+= omap_hwmod_2xxx_interconnect_data.o
-obj-$(CONFIG_SOC_OMAP2430)		+= omap_hwmod_2xxx_3xxx_interconnect_data.o
 obj-$(CONFIG_SOC_OMAP2430)		+= omap_hwmod_2430_data.o
 obj-$(CONFIG_ARCH_OMAP3)		+= omap_hwmod_2xxx_3xxx_ipblock_data.o
-obj-$(CONFIG_ARCH_OMAP3)		+= omap_hwmod_2xxx_3xxx_interconnect_data.o
 obj-$(CONFIG_ARCH_OMAP3)		+= omap_hwmod_3xxx_data.o
 obj-$(CONFIG_SOC_AM33XX)		+= omap_hwmod_33xx_data.o
 obj-$(CONFIG_SOC_AM33XX)		+= omap_hwmod_33xx_43xx_interconnect_data.o
diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -1101,82 +1101,6 @@ static int _omap4_wait_target_disable(struct omap_hwmod *oh)
 					oh->prcm.omap4.clkctrl_offs, 0);
 }
 
-/**
- * _count_ocp_if_addr_spaces - count the number of address space entries for @oh
- * @oh: struct omap_hwmod *oh
- *
- * Count and return the number of address space ranges associated with
- * the hwmod @oh.  Used to allocate struct resource data.  Returns 0
- * if @oh is NULL.
- */
-static int _count_ocp_if_addr_spaces(struct omap_hwmod_ocp_if *os)
-{
-	struct omap_hwmod_addr_space *mem;
-	int i = 0;
-
-	if (!os || !os->addr)
-		return 0;
-
-	do {
-		mem = &os->addr[i++];
-	} while (mem->pa_start != mem->pa_end);
-
-	return i-1;
-}
-
-/**
- * _get_addr_space_by_name - fetch address space start & end by name
- * @oh: struct omap_hwmod * to operate on
- * @name: pointer to the name of the address space to fetch (optional)
- * @pa_start: pointer to a u32 to store the starting address to
- * @pa_end: pointer to a u32 to store the ending address to
- *
- * Retrieve address space start and end addresses for the IP block
- * pointed to by @oh.  The data will be filled into the addresses
- * pointed to by @pa_start and @pa_end.  When @name is non-null, the
- * address space data associated with the named entry will be
- * returned.  If @name is null, the first matching entry will be
- * returned.  Data order is not meaningful in hwmod data, so callers
- * are strongly encouraged to use a non-null @name whenever possible
- * to avoid unpredictable effects if hwmod data is later added that
- * causes data ordering to change.  Returns 0 upon success or a
- * negative error code upon error.
- */
-static int _get_addr_space_by_name(struct omap_hwmod *oh, const char *name,
-				   u32 *pa_start, u32 *pa_end)
-{
-	int j;
-	struct omap_hwmod_ocp_if *os;
-	bool found = false;
-
-	list_for_each_entry(os, &oh->slave_ports, node) {
-
-		if (!os->addr)
-			return -ENOENT;
-
-		j = 0;
-		while (os->addr[j].pa_start != os->addr[j].pa_end) {
-			if (name == os->addr[j].name ||
-			    !strcmp(name, os->addr[j].name)) {
-				found = true;
-				break;
-			}
-			j++;
-		}
-
-		if (found)
-			break;
-	}
-
-	if (!found)
-		return -ENOENT;
-
-	*pa_start = os->addr[j].pa_start;
-	*pa_end = os->addr[j].pa_end;
-
-	return 0;
-}
-
 /**
  * _save_mpu_port_index - find and save the index to @oh's MPU port
  * @oh: struct omap_hwmod *
@@ -1227,32 +1151,6 @@ static struct omap_hwmod_ocp_if *_find_mpu_rt_port(struct omap_hwmod *oh)
 	return oh->_mpu_port;
 };
 
-/**
- * _find_mpu_rt_addr_space - return MPU register target address space for @oh
- * @oh: struct omap_hwmod *
- *
- * Returns a pointer to the struct omap_hwmod_addr_space record representing
- * the register target MPU address space; or returns NULL upon error.
- */
-static struct omap_hwmod_addr_space * __init _find_mpu_rt_addr_space(struct omap_hwmod *oh)
-{
-	struct omap_hwmod_ocp_if *os;
-	struct omap_hwmod_addr_space *mem;
-	int found = 0, i = 0;
-
-	os = _find_mpu_rt_port(oh);
-	if (!os || !os->addr)
-		return NULL;
-
-	do {
-		mem = &os->addr[i++];
-		if (mem->flags & ADDR_TYPE_RT)
-			found = 1;
-	} while (!found && mem->pa_start != mem->pa_end);
-
-	return (found) ? mem : NULL;
-}
-
 /**
  * _enable_sysc - try to bring a module out of idle via OCP_SYSCONFIG
  * @oh: struct omap_hwmod *
@@ -2282,7 +2180,6 @@ static int of_dev_hwmod_lookup(struct device_node *np,
 static int __init _init_mpu_rt_base(struct omap_hwmod *oh, void *data,
 				    int index, struct device_node *np)
 {
-	struct omap_hwmod_addr_space *mem;
 	void __iomem *va_start = NULL;
 
 	if (!oh)
@@ -2298,28 +2195,15 @@ static int __init _init_mpu_rt_base(struct omap_hwmod *oh, void *data,
 	if (oh->_int_flags & _HWMOD_NO_MPU_PORT)
 		return -ENXIO;
 
-	mem = _find_mpu_rt_addr_space(oh);
-	if (!mem) {
-		pr_debug("omap_hwmod: %s: no MPU register target found\n",
-			 oh->name);
-
-		/* Extract the IO space from device tree blob */
-		if (!np) {
-			pr_err("omap_hwmod: %s: no dt node\n", oh->name);
-			return -ENXIO;
-		}
-
-		va_start = of_iomap(np, index + oh->mpu_rt_idx);
-	} else {
-		va_start = ioremap(mem->pa_start, mem->pa_end - mem->pa_start);
+	if (!np) {
+		pr_err("omap_hwmod: %s: no dt node\n", oh->name);
+		return -ENXIO;
 	}
 
+	va_start = of_iomap(np, index + oh->mpu_rt_idx);
 	if (!va_start) {
-		if (mem)
-			pr_err("omap_hwmod: %s: Could not ioremap\n", oh->name);
-		else
-			pr_err("omap_hwmod: %s: Missing dt reg%i for %pOF\n",
-			       oh->name, index, np);
+		pr_err("omap_hwmod: %s: Missing dt reg%i for %pOF\n",
+		       oh->name, index, np);
 		return -ENXIO;
 	}
 
@@ -3223,117 +3107,6 @@ int omap_hwmod_shutdown(struct omap_hwmod *oh)
  * IP block data retrieval functions
  */
 
-/**
- * omap_hwmod_count_resources - count number of struct resources needed by hwmod
- * @oh: struct omap_hwmod *
- * @flags: Type of resources to include when counting (IRQ/DMA/MEM)
- *
- * Count the number of struct resource array elements necessary to
- * contain omap_hwmod @oh resources.  Intended to be called by code
- * that registers omap_devices.  Intended to be used to determine the
- * size of a dynamically-allocated struct resource array, before
- * calling omap_hwmod_fill_resources().  Returns the number of struct
- * resource array elements needed.
- *
- * XXX This code is not optimized.  It could attempt to merge adjacent
- * resource IDs.
- *
- */
-int omap_hwmod_count_resources(struct omap_hwmod *oh, unsigned long flags)
-{
-	int ret = 0;
-
-	if (flags & IORESOURCE_MEM) {
-		struct omap_hwmod_ocp_if *os;
-
-		list_for_each_entry(os, &oh->slave_ports, node)
-			ret += _count_ocp_if_addr_spaces(os);
-	}
-
-	return ret;
-}
-
-/**
- * omap_hwmod_fill_resources - fill struct resource array with hwmod data
- * @oh: struct omap_hwmod *
- * @res: pointer to the first element of an array of struct resource to fill
- *
- * Fill the struct resource array @res with resource data from the
- * omap_hwmod @oh.  Intended to be called by code that registers
- * omap_devices.  See also omap_hwmod_count_resources().  Returns the
- * number of array elements filled.
- */
-int omap_hwmod_fill_resources(struct omap_hwmod *oh, struct resource *res)
-{
-	struct omap_hwmod_ocp_if *os;
-	int j, addr_cnt;
-	int r = 0;
-
-	/* For each memory area, fill in array.*/
-
-	list_for_each_entry(os, &oh->slave_ports, node) {
-		addr_cnt = _count_ocp_if_addr_spaces(os);
-
-		for (j = 0; j < addr_cnt; j++) {
-			(res + r)->name = (os->addr + j)->name;
-			(res + r)->start = (os->addr + j)->pa_start;
-			(res + r)->end = (os->addr + j)->pa_end;
-			(res + r)->flags = IORESOURCE_MEM;
-			r++;
-		}
-	}
-
-	return r;
-}
-
-/**
- * omap_hwmod_get_resource_byname - fetch IP block integration data by name
- * @oh: struct omap_hwmod * to operate on
- * @type: one of the IORESOURCE_* constants from include/linux/ioport.h
- * @name: pointer to the name of the data to fetch (optional)
- * @rsrc: pointer to a struct resource, allocated by the caller
- *
- * Retrieve MPU IRQ, SDMA request line, or address space start/end
- * data for the IP block pointed to by @oh.  The data will be filled
- * into a struct resource record pointed to by @rsrc.  The struct
- * resource must be allocated by the caller.  When @name is non-null,
- * the data associated with the matching entry in the IRQ/SDMA/address
- * space hwmod data arrays will be returned.  If @name is null, the
- * first array entry will be returned.  Data order is not meaningful
- * in hwmod data, so callers are strongly encouraged to use a non-null
- * @name whenever possible to avoid unpredictable effects if hwmod
- * data is later added that causes data ordering to change.  This
- * function is only intended for use by OMAP core code.  Device
- * drivers should not call this function - the appropriate bus-related
- * data accessor functions should be used instead.  Returns 0 upon
- * success or a negative error code upon error.
- */
-int omap_hwmod_get_resource_byname(struct omap_hwmod *oh, unsigned int type,
-				   const char *name, struct resource *rsrc)
-{
-	int r;
-	u32 pa_start, pa_end;
-
-	if (!oh || !rsrc)
-		return -EINVAL;
-
-	if (type == IORESOURCE_MEM) {
-		r = _get_addr_space_by_name(oh, name, &pa_start, &pa_end);
-		if (r)
-			return r;
-
-		rsrc->start = pa_start;
-		rsrc->end = pa_end;
-	} else {
-		return -EINVAL;
-	}
-
-	rsrc->flags = type;
-	rsrc->name = name;
-
-	return 0;
-}
-
 /**
  * omap_hwmod_get_pwrdm - return pointer to this module's main powerdomain
  * @oh: struct omap_hwmod *
diff --git a/arch/arm/mach-omap2/omap_hwmod.h b/arch/arm/mach-omap2/omap_hwmod.h
--- a/arch/arm/mach-omap2/omap_hwmod.h
+++ b/arch/arm/mach-omap2/omap_hwmod.h
@@ -198,34 +198,6 @@ struct omap_hwmod_omap2_firewall {
 	u8 flags;
 };
 
-
-/*
- * omap_hwmod_addr_space.flags bits
- *
- * ADDR_MAP_ON_INIT: Map this address space during omap_hwmod init.
- * ADDR_TYPE_RT: Address space contains module register target data.
- */
-#define ADDR_MAP_ON_INIT	(1 << 0)	/* XXX does not belong */
-#define ADDR_TYPE_RT		(1 << 1)
-
-/**
- * struct omap_hwmod_addr_space - address space handled by the hwmod
- * @name: name of the address space
- * @pa_start: starting physical address
- * @pa_end: ending physical address
- * @flags: (see omap_hwmod_addr_space.flags macros above)
- *
- * Address space doesn't necessarily follow physical interconnect
- * structure.  GPMC is one example.
- */
-struct omap_hwmod_addr_space {
-	const char *name;
-	u32 pa_start;
-	u32 pa_end;
-	u8 flags;
-};
-
-
 /*
  * omap_hwmod_ocp_if.user bits: these indicate the initiators that use this
  * interface to interact with the hwmod.  Used to add sleep dependencies
diff --git a/arch/arm/mach-omap2/omap_hwmod_2420_data.c b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
--- a/arch/arm/mach-omap2/omap_hwmod_2420_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
@@ -370,7 +370,6 @@ static struct omap_hwmod_ocp_if omap2420_l4_core__dma_system = {
 	.master		= &omap2xxx_l4_core_hwmod,
 	.slave		= &omap2420_dma_system_hwmod,
 	.clk		= "sdma_ick",
-	.addr		= omap2_dma_system_addrs,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
diff --git a/arch/arm/mach-omap2/omap_hwmod_2430_data.c b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
--- a/arch/arm/mach-omap2/omap_hwmod_2430_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
@@ -571,7 +571,6 @@ static struct omap_hwmod_ocp_if omap2430_l4_core__dma_system = {
 	.master		= &omap2xxx_l4_core_hwmod,
 	.slave		= &omap2430_dma_system_hwmod,
 	.clk		= "sdma_ick",
-	.addr		= omap2_dma_system_addrs,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
diff --git a/arch/arm/mach-omap2/omap_hwmod_2xxx_3xxx_interconnect_data.c b/arch/arm/mach-omap2/omap_hwmod_2xxx_3xxx_interconnect_data.c
deleted file mode 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2xxx_3xxx_interconnect_data.c
+++ /dev/null
@@ -1,27 +0,0 @@
-/*
- * omap_hwmod_2xxx_3xxx_interconnect_data.c - common interconnect data, OMAP2/3
- *
- * Copyright (C) 2009-2011 Nokia Corporation
- * Paul Walmsley
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- * XXX handle crossbar/shared link difference for L3?
- * XXX these should be marked initdata for multi-OMAP kernels
- */
-#include <asm/sizes.h>
-
-#include "omap_hwmod.h"
-
-#include "omap_hwmod_common_data.h"
-
-struct omap_hwmod_addr_space omap2_dma_system_addrs[] = {
-	{
-		.pa_start	= 0x48056000,
-		.pa_end		= 0x48056000 + SZ_4K - 1,
-		.flags		= ADDR_TYPE_RT,
-	},
-	{ },
-};
diff --git a/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_interconnect_data.c b/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_interconnect_data.c
--- a/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_interconnect_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_interconnect_data.c
@@ -159,54 +159,24 @@ struct omap_hwmod_ocp_if am33xx_l4_ls__elm = {
 	.user		= OCP_USER_MPU,
 };
 
-static struct omap_hwmod_addr_space am33xx_epwmss0_addr_space[] = {
-	{
-		.pa_start	= 0x48300000,
-		.pa_end		= 0x48300000 + SZ_16 - 1,
-		.flags		= ADDR_TYPE_RT
-	},
-	{ }
-};
-
 struct omap_hwmod_ocp_if am33xx_l4_ls__epwmss0 = {
 	.master		= &am33xx_l4_ls_hwmod,
 	.slave		= &am33xx_epwmss0_hwmod,
 	.clk		= "l4ls_gclk",
-	.addr		= am33xx_epwmss0_addr_space,
 	.user		= OCP_USER_MPU,
 };
 
-static struct omap_hwmod_addr_space am33xx_epwmss1_addr_space[] = {
-	{
-		.pa_start	= 0x48302000,
-		.pa_end		= 0x48302000 + SZ_16 - 1,
-		.flags		= ADDR_TYPE_RT
-	},
-	{ }
-};
-
 struct omap_hwmod_ocp_if am33xx_l4_ls__epwmss1 = {
 	.master		= &am33xx_l4_ls_hwmod,
 	.slave		= &am33xx_epwmss1_hwmod,
 	.clk		= "l4ls_gclk",
-	.addr		= am33xx_epwmss1_addr_space,
 	.user		= OCP_USER_MPU,
 };
 
-static struct omap_hwmod_addr_space am33xx_epwmss2_addr_space[] = {
-	{
-		.pa_start	= 0x48304000,
-		.pa_end		= 0x48304000 + SZ_16 - 1,
-		.flags		= ADDR_TYPE_RT
-	},
-	{ }
-};
-
 struct omap_hwmod_ocp_if am33xx_l4_ls__epwmss2 = {
 	.master		= &am33xx_l4_ls_hwmod,
 	.slave		= &am33xx_epwmss2_hwmod,
 	.clk		= "l4ls_gclk",
-	.addr		= am33xx_epwmss2_addr_space,
 	.user		= OCP_USER_MPU,
 };
 
@@ -250,38 +220,18 @@ struct omap_hwmod_ocp_if am33xx_l4_ls__spinlock = {
 };
 
 /* l4 ls -> mcasp0 */
-static struct omap_hwmod_addr_space am33xx_mcasp0_addr_space[] = {
-	{
-		.pa_start	= 0x48038000,
-		.pa_end		= 0x48038000 + SZ_8K - 1,
-		.flags		= ADDR_TYPE_RT
-	},
-	{ }
-};
-
 struct omap_hwmod_ocp_if am33xx_l4_ls__mcasp0 = {
 	.master		= &am33xx_l4_ls_hwmod,
 	.slave		= &am33xx_mcasp0_hwmod,
 	.clk		= "l4ls_gclk",
-	.addr		= am33xx_mcasp0_addr_space,
 	.user		= OCP_USER_MPU,
 };
 
 /* l4 ls -> mcasp1 */
-static struct omap_hwmod_addr_space am33xx_mcasp1_addr_space[] = {
-	{
-		.pa_start	= 0x4803C000,
-		.pa_end		= 0x4803C000 + SZ_8K - 1,
-		.flags		= ADDR_TYPE_RT
-	},
-	{ }
-};
-
 struct omap_hwmod_ocp_if am33xx_l4_ls__mcasp1 = {
 	.master		= &am33xx_l4_ls_hwmod,
 	.slave		= &am33xx_mcasp1_hwmod,
 	.clk		= "l4ls_gclk",
-	.addr		= am33xx_mcasp1_addr_space,
 	.user		= OCP_USER_MPU,
 };
 
@@ -382,56 +332,26 @@ struct omap_hwmod_ocp_if am33xx_l3_main__tpcc = {
 };
 
 /* l3 main -> tpcc0 */
-static struct omap_hwmod_addr_space am33xx_tptc0_addr_space[] = {
-	{
-		.pa_start	= 0x49800000,
-		.pa_end		= 0x49800000 + SZ_8K - 1,
-		.flags		= ADDR_TYPE_RT,
-	},
-	{ }
-};
-
 struct omap_hwmod_ocp_if am33xx_l3_main__tptc0 = {
 	.master		= &am33xx_l3_main_hwmod,
 	.slave		= &am33xx_tptc0_hwmod,
 	.clk		= "l3_gclk",
-	.addr		= am33xx_tptc0_addr_space,
 	.user		= OCP_USER_MPU,
 };
 
 /* l3 main -> tpcc1 */
-static struct omap_hwmod_addr_space am33xx_tptc1_addr_space[] = {
-	{
-		.pa_start	= 0x49900000,
-		.pa_end		= 0x49900000 + SZ_8K - 1,
-		.flags		= ADDR_TYPE_RT,
-	},
-	{ }
-};
-
 struct omap_hwmod_ocp_if am33xx_l3_main__tptc1 = {
 	.master		= &am33xx_l3_main_hwmod,
 	.slave		= &am33xx_tptc1_hwmod,
 	.clk		= "l3_gclk",
-	.addr		= am33xx_tptc1_addr_space,
 	.user		= OCP_USER_MPU,
 };
 
 /* l3 main -> tpcc2 */
-static struct omap_hwmod_addr_space am33xx_tptc2_addr_space[] = {
-	{
-		.pa_start	= 0x49a00000,
-		.pa_end		= 0x49a00000 + SZ_8K - 1,
-		.flags		= ADDR_TYPE_RT,
-	},
-	{ }
-};
-
 struct omap_hwmod_ocp_if am33xx_l3_main__tptc2 = {
 	.master		= &am33xx_l3_main_hwmod,
 	.slave		= &am33xx_tptc2_hwmod,
 	.clk		= "l3_gclk",
-	.addr		= am33xx_tptc2_addr_space,
 	.user		= OCP_USER_MPU,
 };
 
@@ -483,38 +403,18 @@ struct omap_hwmod_ocp_if am33xx_l3_main__ocmc = {
 };
 
 /* l3 main -> sha0 HIB2 */
-static struct omap_hwmod_addr_space am33xx_sha0_addrs[] = {
-	{
-		.pa_start	= 0x53100000,
-		.pa_end		= 0x53100000 + SZ_512 - 1,
-		.flags		= ADDR_TYPE_RT
-	},
-	{ }
-};
-
 struct omap_hwmod_ocp_if am33xx_l3_main__sha0 = {
 	.master		= &am33xx_l3_main_hwmod,
 	.slave		= &am33xx_sha0_hwmod,
 	.clk		= "sha0_fck",
-	.addr		= am33xx_sha0_addrs,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
 /* l3 main -> AES0 HIB2 */
-static struct omap_hwmod_addr_space am33xx_aes0_addrs[] = {
-	{
-		.pa_start	= 0x53500000,
-		.pa_end		= 0x53500000 + SZ_1M - 1,
-		.flags		= ADDR_TYPE_RT
-	},
-	{ }
-};
-
 struct omap_hwmod_ocp_if am33xx_l3_main__aes0 = {
 	.master		= &am33xx_l3_main_hwmod,
 	.slave		= &am33xx_aes0_hwmod,
 	.clk		= "aes0_fck",
-	.addr		= am33xx_aes0_addrs,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
diff --git a/arch/arm/mach-omap2/omap_hwmod_33xx_data.c b/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
--- a/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
@@ -320,20 +320,11 @@ static struct omap_hwmod am33xx_usbss_hwmod = {
  * Interfaces
  */
 
-static struct omap_hwmod_addr_space am33xx_emif_addrs[] = {
-	{
-		.pa_start	= 0x4c000000,
-		.pa_end		= 0x4c000fff,
-		.flags		= ADDR_TYPE_RT
-	},
-	{ }
-};
 /* l3 main -> emif */
 static struct omap_hwmod_ocp_if am33xx_l3_main__emif = {
 	.master		= &am33xx_l3_main_hwmod,
 	.slave		= &am33xx_emif_hwmod,
 	.clk		= "dpll_core_m4_ck",
-	.addr		= am33xx_emif_addrs,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
@@ -370,20 +361,10 @@ static struct omap_hwmod_ocp_if am33xx_l4_hs__pruss = {
 };
 
 /* l3_main -> debugss */
-static struct omap_hwmod_addr_space am33xx_debugss_addrs[] = {
-	{
-		.pa_start	= 0x4b000000,
-		.pa_end		= 0x4b000000 + SZ_16M - 1,
-		.flags		= ADDR_TYPE_RT
-	},
-	{ }
-};
-
 static struct omap_hwmod_ocp_if am33xx_l3_main__debugss = {
 	.master		= &am33xx_l3_main_hwmod,
 	.slave		= &am33xx_debugss_hwmod,
 	.clk		= "dpll_core_m4_ck",
-	.addr		= am33xx_debugss_addrs,
 	.user		= OCP_USER_MPU,
 };
 
@@ -428,20 +409,10 @@ static struct omap_hwmod_ocp_if am33xx_l4_wkup__gpio0 = {
 };
 
 /* L4 WKUP -> ADC_TSC */
-static struct omap_hwmod_addr_space am33xx_adc_tsc_addrs[] = {
-	{
-		.pa_start	= 0x44E0D000,
-		.pa_end		= 0x44E0D000 + SZ_8K - 1,
-		.flags		= ADDR_TYPE_RT
-	},
-	{ }
-};
-
 static struct omap_hwmod_ocp_if am33xx_l4_wkup__adc_tsc = {
 	.master		= &am33xx_l4_wkup_hwmod,
 	.slave		= &am33xx_adc_tsc_hwmod,
 	.clk		= "dpll_core_m4_div2_ck",
-	.addr		= am33xx_adc_tsc_addrs,
 	.user		= OCP_USER_MPU,
 };
 
@@ -452,20 +423,10 @@ static struct omap_hwmod_ocp_if am33xx_l4_hs__cpgmac0 = {
 	.user		= OCP_USER_MPU,
 };
 
-static struct omap_hwmod_addr_space am33xx_lcdc_addr_space[] = {
-	{
-		.pa_start	= 0x4830E000,
-		.pa_end		= 0x4830E000 + SZ_8K - 1,
-		.flags		= ADDR_TYPE_RT,
-	},
-	{ }
-};
-
 static struct omap_hwmod_ocp_if am33xx_l3_main__lcdc = {
 	.master		= &am33xx_l3_main_hwmod,
 	.slave		= &am33xx_lcdc_hwmod,
 	.clk		= "dpll_core_m4_ck",
-	.addr		= am33xx_lcdc_addr_space,
 	.user		= OCP_USER_MPU,
 };
 
diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -2098,20 +2098,10 @@ static struct omap_hwmod_ocp_if omap3_l4_core__i2c3 = {
 };
 
 /* L4 CORE -> SR1 interface */
-static struct omap_hwmod_addr_space omap3_sr1_addr_space[] = {
-	{
-		.pa_start	= OMAP34XX_SR1_BASE,
-		.pa_end		= OMAP34XX_SR1_BASE + SZ_1K - 1,
-		.flags		= ADDR_TYPE_RT,
-	},
-	{ },
-};
-
 static struct omap_hwmod_ocp_if omap34xx_l4_core__sr1 = {
 	.master		= &omap3xxx_l4_core_hwmod,
 	.slave		= &omap34xx_sr1_hwmod,
 	.clk		= "sr_l4_ick",
-	.addr		= omap3_sr1_addr_space,
 	.user		= OCP_USER_MPU,
 };
 
@@ -2119,25 +2109,15 @@ static struct omap_hwmod_ocp_if omap36xx_l4_core__sr1 = {
 	.master		= &omap3xxx_l4_core_hwmod,
 	.slave		= &omap36xx_sr1_hwmod,
 	.clk		= "sr_l4_ick",
-	.addr		= omap3_sr1_addr_space,
 	.user		= OCP_USER_MPU,
 };
 
-/* L4 CORE -> SR1 interface */
-static struct omap_hwmod_addr_space omap3_sr2_addr_space[] = {
-	{
-		.pa_start	= OMAP34XX_SR2_BASE,
-		.pa_end		= OMAP34XX_SR2_BASE + SZ_1K - 1,
-		.flags		= ADDR_TYPE_RT,
-	},
-	{ },
-};
+/* L4 CORE -> SR2 interface */
 
 static struct omap_hwmod_ocp_if omap34xx_l4_core__sr2 = {
 	.master		= &omap3xxx_l4_core_hwmod,
 	.slave		= &omap34xx_sr2_hwmod,
 	.clk		= "sr_l4_ick",
-	.addr		= omap3_sr2_addr_space,
 	.user		= OCP_USER_MPU,
 };
 
@@ -2145,7 +2125,6 @@ static struct omap_hwmod_ocp_if omap36xx_l4_core__sr2 = {
 	.master		= &omap3xxx_l4_core_hwmod,
 	.slave		= &omap36xx_sr2_hwmod,
 	.clk		= "sr_l4_ick",
-	.addr		= omap3_sr2_addr_space,
 	.user		= OCP_USER_MPU,
 };
 
@@ -2514,21 +2493,11 @@ static struct omap_hwmod_ocp_if omap3xxx_dma_system__l3 = {
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
-static struct omap_hwmod_addr_space omap3xxx_dma_system_addrs[] = {
-	{
-		.pa_start	= 0x48056000,
-		.pa_end		= 0x48056fff,
-		.flags		= ADDR_TYPE_RT,
-	},
-	{ },
-};
-
 /* l4_cfg -> dma_system */
 static struct omap_hwmod_ocp_if omap3xxx_l4_core__dma_system = {
 	.master		= &omap3xxx_l4_core_hwmod,
 	.slave		= &omap3xxx_dma_system_hwmod,
 	.clk		= "core_l4_ick",
-	.addr		= omap3xxx_dma_system_addrs,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -3392,81 +3392,19 @@ static struct omap_hwmod_ocp_if omap44xx_l4_cfg__ocp_wp_noc = {
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
-static struct omap_hwmod_addr_space omap44xx_aess_addrs[] = {
-	{
-		.name		= "dmem",
-		.pa_start	= 0x40180000,
-		.pa_end		= 0x4018ffff
-	},
-	{
-		.name		= "cmem",
-		.pa_start	= 0x401a0000,
-		.pa_end		= 0x401a1fff
-	},
-	{
-		.name		= "smem",
-		.pa_start	= 0x401c0000,
-		.pa_end		= 0x401c5fff
-	},
-	{
-		.name		= "pmem",
-		.pa_start	= 0x401e0000,
-		.pa_end		= 0x401e1fff
-	},
-	{
-		.name		= "mpu",
-		.pa_start	= 0x401f1000,
-		.pa_end		= 0x401f13ff,
-		.flags		= ADDR_TYPE_RT
-	},
-	{ }
-};
-
 /* l4_abe -> aess */
 static struct omap_hwmod_ocp_if __maybe_unused omap44xx_l4_abe__aess = {
 	.master		= &omap44xx_l4_abe_hwmod,
 	.slave		= &omap44xx_aess_hwmod,
 	.clk		= "ocp_abe_iclk",
-	.addr		= omap44xx_aess_addrs,
 	.user		= OCP_USER_MPU,
 };
 
-static struct omap_hwmod_addr_space omap44xx_aess_dma_addrs[] = {
-	{
-		.name		= "dmem_dma",
-		.pa_start	= 0x49080000,
-		.pa_end		= 0x4908ffff
-	},
-	{
-		.name		= "cmem_dma",
-		.pa_start	= 0x490a0000,
-		.pa_end		= 0x490a1fff
-	},
-	{
-		.name		= "smem_dma",
-		.pa_start	= 0x490c0000,
-		.pa_end		= 0x490c5fff
-	},
-	{
-		.name		= "pmem_dma",
-		.pa_start	= 0x490e0000,
-		.pa_end		= 0x490e1fff
-	},
-	{
-		.name		= "dma",
-		.pa_start	= 0x490f1000,
-		.pa_end		= 0x490f13ff,
-		.flags		= ADDR_TYPE_RT
-	},
-	{ }
-};
-
 /* l4_abe -> aess (dma) */
 static struct omap_hwmod_ocp_if __maybe_unused omap44xx_l4_abe__aess_dma = {
 	.master		= &omap44xx_l4_abe_hwmod,
 	.slave		= &omap44xx_aess_hwmod,
 	.clk		= "ocp_abe_iclk",
-	.addr		= omap44xx_aess_dma_addrs,
 	.user		= OCP_USER_SDMA,
 };
 
@@ -3486,75 +3424,35 @@ static struct omap_hwmod_ocp_if omap44xx_l4_wkup__counter_32k = {
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
-static struct omap_hwmod_addr_space omap44xx_ctrl_module_core_addrs[] = {
-	{
-		.pa_start	= 0x4a002000,
-		.pa_end		= 0x4a0027ff,
-		.flags		= ADDR_TYPE_RT
-	},
-	{ }
-};
-
 /* l4_cfg -> ctrl_module_core */
 static struct omap_hwmod_ocp_if omap44xx_l4_cfg__ctrl_module_core = {
 	.master		= &omap44xx_l4_cfg_hwmod,
 	.slave		= &omap44xx_ctrl_module_core_hwmod,
 	.clk		= "l4_div_ck",
-	.addr		= omap44xx_ctrl_module_core_addrs,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
-static struct omap_hwmod_addr_space omap44xx_ctrl_module_pad_core_addrs[] = {
-	{
-		.pa_start	= 0x4a100000,
-		.pa_end		= 0x4a1007ff,
-		.flags		= ADDR_TYPE_RT
-	},
-	{ }
-};
-
 /* l4_cfg -> ctrl_module_pad_core */
 static struct omap_hwmod_ocp_if omap44xx_l4_cfg__ctrl_module_pad_core = {
 	.master		= &omap44xx_l4_cfg_hwmod,
 	.slave		= &omap44xx_ctrl_module_pad_core_hwmod,
 	.clk		= "l4_div_ck",
-	.addr		= omap44xx_ctrl_module_pad_core_addrs,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
-static struct omap_hwmod_addr_space omap44xx_ctrl_module_wkup_addrs[] = {
-	{
-		.pa_start	= 0x4a30c000,
-		.pa_end		= 0x4a30c7ff,
-		.flags		= ADDR_TYPE_RT
-	},
-	{ }
-};
-
 /* l4_wkup -> ctrl_module_wkup */
 static struct omap_hwmod_ocp_if omap44xx_l4_wkup__ctrl_module_wkup = {
 	.master		= &omap44xx_l4_wkup_hwmod,
 	.slave		= &omap44xx_ctrl_module_wkup_hwmod,
 	.clk		= "l4_wkup_clk_mux_ck",
-	.addr		= omap44xx_ctrl_module_wkup_addrs,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
-static struct omap_hwmod_addr_space omap44xx_ctrl_module_pad_wkup_addrs[] = {
-	{
-		.pa_start	= 0x4a31e000,
-		.pa_end		= 0x4a31e7ff,
-		.flags		= ADDR_TYPE_RT
-	},
-	{ }
-};
-
 /* l4_wkup -> ctrl_module_pad_wkup */
 static struct omap_hwmod_ocp_if omap44xx_l4_wkup__ctrl_module_pad_wkup = {
 	.master		= &omap44xx_l4_wkup_hwmod,
 	.slave		= &omap44xx_ctrl_module_pad_wkup_hwmod,
 	.clk		= "l4_wkup_clk_mux_ck",
-	.addr		= omap44xx_ctrl_module_pad_wkup_addrs,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
@@ -3566,21 +3464,11 @@ static struct omap_hwmod_ocp_if omap44xx_l3_instr__debugss = {
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
-static struct omap_hwmod_addr_space omap44xx_dma_system_addrs[] = {
-	{
-		.pa_start	= 0x4a056000,
-		.pa_end		= 0x4a056fff,
-		.flags		= ADDR_TYPE_RT
-	},
-	{ }
-};
-
 /* l4_cfg -> dma_system */
 static struct omap_hwmod_ocp_if omap44xx_l4_cfg__dma_system = {
 	.master		= &omap44xx_l4_cfg_hwmod,
 	.slave		= &omap44xx_dma_system_hwmod,
 	.clk		= "l4_div_ck",
-	.addr		= omap44xx_dma_system_addrs,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
@@ -3616,255 +3504,115 @@ static struct omap_hwmod_ocp_if omap44xx_l4_cfg__dsp = {
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
-static struct omap_hwmod_addr_space omap44xx_dss_dma_addrs[] = {
-	{
-		.pa_start	= 0x58000000,
-		.pa_end		= 0x5800007f,
-		.flags		= ADDR_TYPE_RT
-	},
-	{ }
-};
-
 /* l3_main_2 -> dss */
 static struct omap_hwmod_ocp_if omap44xx_l3_main_2__dss = {
 	.master		= &omap44xx_l3_main_2_hwmod,
 	.slave		= &omap44xx_dss_hwmod,
 	.clk		= "l3_div_ck",
-	.addr		= omap44xx_dss_dma_addrs,
 	.user		= OCP_USER_SDMA,
 };
 
-static struct omap_hwmod_addr_space omap44xx_dss_addrs[] = {
-	{
-		.pa_start	= 0x48040000,
-		.pa_end		= 0x4804007f,
-		.flags		= ADDR_TYPE_RT
-	},
-	{ }
-};
-
 /* l4_per -> dss */
 static struct omap_hwmod_ocp_if omap44xx_l4_per__dss = {
 	.master		= &omap44xx_l4_per_hwmod,
 	.slave		= &omap44xx_dss_hwmod,
 	.clk		= "l4_div_ck",
-	.addr		= omap44xx_dss_addrs,
 	.user		= OCP_USER_MPU,
 };
 
-static struct omap_hwmod_addr_space omap44xx_dss_dispc_dma_addrs[] = {
-	{
-		.pa_start	= 0x58001000,
-		.pa_end		= 0x58001fff,
-		.flags		= ADDR_TYPE_RT
-	},
-	{ }
-};
-
 /* l3_main_2 -> dss_dispc */
 static struct omap_hwmod_ocp_if omap44xx_l3_main_2__dss_dispc = {
 	.master		= &omap44xx_l3_main_2_hwmod,
 	.slave		= &omap44xx_dss_dispc_hwmod,
 	.clk		= "l3_div_ck",
-	.addr		= omap44xx_dss_dispc_dma_addrs,
 	.user		= OCP_USER_SDMA,
 };
 
-static struct omap_hwmod_addr_space omap44xx_dss_dispc_addrs[] = {
-	{
-		.pa_start	= 0x48041000,
-		.pa_end		= 0x48041fff,
-		.flags		= ADDR_TYPE_RT
-	},
-	{ }
-};
-
 /* l4_per -> dss_dispc */
 static struct omap_hwmod_ocp_if omap44xx_l4_per__dss_dispc = {
 	.master		= &omap44xx_l4_per_hwmod,
 	.slave		= &omap44xx_dss_dispc_hwmod,
 	.clk		= "l4_div_ck",
-	.addr		= omap44xx_dss_dispc_addrs,
 	.user		= OCP_USER_MPU,
 };
 
-static struct omap_hwmod_addr_space omap44xx_dss_dsi1_dma_addrs[] = {
-	{
-		.pa_start	= 0x58004000,
-		.pa_end		= 0x580041ff,
-		.flags		= ADDR_TYPE_RT
-	},
-	{ }
-};
-
 /* l3_main_2 -> dss_dsi1 */
 static struct omap_hwmod_ocp_if omap44xx_l3_main_2__dss_dsi1 = {
 	.master		= &omap44xx_l3_main_2_hwmod,
 	.slave		= &omap44xx_dss_dsi1_hwmod,
 	.clk		= "l3_div_ck",
-	.addr		= omap44xx_dss_dsi1_dma_addrs,
 	.user		= OCP_USER_SDMA,
 };
 
-static struct omap_hwmod_addr_space omap44xx_dss_dsi1_addrs[] = {
-	{
-		.pa_start	= 0x48044000,
-		.pa_end		= 0x480441ff,
-		.flags		= ADDR_TYPE_RT
-	},
-	{ }
-};
-
 /* l4_per -> dss_dsi1 */
 static struct omap_hwmod_ocp_if omap44xx_l4_per__dss_dsi1 = {
 	.master		= &omap44xx_l4_per_hwmod,
 	.slave		= &omap44xx_dss_dsi1_hwmod,
 	.clk		= "l4_div_ck",
-	.addr		= omap44xx_dss_dsi1_addrs,
 	.user		= OCP_USER_MPU,
 };
 
-static struct omap_hwmod_addr_space omap44xx_dss_dsi2_dma_addrs[] = {
-	{
-		.pa_start	= 0x58005000,
-		.pa_end		= 0x580051ff,
-		.flags		= ADDR_TYPE_RT
-	},
-	{ }
-};
-
 /* l3_main_2 -> dss_dsi2 */
 static struct omap_hwmod_ocp_if omap44xx_l3_main_2__dss_dsi2 = {
 	.master		= &omap44xx_l3_main_2_hwmod,
 	.slave		= &omap44xx_dss_dsi2_hwmod,
 	.clk		= "l3_div_ck",
-	.addr		= omap44xx_dss_dsi2_dma_addrs,
 	.user		= OCP_USER_SDMA,
 };
 
-static struct omap_hwmod_addr_space omap44xx_dss_dsi2_addrs[] = {
-	{
-		.pa_start	= 0x48045000,
-		.pa_end		= 0x480451ff,
-		.flags		= ADDR_TYPE_RT
-	},
-	{ }
-};
-
 /* l4_per -> dss_dsi2 */
 static struct omap_hwmod_ocp_if omap44xx_l4_per__dss_dsi2 = {
 	.master		= &omap44xx_l4_per_hwmod,
 	.slave		= &omap44xx_dss_dsi2_hwmod,
 	.clk		= "l4_div_ck",
-	.addr		= omap44xx_dss_dsi2_addrs,
 	.user		= OCP_USER_MPU,
 };
 
-static struct omap_hwmod_addr_space omap44xx_dss_hdmi_dma_addrs[] = {
-	{
-		.pa_start	= 0x58006000,
-		.pa_end		= 0x58006fff,
-		.flags		= ADDR_TYPE_RT
-	},
-	{ }
-};
-
 /* l3_main_2 -> dss_hdmi */
 static struct omap_hwmod_ocp_if omap44xx_l3_main_2__dss_hdmi = {
 	.master		= &omap44xx_l3_main_2_hwmod,
 	.slave		= &omap44xx_dss_hdmi_hwmod,
 	.clk		= "l3_div_ck",
-	.addr		= omap44xx_dss_hdmi_dma_addrs,
 	.user		= OCP_USER_SDMA,
 };
 
-static struct omap_hwmod_addr_space omap44xx_dss_hdmi_addrs[] = {
-	{
-		.pa_start	= 0x48046000,
-		.pa_end		= 0x48046fff,
-		.flags		= ADDR_TYPE_RT
-	},
-	{ }
-};
-
 /* l4_per -> dss_hdmi */
 static struct omap_hwmod_ocp_if omap44xx_l4_per__dss_hdmi = {
 	.master		= &omap44xx_l4_per_hwmod,
 	.slave		= &omap44xx_dss_hdmi_hwmod,
 	.clk		= "l4_div_ck",
-	.addr		= omap44xx_dss_hdmi_addrs,
 	.user		= OCP_USER_MPU,
 };
 
-static struct omap_hwmod_addr_space omap44xx_dss_rfbi_dma_addrs[] = {
-	{
-		.pa_start	= 0x58002000,
-		.pa_end		= 0x580020ff,
-		.flags		= ADDR_TYPE_RT
-	},
-	{ }
-};
-
 /* l3_main_2 -> dss_rfbi */
 static struct omap_hwmod_ocp_if omap44xx_l3_main_2__dss_rfbi = {
 	.master		= &omap44xx_l3_main_2_hwmod,
 	.slave		= &omap44xx_dss_rfbi_hwmod,
 	.clk		= "l3_div_ck",
-	.addr		= omap44xx_dss_rfbi_dma_addrs,
 	.user		= OCP_USER_SDMA,
 };
 
-static struct omap_hwmod_addr_space omap44xx_dss_rfbi_addrs[] = {
-	{
-		.pa_start	= 0x48042000,
-		.pa_end		= 0x480420ff,
-		.flags		= ADDR_TYPE_RT
-	},
-	{ }
-};
-
 /* l4_per -> dss_rfbi */
 static struct omap_hwmod_ocp_if omap44xx_l4_per__dss_rfbi = {
 	.master		= &omap44xx_l4_per_hwmod,
 	.slave		= &omap44xx_dss_rfbi_hwmod,
 	.clk		= "l4_div_ck",
-	.addr		= omap44xx_dss_rfbi_addrs,
 	.user		= OCP_USER_MPU,
 };
 
-static struct omap_hwmod_addr_space omap44xx_dss_venc_dma_addrs[] = {
-	{
-		.pa_start	= 0x58003000,
-		.pa_end		= 0x580030ff,
-		.flags		= ADDR_TYPE_RT
-	},
-	{ }
-};
-
 /* l3_main_2 -> dss_venc */
 static struct omap_hwmod_ocp_if omap44xx_l3_main_2__dss_venc = {
 	.master		= &omap44xx_l3_main_2_hwmod,
 	.slave		= &omap44xx_dss_venc_hwmod,
 	.clk		= "l3_div_ck",
-	.addr		= omap44xx_dss_venc_dma_addrs,
 	.user		= OCP_USER_SDMA,
 };
 
-static struct omap_hwmod_addr_space omap44xx_dss_venc_addrs[] = {
-	{
-		.pa_start	= 0x48043000,
-		.pa_end		= 0x480430ff,
-		.flags		= ADDR_TYPE_RT
-	},
-	{ }
-};
-
 /* l4_per -> dss_venc */
 static struct omap_hwmod_ocp_if omap44xx_l4_per__dss_venc = {
 	.master		= &omap44xx_l4_per_hwmod,
 	.slave		= &omap44xx_dss_venc_hwmod,
 	.clk		= "l4_div_ck",
-	.addr		= omap44xx_dss_venc_addrs,
 	.user		= OCP_USER_MPU,
 };
 
@@ -3884,21 +3632,11 @@ static struct omap_hwmod_ocp_if omap44xx_l4_per__elm = {
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
-static struct omap_hwmod_addr_space omap44xx_fdif_addrs[] = {
-	{
-		.pa_start	= 0x4a10a000,
-		.pa_end		= 0x4a10a1ff,
-		.flags		= ADDR_TYPE_RT
-	},
-	{ }
-};
-
 /* l4_cfg -> fdif */
 static struct omap_hwmod_ocp_if omap44xx_l4_cfg__fdif = {
 	.master		= &omap44xx_l4_cfg_hwmod,
 	.slave		= &omap44xx_fdif_hwmod,
 	.clk		= "l4_div_ck",
-	.addr		= omap44xx_fdif_addrs,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
@@ -3958,57 +3696,27 @@ static struct omap_hwmod_ocp_if omap44xx_l3_main_2__gpmc = {
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
-static struct omap_hwmod_addr_space omap44xx_gpu_addrs[] = {
-	{
-		.pa_start	= 0x56000000,
-		.pa_end		= 0x5600ffff,
-		.flags		= ADDR_TYPE_RT
-	},
-	{ }
-};
-
 /* l3_main_2 -> gpu */
 static struct omap_hwmod_ocp_if omap44xx_l3_main_2__gpu = {
 	.master		= &omap44xx_l3_main_2_hwmod,
 	.slave		= &omap44xx_gpu_hwmod,
 	.clk		= "l3_div_ck",
-	.addr		= omap44xx_gpu_addrs,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
-static struct omap_hwmod_addr_space omap44xx_hdq1w_addrs[] = {
-	{
-		.pa_start	= 0x480b2000,
-		.pa_end		= 0x480b201f,
-		.flags		= ADDR_TYPE_RT
-	},
-	{ }
-};
-
 /* l4_per -> hdq1w */
 static struct omap_hwmod_ocp_if omap44xx_l4_per__hdq1w = {
 	.master		= &omap44xx_l4_per_hwmod,
 	.slave		= &omap44xx_hdq1w_hwmod,
 	.clk		= "l4_div_ck",
-	.addr		= omap44xx_hdq1w_addrs,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
-static struct omap_hwmod_addr_space omap44xx_hsi_addrs[] = {
-	{
-		.pa_start	= 0x4a058000,
-		.pa_end		= 0x4a05bfff,
-		.flags		= ADDR_TYPE_RT
-	},
-	{ }
-};
-
 /* l4_cfg -> hsi */
 static struct omap_hwmod_ocp_if omap44xx_l4_cfg__hsi = {
 	.master		= &omap44xx_l4_cfg_hwmod,
 	.slave		= &omap44xx_hsi_hwmod,
 	.clk		= "l4_div_ck",
-	.addr		= omap44xx_hsi_addrs,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
@@ -4052,21 +3760,11 @@ static struct omap_hwmod_ocp_if omap44xx_l3_main_2__ipu = {
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
-static struct omap_hwmod_addr_space omap44xx_iss_addrs[] = {
-	{
-		.pa_start	= 0x52000000,
-		.pa_end		= 0x520000ff,
-		.flags		= ADDR_TYPE_RT
-	},
-	{ }
-};
-
 /* l3_main_2 -> iss */
 static struct omap_hwmod_ocp_if omap44xx_l3_main_2__iss = {
 	.master		= &omap44xx_l3_main_2_hwmod,
 	.slave		= &omap44xx_iss_hwmod,
 	.clk		= "l3_div_ck",
-	.addr		= omap44xx_iss_addrs,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
@@ -4102,39 +3800,19 @@ static struct omap_hwmod_ocp_if omap44xx_l4_cfg__mailbox = {
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
-static struct omap_hwmod_addr_space omap44xx_mcasp_addrs[] = {
-	{
-		.pa_start	= 0x40128000,
-		.pa_end		= 0x401283ff,
-		.flags		= ADDR_TYPE_RT
-	},
-	{ }
-};
-
 /* l4_abe -> mcasp */
 static struct omap_hwmod_ocp_if omap44xx_l4_abe__mcasp = {
 	.master		= &omap44xx_l4_abe_hwmod,
 	.slave		= &omap44xx_mcasp_hwmod,
 	.clk		= "ocp_abe_iclk",
-	.addr		= omap44xx_mcasp_addrs,
 	.user		= OCP_USER_MPU,
 };
 
-static struct omap_hwmod_addr_space omap44xx_mcasp_dma_addrs[] = {
-	{
-		.pa_start	= 0x49028000,
-		.pa_end		= 0x490283ff,
-		.flags		= ADDR_TYPE_RT
-	},
-	{ }
-};
-
 /* l4_abe -> mcasp (dma) */
 static struct omap_hwmod_ocp_if omap44xx_l4_abe__mcasp_dma = {
 	.master		= &omap44xx_l4_abe_hwmod,
 	.slave		= &omap44xx_mcasp_hwmod,
 	.clk		= "ocp_abe_iclk",
-	.addr		= omap44xx_mcasp_dma_addrs,
 	.user		= OCP_USER_SDMA,
 };
 
@@ -4314,111 +3992,51 @@ static struct omap_hwmod_ocp_if __maybe_unused omap44xx_l3_main_2__sl2if = {
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
-static struct omap_hwmod_addr_space omap44xx_slimbus1_addrs[] = {
-	{
-		.pa_start	= 0x4012c000,
-		.pa_end		= 0x4012c3ff,
-		.flags		= ADDR_TYPE_RT
-	},
-	{ }
-};
-
 /* l4_abe -> slimbus1 */
 static struct omap_hwmod_ocp_if omap44xx_l4_abe__slimbus1 = {
 	.master		= &omap44xx_l4_abe_hwmod,
 	.slave		= &omap44xx_slimbus1_hwmod,
 	.clk		= "ocp_abe_iclk",
-	.addr		= omap44xx_slimbus1_addrs,
 	.user		= OCP_USER_MPU,
 };
 
-static struct omap_hwmod_addr_space omap44xx_slimbus1_dma_addrs[] = {
-	{
-		.pa_start	= 0x4902c000,
-		.pa_end		= 0x4902c3ff,
-		.flags		= ADDR_TYPE_RT
-	},
-	{ }
-};
-
 /* l4_abe -> slimbus1 (dma) */
 static struct omap_hwmod_ocp_if omap44xx_l4_abe__slimbus1_dma = {
 	.master		= &omap44xx_l4_abe_hwmod,
 	.slave		= &omap44xx_slimbus1_hwmod,
 	.clk		= "ocp_abe_iclk",
-	.addr		= omap44xx_slimbus1_dma_addrs,
 	.user		= OCP_USER_SDMA,
 };
 
-static struct omap_hwmod_addr_space omap44xx_slimbus2_addrs[] = {
-	{
-		.pa_start	= 0x48076000,
-		.pa_end		= 0x480763ff,
-		.flags		= ADDR_TYPE_RT
-	},
-	{ }
-};
-
 /* l4_per -> slimbus2 */
 static struct omap_hwmod_ocp_if omap44xx_l4_per__slimbus2 = {
 	.master		= &omap44xx_l4_per_hwmod,
 	.slave		= &omap44xx_slimbus2_hwmod,
 	.clk		= "l4_div_ck",
-	.addr		= omap44xx_slimbus2_addrs,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
-static struct omap_hwmod_addr_space omap44xx_smartreflex_core_addrs[] = {
-	{
-		.pa_start	= 0x4a0dd000,
-		.pa_end		= 0x4a0dd03f,
-		.flags		= ADDR_TYPE_RT
-	},
-	{ }
-};
-
 /* l4_cfg -> smartreflex_core */
 static struct omap_hwmod_ocp_if omap44xx_l4_cfg__smartreflex_core = {
 	.master		= &omap44xx_l4_cfg_hwmod,
 	.slave		= &omap44xx_smartreflex_core_hwmod,
 	.clk		= "l4_div_ck",
-	.addr		= omap44xx_smartreflex_core_addrs,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
-static struct omap_hwmod_addr_space omap44xx_smartreflex_iva_addrs[] = {
-	{
-		.pa_start	= 0x4a0db000,
-		.pa_end		= 0x4a0db03f,
-		.flags		= ADDR_TYPE_RT
-	},
-	{ }
-};
-
 /* l4_cfg -> smartreflex_iva */
 static struct omap_hwmod_ocp_if omap44xx_l4_cfg__smartreflex_iva = {
 	.master		= &omap44xx_l4_cfg_hwmod,
 	.slave		= &omap44xx_smartreflex_iva_hwmod,
 	.clk		= "l4_div_ck",
-	.addr		= omap44xx_smartreflex_iva_addrs,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
-static struct omap_hwmod_addr_space omap44xx_smartreflex_mpu_addrs[] = {
-	{
-		.pa_start	= 0x4a0d9000,
-		.pa_end		= 0x4a0d903f,
-		.flags		= ADDR_TYPE_RT
-	},
-	{ }
-};
-
 /* l4_cfg -> smartreflex_mpu */
 static struct omap_hwmod_ocp_if omap44xx_l4_cfg__smartreflex_mpu = {
 	.master		= &omap44xx_l4_cfg_hwmod,
 	.slave		= &omap44xx_smartreflex_mpu_hwmod,
 	.clk		= "l4_div_ck",
-	.addr		= omap44xx_smartreflex_mpu_addrs,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
@@ -4590,39 +4208,19 @@ static struct omap_hwmod_ocp_if omap44xx_l4_wkup__wd_timer2 = {
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
-static struct omap_hwmod_addr_space omap44xx_wd_timer3_addrs[] = {
-	{
-		.pa_start	= 0x40130000,
-		.pa_end		= 0x4013007f,
-		.flags		= ADDR_TYPE_RT
-	},
-	{ }
-};
-
 /* l4_abe -> wd_timer3 */
 static struct omap_hwmod_ocp_if omap44xx_l4_abe__wd_timer3 = {
 	.master		= &omap44xx_l4_abe_hwmod,
 	.slave		= &omap44xx_wd_timer3_hwmod,
 	.clk		= "ocp_abe_iclk",
-	.addr		= omap44xx_wd_timer3_addrs,
 	.user		= OCP_USER_MPU,
 };
 
-static struct omap_hwmod_addr_space omap44xx_wd_timer3_dma_addrs[] = {
-	{
-		.pa_start	= 0x49030000,
-		.pa_end		= 0x4903007f,
-		.flags		= ADDR_TYPE_RT
-	},
-	{ }
-};
-
 /* l4_abe -> wd_timer3 (dma) */
 static struct omap_hwmod_ocp_if omap44xx_l4_abe__wd_timer3_dma = {
 	.master		= &omap44xx_l4_abe_hwmod,
 	.slave		= &omap44xx_wd_timer3_hwmod,
 	.clk		= "ocp_abe_iclk",
-	.addr		= omap44xx_wd_timer3_dma_addrs,
 	.user		= OCP_USER_SDMA,
 };
 
diff --git a/arch/arm/mach-omap2/omap_hwmod_54xx_data.c b/arch/arm/mach-omap2/omap_hwmod_54xx_data.c
--- a/arch/arm/mach-omap2/omap_hwmod_54xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_54xx_data.c
@@ -2245,21 +2245,11 @@ static struct omap_hwmod_ocp_if omap54xx_l4_wkup__counter_32k = {
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
-static struct omap_hwmod_addr_space omap54xx_dma_system_addrs[] = {
-	{
-		.pa_start	= 0x4a056000,
-		.pa_end		= 0x4a056fff,
-		.flags		= ADDR_TYPE_RT
-	},
-	{ }
-};
-
 /* l4_cfg -> dma_system */
 static struct omap_hwmod_ocp_if omap54xx_l4_cfg__dma_system = {
 	.master		= &omap54xx_l4_cfg_hwmod,
 	.slave		= &omap54xx_dma_system_hwmod,
 	.clk		= "l4_root_clk_div",
-	.addr		= omap54xx_dma_system_addrs,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
diff --git a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
--- a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
@@ -2920,21 +2920,11 @@ static struct omap_hwmod_ocp_if dra7xx_l4_per2__dcan2 = {
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
-static struct omap_hwmod_addr_space dra7xx_dma_system_addrs[] = {
-	{
-		.pa_start	= 0x4a056000,
-		.pa_end		= 0x4a056fff,
-		.flags		= ADDR_TYPE_RT
-	},
-	{ }
-};
-
 /* l4_cfg -> dma_system */
 static struct omap_hwmod_ocp_if dra7xx_l4_cfg__dma_system = {
 	.master		= &dra7xx_l4_cfg_hwmod,
 	.slave		= &dra7xx_dma_system_hwmod,
 	.clk		= "l3_iclk_div",
-	.addr		= dra7xx_dma_system_addrs,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
@@ -3178,21 +3168,11 @@ static struct omap_hwmod_ocp_if dra7xx_l3_main_1__gpmc = {
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
-static struct omap_hwmod_addr_space dra7xx_hdq1w_addrs[] = {
-	{
-		.pa_start	= 0x480b2000,
-		.pa_end		= 0x480b201f,
-		.flags		= ADDR_TYPE_RT
-	},
-	{ }
-};
-
 /* l4_per1 -> hdq1w */
 static struct omap_hwmod_ocp_if dra7xx_l4_per1__hdq1w = {
 	.master		= &dra7xx_l4_per1_hwmod,
 	.slave		= &dra7xx_hdq1w_hwmod,
 	.clk		= "l3_iclk_div",
-	.addr		= dra7xx_hdq1w_addrs,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
@@ -3476,26 +3456,14 @@ static struct omap_hwmod_ocp_if dra7xx_l4_per3__rtcss = {
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
-static struct omap_hwmod_addr_space dra7xx_sata_addrs[] = {
-	{
-		.name		= "sysc",
-		.pa_start	= 0x4a141100,
-		.pa_end		= 0x4a141107,
-		.flags		= ADDR_TYPE_RT
-	},
-	{ }
-};
-
 /* l4_cfg -> sata */
 static struct omap_hwmod_ocp_if dra7xx_l4_cfg__sata = {
 	.master		= &dra7xx_l4_cfg_hwmod,
 	.slave		= &dra7xx_sata_hwmod,
 	.clk		= "l3_iclk_div",
-	.addr		= dra7xx_sata_addrs,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
-/* l4_cfg -> spinlock */
 static struct omap_hwmod_ocp_if dra7xx_l4_cfg__spinlock = {
 	.master		= &dra7xx_l4_cfg_hwmod,
 	.slave		= &dra7xx_spinlock_hwmod,
diff --git a/arch/arm/mach-omap2/omap_hwmod_81xx_data.c b/arch/arm/mach-omap2/omap_hwmod_81xx_data.c
--- a/arch/arm/mach-omap2/omap_hwmod_81xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_81xx_data.c
@@ -1260,15 +1260,6 @@ static struct omap_hwmod_ocp_if dm81xx_alwon_l3_fast__tpcc = {
 	.user		= OCP_USER_MPU,
 };
 
-static struct omap_hwmod_addr_space dm81xx_tptc0_addr_space[] = {
-	{
-		.pa_start	= 0x49800000,
-		.pa_end		= 0x49800000 + SZ_8K - 1,
-		.flags		= ADDR_TYPE_RT,
-	},
-	{ },
-};
-
 static struct omap_hwmod_class dm81xx_tptc0_hwmod_class = {
 	.name		= "tptc0",
 };
@@ -1290,7 +1281,6 @@ static struct omap_hwmod_ocp_if dm81xx_alwon_l3_fast__tptc0 = {
 	.master		= &dm81xx_alwon_l3_fast_hwmod,
 	.slave		= &dm81xx_tptc0_hwmod,
 	.clk		= "sysclk4_ck",
-	.addr		= dm81xx_tptc0_addr_space,
 	.user		= OCP_USER_MPU,
 };
 
@@ -1298,19 +1288,9 @@ static struct omap_hwmod_ocp_if dm81xx_tptc0__alwon_l3_fast = {
 	.master		= &dm81xx_tptc0_hwmod,
 	.slave		= &dm81xx_alwon_l3_fast_hwmod,
 	.clk		= "sysclk4_ck",
-	.addr		= dm81xx_tptc0_addr_space,
 	.user		= OCP_USER_MPU,
 };
 
-static struct omap_hwmod_addr_space dm81xx_tptc1_addr_space[] = {
-	{
-		.pa_start	= 0x49900000,
-		.pa_end		= 0x49900000 + SZ_8K - 1,
-		.flags		= ADDR_TYPE_RT,
-	},
-	{ },
-};
-
 static struct omap_hwmod_class dm81xx_tptc1_hwmod_class = {
 	.name		= "tptc1",
 };
@@ -1332,7 +1312,6 @@ static struct omap_hwmod_ocp_if dm81xx_alwon_l3_fast__tptc1 = {
 	.master		= &dm81xx_alwon_l3_fast_hwmod,
 	.slave		= &dm81xx_tptc1_hwmod,
 	.clk		= "sysclk4_ck",
-	.addr		= dm81xx_tptc1_addr_space,
 	.user		= OCP_USER_MPU,
 };
 
@@ -1340,19 +1319,9 @@ static struct omap_hwmod_ocp_if dm81xx_tptc1__alwon_l3_fast = {
 	.master		= &dm81xx_tptc1_hwmod,
 	.slave		= &dm81xx_alwon_l3_fast_hwmod,
 	.clk		= "sysclk4_ck",
-	.addr		= dm81xx_tptc1_addr_space,
 	.user		= OCP_USER_MPU,
 };
 
-static struct omap_hwmod_addr_space dm81xx_tptc2_addr_space[] = {
-	{
-		.pa_start	= 0x49a00000,
-		.pa_end		= 0x49a00000 + SZ_8K - 1,
-		.flags		= ADDR_TYPE_RT,
-	},
-	{ },
-};
-
 static struct omap_hwmod_class dm81xx_tptc2_hwmod_class = {
 	.name		= "tptc2",
 };
@@ -1374,7 +1343,6 @@ static struct omap_hwmod_ocp_if dm81xx_alwon_l3_fast__tptc2 = {
 	.master		= &dm81xx_alwon_l3_fast_hwmod,
 	.slave		= &dm81xx_tptc2_hwmod,
 	.clk		= "sysclk4_ck",
-	.addr		= dm81xx_tptc2_addr_space,
 	.user		= OCP_USER_MPU,
 };
 
@@ -1382,19 +1350,9 @@ static struct omap_hwmod_ocp_if dm81xx_tptc2__alwon_l3_fast = {
 	.master		= &dm81xx_tptc2_hwmod,
 	.slave		= &dm81xx_alwon_l3_fast_hwmod,
 	.clk		= "sysclk4_ck",
-	.addr		= dm81xx_tptc2_addr_space,
 	.user		= OCP_USER_MPU,
 };
 
-static struct omap_hwmod_addr_space dm81xx_tptc3_addr_space[] = {
-	{
-		.pa_start	= 0x49b00000,
-		.pa_end		= 0x49b00000 + SZ_8K - 1,
-		.flags		= ADDR_TYPE_RT,
-	},
-	{ },
-};
-
 static struct omap_hwmod_class dm81xx_tptc3_hwmod_class = {
 	.name		= "tptc3",
 };
@@ -1416,7 +1374,6 @@ static struct omap_hwmod_ocp_if dm81xx_alwon_l3_fast__tptc3 = {
 	.master		= &dm81xx_alwon_l3_fast_hwmod,
 	.slave		= &dm81xx_tptc3_hwmod,
 	.clk		= "sysclk4_ck",
-	.addr		= dm81xx_tptc3_addr_space,
 	.user		= OCP_USER_MPU,
 };
 
@@ -1424,7 +1381,6 @@ static struct omap_hwmod_ocp_if dm81xx_tptc3__alwon_l3_fast = {
 	.master		= &dm81xx_tptc3_hwmod,
 	.slave		= &dm81xx_alwon_l3_fast_hwmod,
 	.clk		= "sysclk4_ck",
-	.addr		= dm81xx_tptc3_addr_space,
 	.user		= OCP_USER_MPU,
 };
 
diff --git a/arch/arm/mach-omap2/omap_hwmod_common_data.h b/arch/arm/mach-omap2/omap_hwmod_common_data.h
--- a/arch/arm/mach-omap2/omap_hwmod_common_data.h
+++ b/arch/arm/mach-omap2/omap_hwmod_common_data.h
@@ -18,9 +18,6 @@
 #include "common.h"
 #include "display.h"
 
-/* Common address space across OMAP2xxx/3xxx */
-extern struct omap_hwmod_addr_space omap2_dma_system_addrs[];
-
 /* Common IP block data across OMAP2xxx */
 extern struct omap_gpio_dev_attr omap2xxx_gpio_dev_attr;
 extern struct omap_hwmod omap2xxx_l3_main_hwmod;
@@ -89,9 +86,6 @@ extern struct omap_hwmod_ocp_if omap2xxx_l4_core__rng;
 extern struct omap_hwmod_ocp_if omap2xxx_l4_core__sham;
 extern struct omap_hwmod_ocp_if omap2xxx_l4_core__aes;
 
-/* Common IP block data across OMAP2/3 */
-extern struct omap_hwmod_addr_space omap2xxx_timer12_addrs[];
-
 /* OMAP hwmod classes - forward declarations */
 extern struct omap_hwmod_class l3_hwmod_class;
 extern struct omap_hwmod_class l4_hwmod_class;
-- 
2.14.1
