From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 2/8] OMAP: hwmod: warn on missing clockdomain
Date: Wed, 18 Nov 2009 04:07:23 -0700 (MST)
Message-ID: <alpine.DEB.2.00.0911180404050.25515@utopia.booyaka.com>
References: <1258506313-17115-1-git-send-email-khilman@deeprootsystems.com> <1258506313-17115-2-git-send-email-khilman@deeprootsystems.com> <1258506313-17115-3-git-send-email-khilman@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:34954 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750961AbZKRLHS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 18 Nov 2009 06:07:18 -0500
In-Reply-To: <1258506313-17115-3-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-omap@vger.kernel.org

Hi Kevin

On Tue, 17 Nov 2009, Kevin Hilman wrote:

> WARN if a clock/hwmod is missing a clockdomain association since
> resulting hwmod will not be able to correctly enable/disable clocks.

Wouldn't this check be best placed in the clock code?  

> 
> Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
> ---
>  arch/arm/mach-omap2/omap_hwmod.c |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
> index 633b216..7d7b3b8 100644
> --- a/arch/arm/mach-omap2/omap_hwmod.c
> +++ b/arch/arm/mach-omap2/omap_hwmod.c
> @@ -326,6 +326,9 @@ static int _init_main_clk(struct omap_hwmod *oh)
>  		ret = -EINVAL;
>  	oh->_clk = c;
>  
> +	WARN(!c->clkdm, "omap_hwmod: %s: missing clockdomain for %s.\n",
> +	     oh->clkdev_con_id, c->name);
> +
>  	return ret;
>  }
>  
> -- 
> 1.6.5.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


- Paul
