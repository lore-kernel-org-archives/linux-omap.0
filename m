From: Artem Bityutskiy <dedekind@yandex.ru>
Subject: Re: [OMAP][sDMA]Fix for possible race condition in omap_free_dma()
Date: Tue, 07 Apr 2009 15:00:09 +0300
Message-ID: <49DB4049.2030004@yandex.ru>
References: <EAF47CD23C76F840A9E7FCE10091EFAB02A93B8033@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:41578 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754991AbZDGMAf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 7 Apr 2009 08:00:35 -0400
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02A93B8033@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "'linux-omap@vger.kernel.org'" <linux-omap@vger.kernel.org>

Hi Tony,

I wonder, what happened to this patch?

Shilimkar, Santosh wrote:
> From: Santosh Shilimkar <santosh.shilimkar@ti.com>
>=20
> Fix the possible race condition in omap_free_dma(). Function omap_fre=
e_dma()=20
> sets the dev_id =3D -1 and then accesses the channel afterwards to cl=
ear it.
> But setting the dev_id=3D-1 makes the channel available for allocatio=
n again.
> So it is possible someone else can grab it and results are unpredicta=
ble.
> To avod this DMA channle is cleared first and then the dev_id =3D -1 =
is set.
>=20
> Thanks to McNeil, Sean <sean.mcneil@ti.com> for ointing out this issu=
e.
>=20
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> ---
>  arch/arm/plat-omap/dma.c |   13 ++++++-------
>  1 files changed, 6 insertions(+), 7 deletions(-)
>=20
> Index: omapkernel/arch/arm/plat-omap/dma.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- omapkernel.orig/arch/arm/plat-omap/dma.c
> +++ omapkernel/arch/arm/plat-omap/dma.c
> @@ -785,19 +785,12 @@ void omap_free_dma(int lch)
>  {
>  	unsigned long flags;
> =20
> -	spin_lock_irqsave(&dma_chan_lock, flags);
>  	if (dma_chan[lch].dev_id =3D=3D -1) {
>  		pr_err("omap_dma: trying to free unallocated DMA channel %d\n",
>  		       lch);
> -		spin_unlock_irqrestore(&dma_chan_lock, flags);
>  		return;
>  	}
> =20
> -	dma_chan[lch].dev_id =3D -1;
> -	dma_chan[lch].next_lch =3D -1;
> -	dma_chan[lch].callback =3D NULL;
> -	spin_unlock_irqrestore(&dma_chan_lock, flags);
> -
>  	if (cpu_class_is_omap1()) {
>  		/* Disable all DMA interrupts for the channel. */
>  		dma_write(0, CICR(lch));
> @@ -823,6 +816,12 @@ void omap_free_dma(int lch)
>  		dma_write(0, CCR(lch));
>  		omap_clear_dma(lch);
>  	}
> +
> +	spin_lock_irqsave(&dma_chan_lock, flags);
> +	dma_chan[lch].dev_id =3D -1;
> +	dma_chan[lch].next_lch =3D -1;
> +	dma_chan[lch].callback =3D NULL;
> +	spin_unlock_irqrestore(&dma_chan_lock, flags);
>  }
>  EXPORT_SYMBOL(omap_free_dma);
> =20
>=20
> Regards,
> Santosh
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


--=20
Best Regards,
Artem Bityutskiy (=D0=90=D1=80=D1=82=D1=91=D0=BC =D0=91=D0=B8=D1=82=D1=8E=
=D1=86=D0=BA=D0=B8=D0=B9)
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
