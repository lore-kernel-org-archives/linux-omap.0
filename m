From: Vishwanath Sripathy <vishwanath.bs@ti.com>
Subject: RE: [RFC 3/3] am35xx: pm: Hook-up with TPS65023
Date: Thu, 24 Feb 2011 15:34:44 +0530
Message-ID: <6356620acee7ee78af7da3906b0ea78a@mail.gmail.com>
References: <1298483913-20344-1-git-send-email-premi@ti.com> <1298483913-20344-4-git-send-email-premi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:36577 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932299Ab1BXKEs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 24 Feb 2011 05:04:48 -0500
Received: by mail-ey0-f172.google.com with SMTP id 13so136724eye.31
        for <linux-omap@vger.kernel.org>; Thu, 24 Feb 2011 02:04:46 -0800 (PST)
In-Reply-To: <1298483913-20344-4-git-send-email-premi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sanjeev Premi <premi@ti.com>, linux-omap@vger.kernel.org

Sanjeev,

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Sanjeev Premi
> Sent: Wednesday, February 23, 2011 11:29 PM
> To: linux-omap@vger.kernel.org
> Cc: Sanjeev Premi
> Subject: [RFC 3/3] am35xx: pm: Hook-up with TPS65023
>
> Add glue logic to hook-up AM35x processors
> with TPS65023.
It seems that you are not really using Voltage layer for any interaction
with TPS65023 as you are not using VP and VC. Then what is the purpose of
registering this PMIC with Voltage layer. I fail to understand the purpose
of this patch series.

Vishwa
>
> Signed-off-by: Sanjeev Premi <premi@ti.com>
> ---
>  arch/arm/mach-omap2/am3517_tps.c |   96
> ++++++++++++++++++++++++++++++++++++++
>  1 files changed, 96 insertions(+), 0 deletions(-)
>  create mode 100644 arch/arm/mach-omap2/am3517_tps.c
>
> diff --git a/arch/arm/mach-omap2/am3517_tps.c b/arch/arm/mach-
> omap2/am3517_tps.c
> new file mode 100644
> index 0000000..cddd7eb
> --- /dev/null
> +++ b/arch/arm/mach-omap2/am3517_tps.c
> @@ -0,0 +1,96 @@
> +/**
> + * Copyright (C) 2011 Texas Instruments Incorporated -
> http://www.ti.com/
> + *
> + * Based on omap_twl.c
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License as
> + * published by the Free Software Foundation version 2.
> + *
> + * This program is distributed "as is" WITHOUT ANY WARRANTY of any
> + * kind, whether express or implied; without even the implied warranty
> + * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
> See the
> + * GNU General Public License for more details.
> + */
> +
> +#include <linux/err.h>
> +#include <linux/io.h>
> +#include <linux/kernel.h>
> +#include <linux/i2c/twl.h>
> +
> +#include <plat/voltage.h>
> +
> +#include "pm.h"
> +
> +/*
> + * TODO: Copy of OMAP3 definitions to get thru compilation.
> + *       May not be needed in final implementation. Need to
> + *       relook at the the need again.
> + */
> +#define OMAP3_SRI2C_SLAVE_ADDR		0x12
> +#define OMAP3_VDD_MPU_SR_CONTROL_REG	0x00
> +#define OMAP3_VDD_CORE_SR_CONTROL_REG	0x01
> +#define OMAP3_VP_CONFIG_ERROROFFSET	0x00
> +#define OMAP3_VP_VSTEPMIN_VSTEPMIN	0x1
> +#define OMAP3_VP_VSTEPMAX_VSTEPMAX	0x04
> +#define OMAP3_VP_VLIMITTO_TIMEOUT_US	200
> +
> +#define OMAP3430_VP2_VLIMITTO_VDDMIN 0x18
> +#define OMAP3430_VP2_VLIMITTO_VDDMAX 0x2c
> +
> +/**
> + * TBD: Update the formula below.
> + *      Needs to be derived from a table.
> + */
> +static unsigned long tps65023_vsel_to_uv(const u8 vsel)
> +{
> +	return (((vsel * 250) + 6000)) * 100;
> +}
> +
> +/**
> + * TBD: Update the formula below.
> + *      Needs to be derived from a table.
> + */
> +static u8 tps65023_uv_to_vsel(unsigned long uv)
> +{
> +	return DIV_ROUND_UP(uv - 600000, 25000);
> +}
> +
> +/**
> + * TBD: Just a copy of OMAP3 PMIC info.
> + *      Many fields below don't make much sense for AM3517,
> + *      but keeping them as is for now.
> + */
> +static struct omap_volt_pmic_info am3517_volt_info = {
> +	.slew_rate		= 4000,
> +	.step_size		= 25000,
> +	.on_volt                = 1200000,
> +	.onlp_volt              = 1000000,
> +	.ret_volt               = 975000,
> +	.off_volt               = 600000,
> +	.volt_setup_time        = 0xfff,
> +	.vp_erroroffset		=
> OMAP3_VP_CONFIG_ERROROFFSET,
> +	.vp_vstepmin		= OMAP3_VP_VSTEPMIN_VSTEPMIN,
> +	.vp_vstepmax		= OMAP3_VP_VSTEPMAX_VSTEPMAX,
> +	.vp_vddmin		= OMAP3430_VP2_VLIMITTO_VDDMIN,
> +	.vp_vddmax		= OMAP3430_VP2_VLIMITTO_VDDMAX,
> +	.vp_timeout_us		=
> OMAP3_VP_VLIMITTO_TIMEOUT_US,
> +	.i2c_slave_addr		= OMAP3_SRI2C_SLAVE_ADDR,
> +	.pmic_reg		= OMAP3_VDD_CORE_SR_CONTROL_REG,
> +	.vsel_to_uv		= tps65023_vsel_to_uv,
> +	.uv_to_vsel		= tps65023_uv_to_vsel,
> +};
> +
> +int __init am3517_tps_init(void)
> +{
> +	struct voltagedomain *voltdm;
> +
> +	if (!cpu_is_omap3505() && !cpu_is_omap3517())
> +		return -ENODEV;
> +
> +	voltdm = omap_voltage_domain_lookup("mpu");
> +	omap_voltage_register_pmic(voltdm, &am3517_volt_info);
> +
> +	return 0;
> +}
> +
> --
> 1.7.2.2
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
