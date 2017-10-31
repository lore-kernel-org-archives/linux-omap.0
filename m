From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH] mfd: palmas: Assign the right powerhold mask for tps65917
Date: Tue, 31 Oct 2017 10:48:00 +0000
Message-ID: <20171031104800.sedywmkgf4kp6ych@dell>
References: <1508833296-20702-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1508833296-20702-1-git-send-email-j-keerthy@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Keerthy <j-keerthy@ti.com>
Cc: tony@atomide.com, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, t-kristo@ti.com
List-Id: linux-omap@vger.kernel.org

On Tue, 24 Oct 2017, Keerthy wrote:

> The powerhold mask for TPS65917 is different when comapred to
> the other palmas versions. Hence assign the right mask that enables
> power off of tps65917 pmic correctly.
> 
> Signed-off-by: Keerthy <j-keerthy@ti.com>
> ---
>  drivers/mfd/palmas.c       | 10 +++++++++-
>  include/linux/mfd/palmas.h |  3 +++
>  2 files changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mfd/palmas.c b/drivers/mfd/palmas.c
> index 3922a93..663a239 100644
> --- a/drivers/mfd/palmas.c
> +++ b/drivers/mfd/palmas.c
> @@ -430,6 +430,7 @@ static void palmas_power_off(void)
>  {
>  	unsigned int addr;
>  	int ret, slave;
> +	u8 powerhold_mask;
>  	struct device_node *np = palmas_dev->dev->of_node;
>  
>  	if (of_property_read_bool(np, "ti,palmas-override-powerhold")) {
> @@ -437,8 +438,15 @@ static void palmas_power_off(void)
>  					  PALMAS_PRIMARY_SECONDARY_PAD2);
>  		slave = PALMAS_BASE_TO_SLAVE(PALMAS_PU_PD_OD_BASE);
>  
> +		if (of_device_is_compatible(np, "ti,tps65917"))

Is it possible to interrogate the device itself, rather than DT?

> +			powerhold_mask =
> +				TPS65917_PRIMARY_SECONDARY_PAD2_GPIO_5_MASK;
> +		else
> +			powerhold_mask =
> +				PALMAS_PRIMARY_SECONDARY_PAD2_GPIO_7_MASK;
> +
>  		ret = regmap_update_bits(palmas_dev->regmap[slave], addr,
> -				PALMAS_PRIMARY_SECONDARY_PAD2_GPIO_7_MASK, 0);
> +					 powerhold_mask, 0);
>  		if (ret)
>  			dev_err(palmas_dev->dev,
>  				"Unable to write PRIMARY_SECONDARY_PAD2 %d\n",
> diff --git a/include/linux/mfd/palmas.h b/include/linux/mfd/palmas.h
> index 6dec438..cffb23b 100644
> --- a/include/linux/mfd/palmas.h
> +++ b/include/linux/mfd/palmas.h
> @@ -3733,6 +3733,9 @@ enum usb_irq_events {
>  #define TPS65917_REGEN3_CTRL_MODE_ACTIVE			0x01
>  #define TPS65917_REGEN3_CTRL_MODE_ACTIVE_SHIFT			0x00
>  
> +/* POWERHOLD Mask field for PRIMARY_SECONDARY_PAD2 register */
> +#define TPS65917_PRIMARY_SECONDARY_PAD2_GPIO_5_MASK		0xC
> +
>  /* Registers for function RESOURCE */
>  #define TPS65917_REGEN1_CTRL					0x2
>  #define TPS65917_PLLEN_CTRL					0x3

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
