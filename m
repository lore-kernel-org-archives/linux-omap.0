From: Milo Kim <milo.kim-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 4/6] regulator: lp872x: Add enable GPIO pin support
Date: Mon, 28 Dec 2015 09:34:38 +0900
Message-ID: <5680839E.4080800@ti.com>
References: <1450868319-20513-1-git-send-email-contact@paulk.fr>
 <1450868319-20513-5-git-send-email-contact@paulk.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1450868319-20513-5-git-send-email-contact-W9ppeneeCTY@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Paul Kocialkowski <contact-W9ppeneeCTY@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, =?UTF-8?Q?Beno=c3=aet_Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi Paul,

Thanks for the patches. Please see my comments below.

On 23/12/15 19:58, Paul Kocialkowski wrote:
> LP872x regulators are made active via the EN pin, which might be hooked to a
> GPIO. This adds support for driving the GPIO high when the driver is in use.

EN pin is used for enabling HW logic like I2C block. It's not regulator 
enable pin. Please check the block diagram in the datasheet.

All regulators of LP8720 and LP8725 are controlled through I2C 
registers. Additionally, LP8725 provides external pin control for LDO3 
and BUCK2. In this case, you can use 'regulator_config.ena_gpio' when a 
regulator is registered.

>
> Signed-off-by: Paul Kocialkowski <contact-W9ppeneeCTY@public.gmane.org>
> ---
>   .../devicetree/bindings/regulator/lp872x.txt       |  1 +
>   drivers/regulator/lp872x.c                         | 33 ++++++++++++++++++++--
>   include/linux/regulator/lp872x.h                   |  2 ++
>   3 files changed, 33 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/regulator/lp872x.txt b/Documentation/devicetree/bindings/regulator/lp872x.txt
> index 7818318..0559c25 100644
> --- a/Documentation/devicetree/bindings/regulator/lp872x.txt
> +++ b/Documentation/devicetree/bindings/regulator/lp872x.txt
> @@ -28,6 +28,7 @@ Optional properties:
>     - ti,dvs-gpio: GPIO specifier for external DVS pin control of LP872x devices.
>     - ti,dvs-vsel: DVS selector. 0 = SEL_V1, 1 = SEL_V2.
>     - ti,dvs-state: initial DVS pin state. 0 = DVS_LOW, 1 = DVS_HIGH.
> +  - ti,enable-gpio: GPIO specifier for EN pin control of LP872x devices.

Please use general property, "enable-gpios" instead of "ti,enable-gpio".

>
>     Sub nodes for regulator_init_data
>       LP8720 has maximum 6 nodes. (child name: ldo1 ~ 5 and buck)
> diff --git a/drivers/regulator/lp872x.c b/drivers/regulator/lp872x.c
> index 21c49d8..c8855f3 100644
> --- a/drivers/regulator/lp872x.c
> +++ b/drivers/regulator/lp872x.c
> @@ -726,6 +726,27 @@ static struct regulator_desc lp8725_regulator_desc[] = {
>   	},
>   };
>
> +static int lp872x_init_enable(struct lp872x *lp)

lp872x_enable_hw() would be better.

> +{
> +	int ret, gpio;
> +
> +	if (!lp->pdata)
> +		return -EINVAL;
> +
> +	gpio = lp->pdata->enable_gpio;
> +	if (!gpio_is_valid(gpio))
> +		return 0;
> +
> +	/* Always set enable GPIO high. */
> +	ret = devm_gpio_request_one(lp->dev, gpio, GPIOF_OUT_INIT_HIGH, "LP872X EN");
> +	if (ret) {
> +		dev_err(lp->dev, "gpio request err: %d\n", ret);
> +		return ret;
> +	}

LP8720 device needs max 200usec for startup time.
LP8725 also requires enable time about 30ms.
Please use usleep_range() after EN pin control.

> +
> +	return 0;
> +}
> +
>   static int lp872x_init_dvs(struct lp872x *lp)
>   {
>   	int ret, gpio;
> @@ -763,14 +784,18 @@ static int lp872x_config(struct lp872x *lp)
>   	int ret;
>
>   	if (!pdata || !pdata->update_config)
> -		goto init_dvs;
> +		goto init_dvs_enable;
>
>   	ret = lp872x_write_byte(lp, LP872X_GENERAL_CFG, pdata->general_config);
>   	if (ret)
>   		return ret;
>
> -init_dvs:
> -	return lp872x_init_dvs(lp);
> +init_dvs_enable:
> +	ret = lp872x_init_dvs(lp);
> +	if (ret)
> +		return ret;
> +
> +	return lp872x_init_enable(lp);
>   }

Logic should be enabled prior to DVS configuration. And please call 
lp872x_enable_hw() in _probe().

>
>   static struct regulator_init_data
> @@ -875,6 +900,8 @@ static struct lp872x_platform_data
>   	of_property_read_u8(np, "ti,dvs-state", &dvs_state);
>   	pdata->dvs->init_state = dvs_state ? DVS_HIGH : DVS_LOW;
>
> +	pdata->enable_gpio = of_get_named_gpio(np, "ti,enable-gpio", 0);
> +

Please replace "ti,enable-gpio" with "enable-gpios".

Best regards,
Milo
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
