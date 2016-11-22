From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v2 3/5] mfd: palmas: Reset the POWERHOLD mux during power
 off
Date: Tue, 22 Nov 2016 13:03:08 +0000
Message-ID: <20161122130308.GE316@dell.lan>
References: <1478754560-27923-1-git-send-email-j-keerthy@ti.com>
 <1478754560-27923-4-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1478754560-27923-4-git-send-email-j-keerthy@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Keerthy <j-keerthy@ti.com>
Cc: tony@atomide.com, robh+dt@kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, nm@ti.com, t-kristo@ti.com
List-Id: linux-omap@vger.kernel.org

On Thu, 10 Nov 2016, Keerthy wrote:

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
> Signed-off-by: Keerthy <j-keerthy@ti.com>
> ---
> 
> Changes in v2:
> 
>   * Changed pr_err to dev_err
>   * removed redundant boolean variable override-powerhold
> 
>  drivers/mfd/palmas.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)

Applied, thanks.

> diff --git a/drivers/mfd/palmas.c b/drivers/mfd/palmas.c
> index ee9e9ea..da90124 100644
> --- a/drivers/mfd/palmas.c
> +++ b/drivers/mfd/palmas.c
> @@ -430,6 +430,20 @@ static void palmas_power_off(void)
>  {
>  	unsigned int addr;
>  	int ret, slave;
> +	struct device_node *np = palmas_dev->dev->of_node;
> +
> +	if (of_property_read_bool(np, "ti,palmas-override-powerhold")) {
> +		addr = PALMAS_BASE_TO_REG(PALMAS_PU_PD_OD_BASE,
> +					  PALMAS_PRIMARY_SECONDARY_PAD2);
> +		slave = PALMAS_BASE_TO_SLAVE(PALMAS_PU_PD_OD_BASE);
> +
> +		ret = regmap_update_bits(palmas_dev->regmap[slave], addr,
> +				PALMAS_PRIMARY_SECONDARY_PAD2_GPIO_7_MASK, 0);
> +		if (ret)
> +			dev_err(palmas_dev->dev,
> +				"Unable to write PRIMARY_SECONDARY_PAD2 %d\n",
> +				ret);
> +	}
>  
>  	slave = PALMAS_BASE_TO_SLAVE(PALMAS_PMU_CONTROL_BASE);
>  	addr = PALMAS_BASE_TO_REG(PALMAS_PMU_CONTROL_BASE, PALMAS_DEV_CTRL);

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
