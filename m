From: Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 4/4] arm: omap: display: Don't build device for DMM
Date: Fri, 13 Sep 2013 12:29:44 +0300
Message-ID: <5232DB08.9060005@ti.com>
References: <1379063679-4869-1-git-send-email-archit@ti.com> <1379063679-4869-5-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="rrx3Ie7KDAgfBgJGkJeb8BdruXieSHujA"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1379063679-4869-5-git-send-email-archit-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Archit Taneja <archit-l0cyMroinI0@public.gmane.org>
Cc: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robdclark-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Andy Gross <andygro-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

--rrx3Ie7KDAgfBgJGkJeb8BdruXieSHujA
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 13/09/13 12:14, Archit Taneja wrote:
> DMM exists on omap4+ platforms, these platforms will always boot with D=
T. Remove
> the previous method of searching the dmm hwmod and building the device =
by
> ourselves. Addition of a DMM nodes in DT will ensure a DMM device is bu=
ilt.
>=20
> For OMAP4, the address and irq data for most hwmods were removed, so th=
e older
> method doesn't work anyway.
>=20
> Cc: Andy Gross <andygro-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Signed-off-by: Archit Taneja <archit-l0cyMroinI0@public.gmane.org>
> ---
>  arch/arm/mach-omap2/display.c | 16 ++--------------
>  1 file changed, 2 insertions(+), 14 deletions(-)
>=20
> diff --git a/arch/arm/mach-omap2/display.c b/arch/arm/mach-omap2/displa=
y.c
> index d097d23..e0642bd 100644
> --- a/arch/arm/mach-omap2/display.c
> +++ b/arch/arm/mach-omap2/display.c
> @@ -126,20 +126,8 @@ static int __init omapdrm_init(void)
>  {
>  	int r =3D 0;
> =20
> -	/* create DRM and DMM device */
> +	/* create DRM device(DMM device created via DT) */
>  	if (omap_drm_device !=3D NULL) {
> -		struct omap_hwmod *oh =3D NULL;
> -		struct platform_device *pdev;
> -
> -		/* lookup and populate the DMM information, if present - OMAP4+ */
> -		oh =3D omap_hwmod_lookup("dmm");
> -		if (oh) {
> -			pdev =3D omap_device_build(oh->name, -1, oh, NULL, 0);
> -			WARN(IS_ERR(pdev),
> -				"Could not build omap_device for %s\n",
> -				oh->name);
> -		}
> -
>  		platform_drm_data.omaprev =3D GET_OMAP_TYPE;

Ok, so you remove the DMM device creation here. Why not do this as a
first patch, before moving the DMM/DRM code?

 Tomi



--rrx3Ie7KDAgfBgJGkJeb8BdruXieSHujA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJSMtsIAAoJEPo9qoy8lh71yCQQAKqIbSqh6tRvR4QVarttTppr
mX3TYlm8FQ3qrmLmTILRtHDs/iMsBXpP1M0sioZ6oNTc164TQO0dHtO9/7oS7Z8I
1RVBZ0gXdJD0DMusH+U1TJbRqv6CXxG2NeqlxWmUEFVZLK92QO7y9Or9W7YPQa2l
OMZDlixd27Q/2SPhiFl7uFQYK+poT0bhm5rD9Voi1sxYAPdaXbzJAfoL0mlnUDmJ
Npxuf4kp2XcJloFMX06g6hWI0TVXuHqp5bS+4nj4EQnjMz7jTwO0acNqqpilbUNx
GN/eJuzzdrKwAO5oZBS/Kov7CY7leR4O5UQ4VryaASWn8Pzkbdr0MyOWbK8oiGS4
NDeXqkC81zMM2MZkakgUhkS5APb/NnObg4d4UUgz/A+ZaMgUI0B0IVu22GjRgaVl
qnbUz4ts2hA/4v22rA//b6/QSmNakxlrzWSwyf+Le2KVxSkXmpii5Ft/guohcOaE
pjO8ss9SH+GzHK8f1tiX9I0wT2h6TTdIhx5W4SNdbzq4gD9k+L6MJgneUDqCxy7+
RU8XiklKuD92fw/YFAmWpBdznZO+EZz5ngIQsQsE5K+AV73vmbTY/Frv2C9IMZMM
NED6MaT2z90eVxPNIz4273fmTzDYmogI8ma7nszd2iHBc9hY/rXErIj5hxasEnnq
GDGmakMnTC4c+7I2htdf
=4Qt6
-----END PGP SIGNATURE-----

--rrx3Ie7KDAgfBgJGkJeb8BdruXieSHujA--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
