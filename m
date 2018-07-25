From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Droid 4: suspend to RAM?
Date: Wed, 25 Jul 2018 23:28:53 +0200
Message-ID: <20180725212853.GA1965@amd>
References: <20180725200205.GA29594@amd>
 <CAOf5uwkyPoDT8TZe9V24p+nQMiee9XfD=943xwx0ThGi9_cPng@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="J2SCkAp4GZ/dPZZf"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAOf5uwkyPoDT8TZe9V24p+nQMiee9XfD=943xwx0ThGi9_cPng@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Cc: kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Sebastian Reichel <sre@kernel.org>, nekit1000@gmail.com, mpartap@gmx.net, Merlijn Wajer <merlijn@wizzup.org>
List-Id: linux-omap@vger.kernel.org


--J2SCkAp4GZ/dPZZf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

HI!
> >
> > I have two big problems with droid 4. #1 is that it lost 2 SMS.. and I
> > have no idea why. Second is power consumption -- it seems to be rather
>=20
> Depend how do you set the SMS buffering using CNMI if I remember. Modem
> has 1024bytes of memory most of the time that can buffer more then 1 sms.
> Modem rise a irq when they receive a call or sms, or you an use the seria=
l but
> omap family can loose the first char coming from the serial so you can lo=
st the
> sms because parsing fail

I am using USB connection to the modem. And yes, I'm using rather
strange CNMI settings (but other did not work).

> > high even before modem (and thus USB) is enabled.
> >
> > Interestingly, CyanogenMod and Jolla seem to have higher power
> > consumption than stock operating system.
> >
> > (My Linux can survive for 10 hours, stock system could survive for 4
> > days if I'm not mistaken).
> >
> > I thought I would experiment with suspend to RAM.. and it indeed
> > seemed to suspend ok, but I could not wake it up. Do I need to set up
> > wakeup with button somehow? Is suspend to RAM required for good power
> > consumption?
>=20
> Sorry but pm subsystem has debug mode that you can test in a easy way.
> You can even wakeup by any rtc alarm easily.

Yes, that is how it works on PC (but there power button works,
too). Is it expected to work on Droid in v4.18?

Thanks,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--J2SCkAp4GZ/dPZZf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAltY65UACgkQMOfwapXb+vLsHgCdEcDohCkc0PQimfLiCHnIuZ9g
QvcAoIVHdtGFRae5ZVW0TyD3Fq4RBcUm
=M3Ge
-----END PGP SIGNATURE-----

--J2SCkAp4GZ/dPZZf--
