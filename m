From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCHv4 03/20] OMAP: McBSP: Use appropriate value for startup
	delay
Date: Mon, 17 Aug 2009 16:56:33 +0300
Message-ID: <20090817135632.GW7278@atomide.com>
References: <1250509879-6703-1-git-send-email-eduardo.valentin@nokia.com> <1250509879-6703-4-git-send-email-eduardo.valentin@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:51177 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753375AbZHQN4k (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 17 Aug 2009 09:56:40 -0400
Content-Disposition: inline
In-Reply-To: <1250509879-6703-4-git-send-email-eduardo.valentin@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Eduardo Valentin <eduardo.valentin@nokia.com>
Cc: Takashi Iwai <tiwai@suse.de>, Linux-OMAP <linux-omap@vger.kernel.org>, ALSA-Devel <alsa-devel@vger.kernel.org>, Jarkko Nikula <jhnikula@gmail.com>, "Nurkkala Eero.An (EXT-Offcode/Oulu)" <ext-Eero.Nurkkala@nokia.com>, "Ujfalusi Peter (Nokia-D/Tampere)" <peter.ujfalusi@nokia.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>

* Eduardo Valentin <eduardo.valentin@nokia.com> [090817 15:06]:
> From: Eduardo Valentin <eduardo.valentin@nokia.com>

This too is missing a description.

Tony
 
> Signed-off-by: Eduardo Valentin <eduardo.valentin@nokia.com>
> ---
>  arch/arm/plat-omap/mcbsp.c |    8 +++++++-
>  1 files changed, 7 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/plat-omap/mcbsp.c b/arch/arm/plat-omap/mcbsp.c
> index 0aa2524..e9dd703 100644
> --- a/arch/arm/plat-omap/mcbsp.c
> +++ b/arch/arm/plat-omap/mcbsp.c
> @@ -365,7 +365,13 @@ void omap_mcbsp_start(unsigned int id, int tx, int rx)
>  	w = OMAP_MCBSP_READ(io_base, SPCR1);
>  	OMAP_MCBSP_WRITE(io_base, SPCR1, w | (rx & 1));
>  
> -	udelay(100);
> +	/*
> +	 * Worst case: CLKSRG*2 = 8000khz: (1/8000) * 2 * 2 usec
> +	 * REVISIT: 100us may give enough time for two CLKSRG, however
> +	 * due to some unknown PM related, clock gating etc. reason it
> +	 * is now at 500us.
> +	 */
> +	udelay(500);
>  
>  	if (idle) {
>  		/* Start frame sync */
> -- 
> 1.6.2.GIT
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
