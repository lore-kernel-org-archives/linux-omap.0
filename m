From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Subject: Re: Nokia N900: musb is in wrong state after boot
Date: Mon, 22 Feb 2016 09:34:31 +0100
Message-ID: <20160222083431.GA4606@pali>
References: <201601091616.04193@pali>
 <20160126143450.GG25796@pali>
 <20160126172631.GZ19432@atomide.com>
 <201602211212.49460@pali>
 <87ziutnqu1.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <87ziutnqu1.fsf@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Felipe Balbi <balbi@kernel.org>
Cc: Tony Lindgren <tony@atomide.com>, b-liu@ti.com, joerg Reisenweber <joerg@openmoko.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Sebastian Reichel <sre@kernel.org>, Aaro Koskinen <aaro.koskinen@iki.fi>, Pavel Machek <pavel@ucw.cz>, Nishanth Menon <nm@ti.com>
List-Id: linux-omap@vger.kernel.org

On Monday 22 February 2016 09:31:50 Felipe Balbi wrote:
> Pali Roh=C3=A1r <pali.rohar@gmail.com> writes:
>=20
> > On Tuesday 26 January 2016 18:26:32 Tony Lindgren wrote:
> >> * Pali Roh=C3=A1r <pali.rohar@gmail.com> [160126 06:35]:
> >> > On Thursday 21 January 2016 12:30:13 Tony Lindgren wrote:
> >> > > * joerg Reisenweber <joerg@openmoko.org> [160121 11:35]:
> >> > > > On Thu 21 January 2016 11:21:13 Tony Lindgren wrote:
> >> > > > > Do you have some pointer
> >> > > > > to the "certain resistor value on ID to GND" spec? Is it
> >> > > > > maybe part of the carkit related parts of the USB spec?
> >> > > >=20
> >> > > > ""Three additional ID pin states are defined[4] at the nomin=
al
> >> > > > resistance values of 124 k=CE=A9, 68 k=CE=A9, and 36.5 k=CE=A9=
, with respect
> >> > > > to the ground pin. These permit the device to work with USB
> >> > > > Accessory Charger Adapters that allows the OTG device to be
> >> > > > attached to both a charger and another device simultaneously=
=2E
> >> > > > [6]""
> >> > > > https://en.wikipedia.org/wiki/USB_On-The-Go#OTG_micro_plugs
> >> > >=20
> >> > > OK thanks. So it's the "accessory charger" part of the
> >> > > battery charging specification 1.1.
> >> >=20
> >> > So, Tony, do you have some idea what needs to be changed and how=
 to
> >> > fix peripheral mode after boot on Nokia N900?
> >>=20
> >> No, I'm waiting to hear an educated guess from Felipe on this one.
>=20
> about why peripheral mode doesn't work on n900 ? No idea. that's alwa=
ys
> the default role of MUSB and last I checked, before stopping working =
on
> this, BBB was working just fine.
>=20
> N900 is odd in that it has two PHYs (1701 handles data lines while
> twl4030 handles power lines, IIRC), but peripheral should be working.
>=20
> The only reason for MUSB to not start would be that it's not detectin=
g
> VBUS being above session valid threshold, however twl4030 should have=
 an
> IRQ for that.
>=20
> What happens when cable is attached ? Any IRQs anywhere firing ?
>=20

Just to note, when I call echo peripheral > mode then detecting usb
cable starts working and usb peripheral mode also works fine (also afte=
r
disconnecting and connecting usb cable again). Read my first post in
this thread, there are also some logs: https://lkml.org/lkml/2016/1/9/6=
9

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com
