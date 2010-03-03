From: hari n <hari.zoom@gmail.com>
Subject: Re: [PATCH] Add support for packet synchronised sDMA transfers.
Date: Wed, 3 Mar 2010 07:02:40 -0600
Message-ID: <2183bec21003030502y4e29d943o49b85cba937922a0@mail.gmail.com>
References: <1267611658-18946-1-git-send-email-f-goucem@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f46.google.com ([74.125.82.46]:40742 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753815Ab0CCNCo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 3 Mar 2010 08:02:44 -0500
Received: by wwa36 with SMTP id 36so745685wwa.19
        for <linux-omap@vger.kernel.org>; Wed, 03 Mar 2010 05:02:41 -0800 (PST)
In-Reply-To: <1267611658-18946-1-git-send-email-f-goucem@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Fabrice Goucem <f-goucem@ti.com>
Cc: linux-omap@vger.kernel.org

I believe, packet mode is already supported in the current DMA driver.
Both the FS and BS bits of the CCR are set when packet mode is
selected. This is because, enum for OMAP_DMA_SYNC_PACKET is '0x03'
(i.e OMAP_DMA_SYNC_FRAME | OMAP_DMA_SYNC_BLOCK).


On Wed, Mar 3, 2010 at 4:20 AM, Fabrice Goucem <f-goucem@ti.com> wrote:
> System DMA packet synchronisation is currently not supported in the
> Linux Kernel.
> This patch provides necessary modifications to support packet
> synchronisation:
> Function omap_set_dma_transfer_params() handles value OMAP_DMA_SYNC_P=
ACKET
> to program FS and BS bits of register CCR.
> Users can give the packet size to the DMA driver by using parameters
> src_fi / dst_fi in functions omap_set_dma_src_params() /
> omap_set_dma_dest_params().
>
> Patch has been validated using OMAP's McSPI (on Zoom2, OMAP3430):
> McSPI is configured to use DMA transfer.
> FIFO are activated with a threshold of 16 bytes (i.e. DMA requests wi=
ll be
> triggered as soon as more than 16 bytes are free in the FIFO).
> A frame of 132 elements (bytes) has been transfered, by packets of 16
> elements. Resulting transfer was 8 packets of 16 elements plus a last=
 packet
> of 4 elements.
>
> Modifications tested building on OMAP2, OMAP3 and OMAP4 configuration=
s.
>
> Signed-off-by: Fabrice Goucem <f-goucem@ti.com>
> Acked-by: Venkatraman S <svenkatr@ti.com>
> Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Acked-by: Shilpa Maddi <s-maddi@ti.com>
> ---
> =A0arch/arm/plat-omap/dma.c | =A0 =A06 ++++--
> =A01 files changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/plat-omap/dma.c b/arch/arm/plat-omap/dma.c
> index 2ab224c..48f9355 100644
> --- a/arch/arm/plat-omap/dma.c
> +++ b/arch/arm/plat-omap/dma.c
> @@ -293,12 +293,14 @@ void omap_set_dma_transfer_params(int lch, int =
data_type, int elem_count,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0val |=3D (dma_trigger & ~0x1f) << 14;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0val |=3D dma_trigger & 0x1f;
>
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (sync_mode & OMAP_DMA_SYNC_FRAME)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ((sync_mode =3D=3D OMAP_DMA_SYNC_FRA=
ME) ||
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (sync_mode =3D=3D OMAP_DMA_SYNC=
_PACKET))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0val |=3D 1 << 5;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0else
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0val &=3D ~(1 << 5);
>
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (sync_mode & OMAP_DMA_SYNC_BLOCK)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ((sync_mode =3D=3D OMAP_DMA_SYNC_BLO=
CK) ||
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (sync_mode =3D=3D OMAP_DMA_SYNC=
_PACKET))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0val |=3D 1 << 18;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0else
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0val &=3D ~(1 << 18);
> --
> 1.6.0.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
