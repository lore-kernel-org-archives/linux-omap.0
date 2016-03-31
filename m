From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH 4/7] ARM: dts: Enable N950 keyboard sleep leds by default
Date: Thu, 31 Mar 2016 02:48:10 +0200
Message-ID: <20160331004809.GA27951@earth>
References: <1457827580-16919-1-git-send-email-sre@kernel.org>
 <1457827580-16919-5-git-send-email-sre@kernel.org>
 <20160329105128.GA30184@amd>
 <20160329145209.GB31858@earth>
 <20160330193520.GY9329@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="BXVAT5kNtrzKuDFl"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160330193520.GY9329@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Pavel Machek <pavel@ucw.cz>, =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson@baylibre.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--BXVAT5kNtrzKuDFl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Mar 30, 2016 at 12:35:21PM -0700, Tony Lindgren wrote:
> > > I must say I've seen it on N900, and yes, it is useful, but no, I
> > > don't think this is right.
> > >
> > > This is not a LED. This is a interface that changes meaning of two
> > > other LEDs. I guess it should go to debugfs somewhere.
>=20
> Eh that sounds like a GPIO LED to me :) And it already has a
> /sys/class/leds/debug interface.
>=20
> The two LEDs this GPIO controls are hardwired to sys_clkreq and
> sys_off_mode pins that are the control signals between the SoC
> and PMIC.
>=20
> In theory you could steal the sys_clkreq and sys_off_mode pins
> from the PMIC at the cost of breaking PM. But I doubt anybody
> wants to do that considering it's a battery operated device.
>=20
> > I don't think we should diverge N900 and N950 userspace
> > APIs in this regard.
> >=20
> > Actually the correct way would be a custom trigger
> > for the leds IMHO. I don't know if the led framework
> > supports per led custom triggers, though.
>=20
> Sure, there are something like 10 triggers already. And
> you can already change them using:
>=20
> echo none > /sys/class/leds/debug::sleep/trigger
>=20
> That still does not change the fact that the LEDs trigger
> based on the state of sys_clkreq and sys_off_mode.
>=20
> Maybe I'm not following what you guys are trying to achieve
> here though :) If so, please let me know.

If I understand the situation correctly there are two different
control methods for the same LED. I was wondering if the trigger
=66rom lp5523:kb0 could enable the gpio. For example like this:

echo cpu-sleep-state > /sys/class/leds/lp5523:kb0/trigger

Thinking about it again supporting this requires quite some effort
with N9xx being the only affected platform. Apart from that (as
Pavel mentioned) two LEDs are affected by the GPIO, so even the
trigger is not a clean option.

So I'm fine with the current solution. IMHO moving it to debugfs
is not recommendable while keeping it default enabled (which makes
sense IMHO). At the end the correct solution is fixing the power
management. If the cpu sleeps the impact of this should be marginal.

-- Sebastian

--BXVAT5kNtrzKuDFl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJW/HPHAAoJENju1/PIO/qaRcsP/38gsX3OuG8u2Xrh89fg3e/g
IoCXxykJ5XakLgVq2FI56N0QNfwVuiCvziNVBqyk9d7FghUn4TBekd43l4QvAyOu
60cctzxDQcTvdKiLPhP3Mx7XwVyYDi+xbZ3d47rB7V0x0QXUBtRwHV/T0pWB3d7L
FVI/K5nNEKkidpQsLF7dP4K6HssK+/UVa4mmdEoBs2SRSdUKiW5uvFrw/aDAhc3I
/OtktoEkrwe7r0h1EAtIvS0WaHvWvzCy/hmKajrMy2RS4WArFq+iiCB4ew0FhuQT
ktrg1qP10ypG7hyiAsGhws6wMtApmWs25nemM8jkZdHJYssw/oiSf1FOCFDoUwwW
WUjUiZACyar2+9g0H2sRdWKMLejUSuc/S9M7P95P2BUcOxDEWsKX1Mk1VZD1038+
+vEqF6zhPqa62BxYanVSmQhPIzcvuIydx5z9Uh/l7afXk5W0JIHXEaaKY3SwpFqS
5UlBglFB1WOGa9Sjhd/ysT8WTOunWSBdQ74G1Beppull63xzkWJo+IvYfCZm1F1Q
A/4BniTjFAqI5p94IBcEFUIEilXBNW8dAjJKt8clW0SbOqPUyxxS2yXZYqeIax8E
97RYfJtuvz6tTzp/bEN1ZUeJBT3402TPa1ZEr2jgaMoHi0WED9h3jMUalsDLGXF3
L+a6lHB3KwHn0H8MJyvY
=+veR
-----END PGP SIGNATURE-----

--BXVAT5kNtrzKuDFl--
