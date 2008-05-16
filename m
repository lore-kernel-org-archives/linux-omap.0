From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 3/3] N800: Select tcm825x only if wanted
Date: Fri, 16 May 2008 10:44:54 -0700
Message-ID: <20080516174454.GO23002@atomide.com>
References: <482AD555.40905@nokia.com> <12107667331990-git-send-email-sakari.ailus@nokia.com> <12107667331986-git-send-email-sakari.ailus@nokia.com> <12107667332796-git-send-email-sakari.ailus@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:61996 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759514AbYEPRow (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 May 2008 13:44:52 -0400
Content-Disposition: inline
In-Reply-To: <12107667332796-git-send-email-sakari.ailus@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sakari Ailus <sakari.ailus@nokia.com>
Cc: linux-omap@vger.kernel.org

* Sakari Ailus <sakari.ailus@nokia.com> [080514 06:36]:
> Don't enable automatically TCM825x on N800 unless
> VIDEO_HELPER_CHIPS_AUTO is selected.

Pushing.

Tony


> Signed-off-by: Sakari Ailus <sakari.ailus@nokia.com>
> ---
>  arch/arm/mach-omap2/Kconfig |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
> index 5c229cc..94beff0 100644
> --- a/arch/arm/mach-omap2/Kconfig
> +++ b/arch/arm/mach-omap2/Kconfig
> @@ -35,7 +35,7 @@ config MACH_OMAP_GENERIC
>  config MACH_NOKIA_N800
>  	bool "Nokia N800"
>  	depends on ARCH_OMAP2420
> -	select VIDEO_TCM825X if VIDEO_OMAP2
> +	select VIDEO_TCM825X if VIDEO_OMAP2 && VIDEO_HELPER_CHIPS_AUTO
>  	select CBUS if VIDEO_TCM825X
>  	select CBUS_RETU if VIDEO_TCM825X
>  	select MENELAUS if VIDEO_TCM825X
> -- 
> 1.5.0.6
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
