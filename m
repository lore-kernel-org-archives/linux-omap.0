From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH] OMAP3 GPIO: Fix getting the value of the GPIO output pin
Date: Sun, 8 Feb 2009 11:56:15 -0800
Message-ID: <200902081156.15950.david-b@pacbell.net>
References: <4e1455be0902062015i1ff94b28p93588e61b7860618@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp122.sbc.mail.sp1.yahoo.com ([69.147.64.95]:27463 "HELO
	smtp122.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753128AbZBHT4R (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 8 Feb 2009 14:56:17 -0500
In-Reply-To: <4e1455be0902062015i1ff94b28p93588e61b7860618@mail.gmail.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Joonyoung Shim <dofmind@gmail.com>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>

On Friday 06 February 2009, Joonyoung Shim wrote:
> If the GPIO pin is output, must read the value from OMAP24XX_GPIO_DATAOUT
> register in __omap_get_gpio_datain().

Same comment as with the similar twl4030 patch you sent:
the API specifies that the value reported for input should
be the actual value AT THE PIN, even for outputs ... this
patch would change the behavior to report the value the pin
is trying to drive, which isn't necessarily going to reflect
the signal value at the pin.

So, NAK.

In a few rare cases on OMAP3 chips -- not currently used
by Linux -- GPIOs can be output-only (input drivers not
enabled).  Such a change might be appropriate for GPIOs
configured that way ... were it not for the fact that in
those cases, a value of zero should be returned.

- Dave



> Signed-off-by: Joonyoung Shim <jy0922.shim@samsung.com>
> ---
> 
> diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
> index f856a90..296773a 100644
> --- a/arch/arm/plat-omap/gpio.c
> +++ b/arch/arm/plat-omap/gpio.c
> @@ -428,7 +428,11 @@ static int __omap_get_gpio_datain(int gpio)
>  #endif
>  #if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX)
>  	case METHOD_GPIO_24XX:
> -		reg += OMAP24XX_GPIO_DATAIN;
> +		if (__raw_readl(reg + OMAP24XX_GPIO_OE)
> +					& (1 << get_gpio_index(gpio)))
> +			reg += OMAP24XX_GPIO_DATAIN;
> +		else
> +			reg += OMAP24XX_GPIO_DATAOUT;
>  		break;
>  #endif
>  	default:
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 


