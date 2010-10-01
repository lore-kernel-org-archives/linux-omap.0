From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v3 2/2] OMAP3: DMA: Errata: sDMA FIFO draining does not
 finish
Date: Fri, 1 Oct 2010 09:55:42 -0700
Message-ID: <20101001165542.GS3117@atomide.com>
References: <1285936577-14881-1-git-send-email-peter.ujfalusi@nokia.com>
 <1285936577-14881-3-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:52997 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752784Ab0JAQzq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 Oct 2010 12:55:46 -0400
Content-Disposition: inline
In-Reply-To: <1285936577-14881-3-git-send-email-peter.ujfalusi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Cc: linux-omap@vger.kernel.org, Jarkko Nikula <jhnikula@gmail.com>, Liam Girdwood <lrg@slimlogic.co.uk>

* Peter Ujfalusi <peter.ujfalusi@nokia.com> [101001 05:27]:
>
> --- a/arch/arm/plat-omap/dma.c
> +++ b/arch/arm/plat-omap/dma.c
> @@ -1018,8 +1019,39 @@ void omap_stop_dma(int lch)
>  		dma_write(0, CICR(lch));
>  
>  	l = dma_read(CCR(lch));
> -	l &= ~OMAP_DMA_CCR_EN;
> -	dma_write(l, CCR(lch));
> +	/* OMAP3 Errata i541: sDMA FIFO draining does not finish */
> +	if (cpu_is_omap34xx() && (l & OMAP_DMA_CCR_SEL_SRC_DST_SYNC)) {
> +		int i = 0;
> +		u32 sys_cf;
> +
> +		/* Configure No-Standby */
> +		l = dma_read(OCP_SYSCONFIG);
> +		sys_cf = l;
> +		l &= ~DMA_SYSCONFIG_MIDLEMODE_MASK;
> +		l |= DMA_SYSCONFIG_MIDLEMODE(DMA_IDLEMODE_NO_IDLE);
> +		dma_write(l , OCP_SYSCONFIG);
> +
> +		l = dma_read(CCR(lch));
> +		l &= ~OMAP_DMA_CCR_EN;
> +		dma_write(l, CCR(lch));
> +
> +		/* Wait for sDMA FIFO drain */
> +		l = dma_read(CCR(lch));
> +		while (i < 100 && (l & (OMAP_DMA_CCR_RD_ACTIVE |
> +					OMAP_DMA_CCR_WR_ACTIVE))) {
> +			udelay(5);
> +			i++;
> +			l = dma_read(CCR(lch));
> +		}
> +		if (i >= 100)
> +			printk(KERN_ERR "DMA drain did not completed on "
> +					"lch %d\n", lch);
> +		/* Restore OCP_SYSCONFIG */
> +		dma_write(sys_cf, OCP_SYSCONFIG);
> +	} else {
> +		l &= ~OMAP_DMA_CCR_EN;
> +		dma_write(l, CCR(lch));
> +	}
>  
>  	if (!omap_dma_in_1510_mode() && dma_chan[lch].next_lch != -1) {
>  		int next_lch, cur_lch = lch;

Thinking about moving to use dmaengine.c, we should not use
cpu_is_omapxxxx except during the platform init.

Can you please change this to be in u32 flags in dma.c that get set during
the init only for omap3? Then we can have something like:

#define OMAP_DMA_ERRATA_AAA	(1 << 2)
#define OMAP_DMA_ERRATA_BBB	(1 << 0)
...

Regards,

Tony
