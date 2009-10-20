From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: RE: [PATCH v2] ARM: OMAP: SDMA: Fix omap_stop_dma() API for	channel
 linking
Date: Tue, 20 Oct 2009 11:59:24 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02BB37DB76@dbde02.ent.ti.com>
References: <1255590416-11550-1-git-send-email-santosh.shilimkar@ti.com>
 <20091019172339.GR12576@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:34629 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750843AbZJTG30 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 20 Oct 2009 02:29:26 -0400
In-Reply-To: <20091019172339.GR12576@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "S, Venkatraman" <svenkatr@ti.com>, Hari n <hari.zoom@gmail.com>, Jarkko Nikula <jhnikula@gmail.com>

Tony,
> -----Original Message-----
> From: Tony Lindgren [mailto:tony@atomide.com]
> Sent: Monday, October 19, 2009 10:54 PM
> To: Shilimkar, Santosh
> Cc: linux-omap@vger.kernel.org; S, Venkatraman; Hari n; Jarkko
> Nikula
> Subject: Re: [PATCH v2] ARM: OMAP: SDMA: Fix omap_stop_dma() API for
> channel linking
> 
> * Santosh Shilimkar <santosh.shilimkar@ti.com> [091015 00:07]:
> > OMAP sDMA driver API omap_stop_dma() doesn't really stop the dma
> when used
> > in linking scenario. This patch fixes the same.
> >
> > Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> > Signed-off-by: Venkatraman S <svenkatr@ti.com>
> > Reviewed-By: Tony Lindgren <tony@atomide.com>
> > CC: Hari n <hari.zoom@gmail.com>
> > CC: Jarkko Nikula <jhnikula@gmail.com>
> > ---
> >  arch/arm/plat-omap/dma.c |    5 +++++
> >  1 files changed, 5 insertions(+), 0 deletions(-)
> >
> > diff --git a/arch/arm/plat-omap/dma.c b/arch/arm/plat-omap/dma.c
> > index fd3154a..1c933b4 100644
> > --- a/arch/arm/plat-omap/dma.c
> > +++ b/arch/arm/plat-omap/dma.c
> > @@ -987,6 +987,11 @@ void omap_stop_dma(int lch)
> >  			/* Mark the current channel */
> >  			dma_chan_link_map[cur_lch] = 1;
> >
> > +			/* Disable the DMA channel */
> > +			l = dma_read(CCR(lch));
> > +			l &= ~OMAP_DMA_CCR_EN;
> > +			dma_write(l, CCR(lch));
> > +
> >  			disable_lnk(cur_lch);
> >
> >  			next_lch = dma_chan[cur_lch].next_lch;
> 
> Hmm, I'm thinking it should be like this instead to also clear
> the dma_chan[lch].flags instead of returning before that.
> 
> Can you try this with your testcase?
This works too. OMAP1 doesn't support channel linking so this is fine. In case it was, then it would have been an issue.

> diff --git a/arch/arm/plat-omap/dma.c b/arch/arm/plat-omap/dma.c
> index 0eb676d..b53125f 100644
> --- a/arch/arm/plat-omap/dma.c
> +++ b/arch/arm/plat-omap/dma.c
> @@ -978,6 +978,14 @@ void omap_stop_dma(int lch)
>  {
>  	u32 l;
> 
> +	/* Disable all interrupts on the channel */
> +	if (cpu_class_is_omap1())
> +		dma_write(0, CICR(lch));
> +
> +	l = dma_read(CCR(lch));
> +	l &= ~OMAP_DMA_CCR_EN;
> +	dma_write(l, CCR(lch));
> +
>  	if (!omap_dma_in_1510_mode() && dma_chan[lch].next_lch != -1)
> {
>  		int next_lch, cur_lch = lch;
>  		char dma_chan_link_map[OMAP_DMA4_LOGICAL_DMA_CH_COUNT];
> @@ -995,18 +1003,8 @@ void omap_stop_dma(int lch)
>  			next_lch = dma_chan[cur_lch].next_lch;
>  			cur_lch = next_lch;
>  		} while (next_lch != -1);
> -
> -		return;
>  	}
> 
> -	/* Disable all interrupts on the channel */
> -	if (cpu_class_is_omap1())
> -		dma_write(0, CICR(lch));
> -
> -	l = dma_read(CCR(lch));
> -	l &= ~OMAP_DMA_CCR_EN;
> -	dma_write(l, CCR(lch));
> -
>  	dma_chan[lch].flags &= ~OMAP_DMA_ACTIVE;
>  }
>  EXPORT_SYMBOL(omap_stop_dma);

