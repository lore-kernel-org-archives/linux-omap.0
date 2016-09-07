From: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [RESEND PATCH v4 3/3] Input: Add tps65217 power button driver
Date: Wed, 7 Sep 2016 09:54:45 -0700
Message-ID: <20160907165445.GB6445@dtor-ws>
References: <20160902103526.5050-1-m.niestroj@grinn-global.com>
 <20160902103526.5050-4-m.niestroj@grinn-global.com>
 <20160903175321.GC32345@dtor-ws>
 <e24c9dc1-0e7a-0cc1-8f25-521034f09bc8@grinn-global.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <e24c9dc1-0e7a-0cc1-8f25-521034f09bc8-z3quKL4iOrmQ6ZAhV5LmOA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Marcin Niestroj <m.niestroj-z3quKL4iOrmQ6ZAhV5LmOA@public.gmane.org>
Cc: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Wed, Sep 07, 2016 at 01:42:41PM +0200, Marcin Niestroj wrote:
> On 03.09.2016 19:53, Dmitry Torokhov wrote:
> >On Fri, Sep 02, 2016 at 12:35:26PM +0200, Marcin Niestroj wrote:
> >>This driver enables us to use tps65217's power button as KEY_POWER on
> >>am335x boards (directly connected button in chiliboard, accessible pin
> >>via expansion header in beaglebone). This patch has been tested with
> >>chiliboard.
> >>
> >>Signed-off-by: Marcin Niestroj <m.niestroj-z3quKL4iOrmQ6ZAhV5LmOA@public.gmane.org>
> >>Acked-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> >
> >Was it produces by soing s/65218/65217 over
> >drivers/input/misc/tps65217-pwrbutton.c? I honestly can't see much
> >difference between the 2. Can they be probably be combined?
> 
> I didn't think of that earlier. Below is a patch that adds support for
> tps65217 power button in tps65218-pwrbutton.c. Is this approach ok for
> you? If yes, I will send new patch version with it.
> 
> Additionally I guess the file should be renamed to tps6521x-pwrbutton.c
> and config option changed to CONFIG_INPUT_TPS6521X_PWRBUTTON?

We could but I do not think it is that important.

> 
> diff --git a/drivers/input/misc/tps65218-pwrbutton.c
> b/drivers/input/misc/tps65218-pwrbutton.c
> index a39b626..19d2bb1 100644
> --- a/drivers/input/misc/tps65218-pwrbutton.c
> +++ b/drivers/input/misc/tps65218-pwrbutton.c
> @@ -1,8 +1,9 @@
>  /*
> - * Texas Instruments' TPS65218 Power Button Input Driver
> + * Texas Instruments' TPS65217 and TPS65218 Power Button Input Driver
>   *
>   * Copyright (C) 2014 Texas Instruments Incorporated - http://www.ti.com/
>   * Author: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
> + * Author: Marcin Niestroj <m.niestroj-z3quKL4iOrmQ6ZAhV5LmOA@public.gmane.org>
>   *
>   * This program is free software; you can redistribute it and/or modify
>   * it under the terms of the GNU General Public License version 2 as
> @@ -18,31 +19,73 @@
>  #include <linux/input.h>
>  #include <linux/interrupt.h>
>  #include <linux/kernel.h>
> +#include <linux/mfd/tps65217.h>
>  #include <linux/mfd/tps65218.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
>  #include <linux/platform_device.h>
>  #include <linux/slab.h>
> 
> -struct tps65218_pwrbutton {
> +struct tps6521x_data {
> +	unsigned int reg_status;
> +	unsigned int pb_mask;
> +	const char *name;
> +};
> +
> +static const struct tps6521x_data tps65217_data = {
> +	.reg_status = TPS65217_REG_STATUS,
> +	.pb_mask = TPS65217_STATUS_PB,
> +	.name = "tps65217_pwrbutton",
> +};
> +
> +static const struct tps6521x_data tps65218_data = {
> +	.reg_status = TPS65218_REG_STATUS,
> +	.pb_mask = TPS65218_STATUS_PB_STATE,
> +	.name = "tps65218_pwrbutton",
> +};
> +
> +struct tps6521x_pwrbutton {
>  	struct device *dev;
> -	struct tps65218 *tps;
> +	void *tps;
>  	struct input_dev *idev;
> +	const struct tps6521x_data *data;
> +	char phys[32];
>  };
> 
> -static irqreturn_t tps65218_pwr_irq(int irq, void *_pwr)
> +static const struct of_device_id of_tps6521x_pwr_match[] = {
> +	{ .compatible = "ti,tps65217-pwrbutton", .data = &tps65217_data },
> +	{ .compatible = "ti,tps65218-pwrbutton", .data = &tps65218_data },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(of, of_tps6521x_pwr_match);
> +
> +static int tps6521x_reg_read(struct tps6521x_pwrbutton *pwr,
> unsigned int reg,
> +		unsigned int *val)
>  {
> -	struct tps65218_pwrbutton *pwr = _pwr;
> +	if (pwr->data == &tps65217_data)
> +		return tps65217_reg_read((struct tps65217 *) pwr->tps,
> +					reg, val);
> +	else if (pwr->data == &tps65218_data)
> +		return tps65218_reg_read((struct tps65218 *) pwr->tps,
> +					reg, val);

This is step in right direction, but not quite there yet. You could add
the reg_read pointer to your tps6521x_data and avoid doing if/else/case,
or, maybe better yet, have registers accessible via regmap.

Thanks.

-- 
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
