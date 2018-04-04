From: Pavel Machek <pavel@ucw.cz>
Subject: ARM compile failure in Re: linux-next: Tree for Apr 4
Date: Wed, 4 Apr 2018 09:48:56 +0200
Message-ID: <20180404074856.GA9342@amd>
References: <20180404165559.4cd0c12c@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="HlL+5n6rz5pIUxbD"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180404165559.4cd0c12c@canb.auug.org.au>
Sender: linux-kernel-owner@vger.kernel.org
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, pali.rohar@gmail.com, sre@kernel.org, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com, abcloriens@gmail.com, clayton@craftyguy.net, martijn@brixit.nl, sakari.ailus@linux.intel.com, Filip =?utf-8?Q?Matijevi=C4=87?= <filip.matijevic.pz@gmail.com>
List-Id: linux-omap@vger.kernel.org


--HlL+5n6rz5pIUxbD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Please do not add any v4.18 destined stuff to your linux-next included
> trees until after v4.17-rc1 has been released.
>=20
> Changes since 20180403:
>=20
> The vfs tree still had its build failure for which I reverted a commit.
>=20
> Non-merge commits (relative to Linus' tree): 8505
>  8493 files changed, 392779 insertions(+), 275941 deletions(-)
>=20
> -------------------------------------------------------------------------=
---

When trying to build kernel for N900, I get:

  CC      lib/timerqueue.o
    CC      lib/vsprintf.o
    lib/string.c: In function 'strstr':
    lib/string.c:478:8: error: inlining failed in call to
    always_inline 'strlen': function not inlinable
    lib/string.c:903:5: error: called from here
    lib/string.c:478:8: error: inlining failed in call to
    always_inline 'strlen': function not inlinable
    lib/string.c:906:5: error: called from here
    lib/string.c:855:15: error: inlining failed in call to
    always_inline 'memcmp': function not inlinable
    ...
pavel@duo:/data/l/linux-next-n900$ git branch -l
* (detached from next-20180403)

I'm using

eval ` eldk-switch.sh -r 5.4 armv7a`

for cross-compilation.

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--HlL+5n6rz5pIUxbD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlrEg2gACgkQMOfwapXb+vJ5dwCeNPpuo0yVMb3Elh9UesG/jQJV
mjsAn3yLbH5gKwVvKVyHBSaJ3x/tkb2l
=Uztg
-----END PGP SIGNATURE-----

--HlL+5n6rz5pIUxbD--
