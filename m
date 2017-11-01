From: Pavel Machek <pavel@ucw.cz>
Subject: Display on Nokia N950 was Re: Serial cable N9
Date: Wed, 1 Nov 2017 22:46:18 +0100
Message-ID: <20171101214618.GB1636@amd>
References: <20171029082331.GA4358@amd>
 <b05ead6d-3996-3bfc-8f09-09d0229a79b3@gmail.com>
 <20171030074816.GA31977@amd>
 <1cbe2c73-754d-f0c5-1732-b306c7f86f85@gmail.com>
 <20171030205232.GA28601@amd>
 <0f4b8908-7421-6481-8415-3563f347b9de@gmail.com>
 <d3682a85-7910-78fc-407d-fdd333a1d60f@gmail.com>
 <50c15c96-36f5-1e1b-0538-9c758919141c@gmail.com>
 <20171101193220.GA14009@amd>
 <2851c57a-7aba-ddab-3201-03d91fdfa040@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="qlTNgmc+xy1dBmNv"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <2851c57a-7aba-ddab-3201-03d91fdfa040@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Filip =?utf-8?Q?Matijevi=C4=87?= <filip.matijevic.pz@gmail.com>, airlied@redhat.com, tomi.valkeinen@ti.com, laurent.pinchart@ideasonboard.com
Cc: pali.rohar@gmail.com, sre@kernel.org, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com, abcloriens@gmail.com, clayton@craftyguy.net, martijn@brixit.nl, sakari.ailus@linux.intel.com
List-Id: linux-omap@vger.kernel.org


--qlTNgmc+xy1dBmNv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > For the record, display does not work for me in 4.14 on either n9 or
> > n950. I did not investigate that, yet.
>=20
> On v4.13 framebuffer console works OK (I haven't tested anything more in
> fact), but somewhere between v4.13 and v4.14-rc1 there is a commit that
> breaks things - my best guess at this time after a partial git bisect is
> that 906dde0f355bd97c080c215811ae7db1137c4af8 is the one to look at.

Confirmed. Reverting the merge (as far as it can be reverted) gets me
booting N950 with working display. (With 906dde applied, backlight
goes turns on, so it looks like display driver is initialized, but
then machine is killed, probably by watchdog).

AFAICT N950 display never worked on mainline; I'm using Sebastian's
patches to get it to work.

Linux n900 4.14.0-rc7-28884-gdf7c8f0-dirty #283 Wed Nov 1 22:31:35 CET
2017 armv7l GNU/Linux

Filip did all the work here, thanks!
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--qlTNgmc+xy1dBmNv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAln6QKkACgkQMOfwapXb+vJyMQCeLOF7cNCDkGPflAkHulekkKZL
JgYAn2q+0IHcSUU41RgmajoSGaX8KvLD
=09Ap
-----END PGP SIGNATURE-----

--qlTNgmc+xy1dBmNv--
