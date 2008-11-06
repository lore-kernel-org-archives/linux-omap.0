From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] OMAP3 flash: fix use of system_rev in
	board-3430sdp-flash.c
Date: Thu, 6 Nov 2008 08:58:16 -0800
Message-ID: <20081106165816.GS21736@atomide.com>
References: <20081106122630.32272.71026.stgit@localhost.localdomain> <20081106122633.32272.65124.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:52364 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753153AbYKFQ6S (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 6 Nov 2008 11:58:18 -0500
Content-Disposition: inline
In-Reply-To: <20081106122633.32272.65124.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, Timo-Pekka Launonen <ext-timo-pekka.launonen@nokia.com>, Lauri Leukkunen <lauri.leukkunen@nokia.com>

* Paul Walmsley <paul@pwsan.com> [081106 04:28]:
> Fix one remaining user of system_rev.  This patch is needed for
> 3430SDP ES2 to boot after 4a4ada55c1bdaa2b9fd1293611b55ceba14b13e7.
> 
> Bisected by Timo-Pekka Launonen's <ext-timo-pekka.launonen@nokia.com>
> list robot.

Nice to have that robot! :) Pushing.

Tony

> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> Cc: Timo-Pekka Launonen <ext-timo-pekka.launonen@nokia.com>
> Cc: Lauri Leukkunen <lauri.leukkunen@nokia.com>
> ---
>  arch/arm/mach-omap2/board-3430sdp-flash.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/board-3430sdp-flash.c b/arch/arm/mach-omap2/board-3430sdp-flash.c
> index 6b0419c..51dd839 100644
> --- a/arch/arm/mach-omap2/board-3430sdp-flash.c
> +++ b/arch/arm/mach-omap2/board-3430sdp-flash.c
> @@ -210,7 +210,7 @@ void __init sdp3430_flash_init(void)
>  	gpmc_base_add   = OMAP34XX_GPMC_VIRT;
>  
>  	/* Configure start address and size of NOR device */
> -	if (system_rev > OMAP3430_REV_ES1_0) {
> +	if (omap_rev() > OMAP3430_REV_ES1_0) {
>  		sdp_nor_resource.start	= FLASH_BASE_SDPV2;
>  		sdp_nor_resource.end	= FLASH_BASE_SDPV2
>  						+ FLASH_SIZE_SDPV2 - 1;
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
