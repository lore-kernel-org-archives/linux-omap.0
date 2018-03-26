From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [Letux-kernel] [PATCH v5 3/5] misc serdev: Add w2sg0004 (gps
 receiver) power control driver
Date: Mon, 26 Mar 2018 15:59:20 +0200
Message-ID: <20180326135920.GA1450@amd>
References: <5494ad34b39a6c62601e3747440268dfb3be7d5a.1512114576.git.hns@goldelico.com>
 <20171222124427.GI3374@localhost>
 <91850CC3-B280-4701-9D07-96AFF3A79A6F@goldelico.com>
 <90F9A8E4-035A-4A9E-8AAB-757491D63E69@goldelico.com>
 <20180112153903.GB5992@localhost>
 <20180212152618.GC13962@amd>
 <20180227070415.GB18666@localhost>
 <22A8F5FE-C8B9-46EB-B98D-A94EA4170131@goldelico.com>
 <20180319135418.GL18359@localhost>
 <FCD404C1-3DD4-45BD-9242-3F7A7C44F6C9@goldelico.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="SUOF0GtieIMvvwua"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <FCD404C1-3DD4-45BD-9242-3F7A7C44F6C9@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: Johan Hovold <johan@kernel.org>, Mark Rutland <mark.rutland@arm.com>, DTML <devicetree@vger.kernel.org>, Discussions about the Letux Kernel <letux-kernel@openphoenux.org>, =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson@baylibre.com>, Arnd Bergmann <arnd@arndb.de>, Tony Lindgren <tony@atomide.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, kernel@pyra-handheld.com, Russell King <linux@armlinux.org.uk>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-omap <linux-omap@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Kevin Hilman <khilman@baylibre.com>, Thierry Reding <treding@nvidia.com>, Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>, Jonathan Cameron <jic23@kernel.org>
List-Id: linux-omap@vger.kernel.org


--SUOF0GtieIMvvwua
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > No, we need some kind of at least rudimentary gps framework even if we
> > allow for a raw (NMEA) interface for the time being (possibly
> > indefinitely).
>=20
> Ok, that would be fine if we can get that!
>=20
> For a minimal set of API I think something like this (following hci_dev) =
would suffice:
>=20
> struct gps_dev {
> 	...
> 	int (*open)(struct gps_dev *gdev);
> 	int (*close)(struct gps_dev *gdev);
> 	int (*send)(struct gps_dev *gdev, char *data, int length);
> };
>=20
> int gps_register_dev(struct gps_dev *gdev);
> void gps_unregister_dev(struct gps_dev *gdev);
> int gps_recv_nmea_chars(struct gps_dev *gdev, char *data, int length);
>=20
> If that would wrap all creation of some /dev/ttyGPS0 (or however it is ca=
lled),
> it would fit our needs for a driver and user-space for our system.
>=20
> And I would be happy to get rid of creating and registering a /dev/ttyGPS0
> in the w2sg0004 driver.

Sounds like a good start.

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--SUOF0GtieIMvvwua
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlq4/LgACgkQMOfwapXb+vL8hgCfS0UWaS1wC9bm/jIlnajYRwgo
ReUAoIYO2jKAA99I3pDDwchvNGTzCbEZ
=IReX
-----END PGP SIGNATURE-----

--SUOF0GtieIMvvwua--
