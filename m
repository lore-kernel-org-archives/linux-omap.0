From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 2/2] mfd: omap-usb-host: Move usbhs init before allocing
 child dev
Date: Wed, 15 Feb 2012 13:17:45 +0200
Message-ID: <20120215111743.GB15346@legolas.emea.dhcp.ti.com>
References: <1329301414-31003-1-git-send-email-govindraj.raja@ti.com>
 <1329301414-31003-3-git-send-email-govindraj.raja@ti.com>
Reply-To: balbi-l0cyMroinI0@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LMmSgwdUwKH/sMG1"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1329301414-31003-3-git-send-email-govindraj.raja-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Govindraj.R" <govindraj.raja-l0cyMroinI0@public.gmane.org>
Cc: Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
List-Id: linux-omap@vger.kernel.org


--LMmSgwdUwKH/sMG1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 15, 2012 at 03:53:34PM +0530, Govindraj.R wrote:
> From: "Govindraj.R" <govindraj.raja-l0cyMroinI0@public.gmane.org>
>=20
> There could be possible race condition where the host dev's
> are alloced and added to platform dev just before usbhs_init.
> Just move usbhs_init before adding child dev.
>=20
> CC: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>

Acked-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>

> CC: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
> Signed-off-by: Govindraj.R <govindraj.raja-l0cyMroinI0@public.gmane.org>
> ---
>  drivers/mfd/omap-usb-host.c |    3 +--
>  1 files changed, 1 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/mfd/omap-usb-host.c b/drivers/mfd/omap-usb-host.c
> index 3109b0a..c5d48ce 100644
> --- a/drivers/mfd/omap-usb-host.c
> +++ b/drivers/mfd/omap-usb-host.c
> @@ -799,14 +799,13 @@ static int __devinit usbhs_omap_probe(struct platfo=
rm_device *pdev)
> =20
>  	platform_set_drvdata(pdev, omap);
> =20
> +	omap_usbhs_init(dev);
>  	ret =3D omap_usbhs_alloc_children(pdev);
>  	if (ret) {
>  		dev_err(dev, "omap_usbhs_alloc_children failed\n");
>  		goto err_alloc;
>  	}
> =20
> -	omap_usbhs_init(dev);
> -
>  	goto end_probe;
> =20
>  err_alloc:
> --=20
> 1.7.5.4
>=20

--=20
balbi

--LMmSgwdUwKH/sMG1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPO5RXAAoJEIaOsuA1yqRESSIP/0YB//v2tLOp6lusfzfZplRt
jgeq0go+Nb64N/EgTgKEBpnjTOAlatGiRdM0Bz3helMrHKkxuhrTOHJGlcaFStM0
xWjSilLmzsZ3qDPG/fcP/pcg8DUKO/yc+0DIaQcGbiS3GEgVtV/Zy1qU+lv/pRK0
4JJqzyaxYn9oNoWsJnjQuP6jD2JJJ4Fca4ff99weYR4/v8+EcMQZ+5OQ3adnj0M3
sme9htbNltDZSm+lWA8Ckcrq+x4Vh2IoiMDDewlRCbwRgmWPTJtxUy1XLMV9VXI7
So8OvPz9q5E+LiTs9AdpO+9F1vROtj5nJa5723N2APG3J7sSBNfvsCWiIwIwo/wC
cRevgp8zW80wtJyXpuoC0LAKTRC4Xzby5V65k+7ond2CN5HbtMwwn8BbCyGGX+lY
/mVvr+v5ceRwv2a0ZSQ22nJ+Nrmb5+MSGpLWkiQ/hKTAvte/5peCFSIYSe6vIC/b
ixkx4fcagpamoNGRCD2kLB+lWV63snciRvkL3vlGrOnpQZguOc/ifXRcoR8XtdhG
DwtmYWEs2BgqwaYZorIk/QX+DIoiaMCsH/bZORx/AUaBXFX67Hb5oVhFkqCBixMB
B9gLRrjzgB8E0K2OOGcKR+VUIlfa40cfGkBwpiZ9qIXzYYC66ygNIKs0hemlsE5I
Xb0tu2RZ4N2OIAmE/vbQ
=AKIm
-----END PGP SIGNATURE-----

--LMmSgwdUwKH/sMG1--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
