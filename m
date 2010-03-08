From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCHv3 2/4] Regulator: OMAP: Modifying Kconfig/Makefile to
 choose from available PMICs
Date: Mon, 8 Mar 2010 14:55:32 -0800
Message-ID: <20100308225532.GG2900@atomide.com>
References: <1267525787-3169-1-git-send-email-anuj.aggarwal@ti.com>
 <6ed0b2681003020923m2c7526fn11995334c36c8a83@mail.gmail.com>
 <5A47E75E594F054BAF48C5E4FC4B92AB0321CBC701@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:60215 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755773Ab0CHWyQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 8 Mar 2010 17:54:16 -0500
Content-Disposition: inline
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB0321CBC701@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Aggarwal, Anuj" <anuj.aggarwal@ti.com>
Cc: Grazvydas Ignotas <notasas@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>

* Aggarwal, Anuj <anuj.aggarwal@ti.com> [100302 22:52]:
> > -----Original Message-----
> > From: Grazvydas Ignotas [mailto:notasas@gmail.com]
> > Sent: Tuesday, March 02, 2010 10:54 PM
> > To: Aggarwal, Anuj
> > Cc: tony@atomide.com; linux-omap@vger.kernel.org;
> > broonie@opensource.wolfsonmicro.com; lrg@slimlogic.co.uk
> > Subject: Re: [PATCHv3 2/4] Regulator: OMAP: Modifying Kconfig/Makef=
ile to
> > choose from available PMICs
> >=20
> > On Tue, Mar 2, 2010 at 12:29 PM, Anuj Aggarwal <anuj.aggarwal@ti.co=
m>
> > wrote:
> > > Kconfig is modified for OMAP3 EVM so that user can choose the
> > appropriate
> > > PMIC (currently only TWL4030). Config options for other PMICs wil=
l be
> > > added later on.
> > > Makefile is modified so that twl4030-pmic.c gets compiled for the
> > > platforms having TWL4030 as the PMIC.
> > >
> > > Signed-off-by: Anuj Aggarwal <anuj.aggarwal@ti.com>
> > > ---
> > > =C2=A0arch/arm/mach-omap2/Kconfig =C2=A0| =C2=A0 =C2=A09 ++++++++=
+
> > > =C2=A0arch/arm/mach-omap2/Makefile | =C2=A0 =C2=A01 +
> > > =C2=A02 files changed, 10 insertions(+), 0 deletions(-)
> > >
> > > diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kc=
onfig
> > > index a8a3d1e..1974dda 100644
> > > --- a/arch/arm/mach-omap2/Kconfig
> > > +++ b/arch/arm/mach-omap2/Kconfig
> > > @@ -77,6 +77,15 @@ config MACH_OMAP3EVM
> > > =C2=A0 =C2=A0 =C2=A0 =C2=A0depends on ARCH_OMAP3
> > > =C2=A0 =C2=A0 =C2=A0 =C2=A0select OMAP_PACKAGE_CBB
> > >
> > > +config PMIC_TWL4030
> > > + =C2=A0 =C2=A0 =C2=A0 bool "TWL4030/TPS65950 Power Module"
> > > + =C2=A0 =C2=A0 =C2=A0 default y
> > > + =C2=A0 =C2=A0 =C2=A0 select TWL4030_CORE
> > > + =C2=A0 =C2=A0 =C2=A0 select REGULATOR_TWL4030 if REGULATOR
> > > + =C2=A0 =C2=A0 =C2=A0 help
> > > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 Say yes here if you are using the T=
WL4030/TPS65950 based power
> > module
> > > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 for the EVM boards.
> > > +
> >=20
> > Any reason to have this user configurable? The boards that depend o=
n
> > it will always need it to be enabled to compile, and the ones that
> > don't always want it disabled.

> [Aggarwal, Anuj] OMAP3 EVM can have different PMICs like TWL4030,
> TPS65023, TPS6507x etc; user can configure the kernel accordingly.

We need to be able to compile in support for multiple PMICs, so
just probe for PMICs via I2C and use the one you find.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
