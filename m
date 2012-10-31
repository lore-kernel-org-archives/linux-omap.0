From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH RFC] i2c: omap: Fix the revision register read
Date: Wed, 31 Oct 2012 12:12:01 +0200
Message-ID: <20121031101201.GB10094@arwen.pp.htv.fi>
References: <1351673959-5918-1-git-send-email-shubhrajyoti@ti.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/NkBOFFp2J2Af1nK"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:46522 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932975Ab2JaKSS (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 31 Oct 2012 06:18:18 -0400
Content-Disposition: inline
In-Reply-To: <1351673959-5918-1-git-send-email-shubhrajyoti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Shubhrajyoti D <shubhrajyoti@ti.com>
Cc: linux-omap@vger.kernel.org, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, ben-linux@fluff.org, tony@atomide.com, b-cousson@ti.com, w.sang@pengutronix.de

--/NkBOFFp2J2Af1nK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Oct 31, 2012 at 02:29:19PM +0530, Shubhrajyoti D wrote:
> The revision register on OMAP4 is a 16-bit lo and a 16-bit
> hi. Currently the driver reads only the lower 8-bits.
> Fix the same by preventing the truncating of the rev register
> for OMAP4.

very good, but you need to test this with OMAP2/3/4 (5 ??). How was this
tested ?

> Also use the scheme bit ie bit-14 of the hi register to know if it
> is OMAP_I2C_IP_VERSION_2.
>=20
> On platforms previous to OMAP4 the offset 0x04 is IE register whose
> bit-14 reset value is 0, the code uses the same to its advantage.
>=20
> The dev->regs is populated after reading the rev_hi. A NULL check
> has been added in the resume handler to prevent the access before
> the setting of the regs.

this could get some rephrasing, I guess. At least to me it's difficult
to understand what you mean :-s

> Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
> ---
> todo: some of the flag checks can be removed in favour of revision check.
>=20
>  drivers/i2c/busses/i2c-omap.c |   35 +++++++++++++++++++++++++----------
>  1 files changed, 25 insertions(+), 10 deletions(-)
>=20
> diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
> index db31eae..651a7f7 100644
> --- a/drivers/i2c/busses/i2c-omap.c
> +++ b/drivers/i2c/busses/i2c-omap.c
> @@ -51,7 +51,8 @@
>  /* I2C controller revisions present on specific hardware */
>  #define OMAP_I2C_REV_ON_2430		0x36
>  #define OMAP_I2C_REV_ON_3430_3530	0x3C
> -#define OMAP_I2C_REV_ON_3630_4430	0x40
> +#define OMAP_I2C_REV_ON_3630		0x40
> +#define OMAP_I2C_REV_ON_4430_PLUS	0x5040

I would rather see a proper decoding of the revision, meaning that you
would:

For omap2/3:

rev major =3D rev >> 8;
rev minor =3D rev & 0xff;

For OMAP4/5:

well, that's a lot more complex, but you have that data ;-)

>  /* timeout waiting for the controller to respond */
>  #define OMAP_I2C_TIMEOUT (msecs_to_jiffies(1000))
> @@ -202,7 +203,7 @@ struct omap_i2c_dev {
>  						 * fifo_size=3D=3D0 implies no fifo
>  						 * if set, should be trsh+1
>  						 */
> -	u8			rev;
> +	u16			rev;

IMHO this should be u32, so you don't need rev_lo and rev_hi below.

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
> @@ -1064,6 +1065,8 @@ omap_i2c_probe(struct platform_device *pdev)
>  	const struct of_device_id *match;
>  	int irq;
>  	int r;
> +	u16 rev_lo;
> +	u16 rev_hi;
> =20
>  	/* NOTE: driver uses the static register mapping */
>  	mem =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> @@ -1117,11 +1120,6 @@ omap_i2c_probe(struct platform_device *pdev)
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
> @@ -1130,7 +1128,21 @@ omap_i2c_probe(struct platform_device *pdev)
>  	if (IS_ERR_VALUE(r))
>  		goto err_free_mem;
> =20
> -	dev->rev =3D omap_i2c_read_reg(dev, OMAP_I2C_REV_REG) & 0xff;
> +	/* Read the Rev hi bit-14 ie scheme this is 1 indicates ver2 or
> +	* highlander.

the "scheme" in highlander is a 2 bit value. In order to make this
future proof, you need to read both bits (31:30).

> +	* On omap3 Offset 4 is IE Reg the bit 14 is XDR_IE which is 0 at reset.
> +	*/

please align the * characters.

> +	rev_hi =3D __raw_readw(dev->base + 0x04);

you should make omap_i2c_read_reg() work fine for this case too.

> +
> +	if (rev_hi & 0x4000) {/* If scheme 1*/

you should add a symbolic define for scheme, something like:

switch (OMAP_I2C_SCHEME(rev)) {
case OMAP_I2C_SCHEME_1:
	foo();
	break;
case OMAP_I2C_SCHEME_2:
	/* FALLTHROUGH */
default:
	bar();
}

note that this will also default to highest known scheme if another
scheme is added. You need to make the driver behave like that to
decrease amount of rework to support newest OMAPs.

> +		dev->regs =3D (u8 *)reg_map_ip_v2;
> +		dev->rev =3D omap_i2c_read_reg(dev, OMAP_I2C_IP_V2_REVNB_HI);
> +		rev_lo =3D omap_i2c_read_reg(dev, OMAP_I2C_IP_V2_REVNB_LO);
> +		dev_info(dev->dev, "the low rev %x\n", rev_lo);
> +	} else {
> +		dev->regs =3D (u8 *)reg_map_ip_v1;
> +		dev->rev =3D omap_i2c_read_reg(dev, OMAP_I2C_REV_REG) & 0xff;
> +	}
> =20
>  	dev->errata =3D 0;
> =20
> @@ -1155,7 +1167,7 @@ omap_i2c_probe(struct platform_device *pdev)
> =20
>  		dev->fifo_size =3D (dev->fifo_size / 2);
> =20
> -		if (dev->rev < OMAP_I2C_REV_ON_3630_4430)
> +		if (dev->rev < OMAP_I2C_REV_ON_3630)
>  			dev->b_hw =3D 1; /* Enable hardware fixes */
> =20
>  		/* calculate wakeup latency constraint for MPU */
> @@ -1264,6 +1276,9 @@ static int omap_i2c_runtime_resume(struct device *d=
ev)
>  	struct platform_device *pdev =3D to_platform_device(dev);
>  	struct omap_i2c_dev *_dev =3D platform_get_drvdata(pdev);
> =20
> +	if (!_dev->regs)
> +		return 0;

this is wrong, you need to make sure dev->regs is set early enough.

--=20
balbi

--/NkBOFFp2J2Af1nK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQkPlxAAoJEIaOsuA1yqREsrwQAJNH0I8j3BP4V2a7LqzZgr27
AdDVrULzEGuAxp+w5V2iBcVFwN1i/IlAni3vS0GXMDg4MsEH2nicO4SZ4eSRMS4L
SxeYMdQsLcAxGXKpfVMDUblNqD35u0boGoAWHlyberryHZpkwXvb3SWMDH5LfXhl
VmqmTfvFcFNiFp5AFbt5cQK+5KwHwGWjHyQrmI5bNY1n7zVRbqLHQLEVHlyt3m5s
pOut0Hi0TMoxFpBf3idU/SI2tqXJS4eOlLnlv0JlMdp5Bx+dj/y54i0ujuFwXQfw
2+SPO4El42ypA5+fUxZanT8wDAOBE1i45Hb+j+QjJrrDSp93ytmkN0Y5NEyGfGkT
7n/SiGVXRPYdizAH+R0+IceZCGLnH3p12azlvKrMKMtjFxdxeGokD5wSz2wyPNjq
QIX/8zRWFtNWueE9J6TkOvV+jaXxx3Kk38KFSav5QkNSBaBQwaWvpF9ovXh4fdQY
qTcKXTKRUwKYkLsSqzX5NUFY+McpOIpc/Hyl1usByDBvSEOnIaiSiGObysQFk6X/
45U5OKUvk8ZwN3AMwaEJ9SmbJxKTS/gfs9+nADcvwHqu5/HFmC73FPx5IOYrhX3E
8yiRIz1vcKfi2ZCETcChE4A2Sfcf1NBi7QXIZR3DPF+7O8LuP656j7NC+LknFDBq
y33kOhD0AWJTBo5DCk1s
=sEaf
-----END PGP SIGNATURE-----

--/NkBOFFp2J2Af1nK--
