From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/4 v2] arm: omap: tao3530: Add pdata-quirk for the mmc2
 internal clock
Date: Mon, 8 Sep 2014 17:09:59 -0700
Message-ID: <20140909000959.GA10785@atomide.com>
References: <1409308806-27036-1-git-send-email-sr@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:20164 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754506AbaIIAKJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 8 Sep 2014 20:10:09 -0400
Content-Disposition: inline
In-Reply-To: <1409308806-27036-1-git-send-email-sr@denx.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Stefan Roese <sr@denx.de>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Thorsten Eisbein <thorsten.eisbein@head-acoustics.de>, Tapani Utriainen <tapani@technexion.com>

* Stefan Roese <sr@denx.de> [140829 03:40]:
> Set internal clock source for MMC2 on tao3530.
> 
> Signed-off-by: Stefan Roese <sr@denx.de>
> Cc: Thorsten Eisbein <thorsten.eisbein@head-acoustics.de>
> Cc: Tapani Utriainen <tapani@technexion.com>
> Cc: Tony Lindgren <tony@atomide.com>
> ---
> v2:
> - Patch description added to commit text

Applying all into omap-for-v3.18/dt thanks.

Tony
 
>  arch/arm/mach-omap2/pdata-quirks.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/arm/mach-omap2/pdata-quirks.c b/arch/arm/mach-omap2/pdata-quirks.c
> index 90c88d4..b9d091b 100644
> --- a/arch/arm/mach-omap2/pdata-quirks.c
> +++ b/arch/arm/mach-omap2/pdata-quirks.c
> @@ -253,6 +253,11 @@ static void __init nokia_n900_legacy_init(void)
>  
>  	}
>  }
> +
> +static void __init omap3_tao3530_legacy_init(void)
> +{
> +	hsmmc2_internal_input_clk();
> +}
>  #endif /* CONFIG_ARCH_OMAP3 */
>  
>  #ifdef CONFIG_ARCH_OMAP4
> @@ -377,6 +382,7 @@ static struct pdata_init pdata_quirks[] __initdata = {
>  	{ "ti,omap3-evm-37xx", omap3_evm_legacy_init, },
>  	{ "ti,omap3-zoom3", omap3_zoom_legacy_init, },
>  	{ "ti,am3517-evm", am3517_evm_legacy_init, },
> +	{ "technexion,omap3-tao3530", omap3_tao3530_legacy_init, },
>  #endif
>  #ifdef CONFIG_ARCH_OMAP4
>  	{ "ti,omap4-sdp", omap4_sdp_legacy_init, },
> -- 
> 2.1.0
> 
