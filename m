From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: OMAP DSS: panel-dpi and enable gpios
Date: Fri, 16 May 2014 10:44:49 +0300
Message-ID: <5375C1F1.7000606@ti.com>
References: <CAGhQ9VxDQaRzjCMm1RfxVmPt7Nk14ZTeS0-BmBfFDcxQNy__Tw@mail.gmail.com>	<5374BEBD.4060305@ti.com> <CAGhQ9VwyrO-G4m8Rv-nEUujEmQn+tkDn+9=BwvhU-ZSk0eFtvg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="TUBOTxLgNGR4o3d39nDI4s8FcVttQ93RE"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:35061 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751956AbaEPHox (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 16 May 2014 03:44:53 -0400
In-Reply-To: <CAGhQ9VwyrO-G4m8Rv-nEUujEmQn+tkDn+9=BwvhU-ZSk0eFtvg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Joachim Eastwood <manabian@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org

--TUBOTxLgNGR4o3d39nDI4s8FcVttQ93RE
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 16/05/14 00:02, Joachim Eastwood wrote:
> On 15 May 2014 15:18, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
>> On 12/05/14 20:58, Joachim Eastwood wrote:
>>> Hello Tomi,
>>>
>>> There seems to be a mismatch between your panel-dpi code and DT docs.=

>>>
>>> The docs state that enable-gpios is optinal but in panel-dpi.c you
>>> have the following code
>>> gpio =3D devm_gpiod_get(&pdev->dev, "enable");
>>> if (IS_ERR(gpio)) {
>>>     dev_err(&pdev->dev, "failed to parse enable gpio\n");
>>>     return PTR_ERR(gpio);
>>> } else {
>>>     gpiod_direction_output(gpio, 0);
>>>     ddata->enable_gpio =3D gpio;
>>> }
>>>
>>> Making probing fail on my DT since I don't use enable-gpios with
>>
>> Would this work? Only compile tested.
>>
>> diff --git a/drivers/video/fbdev/omap2/displays-new/panel-dpi.c b/driv=
ers/video/fbdev/omap2/displays-new/panel-dpi.c
>> index dca6b10d1157..2ac38eaa4c8f 100644
>> --- a/drivers/video/fbdev/omap2/displays-new/panel-dpi.c
>> +++ b/drivers/video/fbdev/omap2/displays-new/panel-dpi.c
>> @@ -210,14 +210,19 @@ static int panel_dpi_probe_of(struct platform_de=
vice *pdev)
>>         struct gpio_desc *gpio;
>>
>>         gpio =3D devm_gpiod_get(&pdev->dev, "enable");
>> +
>>         if (IS_ERR(gpio)) {
>> -               dev_err(&pdev->dev, "failed to parse enable gpio\n");
>> -               return PTR_ERR(gpio);
>> +               r =3D PTR_ERR(gpio);
>> +               if (r =3D=3D -EPROBE_DEFER || r !=3D -ENOENT)
>> +                       return r;
>> +               else
>> +                       gpio =3D NULL;
>>         } else {
>>                 gpiod_direction_output(gpio, 0);
>> -               ddata->enable_gpio =3D gpio;
>>         }
>>
>> +       ddata->enable_gpio =3D gpio;
>> +
>>         ddata->backlight_gpio =3D -ENOENT;
>>
>>         r =3D of_get_display_timing(node, "panel-timing", &timing);
>=20
> Seems to do the trick here.
>=20
> Display is showing Tux's on boot up again :)

The check above was a bit too complex. Here's an updated patch.

=46rom f48b44ca73e29b2328e7852d9beb06b161bb1cb4 Mon Sep 17 00:00:00 2001
From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Thu, 15 May 2014 16:19:44 +0300
Subject: [PATCH] OMAPDSS: panel-dpi: enable-gpio

The enable gpio should be optional, but the driver returns an error if
it doesn't get the gpio.

So change the driver to accept -ENOENT error.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/fbdev/omap2/displays-new/panel-dpi.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/video/fbdev/omap2/displays-new/panel-dpi.c b/drivers=
/video/fbdev/omap2/displays-new/panel-dpi.c
index dca6b10d1157..3636b61dc9b4 100644
--- a/drivers/video/fbdev/omap2/displays-new/panel-dpi.c
+++ b/drivers/video/fbdev/omap2/displays-new/panel-dpi.c
@@ -210,14 +210,18 @@ static int panel_dpi_probe_of(struct platform_devic=
e *pdev)
 	struct gpio_desc *gpio;
=20
 	gpio =3D devm_gpiod_get(&pdev->dev, "enable");
+
 	if (IS_ERR(gpio)) {
-		dev_err(&pdev->dev, "failed to parse enable gpio\n");
-		return PTR_ERR(gpio);
+		if (PTR_ERR(gpio) !=3D -ENOENT)
+			return PTR_ERR(gpio);
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
--=20
1.9.1





--TUBOTxLgNGR4o3d39nDI4s8FcVttQ93RE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTdcHxAAoJEPo9qoy8lh71+jYP/0GpAoX8LttnQDmjhi6rmgZD
6iz4TcN7et9Cog7Lm3Bw0aCQ8HNrgSYO+vVGip12uYvFj+bzm+7hv9SD549hlsdr
so+4m1U6JOpb4npbOMJukWuSOIuwA6Hqi4F7+aw/ZFnIb5kZSErjZzbehvqJxVBo
3kRXqJK4QqAc4Bp0XUnjpdA7y9gvUM3DdzsaNY0E6iH5glOUC8GII/P9VM06FXrH
vgizcQtTVxiNSCIIeLCm8jduaR25GJkLIzvDgRfqccgG2gL/BWe3rzJGeagCrSp4
bNOMRsE1yxFxuvE2HNv/9yhxLQZorYrVsUwlUgUlwIo1uVjrgtDaEp5kKxzJlfDL
DeO3lFDfUBcCsxOHmpo9zk84MDaOInQh9wNAMQpUX1g6sHBNPDn9GhWJBGHGugxg
CyJSZMKDZ1xHIUYHLOdov6EUfRcvnLM1SGN0dfvtDkfgBxK1nmYQSLVEVgfhbzq7
mSeZDPJPvN/yU7/UFHYk8HlsD2mIPassZmN/EsWX5an1nj082MLai/afoFg4kcZ4
Xg3zDfIwuEg42LpKrB9vAE/oHgiFGE9TsdWUYnp+RyiXr5HPqK/j5rm4BL14wpIi
L625tHl9O/poSgjxbX0fPYCondphR9Od5K0rr9Qzqj4ugP0ZnpLEjZ5Y5m42Lu0a
vH12If9goHbmKC5HvP72
=I7tY
-----END PGP SIGNATURE-----

--TUBOTxLgNGR4o3d39nDI4s8FcVttQ93RE--
