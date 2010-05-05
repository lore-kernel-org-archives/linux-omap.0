From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 1/2] ARM: McBSP: Fix request for irq in OMAP4
Date: Wed, 05 May 2010 14:16:52 -0700
Message-ID: <87zl0e3v7f.fsf@deeprootsystems.com>
References: <1273016270-31452-1-git-send-email-jorge.candelaria@ti.com>
	<1273016270-31452-2-git-send-email-jorge.candelaria@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f204.google.com ([209.85.222.204]:43416 "EHLO
	mail-pz0-f204.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755595Ab0EEVQz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 May 2010 17:16:55 -0400
Received: by pzk42 with SMTP id 42so1641230pzk.4
        for <linux-omap@vger.kernel.org>; Wed, 05 May 2010 14:16:55 -0700 (PDT)
In-Reply-To: <1273016270-31452-2-git-send-email-jorge.candelaria@ti.com> (Jorge Eduardo Candelaria's message of "Tue\,  4 May 2010 18\:37\:49 -0500")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jorge Eduardo Candelaria <jorge.candelaria@ti.com>
Cc: linux-omap@vger.kernel.org

Jorge Eduardo Candelaria <jorge.candelaria@ti.com> writes:

> In OMAP4, there is only one irq line for TX and RX paths. Use
> the correct irq line to avoid errors at runtime.
>
> Also, request irq line only once (instead of requesting for TX
> and RX).
>
> Signed-off-by: Jorge Eduardo Candelaria <jorge.candelaria@ti.com>
> ---
>  arch/arm/mach-omap2/mcbsp.c |   12 ++++--------
>  arch/arm/plat-omap/mcbsp.c  |   20 ++++++++++++--------
>  2 files changed, 16 insertions(+), 16 deletions(-)
>

[...]

> diff --git a/arch/arm/plat-omap/mcbsp.c b/arch/arm/plat-omap/mcbsp.c
> index e1d0440..6e9660d 100644
> --- a/arch/arm/plat-omap/mcbsp.c
> +++ b/arch/arm/plat-omap/mcbsp.c
> @@ -724,14 +724,17 @@ int omap_mcbsp_request(unsigned int id)
>  			goto err_clk_disable;
>  		}
>  
> -		init_completion(&mcbsp->rx_irq_completion);
> -		err = request_irq(mcbsp->rx_irq, omap_mcbsp_rx_irq_handler,
> +		if (!cpu_is_omap44xx) {

Instead of cpu_is* here, just use 'if (mcbsp->rx_irq)' which will
be more portable in other cases of no RX IRQ.

> +			init_completion(&mcbsp->rx_irq_completion);
> +			err = request_irq(mcbsp->rx_irq,
> +					omap_mcbsp_rx_irq_handler,
>  					0, "McBSP", (void *)mcbsp);
> -		if (err != 0) {
> -			dev_err(mcbsp->dev, "Unable to request RX IRQ %d "
> -					"for McBSP%d\n", mcbsp->rx_irq,
> -					mcbsp->id);
> -			goto err_free_irq;
> +			if (err != 0) {
> +				dev_err(mcbsp->dev, "Unable to request RX IRQ %d "
> +						"for McBSP%d\n", mcbsp->rx_irq,
> +						mcbsp->id);
> +				goto err_free_irq;
> +			}
>  		}
>  	}
>  
> @@ -781,7 +784,8 @@ void omap_mcbsp_free(unsigned int id)
>  
>  	if (mcbsp->io_type == OMAP_MCBSP_IRQ_IO) {
>  		/* Free IRQs */
> -		free_irq(mcbsp->rx_irq, (void *)mcbsp);
> +		if (!cpu_is_omap44xx())

here too

> +			free_irq(mcbsp->rx_irq, (void *)mcbsp);
>  		free_irq(mcbsp->tx_irq, (void *)mcbsp);
>  	}
>  

Kevin
