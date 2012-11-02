From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 2/2] i2c: omap: use revision check for
 OMAP_I2C_FLAG_APPLY_ERRATA_I207
Date: Fri, 2 Nov 2012 13:07:13 +0200
Message-ID: <20121102110713.GC19493@arwen.pp.htv.fi>
References: <1351852785-16961-1-git-send-email-shubhrajyoti@ti.com>
 <1351852785-16961-3-git-send-email-shubhrajyoti@ti.com>
Reply-To: <balbi-l0cyMroinI0@public.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="eHhjakXzOLJAF9wJ"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1351852785-16961-3-git-send-email-shubhrajyoti-l0cyMroinI0@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, b-cousson-l0cyMroinI0@public.gmane.org, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org
List-Id: linux-omap@vger.kernel.org

--eHhjakXzOLJAF9wJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 02, 2012 at 04:09:45PM +0530, Shubhrajyoti D wrote:
> The errata i207 is enabled for 2430 and 3xxx. Use the revision check
> to enable the erratum instead.
>=20
> Signed-off-by: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>

very good. I haven't read the errata but from a code standpoint, it
looks good:

Reviewed-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>

> ---
>  drivers/i2c/busses/i2c-omap.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
>=20
> diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
> index d8e7709..44245d4 100644
> --- a/drivers/i2c/busses/i2c-omap.c
> +++ b/drivers/i2c/busses/i2c-omap.c
> @@ -1164,7 +1164,8 @@ omap_i2c_probe(struct platform_device *pdev)
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

--eHhjakXzOLJAF9wJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQk6lhAAoJEIaOsuA1yqREADMQAK9NK810t+n2zSwI4z5bEk1j
mlW4qGZnpK0M8Wbz9oD8JaYRQ2dNyIuCknhAMBvv1KJx66v1iAP3JICuODfvrHJf
KJh26GebLtIJxQFrkKJSpW3siILc6nnKg8eAl5cc0ykVGuQFskrtXQ3TtVwX+hwD
01egM3nONEi1RdYOMc6ZTwfrnZD77lF+6fEF+mZxmQK7nx7KuJNWvEknTM5MIt8E
mQ663h2DMh9vUyMYn2Z/CecgI/DUkmcsGbfgfmlvOsMQLH2D9MEbyEYL1XOEK/SM
8wFOP3P5/4xErYcbqQmBF3oHZqGVECMIaMlG4erD6THQFHKyAI/6powe6TkYh8HU
9zpCxLzlzGmyniBabRo2sLmaRbw78swLFvhN4FcyzkRlhf2CD4Mk47JYPtZoldxb
fNLtEPE3PhyBq0klI06wZsvwxDMoSXA3jHBNSCZVL33XJCpwa+Zhbs0ZoqYKqLLI
xkj+SBtj6n2l+udaPBjjjxMmG9osh2NQPSK8Dmhh4WM8bHnlqLe4KBWEz8bObhOE
WZbOnmzw54RNAFkKIG2H0keuPdDLeY1+YZuJJciY1sbocdFKZd3B9quFiBnH9ClC
IGk6P4gSw69KfA8dSebQ4y3Ote6aFsOkNz+hG56Drl1VzLO88Jg95W+5KvgGBiBG
Bda9+CVhpvMp47drwnUD
=QNT4
-----END PGP SIGNATURE-----

--eHhjakXzOLJAF9wJ--
