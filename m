From: Pavel Machek <pavel@ucw.cz>
Subject: Re: v4.10-rc4 to v4.10-rc5: battery regression on Nokia N900
Date: Fri, 27 Jan 2017 12:29:53 +0100
Message-ID: <20170127112953.GC5335@amd>
References: <20170123144031.GA7870@amd>
 <20170123232654.GA19342@amd>
 <20170123234912.GA2460@roeck-us.net>
 <20170124070639.GA5068@rzhang1-surface>
 <20170124073720.GB5603@amd>
 <88c94ea6-abe2-0f20-337e-e9ee00c883d8@roeck-us.net>
 <20170124175800.GA15070@amd>
 <20170124184526.GA25056@roeck-us.net>
 <20170125111233.GB3912@amd>
 <20170125120918.GA7936@pali>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="OBd5C1Lgu00Gd/Tn"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170125120918.GA7936@pali>
Sender: linux-kernel-owner@vger.kernel.org
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: Guenter Roeck <linux@roeck-us.net>, Zhang Rui <rui.zhang@intel.com>, sre@kernel.org, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com, abcloriens@gmail.com, fabio.estevam@nxp.com
List-Id: linux-omap@vger.kernel.org


--OBd5C1Lgu00Gd/Tn
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed 2017-01-25 13:09:18, Pali Roh=E1r wrote:
> On Wednesday 25 January 2017 12:12:33 Pavel Machek wrote:
> > Hi!
> >=20
> > > > > >>Right.
> > > > > >>
> > > > > >>Before reverting, can you please try if this patch works or not?
> > > > > >
> > > > > >Not really. Revert now. Sorry.
> > > > > >
> > > > > >Are you sure? This does not look equivalent to me at all.
> > > > > >
> > > > > >"name" file handling moved from drivers to the core, which added=
 some
> > > > > >crazy checks what name can contain. Even if this "works", what i=
s the
> > > > > >expected effect on the "name" file?
> > > > > >
> > > > > The hwmon name attribute must not include '-', as documented in
> > > > > Documentation/hwmon/sysfs-interface. Is enforcing that 'crazy' ?
> > > > > Maybe in your world, but not in mine.
> > > >=20
> > > > Well, lets revert the patch and then we can discuss what to do with
> > > > the "name" problem.
> >=20
> > Ok, so the patch is on the way in. What to do next?
> >=20
> > pavel@n900:/sys/class/hwmon$ cat hwmon0/name
> > bq27200-0
> > pavel@n900:/sys/class/hwmon$ cat hwmon1/name
> > rx51-battery
> >=20
> > > To provide some detail: libsensors gets just as confused with wildcar=
ds
> > > and whitespace/newline as it does with '-' in the reported name, which
> > > is why those are blocked by the new API.
> >=20
> > Ok... Question is "does someone actually use hwmon*/name on N900"? If
> > so, we can't change it, but it is well possible that noone is.
>=20
> IIRC hwmon is used on Nokia N900.
>=20
> But I have not seen hwmon devices for bq27200 and rx51-battery yet.
> Those are power supply driver and auto-exporting them also via hwmon is
> something new, right? If yes, then we can use any name for those new
> hwmon devices as they cannot break userspace... as there is no userspace
> application for them.

So maemo does not use that. Good. Nor does my Debian userspace. Hey,
maybe you can get away with changing that.

Including batteries in hwmon interface seems useful, and I'd keep that.

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--OBd5C1Lgu00Gd/Tn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAliLLzEACgkQMOfwapXb+vLjYACgulMeTSyjTrPP1rWvAj5rBAM1
IWUAn3JWlcGHty3YfTpLF6adqe2vMSGK
=ui0p
-----END PGP SIGNATURE-----

--OBd5C1Lgu00Gd/Tn--
