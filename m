From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH v2 4/4] OMAP: DMA: Fix: context restore during off mode
Date: Thu, 17 Mar 2011 14:08:34 -0700
Message-ID: <87wrjxwj3h.fsf@ti.com>
References: <1299853215-8507-1-git-send-email-manjugk@ti.com>
	<1299853215-8507-5-git-send-email-manjugk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:59986 "EHLO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755534Ab1CQVIi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 17 Mar 2011 17:08:38 -0400
Received: by mail-iw0-f181.google.com with SMTP id 2so3652560iwn.12
        for <linux-omap@vger.kernel.org>; Thu, 17 Mar 2011 14:08:37 -0700 (PDT)
In-Reply-To: <1299853215-8507-5-git-send-email-manjugk@ti.com> (Manjunath
	Kondaiah G.'s message of "Fri, 11 Mar 2011 19:50:15 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "G, Manjunath Kondaiah" <manjugk@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.arm.linux.org.uk, paul@pwsan.com, tony@atomide.com

"G, Manjunath Kondaiah" <manjugk@ti.com> writes:

> The current DMA context restore clears all the DMA channel registers
> even if the channels are in use. This will result in transfer failures
> if repeated DMA transfers are initiated with one time DMA channel
> configuration.
>
> Also, remove access to sysconfig register during context save/restore
> since it will be handled through hwmod layer.
>
> Tested on OMAP3430 Zoom2 with
>  - off mode enabled
>  - one time DMA channel configuration
>  - repeated DMA transfers
>
> Signed-off-by: G, Manjunath Kondaiah <manjugk@ti.com>

This patch introduces a compiler warning:

/work/kernel/omap/pm/arch/arm/plat-omap/dma.c: In function 'omap_dma_global_context_restore':
/work/kernel/omap/pm/arch/arm/plat-omap/dma.c:2068:6: warning: unused variable 'ch'

because...

> ---
>  arch/arm/plat-omap/dma.c |    7 -------
>  1 files changed, 0 insertions(+), 7 deletions(-)
>
> diff --git a/arch/arm/plat-omap/dma.c b/arch/arm/plat-omap/dma.c
> index 5cca56b..bb0b7e2 100644
> --- a/arch/arm/plat-omap/dma.c
> +++ b/arch/arm/plat-omap/dma.c
> @@ -2059,8 +2059,6 @@ void omap_dma_global_context_save(void)
>  	pm_runtime_get_sync(dev);
>  	omap_dma_global_context.dma_irqenable_l0 =
>  		p->dma_read(IRQENABLE_L0, 0);
> -	omap_dma_global_context.dma_ocp_sysconfig =
> -		p->dma_read(OCP_SYSCONFIG, 0);
>  	omap_dma_global_context.dma_gcr = p->dma_read(GCR, 0);
>  	pm_runtime_put_autosuspend(dev);
>  }
> @@ -2071,17 +2069,12 @@ void omap_dma_global_context_restore(void)
>  
>  	pm_runtime_get_sync(dev);
>  	p->dma_write(omap_dma_global_context.dma_gcr, GCR, 0);
> -	p->dma_write(omap_dma_global_context.dma_ocp_sysconfig,
> -		OCP_SYSCONFIG, 0);
>  	p->dma_write(omap_dma_global_context.dma_irqenable_l0,
>  		IRQENABLE_L0, 0);
>  
>  	if (IS_DMA_ERRATA(DMA_ROMCODE_BUG))
>  		p->dma_write(0x3 , IRQSTATUS_L0, 0);
>  
> -	for (ch = 0; ch < dma_chan_count; ch++)
> -		if (dma_chan[ch].dev_id != -1)
> -			omap_clear_dma(ch);
>  	pm_runtime_put_autosuspend(dev);
>  }

...you removed the usage if 'ch' but not it's declaration.

Kevin



