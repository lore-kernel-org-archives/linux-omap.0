From: "Aggarwal, Anuj" <anuj.aggarwal@ti.com>
Subject: RE: [PATCHv3 2/4] Regulator: OMAP: Modifying Kconfig/Makefile to
 	choose from available PMICs
Date: Wed, 3 Mar 2010 12:25:14 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB0321CBC701@dbde02.ent.ti.com>
References: <1267525787-3169-1-git-send-email-anuj.aggarwal@ti.com>
 <6ed0b2681003020923m2c7526fn11995334c36c8a83@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:52682 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754753Ab0CCGz2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 3 Mar 2010 01:55:28 -0500
In-Reply-To: <6ed0b2681003020923m2c7526fn11995334c36c8a83@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grazvydas Ignotas <notasas@gmail.com>
Cc: "tony@atomide.com" <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>

> -----Original Message-----
> From: Grazvydas Ignotas [mailto:notasas@gmail.com]
> Sent: Tuesday, March 02, 2010 10:54 PM
> To: Aggarwal, Anuj
> Cc: tony@atomide.com; linux-omap@vger.kernel.org;
> broonie@opensource.wolfsonmicro.com; lrg@slimlogic.co.uk
> Subject: Re: [PATCHv3 2/4] Regulator: OMAP: Modifying Kconfig/Makefil=
e to
> choose from available PMICs
>=20
> On Tue, Mar 2, 2010 at 12:29 PM, Anuj Aggarwal <anuj.aggarwal@ti.com>
> wrote:
> > Kconfig is modified for OMAP3 EVM so that user can choose the
> appropriate
> > PMIC (currently only TWL4030). Config options for other PMICs will =
be
> > added later on.
> > Makefile is modified so that twl4030-pmic.c gets compiled for the
> > platforms having TWL4030 as the PMIC.
> >
> > Signed-off-by: Anuj Aggarwal <anuj.aggarwal@ti.com>
> > ---
> > =A0arch/arm/mach-omap2/Kconfig =A0| =A0 =A09 +++++++++
> > =A0arch/arm/mach-omap2/Makefile | =A0 =A01 +
> > =A02 files changed, 10 insertions(+), 0 deletions(-)
> >
> > diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kcon=
fig
> > index a8a3d1e..1974dda 100644
> > --- a/arch/arm/mach-omap2/Kconfig
> > +++ b/arch/arm/mach-omap2/Kconfig
> > @@ -77,6 +77,15 @@ config MACH_OMAP3EVM
> > =A0 =A0 =A0 =A0depends on ARCH_OMAP3
> > =A0 =A0 =A0 =A0select OMAP_PACKAGE_CBB
> >
> > +config PMIC_TWL4030
> > + =A0 =A0 =A0 bool "TWL4030/TPS65950 Power Module"
> > + =A0 =A0 =A0 default y
> > + =A0 =A0 =A0 select TWL4030_CORE
> > + =A0 =A0 =A0 select REGULATOR_TWL4030 if REGULATOR
> > + =A0 =A0 =A0 help
> > + =A0 =A0 =A0 =A0 Say yes here if you are using the TWL4030/TPS6595=
0 based power
> module
> > + =A0 =A0 =A0 =A0 for the EVM boards.
> > +
>=20
> Any reason to have this user configurable? The boards that depend on
> it will always need it to be enabled to compile, and the ones that
> don't always want it disabled.
[Aggarwal, Anuj] OMAP3 EVM can have different PMICs like TWL4030,
TPS65023, TPS6507x etc; user can configure the kernel accordingly.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
