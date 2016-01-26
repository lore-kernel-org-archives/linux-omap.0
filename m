From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Subject: Re: Nokia N900: musb is in wrong state after boot
Date: Tue, 26 Jan 2016 15:34:50 +0100
Message-ID: <20160126143450.GG25796@pali>
References: <201601091616.04193@pali>
 <3690314.8jDXSUDcRZ@saturn>
 <20160121192113.GM19432@atomide.com>
 <8629381.KDSn8v3DtH@saturn>
 <20160121203012.GN19432@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160121203012.GN19432@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: joerg Reisenweber <joerg@openmoko.org>, Felipe Balbi <balbi@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Sebastian Reichel <sre@kernel.org>, Aaro Koskinen <aaro.koskinen@iki.fi>, Pavel Machek <pavel@ucw.cz>, Nishanth Menon <nm@ti.com>
List-Id: linux-omap@vger.kernel.org

On Thursday 21 January 2016 12:30:13 Tony Lindgren wrote:
> * joerg Reisenweber <joerg@openmoko.org> [160121 11:35]:
> > On Thu 21 January 2016 11:21:13 Tony Lindgren wrote:
> > > Do you have some pointer
> > > to the "certain resistor value on ID to GND" spec? Is it maybe pa=
rt of
> > > the carkit related parts of the USB spec?
> >=20
> > ""Three additional ID pin states are defined[4] at the nominal resi=
stance=20
> > values of 124 k=CE=A9, 68 k=CE=A9, and 36.5 k=CE=A9, with respect t=
o the ground pin. These=20
> > permit the device to work with USB Accessory Charger Adapters that =
allows the=20
> > OTG device to be attached to both a charger and another device simu=
ltaneously.
> > [6]""
> > https://en.wikipedia.org/wiki/USB_On-The-Go#OTG_micro_plugs
>=20
> OK thanks. So it's the "accessory charger" part of the
> battery charging specification 1.1.

So, Tony, do you have some idea what needs to be changed and how to fix
peripheral mode after boot on Nokia N900?

=46irst I would like to have fully working peripheral mode on Nokia N90=
0
and then we can try to hack host mode (if possible).

But peripheral mode is a must due to development, because it provides
usb network or usb tty.

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com
