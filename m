From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 1/2] mfd: omap-usb-host: Remove magic numbers for dev dma
 mask
Date: Wed, 15 Feb 2012 13:17:05 +0200
Message-ID: <20120215111704.GA15346@legolas.emea.dhcp.ti.com>
References: <1329301414-31003-1-git-send-email-govindraj.raja@ti.com>
 <1329301414-31003-2-git-send-email-govindraj.raja@ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mPYgjWmOFizS0g23"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:34741 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755244Ab2BOLRL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 15 Feb 2012 06:17:11 -0500
Content-Disposition: inline
In-Reply-To: <1329301414-31003-2-git-send-email-govindraj.raja@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Govindraj.R" <govindraj.raja@ti.com>
Cc: Samuel Ortiz <sameo@linux.intel.com>, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, Felipe Balbi <balbi@ti.com>, Alan Stern <stern@rowland.harvard.edu>


--mPYgjWmOFizS0g23
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 15, 2012 at 03:53:33PM +0530, Govindraj.R wrote:
> From: "Govindraj.R" <govindraj.raja@ti.com>
>=20
> Remove the hardcoded magic values for dma mask and use the dma
> mask macros available.
>=20
> CC: Felipe Balbi <balbi@ti.com>
> CC: Alan Stern <stern@rowland.harvard.edu>
> Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
> ---
>  drivers/mfd/omap-usb-host.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/mfd/omap-usb-host.c b/drivers/mfd/omap-usb-host.c
> index 68ac2c5..3109b0a 100644
> --- a/drivers/mfd/omap-usb-host.c
> +++ b/drivers/mfd/omap-usb-host.c
> @@ -170,7 +170,7 @@ struct usbhs_hcd_omap {
>  /*----------------------------------------------------------------------=
---*/
> =20
>  const char usbhs_driver_name[] =3D USBHS_DRIVER_NAME;
> -static u64 usbhs_dmamask =3D ~(u32)0;
> +static u64 usbhs_dmamask =3D DMA_BIT_MASK(32);
> =20
>  /*----------------------------------------------------------------------=
---*/
> =20
> @@ -223,7 +223,7 @@ static struct platform_device *omap_usbhs_alloc_child=
(const char *name,
>  	}
> =20
>  	child->dev.dma_mask		=3D &usbhs_dmamask;
> -	child->dev.coherent_dma_mask	=3D 0xffffffff;
> +	child->dev.coherent_dma_mask	=3D DMA_BIT_MASK(32);

while at that, you could use dma_set_coherent_mask();

--=20
balbi

--mPYgjWmOFizS0g23
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPO5QwAAoJEIaOsuA1yqREAzEP/jw3H9oPY84gE9Ch6RZQc3fp
/qiWrn8j4WNk931IV1SFXo55cU0kZFain1D+n8Vq54eUDWdvBf+6xdih36z0Znhp
z1w9KhMhTo741hKUTkLUKwy5695WmslbJ9C8dLwNXSyPwa0MaIuzCsMimbgeKYZz
Zv1bMEI/pnI0jZwP1cEAap5eDSrz/8172uPEhHamqVFjaj6xJ/uBYSGc9/UcMKTu
ZAgjO6H9mrjb4Rd4zyAT/L23O//SdFBQsptuBS/n61n64HYa2dbhLbMEVV3dz4Vc
oCcKv1BWweJ+aa2CCBt2zu7JSUsxLPIM+FCk5BLBiLritKjWe8EsanvZg/RmRmON
Uk/t1f9B1jaoQIwBKi6WxZbqIxzecdxLR5HmlRGk5LbmKwNYP9MoEL2aL2kPqaLZ
batnD4wG8Oyq7R7CVkAEuVhgZFx2/vNRIBRKWEc5HfiwkgKCa/KyY+7lRSw9EpZV
PIgLJOEO/bTGq5Al2QkHWegMUnQNsHygVzPOLivKY+QywLUQl55Ko2FQKmioX2kN
OHb6yRG/BDmO4fUtNIU4wJTMlZl1EYPEWBNu1XsarkKyHnTYEcva5iJIKt7drt2n
iaxZxzlzvNy+3raDmbLEuonKOrxoHptHPEmsuac5KaKYhnbE0afHm6gpvxFF+GId
uWLWjZBJwLOftSw2tLPG
=DO7d
-----END PGP SIGNATURE-----

--mPYgjWmOFizS0g23--
