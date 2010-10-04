From: "G, Manjunath Kondaiah" <manjugk@ti.com>
Subject: RE: [PATCH v4 4/4] OMAP3: DMA: Errata i541: sDMA FIFO draining does
 not finish
Date: Mon, 4 Oct 2010 14:47:41 +0530
Message-ID: <E0D41E29EB0DAC4E9F3FF173962E9E9402DB90CA49@dbde02.ent.ti.com>
References: <1286180294-32618-1-git-send-email-peter.ujfalusi@nokia.com>
 <1286180294-32618-5-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:42163 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752814Ab0JDJRx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 4 Oct 2010 05:17:53 -0400
In-Reply-To: <1286180294-32618-5-git-send-email-peter.ujfalusi@nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@nokia.com>, Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Jarkko Nikula <jhnikula@gmail.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>



> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org 
> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Peter Ujfalusi
> Sent: Monday, October 04, 2010 1:48 PM
> To: Tony Lindgren
> Cc: linux-omap@vger.kernel.org; Jarkko Nikula; 
> linux-arm-kernel@lists.infradead.org
> Subject: [PATCH v4 4/4] OMAP3: DMA: Errata i541: sDMA FIFO 
> draining does not finish
>
...
> +	/* OMAP3 Errata i541: sDMA FIFO draining does not finish */

This logic is required for multiple erratas. Can we have seperate
function for handling this logic. More details at:
https://patchwork.kernel.org/patch/126271/

...

> --- a/arch/arm/plat-omap/include/plat/dma.h
> +++ b/arch/arm/plat-omap/include/plat/dma.h
> @@ -335,6 +335,9 @@
>  #define OMAP2_DMA_MISALIGNED_ERR_IRQ	(1 << 11)
>  
>  #define OMAP_DMA_CCR_EN			(1 << 7)
> +#define OMAP_DMA_CCR_RD_ACTIVE		(1 << 9)
> +#define OMAP_DMA_CCR_WR_ACTIVE		(1 << 10)
> +#define OMAP_DMA_CCR_SEL_SRC_DST_SYNC	(1 << 24)
>  #define OMAP_DMA_CCR_BUFFERING_DISABLE	(1 << 25)

As I mentioned in other mail, if you are introducing this feature,
it is better to convert existing erratas also to use this feature.

-Manjunath