From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCHv2 1/7] i2c: omap: Fix the revision register read
Date: Mon, 5 Nov 2012 09:50:26 +0200
Message-ID: <20121105075026.GB32468@arwen.pp.htv.fi>
References: <1352025873-27492-1-git-send-email-shubhrajyoti@ti.com>
 <1352025873-27492-2-git-send-email-shubhrajyoti@ti.com>
Reply-To: <balbi-l0cyMroinI0@public.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="KFztAG8eRSV9hGtP"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1352025873-27492-2-git-send-email-shubhrajyoti-l0cyMroinI0@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, b-cousson-l0cyMroinI0@public.gmane.org, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org
List-Id: linux-omap@vger.kernel.org

--KFztAG8eRSV9hGtP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Nov 04, 2012 at 04:14:27PM +0530, Shubhrajyoti D wrote:
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
>=20
> Signed-off-by: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
> ---
>  drivers/i2c/busses/i2c-omap.c |   61 ++++++++++++++++++++++++++++++++---=
------
>  1 files changed, 48 insertions(+), 13 deletions(-)
>=20
> diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
> index db31eae..72fce6d 100644
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
> +#define OMAP_I2C_REV_ON_3430_3530	0x0000003C
> +#define OMAP_I2C_REV_ON_3630		0x00000040
> +#define OMAP_I2C_REV_ON_4430_PLUS	0x50400002
> =20
>  /* timeout waiting for the controller to respond */
>  #define OMAP_I2C_TIMEOUT (msecs_to_jiffies(1000))
> @@ -202,7 +203,7 @@ struct omap_i2c_dev {
>  						 * fifo_size=3D=3D0 implies no fifo
>  						 * if set, should be trsh+1
>  						 */
> -	u8			rev;
> +	u32			rev;
>  	unsigned		b_hw:1;		/* bad h/w fixes */
>  	unsigned		receiver:1;	/* true when we're in receiver mode */
>  	u16			iestate;	/* Saved interrupt register */
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
> @@ -1052,6 +1053,16 @@ static const struct of_device_id omap_i2c_of_match=
[] =3D {
>  MODULE_DEVICE_TABLE(of, omap_i2c_of_match);
>  #endif
> =20
> +#define OMAP_I2C_SCHEME(rev)		((rev & 0xc000) >> 14)
> +
> +#define OMAP_I2C_REV_SCHEME_0_MAJOR(rev) (rev >> 4)
> +#define OMAP_I2C_REV_SCHEME_0_MINOR(rev) (rev & 0xf)
> +
> +#define OMAP_I2C_REV_SCHEME_1_MAJOR(rev) ((rev & 0x0700) >> 7)
> +#define OMAP_I2C_REV_SCHEME_1_MINOR(rev) (rev & 0x1f)
> +#define OMAP_I2C_SCHEME_0		0
> +#define OMAP_I2C_SCHEME_1		1
> +
>  static int __devinit
>  omap_i2c_probe(struct platform_device *pdev)
>  {
> @@ -1064,6 +1075,8 @@ omap_i2c_probe(struct platform_device *pdev)
>  	const struct of_device_id *match;
>  	int irq;
>  	int r;
> +	u32 rev;
> +	u16 minor, major;
> =20
>  	/* NOTE: driver uses the static register mapping */
>  	mem =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> @@ -1117,11 +1130,6 @@ omap_i2c_probe(struct platform_device *pdev)
> =20
>  	dev->reg_shift =3D (dev->flags >> OMAP_I2C_FLAG_BUS_SHIFT__SHIFT) & 3;
> =20
> -	if (dev->dtrev =3D=3D OMAP_I2C_IP_VERSION_2)
> -		dev->regs =3D (u8 *)reg_map_ip_v2;
> -	else
> -		dev->regs =3D (u8 *)reg_map_ip_v1;
> -
>  	pm_runtime_enable(dev->dev);
>  	pm_runtime_set_autosuspend_delay(dev->dev, OMAP_I2C_PM_TIMEOUT);
>  	pm_runtime_use_autosuspend(dev->dev);
> @@ -1130,7 +1138,31 @@ omap_i2c_probe(struct platform_device *pdev)
>  	if (IS_ERR_VALUE(r))
>  		goto err_free_mem;
> =20
> -	dev->rev =3D omap_i2c_read_reg(dev, OMAP_I2C_REV_REG) & 0xff;
> +	/*
> +	 * Read the Rev hi bit-[15:14] ie scheme this is 1 indicates ver2.
> +	 * On omap3 Offset 4 is IE Reg the bit [15:14] is XDR_IE which is 0

comment is wrong. You talk about 2 bits and document only one of them.
Also, this is valid for all OMAPs until OMAP3, comment should probably
read: On OMAP1/2/3 offset 0x04 is.....

> +	 * at reset. Also since the omap_i2c_read_reg uses reg_map_ip_* a
> +	 * raw_readw is done.
> +	 */
> +	rev =3D __raw_readw(dev->base + 0x04);
> +
> +	switch (OMAP_I2C_SCHEME(rev)) {
> +	case OMAP_I2C_SCHEME_0:
> +		dev->regs =3D (u8 *)reg_map_ip_v1;
> +		dev->rev =3D omap_i2c_read_reg(dev, OMAP_I2C_REV_REG) & 0xff;

drop the 0xff. Top byte is supposed to be zero and if it's not, we want
to know what they hold.

> +		minor =3D OMAP_I2C_REV_SCHEME_0_MAJOR(dev->rev);
> +		major =3D OMAP_I2C_REV_SCHEME_0_MAJOR(dev->rev);
> +		break;
> +	case OMAP_I2C_SCHEME_1:
> +		/* FALLTHROUGH */
> +	default:
> +		dev->regs =3D (u8 *)reg_map_ip_v2;
> +		rev =3D (rev << 16) |
> +			omap_i2c_read_reg(dev, OMAP_I2C_IP_V2_REVNB_LO);
> +		minor =3D OMAP_I2C_REV_SCHEME_1_MINOR(rev);
> +		major =3D OMAP_I2C_REV_SCHEME_1_MAJOR(rev);
> +		dev->rev =3D rev;
> +	}
> =20
>  	dev->errata =3D 0;
> =20
> @@ -1155,7 +1187,7 @@ omap_i2c_probe(struct platform_device *pdev)
> =20
>  		dev->fifo_size =3D (dev->fifo_size / 2);
> =20
> -		if (dev->rev < OMAP_I2C_REV_ON_3630_4430)
> +		if (dev->rev < OMAP_I2C_REV_ON_3630)
>  			dev->b_hw =3D 1; /* Enable hardware fixes */

looks like this was applicable to 4430 too, what happened ?

--=20
balbi

--KFztAG8eRSV9hGtP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQl2/CAAoJEIaOsuA1yqREu0AP/RowfdC9OqS5HMdiR1oCDVu+
EebJpIl8m30Y1Blsk8DFGOa1gIYIsICcW8m+Ls+0niHCPzQbooyz41SnSV5zquSd
hscPITRo2PP9aj7MI6q0855r+u2HsFNQ66BaD4aciirm1GlttHAPihMWsejiNKFC
AkRcZklaDEZTNuXQYIl/9a27mix70PveJtWRuunJe7DpVdLiTYdFASkXJDGZXsBl
9xBZRze5bKxVdtkVMFKy7efyEO3UbmUN6X0boAXT1sfE3Gb4q18cVMXfob369dcZ
ta7Ynq1FaafO15m93Zpfd5JY9R5FAD/c5zmYg1Kg7fh7RU/VrQOcNz3ksmKEqDGa
CsBArtVSN03zqmUlT0+Rg7yvCFEV/7UucVJEkVOmyrd7qi/FIfpJE5xWPmxPV991
bRSshetdqkPAfIVufOc9X3cGJMmqBfDxuxdCTK3Z6m+BKJRow2Yz/nLAtb45jBYf
+8W621zcwEP7x6hE3m7xjfHS6SLaruHwktQ3+OwFhkRhm9RXl9Gn3QLsTQuXgEap
Ka6yMjHNwoI1RB+zUy2F/xJKOti2TbdcANOe/o2wwTMDPbEqf3iCRW95Oi8AZnk8
ydxqVpEF+UnM+qBfGpVwYG1xKMxkj7xWAZwX+LI7U6gqKI481khb1ZSPX67D/2Vg
XCipdFOf8NBHJfkSLDCZ
=DYKc
-----END PGP SIGNATURE-----

--KFztAG8eRSV9hGtP--
