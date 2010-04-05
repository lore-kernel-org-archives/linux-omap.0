From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: RE: [PATCH] dma: fix scope of errata i88 upto 3430ES1.0
Date: Mon, 5 Apr 2010 19:56:13 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02C4C33347@dbde02.ent.ti.com>
References: <w2g618f0c911004020435qd281c5deoc3e0ade84cc2d0b1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:53922 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754880Ab0DEO0U convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 5 Apr 2010 10:26:20 -0400
In-Reply-To: <w2g618f0c911004020435qd281c5deoc3e0ade84cc2d0b1@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "S, Venkatraman" <svenkatr@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Gopinath, Thara" <thara@ti.com>, Tony Lindgren <tony@atomide.com>

Venkat,
> -----Original Message-----
> From: svenkatr@gmail.com [mailto:svenkatr@gmail.com] On Behalf Of S, Venkatraman
> Sent: Friday, April 02, 2010 5:05 PM
> To: linux-omap@vger.kernel.org
> Cc: Gopinath, Thara; Tony Lindgren; Shilimkar, Santosh
> Subject: [PATCH] dma: fix scope of errata i88 upto 3430ES1.0
> 
> DMA errata for special end of block programming is applicable
> only for OMAP2430 & OMAP3430 ES1.0.
> This patch does the necessary checks before the workaround
> is applied. Tested on 3430 SDP
> 
> Signed-off-by: Thara Gopinath <thara@ti.com>
> Signed-off-by: Venkatraman S <svenkatr@ti.com>
> ---
>  arch/arm/plat-omap/dma.c |   22 ++++++++++++++--------
>  1 files changed, 14 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/arm/plat-omap/dma.c b/arch/arm/plat-omap/dma.c
> index 2ab224c..ef965ac 100644
> --- a/arch/arm/plat-omap/dma.c
> +++ b/arch/arm/plat-omap/dma.c
> @@ -1663,14 +1663,18 @@ int omap_stop_dma_chain_transfers(int chain_id)
>  	channels = dma_linked_lch[chain_id].linked_dmach_q;
> 
>  	/*
> -	 * DMA Errata:
> -	 * Special programming model needed to disable DMA before end of block
> +	 * DMA Errata: i88
> +	 * Special programming model needed
> +	 * to disable DMA before end of block
>  	 */
>  	sys_cf = dma_read(OCP_SYSCONFIG);
> -	l = sys_cf;
> -	/* Middle mode reg set no Standby */
> -	l &= ~((1 << 12)|(1 << 13));
> -	dma_write(l, OCP_SYSCONFIG);
> +	if (cpu_is_omap2430() || (cpu_is_omap3430() &&
> +			omap_rev() == OMAP3430_REV_ES1_0)) {
Since the Errata is applicable only for "omap2430" and
"OMAP3430 ES1.0", below should be enough, isn't it ?

if (cpu_is_omap2430() || omap_rev() == OMAP3430_REV_ES1_0))

> +		l = sys_cf;
> +		/* Middle mode reg set no Standby */
> +		l &= ~((1 << 12)|(1 << 13));
> +		dma_write(l, OCP_SYSCONFIG);
> +	}
> 
>  	for (i = 0; i < dma_linked_lch[chain_id].no_of_lchs_linked; i++) {
> 
> @@ -1689,8 +1693,10 @@ int omap_stop_dma_chain_transfers(int chain_id)
>  	/* Reset the Queue pointers */
>  	OMAP_DMA_CHAIN_QINIT(chain_id);
> 
> -	/* Errata - put in the old value */
> -	dma_write(sys_cf, OCP_SYSCONFIG);
> +	/* Errata: put back the old value */
> +	if (cpu_is_omap2430() || (cpu_is_omap3430() &&
> +			omap_rev() == OMAP3430_REV_ES1_0))
Same as above comment.
> +		dma_write(sys_cf, OCP_SYSCONFIG);
> 
>  	return 0;
>  }
After fixing above two, the patch is fine with me.
> --
> 1.6.3.3
