From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: OMAP DSS: panel-dpi and enable gpios
Date: Thu, 15 May 2014 16:18:53 +0300
Message-ID: <5374BEBD.4060305@ti.com>
References: <CAGhQ9VxDQaRzjCMm1RfxVmPt7Nk14ZTeS0-BmBfFDcxQNy__Tw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="1v08wOoqeHVJruleARWPl1j4pnUIX26gU"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:53757 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751455AbaEONS6 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 15 May 2014 09:18:58 -0400
In-Reply-To: <CAGhQ9VxDQaRzjCMm1RfxVmPt7Nk14ZTeS0-BmBfFDcxQNy__Tw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Joachim Eastwood <manabian@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org

--1v08wOoqeHVJruleARWPl1j4pnUIX26gU
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 12/05/14 20:58, Joachim Eastwood wrote:
> Hello Tomi,
>=20
> There seems to be a mismatch between your panel-dpi code and DT docs.
>=20
> The docs state that enable-gpios is optinal but in panel-dpi.c you
> have the following code
> gpio =3D devm_gpiod_get(&pdev->dev, "enable");
> if (IS_ERR(gpio)) {
>     dev_err(&pdev->dev, "failed to parse enable gpio\n");
>     return PTR_ERR(gpio);
> } else {
>     gpiod_direction_output(gpio, 0);
>     ddata->enable_gpio =3D gpio;
> }
>=20
> Making probing fail on my DT since I don't use enable-gpios with

Would this work? Only compile tested.

diff --git a/drivers/video/fbdev/omap2/displays-new/panel-dpi.c b/drivers=
/video/fbdev/omap2/displays-new/panel-dpi.c
index dca6b10d1157..2ac38eaa4c8f 100644
--- a/drivers/video/fbdev/omap2/displays-new/panel-dpi.c
+++ b/drivers/video/fbdev/omap2/displays-new/panel-dpi.c
@@ -210,14 +210,19 @@ static int panel_dpi_probe_of(struct platform_devic=
e *pdev)
 	struct gpio_desc *gpio;
=20
 	gpio =3D devm_gpiod_get(&pdev->dev, "enable");
+
 	if (IS_ERR(gpio)) {
-		dev_err(&pdev->dev, "failed to parse enable gpio\n");
-		return PTR_ERR(gpio);
+		r =3D PTR_ERR(gpio);
+		if (r =3D=3D -EPROBE_DEFER || r !=3D -ENOENT)
+			return r;
+		else
+			gpio =3D NULL;
 	} else {
 		gpiod_direction_output(gpio, 0);
-		ddata->enable_gpio =3D gpio;
 	}
=20
+	ddata->enable_gpio =3D gpio;
+
 	ddata->backlight_gpio =3D -ENOENT;
=20
 	r =3D of_get_display_timing(node, "panel-timing", &timing);



--1v08wOoqeHVJruleARWPl1j4pnUIX26gU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTdL69AAoJEPo9qoy8lh71mBYP/A6H83OM5PCLMy8BYZ3VJUv6
vVY8xMscOjU/jCZUVsyrFSzvXVQfFVx32jZo4wdoJUnxRmlj8/3dsIJYJE7kPiK3
mNbQIx89Z7/dNWm0dg7o3NIjdiMv0xvwXURXqk5VcxRlLGpPFBiLTian0fCedvUX
I18SZDik9QdEwMJpK5TFe+TusK3z+l3z9Gezhz03sJ+6d/njY2WGrKxdVfAgrgtV
lit7j9OLi7vBebdV7iNb3WA3HkoVYxmMBex2mdugvA/SHjojIs3KvsFL+8vJOr88
UInRMHKlf9Y2iDlULjxGFst1xmeXj7sjrqCFL4K6WFl+iQNOzVjFrCq88dfdcLRH
IoKC/mMvFcVIkx40NJM5IeUNI+gPj2gwd5EgVhVPIu6ENqv4UCS4fX3tkGMxrjRW
xb36qRMjZCN9dPV6US2bFi4lNTtDVOYpcXQ3Yh6MqKg434ic6TcBLy8UU8hXfp7+
ZGLlTP8mSjKecDFYbqLk5hkNApqY/yVW0RL++WyqwevTef8VeThBd7m446MuZpPX
S+NlseXQCCcCZuXhyPMLw0fkc0ZCAk+vKETs/hOv/xb+mGS9Xf7xQs1hOO4+2udS
1rWG6C/XlIx+VJ8P8GQ1aZC5+/8r8ObGcWL9TyU4gkU0oxvudCtqZrhZG8qW61cz
tjGdirmk2C5yutyHRxqe
=oCbx
-----END PGP SIGNATURE-----

--1v08wOoqeHVJruleARWPl1j4pnUIX26gU--
