From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [Letux-kernel] [PATCH v5 3/5] misc serdev: Add w2sg0004 (gps
 receiver) power control driver
Date: Mon, 12 Feb 2018 16:25:47 +0100
Message-ID: <20180212152547.GA13962@amd>
References: <cover.1512114576.git.hns@goldelico.com>
 <5494ad34b39a6c62601e3747440268dfb3be7d5a.1512114576.git.hns@goldelico.com>
 <20171222124427.GI3374@localhost>
 <91850CC3-B280-4701-9D07-96AFF3A79A6F@goldelico.com>
 <90F9A8E4-035A-4A9E-8AAB-757491D63E69@goldelico.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="PEIAKu/WMn1b1Hv9"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <90F9A8E4-035A-4A9E-8AAB-757491D63E69@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: Johan Hovold <johan@kernel.org>, Mark Rutland <mark.rutland@arm.com>, DTML <devicetree@vger.kernel.org>, linux-omap <linux-omap@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Tony Lindgren <tony@atomide.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, kernel@pyra-handheld.com, Russell King <linux@armlinux.org.uk>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson@baylibre.com>, Kevin Hilman <khilman@baylibre.com>, Thierry Reding <treding@nvidia.com>, Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>, Jonathan Cameron <jic23@kernel.org>, Discussions about the Letux Kernel <letux-kernel@openphoenux.org>
List-Id: linux-omap@vger.kernel.org


--PEIAKu/WMn1b1Hv9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> >> I'm sorry (and I know this discussion has been going on for a long
> >> time),but this still feels like too much of a hack.
>=20
> Happy new year ... Happy new attempt...
>=20
> Let's restart this discussion and focus on the main roadblock (others are=
 minor
> details which can be sorted out later).
>=20
> If it feels like a hack, the key issue seems to me to be the choice of
> the API to present the GPS data to user space. Right?
>=20
> I see three reasonable options how this presentation can be done:
>=20
> 1. char device
> 2. tty device
> 3. some new gps interface API (similar to network, bluetooth interfaces)
> 4. no driver and use the UART tty directly

> 3. some new gps interface API
> + could become very elegant and general
> - does not exist (AFAIK not even a plan but I am not aware of everything)
> - no user-space daemons and applications exist which use it

Yes, that is what needs to be done. It is very similar problem to
serial mice we used to have long time ago. (And it has pretty much
same solution; exporting NMEA for gpsd, then slowly moving to system
with no gpsd).

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--PEIAKu/WMn1b1Hv9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlqBsfsACgkQMOfwapXb+vIztgCgpEcmQ7dvaYf7kgZRjfe0YBDw
v+gAoMKpp9BRiTQ1XZyg/N2O0lebNF7X
=NWEi
-----END PGP SIGNATURE-----

--PEIAKu/WMn1b1Hv9--
