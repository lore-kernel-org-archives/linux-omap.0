From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] tty: serial: serial-omap: depend on !8250_omap
Date: Sat, 29 Nov 2014 09:34:19 -0800
Message-ID: <20141129173418.GY2817@atomide.com>
References: <1417039306-2384-1-git-send-email-bigeasy@linutronix.de>
 <20141129094823.GA10840@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20141129094823.GA10840@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Sekhar Nori <nsekhar@ti.com>, Felipe Balbi <balbi@ti.com>, uwe@kleine-koenig.org
List-Id: linux-omap@vger.kernel.org

* Sebastian Andrzej Siewior <bigeasy@linutronix.de> [141129 01:50]:
> * Sebastian Andrzej Siewior | 2014-11-26 23:01:46 [+0100]:
>=20
> >Technically speaking this is not required. If both are enabled then =
the
> >Maikefile order says that 8250 one wins, the second is never probed.
> >
> >If we choose to enable 8250_omap via defconfig then one might get su=
pprised
> >that his console isn't working anymore since nothing says use ttySx
> >instead ttyOx.
> >This patch _tries_ to bring this to the users' attention by not show=
ing
> >the serial-omap driver once the 8250 one is enabled. So the user mig=
ht
> >choose to use the help text which says that this driver (8250_omap)
> >uses ttySx instead ttyOx.
> >
> >Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> >---
> >This is my attempt to warn the defconfig user of the defconfig chang=
e
> >(which did not yet happen). Any suggestions?
>=20
> This is was Uwe Kleine-K=C3=B6nig suggested off-list:
>=20
> |Currently there are two drivers for the serial device. Until the new=
 one
> |matured enough to drop the old one, let them conflict each other. Th=
ey
> |both handle the same devices, but only one can be responsible for a
> |single device. There is no technical need, but having two drivers in=
 the
> |same kernel might result in surprises.
>=20
> I personally don't mind having two drivers enabled since the makefile
> order is always the same. My main concern is the ttyOx -> ttySx switc=
h
> after the newer driver is enabled by default via defconfig (and the u=
ser
> does not know it). "make oldconfig" is covered by "default n".
> Uwe's has a point about "matured enough to drop the old one". It isn'=
t
> mentioned anywhere that the newer driver supports also DMA. Is this
> something we want to add to the help text?
> Could someone that will probably be dealling with possible fallout co=
mment
> on this? This patch shouldn't go in without an ACK.

Well the nightmare userspace switch from ttyS to ttyO few years ago is
something we want to avoid.. I think the best solution would be to make
serial-omap.c transparently provide support for ttyO using the new 8250
code so both ttyS and ttyO devices would just work. Otherwise it will
be years of "my serial port stopped working" questions again.

Regards,

Tony
