From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: omap: USB host disconnects connecting a device through USB HUB
Date: Fri, 8 Apr 2011 10:36:05 +0300
Message-ID: <20110408073603.GB9489@legolas.emea.dhcp.ti.com>
References: <BANLkTim4FNNH3MfbEAwwpGzGvvLARWW+KA@mail.gmail.com>
 <Pine.LNX.4.44L0.1104071036040.2147-100000@iolanthe.rowland.org>
 <BANLkTinNF2C6_2ApHke+Oi74zovUwbWkCQ@mail.gmail.com>
Reply-To: balbi-l0cyMroinI0@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <BANLkTinNF2C6_2ApHke+Oi74zovUwbWkCQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Enric =?iso-8859-1?Q?Balletb=F2?= i Serra <eballetbo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Thu, Apr 07, 2011 at 11:03:38PM +0200, Enric Balletb=F2 i Serra wrot=
e:
> Hi,
>=20
> 2011/4/7 Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>:
> > On Thu, 7 Apr 2011, Enric Balletb=F2 i Serra wrote:
> >
> >> Hi all,
> >>
> >> I'm experimenting some issues with USB on IGEP v2 board, in certai=
n
> >> cases I've an USB disconnect when I plug a device. For me it fails
> >> with kernel 2.6.35 but I think it also affect newer kernel, the is=
sue
> >> is easy to reproduce following these steps:
> >>
> >> 1. Power up the board (without any device connected )
> >>
> >> 2. When kernel is up, connect a powered USB HUB 2.0 to the USB hos=
t
> >> port, kernel shows,
> >>
> >> usb 1-1: new high speed USB device using ehci-omap and address 2
> >> usb 1-1: New USB device found, idVendor=3D05e3, idProduct=3D0608
> >> usb 1-1: New USB device strings: Mfr=3D0, Product=3D1, SerialNumbe=
r=3D0
> >> usb 1-1: Product: USB2.0 Hub
> >> hub 1-1:1.0: USB hub found
> >> hub 1-1:1.0: 4 ports detected
> >> usb 1-1.4: new high speed USB device using ehci-omap and address 3
> >> usb 1-1.4: New USB device found, idVendor=3D05e3, idProduct=3D0608
> >> usb 1-1.4: New USB device strings: Mfr=3D0, Product=3D1, SerialNum=
ber=3D0
> >> usb 1-1.4: Product: USB2.0 Hub
> >> hub 1-1.4:1.0: USB hub found
> >> hub 1-1.4:1.0: 4 ports detected
> >>
> >> 3. Then if I connect a device (for example a pendrive) to the HUB =
I
> >> get USB disconnect message
> >>
> >> usb 1-1: USB disconnect, address 2
> >> usb 1-1.4: USB disconnect, address 3
> >>
> >> OTOH, it works without problem
> >> =A0 1. if power up the board with the USB HUB connected to the USB=
 Host
> >> port and the device connected to the USB hub.
> >> =A0 2. if after kernel is up, connect the USB HUB + device to the =
USB Host port
> >>
> >> Anyone is experimenting something like this with other OMAP3-based=
 boards ?
> >
> > At first glance, it looks like a power-related issue. =A0Current in=
rush
> > when the device is plugged in, or something like that.
> >
> > What happens if you attach the hub and pendrive to a standard PC?
> >
>=20
> With standard PC works as expected, would be possible a problem with
> omap-ehci driver ? Maybe Felipe can give some light ?

Maybe PM is kicking in and turning off the clocks. Donno. What if you
use function tracer so we know the last called function before the
problem ? Just filter the call to *hci*.

--=20
balbi
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
