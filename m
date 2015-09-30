From: Felipe Balbi <balbi@ti.com>
Subject: Re: [RFC/PATCH 00/11] arm: omap: counter32k rework
Date: Wed, 30 Sep 2015 09:57:30 -0500
Message-ID: <20150930145730.GA32625@saruman.tx.rr.com>
References: <1443559446-26969-1-git-send-email-balbi@ti.com>
 <20150930141338.GC31865@saruman.tx.rr.com>
 <3705422.OMk7ysE7Jn@wuerfel>
 <6944324.e1oo8C9xbx@wuerfel>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jRHKVT23PllUwdXP"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <6944324.e1oo8C9xbx@wuerfel>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org, balbi@ti.com, Alexandre Courbot <gnurou@gmail.com>, Stephen Warren <swarren@wwwdotorg.org>, Tony Lindgren <tony@atomide.com>, daniel.lezcano@linaro.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Thierry Reding <thierry.reding@gmail.com>, linux-tegra@vger.kernel.org, tglx@linutronix.de, Linux OMAP Mailing List <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

--jRHKVT23PllUwdXP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 30, 2015 at 04:49:53PM +0200, Arnd Bergmann wrote:
> On Wednesday 30 September 2015 16:42:21 Arnd Bergmann wrote:
> >=20
> > TEGRA folks: the tegra_read_persistent_clock() implementation apparently
> > predates the Tegra RTC driver and I wonder if they actually do the
> > right thing in combination. Could it be that the wall time forwards
> > twice as fast as it should during resume when the RTC driver is loaded?
> > Could it be that we can simply remove  tegra_read_persistent_clock()
> > and the register_persistent_clock() infrastructure?
> >=20
>=20
> I found the 'sleeptime_injected' variable now, which takes care of
> forwarding the clock by the correct amount.
>=20
> I also found the CLOCK_SOURCE_SUSPEND_NONSTOP flag next to it, which
> should let us use the counter32k driver to provide the correct
> time during suspend without the omap_read_persistent_clock() function.
> We should be able to just delete that code.
>=20
> If we decide to also delete the tegra_read_persistent_clock()
> function, we can remove the registration too.

cool, I'll try to have a look at that after this series gets accepted.

--=20
balbi

--jRHKVT23PllUwdXP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWC/haAAoJEIaOsuA1yqRExycP/igxvHWEV1/dl8Tts84QfEip
RX1ujMRKedIaR98UqM+yVJaWpBbyerVAeZ3utVhP19LdlQRC1UZyd/kH7XgoRjew
z9gJIThOu7ohE3jG541SuuAZ6tHKH6sQruG/CT4XA/zXSFNBdo8KE9N+nY76TFxU
uTWmZZ9gaCndCn3KWGda+1Vw4L5X6VSFoxxd0I/ol3vW/T4aSzhemCAQS78GttPJ
jl82PqObwv7ZQpqO8GEwjwp1/p0JDT4uOIIPaCmYcek3gugtb1QRdFgzCpKX+h1h
sxJKprYQG7Gd2MKPN3fiW5yuFqRokmqsAKv9L3qdblha7teRPHr3HEVpjEfjNq9R
DaoxXMzDag92oZAVuPtkmpFB8sQtn7NKQmTjsjV8jSmYaW6FBiQJ20lUCN4fEMwT
diDBKvq0raYYKrDGnUyZMxafm60w/1FnHxD9qqZ6L+286Xr/1mf2Y1Vbcmo/K6pP
sUrXZ9l2I5h7cmCyUP8PPFziHNrUGgT9hRf+nml0mQ7iNeJq1USVtHZnCJWRWmls
YWqNnnuuxqM9PjQf/3/FPmb9dFZVCpRE7r7/gAg9ANpTv1AEHZrCqKeInsN/lAsI
C7V+qOy8qhmF97OtoSlNCbLraCPWp31YafHtIZAhingQSR12r3rh1w6ox1dd7i56
eBQvu+zL1Hgw+dDYTk91
=fgm1
-----END PGP SIGNATURE-----

--jRHKVT23PllUwdXP--
