From: Mika Westerberg <ext-mika.1.westerberg@nokia.com>
Subject: Re: [PATCH] OMAP2/3/4: DMA: reset controller during init
Date: Tue, 11 May 2010 12:27:31 +0300
Message-ID: <20100511092731.GG11783@esdhcp04058.research.nokia.com>
References: <1272891357-27400-1-git-send-email-ext-mika.1.westerberg@nokia.com> <20100503165817.GR29604@atomide.com> <20100504074006.GK12682@esdhcp04058.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:23791 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753454Ab0EKJ3L (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 11 May 2010 05:29:11 -0400
Content-Disposition: inline
In-Reply-To: <20100504074006.GK12682@esdhcp04058.research.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, khilman@deeprootsystems.com

On Tue, May 04, 2010 at 10:40:06AM +0300, Mika Westerberg wrote:
> On Mon, May 03, 2010 at 06:58:18PM +0200, ext Tony Lindgren wrote:
> > * Mika Westerberg <ext-mika.1.westerberg@nokia.com> [100503 05:52]:
> (...)
> > > +/**
> > > + * omap_dma_reset() - perform software reset for the DMA controller
> > > + */
> > > +static void omap_dma_reset(void)
> > > +{
> > > +	u32 v;
> > > +
> > > +	if (cpu_class_is_omap1())
> > > +		return;
> > > +
> > > +	v = dma_read(OCP_SYSCONFIG);
> > > +	v |= 0x2; /* software reset */
> > > +	dma_write(v, OCP_SYSCONFIG);
> > > +
> > > +	/* wait until reset is complete */
> > > +	while ((dma_read(SYSSTATUS) & 0x1) == 0)
> > > +		cpu_relax();
> > 
> > This reset part seems to be mach-omap2 specific.
> > 
> > > +	/* disable per channel interrupts */
> > > +	dma_write(0, IRQENABLE_L0);
> > > +	dma_write(0, IRQENABLE_L1);
> > > +	dma_write(0, IRQENABLE_L2);
> > > +	dma_write(0, IRQENABLE_L3);
> > > +}
> > 
> > For a minimal fix, how about just disable the interrupt in omap_clear_dma()?
> > We are already calling that from omap_init_dma().
> 
> If we do it in omap_clear_dma() then omap_dma_global_context_restore() will
> return with interrupts masked which probably breaks things.
> 
> How about something like following patch?

Tony, Kevin

Any comments on this patch?

Thanks,
MW

> 
> (checking cpu_class_is_omap2() below in omap_init_dma() is probably redundant
>  but seems to be consitent with other code).
> 
> Thanks,
> MW
> 
> >From 74389ff1de06e5adb84b978bf1d169c6d802db1b Mon Sep 17 00:00:00 2001
> From: Mika Westerberg <ext-mika.1.westerberg@nokia.com>
> Date: Tue, 4 May 2010 09:32:29 +0300
> Subject: [PATCH] OMAP2/3/4: DMA: disable channel interrupts in omap_init_dma()
> 
> If we are softbooting another kernel using kexec, DMA controller state is not
> known when we are performing omap_init_dma(). It is possible that some DMA
> channels are already active. For example after kexec we get:
> 
> <4>IRQ 0020 for non-allocated DMAchannel 5
> <4>IRQ 0020 for non-allocated DMAchannel 5
> <4>IRQ 0020 for non-allocated DMAchannel 5
> <4>IRQ 0020 for non-allocated DMAchannel 5
> <4>IRQ 0020 for non-allocated DMAchannel 5
> 
> To prevent any weird things happening, we disable all channel interrupts during
> init.
> 
> Signed-off-by: Mika Westerberg <ext-mika.1.westerberg@nokia.com>
> ---
>  arch/arm/plat-omap/dma.c |   27 +++++++++++++++++++--------
>  1 files changed, 19 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/arm/plat-omap/dma.c b/arch/arm/plat-omap/dma.c
> index 1d95996..ad42ec3 100644
> --- a/arch/arm/plat-omap/dma.c
> +++ b/arch/arm/plat-omap/dma.c
> @@ -709,6 +709,21 @@ static inline void omap2_enable_irq_lch(int lch)
>  	spin_unlock_irqrestore(&dma_chan_lock, flags);
>  }
>  
> +static inline void omap2_disable_irq_lch(int lch)
> +{
> +	u32 val;
> +	unsigned long flags;
> +
> +	if (!cpu_class_is_omap2())
> +		return;
> +
> +	spin_lock_irqsave(&dma_chan_lock, flags);
> +	val = dma_read(IRQENABLE_L0);
> +	val &= ~(1 << lch);
> +	dma_write(val, IRQENABLE_L0);
> +	spin_unlock_irqrestore(&dma_chan_lock, flags);
> +}
> +
>  int omap_request_dma(int dev_id, const char *dev_name,
>  		     void (*callback)(int lch, u16 ch_status, void *data),
>  		     void *data, int *dma_ch_out)
> @@ -807,14 +822,7 @@ void omap_free_dma(int lch)
>  	}
>  
>  	if (cpu_class_is_omap2()) {
> -		u32 val;
> -
> -		spin_lock_irqsave(&dma_chan_lock, flags);
> -		/* Disable interrupts */
> -		val = dma_read(IRQENABLE_L0);
> -		val &= ~(1 << lch);
> -		dma_write(val, IRQENABLE_L0);
> -		spin_unlock_irqrestore(&dma_chan_lock, flags);
> +		omap2_disable_irq_lch(lch);
>  
>  		/* Clear the CSR register and IRQ status register */
>  		dma_write(OMAP2_DMA_CSR_CLEAR_MASK, CSR(lch));
> @@ -2107,6 +2115,9 @@ static int __init omap_init_dma(void)
>  
>  	for (ch = 0; ch < dma_chan_count; ch++) {
>  		omap_clear_dma(ch);
> +		if (cpu_class_is_omap2())
> +			omap2_disable_irq_lch(ch);
> +
>  		dma_chan[ch].dev_id = -1;
>  		dma_chan[ch].next_lch = -1;
>  
> -- 
> 1.5.6.5
