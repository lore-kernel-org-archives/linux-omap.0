From: Rajendra Nayak <rnayak@ti.com>
Subject: RE: [PATCH 01/11] OMAP4: PRCM: add OMAP4-specific accessor/mutatorfunctions
Date: Wed, 8 Dec 2010 19:20:05 +0530
Message-ID: <3407936b2b482d0f7f6b5bb273455377@mail.gmail.com>
References: <20101208061657.30541.79824.stgit@twilight.localdomain> <20101208061829.30541.99531.stgit@twilight.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:53482 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754243Ab0LHNuI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 8 Dec 2010 08:50:08 -0500
Received: by mail-vw0-f47.google.com with SMTP id 6so981665vws.6
        for <linux-omap@vger.kernel.org>; Wed, 08 Dec 2010 05:50:08 -0800 (PST)
In-Reply-To: <20101208061829.30541.99531.stgit@twilight.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>, Benoit Cousson <b-cousson@ti.com>

<snip>...

> +++ b/arch/arm/mach-omap2/cminst44xx.c
> @@ -0,0 +1,118 @@
> +/*
> + * OMAP4 CM instance functions
> + *
> + * Copyright (C) 2009 Nokia Corporation
> + * Paul Walmsley
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * This is needed since CM instances can be in the PRM, PRCM_MPU, CM1,
> + * or CM2 hardware modules.  For example, the EMU_CM CM instance is in
> + * the PRM hardware module.  What a mess...
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/types.h>
> +#include <linux/errno.h>
> +#include <linux/err.h>
> +#include <linux/io.h>
> +
> +#include <plat/common.h>
> +
> +#include "cm.h"
> +#include "cm1_44xx.h"
> +#include "cm2_44xx.h"
> +#include "cm44xx.h"
> +#include "cminst44xx.h"

This header seems to be missed in the series.

> +#include "cm-regbits-44xx.h"
> +#include "prcm44xx.h"
> +#include "prm44xx.h"
> +#include "prcm_mpu44xx.h"
> +
> +static u32 (*_cm_read_fns[OMAP4_MAX_PRCM_PARTITIONS])(s16, u16)  = {
> +	[OMAP4430_INVALID_PRCM_PARTITION]	= NULL,
> +	[OMAP4430_PRM_PARTITION]		=
&omap4_prm_read_inst_reg,
> +	[OMAP4430_CM1_PARTITION]		=
&omap4_cm1_read_inst_reg,
> +	[OMAP4430_CM2_PARTITION]		=
&omap4_cm2_read_inst_reg,
> +	[OMAP4430_SCRM_PARTITION]		= NULL,
> +	[OMAP4430_PRCM_MPU_PARTITION]		=
&omap4_prcm_mpu_read_inst_reg
> +};
> +
> +static void (*_cm_write_fns[OMAP4_MAX_PRCM_PARTITIONS])(u32, s16, u16)
= {
> +	[OMAP4430_INVALID_PRCM_PARTITION]	= NULL,
> +	[OMAP4430_PRM_PARTITION]		=
&omap4_prm_write_inst_reg,
> +	[OMAP4430_CM1_PARTITION]		=
&omap4_cm1_write_inst_reg,
> +	[OMAP4430_CM2_PARTITION]		=
&omap4_cm2_write_inst_reg,
> +	[OMAP4430_SCRM_PARTITION]		= NULL,
> +	[OMAP4430_PRCM_MPU_PARTITION]		=
&omap4_prcm_mpu_write_inst_reg
> +};
> +
> +/* Read a register in a CM instance */
> +u32 omap4_cminst_read_inst_reg(u8 part, s16 module, u16 idx)
> +{
> +	BUG_ON(part >= OMAP4_MAX_PRCM_PARTITIONS ||
> +	       part == OMAP4430_INVALID_PRCM_PARTITION ||
> +	       !_cm_read_fns[part]);
> +	return _cm_read_fns[part](module, idx);
> +}
> +
> +/* Write into a register in a CM instance */
> +void omap4_cminst_write_inst_reg(u32 val, u8 part, s16 module, u16 idx)
> +{
> +	BUG_ON(part >= OMAP4_MAX_PRCM_PARTITIONS ||
> +	       part == OMAP4430_INVALID_PRCM_PARTITION ||
> +	       !_cm_write_fns[part]);
> +	_cm_write_fns[part](val, module, idx);
> +}
> +
> +/* Read-modify-write a register in CM1. Caller must lock */
> +u32 omap4_cminst_rmw_inst_reg_bits(u32 mask, u32 bits, u8 part,
> +				  s16 module, s16 idx)
> +{
> +	u32 v;
> +
> +	v = omap4_cminst_read_inst_reg(part, module, idx);
> +	v &= ~mask;
> +	v |= bits;
> +	omap4_cminst_write_inst_reg(v, part, module, idx);
> +
> +	return v;
> +}
> +
> +
> +/**
> + * omap4_cm_wait_module_ready - wait for a module to be in 'func' state
> + * @clkctrl_reg: CLKCTRL module address
> + *
> + * Wait for the module IDLEST to be functional. If the idle state is in
any
> + * the non functional state (trans, idle or disabled), module and thus
the
> + * sysconfig cannot be accessed and will probably lead to an "imprecise
> + * external abort"
> + *
> + * Module idle state:
> + *   0x0 func:     Module is fully functional, including OCP
> + *   0x1 trans:    Module is performing transition: wakeup, or sleep,
or sleep
> + *                 abortion
> + *   0x2 idle:     Module is in Idle mode (only OCP part). It is
functional if
> + *                 using separate functional clock
> + *   0x3 disabled: Module is disabled and cannot be accessed
> + *
> + */
> +int omap4_cm_wait_module_ready(void __iomem *clkctrl_reg)
> +{
> +	int i = 0;
> +
> +	if (!clkctrl_reg)
> +		return 0;
> +
> +	omap_test_timeout((
> +		((__raw_readl(clkctrl_reg) & OMAP4430_IDLEST_MASK) == 0)
||
> +		 (((__raw_readl(clkctrl_reg) & OMAP4430_IDLEST_MASK) >>
> +		  OMAP4430_IDLEST_SHIFT) == 0x2)),
> +		MAX_MODULE_READY_TIME, i);
> +
> +	return (i < MAX_MODULE_READY_TIME) ? 0 : -EBUSY;
> +}
> +
> diff --git a/arch/arm/mach-omap2/prcm.c b/arch/arm/mach-omap2/prcm.c
> index dd95cbb..fe0865b 100644
> --- a/arch/arm/mach-omap2/prcm.c
> +++ b/arch/arm/mach-omap2/prcm.c
> @@ -33,6 +33,7 @@
>  #include "cm44xx.h"
>  #include "prm2xxx_3xxx.h"
>  #include "prm44xx.h"
> +#include "prcm44xx.h"
>  #include "prm-regbits-24xx.h"
>  #include "prm-regbits-44xx.h"
>  #include "control.h"
> @@ -80,31 +81,6 @@ void omap_prcm_arch_reset(char mode, const char *cmd)
>  				     prcm_offs, OMAP4_RM_RSTCTRL);
>  }
>
> -/* Read a PRM register, AND it, and shift the result down to bit 0 */
> -u32 omap4_prm_read_bits_shift(void __iomem *reg, u32 mask)
> -{
> -	u32 v;
> -
> -	v = __raw_readl(reg);
> -	v &= mask;
> -	v >>= __ffs(mask);
> -
> -	return v;
> -}
> -
> -/* Read-modify-write a register in a PRM module. Caller must lock */
> -u32 omap4_prm_rmw_reg_bits(u32 mask, u32 bits, void __iomem *reg)
> -{
> -	u32 v;
> -
> -	v = __raw_readl(reg);
> -	v &= ~mask;
> -	v |= bits;
> -	__raw_writel(v, reg);
> -
> -	return v;
> -}
> -
>  /**
>   * omap2_cm_wait_idlest - wait for IDLEST bit to indicate module
readiness
>   * @reg: physical address of module IDLEST register
> diff --git a/arch/arm/mach-omap2/prcm44xx.h
b/arch/arm/mach-omap2/prcm44xx.h
> new file mode 100644
> index 0000000..7334ffb
> --- /dev/null
> +++ b/arch/arm/mach-omap2/prcm44xx.h
> @@ -0,0 +1,42 @@
> +/*
> + * OMAP4 PRCM definitions
> + *
> + * Copyright (C) 2010 Texas Instruments, Inc.
> + * Copyright (C) 2010 Nokia Corporation
> + *
> + * Paul Walmsley
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * This file contains macros and functions that are common to all of
> + * the PRM/CM/PRCM blocks on the OMAP4 devices: PRM, CM1, CM2,
> + * PRCM_MPU, SCRM
> + */
> +
> +#ifndef __ARCH_ARM_MACH_OMAP2_PRCM44XX_H
> +#define __ARCH_ARM_MACH_OMAP2_PRCM44XX_H
> +
> +/*
> + * OMAP4 PRCM partition IDs
> + *
> + * The numbers and order are arbitrary, but 0 is reserved for the
> + * 'invalid' partition in case someone forgets to add a
> + * .prcm_partition field.
> + */
> +#define OMAP4430_INVALID_PRCM_PARTITION		0
> +#define OMAP4430_PRM_PARTITION			1
> +#define OMAP4430_CM1_PARTITION			2
> +#define OMAP4430_CM2_PARTITION			3
> +#define OMAP4430_SCRM_PARTITION			4
> +#define OMAP4430_PRCM_MPU_PARTITION		5
> +
> +/*
> + * OMAP4_MAX_PRCM_PARTITIONS: set to the highest value of the PRCM
partition
> + * IDs, plus one
> + */
> +#define OMAP4_MAX_PRCM_PARTITIONS		6
> +
> +
> +#endif
> diff --git a/arch/arm/mach-omap2/prcm_mpu44xx.c
b/arch/arm/mach-omap2/prcm_mpu44xx.c
> new file mode 100644
> index 0000000..171fe17
> --- /dev/null
> +++ b/arch/arm/mach-omap2/prcm_mpu44xx.c
> @@ -0,0 +1,45 @@
> +/*
> + * OMAP4 PRCM_MPU module functions
> + *
> + * Copyright (C) 2009 Nokia Corporation
> + * Paul Walmsley
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/types.h>
> +#include <linux/errno.h>
> +#include <linux/err.h>
> +#include <linux/io.h>
> +
> +#include <plat/common.h>
> +
> +#include "prcm_mpu44xx.h"
> +#include "cm-regbits-44xx.h"
> +
> +/* PRCM_MPU low-level functions */
> +
> +u32 omap4_prcm_mpu_read_inst_reg(s16 inst, u16 reg)
> +{
> +	return __raw_readl(OMAP44XX_PRCM_MPU_REGADDR(inst, reg));
> +}
> +
> +void omap4_prcm_mpu_write_inst_reg(u32 val, s16 inst, u16 reg)
> +{
> +	__raw_writel(val, OMAP44XX_PRCM_MPU_REGADDR(inst, reg));
> +}
> +
> +u32 omap4_prcm_mpu_rmw_inst_reg_bits(u32 mask, u32 bits, s16 inst, s16
reg)
> +{
> +	u32 v;
> +
> +	v = omap4_prcm_mpu_read_inst_reg(inst, reg);
> +	v &= ~mask;
> +	v |= bits;
> +	omap4_prcm_mpu_write_inst_reg(v, inst, reg);
> +
> +	return v;
> +}
> diff --git a/arch/arm/mach-omap2/prcm_mpu44xx.h
b/arch/arm/mach-omap2/prcm_mpu44xx.h
> index 80e00c1..e5190e9 100644
> --- a/arch/arm/mach-omap2/prcm_mpu44xx.h
> +++ b/arch/arm/mach-omap2/prcm_mpu44xx.h
> @@ -88,4 +88,12 @@
>  #define OMAP4_CM_CPU1_CLKSTCTRL_OFFSET			0x0018
>  #define OMAP4430_CM_CPU1_CLKSTCTRL
> 	OMAP44XX_PRCM_MPU_REGADDR(OMAP4430_PRCM_MPU_CPU1_INST, 0x0018)
>
> +/* Function prototypes */
> +# ifndef __ASSEMBLER__
> +extern u32 omap4_prcm_mpu_read_inst_reg(s16 inst, u16 idx);
> +extern void omap4_prcm_mpu_write_inst_reg(u32 val, s16 inst, u16 idx);
> +extern u32 omap4_prcm_mpu_rmw_inst_reg_bits(u32 mask, u32 bits, s16
inst,
> +					    s16 idx);
> +# endif
> +
>  #endif
> diff --git a/arch/arm/mach-omap2/prm44xx.c
b/arch/arm/mach-omap2/prm44xx.c
> index 697b58f..c016ae4 100644
> --- a/arch/arm/mach-omap2/prm44xx.c
> +++ b/arch/arm/mach-omap2/prm44xx.c
> @@ -15,6 +15,7 @@
>  #include <linux/delay.h>
>  #include <linux/errno.h>
>  #include <linux/err.h>
> +#include <linux/io.h>
>
>  #include <plat/common.h>
>  #include <plat/cpu.h>
> @@ -29,6 +30,70 @@
>   */
>  #define OMAP4_RST_CTRL_ST_OFFSET		4
>
> +/* PRM low-level functions */
> +
> +/* Read a register in a CM/PRM instance in the PRM module */
> +u32 omap4_prm_read_inst_reg(s16 inst, u16 reg)
> +{
> +	return __raw_readl(OMAP44XX_PRM_REGADDR(inst, reg));
> +}
> +
> +/* Write into a register in a CM/PRM instance in the PRM module */
> +void omap4_prm_write_inst_reg(u32 val, s16 inst, u16 reg)
> +{
> +	__raw_writel(val, OMAP44XX_PRM_REGADDR(inst, reg));
> +}
> +
> +/* Read-modify-write a register in a PRM module. Caller must lock */
> +u32 omap4_prm_rmw_inst_reg_bits(u32 mask, u32 bits, s16 inst, s16 reg)
> +{
> +	u32 v;
> +
> +	v = omap4_prm_read_inst_reg(inst, reg);
> +	v &= ~mask;
> +	v |= bits;
> +	omap4_prm_write_inst_reg(v, inst, reg);
> +
> +	return v;
> +}
> +
> +/* Read a PRM register, AND it, and shift the result down to bit 0 */
> +/* XXX deprecated */
> +u32 omap4_prm_read_bits_shift(void __iomem *reg, u32 mask)
> +{
> +	u32 v;
> +
> +	v = __raw_readl(reg);
> +	v &= mask;
> +	v >>= __ffs(mask);
> +
> +	return v;
> +}
> +
> +/* Read-modify-write a register in a PRM module. Caller must lock */
> +/* XXX deprecated */
> +u32 omap4_prm_rmw_reg_bits(u32 mask, u32 bits, void __iomem *reg)
> +{
> +	u32 v;
> +
> +	v = __raw_readl(reg);
> +	v &= ~mask;
> +	v |= bits;
> +	__raw_writel(v, reg);
> +
> +	return v;
> +}
> +
> +u32 omap4_prm_set_inst_reg_bits(u32 bits, s16 inst, s16 reg)
> +{
> +	return omap4_prm_rmw_inst_reg_bits(bits, bits, inst, reg);
> +}
> +
> +u32 omap4_prm_clear_inst_reg_bits(u32 bits, s16 inst, s16 reg)
> +{
> +	return omap4_prm_rmw_inst_reg_bits(bits, 0x0, inst, reg);
> +}
> +
>  /**
>   * omap4_prm_is_hardreset_asserted - read the HW reset line state of
>   * submodules contained in the hwmod module
> diff --git a/arch/arm/mach-omap2/prm44xx.h
b/arch/arm/mach-omap2/prm44xx.h
> index 3d36149..3588653 100644
> --- a/arch/arm/mach-omap2/prm44xx.h
> +++ b/arch/arm/mach-omap2/prm44xx.h
> @@ -744,6 +744,12 @@
>  /* Function prototypes */
>  # ifndef __ASSEMBLER__
>
> +extern u32 omap4_prm_read_inst_reg(s16 inst, u16 idx);
> +extern void omap4_prm_write_inst_reg(u32 val, s16 inst, u16 idx);
> +extern u32 omap4_prm_rmw_inst_reg_bits(u32 mask, u32 bits, s16 inst,
s16 idx);
> +extern u32 omap4_prm_rmw_reg_bits(u32 mask, u32 bits, void __iomem
*reg);
> +extern u32 omap4_prm_set_inst_reg_bits(u32 bits, s16 inst, s16 idx);
> +extern u32 omap4_prm_clear_inst_reg_bits(u32 bits, s16 inst, s16 idx);
>  extern u32 omap4_prm_read_bits_shift(void __iomem *reg, u32 mask);
>
>  extern int omap4_prm_is_hardreset_asserted(void __iomem *rstctrl_reg,
u8 shift);
> diff --git a/arch/arm/mach-omap2/prminst44xx.c
b/arch/arm/mach-omap2/prminst44xx.c
> new file mode 100644
> index 0000000..01c57b6
> --- /dev/null
> +++ b/arch/arm/mach-omap2/prminst44xx.c
> @@ -0,0 +1,74 @@
> +/*
> + * OMAP4 PRM instance functions
> + *
> + * Copyright (C) 2009 Nokia Corporation
> + * Paul Walmsley
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/types.h>
> +#include <linux/errno.h>
> +#include <linux/err.h>
> +#include <linux/io.h>
> +
> +#include <plat/common.h>
> +
> +#include "prm44xx.h"
> +#include "prminst44xx.h"
> +#include "prm-regbits-44xx.h"
> +#include "prcm44xx.h"
> +#include "prcm_mpu44xx.h"
> +
> +static u32 (*_prm_read_fns[OMAP4_MAX_PRCM_PARTITIONS])(s16, u16)  = {
> +	[OMAP4430_INVALID_PRCM_PARTITION]	= NULL,
> +	[OMAP4430_PRM_PARTITION]		=
&omap4_prm_read_inst_reg,
> +	[OMAP4430_CM1_PARTITION]		= NULL,
> +	[OMAP4430_CM2_PARTITION]		= NULL,
> +	[OMAP4430_SCRM_PARTITION]		= NULL,
> +	[OMAP4430_PRCM_MPU_PARTITION]		=
&omap4_prcm_mpu_read_inst_reg
> +};
> +
> +static void (*_prm_write_fns[OMAP4_MAX_PRCM_PARTITIONS])(u32, s16, u16)
= {
> +	[OMAP4430_INVALID_PRCM_PARTITION]	= NULL,
> +	[OMAP4430_PRM_PARTITION]		=
&omap4_prm_write_inst_reg,
> +	[OMAP4430_CM1_PARTITION]		= NULL,
> +	[OMAP4430_CM2_PARTITION]		= NULL,
> +	[OMAP4430_SCRM_PARTITION]		= NULL,
> +	[OMAP4430_PRCM_MPU_PARTITION]		=
&omap4_prcm_mpu_write_inst_reg
> +};
> +
> +/* Read a register in a PRM instance */
> +u32 omap4_prminst_read_inst_reg(u8 part, s16 inst, u16 idx)
> +{
> +	BUG_ON(part >= OMAP4_MAX_PRCM_PARTITIONS ||
> +	       part == OMAP4430_INVALID_PRCM_PARTITION ||
> +	       !_prm_read_fns[part]);
> +	return _prm_read_fns[part](inst, idx);
> +}
> +
> +/* Write into a register in a PRM instance */
> +void omap4_prminst_write_inst_reg(u32 val, u8 part, s16 inst, u16 idx)
> +{
> +	BUG_ON(part >= OMAP4_MAX_PRCM_PARTITIONS ||
> +	       part == OMAP4430_INVALID_PRCM_PARTITION ||
> +	       !_prm_write_fns[part]);
> +	_prm_write_fns[part](val, inst, idx);
> +}
> +
> +/* Read-modify-write a register in PRM. Caller must lock */
> +u32 omap4_prminst_rmw_inst_reg_bits(u32 mask, u32 bits, u8 part, s16
inst,
> +				   s16 idx)
> +{
> +	u32 v;
> +
> +	v = omap4_prminst_read_inst_reg(part, inst, idx);
> +	v &= ~mask;
> +	v |= bits;
> +	omap4_prminst_write_inst_reg(v, part, inst, idx);
> +
> +	return v;
> +}
> diff --git a/arch/arm/mach-omap2/prminst44xx.h
b/arch/arm/mach-omap2/prminst44xx.h
> new file mode 100644
> index 0000000..02dd66d
> --- /dev/null
> +++ b/arch/arm/mach-omap2/prminst44xx.h
> @@ -0,0 +1,25 @@
> +/*
> + * OMAP4 Power/Reset Management (PRM) function prototypes
> + *
> + * Copyright (C) 2010 Nokia Corporation
> + * Paul Walmsley
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +#ifndef __ARCH_ASM_MACH_OMAP2_PRMINST44XX_H
> +#define __ARCH_ASM_MACH_OMAP2_PRMINST44XX_H
> +
> +/*
> + * In an ideal world, we would not export these low-level functions,
> + * but this will probably take some time to fix properly
> + */
> +extern u32 omap4_prminst_read_inst_reg(u8 part, s16 inst, u16 idx);
> +extern void omap4_prminst_write_inst_reg(u32 val, u8 part, s16 inst,
u16 idx);
> +extern u32 omap4_prminst_rmw_inst_reg_bits(u32 mask, u32 bits, u8 part,
> +					   s16 inst, s16 idx);
> +
> +extern void omap4_prm_global_warm_sw_reset(void);
> +
> +#endif
> diff --git a/arch/arm/plat-omap/include/plat/prcm.h
b/arch/arm/plat-omap/include/plat/prcm.h
> index d059a05..078906d 100644
> --- a/arch/arm/plat-omap/include/plat/prcm.h
> +++ b/arch/arm/plat-omap/include/plat/prcm.h
> @@ -18,6 +18,10 @@
>   * You should have received a copy of the GNU General Public License
>   * along with this program; if not, write to the Free Software
>   * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307
USA
> + *
> + * XXX This file is deprecated.  The PRCM is an OMAP2+-only subsystem,
> + * so this file doesn't belong in plat-omap/include/plat.  Please
> + * do not add anything new to this file.
>   */
>
>  #ifndef __ASM_ARM_ARCH_OMAP_PRCM_H
> @@ -31,9 +35,6 @@ int omap2_cm_wait_idlest(void __iomem *reg, u32 mask,
u8 idlest,
>  #define START_PADCONF_SAVE 0x2
>  #define PADCONF_SAVE_DONE  0x1
>
> -u32 omap4_prm_read_bits_shift(void __iomem *reg, u32 mask);
> -u32 omap4_prm_rmw_reg_bits(u32 mask, u32 bits, void __iomem *reg);
> -
>  #endif
>
>
>
