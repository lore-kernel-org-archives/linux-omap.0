From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: RE: [PATCH] OMAP: DMA: Add API for setting channel dest addr
Date: Tue, 2 Mar 2010 15:34:34 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02C44C20EC@dbde02.ent.ti.com>
References: <1267524941-15526-1-git-send-email-manjugk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:57670 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752246Ab0CBKEk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 2 Mar 2010 05:04:40 -0500
In-Reply-To: <1267524941-15526-1-git-send-email-manjugk@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "G, Manjunath Kondaiah" <manjugk@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: Tony Lindgren <tony@atomide.com>, "S, Venkatraman" <svenkatr@ti.com>, "Raja, Govindraj" <govindraj.raja@ti.com>

Manju,
Is this patch can build?

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of G,
> Manjunath Kondaiah
> Sent: Tuesday, March 02, 2010 3:46 PM
> To: linux-omap@vger.kernel.org
> Cc: G, Manjunath Kondaiah; Tony Lindgren; S, Venkatraman; Raja, Govindraj
> Subject: [PATCH] OMAP: DMA: Add API for setting channel dest addr
> 
> The new API - omap_set_dma_dst_pos(int lch, int value) is added
> for setting channel destination address in CPC/CDAC register
> 
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: S, Venkatraman <svenkatr@ti.com>
> Signed-off-by: Manjunatha GK <manjugk@ti.com>
> Signed-off-by: Govindraj R <govindraj.raja@ti.com>
> ---
>  arch/arm/plat-omap/dma.c              |   17 +++++++++++++++++
>  arch/arm/plat-omap/include/plat/dma.h |    1 +
>  2 files changed, 18 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/plat-omap/dma.c b/arch/arm/plat-omap/dma.c
> index 2ab224c..9a2a5c4 100644
> --- a/arch/arm/plat-omap/dma.c
> +++ b/arch/arm/plat-omap/dma.c
> @@ -1109,6 +1109,23 @@ dma_addr_t omap_get_dma_dst_pos(int lch)
>  }
>  EXPORT_SYMBOL(omap_get_dma_dst_pos);
> 
> +/**
> + * omap_set_dma_dst_pos() - Set DMA channel destination address
> + * @arg1:  lch      DMA logical channel number
> + * @arg2:  value    Value to write into CDAC register
> + *
> + * Writes "value" into the register CPC/CDAC
> + */
> +void omap_set_dma_dst_pos(int lch, int value)
> +{
> +	if (cpu_is_omap15xx())
> +		dma_write(CPC(lch), value);
> +	else
> +		dma_write(CDAC(lcd), value);
>
Should be "dma_write(CDAC(lch), value);"
> +
> +}
> +EXPORT_SYMBOL(omap_set_dma_dst_pos);
> +
>  int omap_get_dma_active_status(int lch)
>  {
>  	return (dma_read(CCR(lch)) & OMAP_DMA_CCR_EN) != 0;
> diff --git a/arch/arm/plat-omap/include/plat/dma.h b/arch/arm/plat-omap/include/plat/dma.h
> index 02232ca..3b6e43e 100644
> --- a/arch/arm/plat-omap/include/plat/dma.h
> +++ b/arch/arm/plat-omap/include/plat/dma.h
> @@ -509,6 +509,7 @@ extern int omap_set_dma_callback(int lch,
>  			void *data);
>  extern dma_addr_t omap_get_dma_src_pos(int lch);
>  extern dma_addr_t omap_get_dma_dst_pos(int lch);
> +extern void omap_set_dma_dst_pos(int lch, int value);
>  extern void omap_clear_dma(int lch);
>  extern int omap_get_dma_active_status(int lch);
>  extern int omap_dma_running(void);
> --
> 1.6.0.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
