From: Pavel Machek <pavel@ucw.cz>
Subject: [regression v4.17-rc0] Re: FORTIFY_SOURCE breaks ARM compilation in
 -next -- was Re: ARM compile failure in Re: linux-next: Tree for Apr 4
Date: Sun, 15 Apr 2018 19:39:08 +0200
Message-ID: <20180415173908.GA2024@amd>
References: <20180404165559.4cd0c12c@canb.auug.org.au>
 <20180404074856.GA9342@amd>
 <20180404175852.GI5700@atomide.com>
 <20180404184622.GA8608@amd>
 <20180404195951.GJ5700@atomide.com>
 <20180404201837.GA9710@amd>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="7AUc2qLy4jB3hD7Z"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180404201837.GA9710@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Thorsten Leemhuis <regressions@leemhuis.info>, Linus Torvalds <torvalds@linux-foundation.org>, arnd@arndb.de
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Linux-Next Mailing List <linux-next@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, pali.rohar@gmail.com, sre@kernel.org, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com, abcloriens@gmail.com, clayton@craftyguy.net, martijn@brixit.nl, sakari.ailus@linux.intel.com, Filip =?utf-8?Q?Matijevi=C4=87?= <filip.matijevic.pz@gmail.com>, jinb.park7@gmail.com, keescook@chromium.org, rmk+kernel@armlinux.org.uk
List-Id: linux-omap@vger.kernel.org


--7AUc2qLy4jB3hD7Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Thanks.
>=20
> Ok, let me try to bisect it. Compile-problem should be easy...
>=20
> Hmm. And as it is compile-problem in single file, it should even be
> reasonably fast. I did not realize how easy it would be:
>=20
> #!/bin/bash
> set -e
> cp config.ok .config
> yes '' | ARCH=3Darm make lib/string.o
>=20
> And the winner is:
>=20
> ee333554fed55555a986a90bb097ac7f9d6f05bf is the first bad commit
> commit ee333554fed55555a986a90bb097ac7f9d6f05bf
> Author: Jinbum Park <jinb.park7@gmail.com>
> Date:   Tue Mar 6 01:39:24 2018 +0100
=2E..

>     Acked-by: Kees Cook <keescook@chromium.org>
>     Signed-off-by: Jinbum Park <jinb.park7@gmail.com>
>     Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>

So I bisect a problem in -next, and patch is merged to Linus,
_anyway_, breaking compilation there? Neither Jinbum nor Russell even
bother to comment.

And BTW, Russell, there's another regression I bisected to your
commit, that one is like two releases old, and "only" causes
compilation warnings during build with non-US locale. I even proposed
fix for that. Guess what? Ignored too.


									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--7AUc2qLy4jB3hD7Z
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlrTjjsACgkQMOfwapXb+vIcAACgmioGofAJBgF03vtQH/LNcj5h
dE8AnjGHjSgaydJZ0aK2WsMq1PKW9y/H
=+TKb
-----END PGP SIGNATURE-----

--7AUc2qLy4jB3hD7Z--
