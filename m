From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP: Fixes to omap_mcbsp_request function
Date: Wed, 24 Sep 2008 12:11:09 +0300
Message-ID: <20080924091109.GJ5222@atomide.com>
References: <1221831398-10700-1-git-send-email-jarkko.nikula@nokia.com> <1222091271-22546-1-git-send-email-jarkko.nikula@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:53509 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751467AbYIXJLO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 24 Sep 2008 05:11:14 -0400
Content-Disposition: inline
In-Reply-To: <1222091271-22546-1-git-send-email-jarkko.nikula@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@nokia.com>
Cc: linux-omap@vger.kernel.org

* Jarkko Nikula <jarkko.nikula@nokia.com> [080922 16:48]:
> Bootloader may let McBSP logic running so make sure that block is idle
> before requesting IRQs. Also make sure that TX and RX waitqueues are
> initialized before request_irq.

Pushing today and adding to upstream queue for RMK.

Tony

> Signed-off-by: Jarkko Nikula <jarkko.nikula@nokia.com>
> ---
>  arch/arm/plat-omap/mcbsp.c |   13 +++++++++----
>  1 files changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/plat-omap/mcbsp.c b/arch/arm/plat-omap/mcbsp.c
> index 7d32437..798c91e 100644
> --- a/arch/arm/plat-omap/mcbsp.c
> +++ b/arch/arm/plat-omap/mcbsp.c
> @@ -234,8 +234,16 @@ int omap_mcbsp_request(unsigned int id)
>  	mcbsp->free = 0;
>  	spin_unlock(&mcbsp->lock);
>  
> +	/*
> +	 * Make sure that transmitter, receiver and sample-rate generator are
> +	 * not running before activating IRQs.
> +	 */
> +	OMAP_MCBSP_WRITE(mcbsp->io_base, SPCR1, 0);
> +	OMAP_MCBSP_WRITE(mcbsp->io_base, SPCR2, 0);
> +
>  	if (mcbsp->io_type == OMAP_MCBSP_IRQ_IO) {
>  		/* We need to get IRQs here */
> +		init_completion(&mcbsp->tx_irq_completion);
>  		err = request_irq(mcbsp->tx_irq, omap_mcbsp_tx_irq_handler,
>  					0, "McBSP", (void *)mcbsp);
>  		if (err != 0) {
> @@ -245,8 +253,7 @@ int omap_mcbsp_request(unsigned int id)
>  			return err;
>  		}
>  
> -		init_completion(&mcbsp->tx_irq_completion);
> -
> +		init_completion(&mcbsp->rx_irq_completion);
>  		err = request_irq(mcbsp->rx_irq, omap_mcbsp_rx_irq_handler,
>  					0, "McBSP", (void *)mcbsp);
>  		if (err != 0) {
> @@ -256,8 +263,6 @@ int omap_mcbsp_request(unsigned int id)
>  			free_irq(mcbsp->tx_irq, (void *)mcbsp);
>  			return err;
>  		}
> -
> -		init_completion(&mcbsp->rx_irq_completion);
>  	}
>  
>  	return 0;
> -- 
> 1.5.6.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
