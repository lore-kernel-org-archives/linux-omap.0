From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 1/2] i2c: omap: Fix the revision register read
Date: Fri, 2 Nov 2012 13:06:04 +0200
Message-ID: <20121102110604.GB19493@arwen.pp.htv.fi>
References: <1351852785-16961-1-git-send-email-shubhrajyoti@ti.com>
 <1351852785-16961-2-git-send-email-shubhrajyoti@ti.com>
Reply-To: <balbi-l0cyMroinI0@public.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mojUlQ0s9EVzWg2t"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1351852785-16961-2-git-send-email-shubhrajyoti-l0cyMroinI0@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, b-cousson-l0cyMroinI0@public.gmane.org, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org
List-Id: linux-omap@vger.kernel.org

--mojUlQ0s9EVzWg2t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Nov 02, 2012 at 04:09:44PM +0530, Shubhrajyoti D wrote:
> The revision register on OMAP4 is a 16-bit lo and a 16-bit
> hi. Currently the driver reads only the lower 8-bits.
> Fix the same by preventing the truncating of the rev register
> for OMAP4.
>=20
> Also use the scheme bit ie bit-14 of the hi register to know if it
> is OMAP_I2C_IP_VERSION_2.
>=20
> On platforms previous to OMAP4 the offset 0x04 is IE register whose
> bit-14 reset value is 0, the code uses the same to its advantage.
>=20
> Also since the omap_i2c_read_reg uses reg_map_ip_* a raw_readw is done
> to fetch the revision register.
>=20
> The dev->regs is populated after reading the rev_hi. A NULL check
> has been added in the resume handler to prevent the access before
> the setting of the regs.

tested on which platforms ?

> Signed-off-by: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
> ---
>  drivers/i2c/busses/i2c-omap.c |   59 ++++++++++++++++++++++++++++++++---=
------
>  1 files changed, 46 insertions(+), 13 deletions(-)
>=20
> diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
> index db31eae..d8e7709 100644
> --- a/drivers/i2c/busses/i2c-omap.c
> +++ b/drivers/i2c/busses/i2c-omap.c
> @@ -49,9 +49,10 @@
>  #define OMAP_I2C_OMAP1_REV_2		0x20
> =20
>  /* I2C controller revisions present on specific hardware */
> -#define OMAP_I2C_REV_ON_2430		0x36
> -#define OMAP_I2C_REV_ON_3430_3530	0x3C
> -#define OMAP_I2C_REV_ON_3630_4430	0x40
> +#define OMAP_I2C_REV_ON_2430		0x00000036

are you sure this are the contents on 2430 ? Have you actually ran this
code on that platform ?

> +#define OMAP_I2C_REV_ON_3430_3530	0x0000003C
> +#define OMAP_I2C_REV_ON_3630		0x00000040

likewise for these two.

> +#define OMAP_I2C_REV_ON_4430_PLUS	0x50400002

what about 4460, 4470, 3530, etc etc etc ?

> @@ -490,7 +491,7 @@ static void omap_i2c_resize_fifo(struct omap_i2c_dev =
*dev, u8 size, bool is_rx)
> =20
>  	omap_i2c_write_reg(dev, OMAP_I2C_BUF_REG, buf);
> =20
> -	if (dev->rev < OMAP_I2C_REV_ON_3630_4430)
> +	if (dev->rev < OMAP_I2C_REV_ON_3630)
>  		dev->b_hw =3D 1; /* Enable hardware fixes */
> =20
>  	/* calculate wakeup latency constraint for MPU */
> @@ -1052,6 +1053,14 @@ static const struct of_device_id omap_i2c_of_match=
[] =3D {
>  MODULE_DEVICE_TABLE(of, omap_i2c_of_match);
>  #endif
> =20
> +#define OMAP_I2C_SCHEME(rev)		(rev & 0xc000) >> 14

you miss () there to make sure no other operations will take higher
precedence when using this macro.

> @@ -1130,7 +1136,31 @@ omap_i2c_probe(struct platform_device *pdev)
>  	if (IS_ERR_VALUE(r))
>  		goto err_free_mem;
> =20
> -	dev->rev =3D omap_i2c_read_reg(dev, OMAP_I2C_REV_REG) & 0xff;
> +	/*
> +	 * Read the Rev hi bit-[15:14] ie scheme this is 1 indicates ver2.
> +	 * On omap3 Offset 4 is IE Reg the bit [15:14] is XDR_IE which is 0
> +	 * at reset. Also since the omap_i2c_read_reg uses reg_map_ip_* a
> +	 * raw_readw is done.
> +	 */
> +	rev =3D __raw_readw(dev->base + 0x04);
> +
> +	switch (OMAP_I2C_SCHEME(rev)) {
> +	case 0:

define macros for these two cases.

> +		dev->regs =3D (u8 *)reg_map_ip_v1;
> +		dev->rev =3D omap_i2c_read_reg(dev, OMAP_I2C_REV_REG) & 0xff;
> +		minor =3D OMAP_I2C_REV_SCHEME_0_MAJOR(dev->rev);
> +		major =3D OMAP_I2C_REV_SCHEME_0_MAJOR(dev->rev);
> +	break;

wrong indentation.

--=20
balbi

--mojUlQ0s9EVzWg2t
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQk6kcAAoJEIaOsuA1yqREdS4P/RPl2OUxQpVOQHmSvOcmlqJI
8i9Qx8B1YvyPLk8gwGXHfeKF15brzNFzCNtcUcKDqiWwS1MmsQDdC1ks7YwJO7nS
dXANsMRQgYUjzPHIOGS7DR/DId+wlAt2BylHtKVJ7Ye4CxJqSfgZrtdS07TQLbvF
kU7ikSXZA31aYe6ecTwTFqc+acRN8Sjc7CSrEEqYCsUHyddVaQ3HwdqC5wUsBzis
66xBDUehhp+FzTQSBtY0z8qK6PNAW2Gjp4jfOzen6HopTnLPEyQ5/G41xfOaUykl
RnbGdNoSdWmfgueYasTzXb2HiZ0L1FnCJIPiZiI0U638kfVoZvXY9VacHE7YzJDO
B3+lkyBPgBaojyzcO2fC8Au8U7nsV7vfFbM/MC7NopUU0Syy9Q8k8NUz6CavFE0V
L9kEJ1ZEO4or9TASzBBrl21AClP8ltmUFJFDdqK+jV4bBm2Cy5H9//T3SC8bUsEd
PGN+FcNclGnebTrT2wFZMrib3xkq9tHUUOhqKDf7ol45Y5xE4wlELTOuq9zlC4lA
Yf2RYMNYiFcwXvh+Dk2xvxftsZbrnC55c2CWLETdhsOaNEarZzLRYFTIWkv+AN9N
yWymssVi65q4GbGmi0qaYM5Z15EALh+CQuF1kHRdy9itgT5JPoK5o3mQtllVmFuI
mEMOuLoM+sQnYLzWVw/C
=Rv9d
-----END PGP SIGNATURE-----

--mojUlQ0s9EVzWg2t--
