From: Pavel Machek <pavel@ucw.cz>
Subject: Re: ARM compile failure in Re: linux-next: Tree for Apr 4
Date: Wed, 4 Apr 2018 20:15:13 +0200
Message-ID: <20180404181513.GA29233@amd>
References: <20180404165559.4cd0c12c@canb.auug.org.au>
 <20180404074856.GA9342@amd>
 <20180404175852.GI5700@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="pWyiEgJYm5f9v55/"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180404175852.GI5700@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Linux-Next Mailing List <linux-next@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, pali.rohar@gmail.com, sre@kernel.org, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com, abcloriens@gmail.com, clayton@craftyguy.net, martijn@brixit.nl, sakari.ailus@linux.intel.com, Filip =?utf-8?Q?Matijevi=C4=87?= <filip.matijevic.pz@gmail.com>
List-Id: linux-omap@vger.kernel.org


--pWyiEgJYm5f9v55/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > Please do not add any v4.18 destined stuff to your linux-next included
> > > trees until after v4.17-rc1 has been released.
> > >=20
> > > Changes since 20180403:
> > >=20
> > > The vfs tree still had its build failure for which I reverted a commi=
t.
> > >=20
> > > Non-merge commits (relative to Linus' tree): 8505
> > >  8493 files changed, 392779 insertions(+), 275941 deletions(-)
> > >=20
> > > ---------------------------------------------------------------------=
-------
> >=20
> > When trying to build kernel for N900, I get:
> >=20
> >   CC      lib/timerqueue.o
> >     CC      lib/vsprintf.o
> >     lib/string.c: In function 'strstr':
> >     lib/string.c:478:8: error: inlining failed in call to
> >     always_inline 'strlen': function not inlinable
> >     lib/string.c:903:5: error: called from here
> >     lib/string.c:478:8: error: inlining failed in call to
> >     always_inline 'strlen': function not inlinable
> >     lib/string.c:906:5: error: called from here
> >     lib/string.c:855:15: error: inlining failed in call to
> >     always_inline 'memcmp': function not inlinable
> >     ...
> > pavel@duo:/data/l/linux-next-n900$ git branch -l
> > * (detached from next-20180403)
> >=20
> > I'm using
> >=20
> > eval ` eldk-switch.sh -r 5.4 armv7a`
> >=20
> > for cross-compilation.
>=20
> Hmm I'm not seeing build issues with next-20180404, did this somehow
> already get sorted out?

Let me check...

  CC      lib/vsprintf.o
  lib/string.c: In function 'strstr':
  lib/string.c:478:8: error: inlining failed in call to always_inline
  'strlen': function not inlinable

Same problem.

pavel@duo:~$ eval ` eldk-switch.sh -r 5.4 armv7a`
pavel@duo:~$ arm-linux-gnueabi-gcc --version
arm-linux-gnueabi-gcc (GCC) 4.7.2

Best regards,								Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--pWyiEgJYm5f9v55/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlrFFjEACgkQMOfwapXb+vJ0EwCgjB9Z0OHv1LOJNBBQP4y5WsOO
e2MAnAmCW/yDxrTr7BjPi5Zj3GT+77TC
=eqyS
-----END PGP SIGNATURE-----

--pWyiEgJYm5f9v55/--
