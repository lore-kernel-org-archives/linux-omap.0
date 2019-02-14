From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH] mfd: twl6040: Fix device init errors for ACCCTL register
Date: Thu, 14 Feb 2019 09:20:45 +0000
Message-ID: <20190214092045.GD13737@dell>
References: <20190211225726.38355-1-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190211225726.38355-1-tony@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Florian Vaussard <florian.vaussard@epfl.ch>, Peter Ujfalusi <peter.ujfalusi@ti.com>
List-Id: linux-omap@vger.kernel.org

On Mon, 11 Feb 2019, Tony Lindgren wrote:

> I noticed that we can get a -EREMOTEIO errors on at least omap4 duovero:
> 
> twl6040 0-004b: Failed to write 2d = 19: -121
> 
> And then any following register access will produce errors.
> 
> There 2d offset above is register ACCCTL that gets written on twl6040
> powerup. With error checking added to the related regcache_sync() call,
> the -EREMOTEIO error is reproducable on twl6040 powerup at least
> duovero.
> 
> To fix the error, we need to wait until twl6040 is accessible after the
> powerup. Based on tests on omap4 duovero, we need to wait over 8ms after
> powerup before register write will complete without failures. Let's also
> make sure we warn about possible errors too.
> 
> Note that we have twl6040_patch[] reg_sequence with the ACCCTL register
> configuration and regcache_sync() will write the new value to ACCCTL.
> 
> Cc: Florian Vaussard <florian.vaussard@epfl.ch>
> Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>  drivers/mfd/twl6040.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mfd/twl6040.c b/drivers/mfd/twl6040.c
> --- a/drivers/mfd/twl6040.c
> +++ b/drivers/mfd/twl6040.c
> @@ -322,8 +322,19 @@ int twl6040_power(struct twl6040 *twl6040, int on)
>  			}
>  		}
>  
> +		/*
> +		 * Register access can produce errors after power-up unless we
> +		 * wait at least 8ms based on measurements on duovero.
> +		 */
> +		usleep_range(10000, 12000);
> +
>  		/* Sync with the HW */
> -		regcache_sync(twl6040->regmap);
> +		ret = regcache_sync(twl6040->regmap);
> +		if (ret) {
> +			dev_err(twl6040->dev, "%s register write failed: %i\n",
> +				__func__, ret);

Please drop the __func__ and just use the standard format.

Wouldn't something a little more forthcoming be better?

"Failed to sync with the HW" ?

> +			goto out;
> +		}
>  
>  		/* Default PLL configuration after power up */
>  		twl6040->pll = TWL6040_SYSCLK_SEL_LPPLL;

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
