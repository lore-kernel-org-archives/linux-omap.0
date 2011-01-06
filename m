From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] arm: mach-omap2: mux: fix buffer overrun
Date: Thu, 6 Jan 2011 14:14:03 -0800
Message-ID: <20110106221402.GB7771@atomide.com>
References: <1294245733-4126-1-git-send-email-aaro.koskinen@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:51171 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754201Ab1AFWOK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 6 Jan 2011 17:14:10 -0500
Content-Disposition: inline
In-Reply-To: <1294245733-4126-1-git-send-email-aaro.koskinen@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@nokia.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Aaro Koskinen <aaro.koskinen@nokia.com> [110105 08:39]:
> memcpy() copies 8 bytes too much (omap_mux_entry vs. omap_mux). Correct
> by replacing memcpy() with struct assignment, which is safer.

Thanks will queue as a fix after the merge window.

Tony
 
> Signed-off-by: Aaro Koskinen <aaro.koskinen@nokia.com>
> ---
>  arch/arm/mach-omap2/mux.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/mux.c b/arch/arm/mach-omap2/mux.c
> index 17bd639..df8d2f2 100644
> --- a/arch/arm/mach-omap2/mux.c
> +++ b/arch/arm/mach-omap2/mux.c
> @@ -893,7 +893,7 @@ static struct omap_mux * __init omap_mux_list_add(
>  		return NULL;
>  
>  	m = &entry->mux;
> -	memcpy(m, src, sizeof(struct omap_mux_entry));
> +	entry->mux = *src;
>  
>  #ifdef CONFIG_OMAP_MUX
>  	if (omap_mux_copy_names(src, m)) {
> -- 
> 1.5.6.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
