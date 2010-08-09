From: "Premi, Sanjeev" <premi@ti.com>
Subject: RE: [PATCH] omap2: fix assorted compiler warnings
Date: Mon, 9 Aug 2010 16:58:02 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301E800C3E3@dbde02.ent.ti.com>
References: <1279016650-20459-1-git-send-email-premi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:55214 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756101Ab0HIL2N convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 9 Aug 2010 07:28:13 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id o79BS4kT001088
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Mon, 9 Aug 2010 06:28:06 -0500
Received: from dbde71.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id o79BS3V0022990
	for <linux-omap@vger.kernel.org>; Mon, 9 Aug 2010 16:58:03 +0530 (IST)
In-Reply-To: <1279016650-20459-1-git-send-email-premi@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> -----Original Message-----
> From: Premi, Sanjeev 
> Sent: Tuesday, July 13, 2010 3:54 PM
> To: linux-omap@vger.kernel.org
> Cc: Premi, Sanjeev
> Subject: [PATCH] omap2: fix assorted compiler warnings

Tony,

I notice the same warnings today while building against:

commit 842849896627701e4c07441f2c7519aeec771058
Merge: 024a97d c287f2c
Author: Tony Lindgren <tony@atomide.com>
Date:   Wed Aug 4 18:33:28 2010 +0300

Is this patch in your queue?

~sanjeev

> 
> This patch fixes these compiler warnings:
> 
>   CC      arch/arm/mach-omap2/mux.o
> arch/arm/mach-omap2/mux.c: In function 'omap_mux_init_gpio':
> arch/arm/mach-omap2/mux.c:90: warning: 'gpio_mux' may be used 
> uninitial
> ized in this function
> 
>   CC      arch/arm/plat-omap/gpio.o
> arch/arm/plat-omap/gpio.c: In function 'omap2_gpio_resume_after_idle':
> arch/arm/plat-omap/gpio.c:2152: warning: 'l' may be used uninitialized
> in this function
> arch/arm/plat-omap/gpio.c: In function 'omap2_gpio_prepare_for_idle':
> arch/arm/plat-omap/gpio.c:2085: warning: 'l2' may be used 
> uninitialized
> in this function
> arch/arm/plat-omap/gpio.c:2085: warning: 'l1' may be used 
> uninitialized
> in this function
> 
>   CC      arch/arm/mach-omap2/board-omap4panda.o
> arch/arm/mach-omap2/board-omap4panda.c: In function 
> 'omap4_panda_init':
> arch/arm/mach-omap2/board-omap4panda.c:277: warning: unused 
> variable 's
> tatus'
> 
> Signed-off-by: Sanjeev Premi <premi@ti.com>
> ---
>  arch/arm/mach-omap2/board-omap4panda.c |    2 --
>  arch/arm/mach-omap2/mux.c              |    2 +-
>  arch/arm/plat-omap/gpio.c              |    4 ++--
>  3 files changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/board-omap4panda.c 
> b/arch/arm/mach-omap2/board-omap4panda.c
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
> index ab403b2..2ffacc1 100644
> --- a/arch/arm/mach-omap2/mux.c
> +++ b/arch/arm/mach-omap2/mux.c
> @@ -87,7 +87,7 @@ static char *omap_mux_options;
>  int __init omap_mux_init_gpio(int gpio, int val)
>  {
>  	struct omap_mux_entry *e;
> -	struct omap_mux *gpio_mux;
> +	struct omap_mux *gpio_mux=NULL;
>  	u16 old_mode;
>  	u16 mux_mode;
>  	int found = 0;
> diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
> index 9b7e354..831e6bc 100644
> --- a/arch/arm/plat-omap/gpio.c
> +++ b/arch/arm/plat-omap/gpio.c
> @@ -2082,7 +2082,7 @@ void omap2_gpio_prepare_for_idle(int 
> power_state)
>  
>  	for (i = min; i < gpio_bank_count; i++) {
>  		struct gpio_bank *bank = &gpio_bank[i];
> -		u32 l1, l2;
> +		u32 l1=0, l2=0;
>  
>  		if (bank->dbck_enable_mask)
>  			clk_disable(bank->dbck);
> @@ -2149,7 +2149,7 @@ void omap2_gpio_resume_after_idle(void)
>  		min = 1;
>  	for (i = min; i < gpio_bank_count; i++) {
>  		struct gpio_bank *bank = &gpio_bank[i];
> -		u32 l, gen, gen0, gen1;
> +		u32 l=0, gen, gen0, gen1;
>  
>  		if (bank->dbck_enable_mask)
>  			clk_enable(bank->dbck);
> -- 
> 1.6.6.1
> 
> 