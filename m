From: "G, Manjunath Kondaiah" <manjugk@ti.com>
Subject: RE: [PATCH v4 1/4] omap: dma: Fix buffering disable bit setting for
 omap24xx
Date: Mon, 4 Oct 2010 14:44:28 +0530
Message-ID: <E0D41E29EB0DAC4E9F3FF173962E9E9402DB90CA39@dbde02.ent.ti.com>
References: <1286180294-32618-1-git-send-email-peter.ujfalusi@nokia.com>
 <1286180294-32618-2-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:41887 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753115Ab0JDJOl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 4 Oct 2010 05:14:41 -0400
In-Reply-To: <1286180294-32618-2-git-send-email-peter.ujfalusi@nokia.com>
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
> Subject: [PATCH v4 1/4] omap: dma: Fix buffering disable bit 
> setting for omap24xx
> 
> From: ext Jarkko Nikula <jhnikula@gmail.com>
> 
> An errata workaround for omap24xx is not setting the 
> buffering disable bit
> 25 what is the purpose but channel enable bit 7 instead.

...

> diff --git a/arch/arm/plat-omap/dma.c 
> b/arch/arm/plat-omap/dma.c index ec7eddf..6914ccf 100644
> --- a/arch/arm/plat-omap/dma.c
> +++ b/arch/arm/plat-omap/dma.c
> @@ -999,8 +999,9 @@ void omap_start_dma(int lch)
>  	 * Errata: On ES2.0 BUFFERING disable must be set.
>  	 * This will always fail on ES1.0
>  	 */

Sorry, I didn't catch this with earlier patch.

Looks like wrong comment. only on 2430ES1.0 and for all omap2420, 
buffer disable should be set. 
I feel below description will be useful to the reader:
"Errata: Inter Frame DMA buffering issue(All OMAP2420 and OMAP2430ES1.0):
DMA will wrongly buffer elements if packing and bursting is enabled.
This might result in data gets stalled in FIFO at the end of the block.
Workaround: DMA channels must have BUFFERING_DISABLED bit set to guarantee
no data will stay in the DMA FIFO in case inter frame buffering occurs.


-Manjunath