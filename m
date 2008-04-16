From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 5/5] Powerdomains: Add OMAP3 powerdomains
Date: Wed, 16 Apr 2008 14:42:31 -0700
Message-ID: <20080416214228.GO17055@atomide.com>
References: <20080410144624.246788469@pwsan.com> <20080410153344.268066631@pwsan.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-bos.mailhop.org ([63.208.196.179]:51441 "EHLO
	mho-02-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933339AbYDPVmi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 16 Apr 2008 17:42:38 -0400
Content-Disposition: inline
In-Reply-To: <20080410153344.268066631@pwsan.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org

* Paul Walmsley <paul@pwsan.com> [080410 10:16]:
> Add OMAP3 powerdomains

This one seems to be missing S-o-b.

Tony

> ---
>  arch/arm/mach-omap2/powerdomains.h     |   20 ++
>  arch/arm/mach-omap2/powerdomains34xx.h |  296 ++++++++++++++++++++++=
+++++++++++
>  arch/arm/mach-omap2/prcm-common.h      |    3=20
>  arch/arm/mach-omap2/prm-regbits-34xx.h |   11 -
>  4 files changed, 323 insertions(+), 7 deletions(-)
>=20
> Index: linux-omap/arch/arm/mach-omap2/powerdomains.h
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-omap.orig/arch/arm/mach-omap2/powerdomains.h	2008-04-10 08:=
41:54.000000000 -0600
> +++ linux-omap/arch/arm/mach-omap2/powerdomains.h	2008-04-10 08:41:54=
=2E000000000 -0600
> @@ -95,9 +95,12 @@
>  	{ NULL },
>  };
> =20
> -/* Include 24XX-specific powerdomains (which may reference the above=
 wkdeps) */
> -
> +/*
> + * Include 24XX & 34XX-specific powerdomains (which may reference th=
e
> + * above wkdeps)
> + */
>  #include "powerdomains24xx.h"
> +#include "powerdomains34xx.h"
> =20
> =20
>  /*
> @@ -151,6 +154,19 @@
>  	&mdm_pwrdm,
>  #endif
> =20
> +#ifdef CONFIG_ARCH_OMAP34XX
> +	&iva2_pwrdm,
> +	&mpu_34xx_pwrdm,
> +	&neon_pwrdm,
> +	&core_34xx_pwrdm,
> +	&cam_pwrdm,
> +	&dss_pwrdm,
> +	&per_pwrdm,
> +	&emu_pwrdm,
> +	&sgx_pwrdm,
> +	&usbhost_pwrdm,
> +#endif
> +
>  	NULL
>  };
> =20
> Index: linux-omap/arch/arm/mach-omap2/powerdomains34xx.h
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- /dev/null	1970-01-01 00:00:00.000000000 +0000
> +++ linux-omap/arch/arm/mach-omap2/powerdomains34xx.h	2008-04-10 08:4=
1:54.000000000 -0600
> @@ -0,0 +1,296 @@
> +/*
> + * OMAP34XX powerdomain definitions
> + *
> + * Copyright (C) 2007-8 Texas Instruments, Inc.
> + * Copyright (C) 2007-8 Nokia Corporation
> + *
> + * Written by Paul Walmsley
> + * Debugging and integration fixes by Jouni H=F6gander
> + *
> + * This program is free software; you can redistribute it and/or mod=
ify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#ifndef ARCH_ARM_MACH_OMAP2_POWERDOMAINS34XX
> +#define ARCH_ARM_MACH_OMAP2_POWERDOMAINS34XX
> +
> +/*
> + * N.B. If powerdomains are added or removed from this file, update
> + * the array in mach-omap2/powerdomains.h.
> + */
> +
> +#include <asm/arch/powerdomain.h>
> +
> +#include "prcm-common.h"
> +#include "prm.h"
> +#include "prm-regbits-34xx.h"
> +#include "cm.h"
> +#include "cm-regbits-34xx.h"
> +
> +/* Forward declarations - so powerdomain dependencies can be encoded=
 */
> +
> +#ifdef CONFIG_ARCH_OMAP34XX
> +static struct powerdomain mpu_34xx_pwrdm;
> +static struct powerdomain core_34xx_pwrdm;
> +static struct powerdomain dss_pwrdm;
> +static struct powerdomain sgx_pwrdm;
> +static struct powerdomain cam_pwrdm;
> +static struct powerdomain per_pwrdm;
> +static struct powerdomain emu_pwrdm;
> +static struct powerdomain neon_pwrdm;
> +static struct powerdomain usbhost_pwrdm;
> +
> +static struct pwrdm_dep cam_gfx_sleepdeps[];
> +#endif
> +
> +
> +/*
> + * 34XX-specific powerdomains, dependencies
> + */
> +
> +#ifdef CONFIG_ARCH_OMAP34XX
> +
> +/*
> + * 3430: PM_WKDEP_{PER,USBHOST}: CORE, IVA2, MPU, WKUP
> + * (USBHOST is ES2 only)
> + */
> +static struct pwrdm_dep per_usbhost_wkdeps[] =3D {
> +	{ .pwrdm =3D &core_34xx_pwrdm,	.omap_chip =3D CHIP_IS_OMAP3430 },
> +	{ .pwrdm =3D &iva2_pwrdm,		.omap_chip =3D CHIP_IS_OMAP3430 },
> +	{ .pwrdm =3D &mpu_34xx_pwrdm,	.omap_chip =3D CHIP_IS_OMAP3430 },
> +	{ .pwrdm =3D &wkup_pwrdm,		.omap_chip =3D CHIP_IS_OMAP3430 },
> +	{ NULL },
> +};
> +
> +/*
> + * 3430 PM_WKDEP_MPU: CORE, IVA2, DSS, PER
> + */
> +static struct pwrdm_dep mpu_34xx_wkdeps[] =3D {
> +	{ .pwrdm =3D &core_34xx_pwrdm,	.omap_chip =3D CHIP_IS_OMAP3430 },
> +	{ .pwrdm =3D &iva2_pwrdm,		.omap_chip =3D CHIP_IS_OMAP3430 },
> +	{ .pwrdm =3D &dss_pwrdm,		.omap_chip =3D CHIP_IS_OMAP3430 },
> +	{ .pwrdm =3D &per_pwrdm,		.omap_chip =3D CHIP_IS_OMAP3430 },
> +	{ NULL },
> +};
> +
> +/*
> + * 3430 PM_WKDEP_IVA2: CORE, MPU, WKUP, DSS, PER
> + */
> +static struct pwrdm_dep iva2_wkdeps[] =3D {
> +	{ .pwrdm =3D &core_34xx_pwrdm,	.omap_chip =3D CHIP_IS_OMAP3430 },
> +	{ .pwrdm =3D &mpu_34xx_pwrdm,	.omap_chip =3D CHIP_IS_OMAP3430 },
> +	{ .pwrdm =3D &wkup_pwrdm,		.omap_chip =3D CHIP_IS_OMAP3430 },
> +	{ .pwrdm =3D &dss_pwrdm,		.omap_chip =3D CHIP_IS_OMAP3430 },
> +	{ .pwrdm =3D &per_pwrdm,		.omap_chip =3D CHIP_IS_OMAP3430 },
> +	{ NULL },
> +};
> +
> +
> +/* 3430 PM_WKDEP_{CAM,DSS}: IVA2, MPU, WKUP */
> +static struct pwrdm_dep cam_dss_wkdeps[] =3D {
> +	{ .pwrdm =3D &iva2_pwrdm,		.omap_chip =3D CHIP_IS_OMAP3430 },
> +	{ .pwrdm =3D &mpu_34xx_pwrdm,	.omap_chip =3D CHIP_IS_OMAP3430 },
> +	{ .pwrdm =3D &wkup_pwrdm,		.omap_chip =3D CHIP_IS_OMAP3430 },
> +	{ NULL },
> +};
> +
> +/* 3430: PM_WKDEP_NEON: MPU */
> +static struct pwrdm_dep neon_wkdeps[] =3D {
> +	{ .pwrdm =3D &mpu_34xx_pwrdm,	.omap_chip =3D CHIP_IS_OMAP3430 },
> +	{ NULL },
> +};
> +
> +
> +/* Sleep dependency source arrays - 34XX only */
> +
> +/*
> + * 3430: CM_SLEEPDEP_CAM: MPU
> + * 3430ES1: CM_SLEEPDEP_GFX: MPU
> + * 3430ES2: CM_SLEEPDEP_SGX: MPU
> + */
> +static struct pwrdm_dep cam_gfx_sleepdeps[] =3D {
> +	{ .pwrdm =3D &mpu_34xx_pwrdm,	.omap_chip =3D CHIP_IS_OMAP3430 },
> +	{ NULL },
> +};
> +
> +/*
> + * 3430: CM_SLEEPDEP_{DSS,PER}: MPU, IVA
> + * 3430ES2: CM_SLEEPDEP_USBHOST: MPU, IVA
> + */
> +static struct pwrdm_dep dss_per_usbhost_sleepdeps[] =3D {
> +	{ .pwrdm =3D &mpu_34xx_pwrdm,	.omap_chip =3D CHIP_IS_OMAP3430 },
> +	{ NULL },
> +};
> +
> +
> +/*
> + * Powerdomains
> + */
> +
> +static struct powerdomain iva2_pwrdm =3D {
> +	.name		  =3D "iva2_pwrdm",
> +	.prcm_offs	  =3D OMAP3430_IVA2_MOD,
> +	.omap_chip	  =3D CHIP_IS_OMAP3430,
> +	.dep_bit	  =3D OMAP3430_PM_WKDEP_MPU_EN_IVA2_SHIFT,
> +	.wkdep_srcs	  =3D iva2_wkdeps,
> +	.pwrsts		  =3D PWRSTS_OFF_RET_ON,
> +	.pwrsts_logic_ret =3D PWRSTS_OFF_RET,
> +	.banks		  =3D 4,
> +	.pwrsts_mem_ret	  =3D {
> +		[0] =3D PWRSTS_OFF_RET,
> +		[1] =3D PWRSTS_OFF_RET,
> +		[2] =3D PWRSTS_OFF_RET,
> +		[3] =3D PWRSTS_OFF_RET,
> +	},
> +	.pwrsts_mem_on	  =3D {
> +		[0] =3D PWRDM_POWER_ON,
> +		[1] =3D PWRDM_POWER_ON,
> +		[2] =3D PWRSTS_OFF_ON,
> +		[3] =3D PWRDM_POWER_ON,
> +	},
> +};
> +
> +static struct powerdomain mpu_34xx_pwrdm =3D {
> +	.name		  =3D "mpu_pwrdm",
> +	.prcm_offs	  =3D MPU_MOD,
> +	.omap_chip	  =3D CHIP_IS_OMAP3430,
> +	.dep_bit	  =3D OMAP3430_EN_MPU_SHIFT,
> +	.wkdep_srcs	  =3D mpu_34xx_wkdeps,
> +	.pwrsts		  =3D PWRSTS_OFF_RET_ON,
> +	.pwrsts_logic_ret =3D PWRSTS_OFF_RET,
> +	.banks		  =3D 1,
> +	.pwrsts_mem_ret	  =3D {
> +		[0] =3D PWRSTS_OFF_RET,
> +	},
> +	.pwrsts_mem_on	  =3D {
> +		[0] =3D PWRSTS_OFF_ON,
> +	},
> +};
> +
> +/* No wkdeps or sleepdeps for 34xx core apparently */
> +static struct powerdomain core_34xx_pwrdm =3D {
> +	.name		  =3D "core_pwrdm",
> +	.prcm_offs	  =3D CORE_MOD,
> +	.omap_chip	  =3D CHIP_IS_OMAP3430,
> +	.pwrsts		  =3D PWRSTS_OFF_RET_ON,
> +	.dep_bit	  =3D OMAP3430_EN_CORE_SHIFT,
> +	.banks		  =3D 2,
> +	.pwrsts_mem_ret	  =3D {
> +		[0] =3D PWRSTS_OFF_RET,	 /* MEM1RETSTATE */
> +		[1] =3D PWRSTS_OFF_RET,	 /* MEM2RETSTATE */
> +	},
> +	.pwrsts_mem_on	  =3D {
> +		[0] =3D PWRSTS_OFF_RET_ON, /* MEM1ONSTATE */
> +		[1] =3D PWRSTS_OFF_RET_ON, /* MEM2ONSTATE */
> +	},
> +};
> +
> +/* Another case of bit name collisions between several registers: EN=
_DSS */
> +static struct powerdomain dss_pwrdm =3D {
> +	.name		  =3D "dss_pwrdm",
> +	.omap_chip	  =3D CHIP_IS_OMAP3430,
> +	.prcm_offs	  =3D OMAP3430_DSS_MOD,
> +	.dep_bit	  =3D OMAP3430_PM_WKDEP_MPU_EN_DSS_SHIFT,
> +	.wkdep_srcs	  =3D cam_dss_wkdeps,
> +	.sleepdep_srcs	  =3D dss_per_usbhost_sleepdeps,
> +	.pwrsts		  =3D PWRSTS_OFF_RET_ON,
> +	.pwrsts_logic_ret =3D PWRDM_POWER_RET,
> +	.banks		  =3D 1,
> +	.pwrsts_mem_ret	  =3D {
> +		[0] =3D PWRDM_POWER_RET, /* MEMRETSTATE */
> +	},
> +	.pwrsts_mem_on	  =3D {
> +		[0] =3D PWRDM_POWER_ON,  /* MEMONSTATE */
> +	},
> +};
> +
> +static struct powerdomain sgx_pwrdm =3D {
> +	.name		  =3D "sgx_pwrdm",
> +	.prcm_offs	  =3D OMAP3430ES2_SGX_MOD,
> +	.omap_chip	  =3D CHIP_IS_OMAP3430ES2,
> +	.wkdep_srcs	  =3D gfx_sgx_wkdeps,
> +	.sleepdep_srcs	  =3D cam_gfx_sleepdeps,
> +	/* XXX This is accurate for 3430 SGX, but what about GFX? */
> +	.pwrsts		  =3D PWRSTS_OFF_RET_ON,
> +	.pwrsts_logic_ret =3D PWRDM_POWER_RET,
> +	.banks		  =3D 1,
> +	.pwrsts_mem_ret	  =3D {
> +		[0] =3D PWRDM_POWER_RET, /* MEMRETSTATE */
> +	},
> +	.pwrsts_mem_on	  =3D {
> +		[0] =3D PWRDM_POWER_ON,  /* MEMONSTATE */
> +	},
> +};
> +
> +static struct powerdomain cam_pwrdm =3D {
> +	.name		  =3D "cam_pwrdm",
> +	.omap_chip	  =3D CHIP_IS_OMAP3430,
> +	.prcm_offs	  =3D OMAP3430_CAM_MOD,
> +	.wkdep_srcs	  =3D cam_dss_wkdeps,
> +	.sleepdep_srcs	  =3D cam_gfx_sleepdeps,
> +	.pwrsts		  =3D PWRSTS_OFF_RET_ON,
> +	.pwrsts_logic_ret =3D PWRDM_POWER_RET,
> +	.banks		  =3D 1,
> +	.pwrsts_mem_ret	  =3D {
> +		[0] =3D PWRDM_POWER_RET, /* MEMRETSTATE */
> +	},
> +	.pwrsts_mem_on	  =3D {
> +		[0] =3D PWRDM_POWER_ON,  /* MEMONSTATE */
> +	},
> +};
> +
> +static struct powerdomain per_pwrdm =3D {
> +	.name		  =3D "per_pwrdm",
> +	.prcm_offs	  =3D OMAP3430_PER_MOD,
> +	.omap_chip	  =3D CHIP_IS_OMAP3430,
> +	.dep_bit	  =3D OMAP3430_EN_PER_SHIFT,
> +	.wkdep_srcs	  =3D per_usbhost_wkdeps,
> +	.sleepdep_srcs	  =3D dss_per_usbhost_sleepdeps,
> +	.pwrsts		  =3D PWRSTS_OFF_RET_ON,
> +	.pwrsts_logic_ret =3D PWRSTS_OFF_RET,
> +	.banks		  =3D 1,
> +	.pwrsts_mem_ret	  =3D {
> +		[0] =3D PWRDM_POWER_RET, /* MEMRETSTATE */
> +	},
> +	.pwrsts_mem_on	  =3D {
> +		[0] =3D PWRDM_POWER_ON,  /* MEMONSTATE */
> +	},
> +};
> +
> +static struct powerdomain emu_pwrdm =3D {
> +	.name		=3D "emu_pwrdm",
> +	.prcm_offs	=3D OMAP3430_EMU_MOD,
> +	.omap_chip	=3D CHIP_IS_OMAP3430,
> +};
> +
> +static struct powerdomain neon_pwrdm =3D {
> +	.name		  =3D "neon_pwrdm",
> +	.prcm_offs	  =3D OMAP3430_NEON_MOD,
> +	.omap_chip	  =3D CHIP_IS_OMAP3430,
> +	.wkdep_srcs	  =3D neon_wkdeps,
> +	.pwrsts		  =3D PWRSTS_OFF_RET_ON,
> +	.pwrsts_logic_ret =3D PWRDM_POWER_RET,
> +};
> +
> +static struct powerdomain usbhost_pwrdm =3D {
> +	.name		  =3D "usbhost_pwrdm",
> +	.prcm_offs	  =3D OMAP3430ES2_USBHOST_MOD,
> +	.omap_chip	  =3D CHIP_IS_OMAP3430ES2,
> +	.wkdep_srcs	  =3D per_usbhost_wkdeps,
> +	.sleepdep_srcs	  =3D dss_per_usbhost_sleepdeps,
> +	.pwrsts		  =3D PWRSTS_OFF_RET_ON,
> +	.pwrsts_logic_ret =3D PWRDM_POWER_RET,
> +	.banks		  =3D 1,
> +	.pwrsts_mem_ret	  =3D {
> +		[0] =3D PWRDM_POWER_RET, /* MEMRETSTATE */
> +	},
> +	.pwrsts_mem_on	  =3D {
> +		[0] =3D PWRDM_POWER_ON,  /* MEMONSTATE */
> +	},
> +};
> +
> +#endif    /* CONFIG_ARCH_OMAP34XX */
> +
> +
> +#endif
> Index: linux-omap/arch/arm/mach-omap2/prcm-common.h
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-omap.orig/arch/arm/mach-omap2/prcm-common.h	2008-04-10 08:3=
5:24.000000000 -0600
> +++ linux-omap/arch/arm/mach-omap2/prcm-common.h	2008-04-10 08:41:54.=
000000000 -0600
> @@ -311,7 +311,8 @@
>  #define OMAP3430_ST_GPT2				(1 << 3)
> =20
>  /* CM_SLEEPDEP_PER, PM_WKDEP_IVA2, PM_WKDEP_MPU, PM_WKDEP_PER shared=
 bits */
> -#define OMAP3430_EN_CORE				(1 << 0)
> +#define OMAP3430_EN_CORE_SHIFT				0
> +#define OMAP3430_EN_CORE_MASK				(1 << 0)
> =20
>  #endif
> =20
> Index: linux-omap/arch/arm/mach-omap2/prm-regbits-34xx.h
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-omap.orig/arch/arm/mach-omap2/prm-regbits-34xx.h	2008-04-10=
 08:35:24.000000000 -0600
> +++ linux-omap/arch/arm/mach-omap2/prm-regbits-34xx.h	2008-04-10 08:4=
1:54.000000000 -0600
> @@ -68,7 +68,8 @@
>  #define OMAP3430_VPINIDLE				(1 << 0)
> =20
>  /* PM_WKDEP_IVA2, PM_WKDEP_MPU shared bits */
> -#define OMAP3430_EN_PER					(1 << 7)
> +#define OMAP3430_EN_PER_SHIFT				7
> +#define OMAP3430_EN_PER_MASK				(1 << 7)
> =20
>  /* PM_PWSTCTRL_IVA2, PM_PWSTCTRL_MPU, PM_PWSTCTRL_CORE shared bits *=
/
>  #define OMAP3430_MEMORYCHANGE				(1 << 3)
> @@ -77,7 +78,7 @@
>  #define OMAP3430_LOGICSTATEST				(1 << 2)
> =20
>  /* PM_PREPWSTST_IVA2, PM_PREPWSTST_CORE shared bits */
> -#define OMAP3430_LASTLOGICSTATEENTERED				(1 << 2)
> +#define OMAP3430_LASTLOGICSTATEENTERED			(1 << 2)
> =20
>  /*
>   * PM_PREPWSTST_IVA2, PM_PREPWSTST_MPU, PM_PREPWSTST_CORE,
> @@ -278,8 +279,10 @@
>  #define OMAP3430_EMULATION_MPU_RST			(1 << 11)
> =20
>  /* PM_WKDEP_MPU specific bits */
> -#define OMAP3430_PM_WKDEP_MPU_EN_DSS			(1 << 5)
> -#define OMAP3430_PM_WKDEP_MPU_EN_IVA2			(1 << 2)
> +#define OMAP3430_PM_WKDEP_MPU_EN_DSS_SHIFT		5
> +#define OMAP3430_PM_WKDEP_MPU_EN_DSS_MASK		(1 << 5)
> +#define OMAP3430_PM_WKDEP_MPU_EN_IVA2_SHIFT		2
> +#define OMAP3430_PM_WKDEP_MPU_EN_IVA2_MASK		(1 << 2)
> =20
>  /* PM_EVGENCTRL_MPU */
>  #define OMAP3430_OFFLOADMODE_SHIFT			3
>=20
> --=20
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
