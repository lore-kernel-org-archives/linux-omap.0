From: Felipe Balbi <balbi@ti.com>
Subject: Re: USB lockups on BeagleBone/AM335x
Date: Thu, 27 Feb 2014 14:52:10 -0600
Message-ID: <20140227205210.GF5375@saruman.home>
References: <BCBA70ECF3E0284F86C53FAF9ED7FCA1426C07@SRVEXCH01.enatel.local>
 <20140220224902.GB10878@saruman.home>
 <BCBA70ECF3E0284F86C53FAF9ED7FCA1426C96@SRVEXCH01.enatel.local>
 <20140221011405.GB19336@saruman.home>
 <5306B97D.8070306@enatel.net>
 <20140221153321.GD31902@saruman.home>
 <530FA153.809@enatel.net>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oFbHfjnMgUMsrGjO"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:40661 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751067AbaB0Uxm (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 27 Feb 2014 15:53:42 -0500
Content-Disposition: inline
In-Reply-To: <530FA153.809@enatel.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Chris Kimber <chris.kimber@enatel.net>
Cc: balbi@ti.com, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

--oFbHfjnMgUMsrGjO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 28, 2014 at 09:34:27AM +1300, Chris Kimber wrote:
> Hi,
>=20
> On 22/02/2014 4:33 a.m., Felipe Balbi wrote:
> >On Fri, Feb 21, 2014 at 03:27:09PM +1300, Chris Kimber wrote:
> >>Hey
> >>
> >>On 21/02/2014 2:14 p.m., Felipe Balbi wrote:
> >>>Hi,
> >>>
> >>>(please avoid top-posting)
> >>>
> >>>On Fri, Feb 21, 2014 at 12:11:40AM +0000, Chris Kimber wrote:
> >>>>Hey,
> >>>>
> >>>>Thanks for the response.
> >>>>
> >>>>I've disabled the DMA (CONFIG_MUSB_PIO_ONLY=3Dy) but the problem still
> >>>>persists (for both USB sticks & USB serial ports).
> >>>hmm, that's weird.
> >>>
> >>>>Now it looks like dsps_interrupt() never fires and causes the hang
> >>>>up...
> >>>>
> >>>>[   94.865635] tty ttyUSB0: serial_write - 11 byte(s)
> >>>>[   94.865656] cp210x ttyUSB0: usb_serial_generic_write_start - lengt=
h =3D 11, data =3D 54 45 53 54 49 4e 47 20 34 32 0a
> >>>>[   94.865680] musb-hdrc musb-hdrc.1.auto: qh ce461a00 periodic slot =
10
> >>>>[   94.865700] musb-hdrc musb-hdrc.1.auto: qh ce461a00 urb ce481e80 d=
ev2 ep1out-bulk, hw_ep 10, ce43db00/11
> >>>>[   94.865721] musb-hdrc musb-hdrc.1.auto: --> hw10 urb ce481e80 spd2=
 dev2 ep1out h_addr00 h_port00 bytes 11
> >>>>[   94.865740] musb-hdrc musb-hdrc.1.auto: TX ep10 fifo d0832c48 coun=
t 11 buf ce43db00
> >>>>[   94.865755] musb-hdrc musb-hdrc.1.auto: Start TX10 pio
> >>>>[   94.865792] musb-hdrc musb-hdrc.1.auto: usbintr (0) epintr(400)
> >>>>[   94.865810] musb-hdrc musb-hdrc.1.auto: ** IRQ host usb0000 tx0400=
 rx0000
> >>>>[   94.865826] musb-hdrc musb-hdrc.1.auto: OUT/TX10 end, csr 2100
> >>>>[   94.865866] musb-hdrc musb-hdrc.1.auto: complete ce481e80 usb_seri=
al_generic_write_bulk_callback+0x0/0xd4 [usbserial] (0), dev2 ep1out, 11/11
> >>>so the first one completed just fine.
> >>>
> >>>>[   94.865971] tty ttyUSB0: serial_write - 11 byte(s)
> >>>>[   94.865991] cp210x ttyUSB0: usb_serial_generic_write_start - lengt=
h =3D 11, data =3D 54 45 53 54 49 4e 47 20 34 33 0a
> >>>>[   94.866015] musb-hdrc musb-hdrc.1.auto: qh ce461a00 periodic slot =
10
> >>>>[   94.866035] musb-hdrc musb-hdrc.1.auto: qh ce461a00 urb ce481e80 d=
ev2 ep1out-bulk, hw_ep 10, ce43db00/11
> >>>>[   94.866055] musb-hdrc musb-hdrc.1.auto: --> hw10 urb ce481e80 spd2=
 dev2 ep1out h_addr00 h_port00 bytes 11
> >>>>[   94.866075] musb-hdrc musb-hdrc.1.auto: TX ep10 fifo d0832c48 coun=
t 11 buf ce43db00
> >>>>[   94.866089] musb-hdrc musb-hdrc.1.auto: Start TX10 pio
> >>>can you dump TXCSR, DEVCTL and IRQ registers when this happens ?
> >>>
> >>I added the IRQ registers to the debugfs interface..
> >>
> >>IntrTX      : 0000
> >>IntrRX      : 0000
> >>IntrTXE     : ffff
> >>IntrRXE     : fffe
> >>IntrUSB     : 08
> >>IntrUSBE    : f7
> >>TxCSRp      : 0000
> >>DevCtl      : 5d
> >>
> >>Oddly the VBUSERR bit is set, if I disconnect the USB cable then it
> >>goes to 0. I just tried plugging in via powered hub and that doesn't
> >>change the status.
> >that might be the issue you're having, then. for whatever reason VBUS
> >level fluctuates and that confuses MUSB.
> >
> >I'll see if there's anyway to work around that.
> >
>=20
> I've finally managed to find some time to check the old 3.2 kernel's
> Interrupt registers and have found that the VBUSERR bit is still set,
> so this might be a red herring.
>=20
> I've ordered a BeagleBone Black just to make sure this isn't just
> related to the AM335x Silicon v1 problems you mentioned before.
>=20
> The search continues.

alright, keep us posted ;-)

--=20
balbi

--oFbHfjnMgUMsrGjO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTD6V6AAoJEIaOsuA1yqRE/ckP/0Ihc/uYH7giHdLrF5AWtU7X
S0AXCQFq/9kAQsaenyo4w+Iycx15xCj8kP7V1MSQQTyFMN8YC6WdKYidXOY9PJrS
sLSyQhopRbabAwaIlTQbfzfl+IDruojd/w9tQ9w/PoajeptGOMRYVfQwK8/KBLfc
aGsNsYYL/0+/t0+GQiBJmENh9XofztKcOpy340kmlbipnRxulU7tHsi4aXXisvVS
GUaAOMTCYynpx1OQEXRwMqYM5PQ1uwMkVY7uP5Nhu5h5hga+zdw92j9KNNSfvGlA
4ku46jvYCm69iWwrwIc3nwJBuHI9iS3+jnCYJ2Q1T6nbeQCmuykoW87eJY6/ZW5L
4d8vfcrDvDmzSOb2xOGl2Tr7fEbHKeZWUaIJ0G1VPZYODMvf43Yeq6CL89N9QGyC
mB1LvZXmxNnIbJwa0FPiz2uNpcUS0UraRJiHQVBqPz7juWUZGYoDBxIFOUUa8KTC
MuERT/TKkyfj7SK6FzHAUFxBOEOCiqgYVySW68EkXyrG3YsQ02h0H3FdZY04E2Jo
P0kAGr/cvSmtRYPyGmcUYWir3rxmHnRekU7boFYI9or3mxrnrOK8a/USVgNjuLGK
9yhjS7gEaZnSTO6CJW29F+a8pMqeqQ2vjiy0z8fd9SqSOZa6hov9xn9s+9D26JJm
EmK1+VcMZY4tbP/46mwG
=zNtF
-----END PGP SIGNATURE-----

--oFbHfjnMgUMsrGjO--
