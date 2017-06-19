From: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [RESEND PATCH v6 2/8] mfd: retu: Drop -mfd suffix from I2C
 device ID name
Date: Mon, 19 Jun 2017 15:54:23 +0100
Message-ID: <20170619145423.w7zaeboy7iq2usmt@dell>
References: <20170615184928.12007-1-javier@dowhile0.org>
 <20170615184928.12007-3-javier@dowhile0.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170615184928.12007-3-javier-0uQlZySMnqxg9hUCZPvPmw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Javier Martinez Canillas <javier-0uQlZySMnqxg9hUCZPvPmw@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Aaro Koskinen <aaro.koskinen-X3B1VOXEql0@public.gmane.org>, =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Thu, 15 Jun 2017, Javier Martinez Canillas wrote:

> It's not correct to encode the subsystem in the I2C device name, so
> drop the -mfd suffix. To maintain bisect-ability, change driver and
> platform code / DTS users in the same patch.
> 
> Suggested-by: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> Signed-off-by: Javier Martinez Canillas <javier-0uQlZySMnqxg9hUCZPvPmw@public.gmane.org>
> Acked-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> Acked-by: Aaro Koskinen <aaro.koskinen-X3B1VOXEql0@public.gmane.org>
> Acked-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
> Reviewed-by: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
> 
> ---
> 
> Changes in v6:
> - Add Wolfram Sang's Reviewed-by tag.
> 
> Changes in v5:
> - Add Rob Herring's Acked-by tag.
> - Add Aaro Koskinen's Acked-by tag.
> - Add Tony Lindgren's Acked-by tag.
> 
> Changes in v4: None
> Changes in v3: None
> Changes in v2: None
> 
>  arch/arm/boot/dts/omap2420-n8x0-common.dtsi | 4 ++--
>  arch/arm/mach-omap1/board-nokia770.c        | 4 ++--
>  drivers/mfd/retu-mfd.c                      | 4 ++--
>  3 files changed, 6 insertions(+), 6 deletions(-)

Acked-by: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

> diff --git a/arch/arm/boot/dts/omap2420-n8x0-common.dtsi b/arch/arm/boot/dts/omap2420-n8x0-common.dtsi
> index 7e5ffc583c90..1b06430c8013 100644
> --- a/arch/arm/boot/dts/omap2420-n8x0-common.dtsi
> +++ b/arch/arm/boot/dts/omap2420-n8x0-common.dtsi
> @@ -15,8 +15,8 @@
>  				>;
>  			#address-cells = <1>;
>  			#size-cells = <0>;
> -			retu_mfd: retu@1 {
> -				compatible = "retu-mfd";
> +			retu: retu@1 {
> +				compatible = "retu";
>  				interrupt-parent = <&gpio4>;
>  				interrupts = <12 IRQ_TYPE_EDGE_RISING>;
>  				reg = <0x1>;
> diff --git a/arch/arm/mach-omap1/board-nokia770.c b/arch/arm/mach-omap1/board-nokia770.c
> index ee8d9f553db4..06243c0b12d2 100644
> --- a/arch/arm/mach-omap1/board-nokia770.c
> +++ b/arch/arm/mach-omap1/board-nokia770.c
> @@ -233,10 +233,10 @@ static struct platform_device nokia770_cbus_device = {
>  
>  static struct i2c_board_info nokia770_i2c_board_info_2[] __initdata = {
>  	{
> -		I2C_BOARD_INFO("retu-mfd", 0x01),
> +		I2C_BOARD_INFO("retu", 0x01),
>  	},
>  	{
> -		I2C_BOARD_INFO("tahvo-mfd", 0x02),
> +		I2C_BOARD_INFO("tahvo", 0x02),
>  	},
>  };
>  
> diff --git a/drivers/mfd/retu-mfd.c b/drivers/mfd/retu-mfd.c
> index d4c114abeb75..53e1d386d2c0 100644
> --- a/drivers/mfd/retu-mfd.c
> +++ b/drivers/mfd/retu-mfd.c
> @@ -302,8 +302,8 @@ static int retu_remove(struct i2c_client *i2c)
>  }
>  
>  static const struct i2c_device_id retu_id[] = {
> -	{ "retu-mfd", 0 },
> -	{ "tahvo-mfd", 0 },
> +	{ "retu", 0 },
> +	{ "tahvo", 0 },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, retu_id);

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
