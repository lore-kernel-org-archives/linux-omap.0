From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [regression v4.17-rc0] Re: FORTIFY_SOURCE breaks ARM compilation
 in -next -- was Re: ARM compile failure in Re: linux-next: Tree for Apr 4
Date: Fri, 20 Apr 2018 22:30:09 +0200
Message-ID: <20180420203009.GA2244@amd>
References: <20180404195951.GJ5700@atomide.com>
 <20180404201837.GA9710@amd>
 <20180415173908.GA2024@amd>
 <CAGXu5jK9f62n95sOdJViXHXzQFyCdcsWt9HPvcdSFRp9Qqg0bg@mail.gmail.com>
 <20180420073402.GA9356@amd>
 <CAGXu5j+6D3PiVc9SR4+31ZGDC2r5uWJOw8Sn3cDhXdNqBGH+hQ@mail.gmail.com>
 <20180420191523.GA28597@amd>
 <CA+DvKQKLpXP50vV0yoyB_w26NK5h6KdVUSWEHvHZ-8OdVvdt9w@mail.gmail.com>
 <20180420192832.GA1870@amd>
 <CA+DvKQ+ekrr51_JcPiGrOaHj79NxYUqLWEo97z97tSuUzcuoZg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="5mCyUwZo2JvN/JJP"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CA+DvKQ+ekrr51_JcPiGrOaHj79NxYUqLWEo97z97tSuUzcuoZg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Micay <danielmicay@gmail.com>
Cc: Kees Cook <keescook@chromium.org>, Tony Lindgren <tony@atomide.com>, Thorsten Leemhuis <regressions@leemhuis.info>, Linus Torvalds <torvalds@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, Stephen Rothwell <sfr@canb.auug.org.au>, Linux-Next Mailing List <linux-next@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, pali.rohar@gmail.com, sre@kernel.org, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, Kevin Hilman <khilman@kernel.org>, Aaro Koskinen <aaro.koskinen@iki.fi>, ivo.g.dimitrov.75@gmail.com, Patrik Bachan <patrikbachan@gmail.com>, "Serge E. Hallyn" <serge@hallyn.com>, =?utf-8?B?TWlja3Vsw6HFoQ==?= Qwertz <abcloriens@gmail.com>, Clayton Craft <clayton@craftyguy.net>, Martijn
List-Id: linux-omap@vger.kernel.org


--5mCyUwZo2JvN/JJP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri 2018-04-20 15:30:03, Daniel Micay wrote:
> Well, that's not related, it's just this:
>=20
> #ifdef __GNUC__
> #if (__GNUC__ =3D=3D 3 && __GNUC_MINOR__ < 3)
> #error Your compiler is too buggy; it is known to miscompile kernels.
> #error    Known good compilers: 3.3, 4.x
> #endif
> #if GCC_VERSION >=3D 40800 && GCC_VERSION < 40803
> #error Your compiler is too buggy; it is known to miscompile kernels
> #error and result in filesystem corruption and oopses.
> #endif
> #endif

Yeah, I know. I guess the kernel would compile if I removed those
checks...=20

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--5mCyUwZo2JvN/JJP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlraTdEACgkQMOfwapXb+vLDtQCdG8+9dBZlXUAY6QOxIX0vk1zp
7hYAoJ63jV69XqkJDuXwdtQhHr1du/7/
=GcEL
-----END PGP SIGNATURE-----

--5mCyUwZo2JvN/JJP--
