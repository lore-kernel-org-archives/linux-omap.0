From: Felipe Balbi <balbi@ti.com>
Subject: Re: [RFC] possible removal of omap-serial
Date: Thu, 20 Mar 2014 20:37:29 -0500
Message-ID: <20140321013729.GC29691@saruman.home>
References: <20140320235210.GB26964@saruman.home>
 <20140321001228.GA18131@kroah.com>
 <20140321013557.GB29691@saruman.home>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YD3LsXFS42OYHhNZ"
Return-path: <linux-serial-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20140321013557.GB29691@saruman.home>
Sender: linux-serial-owner@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, Tony Lindgren <tony@atomide.com>, Alan Cox <alan@linux.intel.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, linux-serial@vger.kernel.org, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

--YD3LsXFS42OYHhNZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 20, 2014 at 08:35:57PM -0500, Felipe Balbi wrote:
> Hi,
>=20
> On Thu, Mar 20, 2014 at 05:12:28PM -0700, Greg KH wrote:
> > On Thu, Mar 20, 2014 at 06:52:10PM -0500, Felipe Balbi wrote:
> > > Hi folks,
> > >=20
> > > I've been toying with the idea of removing
> > > drivers/tty/serial/omap-serial.c since that's, to put it bluntly, an
> > > ungly copy of 8250 driver.
> > >=20
> > > The original concern was wrt suspend/resume but I think it'd be a far
> > > better approach to implement runtime PM in 8250 and write a rather sm=
all
> > > 8250-omap.c glue (much like 8250-acorn.c or 8250-dw.c) just to get the
> > > OMAP-specific details out of the way.
> > >=20
> > > The question I have is: omap-serial.c calls the serial devnodes ttyO\=
d,
> > > instead of ttyS\d so removing omap-serial.c would have a direct impact
> > > in userland. I wonder if it's an acceptable "regression" considering
> > > we'd be able to reuse 8250 gaining proper Flow Control support, proper
> > > DMA support, years and years of bug-fixes, etc.
> >=20
> > Breaking device node names is a contentious issue for serial ports, I
> > don't think you can do that :(
>=20
> would an upstream udev rule creating a symbolic link from ttyO to ttyS
> be enough ?
>=20
> I didn't test this yet but I guess this is enough (?)
>=20
> KERNEL=3D=3D"ttyO[0-9]", GROUP=3D"dialout", SYMLINK+=3D"ttyS"

or actually it should be to other way around, ttyS would be the real
device:

KERNEL=3D=3D"ttyS[0-9]", GROUP=3D"dialout", SYMLINK+=3D"ttyO"

--=20
balbi

--YD3LsXFS42OYHhNZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTK5fZAAoJEIaOsuA1yqRElPEQAKGBwwREjM1GME0B6VMA9T5o
SkX67nuuFC5WA9pVFDnkJOvRyx8E904xQoTPAfFV9lcZp6Bs0akUWA6dX8WG48k/
5gWXI0EiuIw2Ris0KLjVJjTmj1duScdCd340csryvzqAjpY4IfPvDF409AkQSEcQ
uwrU4CpHbUNKtzwaHBmHXnWpWDwAY5L1MW0NsBfRuDvHiQVOTbmdomzP12MF/dpN
mKQnK6ByZAV9mo3kuLL8AxyJY5v1/bwITyzRf6ZaJCXzAmLvJny+E27nQvwtD8QB
BVBwNGONvDL6ClaNviDPFMCzERRjH2mpMHpJDmoRRrFZ3WomV4MsUZG6GrR0Olel
c3PxdZlEquEsn74beb+DBHPPSvZMqKlCfto7x+VQ2uAiZcJcqed4YHBCize/z/Xq
N9++HR6A1CgVxpi0RKCsodCB7+88qCnOvMVsnRM3Y+oPPeihKo+r1Av3ZMl6RBjq
5iNgwd6F/yXlPW4ACyY5UyW3P4R2aXey1v8UBZCvPuB4lmfy08hdEDVZLAWBwI1A
XjbX2WwlKe+uOXpNd6S1Rqh13G5YWTHMookdG2JDagbMrf1lGwp1tS0DfRKTYely
Vu8V9MFIG2dlaN2Kz2F8Q56476Hunu87dheCD/483nVWv5BvkFlntSGThAvAhe1D
Cq9w4aud8KvbIbEUFuxp
=pZCl
-----END PGP SIGNATURE-----

--YD3LsXFS42OYHhNZ--
