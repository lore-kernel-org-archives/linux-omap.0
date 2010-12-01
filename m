From: "G, Manjunath Kondaiah" <manjugk@ti.com>
Subject: Re: [PATCH 1/2] OMAP: DMA: prevent races while setting M idle mode
 to nostandby
Date: Thu, 2 Dec 2010 00:41:54 +0530
Message-ID: <20101201191154.GB8149@GLPP-machine>
References: <20101130132341.13286.25157.sendpatchset@ahunter-work.research.nokia.com>
 <20101130132347.13286.40388.sendpatchset@ahunter-work.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:40353 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753890Ab0LATLW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 1 Dec 2010 14:11:22 -0500
Received: by yxn35 with SMTP id 35so29091yxn.11
        for <linux-omap@vger.kernel.org>; Wed, 01 Dec 2010 11:11:21 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20101130132347.13286.40388.sendpatchset@ahunter-work.research.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Adrian Hunter <adrian.hunter@nokia.com>
Cc: Tony Lindgren <tony@atomide.com>, Santosh Shilimkar <Santosh.shilimkar@ti.com>, linux-omap Mailing List <linux-omap@vger.kernel.org>

Hi Adrian,

* Adrian Hunter <adrian.hunter@nokia.com> [2010-11-30 15:23:47 +0200]:

> From 8c0f4490d93b67326ff24f6ce1c7e925b08d96b3 Mon Sep 17 00:00:00 2001
> From: Adrian Hunter <adrian.hunter@nokia.com>
> Date: Mon, 22 Nov 2010 11:32:48 +0200
> Subject: [PATCH 1/2] OMAP: DMA: prevent races while setting M idle mode to nostandby
> 
> In a couple of OMAP errata cases, sDMA M idle mode must be
> set temporarily to nostandby.  If two DMA users were to do
> that at the same time, a race condition would arise.
> Prevent that by using a spin lock and counting up/down the
> number of times nostandby is set/reset.
> 
> Signed-off-by: Adrian Hunter <adrian.hunter@nokia.com>
> ---
>  arch/arm/plat-omap/dma.c |   59 ++++++++++++++++++++++++++++++++++-----------
>  1 files changed, 44 insertions(+), 15 deletions(-)
> 
> diff --git a/arch/arm/plat-omap/dma.c b/arch/arm/plat-omap/dma.c
> index a863f55..6158c99 100644
> --- a/arch/arm/plat-omap/dma.c
> +++ b/arch/arm/plat-omap/dma.c
> @@ -139,6 +139,9 @@ static spinlock_t dma_chan_lock;
>  static struct omap_dma_lch *dma_chan;
>  static void __iomem *omap_dma_base;
>  
> +static u32 midlemode_saved;
> +static int midlemode_save_cnt;
> +
>  static const u8 omap1_dma_irq[OMAP1_LOGICAL_DMA_CH_COUNT] = {
>  	INT_DMA_CH0_6, INT_DMA_CH1_7, INT_DMA_CH2_8, INT_DMA_CH3,
>  	INT_DMA_CH4, INT_DMA_CH5, INT_1610_DMA_CH6, INT_1610_DMA_CH7,
> @@ -1016,6 +1019,41 @@ void omap_start_dma(int lch)
>  }
>  EXPORT_SYMBOL(omap_start_dma);
>  
> +static void midlemode_nostandby(void)
> +{
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&dma_chan_lock, flags);
> +	if (!midlemode_save_cnt) {
> +		u32 l;
> +
> +		midlemode_saved = dma_read(OCP_SYSCONFIG);
> +		l = midlemode_saved;
> +		l &= ~DMA_SYSCONFIG_MIDLEMODE_MASK;
> +		l |= DMA_SYSCONFIG_MIDLEMODE(DMA_IDLEMODE_NO_IDLE);
> +		dma_write(l, OCP_SYSCONFIG);
> +	}
> +	midlemode_save_cnt += 1;
> +	spin_unlock_irqrestore(&dma_chan_lock, flags);

The latest DMA hwmod patch series is already taken care of this
issue through the API's:
https://patchwork.kernel.org/patch/372231/

-Manjunath
[...]
