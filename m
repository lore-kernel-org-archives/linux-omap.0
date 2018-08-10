From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Droid 4: suspend to RAM?
Date: Fri, 10 Aug 2018 12:43:18 +0200
Message-ID: <20180810104318.GA3671@amd>
References: <20180725200205.GA29594@amd>
 <CAOf5uwkyPoDT8TZe9V24p+nQMiee9XfD=943xwx0ThGi9_cPng@mail.gmail.com>
 <20180725212853.GA1965@amd>
 <20180727113214.GA32069@amd>
 <20180808090512.GQ99251@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="0F1p//8PRICkK4MW"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180808090512.GQ99251@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Sebastian Reichel <sre@kernel.org>, nekit1000@gmail.com, mpartap@gmx.net, Merlijn Wajer <merlijn@wizzup.org>
List-Id: linux-omap@vger.kernel.org


--0F1p//8PRICkK4MW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed 2018-08-08 02:05:12, Tony Lindgren wrote:
> * Pavel Machek <pavel@ucw.cz> [180727 11:35]:
> > Hi!
> > > > > high even before modem (and thus USB) is enabled.
> > > > >
> > > > > Interestingly, CyanogenMod and Jolla seem to have higher power
> > > > > consumption than stock operating system.
> > > > >
> > > > > (My Linux can survive for 10 hours, stock system could survive fo=
r 4
> > > > > days if I'm not mistaken).
> > > > >
> > > > > I thought I would experiment with suspend to RAM.. and it indeed
> > > > > seemed to suspend ok, but I could not wake it up. Do I need to se=
t up
> > > > > wakeup with button somehow? Is suspend to RAM required for good p=
ower
> > > > > consumption?
> > > >=20
> > > > Sorry but pm subsystem has debug mode that you can test in a easy w=
ay.
> > > > You can even wakeup by any rtc alarm easily.
> > >=20
> > > Yes, that is how it works on PC (but there power button works,
> > > too). Is it expected to work on Droid in v4.18?
> >=20
> > I tried setting up wakeup using RTC, but no, it does not seem to work:
> >=20
> > root@devuan:/my/tui/d4# rtcwake -m no -s 5
> > rtcwake: wakeup using /dev/rtc0 at Fri Jul 27 11:28:44 2018
> > root@devuan:/my/tui/d4# echo mem > /sys/power/state
>=20
> Works for me here as tested on next-20180808, maybe you don't have
> CONFIG_RTC_DRV_CPCAP? Maybe you are trying to use
CONFIG_RTC_DRV_OMAP?

I have right config, and it works for me on next-20180808. Power
button wakes it up, as expected, and even usbnet connections survive,
which is good.

Unfortunately, next-20180808 has no video support, which may also be
reason why it works. I guess I'll need to dust off serial cable and
look for logs...
									Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--0F1p//8PRICkK4MW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlttbEYACgkQMOfwapXb+vLQbACbBffTbmUuT7zepVYXf8VeordR
zIsAoIjVlybg0Mqs9qRPv50Y465l9Euu
=e0TS
-----END PGP SIGNATURE-----

--0F1p//8PRICkK4MW--
