From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [PATCH] [OMAP] GPIO Module is reset during initialization
Date: Sat, 24 Oct 2009 01:56:40 +0300
Message-ID: <20091023225639.GA13020@gandalf>
References: <1256313329-24996-1-git-send-email-charu@ti.com>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:46508 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751593AbZJWXEh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 23 Oct 2009 19:04:37 -0400
Content-Disposition: inline
In-Reply-To: <1256313329-24996-1-git-send-email-charu@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: charu@ti.com
Cc: linux-omap@vger.kernel.org

On Fri, Oct 23, 2009 at 09:25:29PM +0530, charu@ti.com wrote:
> From: Charulatha V <charu@ti.com>
> 
> During initialization, GPIO module is reset using soft reset bit
> of SYSCONFIG register
> 
> Signed-off-by: Charulatha V <charu@ti.com>
> ---
>  arch/arm/plat-omap/gpio.c |   12 +++++++++++-
>  1 files changed, 11 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
> index 2304a5d..4579650 100644
> --- a/arch/arm/plat-omap/gpio.c
> +++ b/arch/arm/plat-omap/gpio.c
> @@ -21,6 +21,7 @@
>  #include <linux/err.h>
>  #include <linux/clk.h>
>  #include <linux/io.h>
> +#include <linux/delay.h>
>  
>  #include <mach/hardware.h>
>  #include <asm/irq.h>
> @@ -1670,7 +1671,7 @@ static int __init _omap_gpio_init(void)
>  	}
>  #endif
>  	for (i = 0; i < gpio_bank_count; i++) {
> -		int j, gpio_count = 16;
> +		int j, gpio_count = 16, attempt = 0;

decrementing is better, so:

attempt = 1000

>  
>  		bank = &gpio_bank[i];
>  		spin_lock_init(&bank->lock);
> @@ -1698,6 +1699,15 @@ static int __init _omap_gpio_init(void)
>  			static const u32 non_wakeup_gpios[] = {
>  				0xe203ffc0, 0x08700040
>  			};
> +
> +		/* Software Reset of GPIO module */
> +		__raw_writel(0x0002, bank->base	+ OMAP24XX_GPIO_SYSCONFIG);
> +		while (((__raw_readl(bank->base + OMAP24XX_GPIO_SYSSTATUS)
> +					& 0x1) == 0) && attempt < 5) {

&& attemp)

> +			udelay(1);

i guess cpu_relax() is better here.

> +			attempt++;

attempt--;

-- 
balbi
