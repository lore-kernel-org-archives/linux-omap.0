From: Paul Kocialkowski <contact-W9ppeneeCTY@public.gmane.org>
Subject: Re: [PATCH 4/6] regulator: lp872x: Add enable GPIO pin support
Date: Sat, 16 Jan 2016 08:32:13 +0100
Message-ID: <1452929533.2520.1.camel@collins>
References: <568088B4.6090207@ti.com> <1451342963.14631.13.camel@collins>
	 <5681D7A8.2030101@ti.com> <1451387613.18148.9.camel@collins>
	 <568323B7.7080101@ti.com> <1451464521.2531.4.camel@collins>
	 <20151230163307.GW16023@sirena.org.uk> <1451500639.14341.6.camel@collins>
	 <20151231214007.GC16023@sirena.org.uk> <1451599146.9673.2.camel@collins>
	 <20151231221407.GF16023@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-5+ZdxzqWfNuc7sq0aPX1"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20151231221407.GF16023-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Milo Kim <milo.kim-l0cyMroinI0@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, =?ISO-8859-1?Q?Beno=EEt?= Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org


--=-5+ZdxzqWfNuc7sq0aPX1
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le jeudi 31 d=C3=A9cembre 2015 =C3=A0 22:14 +0000, Mark Brown a =C3=A9crit =
:
> On Thu, Dec 31, 2015 at 10:59:06PM +0100, Paul Kocialkowski wrote:
>=20
> > I understand, thanks for pointing this out. Well, for my use case, ther=
e
> > is no use in disabling the chip at any point as it powers the external
> > mmc.
>=20
> Presumably someone might decide not to use the MMC in some case (perhaps
> only mounting it when explicitly needed in order to save power for
> example, or the MMC subsystem might figure out a way to power down an
> idle MMC block device).
>=20
> > Would you agree to have the enable pin handled directly (and by that, I
> > mean enabled once, when requested, as I first suggested in the patchset=
)
> > in the driver then?
>=20
> That's probably fine, or do it via runtime PM (the framework is fairly
> simple to use, I'll probably go add support in the core for it in the
> next day or two as this seems like a sensible use case).  I can't
> remember if this device is a MFD or not and I'm just on my way out the
> door.

Is there some git tree I can work with that has regulator runtime PM
support at this point? I'll certainly end up handling the GPIO in the
driver otherwise.

--=20
Paul Kocialkowski, Replicant developer

Replicant is a fully free Android distribution running on several
devices, a free software mobile operating system putting the emphasis on
freedom and privacy/security.

Website: https://www.replicant.us/
Blog: https://blog.replicant.us/
Wiki/tracker/forums: https://redmine.replicant.us/


--=-5+ZdxzqWfNuc7sq0aPX1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAABAgAGBQJWmfH9AAoJEIT9weqP7pUMumYQAIPnmij174j29vJCWPGvKplx
EdogGTO1z43Rq2buqlR4eSH4EwsBRi4gx0ID3Ouxzj2TLaGskz06BHD5xUTL6/37
T6RzCVL+8a85zXBygu32y7XSJJ9XOVFd8e3UtTadBqljM46/UUG0J7zURapnz/2u
U5wf66yhsORKq7466pjWD6ECKfzCTmiX/QodU82gVg+OT5Pjm9GA/qjCVVV8EWba
CsoIiA3f2MDzKomosErY+aORsOHmdbhkcZEZ6FycyjikeBmI6VrGFCfAXXUi7YmW
c8xB4taJMKiAT7dQgMm6NEBsXIhc613aQFjPhGZi9XxrEXMczLIX5B7NgtXbaxP2
15jfDTRCU8/yTQsdRTcfJ7BcKT/eot+TWhwck+C0PcKfsyI94Y0npdz8mAxXUi8X
bc3oz7BDlLfoIGNrDBLHqavksfmxnonkXPy05QrMM2e4x7fvL8ab8AA1Ry4Boeuf
XnHRensXGybTp2q1tlBhjXpDaS6xB4efu/8J3fxeKlUP+wS9rcHA9QbvLSZy5ZM7
35EQumd1dgXiQRSP9MuxItGPs2/uWb1aHRZjKDb/j/M6fJLKgszjv7meDHm2Knkb
+9JQyjN7SNKAQaleuRi+6CjhQZiyypGdvNxvVZis0kLRBWvGwyjOxpU45SZFr5aS
IJpaoX4zax1S5/OhPE1i
=p7A7
-----END PGP SIGNATURE-----

--=-5+ZdxzqWfNuc7sq0aPX1--

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
