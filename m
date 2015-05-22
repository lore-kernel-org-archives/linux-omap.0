From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] tty: serial: omap: use mctrl_gpio helpers
Date: Fri, 22 May 2015 12:38:16 -0500
Message-ID: <20150522173816.GE5582@saruman.tx.rr.com>
References: <1432297017-1264-1-git-send-email-yegorslists@googlemail.com>
 <555F4C7F.9020307@ti.com>
 <20150522165212.GZ10274@atomide.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="phCU5ROyZO6kBE05"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:42360 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757212AbbEVRk1 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 22 May 2015 13:40:27 -0400
Content-Disposition: inline
In-Reply-To: <20150522165212.GZ10274@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Nishanth Menon <nm@ti.com>, yegorslists@googlemail.com, linux-serial@vger.kernel.org, linux-omap@vger.kernel.org, balbi@ti.com, gregkh@linuxfoundation.org, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Sekhar Nori <nsekhar@ti.com>

--phCU5ROyZO6kBE05
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 22, 2015 at 09:52:13AM -0700, Tony Lindgren wrote:
> * Nishanth Menon <nm@ti.com> [150522 08:36]:
> > On 05/22/2015 07:16 AM, yegorslists@googlemail.com wrote:
> > > From: Yegor Yefremov <yegorslists@googlemail.com>
> > >=20
> > > This patch permits to use GPIOs to control the CTS/RTS/DTR/DSR/DCD/RI
> > > signals.
> > >=20
> > > Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>
> > > ---
> > >  .../devicetree/bindings/serial/omap_serial.txt     |    9 +
> > >  drivers/tty/serial/Kconfig                         |    1 +
> > >  drivers/tty/serial/omap-serial.c                   |  168 ++++++++++=
+++++++++-
> > >  3 files changed, 171 insertions(+), 7 deletions(-)
> >=20
> > Would we rather move introducing new features to 8250_omap.c rather
> > than doing that to omap-serial and keep feature creeping it such that
> > we wont ever be able to switch to 8250_omap ?
>=20
> Yes please. Also, do we really want to allow mapping
> random GPIO pins to the UART driver? I guess it would be

See drivers/tty/serial/serial_mctrl_gpio.[ch], these are used for UARTs
on SoCs with enough GPIOs available whose UART don't have full Modem
signals. It's pretty handy for BT, GSM, LTE, whatever type of modem-like
device.

--=20
balbi

--phCU5ROyZO6kBE05
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVX2mIAAoJEIaOsuA1yqREY2kP/1NqS7k4GbMQqYJvBEJE3mmC
/PfE07xRjjJ+kdOrmXbIELlsKHslpDNkLq5VUW5rR6VvbKUN4Wi2oy1em9rPWGYl
6JSHGxNvNetKqXWuQg/r//e0cWLnk1wB1kGlacaKRhcAcvKLpLY7Yf29jl4FuM5q
nxVefQgBXaUdL9mjaT4rNIOlclthfMdHdNji2pznbVqLFjEuAEDjCU6Oach1eiKw
0VdPUnj1LwJJmllXuXFl9W5DKzCWDH/dxXUISr30i7bmxC/yu9qLG2ZTuMZQ4t7o
LyndadX8c3eyF0Zuna7bl40vMU2H5CGwzLhfjh+8qkphey4gSbSYGm1VZPEhAm3/
ngt4cggTsBLdYeDJsgPeoSYdWcRjFKcmJ9OPkrIcbncZuj5lmaCJUoABh5dnNeCI
fWoifo2pcdsZdkHMbWCaxbm8H4XyDsRSuN0OhygXse1fbIBw67lTYadxXgd4p/Zq
1XBrkaFmPSz2sDu4ED3nyfje9t3BEYjUFKKI5cKIAaYVHvfIHMbnU+G+RYDcVTD2
uMCWP8MXl1dnWKQ4sM4yvGipfNu2NBaStyMiKOt7DBKuZ25kBTyPqmb85BE8wNuE
TedSmxvTHPgmKzrjAkB/PgUNBp2cKK+vHFXeXzzaHEzIlaalTkPvJ2ZQcSmDDCR/
M4OpjBmWpjinw7Y1z+Si
=jkUW
-----END PGP SIGNATURE-----

--phCU5ROyZO6kBE05--
