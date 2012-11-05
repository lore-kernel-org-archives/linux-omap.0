From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCHv3 1/8] i2c: omap: Fix the revision register read
Date: Mon, 5 Nov 2012 16:11:03 +0200
Message-ID: <20121105141103.GB4815@arwen.pp.htv.fi>
References: <1352118223-3796-1-git-send-email-shubhrajyoti@ti.com>
 <1352118223-3796-2-git-send-email-shubhrajyoti@ti.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UHN/qo2QbUvPLonB"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:37262 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751606Ab2KEOR3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 5 Nov 2012 09:17:29 -0500
Content-Disposition: inline
In-Reply-To: <1352118223-3796-2-git-send-email-shubhrajyoti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Shubhrajyoti D <shubhrajyoti@ti.com>
Cc: linux-omap@vger.kernel.org, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, ben-linux@fluff.org, tony@atomide.com, b-cousson@ti.com, balbi@ti.com, w.sang@pengutronix.de

--UHN/qo2QbUvPLonB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 05, 2012 at 05:53:36PM +0530, Shubhrajyoti D wrote:
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

Reviewed-by: Felipe Balbi <balbi@ti.com>

> Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
> ---
> v3: Fix the comments.
>=20
>  drivers/i2c/busses/i2c-omap.c |   61 ++++++++++++++++++++++++++++++++---=
------
>  1 files changed, 48 insertions(+), 13 deletions(-)
>=20
> diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
> index db31eae..5c6f538 100644
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
> +	 * On omap1/3/2 Offset 4 is IE Reg the bit [15:14] is 0 at reset.
> +	 * Also since the omap_i2c_read_reg uses reg_map_ip_* a
> +	 * raw_readw is done.
> +	 */
> +	rev =3D __raw_readw(dev->base + 0x04);
> +
> +	switch (OMAP_I2C_SCHEME(rev)) {
> +	case OMAP_I2C_SCHEME_0:
> +		dev->regs =3D (u8 *)reg_map_ip_v1;
> +		dev->rev =3D omap_i2c_read_reg(dev, OMAP_I2C_REV_REG);
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
> =20
>  		/* calculate wakeup latency constraint for MPU */
> @@ -1198,7 +1230,7 @@ omap_i2c_probe(struct platform_device *pdev)
>  	}
> =20
>  	dev_info(dev->dev, "bus %d rev%d.%d.%d at %d kHz\n", adap->nr,
> -		 dev->dtrev, dev->rev >> 4, dev->rev & 0xf, dev->speed);
> +		 dev->dtrev, major, minor, dev->speed);
> =20
>  	of_i2c_register_devices(adap);
> =20
> @@ -1264,6 +1296,9 @@ static int omap_i2c_runtime_resume(struct device *d=
ev)
>  	struct platform_device *pdev =3D to_platform_device(dev);
>  	struct omap_i2c_dev *_dev =3D platform_get_drvdata(pdev);
> =20
> +	if (!_dev->regs)
> +		return 0;
> +
>  	if (_dev->flags & OMAP_I2C_FLAG_RESET_REGS_POSTIDLE) {
>  		omap_i2c_write_reg(_dev, OMAP_I2C_CON_REG, 0);
>  		omap_i2c_write_reg(_dev, OMAP_I2C_PSC_REG, _dev->pscstate);
> --=20
> 1.7.5.4
>=20

--=20
balbi

--UHN/qo2QbUvPLonB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQl8j3AAoJEIaOsuA1yqREYYYQALQdkS/53tbNaaFsNQURaVaT
B6cRnXY5DcSVFGGdmRMTeFaOetf/i1S7CF+tH2dHahWo3bpOn3s0j8g2FlP/Wzbh
AaG2ryDazR6zgWEsa+KQ2nC0j7ufvryXr2EknWUCOxpOCsNifDVHoZP68JbPheD9
RnvBJRHrEHH4jctGdRHEAEOXKEr4NiGtXtoO8yM1L9gdDBZ98SIziClCo4gjFyyU
wkgXfJpPlcL/i7QiBcIYmLNyzoK7pwZ4uLE03P+x8sF8314k2WmKs3iHg3KLW0ty
QRfFEvyvTD0dUEEDdwy3SuZttLLyQvbr9yJP6jCJ6CWBcxgw5aBr4LLvucJgKXM1
vB+6gNMlji+3YJsHW6WsslU0xt1kuaBTl430E+lM1cYKsoJ2/xU2rdGhpkT+Bsbw
oX2XznT+rytCwb3eSlfDOJ1goDrLJUXERspyq87+Rs0ZOLSrC6Vp7kd5/YwGmyQJ
wVVPWbJdEBezoR56wPIXigeHEfiKyz94sLlT8iIOewPHsf99TCBf0tQyAEyFVPBv
0tMpDgRshvBUWiNGzJHvYl090upYqsmH5oJCoO/67phhllzcKFmWz0+U33sDwvHt
C+GPbR7zK3h0Ks5fsgo8q/LGH2LAVRMxkmT8WOSmvYTa/LZpXIoYt4uLv++HFv0d
OTh7mPYGedF0WH2gFBc+
=kAY9
-----END PGP SIGNATURE-----

--UHN/qo2QbUvPLonB--
