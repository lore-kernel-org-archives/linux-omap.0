From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [PATCH 1/1] MMC1 support for OMAP3 EVM with PR785 power modules
Date: Thu, 4 Dec 2008 13:57:59 +0200
Message-ID: <20081204115759.GR10209@gandalf.research.nokia.com>
References: <1228390936-11504-1-git-send-email-mani.pillai@ti.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:25250 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750755AbYLDL7M (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 4 Dec 2008 06:59:12 -0500
Content-Disposition: inline
In-Reply-To: <1228390936-11504-1-git-send-email-mani.pillai@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Manikandan Pillai <mani.pillai@ti.com>
Cc: linux-omap@vger.kernel.org

On Thu, Dec 04, 2008 at 05:12:16PM +0530, ext Manikandan Pillai wrote:
> This patch allows the MMC1 support on OMAP2 EVM board with
> TPS6235x based PR785 boards. Files mmc-pr785.* contain the
> drivers.

again, you'll have to break into a series.

Mux configuration should be separated. Also, use the standard
cross-platform gpio calls, don't use omap_*_gpio_*() calls anymore.

> diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
> index ab3070d..e8eaa6b 100644
> --- a/arch/arm/mach-omap2/board-omap3evm.c
> +++ b/arch/arm/mach-omap2/board-omap3evm.c
> @@ -40,7 +40,12 @@
>  
>  #include "sdram-micron-mt46h32m32lf-6.h"
>  #include "twl4030-generic-scripts.h"
> +#if defined(CONFIG_PR785)
> +#include "mmc-pr785.h"
> +#endif
> +#if defined(CONFIG_TWL4030_CORE)
>  #include "mmc-twl4030.h"
> +#endif

Think you'll have to think a bit more on this because...

>  
>  static struct resource omap3evm_smc911x_resources[] = {
>  	[0] =	{
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
>  		.gpio_wp	= -EINVAL,
>  	},
>  	{}	/* Terminator */
>  };

you basically copied the structure. It's bad to duplicate code. Anyone
else has any comments here ??

> +#endif
> +#if defined(CONFIG_TWL4030_CORE)
> +static struct twl4030_hsmmc_info mmc[] __initdata = {
> +	{
> +		.mmc            = 1,
> +		.wires          = 4,
> +		.gpio_cd        = -EINVAL,
> +		.gpio_wp        = -EINVAL,
> +	},
> +	{}      /* Terminator */
> +};
> +#endif
>  
>  static void __init omap3_evm_init(void)
>  {
> diff --git a/arch/arm/mach-omap2/mux.c b/arch/arm/mach-omap2/mux.c
> index dacb41f..68531b6 100644
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
> +MUX_CFG_34XX("AE6_34XX_GPIO141", 0x16e,
> +		OMAP34XX_MUX_MODE4 | OMAP34XX_PIN_OUTPUT)
> +MUX_CFG_34XX("AF5_34XX_GPIO142", 0x170,
> +		OMAP34XX_MUX_MODE4 | OMAP34XX_PIN_OUTPUT)
> +MUX_CFG_34XX("AE5_34XX_GPIO143", 0x172,
> +		OMAP34XX_MUX_MODE4 | OMAP34XX_PIN_OUTPUT)
> +

this should be in a mux setup patch.

> @@ -790,6 +790,13 @@ enum omap34xx_index {
>  	 */
>  	AH8_34XX_GPIO29,
>  	J25_34XX_GPIO170,
> +	AF26_34XX_GPIO0,
> +	AF22_34XX_GPIO9,
> +	AF6_34XX_GPIO140,
> +	AE6_34XX_GPIO141,
> +	AF5_34XX_GPIO142,
> +	AE5_34XX_GPIO143
> +

this too.

> @@ -32,6 +32,8 @@
>  #include <mach/board.h>
>  #include <mach/mmc.h>
>  #include <mach/cpu.h>
> +#include <mach/gpio.h>

#include <linux/gpio.h>

> @@ -1231,6 +1280,9 @@ static void __exit omap_mmc_cleanup(void)
>  {
>  	/* Unregister MMC driver */
>  	platform_driver_unregister(&omap_mmc_driver);
> +#if defined(CONFIG_MACH_OMAP3EVM) && defined(CONFIG_PR785)
> +	omap_free_gpio(OMAP_PR785_MMC1_CD);

gpio_free(...);


-- 
balbi
