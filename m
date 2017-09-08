From: Pavel Machek <pavel@ucw.cz>
Subject: Re: n900 in next-20170901
Date: Fri, 8 Sep 2017 11:31:00 +0200
Message-ID: <20170908093100.GE18365@amd>
References: <20170903203737.GA12475@amd>
 <20170905201314.GE5024@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="hwvH6HDNit2nSK4j"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170905201314.GE5024@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: pali.rohar@gmail.com, sre@kernel.org, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com, abcloriens@gmail.com, Joonsoo Kim <iamjoonsoo.kim@lge.com>, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, Vlastimil Babka <vbabka@suse.cz>, Andrew Morton <akpm@linux-foundation.org>, Stephen Rothwell <sfr@canb.auug.org.au>, Russell King <linux@armlinux.org.uk>
List-Id: linux-omap@vger.kernel.org


--hwvH6HDNit2nSK4j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > It compiles ok, but it hangs on boot; black screen, so sometime before
> > display is initialized.
>=20
> Thanks for reporting it. Based on git bisect, the regression causing
> commit is 9caf25f996e8 ("mm/cma: manage the memory of the CMA area
> by using the ZONE_MOVABLE"). With this path applied, booting hangs
> with an error in omap3_save_secure_ram_context() after a call to
> _omap_save_secure_sram() that calls the related assembly code
> save_secure_ram_context.
>=20
> However, looks like there is also some other commit causing issue.
>=20
> Just reverting 9caf25f996e8 on Linux next causes the oops below.
>=20
> Anybody got ideas why this now happens?

Thanks for quick bisect.

I take it 9caf25f996e8 is not going to be merged anywhere until this
is fixed...?

Best regards,
								Pavel
							=09

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--hwvH6HDNit2nSK4j
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlmyY1QACgkQMOfwapXb+vL9OACfelxLx+zxg9ZN1r7OC4TG53jP
/ogAn3Z9deayIce8garDm15x0Oiqqv+p
=+1SZ
-----END PGP SIGNATURE-----

--hwvH6HDNit2nSK4j--
