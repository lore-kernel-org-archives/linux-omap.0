From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH 01/11] OMAP: DMA: Introduce DMA device attributes
Date: Thu, 29 Jul 2010 14:35:50 +0200
Message-ID: <4C5175A6.5020101@ti.com>
References: <1280397545-27323-1-git-send-email-manjugk@ti.com> <1280397545-27323-2-git-send-email-manjugk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:45678 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757287Ab0G2Mf6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 29 Jul 2010 08:35:58 -0400
In-Reply-To: <1280397545-27323-2-git-send-email-manjugk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "G, Manjunath Kondaiah" <manjugk@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Kevin Hilman <khilman@deeprootsystems.com>, Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>, "Sawant, Anand" <sawant@ti.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "Nayak, Rajendra" <rnayak@ti.com>, "Basak, Partha" <p-basak2@ti.com>, "Varadarajan, Charulatha" <charu@ti.com>

Hi Manjunatha,

I just have a couple of minor comments.

On 7/29/2010 11:58 AM, G, Manjunath Kondaiah wrote:
> This patches introduces OMAP DMA device attributes for using the same in
> DMA platform driver for all OMAP's and HWMOD database(OMAP2PLUS onwards)
>
> Signed-off-by: Manjunatha GK<manjugk@ti.com>
> ---
>   arch/arm/plat-omap/include/plat/dma.h |   22 ++++++++++++++++++++++
>   1 files changed, 22 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/plat-omap/include/plat/dma.h b/arch/arm/plat-omap/include/plat/dma.h
> index 02232ca..ff60f11 100644
> --- a/arch/arm/plat-omap/include/plat/dma.h
> +++ b/arch/arm/plat-omap/include/plat/dma.h
> @@ -398,6 +398,22 @@
>   #define DMA_CH_PRIO_HIGH		0x1
>   #define DMA_CH_PRIO_LOW			0x0 /* Def */
>
> +/* Attributes for OMAP DMA Contrllers */
> +#define ENABLE_1510_MODE		(1<<  0)
> +#define DMA_LINKED_LCH			(1<<  1)
> +#define GLOBAL_PRIORITY			(1<<  2)
> +#define RESERVE_CHANNEL			(1<<  3)
> +#define SRC_PORT			(2<<  3)
> +#define DST_PORT			(2<<  4)
> +#define IS_CSSA_32			(2<<  5)
> +#define IS_CDSA_32			(2<<  6)
> +#define SRC_INDEX			(4<<  6)
> +#define DST_INDEX			(4<<  7)
> +#define IS_BURST_ONLY4			(4<<  8)
> +#define CLEAR_CSR_ON_READ		(4<<  9)
> +#define IS_WORD_16			(8<<  9)
> +#define IS_RW_PRIORIY			(8<<  0xA)

It is a minor detail, but why are you shifting both side of the
operator? It is really confusing, cannot you just do 1 << X?
With 0 < X < 13.

> +
>   enum omap_dma_burst_mode {
>   	OMAP_DMA_DATA_BURST_DIS = 0,
>   	OMAP_DMA_DATA_BURST_4,
> @@ -463,6 +479,12 @@ struct omap_dma_channel_params {
>   #endif
>   };
>
> +struct omap_dma_dev_attr {
> +	u32 dma_dev_attr;

That name is not very meaningful, maybe dma_cap for capability or 
something else will be better.


> +	u16 dma_lch_count;
> +	u16 dma_chan_count;
> +	struct omap_dma_lch *dma_chan;

In general, I think that there are too many "dma_" prefix in that 
structure. It is already inside a dma_XXX struct so I don't think that 
adding an extra prefix to every attribute is needed.

Regards,
Benoit

