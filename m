From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH 2/2] OMAP3: DMA: Errata: sDMA FIFO draining does not finish
Date: Fri, 1 Oct 2010 02:45:12 -0500
Message-ID: <4CA59188.5020904@ti.com>
References: <1285915146-18511-1-git-send-email-peter.ujfalusi@nokia.com> <1285915146-18511-3-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:60111 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752295Ab0JAIVP (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 1 Oct 2010 04:21:15 -0400
In-Reply-To: <1285915146-18511-3-git-send-email-peter.ujfalusi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Cc: Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Jarkko Nikula <jhnikula@gmail.com>, Liam Girdwood <lrg@slimlogic.co.uk>

Peter Ujfalusi had written, on 10/01/2010 01:39 AM, the following:
[...]
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
> ---
>  arch/arm/plat-omap/dma.c              |   35 +++++++++++++++++++++++++++++++-
>  arch/arm/plat-omap/include/plat/dma.h |    3 ++
>  2 files changed, 36 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/plat-omap/dma.c b/arch/arm/plat-omap/dma.c
> index 7115884..590cb47 100644
> --- a/arch/arm/plat-omap/dma.c
> +++ b/arch/arm/plat-omap/dma.c
> @@ -30,6 +30,7 @@
>  #include <linux/irq.h>
>  #include <linux/io.h>
>  #include <linux/slab.h>
> +#include <linux/delay.h>
>  
>  #include <asm/system.h>
>  #include <mach/hardware.h>
> @@ -1018,8 +1019,38 @@ void omap_stop_dma(int lch)
>  		dma_write(0, CICR(lch));
>  
>  	l = dma_read(CCR(lch));
> -	l &= ~OMAP_DMA_CCR_EN;
> -	dma_write(l, CCR(lch));
> +	/* OMAP3 Errata: sDMA FIFO draining does not finish */
would be informative to give the iXYZ id as well for some of these 
erratas might scale across processors.
> +	if (cpu_is_omap34xx() && (l & OMAP_DMA_CCR_SEL_SRC_DST_SYNC)) {

does it make sense to use an dma_errata variable and populate it?
-- 
Regards,
Nishanth Menon
