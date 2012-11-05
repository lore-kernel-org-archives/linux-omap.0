From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCHv2 2/7] i2c: omap: use revision check for
 OMAP_I2C_FLAG_APPLY_ERRATA_I207
Date: Mon, 5 Nov 2012 09:51:07 +0200
Message-ID: <20121105075107.GC32468@arwen.pp.htv.fi>
References: <1352025873-27492-1-git-send-email-shubhrajyoti@ti.com>
 <1352025873-27492-3-git-send-email-shubhrajyoti@ti.com>
Reply-To: <balbi-l0cyMroinI0@public.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="iFRdW5/EC4oqxDHL"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1352025873-27492-3-git-send-email-shubhrajyoti-l0cyMroinI0@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, b-cousson-l0cyMroinI0@public.gmane.org, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org
List-Id: linux-omap@vger.kernel.org

--iFRdW5/EC4oqxDHL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 04, 2012 at 04:14:28PM +0530, Shubhrajyoti D wrote:
> The errata i207 is enabled for 2430 and 3xxx. Use the revision check
> to enable the erratum instead.
>=20
> Signed-off-by: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>

Reviewed-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>

> ---
>  drivers/i2c/busses/i2c-omap.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
>=20
> diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
> index 72fce6d..e009985 100644
> --- a/drivers/i2c/busses/i2c-omap.c
> +++ b/drivers/i2c/busses/i2c-omap.c
> @@ -1166,7 +1166,8 @@ omap_i2c_probe(struct platform_device *pdev)
> =20
>  	dev->errata =3D 0;
> =20
> -	if (dev->flags & OMAP_I2C_FLAG_APPLY_ERRATA_I207)
> +	if (dev->rev >=3D OMAP_I2C_REV_ON_2430 &&
> +			dev->rev < OMAP_I2C_REV_ON_4430_PLUS)
>  		dev->errata |=3D I2C_OMAP_ERRATA_I207;
> =20
>  	if (dev->rev <=3D OMAP_I2C_REV_ON_3430_3530)
> --=20
> 1.7.5.4
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--=20
balbi

--iFRdW5/EC4oqxDHL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQl2/rAAoJEIaOsuA1yqREUgoQALU6APbIsmjKcTQsiDDbNs8k
FQtRnozBy681RLZ4KSfkq58DJEbxW/e5L48dnOkgwtGBJXxT0yohXPXmN644Op0P
uSidgFNA5V76Ap4EtFd5eSzZW8fpyVQqzOubG7kzGGU4HPcs1JNL896VMrfRtwXd
VaGkhBv8fg60kHo4soUTntZ/ol4h87OLs7ovynLHnQJ5Syy5gm7ueUjzAudKcw8W
fjZtO6xnoa3wXrMl81autF/AzpdRhyyyKicZ5Wsl7d4QGG3/9CpEWusX8Ze9mK0B
TSeH5fbi8i5zp3Ki5Yhkq6BkDiSanjKRmS9Cy+6qaNw9+Qj3FTrNmQjV7mAnHWjl
zNGwr69TwvyU2rrVwTvP6bhrrXyAROIxKphnjUCgqv9i0fNpNZ6g9e7tjBagiFg3
fiIJY9dvXE3Mvp1+exnYB9kRX7i4v+Db7cxE+4UfdGGbVOi5fwH6HaQLNA1lS1L/
gI0ZirDfQJiVrIbEWa9QxLAI6vQEkcOSYeKv2wtQrAwe9PXLX5KS2AJkS136lFAA
fs/W+OnUK9daj3cwfl8ynroLaL4MNVr4FzV2S4Hy3Jblio6Tn1RBOLSDopa2tkSb
WDjGv8KdoeHNvNdG5bZewN6+ziu0sDGX7fwAWNek98jI/JoNdPprGZ7Y52kD45Vi
5kXwQdgE7fhDG0L1nm+T
=iMsm
-----END PGP SIGNATURE-----

--iFRdW5/EC4oqxDHL--
