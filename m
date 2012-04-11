From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCHv7 11/18] I2C: OMAP: use devm_* functions
Date: Wed, 11 Apr 2012 14:34:57 +0300
Message-ID: <20120411113456.GF12064@arwen.pp.htv.fi>
References: <1334142776-10583-1-git-send-email-shubhrajyoti@ti.com>
 <1334142776-10583-12-git-send-email-shubhrajyoti@ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gAUgrzRZ7tRi/Yr6"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog138.obsmtp.com ([74.125.149.19]:58788 "EHLO
	psmtp.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1757946Ab2DKLfq (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 11 Apr 2012 07:35:46 -0400
Received: by lagv3 with SMTP id v3so676901lag.41
        for <linux-omap@vger.kernel.org>; Wed, 11 Apr 2012 04:35:43 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1334142776-10583-12-git-send-email-shubhrajyoti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Shubhrajyoti D <shubhrajyoti@ti.com>
Cc: linux-omap@vger.kernel.org, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, ben-linux@fluff.org, tony@atomide.com, w.sang@pengutronix.de


--gAUgrzRZ7tRi/Yr6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 11, 2012 at 04:42:49PM +0530, Shubhrajyoti D wrote:
> The various devm_ functions allocate memory that is released when a driver
> detaches. This patch uses devm_kzalloc, devm_request_mem_region and
> devm_ioremap for data that is allocated in the probe function of a platfo=
rm
> device and is only freed in the remove function.
>=20
> Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
> ---
>  drivers/i2c/busses/i2c-omap.c |   29 +++++++++--------------------
>  1 files changed, 9 insertions(+), 20 deletions(-)
>=20
> diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
> index 121c52e..86be475 100644
> --- a/drivers/i2c/busses/i2c-omap.c
> +++ b/drivers/i2c/busses/i2c-omap.c
> @@ -995,17 +995,17 @@ omap_i2c_probe(struct platform_device *pdev)
>  		return -ENODEV;
>  	}
> =20
> -	ioarea =3D request_mem_region(mem->start, resource_size(mem),
> -			pdev->name);
> +	ioarea =3D devm_request_mem_region(&pdev->dev, mem->start,
> +			resource_size(mem), pdev->name);

you could use devm_request_and_ioremap()

--=20
balbi

--gAUgrzRZ7tRi/Yr6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPhWxgAAoJEIaOsuA1yqRE1UgQALW47R6Z+bM9+UL69N19vE3p
seXWaXrju3F7oYesz2CyJ/ZM90KduhP9sjKQzgrCsvpK5JfBiIiZ3NEB5WG1QIGM
HY068EGJpaiej8DyU4SP2yf6Z3K1B5cxtCfUwdopLBV6mAiMGB6uSrX+uKDIDYAM
AS4LaFwbtxFc0BpWU7OAh42v6rH6EeD/Me7ISe48j7KEmtFGRRt2LvAO6bt/bcpI
lhPxq63x65U19laHm+ueTH94nbSj7+471634A0IE2Os+cXOnFqqeZS9NSFCgctBn
3sITSwGgjTVhVl64HxDGQUwzg25p82fXQwSFEW8wMZCQehzFf8/KjPhuRI5DdFOP
tmQGdvBFqwUDaUP1FADujmi/xDFv9lCK3Is+h+bLmcxNJ4OftIvS5PQiPDBQJF0c
NtuJmn2r5J7hq4TFqSj57rGOAiQHtZbV3v1M84FbDG4u1DFUdb5xHBDtPwENaEnE
BZqWnpSUS8VHdZA7lG76WxGWYYRaod8UHUCLdUTU6XNgYGRyZQmY8VtEecHj0A+i
Xo9KFB7WJU8U2dtgVWcfn97G9JeKjS6LpHAsOSRzbtf66Y/pNQG4R5NRh4kt22QU
tuNA6ugY0TIOsqM0OBjnDlQUdiBIqbB5NVTkan3PANgVJlQp90wWp7JtrgrtoxlK
LniyZg1GUaP/5h1lDRUA
=WwI0
-----END PGP SIGNATURE-----

--gAUgrzRZ7tRi/Yr6--
