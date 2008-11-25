From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH] ASoC: Fix TW4030 Kconfig dependency
Date: Mon, 24 Nov 2008 20:44:13 -0800
Message-ID: <200811242044.13438.david-b@pacbell.net>
References: <1227587172-9523-1-git-send-email-arunks@mistralsolutions.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp124.sbc.mail.sp1.yahoo.com ([69.147.64.97]:31562 "HELO
	smtp124.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753200AbYKYEoP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 24 Nov 2008 23:44:15 -0500
In-Reply-To: <1227587172-9523-1-git-send-email-arunks@mistralsolutions.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: arunks@mistralsolutions.com
Cc: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, steve@sakoman.com

On Monday 24 November 2008, arunks@mistralsolutions.com wrote:
> From: Arun KS <arunks@mistralsolutions.com>
> 
> Fixes Kconfig dependency of TWL4030 audio codec driver
> with TWL4030 core driver on both overo and omap2evm
> boards
> 
> Signed-off-by: Arun KS <arunks@mistralsolutions.com>

Good idea.  :)

Acked-by: David Brownell <dbrownell@users.sourceforge.net>


> ---
>  sound/soc/omap/Kconfig |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/soc/omap/Kconfig b/sound/soc/omap/Kconfig
> index 6c56277..0900437 100644
> --- a/sound/soc/omap/Kconfig
> +++ b/sound/soc/omap/Kconfig
> @@ -24,7 +24,7 @@ config SND_OMAP_SOC_OSK5912
>  
>  config SND_OMAP_SOC_OVERO
>  	tristate "SoC Audio support for Gumstix Overo"
> -	depends on SND_OMAP_SOC && MACH_OVERO
> +	depends on TWL4030_CORE && SND_OMAP_SOC && MACH_OVERO
>  	select SND_OMAP_SOC_MCBSP
>  	select SND_SOC_TWL4030
>  	help
> @@ -32,7 +32,7 @@ config SND_OMAP_SOC_OVERO
>  
>  config SND_OMAP_SOC_OMAP2EVM
>  	tristate "SoC Audio support for OMAP2EVM board"
> -	depends on SND_OMAP_SOC && MACH_OMAP2EVM
> +	depends on TWL4030_CORE && SND_OMAP_SOC && MACH_OMAP2EVM
>  	select SND_OMAP_SOC_MCBSP
>  	select SND_SOC_TWL4030
>  	help
> -- 
> 1.5.6.3
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 


