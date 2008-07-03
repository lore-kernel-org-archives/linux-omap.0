From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP: Add support to Nokia N810 WiMAX
Date: Thu, 3 Jul 2008 13:26:22 +0300
Message-ID: <20080703102621.GK14276@atomide.com>
References: <1214898819-12471-1-git-send-email-jarkko.nikula@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:51826 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755413AbYGCMdw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Jul 2008 08:33:52 -0400
Content-Disposition: inline
In-Reply-To: <1214898819-12471-1-git-send-email-jarkko.nikula@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@nokia.com>
Cc: linux-omap@vger.kernel.org

* Jarkko Nikula <jarkko.nikula@nokia.com> [080701 10:54]:
> This adds basic booting support and selects CONFIG_MACH_NOKIA_N810 since
> most of the HW and configuration are the same in N810 and N810 WiMAX.

Pushing today.

Tony


> Signed-off-by: Jarkko Nikula <jarkko.nikula@nokia.com>
> ---
>  arch/arm/mach-omap2/Kconfig      |    5 +++++
>  arch/arm/mach-omap2/board-n810.c |   10 ++++++++++
>  2 files changed, 15 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
> index 072aded..bb6d695 100644
> --- a/arch/arm/mach-omap2/Kconfig
> +++ b/arch/arm/mach-omap2/Kconfig
> @@ -45,6 +45,11 @@ config MACH_NOKIA_N810
>  	bool "Nokia N810"
>  	depends on MACH_NOKIA_N800
>  
> +config MACH_NOKIA_N810_WIMAX
> +	bool "Nokia N810 WiMAX"
> +	depends on MACH_NOKIA_N800
> +	select MACH_NOKIA_N810
> +
>  config MACH_OMAP2_TUSB6010
>  	bool
>  	depends on ARCH_OMAP2 && ARCH_OMAP2420
> diff --git a/arch/arm/mach-omap2/board-n810.c b/arch/arm/mach-omap2/board-n810.c
> index fb0e61f..8609a0b 100644
> --- a/arch/arm/mach-omap2/board-n810.c
> +++ b/arch/arm/mach-omap2/board-n810.c
> @@ -35,3 +35,13 @@ MACHINE_START(NOKIA_N810, "Nokia N810")
>  	.init_machine	= nokia_n810_init,
>  	.timer		= &omap_timer,
>  MACHINE_END
> +
> +MACHINE_START(NOKIA_N810_WIMAX, "Nokia N810 WiMAX")
> +	.phys_io	= 0x48000000,
> +	.io_pg_offst	= ((0xd8000000) >> 18) & 0xfffc,
> +	.boot_params	= 0x80000100,
> +	.map_io		= nokia_n800_map_io,
> +	.init_irq	= nokia_n800_init_irq,
> +	.init_machine	= nokia_n810_init,
> +	.timer		= &omap_timer,
> +MACHINE_END
> -- 
> 1.5.5.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
