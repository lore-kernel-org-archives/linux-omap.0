From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCHv2 00/10] Add memory mapped support for ti qspi, m25p80
 serial flash.
Date: Tue, 10 Dec 2013 16:11:43 +0000
Message-ID: <20131210161143.GK29268@sirena.org.uk>
References: <1386339891-32717-1-git-send-email-sourav.poddar@ti.com>
 <201312101349.13564.marex@denx.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jWPLtjN/TlbXOuX3"
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <201312101349.13564.marex-ynQEQJNshbs@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Cc: Sourav Poddar <sourav.poddar-l0cyMroinI0@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org


--jWPLtjN/TlbXOuX3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 10, 2013 at 01:49:13PM +0100, Marek Vasut wrote:

> My question is, shall we not wait for the new SPI NOR framework to be wel=
l=20
> fleshed out and only then implement this controller driver on top of it ?

> I have a feeling this patchset adds quite a lot of ad-hoc hacks into the =
m25p80=20
> driver, which would become dead code once converted to the SPI NOR framew=
ork.

There is some stuff that pushes up into the controller in that while the
device is in memory mapped mode as far as I can tell it's not safe to do
other accesses so if someone's put more than one device on the SPI bus
we need to handle interactions there.

--jWPLtjN/TlbXOuX3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSpz08AAoJELSic+t+oim9CsgP/RKihfzVyXn4iAdbIi35lGk+
UIp4ZMCB8ZhcKnuYZ/h3IskvxE2uscwSjyrZCSSB1ftuz5gSZftK1++duadAP6nU
BztSGxPK1W74Nd2q+ogY1sfJsj5ICzH21PFw/M7gWS6JT0hczjbFhHFN7OLLYXye
uoSVGlsKKhXvx/csPaPjjn2n/LkGMGhVOHyKNzDPcyPPfA2vKwzNckDJW1JHWx0K
eXCDKkG6jczb1qKPvW1wfXzIy1arYlsxMwSMd/QrPhVziBSPPS7/7mCZGCl6QahI
bUnYMY8gdNxFZi8d1JPk/ZDCScdHEAJihe+IpZ5YXGlwSVHztGe2ebydz5Z5IcTq
pYjTIZWPeJYtrIkpOBpFTUX/O5EmO6EyE2bloqn75AoJov+DyhhZE+9wZszeZD+7
oOy/AV89eQn3xlzmgm79KeKzxA/OrstreA/K1djS7vx5EtR5YlUL9N1Y/uhAiV5G
//BufIYsX3zGQmKHA8e2C/ZB99d6AJIIyH2FoBBh+zhUadR/1HSpqoLa8AfuVNEz
ByDlG4UJH5maHldkcYu09WQyEVg2qGVmFbBT5p1V39+ECFGvzCAmed0R1XfVRaZD
frjPzzzmeRo+Vd1XmLkkwxPH98rsSLtr+lS9tCJnnw38IzcOV1r8dlkJrDaNwXrp
lt1fWSzEK3EIBwlBkIu4
=xR23
-----END PGP SIGNATURE-----

--jWPLtjN/TlbXOuX3--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
