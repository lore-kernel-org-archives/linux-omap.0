From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] omap_hsmmc: Flush posted write to IRQ
Date: Mon, 6 Apr 2009 09:49:18 -0700
Message-ID: <20090406164917.GA30724@atomide.com>
References: <49D9EF0F.9090808@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:59885 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751461AbZDFQt3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 6 Apr 2009 12:49:29 -0400
Content-Disposition: inline
In-Reply-To: <49D9EF0F.9090808@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Adrian Hunter <adrian.hunter@nokia.com>
Cc: Pierre Ossman <drzeus-mmc@drzeus.cx>, LKML <linux-kernel@vger.kernel.org>, Kevin Hilman <khilman@deeprootsystems.com>, linux-omap Mailing List <linux-omap@vger.kernel.org>

* Adrian Hunter <adrian.hunter@nokia.com> [090406 05:00]:
> From: Kevin Hilman <khilman@deeprootsystems.com>
>
> Spurious IRQs seen on MMC after 2.6.29.  Flush posted write in IRQ
> handler.
>
> The interrupt line is released by clearing the error status bits
> in the MMCHS_STAT register, which must occur before the interrupt
> handler returns to avoid unwanted irqs.  Hence the need to flush
> the posted write.
>
> Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
> Signed-off-by: Adrian Hunter <adrian.hunter@nokia.com>

Acked-by: Tony Lindgen <tony@atomide.com>

> ---
>
>
>
>
> This patch is slightly modified from Kevin's original, which is
> here:
>
> 	http://marc.info/?l=linux-omap&m=123862814815052&w=2
>
>
>
> drivers/mmc/host/omap_hsmmc.c |    4 ++++
> 1 files changed, 4 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
> index 04e5a0c..2ae6049 100644
> --- a/drivers/mmc/host/omap_hsmmc.c
> +++ b/drivers/mmc/host/omap_hsmmc.c
> @@ -452,6 +452,8 @@ static irqreturn_t mmc_omap_irq(int irq, void *dev_id)
> 	if (host->mrq == NULL) {
> 		OMAP_HSMMC_WRITE(host->base, STAT,
> 			OMAP_HSMMC_READ(host->base, STAT));
> +		/* Flush posted write */
> +		OMAP_HSMMC_READ(host->base, STAT);
> 		return IRQ_HANDLED;
> 	}
>
> @@ -523,6 +525,8 @@ static irqreturn_t mmc_omap_irq(int irq, void *dev_id)
> 	}
>
> 	OMAP_HSMMC_WRITE(host->base, STAT, status);
> +	/* Flush posted write */
> +	OMAP_HSMMC_READ(host->base, STAT);
>
> 	if (end_cmd || (status & CC))
> 		mmc_omap_cmd_done(host, host->cmd);
> -- 
> 1.5.6.3
