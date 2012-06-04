From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Subject: Re: [PATCH v2] omap: dma: Clear status registers on enable/disable irq.
Date: Mon, 04 Jun 2012 23:53:06 +0200
Message-ID: <2491206.Xgf8oVG38F@acer>
References: <1337117708-27215-1-git-send-email-oleg.matcovschi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from d1.icnet.pl ([212.160.220.21]:53280 "EHLO d1.icnet.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756985Ab2FDV5Q (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 4 Jun 2012 17:57:16 -0400
In-Reply-To: <1337117708-27215-1-git-send-email-oleg.matcovschi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Oleg Matcovschi <oleg.matcovschi@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com, linux@arm.linux.org.uk, jarkko.nikula@bitmer.com

On Tue, 15 May 2012 14:35:08 Oleg Matcovschi wrote:
> Use omap_disable_channel_irq() function instead of directly accessing CICR.
> The omap_disable_chanel_irq() function clears pending interrupts
> and disables interrupt on channel.
> Functions omap2_enable_irq_lch()/omap2_disable_irq_lch() clear interrupt
> status register.
> 
> 
> Signed-off-by: Oleg Matcovschi <oleg.matcovschi@ti.com>
> ---
> v1 initial revision
> v2 Review by Tony Lindgren

My Tested-by: on OMAP1 still valid for v2 if you care.

Thanks,
Janusz

> ---
>  arch/arm/plat-omap/dma.c |   59 +++++++++++++++++++++------------------------
>  1 files changed, 28 insertions(+), 31 deletions(-)
> 
> diff --git a/arch/arm/plat-omap/dma.c b/arch/arm/plat-omap/dma.c
> index 3ec7ec5..3d5d593 100644
> --- a/arch/arm/plat-omap/dma.c
> +++ b/arch/arm/plat-omap/dma.c
> @@ -563,22 +563,25 @@ EXPORT_SYMBOL(omap_set_dma_dest_burst_mode);
>  
>  static inline void omap_enable_channel_irq(int lch)
>  {
> -	u32 status;
> -
>  	/* Clear CSR */
>  	if (cpu_class_is_omap1())
> -		status = p->dma_read(CSR, lch);
> -	else if (cpu_class_is_omap2())
> +		p->dma_read(CSR, lch);
> +	else
>  		p->dma_write(OMAP2_DMA_CSR_CLEAR_MASK, CSR, lch);
>  
>  	/* Enable some nice interrupts. */
>  	p->dma_write(dma_chan[lch].enabled_irqs, CICR, lch);
>  }
>  
> -static void omap_disable_channel_irq(int lch)
> +static inline void omap_disable_channel_irq(int lch)
>  {
> -	if (cpu_class_is_omap2())
> -		p->dma_write(0, CICR, lch);
> +	/* disable channel interrupts */
> +	p->dma_write(0, CICR, lch);
> +	/* Clear CSR */
> +	if (cpu_class_is_omap1())
> +		p->dma_read(CSR, lch);
> +	else
> +		p->dma_write(OMAP2_DMA_CSR_CLEAR_MASK, CSR, lch);
>  }
>  
>  void omap_enable_dma_irq(int lch, u16 bits)
> @@ -622,14 +625,14 @@ static inline void disable_lnk(int lch)
>  	l = p->dma_read(CLNK_CTRL, lch);
>  
>  	/* Disable interrupts */
> +	omap_disable_channel_irq(lch);
> +
>  	if (cpu_class_is_omap1()) {
> -		p->dma_write(0, CICR, lch);
>  		/* Set the STOP_LNK bit */
>  		l |= 1 << 14;
>  	}
>  
>  	if (cpu_class_is_omap2()) {
> -		omap_disable_channel_irq(lch);
>  		/* Clear the ENABLE_LNK bit */
>  		l &= ~(1 << 15);
>  	}
> @@ -647,6 +650,9 @@ static inline void omap2_enable_irq_lch(int lch)
>  		return;
>  
>  	spin_lock_irqsave(&dma_chan_lock, flags);
> +	/* clear IRQ STATUS */
> +	p->dma_write(1 << lch, IRQSTATUS_L0, lch);
> +	/* Enable interrupt */
>  	val = p->dma_read(IRQENABLE_L0, lch);
>  	val |= 1 << lch;
>  	p->dma_write(val, IRQENABLE_L0, lch);
> @@ -662,9 +668,12 @@ static inline void omap2_disable_irq_lch(int lch)
>  		return;
>  
>  	spin_lock_irqsave(&dma_chan_lock, flags);
> +	/* Disable interrupt */
>  	val = p->dma_read(IRQENABLE_L0, lch);
>  	val &= ~(1 << lch);
>  	p->dma_write(val, IRQENABLE_L0, lch);
> +	/* clear IRQ STATUS */
> +	p->dma_write(1 << lch, IRQSTATUS_L0, lch);
>  	spin_unlock_irqrestore(&dma_chan_lock, flags);
>  }
>  
> @@ -735,11 +744,8 @@ int omap_request_dma(int dev_id, const char *dev_name,
>  	}
>  
>  	if (cpu_class_is_omap2()) {
> -		omap2_enable_irq_lch(free_ch);
>  		omap_enable_channel_irq(free_ch);
> -		/* Clear the CSR register and IRQ status register */
> -		p->dma_write(OMAP2_DMA_CSR_CLEAR_MASK, CSR, free_ch);
> -		p->dma_write(1 << free_ch, IRQSTATUS_L0, 0);
> +		omap2_enable_irq_lch(free_ch);
>  	}
>  
>  	*dma_ch_out = free_ch;
> @@ -758,27 +764,19 @@ void omap_free_dma(int lch)
>  		return;
>  	}
>  
> -	if (cpu_class_is_omap1()) {
> -		/* Disable all DMA interrupts for the channel. */
> -		p->dma_write(0, CICR, lch);
> -		/* Make sure the DMA transfer is stopped. */
> -		p->dma_write(0, CCR, lch);
> -	}
> -
> -	if (cpu_class_is_omap2()) {
> +	/* Disable interrupt for logical channel */
> +	if (cpu_class_is_omap2())
>  		omap2_disable_irq_lch(lch);
>  
> -		/* Clear the CSR register and IRQ status register */
> -		p->dma_write(OMAP2_DMA_CSR_CLEAR_MASK, CSR, lch);
> -		p->dma_write(1 << lch, IRQSTATUS_L0, lch);
> +	/* Disable all DMA interrupts for the channel. */
> +	omap_disable_channel_irq(lch);
>  
> -		/* Disable all DMA interrupts for the channel. */
> -		p->dma_write(0, CICR, lch);
> +	/* Make sure the DMA transfer is stopped. */
> +	p->dma_write(0, CCR, lch);
>  
> -		/* Make sure the DMA transfer is stopped. */
> -		p->dma_write(0, CCR, lch);
> +	/* Clear registers */
> +	if (cpu_class_is_omap2())
>  		omap_clear_dma(lch);
> -	}
>  
>  	spin_lock_irqsave(&dma_chan_lock, flags);
>  	dma_chan[lch].dev_id = -1;
> @@ -926,8 +924,7 @@ void omap_stop_dma(int lch)
>  	u32 l;
>  
>  	/* Disable all interrupts on the channel */
> -	if (cpu_class_is_omap1())
> -		p->dma_write(0, CICR, lch);
> +	omap_disable_channel_irq(lch);
>  
>  	l = p->dma_read(CCR, lch);
>  	if (IS_DMA_ERRATA(DMA_ERRATA_i541) &&
> 
