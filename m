From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 1/8] OMAP3: PM: Adding voltage driver support for OMAP3
Date: Wed, 23 Jun 2010 11:42:41 -0700
Message-ID: <877hlptwta.fsf@deeprootsystems.com>
References: <1275150748-15386-1-git-send-email-thara@ti.com>
	<1275150748-15386-2-git-send-email-thara@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.212.174]:50809 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753152Ab0FWSmr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 23 Jun 2010 14:42:47 -0400
Received: by pxi7 with SMTP id 7so395969pxi.19
        for <linux-omap@vger.kernel.org>; Wed, 23 Jun 2010 11:42:46 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Thara Gopinath <thara@ti.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, b-cousson@ti.com, vishwanath.bs@ti.com, sawant@ti.com

Thara Gopinath <thara@ti.com> writes:

> This patch adds voltage driver support for OMAP3. The driver
> allows  configuring the voltage controller and voltage
> processors during init and exports APIs to enable/disable
> voltage processors, scale voltage and reset voltage.
> The driver also maintains the global voltage table on a per
> VDD basis which contains the various voltages supported by the
> VDD along with per voltage dependent data like smartreflex
> n-target value, errminlimit and voltage processor errorgain.
> The driver allows scaling of VDD voltages either through
> "vc bypass method" or through "vp forceupdate method" the
> choice being configurable through the board file.
>
> This patch contains code originally in linux omap pm branch
> smartreflex driver.  Major contributors to this driver are
> Lesly A M, Rajendra Nayak, Kalle Jokiniemi, Paul Walmsley,
> Nishant Menon, Kevin Hilman.
>
> Signed-off-by: Thara Gopinath <thara@ti.com>

First some general comments:

I thought we had agreed that all the internal functions should not
need to take a VDD ID, but instead they could be just passed a
vdd_info pointer.

I would greatly improve readability to see all usage of
vdd_info[vdd_id] go away.

In the exported functions that take vdd_id as an argument, just do
something like

          struct omap_vdd_info *vdd = vdd_info[vdd_id];

at the beginning, then replace all the instances of vdd_info[vdd_id]
with 'vdd->'

In the rest of the internal functions, make them take the pointer as
the argument instead of the id.

Also, we have a bunch of stuff in the current pm-vc branch which allows
boards to override settings.  Are you planning to address that in this
series?  or is Lesly going to continue that work?

Some other comments below...

> ---
>  arch/arm/mach-omap2/Makefile  |    3 +-
>  arch/arm/mach-omap2/voltage.c | 1059 +++++++++++++++++++++++++++++++++++++++++
>  arch/arm/mach-omap2/voltage.h |  123 +++++
>  3 files changed, 1184 insertions(+), 1 deletions(-)
>  create mode 100644 arch/arm/mach-omap2/voltage.c
>  create mode 100644 arch/arm/mach-omap2/voltage.h
>
> diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
> index e975b43..e4c660d 100644
> --- a/arch/arm/mach-omap2/Makefile
> +++ b/arch/arm/mach-omap2/Makefile
> @@ -46,7 +46,8 @@ obj-$(CONFIG_ARCH_OMAP2)		+= sdrc2xxx.o
>  ifeq ($(CONFIG_PM),y)
>  obj-$(CONFIG_ARCH_OMAP2)		+= pm24xx.o
>  obj-$(CONFIG_ARCH_OMAP2)		+= sleep24xx.o
> -obj-$(CONFIG_ARCH_OMAP3)		+= pm34xx.o sleep34xx.o cpuidle34xx.o
> +obj-$(CONFIG_ARCH_OMAP3)		+= pm34xx.o sleep34xx.o cpuidle34xx.o \
> +					   voltage.o
>  obj-$(CONFIG_PM_DEBUG)			+= pm-debug.o
>  
>  AFLAGS_sleep24xx.o			:=-Wa,-march=armv6
> diff --git a/arch/arm/mach-omap2/voltage.c b/arch/arm/mach-omap2/voltage.c
> new file mode 100644
> index 0000000..657e322
> --- /dev/null
> +++ b/arch/arm/mach-omap2/voltage.c
> @@ -0,0 +1,1059 @@
> +/*
> + * OMAP3/OMAP4 Voltage Management Routines
> + *
> + * Author: Thara Gopinath	<thara@ti.com>
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
> +#include <linux/clk.h>
> +#include <linux/err.h>
> +
> +#include <plat/omap-pm.h>
> +#include <plat/omap34xx.h>
> +#include <plat/opp.h>
> +#include <plat/opp_twl_tps.h>
> +#include <plat/clock.h>
> +#include <plat/common.h>
> +
> +#include "prm-regbits-34xx.h"
> +#include "voltage.h"
> +
> +#define VP_IDLE_TIMEOUT		200
> +#define VP_TRANXDONE_TIMEOUT	300
> +
> +/* PRM voltage module */
> +u32 volt_mod;

should be static

> +/* Voltage processor register offsets */
> +struct vp_reg_offs {
> +	u8 vpconfig_reg;
> +	u8 vstepmin_reg;
> +	u8 vstepmax_reg;
> +	u8 vlimitto_reg;
> +	u8 status_reg;
> +	u8 voltage_reg;
> +};

Minor issue, but the _reg suffix is not really needed on all these
names.

[...]

> +
> +/* Generic voltage init functions */
> +static void __init init_voltageprocesor(int vp_id)

was mystified why I wasn't finding this function when grepping and
discovered there should be two 's's in processor in this function name.

[...]

> diff --git a/arch/arm/mach-omap2/voltage.h b/arch/arm/mach-omap2/voltage.h
[...]

For the naming, rather than the long names voltagecontroller,
voltageprocessor, I'd suggest just using vc and vp.  For the external
functions, they can have the omap_ prefix.

> +unsigned long omap_voltageprocessor_get_curr_volt(int vp_id);
> +void omap_voltageprocessor_enable(int vp_id);
> +void omap_voltageprocessor_disable(int vp_id);

these should be omap_vp_*

> +int omap_voltage_scale(int vdd, unsigned long target_volt);
> +void omap_reset_voltage(int vdd);

omap_voltage_reset()

> +int omap_get_voltage_table(int vdd, struct omap_volt_data **volt_data);

omap_voltage_get_table()

> +struct omap_volt_data *omap_get_volt_data(int vdd, unsigned long volt);

omap_voltage_get_data()

> +void omap_voltage_register_pmic(struct omap_volt_pmic_info *pmic_info);
> +unsigned long get_curr_voltage(int vdd);

omap_voltage_get()

> +#ifdef CONFIG_PM
> +void omap_voltage_init_vc(struct omap_volt_vc_data *setup_vc);
> +#else
> +static inline void omap_voltage_init_vc(struct omap_volt_vc_data *setup_vc) {}
> +#endif
> +
> +#endif
> -- 
> 1.7.0.rc1.33.g07cf0f

Kevin
