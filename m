From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/1] input: lm8323: setting correct value to size_y
Date: Tue, 10 Nov 2009 12:45:57 -0800
Message-ID: <20091110204557.GC23952@atomide.com>
References: <4AE36117.8090601@indt.org.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:54133 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758081AbZKJUpz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 10 Nov 2009 15:45:55 -0500
Content-Disposition: inline
In-Reply-To: <4AE36117.8090601@indt.org.br>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Carlos Aguiar <carlos.aguiar@indt.org.br>
Cc: "Balbi Felipe (Nokia-D/Helsinki)" <felipe.balbi@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

* Carlos Aguiar <carlos.aguiar@indt.org.br> [091024 13:18]:
> From: Carlos Eduardo Aguiar <carlos.aguiar@indt.org.br>
> 
> This simple patch fixes the correct value to plataform parameter size_y.
> 
> Fix needed to make N810 keyboard work properly.
> 
> Signed-off-by: Carlos Eduardo Aguiar <carlos.aguiar@indt.org.br>
> ---
>  arch/arm/mach-omap2/board-n800.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/board-n800.c b/arch/arm/mach-omap2/board-n800.c
> index cb32b61..0a50fd3 100644
> --- a/arch/arm/mach-omap2/board-n800.c
> +++ b/arch/arm/mach-omap2/board-n800.c

Looks like this needs to be refreshed for board-n8x0.c..

Regards,

Tony


> @@ -115,7 +115,7 @@ static struct lm8323_platform_data lm8323_pdata = {
>  	.repeat		= 0, /* Repeat is handled in userspace for now. */
>  	.keymap		= rx44_keymap,
>  	.size_x		= 8,
> -	.size_y		= 8,
> +	.size_y		= 12,
>  	.debounce_time	= 12,
>  	.active_time	= 500,
>  
> -- 1.5.4.3
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
