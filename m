From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Droid 4: suspend to RAM?
Date: Fri, 27 Jul 2018 13:32:15 +0200
Message-ID: <20180727113214.GA32069@amd>
References: <20180725200205.GA29594@amd>
 <CAOf5uwkyPoDT8TZe9V24p+nQMiee9XfD=943xwx0ThGi9_cPng@mail.gmail.com>
 <20180725212853.GA1965@amd>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="FCuugMFkClbJLl1L"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180725212853.GA1965@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Cc: kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Sebastian Reichel <sre@kernel.org>, nekit1000@gmail.com, mpartap@gmx.net, Merlijn Wajer <merlijn@wizzup.org>
List-Id: linux-omap@vger.kernel.org


--FCuugMFkClbJLl1L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!
> > > high even before modem (and thus USB) is enabled.
> > >
> > > Interestingly, CyanogenMod and Jolla seem to have higher power
> > > consumption than stock operating system.
> > >
> > > (My Linux can survive for 10 hours, stock system could survive for 4
> > > days if I'm not mistaken).
> > >
> > > I thought I would experiment with suspend to RAM.. and it indeed
> > > seemed to suspend ok, but I could not wake it up. Do I need to set up
> > > wakeup with button somehow? Is suspend to RAM required for good power
> > > consumption?
> >=20
> > Sorry but pm subsystem has debug mode that you can test in a easy way.
> > You can even wakeup by any rtc alarm easily.
>=20
> Yes, that is how it works on PC (but there power button works,
> too). Is it expected to work on Droid in v4.18?

I tried setting up wakeup using RTC, but no, it does not seem to work:

root@devuan:/my/tui/d4# rtcwake -m no -s 5
rtcwake: wakeup using /dev/rtc0 at Fri Jul 27 11:28:44 2018
root@devuan:/my/tui/d4# echo mem > /sys/power/state

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--FCuugMFkClbJLl1L
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEUEARECAAYFAltbAr4ACgkQMOfwapXb+vKMYgCcD0rd87jKWp3Ro7qsE0rJb06q
omEAl3HBUYdy1It1rDlYXaHVs/gbSjI=
=rs/z
-----END PGP SIGNATURE-----

--FCuugMFkClbJLl1L--
