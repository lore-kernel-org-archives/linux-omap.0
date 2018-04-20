From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [regression v4.17-rc0] Re: FORTIFY_SOURCE breaks ARM compilation
 in -next -- was Re: ARM compile failure in Re: linux-next: Tree for Apr 4
Date: Fri, 20 Apr 2018 21:28:32 +0200
Message-ID: <20180420192832.GA1870@amd>
References: <20180404175852.GI5700@atomide.com>
 <20180404184622.GA8608@amd>
 <20180404195951.GJ5700@atomide.com>
 <20180404201837.GA9710@amd>
 <20180415173908.GA2024@amd>
 <CAGXu5jK9f62n95sOdJViXHXzQFyCdcsWt9HPvcdSFRp9Qqg0bg@mail.gmail.com>
 <20180420073402.GA9356@amd>
 <CAGXu5j+6D3PiVc9SR4+31ZGDC2r5uWJOw8Sn3cDhXdNqBGH+hQ@mail.gmail.com>
 <20180420191523.GA28597@amd>
 <CA+DvKQKLpXP50vV0yoyB_w26NK5h6KdVUSWEHvHZ-8OdVvdt9w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="BOKacYhQ+x31HxR3"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CA+DvKQKLpXP50vV0yoyB_w26NK5h6KdVUSWEHvHZ-8OdVvdt9w@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Micay <danielmicay@gmail.com>
Cc: Kees Cook <keescook@chromium.org>, Tony Lindgren <tony@atomide.com>, Thorsten Leemhuis <regressions@leemhuis.info>, Linus Torvalds <torvalds@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, Stephen Rothwell <sfr@canb.auug.org.au>, Linux-Next Mailing List <linux-next@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, pali.rohar@gmail.com, sre@kernel.org, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, Kevin Hilman <khilman@kernel.org>, Aaro Koskinen <aaro.koskinen@iki.fi>, ivo.g.dimitrov.75@gmail.com, Patrik Bachan <patrikbachan@gmail.com>, "Serge E. Hallyn" <serge@hallyn.com>, =?utf-8?B?TWlja3Vsw6HFoQ==?= Qwertz <abcloriens@gmail.com>, Clayton Craft <clayton@craftyguy.net>, Martijn
List-Id: linux-omap@vger.kernel.org


--BOKacYhQ+x31HxR3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri 2018-04-20 15:18:32, Daniel Micay wrote:
> On 20 April 2018 at 15:15, Pavel Machek <pavel@ucw.cz> wrote:
> > Hi!
> >
> >> >> Hi! Sorry I lost this email in my inbox. It seems this is specific =
to
> >> >> a particular subset of arm architectures? (My local builds of arm a=
ll
> >> >> succeed, for example. Can you send your failing config?) I'll take a
> >> >> closer look on Monday if Daniel doesn't beat me to it.
> >> >
> >> > Daniel, Kees: any news?
> >> >
> >> > I'm aware you did not specify which Monday :-).
> >>
> >> Hi! Sorry, I got distracted. So the .config you sent me builds fine
> >> with my cross compiler. I suspect this is something specific to ELDK's
> >> compiler. I can try some other compiler versions. What version of gcc
> >> is failing?
> >
> > I have:
> >
> > pavel@duo:/data/l/linux-n900$ arm-linux-gnueabi-gcc --version
> > arm-linux-gnueabi-gcc (GCC) 4.7.2
> > Copyright (C) 2012 Free Software Foundation, Inc.
> > pavel@duo:/data/l/linux-n900$ arm-linux-gnueabi-ld --version
> > GNU ld (GNU Binutils) 2.23.1.20121113
> > Copyright 2012 Free Software Foundation, Inc.
> >
> > Let me try with eldk-5.6:
> >
> > pavel@duo:/data/l/linux-n900$ arm-linux-gnueabi-gcc --version
> > arm-linux-gnueabi-gcc (GCC) 4.8.2
> > pavel@duo:/data/l/linux-n900$ arm-linux-gnueabi-ld --version
> > GNU ld (GNU Binutils) 2.24
> >
> > make  lib/string.o
> >
> > Seems to succeed, so I guess full build will succeed, too...
>=20
> It doesn't imply that a full build would work.

You are right. eldk-5.6 does not have problem with string.o, but does
not compile the kernel, either...

  CC      arch/arm/kernel/asm-offsets.s
  arch/arm/kernel/asm-offsets.c:56:2: error: #error Your compiler is
  too buggy; it is known to miscompile kernels
   #error Your compiler is too buggy; it is known to miscompile
  kernels
    ^
    arch/arm/kernel/asm-offsets.c:57:2: error: #error and result in
  filesystem corruption and oopses.
   #error and result in filesystem corruption and oopses.
     ^

									Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--BOKacYhQ+x31HxR3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlraP2AACgkQMOfwapXb+vJEIACffw4iwM+EDb+s3S8yeMfXCXia
hWYAoJdu/R6npi3P+hYD8NMYrwzQ8GWB
=YXXb
-----END PGP SIGNATURE-----

--BOKacYhQ+x31HxR3--
