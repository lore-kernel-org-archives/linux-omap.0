From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [Letux-kernel] [PATCH v5 3/5] misc serdev: Add w2sg0004 (gps
 receiver) power control driver
Date: Tue, 27 Feb 2018 19:38:26 +0100
Message-ID: <20180227183826.GA32473@amd>
References: <cover.1512114576.git.hns@goldelico.com>
 <5494ad34b39a6c62601e3747440268dfb3be7d5a.1512114576.git.hns@goldelico.com>
 <20171222124427.GI3374@localhost>
 <91850CC3-B280-4701-9D07-96AFF3A79A6F@goldelico.com>
 <90F9A8E4-035A-4A9E-8AAB-757491D63E69@goldelico.com>
 <20180112153903.GB5992@localhost>
 <20180212152618.GC13962@amd>
 <20180227070415.GB18666@localhost>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="J2SCkAp4GZ/dPZZf"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180227070415.GB18666@localhost>
Sender: linux-kernel-owner@vger.kernel.org
To: Johan Hovold <johan@kernel.org>
Cc: "H. Nikolaus Schaller" <hns@goldelico.com>, Mark Rutland <mark.rutland@arm.com>, DTML <devicetree@vger.kernel.org>, Thierry Reding <treding@nvidia.com>, Jonathan Cameron <jic23@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Tony Lindgren <tony@atomide.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Russell King <linux@armlinux.org.uk>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, Kevin Hilman <khilman@baylibre.com>, =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson@baylibre.com>, kernel@pyra-handheld.com, Discussions about the Letux Kernel <letux-kernel@openphoenux.org>, linux-omap <linux-omap@vger.kernel.org>, Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>, Linux ARM <linux-arm-kernel@lists>
List-Id: linux-omap@vger.kernel.org


--J2SCkAp4GZ/dPZZf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > > Let's restart this discussion and focus on the main roadblock (othe=
rs
> > > > are minor details which can be sorted out later).
> > > >=20
> > > > If it feels like a hack, the key issue seems to me to be the choice=
 of
> > > > the API to present the GPS data to user space. Right?
> > >=20
> > > Or even more fundamentally, does this belong in the kernel at all?
> >=20
> > Yes, it does.
>=20
> But not necessarily in its current form.

Not necessarily, no. OTOH this hack was not too bad IIRC and we
usually do present NMEA to userspace at the moment. We'll need proper
GPS subsystem one day, but I'm afraid that will take some time...

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--J2SCkAp4GZ/dPZZf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlqVpaIACgkQMOfwapXb+vLVKACcCK9CCeKVQ3hMNwRNIJJgsPv1
XuAAnRVH+t7hwwDq1BgR1dcqpRfgd2e4
=XIu1
-----END PGP SIGNATURE-----

--J2SCkAp4GZ/dPZZf--
