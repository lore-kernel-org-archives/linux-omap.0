From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 4/8] ARM: OMAP1: Move 16xx GPIO system clock to platform init code
Date: Mon, 12 Mar 2012 11:30:05 -0600
Message-ID: <20120312173005.A11093E07B0@localhost>
References: <20120221233619.18709.87982.stgit@kaulin.local> <20120221234042.18709.57610.stgit@kaulin.local>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:64854 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753309Ab2CLRaI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 12 Mar 2012 13:30:08 -0400
Received: by iagz16 with SMTP id z16so7134688iag.19
        for <linux-omap@vger.kernel.org>; Mon, 12 Mar 2012 10:30:08 -0700 (PDT)
In-Reply-To: <20120221234042.18709.57610.stgit@kaulin.local>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

On Tue, 21 Feb 2012 15:40:42 -0800, Tony Lindgren <tony@atomide.com> wrote:
> This way we can remove omap_read/write call from the GPIO driver
> and remove include to linux/io.h.
> 
> Cc: Grant Likely <grant.likely@secretlab.ca>
> Signed-off-by: Tony Lindgren <tony@atomide.com>

Acked-by: Grant Likely <grant.likely@secretlab.ca>

Who will be picking up this series?  How intertwined is it with your tree Tony?

g.

> ---
>  arch/arm/mach-omap1/gpio16xx.c |    7 +++++++
>  drivers/gpio/gpio-omap.c       |    8 --------
>  2 files changed, 7 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/arm/mach-omap1/gpio16xx.c b/arch/arm/mach-omap1/gpio16xx.c
> index 0f399bd..99cabc4 100644
> --- a/arch/arm/mach-omap1/gpio16xx.c
> +++ b/arch/arm/mach-omap1/gpio16xx.c
> @@ -218,6 +218,13 @@ static int __init omap16xx_gpio_init(void)
>  	if (!cpu_is_omap16xx())
>  		return -EINVAL;
>  
> +	/*
> +	 * Enable system clock for GPIO module.
> +	 * The CAM_CLK_CTRL *is* really the right place.
> +	 */
> +	omap_writel(omap_readl(ULPD_CAM_CLK_CTRL) | 0x04,
> +					ULPD_CAM_CLK_CTRL);
> +
>  	for (i = 0; i < ARRAY_SIZE(omap16xx_gpio_dev); i++)
>  		platform_device_register(omap16xx_gpio_dev[i]);
>  
> diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
> index 0b05629..1078a14 100644
> --- a/drivers/gpio/gpio-omap.c
> +++ b/drivers/gpio/gpio-omap.c
> @@ -18,7 +18,6 @@
>  #include <linux/syscore_ops.h>
>  #include <linux/err.h>
>  #include <linux/clk.h>
> -#include <linux/io.h>
>  #include <linux/slab.h>
>  #include <linux/pm_runtime.h>
>  
> @@ -1064,13 +1063,6 @@ static void omap_gpio_mod_init(struct gpio_bank *bank, int id)
>  						+ OMAP1610_GPIO_IRQSTATUS1);
>  			__raw_writew(0x0014, bank->base
>  						+ OMAP1610_GPIO_SYSCONFIG);
> -
> -			/*
> -			 * Enable system clock for GPIO module.
> -			 * The CAM_CLK_CTRL *is* really the right place.
> -			 */
> -			omap_writel(omap_readl(ULPD_CAM_CLK_CTRL) | 0x04,
> -						ULPD_CAM_CLK_CTRL);
>  		}
>  		if (cpu_is_omap7xx() && bank->method == METHOD_GPIO_7XX) {
>  			__raw_writel(0xffffffff, bank->base
> 

-- 
Grant Likely, B.Sc, P.Eng.
Secret Lab Technologies,Ltd.
