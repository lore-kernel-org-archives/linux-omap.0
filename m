From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP: board-omap3beagle: fix merge-damage in RTC
	code
Date: Fri, 16 May 2008 08:32:22 -0700
Message-ID: <20080516153221.GD23002@atomide.com>
References: <1210836883-7409-1-git-send-email-koen@openembedded.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-bos.mailhop.org ([63.208.196.179]:49308 "EHLO
	mho-02-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751954AbYEPPcV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 May 2008 11:32:21 -0400
Content-Disposition: inline
In-Reply-To: <1210836883-7409-1-git-send-email-koen@openembedded.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Koen Kooi <koen@openembedded.org>
Cc: linux-omap@vger.kernel.org

* Koen Kooi <koen@openembedded.org> [080515 00:36]:
> This patch fixes the merge-damage in the beagleboard RTC code

Heh, this should teach you to not trust me to merge patches manually! :)

Pushing today.

Tony

> Signed-off-by: Koen Kooi <koen@openembedded.org>
> ---
>  arch/arm/mach-omap2/board-omap3beagle.c |    3 +--
>  1 files changed, 1 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
> index 0c15ca0..0c0cbfc 100644
> --- a/arch/arm/mach-omap2/board-omap3beagle.c
> +++ b/arch/arm/mach-omap2/board-omap3beagle.c
> @@ -76,6 +76,7 @@ static struct platform_device *omap3_beagle_devices[] __initdata = {
>  
>  static void __init omap3_beagle_init(void)
>  {
> +	platform_add_devices(omap3_beagle_devices, ARRAY_SIZE(omap3_beagle_devices));
>  	omap_board_config = omap3_beagle_config;
>  	omap_board_config_size = ARRAY_SIZE(omap3_beagle_config);
>  	omap_serial_init();
> @@ -88,8 +89,6 @@ arch_initcall(omap3_beagle_i2c_init);
>  
>  static void __init omap3_beagle_map_io(void)
>  {
> -	platform_add_devices(omap3_beagle_devices,
> -				ARRAY_SIZE(omap3_beagle_devices));
>  	omap2_set_globals_343x();
>  	omap2_map_common_io();
>  }
> -- 
> 1.5.4.3
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
