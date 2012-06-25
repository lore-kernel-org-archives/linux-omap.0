From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCHv10 6/7] I2C: OMAP: Correct I2C revision for OMAP3
Date: Mon, 25 Jun 2012 15:35:43 +0300
Message-ID: <20120625123542.GE30463@arwen.pp.htv.fi>
References: <1340622702-21622-1-git-send-email-shubhrajyoti@ti.com>
 <1340622702-21622-7-git-send-email-shubhrajyoti@ti.com>
Reply-To: balbi-l0cyMroinI0@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="nHwqXXcoX0o6fKCv"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1340622702-21622-7-git-send-email-shubhrajyoti-l0cyMroinI0@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, Jon Hunter <jon-hunter-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org


--nHwqXXcoX0o6fKCv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 25, 2012 at 04:41:41PM +0530, Shubhrajyoti D wrote:
> From: Jon Hunter <jon-hunter-l0cyMroinI0@public.gmane.org>
>=20
> The OMAP3530 is based upon the same silicon as the OMAP3430 and so the I2C
> revision is the same for 3430 and 3530. However, the OMAP3630 device has =
the
> same I2C revision as OMAP4. Correct the revision definition to reflect th=
is.
>=20
> This patch is based on work done by Jon Hunter <jon-hunter-l0cyMroinI0@public.gmane.org>
> Changes from his patch
> - Update OMAP_I2C_REV_ON_3430 also to reflect that it is same as 3530
>=20
> Signed-off-by: Jon Hunter <jon-hunter-l0cyMroinI0@public.gmane.org>
> Signed-off-by: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>

Reviewed-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>

> ---
>  drivers/i2c/busses/i2c-omap.c |   10 +++++-----
>  1 files changed, 5 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
> index 8344ad030..0557b0d 100644
> --- a/drivers/i2c/busses/i2c-omap.c
> +++ b/drivers/i2c/busses/i2c-omap.c
> @@ -50,8 +50,8 @@
> =20
>  /* I2C controller revisions present on specific hardware */
>  #define OMAP_I2C_REV_ON_2430		0x36
> -#define OMAP_I2C_REV_ON_3430		0x3C
> -#define OMAP_I2C_REV_ON_3530_4430	0x40
> +#define OMAP_I2C_REV_ON_3430_3530	0x3C
> +#define OMAP_I2C_REV_ON_3630_4430	0x40
> =20
>  /* timeout waiting for the controller to respond */
>  #define OMAP_I2C_TIMEOUT (msecs_to_jiffies(1000))
> @@ -305,7 +305,7 @@ static int omap_i2c_init(struct omap_i2c_dev *dev)
>  			omap_i2c_write_reg(dev, OMAP_I2C_SYSC_REG,
>  					   SYSC_AUTOIDLE_MASK);
> =20
> -		} else if (dev->rev >=3D OMAP_I2C_REV_ON_3430) {
> +		} else if (dev->rev >=3D OMAP_I2C_REV_ON_3430_3530) {
>  			dev->syscstate =3D SYSC_AUTOIDLE_MASK;
>  			dev->syscstate |=3D SYSC_ENAWAKEUP_MASK;
>  			dev->syscstate |=3D (SYSC_IDLEMODE_SMART <<
> @@ -1021,7 +1021,7 @@ omap_i2c_probe(struct platform_device *pdev)
>  	if (dev->flags & OMAP_I2C_FLAG_APPLY_ERRATA_I207)
>  		dev->errata |=3D I2C_OMAP_ERRATA_I207;
> =20
> -	if (dev->rev <=3D OMAP_I2C_REV_ON_3430)
> +	if (dev->rev <=3D OMAP_I2C_REV_ON_3430_3530)
>  		dev->errata |=3D I2C_OMAP_ERRATA_I462;
> =20
>  	if (!(dev->flags & OMAP_I2C_FLAG_NO_FIFO)) {
> @@ -1039,7 +1039,7 @@ omap_i2c_probe(struct platform_device *pdev)
> =20
>  		dev->fifo_size =3D (dev->fifo_size / 2);
> =20
> -		if (dev->rev >=3D OMAP_I2C_REV_ON_3530_4430)
> +		if (dev->rev >=3D OMAP_I2C_REV_ON_3630_4430)
>  			dev->b_hw =3D 0; /* Disable hardware fixes */
>  		else
>  			dev->b_hw =3D 1; /* Enable hardware fixes */
> --=20
> 1.7.5.4
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--=20
balbi

--nHwqXXcoX0o6fKCv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJP6FseAAoJEIaOsuA1yqRETOoP/ijyohy+I7Fg4lYG3uUusBqx
4xHT6Z2kFbIK+K8jB4PWCzq9wLhTl3ZXMcQASAWH8sZfJ+H6oS6VuEnD6NRT3/m9
CIgxVALpUON9ie8gMleFaUI2cmCIdjdkKA+RNSf+cHtj7omXq6K9W6B7vLuS86ZX
+f1Lx7Gw4m6OuxYjWxvaHZgipGl8i9elWrC+a+C0eeC35Y4jG9E+WAjYoUiqaSxN
3/vJ8LhtqDP8PgHe36GPntGBLjU2cuek+7aNrn3L3WkbzagsyYZJdlVamv3TVYUZ
fqaTJ6e+ZFK5CzNC2c6ep+EGnfj5j5OKewhPTB5XZ9k2TPeSUX/CMezXIYr0tgeF
r/wu9Wku642FEdYOw7o5TB/kvp42IVoboIlmpid1n4pNLPvDIABylvA2119HkhWj
uMy/YmCONGWoDQ/MWkT+hZjz6yZr4cYGIWmeEqTbY+qY/bwUpU5dsG87+vQJvm6W
H99um5o5XaVVFPENRuVDAyHt1FVjC0GF07h3EXlM5reT9zKoAwkOE9SziI2v+pkz
+G3bby0wnlfb2egsClKM43e0999JpAaoSXNJo/CtEz3iiFqfddHoXZJmocj4Pzzn
iWCY5zg6h7SVcBFcThwprHSPDLnkTwGNOFRAjKUMEz8IjMdB1Vp+sR3LrN6u51j+
j0fODl8Gp1RtLWSf2/sC
=RIIj
-----END PGP SIGNATURE-----

--nHwqXXcoX0o6fKCv--
