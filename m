From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] OMAP3 GPTIMER: fix GPTIMER12 IRQ
Date: Fri, 8 Aug 2008 12:06:24 +0300
Message-ID: <20080808090624.GO24923@atomide.com>
References: <alpine.DEB.1.00.0808080256150.21853@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:63579 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752073AbYHHJG0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 8 Aug 2008 05:06:26 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0808080256150.21853@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org

* Paul Walmsley <paul@pwsan.com> [080808 11:57]:
> 
> GPTIMER12 IRQ is at IRQ 95 on OMAP3, unlike OMAP2.  (ref: OMAP34xx
> Multimedia High Security (HS) Device Silicon Revision 3.0 Security
> Addendum Rev. B, SWPU119B)

That probably explains why it did not work earlier :) Pushing today.

Tony

> 
> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> ---
> 
>  arch/arm/plat-omap/dmtimer.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtimer.c
> index f22506a..fcc1a02 100644
> --- a/arch/arm/plat-omap/dmtimer.c
> +++ b/arch/arm/plat-omap/dmtimer.c
> @@ -237,7 +237,7 @@ static struct omap_dm_timer omap3_dm_timers[] = {
>  	{ .phys_base = 0x49040000, .irq = INT_24XX_GPTIMER9 },
>  	{ .phys_base = 0x48086000, .irq = INT_24XX_GPTIMER10 },
>  	{ .phys_base = 0x48088000, .irq = INT_24XX_GPTIMER11 },
> -	{ .phys_base = 0x48304000, .irq = INT_24XX_GPTIMER12 },
> +	{ .phys_base = 0x48304000, .irq = INT_34XX_GPT12_IRQ },
>  };
>  
>  static const char *omap3_dm_source_names[] __initdata = {
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
