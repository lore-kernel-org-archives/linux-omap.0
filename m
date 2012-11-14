From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH] i2c: omap: don't save a value only needed for
 read-clearing
Date: Wed, 14 Nov 2012 20:37:39 +0200
Message-ID: <20121114183739.GA30212@arwen.pp.htv.fi>
References: <1352913666-11022-1-git-send-email-wolfram@the-dreams.de>
Reply-To: <balbi-l0cyMroinI0@public.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PEIAKu/WMn1b1Hv9"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1352913666-11022-1-git-send-email-wolfram-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wolfram-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

--PEIAKu/WMn1b1Hv9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Nov 14, 2012 at 06:21:06PM +0100, Wolfram Sang wrote:
> Signed-off-by: Wolfram Sang <wolfram-z923LK4zBo2bacvFa/9K2g@public.gmane.org>

fine by me. I'd like to see a commit log (even if obvious) there. But no
strong feelings.

Acked-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>

> ---
>=20
> This makes one of my code analyzers happy and makes me a part of the

anything open source which we could all be using ? :-)

> i2c-omap-patch crowd \o/
>=20
>  drivers/i2c/busses/i2c-omap.c |    3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
> index 482c63d..49b12fb 100644
> --- a/drivers/i2c/busses/i2c-omap.c
> +++ b/drivers/i2c/busses/i2c-omap.c
> @@ -1291,14 +1291,13 @@ static int omap_i2c_runtime_suspend(struct device=
 *dev)
>  {
>  	struct platform_device *pdev =3D to_platform_device(dev);
>  	struct omap_i2c_dev *_dev =3D platform_get_drvdata(pdev);
> -	u16 iv;
> =20
>  	_dev->iestate =3D omap_i2c_read_reg(_dev, OMAP_I2C_IE_REG);
> =20
>  	omap_i2c_write_reg(_dev, OMAP_I2C_IE_REG, 0);
> =20
>  	if (_dev->rev < OMAP_I2C_OMAP1_REV_2) {
> -		iv =3D omap_i2c_read_reg(_dev, OMAP_I2C_IV_REG); /* Read clears */
> +		omap_i2c_read_reg(_dev, OMAP_I2C_IV_REG); /* Read clears */
>  	} else {
>  		omap_i2c_write_reg(_dev, OMAP_I2C_STAT_REG, _dev->iestate);
> =20
> --=20
> 1.7.10.4
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--=20
balbi

--PEIAKu/WMn1b1Hv9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQo+TzAAoJEIaOsuA1yqREssgP/0aGY8KZGmECw/TAArpCRbom
HLDa1nP19mc+lnV7w55w5adf7kTqUwUy9R82O+4Px1qZN9jMUCrMS4vQ1+jAKhHG
sYS+3l6lgXwaeAJT5uq/JyUuJxwux92C/FPxsxxtApxug5Y/WCTcBYUtFobYk4bY
kQ+VBRX9KNSEfTWgzVKLd1Zbt76XwT920d01/PK3EojxnWQrtn81JHSeIgNArZa2
L1bb9pkiCroa9VY/DhnvgLYDfSJsuzaZCiNdPTUWa+4imItOw3LQY6gTz/Uy2J/C
jMj2Ny9KwqtwdiOBOWx1L5+oPBL5APtUPx4hH3VoXNrvQgc2rfY/Vs+5vI4UI4J7
PTOMC3BeHyLtSB5LNmlBKjx9rDgcDdfqFsaGzK183XfIjzW8p2n6bmuaGHI8bMLs
OC0CwXRpaR6szMeONFdBmMG7vj1UBwNDe6qAraU0yoXXCg6qkraajzp15yOPzQR/
2BmUNvel/1jYBCE6eNQu6uTUQs+tJeQYL+pSvFOToEEq/VkGC8XBI+ixMF140Q3o
9stgWgAjPTKUzOef1FfS04T0sX3CjUnFit/D4KoVKE3LV3hMWnk1Eh9O54UhFe7W
WsFme3HKbNnknO7fcR2dop5rTzbbSYv19LKmIvThWrt81kLbdFl9kS9sNWUEJK1S
Y7QuI+97yEBDVfU0/1pO
=nmSW
-----END PGP SIGNATURE-----

--PEIAKu/WMn1b1Hv9--
