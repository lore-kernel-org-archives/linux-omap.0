From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH] Allow OMAP3 GPIO wakeup from power off.
Date: Wed, 13 May 2009 07:07:33 -0700
Message-ID: <87hbzp9jve.fsf@deeprootsystems.com>
References: <1240860407-14883-1-git-send-email-Russ.Dill@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.175]:56076 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752267AbZEMOHg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 13 May 2009 10:07:36 -0400
Received: by wf-out-1314.google.com with SMTP id 26so444127wfd.4
        for <linux-omap@vger.kernel.org>; Wed, 13 May 2009 07:07:36 -0700 (PDT)
In-Reply-To: <1240860407-14883-1-git-send-email-Russ.Dill@gmail.com> (Russ Dill's message of "Mon\, 27 Apr 2009 12\:26\:47 -0700")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russ Dill <russ.dill@gmail.com>
Cc: linux-omap@vger.kernel.org

Russ Dill <russ.dill@gmail.com> writes:

> This patch configures the wakeup padconf registers to reflect the sysfs
> power/wakeup settings. This allows a GPIO to wake the processor from
> off mode.
>
> Signed-off-by: Russ Dill <Russ.Dill@gmail.com>

Hi Russ,

This looks good for the PM branch.  For completeness, could you update
the description to include a brief example of how you're using sysfs
to test this.  That will help other folks test this feature and
also setup some automated tests.

Thanks,

Kevin

> ---
>  arch/arm/plat-omap/gpio.c |   58 ++++++++++++++++++++++++++++++--------------
>  1 files changed, 39 insertions(+), 19 deletions(-)
>
> diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
> index 64852db..3b2054b 100644
> --- a/arch/arm/plat-omap/gpio.c
> +++ b/arch/arm/plat-omap/gpio.c
> @@ -277,7 +277,14 @@ static const struct gpio_pad_range gpio_pads_config[] = {
>  	{ 170, 182, 0x1c6 },
>  	{ 0, 0, 0x1e0 },
>  	{ 186, 186, 0x1e2 },
> +	{ 187, 187, 0x238 },
> +	{ 32, 32, 0x23a },
>  	{ 12, 29, 0x5d8 },
> +	{ 1, 1, 0xa06 },
> +	{ 30, 30, 0xa08 },
> +	{ 2, 10, 0xa0a },
> +	{ 11, 11, 0xa24 },
> +	{ 31, 31, 0xa26 },
>  };
>  
>  /* GPIO -> PAD config mapping for OMAP3 */
> @@ -289,7 +296,8 @@ struct gpio_pad {
>  
>  #define OMAP34XX_GPIO_AMT	(32 * OMAP34XX_NR_GPIOS)
>  
> -struct gpio_pad *gpio_pads;
> +static struct gpio_pad *gpio_pads;
> +static u16 gpio_pad_map[OMAP34XX_GPIO_AMT];
>  #endif
>  
>  static struct gpio_bank *gpio_bank;
> @@ -1353,32 +1361,21 @@ static int __init omap3_gpio_pads_init(void)
>  {
>  	int i, j, min, max, gpio_amt;
>  	u16 offset;
> -	u16 *gpio_pad_map;
>  
>  	gpio_amt = 0;
>  
> -	gpio_pad_map = kzalloc(sizeof(u16) * OMAP34XX_GPIO_AMT, GFP_KERNEL);
> -	if (gpio_pad_map == NULL) {
> -		printk(KERN_ERR "FATAL: Failed to allocate gpio_pad_map\n");
> -		return -ENOMEM;
> -	}
> -
>  	for (i = 0; i < ARRAY_SIZE(gpio_pads_config); i++) {
>  		min = gpio_pads_config[i].min;
>  		max = gpio_pads_config[i].max;
>  		offset = gpio_pads_config[i].offset;
>  
>  		for (j = min; j <= max; j++) {
> -			/*
> -			 * Check if pad has been configured as GPIO.
> -			 * First module (gpio 0...31) is ignored as it is
> -			 * in wakeup domain and does not need special
> -			 * handling during off mode.
> -			 */
> -			if (j > 31 && (omap_ctrl_readw(offset) &
> +			/* Check if pad has been configured as GPIO. */
> +			if ((omap_ctrl_readw(offset) &
>  				OMAP34XX_MUX_MODE7) == OMAP34XX_MUX_MODE4) {
>  				gpio_pad_map[j] = offset;
> -				gpio_amt++;
> +				if (j > 31)
> +					gpio_amt++;
>  			}
>  			offset += 2;
>  		}
> @@ -1388,20 +1385,23 @@ static int __init omap3_gpio_pads_init(void)
>  
>  	if (gpio_pads == NULL) {
>  		printk(KERN_ERR "FATAL: Failed to allocate gpio_pads\n");
> -		kfree(gpio_pad_map);
>  		return -ENOMEM;
>  	}
>  
>  	gpio_amt = 0;
>  	for (i = 0; i < OMAP34XX_GPIO_AMT; i++) {
> -		if (gpio_pad_map[i] != 0) {
> +		/*
> +		 * First module (gpio 0...31) is ignored as it is
> +		 * in wakeup domain and does not need special
> +		 * handling during off mode.
> +		 */
> +		if (gpio_pad_map[i] && i > 31) {
>  			gpio_pads[gpio_amt].gpio = i;
>  			gpio_pads[gpio_amt].offset = gpio_pad_map[i];
>  			gpio_amt++;
>  		}
>  	}
>  	gpio_pads[gpio_amt].gpio = -1;
> -	kfree(gpio_pad_map);
>  	return 0;
>  }
>  late_initcall(omap3_gpio_pads_init);
> @@ -1676,6 +1676,26 @@ static int omap_gpio_suspend(struct sys_device *dev, pm_message_t mesg)
>  		__raw_writel(0xffffffff, wake_clear);
>  		__raw_writel(bank->suspend_wakeup, wake_set);
>  		spin_unlock_irqrestore(&bank->lock, flags);
> +
> +#ifdef CONFIG_ARCH_OMAP34XX
> +		if (bank->method == METHOD_GPIO_24XX) {
> +			int j;
> +			for (j = 0; j < 32; j++) {
> +				int offset = gpio_pad_map[j + i * 32];
> +				u16 v;
> +
> +				if (!offset)
> +					continue;
> +
> +				v = omap_ctrl_readw(offset);
> +				if (bank->suspend_wakeup & (1 << j))
> +					v |= OMAP3_PADCONF_WAKEUPENABLE0;
> +				else
> +					v &= ~OMAP3_PADCONF_WAKEUPENABLE0;
> +				omap_ctrl_writew(v, offset);
> +			}
> +		}
> +#endif
>  	}
>  
>  	return 0;
> -- 
> 1.6.0.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
