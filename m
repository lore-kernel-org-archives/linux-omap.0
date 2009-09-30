From: Tony Lindgren <tony@atomide.com>
Subject: Re: linux-omap git tree updated to v2.6.32-rc1, important changes,
	please read
Date: Wed, 30 Sep 2009 10:55:06 -0700
Message-ID: <20090930175506.GO16865@atomide.com>
References: <20090928190404.GE18957@atomide.com> <EAF47CD23C76F840A9E7FCE10091EFAB02BADAC1AD@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:54068 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754894AbZI3RzG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 30 Sep 2009 13:55:06 -0400
Content-Disposition: inline
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02BADAC1AD@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

* Shilimkar, Santosh <santosh.shilimkar@ti.com> [090929 03:54]:

<snip>
 
> Thanks for fixing the OMAP4 compilation issues. We need below patch to make the kernel boot on OMAP4430 on the latest LO master.

No problem. In the future, let's make sure the omap4 patches are merged
into l-o master branch for testing. This time the first three patches
in the omap-fixes branch were build breakage caused by the omap4 patches
directly or indirectly..

Also, please everybody check that your patches don't break the build
for other the omaps, and also boot test on some other omaps if someting
looks risky.

Few comments below.
 
> 
> From d9a22d9f7b68b99aa9607bdab377d998dfe82acd Mon Sep 17 00:00:00 2001
> From: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Date: Tue, 29 Sep 2009 16:10:46 +0530
> Subject: [PATCH] ARM: OMAP4: Allow omap_serial_early_init() for OMAP4430 board
> 
> This patch enables omap_serial_early_init() function for OMAP4430
> SDP. Without this the bootup would throw opps in omap_serial_init().

The opps probably should be oops above :)

 
> Additionally the patch removed the merge issue for the UART4.
> 
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> ---
>  arch/arm/mach-omap2/board-4430sdp.c |    4 ++--
>  arch/arm/mach-omap2/io.c            |    2 ++
>  arch/arm/mach-omap2/serial.c        |   10 ----------
>  3 files changed, 4 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
> index eb37c40..609a5a4 100644
> --- a/arch/arm/mach-omap2/board-4430sdp.c
> +++ b/arch/arm/mach-omap2/board-4430sdp.c
> @@ -58,6 +58,8 @@ static void __init gic_init_irq(void)
>  
>  static void __init omap_4430sdp_init_irq(void)
>  {
> +	omap_board_config = sdp4430_config;
> +	omap_board_config_size = ARRAY_SIZE(sdp4430_config);
>  	omap2_init_common_hw(NULL, NULL);
>  #ifdef CONFIG_OMAP_32K_TIMER
>  	omap2_gp_clockevent_set_gptimer(1);
> @@ -70,8 +72,6 @@ static void __init omap_4430sdp_init_irq(void)
>  static void __init omap_4430sdp_init(void)
>  {
>  	platform_add_devices(sdp4430_devices, ARRAY_SIZE(sdp4430_devices));
> -	omap_board_config = sdp4430_config;
> -	omap_board_config_size = ARRAY_SIZE(sdp4430_config);
>  	omap_serial_init();
>  }
>  
> diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
> index e3a3bad..56be87d 100644
> --- a/arch/arm/mach-omap2/io.c
> +++ b/arch/arm/mach-omap2/io.c
> @@ -302,7 +302,9 @@ void __init omap2_init_common_hw(struct omap_sdrc_params *sdrc_cs0,
>  	pwrdm_init(powerdomains_omap);
>  	clkdm_init(clockdomains_omap, clkdm_pwrdm_autodeps);
>  	omap2_clk_init();
> +#endif
>  	omap_serial_early_init();
> +#ifndef CONFIG_ARCH_OMAP4
>  	omap_hwmod_late_init();
>  	omap_pm_if_init();
>  	omap2_sdrc_init(sdrc_cs0, sdrc_cs1);
> diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
> index ae21868..54dfeb5 100644
> --- a/arch/arm/mach-omap2/serial.c
> +++ b/arch/arm/mach-omap2/serial.c
> @@ -109,16 +109,6 @@ static struct plat_serial8250_port serial_platform_data2[] = {
>  		.regshift	= 2,
>  		.uartclk	= OMAP24XX_BASE_BAUD * 16,
>  	}, {
> -#ifdef CONFIG_ARCH_OMAP4
> -		.membase	= OMAP2_IO_ADDRESS(OMAP_UART4_BASE),
> -		.mapbase	= OMAP_UART4_BASE,
> -		.irq		= 70,
> -		.flags		= UPF_BOOT_AUTOCONF,
> -		.iotype		= UPIO_MEM,
> -		.regshift	= 2,
> -		.uartclk	= OMAP24XX_BASE_BAUD * 16,
> -	}, {
> -#endif
>  		.flags		= 0
>  	}
>  };

Can't we fix the extra uart instead of removing it? We just added it!
It's still there in omap4, right?

Regards,

Tony
