From: "Kim, Milo" <milo.kim-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v2 2/4] regulator: lp872x: Add enable GPIO pin support
Date: Fri, 12 Feb 2016 09:14:37 +0900
Message-ID: <56BD23ED.8010207@ti.com>
References: <1454697741-8687-1-git-send-email-contact@paulk.fr>
 <1454697741-8687-3-git-send-email-contact@paulk.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1454697741-8687-3-git-send-email-contact-W9ppeneeCTY@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Paul Kocialkowski <contact-W9ppeneeCTY@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, =?UTF-8?Q?Beno=c3=aet_Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Javier Martinez Canillas <javier-0uQlZySMnqxg9hUCZPvPmw@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi Paul,

Thanks for the patch. Please see my comments below.

On 2/6/2016 3:42 AM, Paul Kocialkowski wrote:
> LP872x regulators are made active via the EN pin, which might be hooked to a
> GPIO. This adds support for driving the GPIO high when the driver is in use.
>
> Signed-off-by: Paul Kocialkowski <contact-W9ppeneeCTY@public.gmane.org>
> ---
>   .../devicetree/bindings/regulator/lp872x.txt       |  1 +
>   drivers/regulator/lp872x.c                         | 34 ++++++++++++++++++++++
>   include/linux/regulator/lp872x.h                   |  5 ++++
>   3 files changed, 40 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/regulator/lp872x.txt b/Documentation/devicetree/bindings/regulator/lp872x.txt
> index 7818318..ca58a68 100644
> --- a/Documentation/devicetree/bindings/regulator/lp872x.txt
> +++ b/Documentation/devicetree/bindings/regulator/lp872x.txt
> @@ -28,6 +28,7 @@ Optional properties:
>     - ti,dvs-gpio: GPIO specifier for external DVS pin control of LP872x devices.
>     - ti,dvs-vsel: DVS selector. 0 = SEL_V1, 1 = SEL_V2.
>     - ti,dvs-state: initial DVS pin state. 0 = DVS_LOW, 1 = DVS_HIGH.
> +  - enable-gpios: GPIO specifier for EN pin control of LP872x devices.
>
>     Sub nodes for regulator_init_data
>       LP8720 has maximum 6 nodes. (child name: ldo1 ~ 5 and buck)
> diff --git a/drivers/regulator/lp872x.c b/drivers/regulator/lp872x.c
> index 21c49d8..3899211 100644
> --- a/drivers/regulator/lp872x.c
> +++ b/drivers/regulator/lp872x.c
> @@ -15,6 +15,7 @@
>   #include <linux/regmap.h>
>   #include <linux/err.h>
>   #include <linux/gpio.h>
> +#include <linux/delay.h>
>   #include <linux/regulator/lp872x.h>
>   #include <linux/regulator/driver.h>
>   #include <linux/platform_device.h>
> @@ -757,6 +758,33 @@ set_default_dvs_mode:
>   				default_dvs_mode[lp->chipid]);
>   }
>
> +static int lp872x_hw_enable(struct lp872x *lp)
> +{
> +	int ret, gpio;
> +
> +	if (!lp->pdata)
> +		return -EINVAL;
> +
> +	gpio = lp->pdata->enable_gpio;
> +	if (!gpio_is_valid(gpio))
> +		return 0;

It seems gpio is always 0 when it starts from DT. 'enable_gpio' is 
updated in lp872x_config() but lp872x_hw_enable() is called first.

> +
> +	/* Always set enable GPIO high. */
> +	ret = devm_gpio_request_one(lp->dev, gpio, GPIOF_OUT_INIT_HIGH, "LP872X EN");
> +	if (ret) {
> +		dev_err(lp->dev, "gpio request err: %d\n", ret);
> +		return ret;
> +	}
> +
> +	/* Each chip has a different enable delay. */
> +	if (lp->chipid == LP8720)
> +		usleep_range(LP8720_ENABLE_DELAY, 1.5 * LP8720_ENABLE_DELAY);
> +	else
> +		usleep_range(LP8725_ENABLE_DELAY, 1.5 * LP8725_ENABLE_DELAY);
> +
> +	return 0;
> +}
> +
>   static int lp872x_config(struct lp872x *lp)
>   {
>   	struct lp872x_platform_data *pdata = lp->pdata;
> @@ -875,6 +903,8 @@ static struct lp872x_platform_data
>   	of_property_read_u8(np, "ti,dvs-state", &dvs_state);
>   	pdata->dvs->init_state = dvs_state ? DVS_HIGH : DVS_LOW;
>
> +	pdata->enable_gpio = of_get_named_gpio(np, "enable-gpios", 0);

Please move this code to lp872x_populate_pdata_from_dt().
lp872x_hw_enable() is called prior to lp872x_config(), so enable_gpio 
should be set on parsing the DT properties.

> +
>   	if (of_get_child_count(np) == 0)
>   		goto out;
>
> @@ -948,6 +978,10 @@ static int lp872x_probe(struct i2c_client *cl, const struct i2c_device_id *id)
>   	lp->chipid = id->driver_data;
>   	i2c_set_clientdata(cl, lp);
>
> +	ret = lp872x_hw_enable(lp);
> +	if (ret)
> +		return ret;
> +
>   	ret = lp872x_config(lp);
>   	if (ret)
>   		return ret;
> diff --git a/include/linux/regulator/lp872x.h b/include/linux/regulator/lp872x.h
> index 132e05c..6029279 100644
> --- a/include/linux/regulator/lp872x.h
> +++ b/include/linux/regulator/lp872x.h
> @@ -18,6 +18,9 @@
>
>   #define LP872X_MAX_REGULATORS		9
>
> +#define LP8720_ENABLE_DELAY		200
> +#define LP8725_ENABLE_DELAY		30000
> +
>   enum lp872x_regulator_id {
>   	LP8720_ID_BASE,
>   	LP8720_ID_LDO1 = LP8720_ID_BASE,
> @@ -79,12 +82,14 @@ struct lp872x_regulator_data {
>    * @update_config     : if LP872X_GENERAL_CFG register is updated, set true
>    * @regulator_data    : platform regulator id and init data
>    * @dvs               : dvs data for buck voltage control
> + * @enable_gpio       : gpio pin number for enable control
>    */
>   struct lp872x_platform_data {
>   	u8 general_config;
>   	bool update_config;
>   	struct lp872x_regulator_data regulator_data[LP872X_MAX_REGULATORS];
>   	struct lp872x_dvs *dvs;
> +	int enable_gpio;
>   };
>
>   #endif
>

Best regards,
Milo
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
