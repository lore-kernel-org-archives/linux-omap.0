From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: about OMAP usb Speed?
Date: Thu, 12 Apr 2007 08:48:58 -0500
Message-ID: <3B6D69C3A9EBCA4BA5DA60D913027429BDB8E9@dlee13.ent.ti.com>
References: <bd205c5f0704111728u57837375j22960eed269e4489@mail.gmail.com>
	<200704121530.04125.marek.vasut@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <200704121530.04125.marek.vasut@gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: =?iso-8859-2?Q?Marek_Va=B9ut?= <marek.vasut@gmail.com>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

You do actually need to be careful at times.  Specification-ly speaking, =
you shouldn't make the simple association of (USB-1.1 =3D=3D Full Speed) =
and (USB2.0 =3D=3D High Speed).  You need to look a bit closer.

OMAP's currently have few USB IP blocks in play (and more for the =
future).

15xx: USB-hostA, USB-clientA
16/17xx/2420: USB-hostA, USB-clientA, USB-OTGA
2430/3430-es1: USB-hostA, USB-clientA, USB-OTGA, USB-hostB, USB-clientB, =
USB-OTGB

If you read different TRMs and Data manuals at some point you see that =
some of the Full Speed only devices might be identified as USB2.0 =
compliant even though they don't support High Speed.  For a client you =
just need to advertise what you can and can't do to make 2.0.  You need =
not support everything.

Also as I recall, OTG didn't come about until the USB2.0 time frame.  I =
don't think you will find an OTG which claims to be 1.1.  Usually it is =
2.0 compliant and adheres to some supplement level.

Even on USB2.0's which support HS, depending on the software and the =
hardware implementations you might find yourself a ways from the 480Mb/s =
max spec rate.  Summary is, if some IP says 2.0 you still need to look a =
bit.=20

Regards,
Richard W.



> -----Original Message-----
> From: =
linux-omap-open-source-bounces+r-woodruff2=3Dti.com@linux.omap.com
> =
[mailto:linux-omap-open-source-bounces+r-woodruff2=3Dti.com@linux.omap.co=
m]
> On Behalf Of Marek Va=B9ut
> Sent: Thursday, April 12, 2007 8:30 AM
> To: linux-omap-open-source@linux.omap.com
> Subject: Re: about OMAP usb Speed?
>=20
> Yeah, right ... as some people here said, it's impossible per default =
to
> make
> it support usb2. I now have board with Cypress SX2 controller which is
> quite
> simple to understand and adds usb2.0 gadget support. Also Cypress put =
out
> all
> datasheets and even a example of driver for VxWorks (written in C; =
vxworks
> -
> embedded "os"). Im now working on driver for that SX2, but I also have =
a
> lot
> of school so it can take long.
>=20
> BR
> Marex
>=20
> Dne =E8tvrtek 12 duben 2007 02:28 Wael Adel napsal(a):
> > hi all,
> > i have an OMAP-OSK5912, as for its usb bus i know that it is a
> > full-speed (12Mbps)
> > isnt there any way or any patch that make it support for high-speed
> > (240Mbps)?
> >
> > or it is an impossible to do that?
> > if it is impossible tell me why please?
> >
> > thanks in advance
> > _______________________________________________
> > Linux-omap-open-source mailing list
> > Linux-omap-open-source@linux.omap.com
> > http://linux.omap.com/mailman/listinfo/linux-omap-open-source
> _______________________________________________
> Linux-omap-open-source mailing list
> Linux-omap-open-source@linux.omap.com
> http://linux.omap.com/mailman/listinfo/linux-omap-open-source
