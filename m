From: Felipe Balbi <balbi@ti.com>
Subject: Re: [RFC/PATCH 09/11] clocksource: add TI 32.768 Hz counter driver
Date: Thu, 1 Oct 2015 17:30:14 -0500
Message-ID: <20151001223014.GD32355@saruman.tx.rr.com>
References: <1443559446-26969-1-git-send-email-balbi@ti.com>
 <1443559446-26969-10-git-send-email-balbi@ti.com>
 <CALAqxLVUDYivs4QKWtFDbwFdWqa2JJX49Aj15p69zpYCb1_SbA@mail.gmail.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0/kgSOzhNoDC5T3a"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CALAqxLVUDYivs4QKWtFDbwFdWqa2JJX49Aj15p69zpYCb1_SbA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: John Stultz <john.stultz@linaro.org>
Cc: Felipe Balbi <balbi@ti.com>, Tony Lindgren <tony@atomide.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

--0/kgSOzhNoDC5T3a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 01, 2015 at 03:20:18PM -0700, John Stultz wrote:
> On Tue, Sep 29, 2015 at 1:44 PM, Felipe Balbi <balbi@ti.com> wrote:
> > Introduce a new clocksource driver for Texas
> > Instruments 32.768 Hz device which is available
> > on most OMAP-like devices.
> >
> > Signed-off-by: Felipe Balbi <balbi@ti.com>
> > ---
> >  drivers/clocksource/Kconfig        |   8 +++
> >  drivers/clocksource/Makefile       |   1 +
> >  drivers/clocksource/timer-ti-32k.c | 121 +++++++++++++++++++++++++++++=
++++++++
>=20
> Also isn't this somewhat duplicate of the code in
> arch/arm/plat-omap/counter_32k.c ?
>=20
> Was this really a rewrite or just a code migration? Should you

migrating, but we can't really delete that yet because we still have
a bunch of legacy platforms not using DT.

> preserve the copyrights from counter_32k.c?

heh, probably :-)

--=20
balbi

--0/kgSOzhNoDC5T3a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWDbP1AAoJEIaOsuA1yqREsPcP/RZ63egqdjH57b/wjCR/G9La
ydxdTD9E4U/qokgQ6G1326cj7CK2flFtxocAMcaL7vzVUDy0SZBD7m7iv5LsYPxX
x7N5Fiqa+ICN2H19A5iOUGfGpBcikygPBxMHEZ5x9i8+cQgKl8XjkkmWJZqj6WaZ
EYLvZpxmLx10ZxT1kRj5PSr+ImJkZ970REjUfGsPa6dBycDRCXx/8i28yhlbXn4J
UWnBUQRt6hLUCLi6T8as5zVCqzA5+CBVuEcnmBj2EAp5Rxf/aSQVz+VRTuLvGtv4
lTMEyknKKaXOYI3/cy9dIdnlwgJGPHjvGTi5YBwvSji+w1nD6siDMis+SYvbye8i
ziCz+HGo86t9G+bo8sbGP2KkQQZv4VOVKRvoO5dNc3TRJuYqHb+kbsBnQ4avqEqQ
e3nws5RmIeJB6P7YQrU0WrXReex4uy3/4Nz8AMEX7pZiUhH/t4ehRQsJDOUxilu3
vf6SYjRZctuZE9kagUWyGJfdPmAORDB5EqBZg306C4XQJMppAiO6ZeG59gHb2T8K
KhD8e/DR+VZrj+1etFNoteDdwbKRjKSoQKtCy0zr5zpACrNkgH0swbmNiX1RB/bj
nbHL9fIxZ22hKTQfirt3dGSX60P67M7etEhMO1zKbNWT0FOlPRssTl4hfaAfxGne
mf9tBcg57nL3znYtNDMZ
=JqQz
-----END PGP SIGNATURE-----

--0/kgSOzhNoDC5T3a--
