From: Felipe Balbi <balbi@ti.com>
Subject: Re: linux 3.6-rc2, undefined reference to omap_musb_mailbox
Date: Mon, 20 Aug 2012 13:26:42 +0300
Message-ID: <20120820102641.GM17455@arwen.pp.htv.fi>
References: <alpine.DEB.2.01.1208181741450.32497@pmeerw.net>
 <CAAe_U6+dFuX9fSX_epnPzX_3Zx3XBWAxE6kHDCTeuPwtn-ZQNw@mail.gmail.com>
 <20120820095421.GL17455@arwen.pp.htv.fi>
 <CAAe_U6+x+gxp2PMzuTyT=2Ox=HJtYw3DXGZLmaczi+q2oTM6TQ@mail.gmail.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mI5TpPl/qDRoXxBg"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog137.obsmtp.com ([74.125.149.18]:32907 "EHLO
	na3sys009aog137.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751100Ab2HTKak (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 20 Aug 2012 06:30:40 -0400
Received: by lage12 with SMTP id e12so5308339lag.27
        for <linux-omap@vger.kernel.org>; Mon, 20 Aug 2012 03:30:37 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAAe_U6+x+gxp2PMzuTyT=2Ox=HJtYw3DXGZLmaczi+q2oTM6TQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ABRAHAM, KISHON VIJAY" <kishon@ti.com>
Cc: balbi@ti.com, Peter Meerwald <pmeerw@pmeerw.net>, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org


--mI5TpPl/qDRoXxBg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 20, 2012 at 03:46:07PM +0530, ABRAHAM, KISHON VIJAY wrote:
> Hi,
>=20
> On Mon, Aug 20, 2012 at 3:24 PM, Felipe Balbi <balbi@ti.com> wrote:
> > On Mon, Aug 20, 2012 at 11:06:34AM +0530, ABRAHAM, KISHON VIJAY wrote:
> >> Hi,
> >>
> >> On Sat, Aug 18, 2012 at 9:34 PM, Peter Meerwald <pmeerw@pmeerw.net> wr=
ote:
> >> >
> >> > 3.6-rc2 fails to compile with
> >> > CONFIG_USB_MUSB_HDRC=3Dm
> >> > CONFIG_USB_MUSB_OMAP2PLUS=3Dm
> >> >
> >> >   LD      init/built-in.o
> >> > drivers/built-in.o: In function `twl4030_usb_irq':
> >> > /home/pmeerw/linux-3.6-rc2/drivers/usb/otg/twl4030-usb.c:518: undefi=
ned reference to `omap_musb_mailbox'
> >> > drivers/built-in.o: In function `twl4030_usb_phy_init':
> >> > /home/pmeerw/linux-3.6-rc2/drivers/usb/otg/twl4030-usb.c:540: undefi=
ned reference to `omap_musb_mailbox'
> >>
> >> Having TWL4030_USB as a module will get rid of this.
> >> I'll see how this can be resolved when some modules are *built-in* and
> >> some are made as *modules*.
> >
> > EXPORT_SYMBOL_GPL() should sort that out, right ?
>=20
> No :-( I already have EXPORT_SYMBOL_GPL() in omap2430.c.

I see you're missing an "extern" on the function prototype (on the
header). Not sure how modules.dep is generated, but maybe it needs the
"extern" there. Can you check it out ?

--=20
balbi

--mI5TpPl/qDRoXxBg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQMhDhAAoJEIaOsuA1yqREEUMQAJh2MTFG6u9TmjiDbgz/gdVN
eDKsHsZlLo7s4C54ttehCY5eOJ/jdLQnNmmdCm5HkfULPmRYsLzkQxy0T5Mr4Xwu
TZomOlfJoUWIoOfj2k7psCoQbrS/D3hyks+opXBJoQ/ST8FnQ5C0b9V9J3/3K+2M
eb97lmJtMF6P51CVtU5lgIBNXuzucqRP+oGnFbaDMtUVBLsrtdPzkB0Fi6do65un
YyZ0N0nmsfCi1zWethMlR6Rp4cLExbTXHgy8RzAsgWaPQmeIFXuXLu2cm4sIBjey
0VaspTnonVRx3h1KU3OBj4iA6KimXCy5PNe/2mLxd9acDnQ47eE1xMKu4fn342Me
zKv6ne6FQKg4EbSkf0FztiMqyA6MTQsLlWJbnEV/o6BO8t6emduzXHoqGJ/98IAe
LprExXluGPgOL5Y8hGSs+nyz90Nl0uaNK0o7xzPZrpht6khnH2pBIVwdQDXF3FB8
0vqVz0I1iXR3iHvxJ8AvFigZoPYQwDY6xxT+f0iEjcjFWD6RTjwgO1+HOr56Z9XC
6qOSmkompoAwpxkWbF98rB05z1+Ze4DJjm2o3ILx7bYXx4iYIbsh8ZHqsa/eQAek
W+L6P6NmW2TRhUPcsTAPqYiBzZXsH8RYZPRdeRt73F9zL1Tf2pXspsmHJcQI4ili
yirEitWHGIhVOwN26iix
=eX+i
-----END PGP SIGNATURE-----

--mI5TpPl/qDRoXxBg--
