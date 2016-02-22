From: Bin Liu <b-liu@ti.com>
Subject: Re: Nokia N900: musb is in wrong state after boot
Date: Mon, 22 Feb 2016 09:36:13 -0600
Message-ID: <20160222153613.GA12995@uda0271908>
References: <201601091616.04193@pali>
 <20160126143450.GG25796@pali>
 <20160126172631.GZ19432@atomide.com>
 <201602211212.49460@pali>
 <87ziutnqu1.fsf@ti.com>
 <20160222083431.GA4606@pali>
 <87oab9nn0i.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <87oab9nn0i.fsf@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Felipe Balbi <balbi@kernel.org>, Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, joerg Reisenweber <joerg@openmoko.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Sebastian Reichel <sre@kernel.org>, Aaro Koskinen <aaro.koskinen@iki.fi>, Pavel Machek <pavel@ucw.cz>, Nishanth Menon <nm@ti.com>
List-Id: linux-omap@vger.kernel.org

Hi,

On Mon, Feb 22, 2016 at 10:54:21AM +0200, Felipe Balbi wrote:
>=20
> Hi,
>=20
> Pali Roh=C3=A1r <pali.rohar@gmail.com> writes:
> > On Monday 22 February 2016 09:31:50 Felipe Balbi wrote:
> >> Pali Roh=C3=A1r <pali.rohar@gmail.com> writes:
> >>=20
> >> > On Tuesday 26 January 2016 18:26:32 Tony Lindgren wrote:
> >> >> * Pali Roh=C3=A1r <pali.rohar@gmail.com> [160126 06:35]:
> >> >> > On Thursday 21 January 2016 12:30:13 Tony Lindgren wrote:
> >> >> > > * joerg Reisenweber <joerg@openmoko.org> [160121 11:35]:
> >> >> > > > On Thu 21 January 2016 11:21:13 Tony Lindgren wrote:
> >> >> > > > > Do you have some pointer
> >> >> > > > > to the "certain resistor value on ID to GND" spec? Is i=
t
> >> >> > > > > maybe part of the carkit related parts of the USB spec?
> >> >> > > >=20
> >> >> > > > ""Three additional ID pin states are defined[4] at the no=
minal
> >> >> > > > resistance values of 124 k=CE=A9, 68 k=CE=A9, and 36.5 k=CE=
=A9, with respect
> >> >> > > > to the ground pin. These permit the device to work with U=
SB
> >> >> > > > Accessory Charger Adapters that allows the OTG device to =
be
> >> >> > > > attached to both a charger and another device simultaneou=
sly.
> >> >> > > > [6]""
> >> >> > > > https://en.wikipedia.org/wiki/USB_On-The-Go#OTG_micro_plu=
gs
> >> >> > >=20
> >> >> > > OK thanks. So it's the "accessory charger" part of the
> >> >> > > battery charging specification 1.1.
> >> >> >=20
> >> >> > So, Tony, do you have some idea what needs to be changed and =
how to
> >> >> > fix peripheral mode after boot on Nokia N900?
> >> >>=20
> >> >> No, I'm waiting to hear an educated guess from Felipe on this o=
ne.
> >>=20
> >> about why peripheral mode doesn't work on n900 ? No idea. that's a=
lways
> >> the default role of MUSB and last I checked, before stopping worki=
ng on
> >> this, BBB was working just fine.
> >>=20
> >> N900 is odd in that it has two PHYs (1701 handles data lines while
> >> twl4030 handles power lines, IIRC), but peripheral should be worki=
ng.
> >>=20
> >> The only reason for MUSB to not start would be that it's not detec=
ting
> >> VBUS being above session valid threshold, however twl4030 should h=
ave an
> >> IRQ for that.
> >>=20
> >> What happens when cable is attached ? Any IRQs anywhere firing ?
> >>=20
> >
> > Just to note, when I call echo peripheral > mode then detecting usb
> > cable starts working and usb peripheral mode also works fine (also
> > after disconnecting and connecting usb cable again). Read my first
> > post in this thread, there are also some logs:
> > https://lkml.org/lkml/2016/1/9/69
>=20
> interesting... that softconnect interface looks odd. We _know_ the va=
lue
> of softconnect from musb->softconnect. /me reads commit which added
> it... Oh okay, that's only valid for host mode. Argh!

softconnet bit is only valid for *peripheral* mode, but the bit is not
set in this case, so the host will not be able to detect the device.

Pali,

Is this never worked or just broken recently? If latter, possible to
git-bisect to find out which patch causes softconnect bit not set?

Regards,
-Bin.

>=20
> Okay, the session bit is _NOT_ set when it should be. Note that DevCt=
l
> reads as 0x98. Bit 0 is Session bit and that's not set. MUSB _is_ in =
the
> device mode (bit 7 set).
>=20
> For some reason DevCtl didn't get set. Care to add a print to
> musb_gadget_pullup() to see when/if it's called ?
>=20
> BTW, Bin will be maintaining MUSB going forward.
>=20
> --=20
> balbi
