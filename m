From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 1/2] mfd: omap-usb-host: Remove magic numbers for dev dma
 mask
Date: Wed, 15 Feb 2012 17:56:41 +0200
Message-ID: <20120215155641.GB32073@legolas.emea.dhcp.ti.com>
References: <1329301414-31003-1-git-send-email-govindraj.raja@ti.com>
 <1329301414-31003-2-git-send-email-govindraj.raja@ti.com>
 <20120215111704.GA15346@legolas.emea.dhcp.ti.com>
 <CAAL8m4x0w+bRXxCAuUTP=nKg99kjy1xvxuyH0aJF68HsnOuKBw@mail.gmail.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7ZAtKRhVyVSsbBD2"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:53594 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750928Ab2BOP4q (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 15 Feb 2012 10:56:46 -0500
Content-Disposition: inline
In-Reply-To: <CAAL8m4x0w+bRXxCAuUTP=nKg99kjy1xvxuyH0aJF68HsnOuKBw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Govindraj <govindraj.ti@gmail.com>
Cc: balbi@ti.com, "Govindraj.R" <govindraj.raja@ti.com>, Samuel Ortiz <sameo@linux.intel.com>, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>


--7ZAtKRhVyVSsbBD2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

> From c4523f02fe96b85245ada1047aa1273c56509e5c Mon Sep 17 00:00:00 2001
> From: "Govindraj.R" <govindraj.raja@ti.com>
> Date: Wed, 15 Feb 2012 12:27:50 +0530
> Subject: [PATCH 1/2] mfd: omap-usb-host: Remove magic numbers for dev dma
>  mask
>=20
> Remove the hardcoded magic values for dma mask and use the dma
> mask api/macro available.
>=20
> Signed-off-by: Govindraj.R <govindraj.raja@ti.com>

Reviewed-by: Felipe Balbi <balbi@ti.com>

> ---
>  drivers/mfd/omap-usb-host.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/mfd/omap-usb-host.c b/drivers/mfd/omap-usb-host.c
> index 68ac2c5..6800411 100644
> --- a/drivers/mfd/omap-usb-host.c
> +++ b/drivers/mfd/omap-usb-host.c
> @@ -170,7 +170,7 @@ struct usbhs_hcd_omap {
>  /*----------------------------------------------------------------------=
---*/
>=20
>  const char usbhs_driver_name[] =3D USBHS_DRIVER_NAME;
> -static u64 usbhs_dmamask =3D ~(u32)0;
> +static u64 usbhs_dmamask =3D DMA_BIT_MASK(32);
>=20
>  /*----------------------------------------------------------------------=
---*/
>=20
> @@ -223,7 +223,7 @@ static struct platform_device
> *omap_usbhs_alloc_child(const char *name,
>  	}
>=20
>  	child->dev.dma_mask		=3D &usbhs_dmamask;
> -	child->dev.coherent_dma_mask	=3D 0xffffffff;
> +	dma_set_coherent_mask(&child->dev, DMA_BIT_MASK(32));
>  	child->dev.parent		=3D dev;
>=20
>  	ret =3D platform_device_add(child);
> --=20
> 1.7.5.4

--=20
balbi

--7ZAtKRhVyVSsbBD2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPO9W4AAoJEIaOsuA1yqREuvQP/Rf8GKH0HRN0IBmvFwCkaCUW
Tbw91723W6i8yUN3i2kTpglZ0RReFxp1M3I3qFQ9A/veZRxqBPO+2rUkCDqO9Y0T
paCcIPamjOcHyM5xOSEd3khiHH6iWAdjaj8Gk42LHG3XArXZ7GYq68jhuBlTO46u
HQQMFwPAIWMDY2bJBa/j+uY/hZcc0UqaXaJgFAxdTZWAnWRGfdbf91Pkdz1JS770
yhZLwAEba/bg1LiN+WmKM5fjrWJW84+8OI3CyzvyMIPwhl2kxypSUuKXN96cT+zd
zYDgEYVMfg1esXTR20NmVGZEvA9xU8K2ddz7m0MpYWoOPITmSZQ7ajqtkjN2Ef4x
1qtmyIO/Ry4g8ZuqI5MZwdHW2v7Tabwjh5j1lyw6BsBVFOSWKUjOMVe/E3vR9RXY
tt/ro/6A85mJHGeO6xW+kJ+rVBe1EZj73CtcjuXYbr7EHIydOS5VMdkJ5B+eFPkw
HLd91I8YhV7xRoRGAAfJcja9LfE0gn9oSUXQXF3jR8pDCTlWnGaGwiakt7ppNVTD
D2fONoBMgRWa5uPy0qL6jrlLpeybfDUr0F4hSr9Nfhcx6rTIcqZaCHylWfCySpgV
UzTa1dqeNmC9TSSNJ1+IRDx36L1PPvcrEhV8xwwpFsIuqc0p9EGoE97IJ/pwdjSr
EldZlcZh21HvA3D2/Ufz
=fWjV
-----END PGP SIGNATURE-----

--7ZAtKRhVyVSsbBD2--
