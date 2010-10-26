From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: RE: [PATCH] omap: dma: Add read-back to DMA interrupt handler to
 avoid spurious interrupts
Date: Tue, 26 Oct 2010 11:01:17 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB030D289B05@dbde02.ent.ti.com>
References: <1288017324-2181-1-git-send-email-mathias.nyman@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:38880 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751867Ab0JZFb0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 26 Oct 2010 01:31:26 -0400
In-Reply-To: <1288017324-2181-1-git-send-email-mathias.nyman@nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mathias Nyman <mathias.nyman@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Mathias Nyman
> Sent: Monday, October 25, 2010 8:05 PM
> To: linux-omap@vger.kernel.org
> Cc: Mathias Nyman
> Subject: [PATCH] omap: dma: Add read-back to DMA interrupt handler to
> avoid spurious interrupts
> 
> Flush the writes to IRQSTATUS_L0 register in the DMA interrupt handler by
> reading the register
> directly after write. This prevents the spurious DMA interrupts noted when
> using VDD_OPP 1
>
Good fix Mathias.
Actually we should also clear other status lines as well when
used with multiple master initiator scenario's. But that need some
additional fixes as well. 

> Signed-off-by: Mathias Nyman <mathias.nyman@nokia.com>

Acked-by: Santosh Shilimkar <Santosh.shilimkar@ti.com>

> ---
>  arch/arm/plat-omap/dma.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/plat-omap/dma.c b/arch/arm/plat-omap/dma.c
> index f5c5b8d..2c28265 100644
> --- a/arch/arm/plat-omap/dma.c
> +++ b/arch/arm/plat-omap/dma.c
> @@ -1983,6 +1983,8 @@ static int omap2_dma_handle_ch(int ch)
> 
>  	dma_write(OMAP2_DMA_CSR_CLEAR_MASK, CSR(ch));
>  	dma_write(1 << ch, IRQSTATUS_L0);
> +	/* read back the register to flush the write */
> +	dma_read(IRQSTATUS_L0);
> 
>  	/* If the ch is not chained then chain_id will be -1 */
>  	if (dma_chan[ch].chain_id != -1) {
> --
> 1.5.6.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
