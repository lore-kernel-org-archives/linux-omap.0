From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [PATCH 1/2] ARM: McBSP: Fix request for irq in OMAP4
Date: Wed, 5 May 2010 13:29:51 +0300
Message-ID: <20100505132951.48eda979.jhnikula@gmail.com>
References: <1273016270-31452-1-git-send-email-jorge.candelaria@ti.com>
	<1273016270-31452-2-git-send-email-jorge.candelaria@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f222.google.com ([209.85.219.222]:63786 "EHLO
	mail-ew0-f222.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934369Ab0EEK2j (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 May 2010 06:28:39 -0400
Received: by ewy22 with SMTP id 22so1433590ewy.37
        for <linux-omap@vger.kernel.org>; Wed, 05 May 2010 03:28:38 -0700 (PDT)
In-Reply-To: <1273016270-31452-2-git-send-email-jorge.candelaria@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jorge Eduardo Candelaria <jorge.candelaria@ti.com>
Cc: linux-omap@vger.kernel.org

On Tue,  4 May 2010 18:37:49 -0500
Jorge Eduardo Candelaria <jorge.candelaria@ti.com> wrote:

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
> diff --git a/arch/arm/mach-omap2/mcbsp.c b/arch/arm/mach-omap2/mcbsp.c
> index 2f3cad6..6b550ec 100644
> --- a/arch/arm/mach-omap2/mcbsp.c
> +++ b/arch/arm/mach-omap2/mcbsp.c
> @@ -187,32 +187,28 @@ static struct omap_mcbsp_platform_data omap44xx_mcbsp_pdata[] = {
>  		.phys_base      = OMAP44XX_MCBSP1_BASE,
>  		.dma_rx_sync    = OMAP44XX_DMA_MCBSP1_RX,
>  		.dma_tx_sync    = OMAP44XX_DMA_MCBSP1_TX,
> -		.rx_irq         = INT_24XX_MCBSP1_IRQ_RX,
> -		.tx_irq         = INT_24XX_MCBSP1_IRQ_TX,
> +		.tx_irq         = INT_44XX_MCBSP1_IRQ,
>  		.ops            = &omap2_mcbsp_ops,
>  	},

These INT_44XX_MCBSPx appears to be undefined. Commit
5772ca7d7897722e7ed4c476bafee0b07bd9193e is removing them and I don't
find are there somewhere a patch adding them to irqs-44xx.h.


-- 
Jarkko
