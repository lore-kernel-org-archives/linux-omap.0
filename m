From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: OMAPDSS and panel-dpi
Date: Tue, 22 Apr 2014 16:28:12 +0300
Message-ID: <1398173292.5897.16.camel@deskari>
References: <CAGhQ9VzL5fLHCNZ=y-exBAds03f8Bw_hO+KjYnwO4MgRWOfpuw@mail.gmail.com>
	 <20140417192215.GA24931@atomide.com>
	 <CAGhQ9VwM-rnXcMXNW40jbx6yDGCQwjODDyKhtbZNyCsexX2f3w@mail.gmail.com>
	 <20140417225025.GA25732@atomide.com> <20140418025024.GB25732@atomide.com>
	 <CAGhQ9VwZg6ww1DE=W-DjFM0=QM5WNO3Yp06YxYzB2Jv3C9=F0Q@mail.gmail.com>
	 <20140418154015.GA5354@atomide.com>
	 <CAGhQ9Vzy3Rg6Vh73Ar3P6N1O6nzTvMZK-hhAcgQ8g8feca0Kow@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="=-kIk4oP5gGAa9onQgTp6y"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:58884 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750955AbaDVN2R (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 22 Apr 2014 09:28:17 -0400
In-Reply-To: <CAGhQ9Vzy3Rg6Vh73Ar3P6N1O6nzTvMZK-hhAcgQ8g8feca0Kow@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Joachim Eastwood <manabian@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org

--=-kIk4oP5gGAa9onQgTp6y
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2014-04-18 at 18:43 +0200, Joachim Eastwood wrote:

> > If it does not make sense to set up a generic mode-gpios for the
> > panels, then panel dpi can parse the first two GPIOs for enable
> > and reset. Then we can allow the rest of the array be parsed if
> > needed based on the compatible flag.
>=20
> Looking through the panels in omap2/display-new the most common gpio
> pins are; backlight, reset and enable.
> So it makes sense to have enable and reset as properties.
>=20
> Gpio is used for mode setting in: nl8048hl11 and ls037v7dw01.
> nl8048hl11 has just a qvga gpio, while the other one has no less than
> 3 mode pins (qvga and 2 scanning direction pins). All these mode pins
> are set once and then never touched again.
>=20
> Using gpios property for setting up an arbitrary amount of mode pins
> so like a solution to me.

Generic reset gpio handling is a bit problematic, as even if we know
what the normal state for the gpio is, we don't know how to use it. How
long should it be set to reset-state? How long should be it in the
normal-state before we can reset again? How to handle the powers when
resetting?

We could have some big delays there, which would work for more or less
all the panels. It just doesn't feel quite right =3D).

If we need reset and panel specific mode pin handling, I think a
separate driver is the cleanest option.

Do we have any way to set some gpios to a specified value at boot time
via DT, in a fixed manner? So more or less what Tony does in
ldp_twl_gpio_setup(). If we could just fix the RESET and QVGA gpios, we
could use the panel-dpi just fine, and only handle the enable gpio in
the panel driver.

 Tomi


--=-kIk4oP5gGAa9onQgTp6y
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAABAgAGBQJTVm5sAAoJEPo9qoy8lh71MxQQAK87LAa+4IW7Uy3m5Ds3sojy
XKM8xc7gML6NK6xQDuYrjrZAD4WG1S6FHIXeclM+mdUSiKL5eMr8TzmpdMLEn6Hq
IHAh9LWTBYN2z5HcGaU3UTVY6osrWMiX6r1DLRwcVS+NuT8dQ6gcsWObEW20YueU
3ntY7IrBmvtQYjKkDHQMvpRi78UoGzMeJRKgicMpLALreKvyM4QUyyJdepSZyKWf
XQhnfyePFUCtTFWxhUEAIKPxk8P8/MAqnDDfnLHX0Ubxe2WLvx39SmBO1VvlZOfp
5IejnhPcaDcF0JMQakkCYxxbn9p4WmtTGl5VnRAMdu7fBnd10B5vtga3eIpRE7iL
KT0N/g/tHJ8gF7aWdPL75farLqVCfXl8E2H9smmIOEUTcqu43dGH5ewIcJx0HZaV
AzGUQnqIpNy9Rza5k79w2PQ69gOvJbpJazBTe/hXvJXIFxWmzQaj7ovXjGU2Ipme
+j39/kNG7cGGOQuIMY52U5mTkyfvdO5xG4wCvy52hr8PbT+P+DqehoY3Jh9nxpeG
GgCX8OKFDlma35bj6yyC/7YtFxCUE3ZPaT0fxiTs/ku0O4lBF7KHLq9/KOz5u+Je
jtR53pibkld56aUpp9UIUIXOghy1+41h/Jl/LMvkEkZw6TYcvXNyDVCOhIRThwvz
pdT0NCs/9giQgzpU/G1k
=zmgt
-----END PGP SIGNATURE-----

--=-kIk4oP5gGAa9onQgTp6y--
