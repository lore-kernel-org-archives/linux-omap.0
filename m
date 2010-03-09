From: "Goucem, Fabrice" <f-goucem@ti.com>
Subject: RE: [PATCH] Add support for packet synchronised sDMA transfers.
Date: Tue, 9 Mar 2010 14:14:36 +0100
Message-ID: <74583B8642AB8841B30447520659FCA9EB8A7F8D@dnce01.ent.ti.com>
References: <1267611658-18946-1-git-send-email-f-goucem@ti.com>
 <2183bec21003030502y4e29d943o49b85cba937922a0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:36360 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750870Ab0CINOl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 9 Mar 2010 08:14:41 -0500
Content-Class: urn:content-classes:message
In-Reply-To: <2183bec21003030502y4e29d943o49b85cba937922a0@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: hari n <hari.zoom@gmail.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi Hari,

Thanks for your comment.
What you're saying is perfectly true, however I find current way is a bit awkward and potentially dangerous if for any reason value of OMAP_DMA_SYNC_PACKET changes in the future, or if more constants are defined later on.

I think proposed patch improves the readability of the code and makes it clearer to developers what DMA synchronisations are supported.

Regards,

Fabrice



Texas Instruments France SA, 821 Avenue Jack Kilby, 06270 Villeneuve Loubet. 036 420 040 R.C.S Antibes. Capital de EUR 753.920

-----Original Message-----

From: hari n [mailto:hari.zoom@gmail.com]
Sent: 03 March 2010 14:03
To: Goucem, Fabrice
Cc: linux-omap@vger.kernel.org
Subject: Re: [PATCH] Add support for packet synchronised sDMA transfers.

I believe, packet mode is already supported in the current DMA driver.
Both the FS and BS bits of the CCR are set when packet mode is selected. This is because, enum for OMAP_DMA_SYNC_PACKET is '0x03'
(i.e OMAP_DMA_SYNC_FRAME | OMAP_DMA_SYNC_BLOCK).


On Wed, Mar 3, 2010 at 4:20 AM, Fabrice Goucem <f-goucem@ti.com> wrote:
> System DMA packet synchronisation is currently not supported in the
> Linux Kernel.
> This patch provides necessary modifications to support packet
> synchronisation:
> Function omap_set_dma_transfer_params() handles value
> OMAP_DMA_SYNC_PACKET to program FS and BS bits of register CCR.
> Users can give the packet size to the DMA driver by using parameters
> src_fi / dst_fi in functions omap_set_dma_src_params() /
> omap_set_dma_dest_params().
>
> Patch has been validated using OMAP's McSPI (on Zoom2, OMAP3430):
> McSPI is configured to use DMA transfer.
> FIFO are activated with a threshold of 16 bytes (i.e. DMA requests
> will be triggered as soon as more than 16 bytes are free in the FIFO).
> A frame of 132 elements (bytes) has been transfered, by packets of 16
> elements. Resulting transfer was 8 packets of 16 elements plus a last
> packet of 4 elements.
>
> Modifications tested building on OMAP2, OMAP3 and OMAP4 configurations.
>
> Signed-off-by: Fabrice Goucem <f-goucem@ti.com>
> Acked-by: Venkatraman S <svenkatr@ti.com>
> Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Acked-by: Shilpa Maddi <s-maddi@ti.com>
> ---
>  arch/arm/plat-omap/dma.c |    6 ++++--
>  1 files changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/plat-omap/dma.c b/arch/arm/plat-omap/dma.c index
> 2ab224c..48f9355 100644
> --- a/arch/arm/plat-omap/dma.c
> +++ b/arch/arm/plat-omap/dma.c
> @@ -293,12 +293,14 @@ void omap_set_dma_transfer_params(int lch, int
> data_type, int elem_count,
>                val |= (dma_trigger & ~0x1f) << 14;
>                val |= dma_trigger & 0x1f;
>
> -               if (sync_mode & OMAP_DMA_SYNC_FRAME)
> +               if ((sync_mode == OMAP_DMA_SYNC_FRAME) ||
> +                   (sync_mode == OMAP_DMA_SYNC_PACKET))
>                        val |= 1 << 5;
>                else
>                        val &= ~(1 << 5);
>
> -               if (sync_mode & OMAP_DMA_SYNC_BLOCK)
> +               if ((sync_mode == OMAP_DMA_SYNC_BLOCK) ||
> +                   (sync_mode == OMAP_DMA_SYNC_PACKET))
>                        val |= 1 << 18;
>                else
>                        val &= ~(1 << 18);
> --
> 1.6.0.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"
> in the body of a message to majordomo@vger.kernel.org More majordomo
> info at  http://vger.kernel.org/majordomo-info.html
>

