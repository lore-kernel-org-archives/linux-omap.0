From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH V4 0/5] ARM: OMAP: HOST: TLL driver implementation
Date: Mon, 13 Aug 2012 17:09:29 +0300
Message-ID: <20120813140928.GH14781@arwen.pp.htv.fi>
References: <1342445471-18704-1-git-send-email-keshava_mgowda@ti.com>
 <CAP05o4+O8FXRjnXtta26rUoZpcMnpZEkdu9+J0xatCyusrjQEw@mail.gmail.com>
 <CAP05o4+rdtsXKV9U0MrLyu7Ce8zJ4uUEcZOJ5yfarpF42gSogA@mail.gmail.com>
 <20120723140830.GA8155@arwen.pp.htv.fi>
 <CAP05o4JDa5WH14SLkFswEqx6jWyr94VfxtEBsbmaiQ+5kT_abQ@mail.gmail.com>
 <CAP05o4+dOH6tDXU4bs5ubh8rqjpjumZjfu4zM1G6MupE0T4fhQ@mail.gmail.com>
 <CAP05o4LRS=svfTsNV45CcToKT7XcZ+et3+fmYzJ7xMLhidtCOA@mail.gmail.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="54u2kuW9sGWg/X+X"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:51970 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751368Ab2HMON0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 13 Aug 2012 10:13:26 -0400
Received: by lage4 with SMTP id e4so2710287lag.39
        for <linux-omap@vger.kernel.org>; Mon, 13 Aug 2012 07:13:12 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAP05o4LRS=svfTsNV45CcToKT7XcZ+et3+fmYzJ7xMLhidtCOA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Munegowda, Keshava" <keshava_mgowda@ti.com>
Cc: balbi@ti.com, Samuel Ortiz <sameo@linux.intel.com>, linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, parthab@india.ti.com


--54u2kuW9sGWg/X+X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 13, 2012 at 06:52:13PM +0530, Munegowda, Keshava wrote:
> On Fri, Jul 27, 2012 at 5:44 PM, Munegowda, Keshava
> <keshava_mgowda@ti.com> wrote:
> > On Mon, Jul 23, 2012 at 8:04 PM, Munegowda, Keshava
> > <keshava_mgowda@ti.com> wrote:
> >> On Mon, Jul 23, 2012 at 7:38 PM, Felipe Balbi <balbi@ti.com> wrote:
> >>> Hi,
> >>>
> >>> On Mon, Jul 23, 2012 at 07:31:10PM +0530, Munegowda, Keshava wrote:
> >>>> On Thu, Jul 19, 2012 at 3:48 PM, Munegowda, Keshava
> >>>> <keshava_mgowda@ti.com> wrote:
> >>>> > On Mon, Jul 16, 2012 at 7:01 PM, Keshava Munegowda
> >>>> > <keshava_mgowda@ti.com> wrote:
> >>>> >> The TLL (Transceiver Less Link) is an separate IP block, independ=
ent of
> >>>> >> the host controller. Basically this TLL operates like USB PHY whi=
ch allows
> >>>> >> the user to connect two USB transceiver interfaces together direc=
tly
> >>>> >> without the use of differential transceivers in omap3 and later c=
hips.
> >>>> >> The TLL configuration is removed from the UHH driver and implemen=
ted as
> >>>> >> a seperate platform driver. Now, the UHH driver configures the TLL
> >>>> >> through API's exported by the TLL platform driver.
> >>>> >>
> >>>> >> Signed-off-by: Keshava Munegowda <keshava_mgowda@ti.com>
> >>>> >>
> >>>> >> In v4:
> >>>> >>     - rebased on top of linux kernel version 3.5.rc7
> >>>> >>     - reworked as per the comments given by Paul Walmsley <paul@p=
wsan.com>
> >>>> >>
> >>>> >> In v3:
> >>>> >>   - rebased on top V3 of Russ dill's patch
> >>>> >>        'ARM: OMAP3: USB: Fix the EHCI ULPI PHY reset issue'
> >>>> >>        fixes an issue where the ULPI PHYs were not held in reset
> >>>> >>        while initializing the EHCI controller
> >>>> >>         http://permalink.gmane.org/gmane.linux.usb.general/65988
> >>>> >>
> >>>> >>   - rebased on top of patch
> >>>> >>     OMAP: USB : Fix the EHCI enumeration and core retention issue
> >>>> >>      http://permalink.gmane.org/gmane.linux.usb.general/66239
> >>>> >>
> >>>> >> In V2:
> >>>> >>     - covered review comments from linux omap and usb community
> >>>> >>     - rebased on top Russ dill's patch
> >>>> >>        'ARM: OMAP3: USB: Fix the EHCI ULPI PHY reset issue'
> >>>> >>        fixes an issue where the ULPI PHYs were not held in reset
> >>>> >>        while initializing the EHCI controller
> >>>> >>
> >>>> >> Keshava Munegowda (5):
> >>>> >>   ARM: OMAP: Add the USB TLL clocks device name
> >>>> >>   ARM: OMAP: USB: HOST TLL platform driver
> >>>> >>   ARM: OMAP: USB: Invoke the TLL driver from USB HS core driver
> >>>> >>   ARM: OMAP: USB: Remove TLL specific code from USB HS core driver
> >>>> >>   ARM: OMAP: Remove older device name of the USB TLL clocks
> >>>> >>
> >>>> >>  arch/arm/mach-omap2/clock3xxx_data.c  |    8 +-
> >>>> >>  arch/arm/mach-omap2/clock44xx_data.c  |    4 +-
> >>>> >>  arch/arm/mach-omap2/usb-host.c        |   31 ++-
> >>>> >>  arch/arm/plat-omap/include/plat/usb.h |    7 +
> >>>> >>  drivers/mfd/Kconfig                   |    2 +-
> >>>> >>  drivers/mfd/Makefile                  |    2 +-
> >>>> >>  drivers/mfd/omap-usb-host.c           |  238 ++---------------
> >>>> >>  drivers/mfd/omap-usb-tll.c            |  471 +++++++++++++++++++=
++++++++++++++
> >>>> >>  8 files changed, 523 insertions(+), 240 deletions(-)
> >>>> >>  create mode 100644 drivers/mfd/omap-usb-tll.c
> >>>> >>
> >>>> >> --
> >>>> >> 1.7.9.5
> >>>> >
> >>>> >
> >>>> > Felipe/ Paul
> >>>> >       please let me know if you have any review comments on this v=
4 series.
> >>>> >
> >>>> > regards
> >>>> > keshava
> >>>>
> >>>> Hi Felipe
> >>>>           please let me know if you have any review comments on this=
 series now.
> >>>
> >>> looks ok... pretty much just moving code around.
> >>>
> >>> --
> >>> balbi
> >>
> >>
> >> Thanks Felipe
> >>
> >> then I request please give your Ack by for this series.
> >>
> >> regards
> >> keshava
> >
> > Hi Paul
> >     do you have any review comments on this series?
> > Felipe is OK with this series.  if there are no review comments on this=
 series
> > I request your ack by for the same.
> > Once this series gets in to mainline. i will start the Device tree
> > conversion for usb2 host.
> >
> > regards
> > keshava
>=20
> Hi Felipe
>        please give you ack by this series , so that I request
> samuel to merge to mainline.

sure, here you go

Acked-by: Felipe Balbi <balbi@ti.com>

--=20
balbi

--54u2kuW9sGWg/X+X
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQKQqYAAoJEIaOsuA1yqREDUwP/3Znlm/iSuKUceMNH6pOgqWo
CVd87dShU6443W5dBmEpIkOmV51MCk7UYCXFWdOB/bvnX+eg9yHEFbH841Kt7ylB
MP6fv5UnjfwPiN1PI4bBix2IiEJV2lpv4BuzSDUnyaerPuSsPkvTxBLevm0Kn3CL
UVicqzuiDIyhymX6fnOZ8Os8HksbYqt62WGJEBzrCouXA16EoWuncJV/DdeMkXPf
XM9YVtdrkh+kmHduhaFLBfJf4uRVrp9FFRn2IyKQyKdGq7b0/aPOFpSeLeCnVEhZ
2eAYrOXZ+TXlmL9SQpr9wHe6qi6LWAw5O84oq80UPYwQSEgUR8kyes6zWgNvAsAC
ZnzXI7AlBFBiDYb5LBqfTduvXQzLtYqTdwrJKCAHfhwRFtSFXPqQzEGbSDuba4wD
dvBQ+zBe5qVUNRHpkjsbx2zXa6OF9W0y6qlNS/KN5WTtDD5CmRNlCdyyi4PDYzSv
YxJx0YWLbznJ1XUKgLiyK1aJyJNLXvdeGn3wtgTtszW0ZkhYlx5uk4SdrZxQrvFm
CVRaUVOmky5UjQ1hHZs2FY12SbRVvgSCpNexE8rHwLXnwWEXwzdJAKsSvOsX1iF6
lum9AF0EcXtPAncDa3GKxqhv6Wrs5LSIUtrxAsq0ZWuEREIYX3nXTtqBo3LQd00Q
gcSq0inVGZGmSJIHpe1t
=NZxP
-----END PGP SIGNATURE-----

--54u2kuW9sGWg/X+X--
