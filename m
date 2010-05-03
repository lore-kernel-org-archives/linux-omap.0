From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] OMAP2/3/4: DMA: reset controller during init
Date: Mon, 3 May 2010 09:58:18 -0700
Message-ID: <20100503165817.GR29604@atomide.com>
References: <1272891357-27400-1-git-send-email-ext-mika.1.westerberg@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:63443 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751203Ab0ECQ6S (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 3 May 2010 12:58:18 -0400
Content-Disposition: inline
In-Reply-To: <1272891357-27400-1-git-send-email-ext-mika.1.westerberg@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mika Westerberg <ext-mika.1.westerberg@nokia.com>
Cc: linux-omap@vger.kernel.org

* Mika Westerberg <ext-mika.1.westerberg@nokia.com> [100503 05:52]:
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
> To prevent any weird things happening, we perform soft reset for the controller
> and disable all per channel interrupts.
> 
> Signed-off-by: Mika Westerberg <ext-mika.1.westerberg@nokia.com>
> ---
>  arch/arm/plat-omap/dma.c              |   32 ++++++++++++++++++++++++++++++++
>  arch/arm/plat-omap/include/plat/dma.h |    4 ++++
>  2 files changed, 36 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/plat-omap/dma.c b/arch/arm/plat-omap/dma.c
> index 1d95996..24cbb97 100644
> --- a/arch/arm/plat-omap/dma.c
> +++ b/arch/arm/plat-omap/dma.c
> @@ -2024,6 +2024,31 @@ void omap_dma_global_context_restore(void)
>  
>  /*----------------------------------------------------------------------------*/
>  
> +/**
> + * omap_dma_reset() - perform software reset for the DMA controller
> + */
> +static void omap_dma_reset(void)
> +{
> +	u32 v;
> +
> +	if (cpu_class_is_omap1())
> +		return;
> +
> +	v = dma_read(OCP_SYSCONFIG);
> +	v |= 0x2; /* software reset */
> +	dma_write(v, OCP_SYSCONFIG);
> +
> +	/* wait until reset is complete */
> +	while ((dma_read(SYSSTATUS) & 0x1) == 0)
> +		cpu_relax();

This reset part seems to be mach-omap2 specific.

> +	/* disable per channel interrupts */
> +	dma_write(0, IRQENABLE_L0);
> +	dma_write(0, IRQENABLE_L1);
> +	dma_write(0, IRQENABLE_L2);
> +	dma_write(0, IRQENABLE_L3);
> +}

For a minimal fix, how about just disable the interrupt in omap_clear_dma()?
We are already calling that from omap_init_dma().

Regards,

Tony
