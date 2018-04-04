From: Pavel Machek <pavel@ucw.cz>
Subject: FORTIFY_SOURCE breaks ARM compilation in -next -- was Re: ARM
 compile failure in Re: linux-next: Tree for Apr 4
Date: Wed, 4 Apr 2018 22:18:37 +0200
Message-ID: <20180404201837.GA9710@amd>
References: <20180404165559.4cd0c12c@canb.auug.org.au>
 <20180404074856.GA9342@amd>
 <20180404175852.GI5700@atomide.com>
 <20180404184622.GA8608@amd>
 <20180404195951.GJ5700@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="lrZ03NoBR/3+SXJZ"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180404195951.GJ5700@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Linux-Next Mailing List <linux-next@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, pali.rohar@gmail.com, sre@kernel.org, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com, abcloriens@gmail.com, clayton@craftyguy.net, martijn@brixit.nl, sakari.ailus@linux.intel.com, Filip =?utf-8?Q?Matijevi=C4=87?= <filip.matijevic.pz@gmail.com>, jinb.park7@gmail.com, keescook@chromium.org, rmk+kernel@armlinux.org.uk
List-Id: linux-omap@vger.kernel.org


--lrZ03NoBR/3+SXJZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed 2018-04-04 12:59:51, Tony Lindgren wrote:
> * Pavel Machek <pavel@ucw.cz> [180404 18:47]:
> > Hi!
> >=20
> > > > When trying to build kernel for N900, I get:
> > > >=20
> > > >   CC      lib/timerqueue.o
> > > >     CC      lib/vsprintf.o
> > > >     lib/string.c: In function 'strstr':
> > > >     lib/string.c:478:8: error: inlining failed in call to
> > > >     always_inline 'strlen': function not inlinable
> > > >     lib/string.c:903:5: error: called from here
> > > >     lib/string.c:478:8: error: inlining failed in call to
> > > >     always_inline 'strlen': function not inlinable
> > > >     lib/string.c:906:5: error: called from here
> > > >     lib/string.c:855:15: error: inlining failed in call to
> > > >     always_inline 'memcmp': function not inlinable
> > > >     ...
> > > > pavel@duo:/data/l/linux-next-n900$ git branch -l
> > > > * (detached from next-20180403)
> > > >=20
> > > > I'm using
> > > >=20
> > > > eval ` eldk-switch.sh -r 5.4 armv7a`
> > > >=20
> > > > for cross-compilation.
> > >=20
> > > Hmm I'm not seeing build issues with next-20180404, did this somehow
> > > already get sorted out?
> >=20
> > It seems it is config-dependend. omap2plus_defconfig compiles ok for
> > me.
> >=20
> > Can you try with attached .config?
>=20
> That still builds for me. This with plain gcc-7.3.0 binutils-2.30
> built with buildall script.

Thanks.

Ok, let me try to bisect it. Compile-problem should be easy...

Hmm. And as it is compile-problem in single file, it should even be
reasonably fast. I did not realize how easy it would be:

#!/bin/bash
set -e
cp config.ok .config
yes '' | ARCH=3Darm make lib/string.o

And the winner is:

ee333554fed55555a986a90bb097ac7f9d6f05bf is the first bad commit
commit ee333554fed55555a986a90bb097ac7f9d6f05bf
Author: Jinbum Park <jinb.park7@gmail.com>
Date:   Tue Mar 6 01:39:24 2018 +0100

    ARM: 8749/1: Kconfig: Add ARCH_HAS_FORTIFY_SOURCE

    CONFIG_FORTIFY_SOURCE detects various overflows at compile-time.
        (6974f0c4555e ("include/linux/string.h:
    add the option of fortified string.h functions)
   =20
    ARCH_HAS_FORTIFY_SOURCE means that the architecture can be built
    and
    run with CONFIG_FORTIFY_SOURCE.
   =20
    Since ARM can be built and run with that flag like other
    architectures,
    select ARCH_HAS_FORTIFY_SOURCE as default.
   =20
    Acked-by: Kees Cook <keescook@chromium.org>
    Signed-off-by: Jinbum Park <jinb.park7@gmail.com>
    Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>

:040000 040000 2bff2f75ba36dd838a8ded3028b745d9f13f4c4a
									e61289e33a1fb71b1a6c05c442d45ea40bd5aba0
									M
									arch
bisect run success
pavel@duo:/data/l/linux-next-n900$=20


									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--lrZ03NoBR/3+SXJZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlrFMx0ACgkQMOfwapXb+vIr9QCbBhT4nZ8xYIgT15jzxo4EoP3J
QiQAn0b+e+VyPD+fPDyBaC/BByfnmXhZ
=vsoP
-----END PGP SIGNATURE-----

--lrZ03NoBR/3+SXJZ--
