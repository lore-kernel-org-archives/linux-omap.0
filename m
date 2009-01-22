From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: RE: [PATCH] ARM OMAP: Fix race in OMAP2/3 DMA IRQ handling
Date: Thu, 22 Jan 2009 09:21:34 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02A39CE60B@dbde02.ent.ti.com>
References: <20090121172409.GA23967@mail.solidboot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:54100 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756418AbZAVDvs convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 21 Jan 2009 22:51:48 -0500
In-Reply-To: <20090121172409.GA23967@mail.solidboot.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: =?iso-8859-1?Q?Juha_Yrj=F6l=E4?= <juha.yrjola@solidboot.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org=20
> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Juha Yrj=F6l=E4
> Sent: Wednesday, January 21, 2009 10:54 PM
> To: linux-omap@vger.kernel.org
> Subject: [PATCH] ARM OMAP: Fix race in OMAP2/3 DMA IRQ handling
>=20
> CSR must be cleared before invoking the callback.
>=20
> If the callback function starts a new, fast DMA transfer on the same
> channel, the completion status might lost if CSR is cleared after
> the callback invocation.
>=20
> Signed-off-by: Juha Yrjola <juha.yrjola@solidboot.com>
> ---
>  arch/arm/plat-omap/dma.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/arch/arm/plat-omap/dma.c b/arch/arm/plat-omap/dma.c
> index 8e6475d..265351b 100755
> --- a/arch/arm/plat-omap/dma.c
> +++ b/arch/arm/plat-omap/dma.c
> @@ -1898,11 +1898,11 @@ static int omap2_dma_handle_ch(int ch)
>  		status =3D dma_read(CSR(ch));
>  	}
> =20
> +	dma_write(status, CSR(ch));
This is not necessary. Refers line "dma_write(OMAP2_DMA_CSR_CLEAR_MASK,=
 CSR(ch));" just above.

It will any way do the job of clearing. In a way, clear done after the =
callback has no effect since the status reg and global IRQ_enable for t=
he particular channel is already disabled before that.
> +
>  	if (likely(dma_chan[ch].callback !=3D NULL))
>  		dma_chan[ch].callback(ch, status, dma_chan[ch].data);
> =20
> -	dma_write(status, CSR(ch));
> -
>  	return 0;
>  }
> =20
> --=20

So dma library is safe from the problem you have described.
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe=20
> linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
Regards,
Santosh
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
