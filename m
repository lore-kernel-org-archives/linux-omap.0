From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] omap2: fix assorted compiler warnings
Date: Tue, 3 Aug 2010 10:51:15 +0300
Message-ID: <20100803075114.GT12293@atomide.com>
References: <1279016650-20459-1-git-send-email-premi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:52423 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752152Ab0HCHuu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 3 Aug 2010 03:50:50 -0400
Content-Disposition: inline
In-Reply-To: <1279016650-20459-1-git-send-email-premi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sanjeev Premi <premi@ti.com>
Cc: linux-omap@vger.kernel.org

* Sanjeev Premi <premi@ti.com> [100713 13:26]:
> This patch fixes these compiler warnings:

> --- a/arch/arm/mach-omap2/mux.c
> +++ b/arch/arm/mach-omap2/mux.c
> @@ -87,7 +87,7 @@ static char *omap_mux_options;
>  int __init omap_mux_init_gpio(int gpio, int val)
>  {
>  	struct omap_mux_entry *e;
> -	struct omap_mux *gpio_mux;
> +	struct omap_mux *gpio_mux=NULL;

Please use spaces around = like *gpio_mux = NULL;

>  	u16 old_mode;
>  	u16 mux_mode;
>  	int found = 0;
> diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
> index 9b7e354..831e6bc 100644
> --- a/arch/arm/plat-omap/gpio.c
> +++ b/arch/arm/plat-omap/gpio.c
> @@ -2082,7 +2082,7 @@ void omap2_gpio_prepare_for_idle(int power_state)
>  
>  	for (i = min; i < gpio_bank_count; i++) {
>  		struct gpio_bank *bank = &gpio_bank[i];
> -		u32 l1, l2;
> +		u32 l1=0, l2=0;
>  
>  		if (bank->dbck_enable_mask)
>  			clk_disable(bank->dbck);

Here too.

> @@ -2149,7 +2149,7 @@ void omap2_gpio_resume_after_idle(void)
>  		min = 1;
>  	for (i = min; i < gpio_bank_count; i++) {
>  		struct gpio_bank *bank = &gpio_bank[i];
> -		u32 l, gen, gen0, gen1;
> +		u32 l=0, gen, gen0, gen1;
>  
>  		if (bank->dbck_enable_mask)
>  			clk_enable(bank->dbck);

And here.

Regards,

Tony
