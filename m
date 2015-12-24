From: Paul Kocialkowski <contact@paulk.fr>
Subject: Re: [PATCH 5/6] ARM: LG Optimus Black (P970) codename sniper
 support, with basic features
Date: Thu, 24 Dec 2015 20:38:24 +0100
Message-ID: <1450985904.11913.6.camel@collins>
References: <1450868319-20513-1-git-send-email-contact@paulk.fr>
	 <1450868319-20513-6-git-send-email-contact@paulk.fr>
	 <20151223154455.GL2793@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-pUW7c45xG4jNl1s7T6r8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20151223154455.GL2793@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Russell King <linux@arm.linux.org.uk>, =?ISO-8859-1?Q?Beno=EEt?= Cousson <bcousson@baylibre.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Milo Kim <milo.kim@ti.com>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--=-pUW7c45xG4jNl1s7T6r8
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Le mercredi 23 d=C3=A9cembre 2015 =C3=A0 07:44 -0800, Tony Lindgren a =C3=
=A9crit :
> * Paul Kocialkowski <contact@paulk.fr> [151223 03:00]:
> > +&gpio1 {
> > +	ti,no-reset-on-init;
> > +};
> > +
> > +&gpio2 {
> > +	ti,no-reset-on-init;
> > +};
> > +
> > +&gpio3 {
> > +	ti,no-reset-on-init;
> > +};
> > +
> > +&gpio4 {
> > +	ti,no-reset-on-init;
> > +};
> > +
> > +&gpio5 {
> > +	ti,no-reset-on-init;
> > +};
> > +
> > +&gpio6 {
> > +	ti,no-reset-on-init;
> > +};
>=20
> Care to try to narrow down exactly which GPIO(s) need to be preserved?
> Chances are this will unnecessarily block deeper idle states in hardware
> otherwise.
>=20
> My guess is that the GPIO pins that need to be preserved if any are in
> the GPIO bank 1 as that's always powered..

Well, I actually need to keep the GPIOs handling backlight control,
buttons LEDs and the micro USB connector muxing (which can be set to
UART or USB). Those are spread accross gpio2, gpio5 and gpio6, so I'll
only enable these in v2.

Thanks for the review!

--=20
Paul Kocialkowski, Replicant developer

Replicant is a fully free Android distribution running on several
devices, a free software mobile operating system putting the emphasis on
freedom and privacy/security.

Website: https://www.replicant.us/
Blog: https://blog.replicant.us/
Wiki/tracker/forums: https://redmine.replicant.us/


--=-pUW7c45xG4jNl1s7T6r8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAABAgAGBQJWfEmwAAoJEIT9weqP7pUMhsQQAIrcImYefbG3Bf/0neGywEci
Use2gd/2/LWskk5uUlNevQ3Gn7ZmlAPl6ileL7iq+scT1QX5NOZ6saLfLCnu8wpg
S4pqtKttnrIHN0xICVcc/BbTM005OiQEKnf8fEWRUbqdZptNISfi5yBJmB1aYkBo
NSzGZWn1s+72OuQv6dQhquULeLKGdBLQ6pQOwDfseUdtKeEZXkdL58zK9R9JY+QZ
nXEaJ1XaR49QbMIjl1qjx5sgJ/C4T9g2OhmmuhLesTI3+DZfsvtTPMtLODQzZB33
mERqA6Iqr9t/uiv3iYckQ0v2jkK2HcQymBA7eqgBLEFxMphDEJSw7rayFnPZrAWi
fQowXlSo/gH+IyQvYhn0s+4cHCVdM2WgNs0qA+qg9UYA+nE0uIYxwmmA6/GMx3uC
QVJ2VtbjAli8i1Lce9aGEYmL4PCXYUZY3CPvNRVoLlekzxyvGrZcvXZ2+z/lDMq2
vAmdeSWa3duY1OjyLK6rqY/V7K9tns3TQ0pqxNjF+YrH4GOMI3EnxyODAw9n6iNq
DQ1hMdGrdmknnOrB1V527aNpBTu6c19zyN6kCaWd72aButh1K3IYKuZZz06XE3SH
3//PlirpjIw1WOl4/971GM0qeICXg7uiwdaIaCsO1iM5aQKQGUJ1EisK0b4zEdHa
F8l16xRooZaWgDF/riD2
=7eXU
-----END PGP SIGNATURE-----

--=-pUW7c45xG4jNl1s7T6r8--
