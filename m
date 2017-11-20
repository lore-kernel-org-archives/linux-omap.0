From: Pavel Machek <pavel@ucw.cz>
Subject: Nokia N900: Funny screen effects, v4.14 with certain configs
Date: Mon, 20 Nov 2017 23:15:51 +0100
Message-ID: <20171120221550.GA13322@amd>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="ibTvN161/egqYuK8"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: pali.rohar@gmail.com, sre@kernel.org, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com, abcloriens@gmail.com, clayton@craftyguy.net, martijn@brixit.nl, sakari.ailus@linux.intel.com
List-Id: linux-omap@vger.kernel.org


--ibTvN161/egqYuK8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

I'm trying to find common configuration for N900, N9 and N950.

=2E..and I found that N900, at least with DRM configuration, is
flakey. Depending on exact .config, and exact way I boot it (timing of
0xffff) display either works or just shows moving horizontal stripes.

In particular, ondemand cpufreq seems to be required for display to
work. Ouch. Yes.

If someone knows what is going on there, or has some better
understanding, let me know.

I do have other configuration that seems to work 100% of
time... unfortuantely that one is useless on N9/N950.

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--ibTvN161/egqYuK8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAloTVBYACgkQMOfwapXb+vL+jgCgtMJHFol5oZjRkrfWZuCgA2aA
Zv0AnjgQor7k/m5nfEQKYUbezfofRIov
=Pyjd
-----END PGP SIGNATURE-----

--ibTvN161/egqYuK8--
