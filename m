From: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/4] mfd: palmas: Reset the POWERHOLD mux during power off
Date: Wed, 9 Nov 2016 16:14:19 +0000
Message-ID: <20161109161419.GJ13127@dell>
References: <1477559414-12520-1-git-send-email-j-keerthy@ti.com>
 <1477559414-12520-3-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1477559414-12520-3-git-send-email-j-keerthy-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>
Cc: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, nm-l0cyMroinI0@public.gmane.org, t-kristo-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Thu, 27 Oct 2016, Keerthy wrote:

> POWERHOLD signal has higher priority  over the DEV_ON bit.
> So power off will not happen if the POWERHOLD is held high.
> Hence reset the MUX to GPIO_7 mode to release the POWERHOLD
> and the DEV_ON bit to take effect to power off the PMIC.
> 
> PMIC Power off happens in dire situations like thermal shutdown
> so irrespective of the POWERHOLD setting go ahead and turn off
> the powerhold.  Currently poweroff is broken on boards that have
> powerhold enabled. This fixes poweroff on those boards.
> 
> Signed-off-by: Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>
> ---
>  drivers/mfd/palmas.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/drivers/mfd/palmas.c b/drivers/mfd/palmas.c
> index 8f8bacb..8fbc5e0 100644
> --- a/drivers/mfd/palmas.c
> +++ b/drivers/mfd/palmas.c
> @@ -430,10 +430,28 @@ static void palmas_power_off(void)
>  {
>  	unsigned int addr;
>  	int ret, slave;
> +	struct device_node *node;
> +	bool override_powerhold;
>  
>  	if (!palmas_dev)

Can this happen?

>  		return;
>  
> +	node = palmas_dev->dev->of_node;

Just do:

struct device_node *np = palmas_dev->dev->of_node;

> +	override_powerhold = of_property_read_bool(node,
> +					"ti,palmas-override-powerhold");

Break the line after the '=' instead.

> +	if (override_powerhold) {

if (of_property_read_bool(node,	"ti,palmas-override-powerhold"))

Then remove 'override_powerhold'.

> +		addr = PALMAS_BASE_TO_REG(PALMAS_PU_PD_OD_BASE,
> +					  PALMAS_PRIMARY_SECONDARY_PAD2);
> +		slave = PALMAS_BASE_TO_SLAVE(PALMAS_PU_PD_OD_BASE);
> +
> +		ret = regmap_update_bits(palmas_dev->regmap[slave], addr,
> +					 PALMAS_PRIMARY_SECONDARY_PAD2_GPIO_7_MASK, 0);
> +		if (ret)
> +			pr_err("%s: Unable to write PALMAS_PRIMARY_SECONDARY_PAD2 %d\n",
> +			       __func__, ret);

Don't use __func__ in live code.

And use dev_err();


> +	}
> +
>  	slave = PALMAS_BASE_TO_SLAVE(PALMAS_PMU_CONTROL_BASE);
>  	addr = PALMAS_BASE_TO_REG(PALMAS_PMU_CONTROL_BASE, PALMAS_DEV_CTRL);
>  

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
