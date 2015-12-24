From: Paul Kocialkowski <contact-W9ppeneeCTY@public.gmane.org>
Subject: Re: [PATCH 5/6] ARM: LG Optimus Black (P970) codename sniper
 support, with basic features
Date: Thu, 24 Dec 2015 20:38:52 +0100
Message-ID: <1450985932.11913.7.camel@collins>
References: <1450868319-20513-1-git-send-email-contact@paulk.fr>
	 <1450868319-20513-6-git-send-email-contact@paulk.fr>
	 <CABxcv=moAUEPo8sq5KhuLZChrQtwjF1aBeNvV1i8HvUnwDXMZA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-VbzVbSVAUd6+5BOmtzcV"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CABxcv=moAUEPo8sq5KhuLZChrQtwjF1aBeNvV1i8HvUnwDXMZA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Javier Martinez Canillas <javier-0uQlZySMnqxg9hUCZPvPmw@public.gmane.org>
Cc: Linux Kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Milo Kim <milo.kim-l0cyMroinI0@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, =?ISO-8859-1?Q?Beno=EEt?= Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org


--=-VbzVbSVAUd6+5BOmtzcV
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Le mercredi 23 d=C3=A9cembre 2015 =C3=A0 13:03 -0300, Javier Martinez Canil=
las a
=C3=A9crit :
> Hello Paul,
>=20
> [snip]
>=20
> > +
> > +&omap3_pmx_core {
> > +       pinctrl-names =3D "default";
> > +
> > +       uart3_pins: pinmux_uart3_pins {
> > +               pinctrl-single,pins =3D <
> > +                       0x16e (PIN_INPUT | MUX_MODE0)           /* uart=
3_rx_irrx */
> > +                       0x170 (PIN_OUTPUT | MUX_MODE0)          /* uart=
3_tx_irtx */
> > +               >;
>=20
> Could you please use the IOPAD mux macros from
> include/dt-bindings/pinctrl/omap.h instead?
>=20
> We just did a massive cleanup on the OMAP DTS to use them instead of
> an offset from the padconf registers.

Sure thing, will do in v2.

Thanks for the review!

--=20
Paul Kocialkowski, Replicant developer

Replicant is a fully free Android distribution running on several
devices, a free software mobile operating system putting the emphasis on
freedom and privacy/security.

Website: https://www.replicant.us/
Blog: https://blog.replicant.us/
Wiki/tracker/forums: https://redmine.replicant.us/


--=-VbzVbSVAUd6+5BOmtzcV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAABAgAGBQJWfEnMAAoJEIT9weqP7pUMmQUP/j936e/+tpkQZVBukaO3FtP6
ijWEFHesx3fCWX5gy28hMVKicQZPciqAMNOzLpkUQauK5O7tWIFr2acU90B7nzP0
pBavhwQakkfGt3fDBzFF95wBmi1oGhnKshaclGyCO/qD1GcjNHOJv5BDLy0BXQLh
R8gwBn5Pj0RdEYhN5/+9v2OxJq7ymzwy4k2EvOI8/9qfbYacpoFM1HTd81voO0Mu
7CzBbEOItl8U2OsjmYcwOKFDnK2f3xrERkLQa+JfSLnC9tnnenyjizfArCTkxYwE
aWMXyHEmYk+LKPPqTzSxIi/C4xaC+924+xNbTUjxH61yXiKF8RlRmfETB4fMs3CK
msuv7MvKr32bA5wiatI1+jAJhgkl33NKbkKvCPd6Wihv9Q0o17QjkU48gRhz63wi
BBjnZFw7Fri5v+8hSWFHDKFoVVZM0KZuG3GWDbZgx0FwBUgzOtSmC09oslrXOOU+
U8K2t1H6PNVEjTVcD1dmqOZHhbl4xbwaNemhZP4EtcNH8Lxe/UJJQaDbGJXKbPnk
8gTsnW33GIncym5noI9HkYKxqcVnD6TSnBR/tPYXp/6QgHBX1P9Ak+6nHjchwlqY
qEJHuJGrQMe5eY1SOk9nJ6+FH/wKEINqWk7K9zO1ZhLXx619WrcufCsyjJtLLnGt
U8IMep7T0r5Ymhjljpq0
=Mfvc
-----END PGP SIGNATURE-----

--=-VbzVbSVAUd6+5BOmtzcV--

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
