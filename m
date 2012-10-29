From: Felipe Balbi <balbi@ti.com>
Subject: Re: OMAP baseline test results for v3.7-rc1
Date: Mon, 29 Oct 2012 22:00:32 +0200
Message-ID: <20121029200032.GD30152@arwen.pp.htv.fi>
References: <alpine.DEB.2.00.1210180517450.8674@utopia.booyaka.com>
 <alpine.DEB.2.00.1210191645390.10773@utopia.booyaka.com>
 <alpine.DEB.2.00.1210200611150.9865@utopia.booyaka.com>
 <CAORVsuUkU3iTTFcXfYJ=_FntjiTR33Gs4z9OsNEn2Cxq7Ef-qA@mail.gmail.com>
 <CAORVsuWFzH3UmXCaY=iqmYsE72KOecLo40tG9BcTUBirJQ5iLA@mail.gmail.com>
 <alpine.DEB.2.00.1210231918500.27211@utopia.booyaka.com>
 <CAORVsuV9_4oc6+voEM9PkqzkXKHipor5XJqaXfDNxAWLofXcxg@mail.gmail.com>
 <20121025101212.GD21217@arwen.pp.htv.fi>
 <20121026201539.GD29548@arwen.pp.htv.fi>
 <alpine.DEB.2.00.1210262201500.11258@utopia.booyaka.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tEFtbjk+mNEviIIX"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:57709 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755021Ab2J2UGg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 29 Oct 2012 16:06:36 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1210262201500.11258@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Felipe Balbi <balbi@ti.com>, Jean Pihet <jean.pihet@newoldbits.com>, aaro.koskinen@iki.fi, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, khilman@ti.com

--tEFtbjk+mNEviIIX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Oct 26, 2012 at 10:03:11PM +0000, Paul Walmsley wrote:
> Hi Felipe,
>=20
> On Fri, 26 Oct 2012, Felipe Balbi wrote:
>=20
> > On Thu, Oct 25, 2012 at 01:12:12PM +0300, Felipe Balbi wrote:
> > > On Tue, Oct 23, 2012 at 09:23:03PM +0200, Jean Pihet wrote:
> > > > On Tue, Oct 23, 2012 at 9:19 PM, Paul Walmsley <paul@pwsan.com> wro=
te:
> > > > > On Mon, 22 Oct 2012, Jean Pihet wrote:
> > > > >
> > > > >> On Mon, Oct 22, 2012 at 6:12 PM, Jean Pihet <jean.pihet@newoldbi=
ts.com> wrote:
> > > > >>
> > > > >> > Do you have CPU_IDLE enabled?
> > > > >> FYI the issue is not present with CPU_IDLE enabled.
> > > > >
> > > > > Hmm, how can you tell?  I thought you weren't able to reproduce i=
t with
> > > > > CPU_IDLE disabled either?
> > > > I could not reproduce the issue, with and without CPU_IDLE enabled.
> > > > What puzzles me is that the PM QoS code only has influence on the
> > > > states chosen by cpuidle, so the change should not have any impact
> > > > with CPU_IDLE enabled. I reallt need to reproduce the issue.
> > > > Let me try with the same setup as yours (bootloader images,
> > > > omap2pus_defconfig, angstrom roots).
> > >=20
> > > I just sent a patch to fix a bug I found on OMAP4 panda but while
> > > reading this thread again, I think it could be that it's the same bug
> > > which is just easier to reproduce on Paul's setup.
> > >=20
> > > Paul, Aaro, can you see if [1] makes the problem go away ? that would=
 be
> > > another reason to push [1] during this -rc cycle.
> > >=20
> > > [1] http://marc.info/?l=3Dlinux-omap&m=3D135115602407925&w=3D2
>=20
> Thanks for mentioning it, but this patch doesn't fix the I2C timeout=20
> problem here.  Log fragment below from the 3530ES3 Beagle.

that's too bad :-(

Can you compile with:

CONFIG_I2C_DEBUG_CORE=3Dy
CONFIG_I2C_DEBUG_ALGO=3Dy
CONFIG_I2C_DEBUG_BUS=3Dy
CONFIG_DEFAULT_MESSAGE_LOGLEVEL=3D9

so that I can see all transfers ?

--=20
balbi

--tEFtbjk+mNEviIIX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQjuBgAAoJEIaOsuA1yqRElNIQALLN2vAHYEzOhz/EeQ82Nha9
6+GESaSKq8KQKyI3YmS5g9I8mNhlC3QMsgyLuD+8wYMEZ0Bw0wFNIGUoEbFwL1Jc
U+QVSwW88j4JBdw8fdMr/iuzJip7xUAGg0TiVKe2yCjPPUxFOwkkw6uVzPLyGeYq
Vh6zWHlGKyT61E1i3oisbDUB+VAJQ9PunzqJhR1b2ie3IDk7ppHs3OocQ4d3U9P+
GtgWo+y7TR2fFLFnNVGNPth9hdBol8CmVmlFNiDIZhshB9Iuxj9Zl+bIVA1TBYcR
my7M2ZCBBdBnzGnKV34a1EqC89zmW3BnK4OYRd+2L4u4wXmv0WeV85nKtwO+21rO
qhccQMgRbrx7tvrlkRBTzn5QB+HuuWDcSjEIWDowDYJAC1S6CnEEYes5YZEjoASB
TaejHngvYfnQVb3g+Oxp0jfS8g9kxVrywA9xIDGrQqM4l94tpnHz8mvjKdQ8sUPo
+GUp5eoGRQZle+uk/7kqld3ls4cvIkIZWkY3Fa6N2LyAc+HE4+57Y1t2ct4wrbWN
x0/2bNADRZLLzkG/ImXhuzMF+TQ4/FMxkbcgY4+szbgO81ckBVfOVdEWAopoBX+Q
jBnjedglWSDrlIds9D0MnWTLg/k0AiVP0GNDn8D88vGXQWGL8QRlTDis8gZELe+M
fhR+6aIbWx0DUDvXxsp4
=YhmX
-----END PGP SIGNATURE-----

--tEFtbjk+mNEviIIX--
