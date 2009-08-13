From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH v2] OMAP2/3: DMA errata correction
Date: Thu, 13 Aug 2009 07:18:15 -0700
Message-ID: <871vnfkdaw.fsf@deeprootsystems.com>
References: <1250128880-1517-1-git-send-email-vikram.pandita@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f196.google.com ([209.85.216.196]:39752 "EHLO
	mail-px0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751869AbZHMOSQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 13 Aug 2009 10:18:16 -0400
Received: by pxi34 with SMTP id 34so38654pxi.4
        for <linux-omap@vger.kernel.org>; Thu, 13 Aug 2009 07:18:18 -0700 (PDT)
In-Reply-To: <1250128880-1517-1-git-send-email-vikram.pandita@ti.com> (Vikram Pandita's message of "Wed\, 12 Aug 2009 21\:01\:20 -0500")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vikram Pandita <vikram.pandita@ti.com>
Cc: linux-omap@vger.kernel.org

Vikram Pandita <vikram.pandita@ti.com> writes:

> This errata is valid for:
> OMAP2420 Errata 1.85 Impacts all 2420 ES rev
> OMAP2430 Errata 1.10 Impacts only ES1.0
> Description: DMA may hang when several channels are used in parallel
>
> OMAP3430: Not impacted, so remove the errata fix for omap3
>
> Signed-off-by: Vikram Pandita <vikram.pandita@ti.com>
> Reviewed-by: Kamat, Nishant <nskamat@ti.com>

Acked-by: Kevin Hilman <khilman@deeprootsystems.com>

> ---
> [Note: Respin of - 
> http://patchwork.kernel.org/patch/32513/
> Incorporated Nishant's review comment]
>  arch/arm/plat-omap/dma.c |    4 +++-
>  1 files changed, 3 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/plat-omap/dma.c b/arch/arm/plat-omap/dma.c
> index 34939bf..bf08634 100644
> --- a/arch/arm/plat-omap/dma.c
> +++ b/arch/arm/plat-omap/dma.c
> @@ -946,7 +946,9 @@ void omap_start_dma(int lch)
>  
>  			cur_lch = next_lch;
>  		} while (next_lch != -1);
> -	} else if (cpu_class_is_omap2()) {
> +	} else if (cpu_is_omap242x() ||
> +		(cpu_is_omap243x() &&  omap_type() <= OMAP2430_REV_ES1_0)) {
> +
>  		/* Errata: Need to write lch even if not using chaining */
>  		dma_write(lch, CLNK_CTRL(lch));
>  	}
> -- 
> 1.6.3.3.334.g916e1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
