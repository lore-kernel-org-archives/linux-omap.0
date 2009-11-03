From: Artem Bityutskiy <dedekind1@gmail.com>
Subject: Re: [PATCH 2/3]NAND: OMAP: Fixing omap nand driver, compiled as
 module
Date: Tue, 03 Nov 2009 10:39:10 +0200
Message-ID: <1257237550.21596.62.camel@localhost>
References: <ce9ab5790910292321y1e7239b7pbffe9a5891d66448@mail.gmail.com>
	 <ce9ab5790910300142kf12e31cpd6249d4c7383553f@mail.gmail.com>
	 <ce9ab5790910300227r41d42673webad0ee48e3444d1@mail.gmail.com>
	 <1257236897.21596.57.camel@localhost>
	 <ce9ab5790911030035p2f8dfe21q7c8f911077adc262@mail.gmail.com>
Reply-To: dedekind1@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:37400 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755712AbZKCIjW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 3 Nov 2009 03:39:22 -0500
In-Reply-To: <ce9ab5790911030035p2f8dfe21q7c8f911077adc262@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vimal Singh <vimal.newwork@gmail.com>
Cc: Linux MTD <linux-mtd@lists.infradead.org>, linux-omap@vger.kernel.org

On Tue, 2009-11-03 at 14:05 +0530, Vimal Singh wrote:
> On Tue, Nov 3, 2009 at 1:58 PM, Artem Bityutskiy <dedekind1@gmail.com=
> wrote:
> > On Fri, 2009-10-30 at 14:57 +0530, Vimal Singh wrote:
> >> Last time I forgot to 'git add' for 'arch/arm/mach-omap2/gpmc.c'..=
=2E My bad.
> >> Correct patch is below.
> >>
> >> -vimal
> >>
> >>
> >> From: Vimal Singh <vimalsingh@ti.com>
> >> Date: Fri, 30 Oct 2009 14:54:29 +0530
> >> Subject: [PATCH] NAND: OMAP: Fixing omap nand driver, compiled as =
module
> >>
> >> Removing OMAP NAND driver, when loaded as a module, gives error an=
d
> >> does not get success. This fixes this and makes driver loadable an=
d
> >> removable run time.
> >>
> >> Signed-off-by: Vimal Singh <vimalsingh@ti.com>
> >> ---
> >>  arch/arm/mach-omap2/gpmc.c |    2 ++
> >>  drivers/mtd/nand/omap2.c   |    5 ++++-
> >>  2 files changed, 6 insertions(+), 1 deletions(-)
> >>
> >> diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc=
=2Ec
> >> index 1587682..1d10b7b 100644
> >> --- a/arch/arm/mach-omap2/gpmc.c
> >> +++ b/arch/arm/mach-omap2/gpmc.c
> >> @@ -88,6 +88,7 @@ void gpmc_cs_write_reg(int cs, int idx, u32 val)
> >>       reg_addr =3D gpmc_base + GPMC_CS0 + (cs * GPMC_CS_SIZE) + id=
x;
> >>       __raw_writel(val, reg_addr);
> >>  }
> >> +EXPORT_SYMBOL(gpmc_cs_write_reg);
> >>
> >>  u32 gpmc_cs_read_reg(int cs, int idx)
> >>  {
> >> @@ -96,6 +97,7 @@ u32 gpmc_cs_read_reg(int cs, int idx)
> >>       reg_addr =3D gpmc_base + GPMC_CS0 + (cs * GPMC_CS_SIZE) + id=
x;
> >>       return __raw_readl(reg_addr);
> >>  }
> >> +EXPORT_SYMBOL(gpmc_cs_read_reg);
> >
> > Why do you export these?
>=20
> These functions are called during prob. So, if not exported and drive=
r
> is compiled as a module compilation will break with error saying thes=
e
> are not defined or not found.

Could you show the place where they are called from please. I tried to
compile the omap NAND driver as module and it compiled fine. Probably
I'm missing something?

--=20
Best Regards,
Artem Bityutskiy (=D0=90=D1=80=D1=82=D1=91=D0=BC =D0=91=D0=B8=D1=82=D1=8E=
=D1=86=D0=BA=D0=B8=D0=B9)

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
