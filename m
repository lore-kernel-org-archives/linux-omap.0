From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v4 2/8] mfd: retu: Drop -mfd suffix from I2C device ID
 name
Date: Tue, 11 Apr 2017 14:56:04 +0100
Message-ID: <20170411135604.x2bavwti7atebwux@dell>
References: <20170404153036.6651-1-javier@osg.samsung.com>
 <20170404153036.6651-3-javier@osg.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170404153036.6651-3-javier@osg.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Javier Martinez Canillas <javier@osg.samsung.com>
Cc: linux-kernel@vger.kernel.org, Aaro Koskinen <aaro.koskinen@iki.fi>, devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Tony Lindgren <tony@atomide.com>, =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson@baylibre.com>, Mark Rutland <mark.rutland@arm.com>, linux-omap@vger.kernel.org, Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Tue, 04 Apr 2017, Javier Martinez Canillas wrote:

> It's not correct to encode the subsystem in the I2C device name, so
> drop the -mfd suffix. To maintain bisect-ability, change driver and
> platform code / DTS users in the same patch.
> 
> Suggested-by: Lee Jones <lee.jones@linaro.org>
> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
> ---
> 
> Changes in v4: None
> Changes in v3: None
> Changes in v2: None
> 
>  arch/arm/boot/dts/omap2420-n8x0-common.dtsi | 4 ++--
>  arch/arm/mach-omap1/board-nokia770.c        | 4 ++--
>  drivers/mfd/retu-mfd.c                      | 4 ++--
>  3 files changed, 6 insertions(+), 6 deletions(-)

For my own reference:
  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

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
