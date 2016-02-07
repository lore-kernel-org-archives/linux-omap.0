From: Paul Kocialkowski <contact@paulk.fr>
Subject: Re: [PATCH v2 3/4] ARM: LG Optimus Black (P970) codename sniper
 support, with basic features
Date: Sun, 07 Feb 2016 16:23:51 +0100
Message-ID: <1454858631.2547.7.camel@aldrin>
References: <1454697741-8687-1-git-send-email-contact@paulk.fr>
	 <1454697741-8687-4-git-send-email-contact@paulk.fr>
	 <1454701140.2623.12.camel@collins>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-orC9SjzuTY+QQEEaffKH"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1454701140.2623.12.camel@collins>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Mark Rutland <mark.rutland@arm.com>, Milo Kim <milo.kim@ti.com>, Russell King <linux@arm.linux.org.uk>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Tony Lindgren <tony@atomide.com>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, =?ISO-8859-1?Q?Beno=EEt?= Cousson <bcousson@baylibre.com>, Kumar Gala <galak@codeaurora.org>, Javier Martinez Canillas <javier@dowhile0.org>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org


--=-orC9SjzuTY+QQEEaffKH
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Le vendredi 05 f=C3=A9vrier 2016 =C3=A0 20:39 +0100, Paul Kocialkowski a =
=C3=A9crit :
> Le vendredi 05 f=C3=A9vrier 2016 =C3=A0 19:42 +0100, Paul Kocialkowski a =
=C3=A9crit :
> > The LG Optimus Black (P970) codename sniper is a smartphone that was de=
signed
> > and manufactured by LG Electronics (LGE) and released back in 2011.
> > It is using an OMAP3630 SoC, GP version.
> >=20
> > This adds devicetree support for the device, with only a few basic feat=
ures
> > supported, such as debug uart, i2c, internal emmc and external mmc.

[snip}

> > +&mmc2 {
> > +
>=20
> Please discard this newline in case v2 gets merged.

All things considered, I'd rather not have this patch merged as-is, but
wait for the next version.

I'll wait for feedback before sending v3.

--=20
Paul Kocialkowski, Replicant developer

Replicant is a fully free Android distribution running on several
devices, a free software mobile operating system putting the emphasis on
freedom and privacy/security.

Website: https://www.replicant.us/
Blog: https://blog.replicant.us/
Wiki/tracker/forums: https://redmine.replicant.us/


--=-orC9SjzuTY+QQEEaffKH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAABAgAGBQJWt2GHAAoJEIT9weqP7pUMdWAP/17uFA/yrclKe9LAGFUrGCLm
C4ddc9/EJI3RG8nVZml787vuv+TjOVv/Rz/sJft3AjMkEuSJkRSOUARm0g93yN/m
jwiMqcHt0FN9iPl8ZYAqTa3epdrcgdrEL8AOtzqm1h4e/hJ0B2vDzht8AXDCNq0A
5uG7uqwv0Twp2z7XUOqYIw4gAHzgyNEWQ83W5FO3qVgjmyG8ZkmlLsMTbVA5EkVH
05y0EGFXxliaS0yBkoP300xqlZZfEujaJYptqdG0u+Xlvb5Bx7Pkod6YgQy0wV5L
YJXc9pF3FK6dQkRAqJ7ow+xdgPBsbdrhua0K/78PnfYlRzV7QyEHb2HnU2Pql93f
PztSRa//QiCv9EVz+1TOJL5wcOQvyvKBflglrqwYKla4m8kN+tlnlvKFYCLGke5i
LmTDJ/VXyO9/SQ5+tO13qkPuPs1cYm0BVXCiZIDuJ9/OaS2rr1t1de1LXOWkQ+6H
RX6Fl6W8vsYhBKTYphfHniq3fOspBgrlxODsSlg7H8oxiScgpAp5GsTbyn40yTQ0
FgAyl3scV1Ez/H4luOTWd2vz+QT38+1jWMQsVmGhTHS18b5286rc5lbEN7EMaKAl
7tCsojrd2QhbPITreW4/XAc5M3faWRB1egy0CUZ3uaR0oKFy/EfjP5t+jkvT0U7o
AmnuHG7i0qdGSCnA3fMt
=o1ga
-----END PGP SIGNATURE-----

--=-orC9SjzuTY+QQEEaffKH--
