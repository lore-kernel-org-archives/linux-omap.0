From: Pavel Machek <pavel@ucw.cz>
Subject: Re: v4.10-rc4 to v4.10-rc5: battery regression on Nokia N900
Date: Tue, 24 Jan 2017 18:58:01 +0100
Message-ID: <20170124175800.GA15070@amd>
References: <20170123124058.GA17134@amd>
 <20170123141331.GA11402@amd>
 <da1f1b45-3ae5-ffe8-62c6-9ec7c3a1505b@roeck-us.net>
 <20170123144031.GA7870@amd>
 <20170123232654.GA19342@amd>
 <20170123234912.GA2460@roeck-us.net>
 <20170124070639.GA5068@rzhang1-surface>
 <20170124073720.GB5603@amd>
 <88c94ea6-abe2-0f20-337e-e9ee00c883d8@roeck-us.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="Nq2Wo0NMKNjxTN9z"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <88c94ea6-abe2-0f20-337e-e9ee00c883d8@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Guenter Roeck <linux@roeck-us.net>
Cc: Zhang Rui <rui.zhang@intel.com>, pali.rohar@gmail.com, sre@kernel.org, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com, abcloriens@gmail.com, fabio.estevam@nxp.com
List-Id: linux-omap@vger.kernel.org


--Nq2Wo0NMKNjxTN9z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> >>Right.
> >>
> >>Before reverting, can you please try if this patch works or not?
> >
> >Not really. Revert now. Sorry.
> >
> >Are you sure? This does not look equivalent to me at all.
> >
> >"name" file handling moved from drivers to the core, which added some
> >crazy checks what name can contain. Even if this "works", what is the
> >expected effect on the "name" file?
> >
> The hwmon name attribute must not include '-', as documented in
> Documentation/hwmon/sysfs-interface. Is enforcing that 'crazy' ?
> Maybe in your world, but not in mine.

Well, lets revert the patch and then we can discuss what to do with
the "name" problem.

Unfortunately, code enforces different rules than documentation says,
and it is all visible to userspace.

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--Nq2Wo0NMKNjxTN9z
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAliHlagACgkQMOfwapXb+vK1NwCdE5X4sT4skp4APiXHBxI2Shsl
FjkAnR5Q0aBVcfEFSMXgS/J5i3m7FKC1
=ywnN
-----END PGP SIGNATURE-----

--Nq2Wo0NMKNjxTN9z--
