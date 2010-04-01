From: "G, Manjunath Kondaiah" <manjugk@ti.com>
Subject: RE: [PATCH v2] OMAP: DMA: Init CDAC to zero
Date: Thu, 1 Apr 2010 17:51:20 +0530
Message-ID: <E0D41E29EB0DAC4E9F3FF173962E9E94026F323D4F@dbde02.ent.ti.com>
References: <1267667139-17599-1-git-send-email-manjugk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:39087 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755962Ab0DAMV3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 1 Apr 2010 08:21:29 -0400
In-Reply-To: <1267667139-17599-1-git-send-email-manjugk@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: Tony Lindgren <tony@atomide.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "Raja, Govindraj" <govindraj.raja@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>

Hi Tony,
If there are no further comments on below patches, can you please
push the patches

https://patchwork.kernel.org/patch/83540/
https://patchwork.kernel.org/patch/83541/

-Manjunath 

> -----Original Message-----
> From: G, Manjunath Kondaiah 
> Sent: Thursday, March 04, 2010 7:46 AM
> To: linux-omap@vger.kernel.org
> Cc: G, Manjunath Kondaiah; Tony Lindgren; Shilimkar, Santosh; 
> Raja, Govindraj; Kevin Hilman
> Subject: [PATCH v2] OMAP: DMA: Init CDAC to zero
> 
> The register DMA4_CDAC needs to be initialized to zero
> before starting DMA transfer.
> 
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Cc: Govindraj R <govindraj.raja@ti.com>
> Cc: Kevin Hilman <khilman@deeprootsystems.com>
> Reported-by:S, Venkatraman <svenkatr@ti.com>
> Signed-off-by: Manjunatha GK <manjugk@ti.com>
> ---
> It was aligned to reset CDAC to zero in omap_start_dma(int lch)
> instead of creating new API for accessing CDAC register.
> 
> Discussion thread is at:
> http://patchwork.kernel.org/patch/83176/
> http://patchwork.kernel.org/patch/82948/
> 
> v2 changes:
> Fixed multiline comments as per CodingStyle
> 
>  arch/arm/plat-omap/dma.c |    9 +++++++++
>  1 files changed, 9 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/plat-omap/dma.c b/arch/arm/plat-omap/dma.c
> index 2ab224c..f6c9bdc 100644
> --- a/arch/arm/plat-omap/dma.c
> +++ b/arch/arm/plat-omap/dma.c
> @@ -936,6 +936,15 @@ void omap_start_dma(int lch)
>  {
>  	u32 l;
>  
> +	/*
> +	 * The CPC/CDAC register needs to be initialized to zero
> +	 * before starting dma transfer.
> +	 */
> +	if (cpu_is_omap15xx())
> +		dma_write(0, CPC(lch));
> +	else
> +		dma_write(0, CDAC(lch));
> +
>  	if (!omap_dma_in_1510_mode() && dma_chan[lch].next_lch != -1) {
>  		int next_lch, cur_lch;
>  		char dma_chan_link_map[OMAP_DMA4_LOGICAL_DMA_CH_COUNT];
> -- 
> 1.6.3.3
> 
> 