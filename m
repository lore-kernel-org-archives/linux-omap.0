From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH V4 0/5] ARM: OMAP: HOST: TLL driver implementation
Date: Mon, 23 Jul 2012 17:08:31 +0300
Message-ID: <20120723140830.GA8155@arwen.pp.htv.fi>
References: <1342445471-18704-1-git-send-email-keshava_mgowda@ti.com>
 <CAP05o4+O8FXRjnXtta26rUoZpcMnpZEkdu9+J0xatCyusrjQEw@mail.gmail.com>
 <CAP05o4+rdtsXKV9U0MrLyu7Ce8zJ4uUEcZOJ5yfarpF42gSogA@mail.gmail.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PNTmBPCT7hxwcZjr"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog124.obsmtp.com ([74.125.149.151]:47535 "EHLO
	na3sys009aog124.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750969Ab2GWOL7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 23 Jul 2012 10:11:59 -0400
Received: by lbbgo11 with SMTP id go11so8844155lbb.31
        for <linux-omap@vger.kernel.org>; Mon, 23 Jul 2012 07:11:37 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAP05o4+rdtsXKV9U0MrLyu7Ce8zJ4uUEcZOJ5yfarpF42gSogA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Munegowda, Keshava" <keshava_mgowda@ti.com>
Cc: linux-omap@vger.kernel.org, Samuel Ortiz <sameo@linux.intel.com>, balbi@ti.com, Paul Walmsley <paul@pwsan.com>, parthab@india.ti.com


--PNTmBPCT7hxwcZjr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jul 23, 2012 at 07:31:10PM +0530, Munegowda, Keshava wrote:
> On Thu, Jul 19, 2012 at 3:48 PM, Munegowda, Keshava
> <keshava_mgowda@ti.com> wrote:
> > On Mon, Jul 16, 2012 at 7:01 PM, Keshava Munegowda
> > <keshava_mgowda@ti.com> wrote:
> >> The TLL (Transceiver Less Link) is an separate IP block, independent of
> >> the host controller. Basically this TLL operates like USB PHY which al=
lows
> >> the user to connect two USB transceiver interfaces together directly
> >> without the use of differential transceivers in omap3 and later chips.
> >> The TLL configuration is removed from the UHH driver and implemented as
> >> a seperate platform driver. Now, the UHH driver configures the TLL
> >> through API's exported by the TLL platform driver.
> >>
> >> Signed-off-by: Keshava Munegowda <keshava_mgowda@ti.com>
> >>
> >> In v4:
> >>     - rebased on top of linux kernel version 3.5.rc7
> >>     - reworked as per the comments given by Paul Walmsley <paul@pwsan.=
com>
> >>
> >> In v3:
> >>   - rebased on top V3 of Russ dill's patch
> >>        'ARM: OMAP3: USB: Fix the EHCI ULPI PHY reset issue'
> >>        fixes an issue where the ULPI PHYs were not held in reset
> >>        while initializing the EHCI controller
> >>         http://permalink.gmane.org/gmane.linux.usb.general/65988
> >>
> >>   - rebased on top of patch
> >>     OMAP: USB : Fix the EHCI enumeration and core retention issue
> >>      http://permalink.gmane.org/gmane.linux.usb.general/66239
> >>
> >> In V2:
> >>     - covered review comments from linux omap and usb community
> >>     - rebased on top Russ dill's patch
> >>        'ARM: OMAP3: USB: Fix the EHCI ULPI PHY reset issue'
> >>        fixes an issue where the ULPI PHYs were not held in reset
> >>        while initializing the EHCI controller
> >>
> >> Keshava Munegowda (5):
> >>   ARM: OMAP: Add the USB TLL clocks device name
> >>   ARM: OMAP: USB: HOST TLL platform driver
> >>   ARM: OMAP: USB: Invoke the TLL driver from USB HS core driver
> >>   ARM: OMAP: USB: Remove TLL specific code from USB HS core driver
> >>   ARM: OMAP: Remove older device name of the USB TLL clocks
> >>
> >>  arch/arm/mach-omap2/clock3xxx_data.c  |    8 +-
> >>  arch/arm/mach-omap2/clock44xx_data.c  |    4 +-
> >>  arch/arm/mach-omap2/usb-host.c        |   31 ++-
> >>  arch/arm/plat-omap/include/plat/usb.h |    7 +
> >>  drivers/mfd/Kconfig                   |    2 +-
> >>  drivers/mfd/Makefile                  |    2 +-
> >>  drivers/mfd/omap-usb-host.c           |  238 ++---------------
> >>  drivers/mfd/omap-usb-tll.c            |  471 ++++++++++++++++++++++++=
+++++++++
> >>  8 files changed, 523 insertions(+), 240 deletions(-)
> >>  create mode 100644 drivers/mfd/omap-usb-tll.c
> >>
> >> --
> >> 1.7.9.5
> >
> >
> > Felipe/ Paul
> >       please let me know if you have any review comments on this v4 ser=
ies.
> >
> > regards
> > keshava
>=20
> Hi Felipe
>           please let me know if you have any review comments on this seri=
es now.

looks ok... pretty much just moving code around.

--=20
balbi

--PNTmBPCT7hxwcZjr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQDVreAAoJEIaOsuA1yqREyEsP/2vV7b8CbJ3hFmg4tXcQMoUJ
viDEgmL76l24JHp+qHaaQ7E7vYCkckxO6s7s2S2pu5PtLm0Qt/XO91LYhsjHqZi/
q2lxdCO8qAL9EleGRqQo0N/GjROMagv01bCgTyuoDfc05wjQVFZQmGPdFLCy6EDx
9lsW0PerRCIvvlAcDWJ/rBPFJW73iOPs032vmuSsQqUa6fdgofwL7/PRAT1+BYYy
ZgL61pjcHvBovwYCXqyV7di6tqrb19S7Yn8qxhMvNqx+jFp8yQrz6MVDBFaUphXo
KYlDfOmRm50dvtv8+3dUHqIEmB7eSFsniR7lExFHu8ofBGarTANcjwnTMUna/x+U
0V3tOf8/1wTKYfagulgct3kTfqa6lDHpAJ6P//KfF+SCnc0WXAx1rEcrZ4KxNzUl
823CD/52hbDWpyoZCGclflR96pCO7N4kiqWX2gYIrnx8ZuOYwqTCAVgxR1bSk8ZS
JAqW4MF5HD6FCZO4rkrRzzpy1nCcyFviFv3Ym0QrzhonjWk5aPl/vNVkoUwshAV/
HehalM201YQWgT+r6wChu/bE46E+o6L8F6AoegEP+NzxMXF3kRE+/KPMS6BVoyfk
dbdKUwCNkIPsEdq8z3US889+mhTigPzszuToq4dXtWT6Z0GuZqvVH08uAZ+xXPqf
sTYY2EobghpeqU8LLRXs
=jt4E
-----END PGP SIGNATURE-----

--PNTmBPCT7hxwcZjr--
