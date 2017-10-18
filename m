From: Pavel Machek <pavel@ucw.cz>
Subject: Re: libbattery was Re: [RFC PATCH 5/5] power: generic-adc-battery:
 Add capacity handling
Date: Wed, 18 Oct 2017 18:13:13 +0200
Message-ID: <20171018161312.GA31392@amd>
References: <1501620926-22669-1-git-send-email-marek.belisko@open-nandra.com>
 <1501620926-22669-6-git-send-email-marek.belisko@open-nandra.com>
 <20170829101147.debhadzyfrxhkrvt@earth>
 <20170908113231.GJ18365@amd>
 <20171018122804.GA14376@amd>
 <61BFA8AF-657A-4AD7-A7AC-3E5DC3B7E83D@goldelico.com>
 <20171018132204.GD4394@atomide.com>
 <20171018135656.GA26432@amd>
 <341EC461-B19F-418C-B0BF-26E1EEFAD5B7@goldelico.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="vtzGhvizbBRQ85DL"
Return-path: <linux-pm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <341EC461-B19F-418C-B0BF-26E1EEFAD5B7@goldelico.com>
Sender: linux-pm-owner@vger.kernel.org
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: Tony Lindgren <tony@atomide.com>, Sebastian Reichel <sebastian.reichel@collabora.co.uk>, pali.rohar@gmail.com, sre@kernel.org, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com, abcloriens@gmail.com, clayton@craftyguy.net, martijn@brixit.nl, sakari.ailus@linux.intel.com, Marek Belisko <marek.belisko@open-nandra.com>, robh+dt@kernel.org, linux-pm@vger.kernel.org, Marek Belisko <marek.belisko@gmail.com>
List-Id: linux-omap@vger.kernel.org


--vtzGhvizbBRQ85DL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed 2017-10-18 17:52:22, H. Nikolaus Schaller wrote:
>=20
> > Am 18.10.2017 um 15:56 schrieb Pavel Machek <pavel@ucw.cz>:
> >=20
> > On Wed 2017-10-18 06:22:04, Tony Lindgren wrote:
> >> * H. Nikolaus Schaller <hns@goldelico.com> [171018 05:49]:
> >>>> Am 18.10.2017 um 14:28 schrieb Pavel Machek <pavel@ucw.cz>:
> >>>>=20
> >>>> So I started something, it is at.
> >>>>=20
> >>>> https://github.com/pavelmachek/libbattery
> >>>>=20
> >>>> My battery on n900 is currently uncalibrated (and charging), still it
> >>>> gets some kind of estimation:
> >>>>=20
> >>>> Battery -1 %
> >>>> Seconds -1
> >>>> State 1
> >>>> Voltage 3.88 V
> >>>> Battery 63 %
> >>>>=20
> >>>> Of course, there's a lot more work to be done.
> >>>=20
> >>> Nice start but not a solution to our problem.
> >>>=20
> >>> Our problem is that people simply expect that for example https://pac=
kages.debian.org/wheezy/xfce/xfce4-battery-plugin
> >>> displays the battery percentage.
> >>=20
> >> I think we could make things compatible with various battery apps by
> >> having libbattery write back the capacity percentage and time remaining
> >> to the kernel driver via sysfs or a dev entry. Then the kernel interfa=
ce
> >> can just display the data to whatever apps.
> >=20
> > Hmm. This could be as simple as providing symlink from
> > /sys/class/power/userland-battery to some place writable by
> > userspace...
>=20
> Well, please implement arbitrary symlinks in /sysfs...

Any reason why I'd like to do that?
									Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--vtzGhvizbBRQ85DL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlnnfZgACgkQMOfwapXb+vIVsgCgtH4D6xGywcYTqiAPvcMGqGsX
LQcAn15UON/Vj2u0lKIdaBbE79SYe+HJ
=5INl
-----END PGP SIGNATURE-----

--vtzGhvizbBRQ85DL--
