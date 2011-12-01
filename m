From: Kevin Hilman <khilman@ti.com>
Subject: Re: [RFC PATCH 03/11] arm:omap:am33xx: Add power domain data
Date: Wed, 30 Nov 2011 17:04:19 -0800
Message-ID: <878vmxump8.fsf@ti.com>
References: <1321809555-13833-1-git-send-email-hvaibhav@ti.com>
	<1321809555-13833-4-git-send-email-hvaibhav@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog118.obsmtp.com ([74.125.149.244]:40404 "EHLO
	na3sys009aog118.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753833Ab1LABE1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 30 Nov 2011 20:04:27 -0500
Received: by mail-yx0-f172.google.com with SMTP id l9so278448yen.31
        for <linux-omap@vger.kernel.org>; Wed, 30 Nov 2011 17:04:26 -0800 (PST)
In-Reply-To: <1321809555-13833-4-git-send-email-hvaibhav@ti.com> (Vaibhav
	Hiremath's message of "Sun, 20 Nov 2011 22:49:07 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vaibhav Hiremath <hvaibhav@ti.com>
Cc: linux-omap@vger.kernel.org, tony@atomide.com, paul@pwsan.com, linux-arm-kernel@lists.infradead.org, b-cousson@ti.com, Afzal Mohammed <afzal@ti.com>, Rachna Patil <rachna@ti.com>

Vaibhav Hiremath <hvaibhav@ti.com> writes:

> From: Afzal Mohammed <afzal@ti.com>
>
> This patch adds AM33XX power domain data,
> corresponding API's to access PRM module and
> PRM register offsets & bit fields.
>
> Signed-off-by: Rachna Patil <rachna@ti.com>
> Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
> Signed-off-by: Afzal Mohammed <afzal@ti.com>

First some general comments:

At first glance, it seems like there could be much more reuse with OMAP4
code here.  From what I see, AM33x has only one partition compared to
several on OMAP4, but that doesn't mean you couldn't reuse the OMAP4
functions and just use a single partition.

IOW, it seems to me that all the pwrdm_ops could be shared with OMAP4.

>From what I read (after an admittedly quick glance), the main thing you
need is a way to override the PRM offsets due to the fact that some
crazy person decided to make each instance different.

If you modified the OMAP4 base so that the _prminst_read_inst_reg()
could be customized, wouldn't that work for AM33xx?

> ---
>  arch/arm/mach-omap2/powerdomain.h           |    4 +-
>  arch/arm/mach-omap2/powerdomain33xx.c       |  155 ++++++++++++
>  arch/arm/mach-omap2/powerdomains33xx_data.c |  115 +++++++++
>  arch/arm/mach-omap2/prm-regbits-33xx.h      |  357 +++++++++++++++++++++++++++
>  arch/arm/mach-omap2/prm33xx.h               |  123 +++++++++
>  arch/arm/mach-omap2/prminst33xx.c           |   74 ++++++
>  arch/arm/mach-omap2/prminst33xx.h           |   25 ++
>  7 files changed, 852 insertions(+), 1 deletions(-)
>  create mode 100644 arch/arm/mach-omap2/powerdomain33xx.c
>  create mode 100644 arch/arm/mach-omap2/powerdomains33xx_data.c
>  create mode 100644 arch/arm/mach-omap2/prm-regbits-33xx.h
>  create mode 100644 arch/arm/mach-omap2/prm33xx.h
>  create mode 100644 arch/arm/mach-omap2/prminst33xx.c
>  create mode 100644 arch/arm/mach-omap2/prminst33xx.h
>
> diff --git a/arch/arm/mach-omap2/powerdomain.h b/arch/arm/mach-omap2/powerdomain.h
> index 0d72a8a..9efa823 100644
> --- a/arch/arm/mach-omap2/powerdomain.h
> +++ b/arch/arm/mach-omap2/powerdomain.h
> @@ -69,7 +69,7 @@
>   * Maximum number of clockdomains that can be associated with a powerdomain.
>   * CORE powerdomain on OMAP4 is the worst case
>   */
> -#define PWRDM_MAX_CLKDMS	9
> +#define PWRDM_MAX_CLKDMS	11

Comment before this needs update  as well.

>  /* XXX A completely arbitrary number. What is reasonable here? */
>  #define PWRDM_TRANSITION_BAILOUT 100000
> @@ -223,10 +223,12 @@ bool pwrdm_can_ever_lose_context(struct powerdomain *pwrdm);
>  extern void omap242x_powerdomains_init(void);
>  extern void omap243x_powerdomains_init(void);
>  extern void omap3xxx_powerdomains_init(void);
> +extern void am33xx_powerdomains_init(void);
>  extern void omap44xx_powerdomains_init(void);
>
>  extern struct pwrdm_ops omap2_pwrdm_operations;
>  extern struct pwrdm_ops omap3_pwrdm_operations;
> +extern struct pwrdm_ops am33xx_pwrdm_operations;
>  extern struct pwrdm_ops omap4_pwrdm_operations;
>
>  /* Common Internal functions used across OMAP rev's */

[...]

> diff --git a/arch/arm/mach-omap2/prm33xx.h b/arch/arm/mach-omap2/prm33xx.h
> new file mode 100644
> index 0000000..0fd5c6e
> --- /dev/null
> +++ b/arch/arm/mach-omap2/prm33xx.h
> @@ -0,0 +1,123 @@
> +/*
> + * AM33XX PRM instance offset macros
> + *
> + * Copyright (C) 2011 Texas Instruments Incorporated - http://www.ti.com/
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License as
> + * published by the Free Software Foundation version 2.
> + *
> + * This program is distributed "as is" WITHOUT ANY WARRANTY of any
> + * kind, whether express or implied; without even the implied warranty
> + * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +#ifndef __ARCH_ARM_MACH_OMAP2_PRM33XX_H
> +#define __ARCH_ARM_MACH_OMAP2_PRM33XX_H
> +
> +#include "prcm-common.h"
> +#include "prm.h"
> +
> +#define AM33XX_PRM_BASE               0x44E00000
> +
> +#define AM33XX_PRM_REGADDR(inst, reg)                         \
> +	AM33XX_L4_WK_IO_ADDRESS(AM33XX_PRM_BASE + (inst) + (reg))
> +
> +
> +/* PRM instances */
> +#define AM33XX_PRM_OCP_SOCKET_MOD	0x0B00
> +#define AM33XX_PRM_PER_MOD		0x0C00
> +#define AM33XX_PRM_WKUP_MOD		0x0D00
> +#define AM33XX_PRM_MPU_MOD		0x0E00
> +#define AM33XX_PRM_DEVICE_MOD		0x0F00
> +#define AM33XX_PRM_RTC_MOD		0x1000
> +#define AM33XX_PRM_GFX_MOD		0x1100
> +#define AM33XX_PRM_CEFUSE_MOD		0x1200
> +
> +/* Register offsets (used from OMAP4) */

Probably could just include prm44xx.h and use OMAP4_PM_... instead.

> +#define AM33XX_PM_PWSTCTRL		0x0000
> +#define AM33XX_PM_PWSTST		0x0004

However, since thes are just dummy offsets into a "fixup" table anyways,
maybe it's best to use use 0 and 1 here and have a comment here to that
effect.   Otherwise, it's a bit confusing since one would assume these
are actual register offsets.

[...]

> diff --git a/arch/arm/mach-omap2/prminst33xx.c b/arch/arm/mach-omap2/prminst33xx.c
> new file mode 100644
> index 0000000..88382ba
> --- /dev/null
> +++ b/arch/arm/mach-omap2/prminst33xx.c
> @@ -0,0 +1,74 @@
> +/*
> + * AM33XX PRM instance functions
> + *
> + * Copyright (C) 2011 Texas Instruments Incorporated - http://www.ti.com/
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License as
> + * published by the Free Software Foundation version 2.
> + *
> + * This program is distributed "as is" WITHOUT ANY WARRANTY of any
> + * kind, whether express or implied; without even the implied warranty
> + * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
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
> +#include "prm33xx.h"
> +#include "prminst33xx.h"
> +#include "prm-regbits-33xx.h"
> +
> +#define AM33XX_PRM_MOD_SIZE	0x100
> +#define AM33XX_PRM_MOD_START	AM33XX_PRM_PER_MOD
> +#define PRM_REG_SZ		0x4
> +
> +/*
> + * PRM Offsets are screwed up, and they are not consistent across modules.
> + * Below are the offsets for PWRSTCTRL and PWRSTST for respective modules.
> + */
> +static u16 off_fixup[][2] = {
> +	{ 0xC, 0x8 },	/* AM33XX_PRM_PER_MOD */
> +	{ 0x4, 0x8 },	/* AM33XX_PRM_WKUP_MOD */
> +	{ 0x0, 0x4 },	/* AM33XX_PRM_MPU_MOD */
> +	/* XXX: PRM_DEVICE: offsets are invalid for powerdomain*/
> +	{ 0x0, 0x0 },	/* AM33XX_PRM_DEVICE_MOD */
> +	{ 0x0, 0x4 },	/* AM33XX_PRM_RTC_MOD */
> +	{ 0x0, 0x10 },	/* AM33XX_PRM_GFX_MOD */
> +	{ 0x0, 0x4 },	/* AM33XX_PRM_CEFUSE_MOD */
> +};

Please use the #define values from prm-regbits...h

[...]

Kevin
