From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH v3 03/13] OMAP: DMA: Introduce DMA device attributes
Date: Tue, 09 Nov 2010 13:46:53 -0800
Message-ID: <87iq06mape.fsf@deeprootsystems.com>
References: <1288099513-1854-1-git-send-email-manjugk@ti.com>
	<1288099513-1854-4-git-send-email-manjugk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:37884 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753708Ab0KIVq6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 9 Nov 2010 16:46:58 -0500
Received: by gyh4 with SMTP id 4so4724090gyh.19
        for <linux-omap@vger.kernel.org>; Tue, 09 Nov 2010 13:46:57 -0800 (PST)
In-Reply-To: <1288099513-1854-4-git-send-email-manjugk@ti.com> (Manjunath
	Kondaiah G.'s message of "Tue, 26 Oct 2010 18:55:03 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "G, Manjunath Kondaiah" <manjugk@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Benoit Cousson <b-cousson@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>

"G, Manjunath Kondaiah" <manjugk@ti.com> writes:

> This patch introduces OMAP DMA device attributes for using the same in
> DMA platform driver for all OMAP's and HWMOD database(OMAP2PLUS onwards)
>
> Signed-off-by: G, Manjunath Kondaiah <manjugk@ti.com>
> Cc: Benoit Cousson <b-cousson@ti.com>
> Cc: Kevin Hilman <khilman@deeprootsystems.com>
> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
> ---
>  arch/arm/plat-omap/include/plat/dma.h |   20 ++++++++++++++++++++
>  1 files changed, 20 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/plat-omap/include/plat/dma.h b/arch/arm/plat-omap/include/plat/dma.h
> index 5e28d26..9757b22 100644
> --- a/arch/arm/plat-omap/include/plat/dma.h
> +++ b/arch/arm/plat-omap/include/plat/dma.h
> @@ -296,6 +296,22 @@
>  #define DMA_ERRATA_i88			(1 << 4)
>  #define DMA_ERRATA_3_3			(1 << 5)
>  
> +/* Attributes for OMAP DMA Contrllers */
> +#define ENABLE_1510_MODE		(1 << 0x0)
> +#define DMA_LINKED_LCH			(1 << 0x1)
> +#define GLOBAL_PRIORITY			(1 << 0x2)
> +#define RESERVE_CHANNEL			(1 << 0x3)
> +#define SRC_PORT			(1 << 0x4)
> +#define DST_PORT			(1 << 0x5)
> +#define IS_CSSA_32			(1 << 0x6)
> +#define IS_CDSA_32			(1 << 0x7)
> +#define SRC_INDEX			(1 << 0x8)
> +#define DST_INDEX			(1 << 0x9)
> +#define IS_BURST_ONLY4			(1 << 0xA)
> +#define CLEAR_CSR_ON_READ		(1 << 0xB)
> +#define IS_WORD_16			(1 << 0xC)
> +#define IS_RW_PRIORITY			(1 << 0xD)

Please use BIT() for these.

>  enum omap_dma_burst_mode {
>  	OMAP_DMA_DATA_BURST_DIS = 0,
>  	OMAP_DMA_DATA_BURST_4,
> @@ -361,6 +377,10 @@ struct omap_dma_channel_params {
>  #endif
>  };
>  
> +struct omap_dma_dev_attr {
> +	u32 dev_caps;
> +	u16 lch_count;
> +};
>  
>  extern void omap_set_dma_priority(int lch, int dst_port, int priority);
>  extern int omap_request_dma(int dev_id, const char *dev_name,

Kevin
