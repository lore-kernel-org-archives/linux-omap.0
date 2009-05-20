From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH] OMAP: PM: Clear DMA channel state after a wakeup
Date: Wed, 20 May 2009 07:26:01 -0700
Message-ID: <871vqju9za.fsf@deeprootsystems.com>
References: <1242827910-16136-1-git-send-email-aaro.koskinen@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.172]:10275 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753013AbZETO0E (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 20 May 2009 10:26:04 -0400
Received: by wf-out-1314.google.com with SMTP id 26so155244wfd.4
        for <linux-omap@vger.kernel.org>; Wed, 20 May 2009 07:26:06 -0700 (PDT)
In-Reply-To: <1242827910-16136-1-git-send-email-aaro.koskinen@nokia.com> (Aaro Koskinen's message of "Wed\, 20 May 2009 16\:58\:30 +0300")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@nokia.com>
Cc: linux-omap@vger.kernel.org

Aaro Koskinen <aaro.koskinen@nokia.com> writes:

> Clear DMA channel states so that users can assume a known initial state.
>
> Signed-off-by: Aaro Koskinen <aaro.koskinen@nokia.com>

Thanks, pushing to PM branch.

Kevin

> ---
>  arch/arm/plat-omap/dma.c |    6 ++++++
>  1 files changed, 6 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/plat-omap/dma.c b/arch/arm/plat-omap/dma.c
> index 9796773..cd53b28 100755
> --- a/arch/arm/plat-omap/dma.c
> +++ b/arch/arm/plat-omap/dma.c
> @@ -2322,6 +2322,8 @@ EXPORT_SYMBOL(omap_dma_global_context_save);
>  
>  void omap_dma_global_context_restore(void)
>  {
> +	int ch;
> +
>  	dma_write(omap_dma_global_context.dma_gcr, GCR);
>  	dma_write(omap_dma_global_context.dma_ocp_sysconfig,
>  		OCP_SYSCONFIG);
> @@ -2336,6 +2338,10 @@ void omap_dma_global_context_restore(void)
>  	 */
>  	if (cpu_is_omap34xx() && (omap_type() != OMAP2_DEVICE_TYPE_GP))
>  		dma_write(0x3 , IRQSTATUS_L0);
> +
> +	for (ch = 0; ch < dma_chan_count; ch++)
> +		if (dma_chan[ch].dev_id != -1)
> +			omap_clear_dma(ch);
>  }
>  EXPORT_SYMBOL(omap_dma_global_context_restore);
>  
> -- 
> 1.5.4.3
