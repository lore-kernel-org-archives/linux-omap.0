From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH RESEND 2/2] mfd: twl6040: Register child device for
 twl6040-pdmclk
Date: Wed, 31 Aug 2016 15:39:43 +0100
Message-ID: <20160831143943.GN9415@dell>
References: <20160831114621.6301-1-peter.ujfalusi@ti.com>
 <20160831114621.6301-3-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160831114621.6301-3-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Wed, 31 Aug 2016, Peter Ujfalusi wrote:

> The McPDM in OMAP4/5 is using the pdmclk from twl6040 as functional clock.
> The twl6040-pdmclk driver provides a clock which can be used to make sure
> that the pdmclk is active when the McPDM is in use.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> Acked-by: Rob Herring <robh@kernel.org>
> ---
>  Documentation/devicetree/bindings/mfd/twl6040.txt | 1 +
>  drivers/mfd/twl6040.c                             | 5 +++++
>  include/linux/mfd/twl6040.h                       | 2 +-
>  3 files changed, 7 insertions(+), 1 deletion(-)

Applied, thanks.

> diff --git a/Documentation/devicetree/bindings/mfd/twl6040.txt b/Documentation/devicetree/bindings/mfd/twl6040.txt
> index e6afdfa3543d..9a98ee7c323d 100644
> --- a/Documentation/devicetree/bindings/mfd/twl6040.txt
> +++ b/Documentation/devicetree/bindings/mfd/twl6040.txt
> @@ -12,6 +12,7 @@ Required properties:
>  - interrupt-parent: The parent interrupt controller
>  - gpio-controller:
>  - #gpio-cells = <1>: twl6040 provides GPO lines.
> +- #clock-cells = <0>; twl6040 is a provider of pdmclk which is used by McPDM
>  - twl6040,audpwron-gpio: Power on GPIO line for the twl6040
>  
>  - vio-supply: Regulator for the twl6040 VIO supply
> diff --git a/drivers/mfd/twl6040.c b/drivers/mfd/twl6040.c
> index c3ad59ef43dd..d66502d36ba0 100644
> --- a/drivers/mfd/twl6040.c
> +++ b/drivers/mfd/twl6040.c
> @@ -783,6 +783,11 @@ static int twl6040_probe(struct i2c_client *client,
>  	cell->name = "twl6040-gpo";
>  	children++;
>  
> +	/* PDM clock support  */
> +	cell = &twl6040->cells[children];
> +	cell->name = "twl6040-pdmclk";
> +	children++;
> +
>  	/* The chip is powered down so mark regmap to cache only and dirty */
>  	regcache_cache_only(twl6040->regmap, true);
>  	regcache_mark_dirty(twl6040->regmap);
> diff --git a/include/linux/mfd/twl6040.h b/include/linux/mfd/twl6040.h
> index 36795a1be479..a2e88761c09f 100644
> --- a/include/linux/mfd/twl6040.h
> +++ b/include/linux/mfd/twl6040.h
> @@ -168,7 +168,7 @@
>  #define TWL6040_VIBROCDET		0x20
>  #define TWL6040_TSHUTDET                0x40
>  
> -#define TWL6040_CELLS			3
> +#define TWL6040_CELLS			4
>  
>  #define TWL6040_REV_ES1_0		0x00
>  #define TWL6040_REV_ES1_1		0x01 /* Rev ES1.1 and ES1.2 */

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
