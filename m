From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 09/16] OMAP3: PM: Creating separate files for handling OMAP3 voltage related operations.
Date: Tue, 02 Mar 2010 12:02:44 -0800
Message-ID: <87zl2qtrtn.fsf@deeprootsystems.com>
References: <1267003757-22456-1-git-send-email-thara@ti.com>
	<1267003757-22456-2-git-send-email-thara@ti.com>
	<1267003757-22456-3-git-send-email-thara@ti.com>
	<1267003757-22456-4-git-send-email-thara@ti.com>
	<1267003757-22456-5-git-send-email-thara@ti.com>
	<1267003757-22456-6-git-send-email-thara@ti.com>
	<1267003757-22456-7-git-send-email-thara@ti.com>
	<1267003757-22456-8-git-send-email-thara@ti.com>
	<1267003757-22456-9-git-send-email-thara@ti.com>
	<1267003757-22456-10-git-send-email-thara@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f201.google.com ([209.85.222.201]:54393 "EHLO
	mail-pz0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754794Ab0CBUCr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 2 Mar 2010 15:02:47 -0500
Received: by pzk39 with SMTP id 39so179625pzk.15
        for <linux-omap@vger.kernel.org>; Tue, 02 Mar 2010 12:02:47 -0800 (PST)
In-Reply-To: <1267003757-22456-10-git-send-email-thara@ti.com> (Thara Gopinath's message of "Wed\, 24 Feb 2010 14\:59\:10 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Thara Gopinath <thara@ti.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, nm@ti.com, b-cousson@ti.com, vishwanath.bs@ti.com, sawant@ti.com

Thara Gopinath <thara@ti.com> writes:

> This patch creates voltage.c and voltage.h files and
> moves all voltage processor and voltage controller specific code
> from smartreflex.c and other places in the OMAP3 codebase into
> these two files.
> This along with smartreflex class driver addition will make
> smartreflex.c a generic driver to support both Class 2 and
> Class 3 smartreflex implementaions.
>
> Signed-off-by: Thara Gopinath <thara@ti.com>

This is definitely in the right direction.  Thanks Thara.

Also, is this expected to be common for OMAP4?   If not, maybe
this should be named voltage3xxx.[ch]?

More comments below, primarily regarding how the various VP/VC
registers are defined and accessed.  I'd rather see them as offsets
into the PRCM rather than absolute virtual addresses.  More on that
below...

> ---
>  arch/arm/mach-omap2/Makefile             |    3 +-
>  arch/arm/mach-omap2/board-3430sdp.c      |    3 +-
>  arch/arm/mach-omap2/pm.h                 |    7 -
>  arch/arm/mach-omap2/pm34xx.c             |   87 +-----
>  arch/arm/mach-omap2/resource34xx.c       |   15 +-
>  arch/arm/mach-omap2/resource34xx.h       |    1 -
>  arch/arm/mach-omap2/smartreflex-class3.c |    4 +
>  arch/arm/mach-omap2/smartreflex.c        |  370 +--------------------
>  arch/arm/mach-omap2/smartreflex.h        |  139 --------
>  arch/arm/mach-omap2/voltage.c            |  550 ++++++++++++++++++++++++++++++
>  arch/arm/mach-omap2/voltage.h            |   74 ++++
>  11 files changed, 640 insertions(+), 613 deletions(-)
>  create mode 100644 arch/arm/mach-omap2/voltage.c
>  create mode 100644 arch/arm/mach-omap2/voltage.h
>

[...]

> diff --git a/arch/arm/mach-omap2/voltage.c b/arch/arm/mach-omap2/voltage.c
> new file mode 100644
> index 0000000..c0c2c17
> --- /dev/null
> +++ b/arch/arm/mach-omap2/voltage.c
> @@ -0,0 +1,550 @@
> +/*
> + * OMAP3/OMAP4 Voltage Management Routines
> + *
> + * Copyright (C) 2007 Texas Instruments, Inc.
> + * Rajendra Nayak <rnayak@ti.com>
> + * Lesly A M <x0080970@ti.com>
> + *
> + * Copyright (C) 2008 Nokia Corporation
> + * Kalle Jokiniemi
> + *
> + * Copyright (C) 2010 Texas Instruments, Inc.
> + * Thara Gopinath <thara@ti.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <linux/pm.h>
> +#include <linux/delay.h>
> +#include <linux/io.h>
> +
> +#include <plat/omap-pm.h>
> +#include <plat/omap34xx.h>
> +#include <plat/opp.h>
> +#include <plat/opp_twl_tps.h>
> +
> +#include "prm-regbits-34xx.h"
> +#include "voltage.h"
> +
> +#define MAX_TRIES 100
> +
> +/**
> + * OMAP3 Voltage controller SR parameters. TODO: Pass this info as part of
> + * board data or PMIC data
> + */
> +#define R_SRI2C_SLAVE_ADDR              0x12
> +#define R_VDD1_SR_CONTROL               0x00
> +#define R_VDD2_SR_CONTROL		0x01
> +
> +
> +/* Voltage processor register offsets */
> +struct vp_reg_offs {
> +	void __iomem *vp_vpconfig_reg;
> +	void __iomem *vp_vstepmin_reg;
> +	void __iomem *vp_vstepmax_reg;
> +	void __iomem *vp_vlimitto_reg;
> +	void __iomem *vp_status_reg;
> +	void __iomem *vp_voltage_reg;
> +};
>
> +/*
> + * Voltage processor structure conttaining info about
> + * the various register offsets and the bit field values
> + * for a particular instance of voltage processor.
> + */
> +struct vp_reg_info {
> +	struct vp_reg_offs vp_offs;
> +	/* Bit fields for VPx_VPCONFIG */
> +	u32 vp_erroroffset;
> +	u32 vp_errorgain;
> +	/* Bit fields for VPx_VSTEPMIN */
> +	u32 vp_stepmin;
> +	u32 vp_smpswaittimemin;
> +	/* Bit fields for VPx_VSTEPMAX */
> +	u32 vp_stepmax;
> +	u32 vp_smpswaittimemax;
> +	/* Bit fields for VPx_VLIMITTO */
> +	u32 vp_vddmin;
> +	u32 vp_vddmax;
> +	u32 vp_timeout;
> +};
> +static struct vp_reg_info *vp_reg;
> +/*
> + * Number of scalable voltage domains that has an independent
> + * Voltage processor
> + */
> +static int no_scalable_vdd;
> +
> +/* OMAP3 VP register offsets and other definitions */
> +struct __init vp_reg_offs omap3_vp_offs[] = {
> +	/* VP1 */
> +	{
> +		.vp_vpconfig_reg = OMAP3430_PRM_VP1_CONFIG,
> +		.vp_vstepmin_reg = OMAP3430_PRM_VP1_VSTEPMIN,
> +		.vp_vstepmax_reg = OMAP3430_PRM_VP1_VSTEPMAX,
> +		.vp_vlimitto_reg = OMAP3430_PRM_VP1_VLIMITTO,
> +		.vp_status_reg = OMAP3430_PRM_VP1_STATUS,
> +		.vp_voltage_reg = OMAP3430_PRM_VP1_VOLTAGE,
> +	},
> +	/* VP2 */
> +	{	.vp_vpconfig_reg = OMAP3430_PRM_VP2_CONFIG,
> +		.vp_vstepmin_reg = OMAP3430_PRM_VP2_VSTEPMIN,
> +		.vp_vstepmax_reg = OMAP3430_PRM_VP2_VSTEPMAX,
> +		.vp_vlimitto_reg = OMAP3430_PRM_VP2_VLIMITTO,
> +		.vp_status_reg = OMAP3430_PRM_VP2_STATUS,
> +		.vp_voltage_reg = OMAP3430_PRM_VP2_VOLTAGE,
> +	},
> +};
> +


Rather than absolute physical addresses, these should all simply be u8
offset values from the GR_MOD base.  Changing the type to u8
and appending _OFFSET to the name should do the trick.

Also, I think you could remove the vp_ prefix from the name.

> +#define OMAP3_NO_SCALABLE_VDD ARRAY_SIZE(omap3_vp_offs)
> +static struct vp_reg_info omap3_vp_reg[OMAP3_NO_SCALABLE_VDD];
> +
> +
> +/* TODO: OMAP4 register offsets */
> +
> +/**
> + * Voltage controller register offsets
> + */
> +struct vc_reg_info {
> +	void __iomem *vc_cmdval0_reg;
> +	void __iomem *vc_cmdval1_reg;
> +	void __iomem *vc_bypass_val_reg;

u8 offsets from GR_MOD please.

vc_ prefix is redundant here also

> +} vc_reg;
> +/*
> + * Default voltage controller settings for OMAP3
> + */
> +static struct prm_setup_vc vc_config = {
> +	.clksetup = 0xff,
> +	.voltsetup_time1 = 0xfff,
> +	.voltsetup_time2 = 0xfff,
> +	.voltoffset = 0xff,
> +	.voltsetup2 = 0xff,
> +	.vdd0_on = 0x30,        /* 1.2v */
> +	.vdd0_onlp = 0x20,      /* 1.0v */
> +	.vdd0_ret = 0x1e,       /* 0.975v */
> +	.vdd0_off = 0x00,       /* 0.6v */
> +	.vdd1_on = 0x2c,        /* 1.15v */
> +	.vdd1_onlp = 0x20,      /* 1.0v */
> +	.vdd1_ret = 0x1e,       /* .975v */
> +	.vdd1_off = 0x00,       /* 0.6v */
> +};
> +
> +static inline u32 voltage_read_reg(void __iomem *offset)
> +{
> +	return __raw_readl(offset);
> +}

These should use prm_[read|write]_*

static inline u32 voltage_read_reg(u8 offset)
{
        return prm_read_mod_reg(OMAP3430_GR_MOD, offset);
}

> +
> +static inline void voltage_write_reg(void __iomem *offset, u32 value)
> +{
> +	__raw_writel(value, offset);
> +}
> +

Kevin
