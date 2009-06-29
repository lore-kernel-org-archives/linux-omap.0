From: "Kamat, Nishant" <nskamat@ti.com>
Subject: RE: [PATCH] OMAP2/3: DMA errata correction
Date: Mon, 29 Jun 2009 06:21:01 -0500
Message-ID: <DFEF307E035C8647B119E6A60DB62D4A0199C96043@dlee02.ent.ti.com>
References: <1245995252-16453-1-git-send-email-vikram.pandita@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:60185 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751621AbZF2LVN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 29 Jun 2009 07:21:13 -0400
Received: from dlep34.itg.ti.com ([157.170.170.115])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id n5TBLBNC020265
	for <linux-omap@vger.kernel.org>; Mon, 29 Jun 2009 06:21:16 -0500
Received: from dlep20.itg.ti.com (localhost [127.0.0.1])
	by dlep34.itg.ti.com (8.13.7/8.13.7) with ESMTP id n5TBLADF026460
	for <linux-omap@vger.kernel.org>; Mon, 29 Jun 2009 06:21:10 -0500 (CDT)
Received: from dsbe71.ent.ti.com (localhost [127.0.0.1])
	by dlep20.itg.ti.com (8.12.11/8.12.11) with ESMTP id n5TBLArb018671
	for <linux-omap@vger.kernel.org>; Mon, 29 Jun 2009 06:21:10 -0500 (CDT)
In-Reply-To: <1245995252-16453-1-git-send-email-vikram.pandita@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Pandita, Vikram" <vikram.pandita@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Vikram,
 

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org 
> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Pandita, Vikram
> Sent: Friday, June 26, 2009 11:18 AM
> To: linux-omap@vger.kernel.org
> Cc: Pandita, Vikram
> Subject: [PATCH] OMAP2/3: DMA errata correction
> 
> This errata is valid for:
> OMAP2420 Errata 1.85 Impacts all 2420 ES rev
> OMAP2430 Errata 1.10 Impacts only ES1.0
> Description: DMA may hang when several channels are used in parallel
> 
> OMAP3430: Not impacted, so remove the errata fix for omap3
> 
> Signed-off-by: Vikram Pandita <vikram.pandita@ti.com>
> ---
>  arch/arm/plat-omap/dma.c |    4 +++-
>  1 files changed, 3 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/plat-omap/dma.c b/arch/arm/plat-omap/dma.c
> index 7677a4a..feebaf3 100644
> --- a/arch/arm/plat-omap/dma.c
> +++ b/arch/arm/plat-omap/dma.c
> @@ -946,7 +946,9 @@ void omap_start_dma(int lch)
>  
>  			cur_lch = next_lch;
>  		} while (next_lch != -1);
> -	} else if (cpu_class_is_omap2()) {
> +	} else if (cpu_is_omap24xx() ||


This should be  cpu_is_omap242x() || ...


Regards,
Nishant




> +		(cpu_is_omap243x() &&  omap_type() <= 
> OMAP2430_REV_ES1_0)) {
> +
>  		/* Errata: Need to write lch even if not using 
> chaining */
>  		dma_write(lch, CLNK_CTRL(lch));
>  	}
> -- 
> 1.6.3.3.334.g916e1
