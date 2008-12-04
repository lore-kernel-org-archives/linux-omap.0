From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 1/1] MMC1 support for OMAP3 EVM with PR785 power modules
Date: Thu, 4 Dec 2008 10:50:34 -0800
Message-ID: <200812041050.34663.david-b@pacbell.net>
References: <1228390936-11504-1-git-send-email-mani.pillai@ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp122.sbc.mail.sp1.yahoo.com ([69.147.64.95]:20615 "HELO
	smtp122.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1755597AbYLDSuh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 4 Dec 2008 13:50:37 -0500
In-Reply-To: <1228390936-11504-1-git-send-email-mani.pillai@ti.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Manikandan Pillai <mani.pillai@ti.com>
Cc: linux-omap@vger.kernel.org

On Thursday 04 December 2008, Manikandan Pillai wrote:
> This patch allows the MMC1 support on OMAP2 EVM board with
> TPS6235x based PR785 boards. Files mmc-pr785.* contain the
> drivers.

See my previous comment about the last twl4030 dependencies
vanishing from mmc-twl4030.c via regulator framework support.

Done well, the PR785 updates should produce hsmmc glue that
can be used on any board that's been converted to use the
regulator framework.


> @@ -258,15 +263,28 @@ static struct platform_device *omap3_evm_devices[] __initdata = {
>  	&omap3evm_smc911x_device,
>  };
>  
> -static struct twl4030_hsmmc_info mmc[] __initdata = {
> +#if defined(CONFIG_PR785)
> +static struct pr785_hsmmc_info mmc[] __initdata = {
>  	{
>  		.mmc		= 1,
>  		.wires		= 4,
> -		.gpio_cd	= -EINVAL,
> +		.gpio_cd	= (IH_GPIO_BASE + 140),

I'd think this should just be "140", letting the hsmmc glue
code convert it to an IRQ as needed.  This looks very wrong,
and in a way that could explain why you seem to want some
board-specific hacks in the hsmmc.c driver.

Does the EVM use GPIO 140 in all cases, or is that signal
routed to the power card?  It'd make more sense if it were
done in all cases.  I suspect the best way to move forward
here would be to submit patches filling in the gaps for
current EVM MMC support first, and *then* update the MMC
support for pr785 differences.


>  		.gpio_wp	= -EINVAL,

Really?  The write protect switch isn't wired up?  Odd...

>  	},
>  	{}	/* Terminator */
>  };
> +#endif


> --- a/arch/arm/mach-omap2/mux.c
> +++ b/arch/arm/mach-omap2/mux.c
> @@ -459,6 +459,19 @@ MUX_CFG_34XX("AH8_34XX_GPIO29", 0x5fa,
>  		OMAP34XX_MUX_MODE4 | OMAP34XX_PIN_INPUT)
>  MUX_CFG_34XX("J25_34XX_GPIO170", 0x1c6,
>  		OMAP34XX_MUX_MODE4 | OMAP34XX_PIN_INPUT)
> +MUX_CFG_34XX("AF26_34XX_GPIO0", 0x1e0,
> +		OMAP34XX_MUX_MODE4 | OMAP34XX_PIN_OUTPUT)
> +MUX_CFG_34XX("AF22_34XX_GPIO9", 0xa18,
> +		OMAP34XX_MUX_MODE4 | OMAP34XX_PIN_OUTPUT)
> +MUX_CFG_34XX("AF6_34XX_GPIO140", 0x16c,
> +		OMAP34XX_MUX_MODE4 | OMAP34XX_PIN_INPUT_PULLUP)

Make that AF6_34XX_GPIO140_UP, to follow the clearly documented
naming convention.  Other boards may need a pull DOWN on that
GPIO, or use external resistors, or want none at all ...

All the pinmux support *should* be in a separate patch.
It's completely independent of EVM or PR785, and other
boards may need these GPIOs.   Beagle, for example, has
GPIOs 140-143 (and more!) on its expansion connector.


> +MUX_CFG_34XX("AE6_34XX_GPIO141", 0x16e,
> +		OMAP34XX_MUX_MODE4 | OMAP34XX_PIN_OUTPUT)
> +MUX_CFG_34XX("AF5_34XX_GPIO142", 0x170,
> +		OMAP34XX_MUX_MODE4 | OMAP34XX_PIN_OUTPUT)
> +MUX_CFG_34XX("AE5_34XX_GPIO143", 0x172,
> +		OMAP34XX_MUX_MODE4 | OMAP34XX_PIN_OUTPUT)
> +
> };
>  
>  #define OMAP34XX_PINS_SZ	ARRAY_SIZE(omap34xx_pins)


> --- a/arch/arm/plat-omap/include/mach/mmc.h
> +++ b/arch/arm/plat-omap/include/mach/mmc.h
> @@ -36,6 +36,18 @@
>  
>  #define OMAP_MMC_MAX_SLOTS	2
>  
> +#if defined(CONFIG_MACH_OMAP3EVM) && defined(CONFIG_PR785)
> +#define OMAP_PR785_MMC1_VSET    0
> +#define OMAP_PR785_MMC1_EN      9
> +#define OMAP_PR785_MMC1_CD      140
> +#define OMAP_PR785_MMC1_CD_MSK  ((1<<12))
> +
> +/* Workaround for MMC Card insertion and deletion interrupt since
> +   Rising and falling interupt detection does not work */
> +#define OMAP_GPIO5_MMC_LOWLVL   (0x49056040)
> +#define OMAP_GPIO5_MMC_HIGHLVL  (0x49056044)
> +#endif

Board-specific #ifdefs don't belong in <mach/mmc.h> ...
or pretty much anywhere.  There *might* be cases where
they're not avoidable.  This isn't one of them.

Re rising and falling not working ... this is a hardware
erratum I've not yet come across?  I would expect the
normal request_irq() code in hsmmc.c to work.

Maybe the issue here is what I noted above:  you're
passing an IRQ number in as a GPIO, and thus are not
using the GPIO logic correctly.

- Dave


