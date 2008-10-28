From: Adrian Hunter <ext-adrian.hunter@nokia.com>
Subject: Re: [PATCH 1/3] ARM: OMAP: hsmmc requires data reset after data timeout
Date: Tue, 28 Oct 2008 10:58:31 +0200
Message-ID: <4906D437.9000607@nokia.com>
References: <48F7438A.8060706@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:37793 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752118AbYJ1Ivi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 28 Oct 2008 04:51:38 -0400
In-Reply-To: <48F7438A.8060706@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap Mailing List <linux-omap@vger.kernel.org>

Adrian Hunter wrote:
> According to TRM a software reset SRD after data timeout
> is required.
> 
> Signed-off-by: Adrian Hunter <ext-adrian.hunter@nokia.com>
> ---
> drivers/mmc/host/omap_hsmmc.c |    5 +++++
> 1 files changed, 5 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
> index 00b1b68..8fb677e 100644
> --- a/drivers/mmc/host/omap_hsmmc.c
> +++ b/drivers/mmc/host/omap_hsmmc.c
> @@ -417,6 +417,11 @@ static irqreturn_t mmc_omap_irq(int irq, void *dev_id)
>                     mmc_dma_cleanup(host);
>                 else
>                     host->data->error = -EILSEQ;
> +                OMAP_HSMMC_WRITE(host->base, SYSCTL,
> +                    OMAP_HSMMC_READ(host->base,
> +                            SYSCTL) | SRD);
> +                while (OMAP_HSMMC_READ(host->base,
> +                            SYSCTL) & SRD) ;
>                 end_trans = 1;
>             }
>         }

Can this and my other 2 patches be applied?
