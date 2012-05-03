From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 4/7] ARM: OMAP: dma: Make use of cpu_class_is_omap2() to avoid future patching.
Date: Thu, 03 May 2012 14:47:53 -0700
Message-ID: <8762cdgcmu.fsf@ti.com>
References: <1335952093-12541-1-git-send-email-santosh.shilimkar@ti.com>
	<1335952093-12541-5-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog125.obsmtp.com ([74.125.149.153]:56711 "EHLO
	na3sys009aog125.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754455Ab2ECVru (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 May 2012 17:47:50 -0400
Received: by pbbrp8 with SMTP id rp8so3004497pbb.19
        for <linux-omap@vger.kernel.org>; Thu, 03 May 2012 14:47:49 -0700 (PDT)
In-Reply-To: <1335952093-12541-5-git-send-email-santosh.shilimkar@ti.com>
	(Santosh Shilimkar's message of "Wed, 2 May 2012 15:18:10 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com

Santosh Shilimkar <santosh.shilimkar@ti.com> writes:

> cpu_class_is_omap2() contains all OMAP2+ devices. So update the DMA code
> cpu checks accordingly so that there is no need to patch
> the file for any future OMAP2+ devices.
>
> In long run, all these attributes should come from hwmod dev_attr based
> on DMA IP version.
>
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> ---
>  arch/arm/mach-omap2/dma.c |    2 +-
>  arch/arm/plat-omap/dma.c  |    4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/dma.c b/arch/arm/mach-omap2/dma.c
> index b19d849..2750bb9 100644
> --- a/arch/arm/mach-omap2/dma.c
> +++ b/arch/arm/mach-omap2/dma.c
> @@ -227,7 +227,7 @@ static int __init omap2_system_dma_init_dev(struct omap_hwmod *oh, void *unused)
>  
>  	dma_stride		= OMAP2_DMA_STRIDE;
>  	dma_common_ch_start	= CSDP;
> -	if (cpu_is_omap3630() || cpu_is_omap44xx())
> +	if (omap_rev() >= OMAP3630_REV_ES1_0)

It's not obvious (at least to me) that this is equivalent.

For example, this will now be true on the TI81xx devices.

Kevin
