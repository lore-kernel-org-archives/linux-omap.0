From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH] OMAP: Fix compilation warnings
Date: Fri, 01 Oct 2010 09:00:16 -0700
Message-ID: <87hbh5aoof.fsf@deeprootsystems.com>
References: <1285913039-2873-1-git-send-email-pramod.gurav@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:34352 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750988Ab0JAQAV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 Oct 2010 12:00:21 -0400
Received: by gye5 with SMTP id 5so1101446gye.19
        for <linux-omap@vger.kernel.org>; Fri, 01 Oct 2010 09:00:20 -0700 (PDT)
In-Reply-To: <1285913039-2873-1-git-send-email-pramod.gurav@ti.com> (pramod
	gurav's message of "Fri, 1 Oct 2010 11:33:59 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: pramod.gurav@ti.com
Cc: linux-omap@vger.kernel.org

pramod.gurav@ti.com writes:

> From: Pramod Gurav <pramod.gurav@ti.com>

patch is missing
- more descriptive subject
- more descriptive changelog (preferably incluing compilation error)
- signoff (should've been noticed when running checkpatch)

And after the '---', which tree this applies to since it does not apply
to current l-o master.  In fact, it appears that all these issues have
already been fixed in l-o master.

Kevin

> ---
>  arch/arm/mach-omap2/board-omap4panda.c |    2 --
>  arch/arm/mach-omap2/mux.c              |    2 +-
>  arch/arm/plat-omap/gpio.c              |    4 ++--
>  3 files changed, 3 insertions(+), 5 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/board-omap4panda.c b/arch/arm/mach-omap2/board-omap4panda.c
> index c03d1d5..96f5bbb 100644
> --- a/arch/arm/mach-omap2/board-omap4panda.c
> +++ b/arch/arm/mach-omap2/board-omap4panda.c
> @@ -274,8 +274,6 @@ static int __init omap4_panda_i2c_init(void)
>  }
>  static void __init omap4_panda_init(void)
>  {
> -	int status;
> -
>  	omap4_panda_i2c_init();
>  	omap_serial_init();
>  	omap4_twl6030_hsmmc_init(mmc);
> diff --git a/arch/arm/mach-omap2/mux.c b/arch/arm/mach-omap2/mux.c
> index ab403b2..6c2f8f0 100644
> --- a/arch/arm/mach-omap2/mux.c
> +++ b/arch/arm/mach-omap2/mux.c
> @@ -87,7 +87,7 @@ static char *omap_mux_options;
>  int __init omap_mux_init_gpio(int gpio, int val)
>  {
>  	struct omap_mux_entry *e;
> -	struct omap_mux *gpio_mux;
> +	struct omap_mux *gpio_mux = NULL;
>  	u16 old_mode;
>  	u16 mux_mode;
>  	int found = 0;
> diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
> index f6c03a7..22f175f 100644
> --- a/arch/arm/plat-omap/gpio.c
> +++ b/arch/arm/plat-omap/gpio.c
> @@ -2223,7 +2223,7 @@ void omap2_gpio_prepare_for_idle(int power_state)
>  
>  	for (i = min; i < gpio_bank_count; i++) {
>  		struct gpio_bank *bank = &gpio_bank[i];
> -		u32 l1, l2;
> +		u32 l1 = 0, l2 = 0;
>  		int j;
>   
>  		for (j = 0; j < hweight_long(bank->dbck_enable_mask); j++)
> @@ -2291,7 +2291,7 @@ void omap2_gpio_resume_after_idle(void)
>  		min = 1;
>  	for (i = min; i < gpio_bank_count; i++) {
>  		struct gpio_bank *bank = &gpio_bank[i];
> -		u32 l, gen, gen0, gen1;
> +		u32 l = 0, gen, gen0, gen1;
>  		int j;
>   
>  		for (j = 0; j < hweight_long(bank->dbck_enable_mask); j++)
