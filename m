From: "Aggarwal, Anuj" <anuj.aggarwal@ti.com>
Subject: RE: [PATCH 5/5] Regulator: Renaming the supplies used in MMC driver
Date: Fri, 6 Nov 2009 11:21:14 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB030A67E302@dbde02.ent.ti.com>
References: <1257439189-29594-1-git-send-email-anuj.aggarwal@ti.com>
 <f870da180911051317r7693dce2l8e6a345d2055198@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:60844 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752157AbZKFFvV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 6 Nov 2009 00:51:21 -0500
In-Reply-To: <f870da180911051317r7693dce2l8e6a345d2055198@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mike Rapoport <mike.rapoport@gmail.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>

> -----Original Message-----
> From: Mike Rapoport [mailto:mike.rapoport@gmail.com]
> Sent: Friday, November 06, 2009 2:47 AM
> To: Aggarwal, Anuj
> Cc: linux-omap@vger.kernel.org; broonie@opensource.wolfsonmicro.com;
> lrg@slimlogic.co.uk
> Subject: Re: [PATCH 5/5] Regulator: Renaming the supplies used in MMC
> driver
>=20
> On Thu, Nov 5, 2009 at 6:39 PM, Anuj Aggarwal <anuj.aggarwal@ti.com>
> wrote:
> > Supply names are renamed from vmmc -> mmc and vmmc_aux -> mmc_aux.
> > This is done to have simple supply names both in the driver
> > and in the board-evm file.
> >
> > Signed-off-by: Anuj Aggarwal <anuj.aggarwal@ti.com>
> > ---
> > =A0arch/arm/mach-omap2/mmc-twl4030.c | =A0 =A06 +++---
> > =A01 files changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/arch/arm/mach-omap2/mmc-twl4030.c b/arch/arm/mach-
> omap2/mmc-twl4030.c
> > index 3403914..af3b1be 100644
> > --- a/arch/arm/mach-omap2/mmc-twl4030.c
> > +++ b/arch/arm/mach-omap2/mmc-twl4030.c
> > @@ -109,9 +109,9 @@ static int twl_mmc_late_init(struct device *dev=
)
> >
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0hsmmc[i].mmc =3D mmc=
;
> >
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D regulator_get=
(dev, "vmmc");
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D regulator_get=
(dev, "mmc");
>=20
> It will break all existing OMAP3 boards.
[Aggarwal, Anuj] This was done to have the same naming conventions acro=
ss
the board. I could not find an extra "v" in supply names except MMC.
Hence modified this. Regulator supply names should be simple and easy t=
o
understand.
I can revert this change or change the dependent board files for SDP/LD=
P
etc. What do you suggest?
>=20
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (IS_ERR(reg)) {
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_d=
bg(dev, "vmmc regulator
> missing\n");
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_d=
bg(dev, "mmc regulator missing\n");
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* H=
ACK: until fixed.c regulator is
> usable,
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * w=
e don't require a main regulator
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * f=
or MMC2 or MMC3
> > @@ -126,7 +126,7 @@ static int twl_mmc_late_init(struct device *dev=
)
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc->slots[0].ocr_ma=
sk =3D
> mmc_regulator_get_ocrmask(reg);
> >
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* allow an aux regu=
lator */
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D regulator_get=
(dev, "vmmc_aux");
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D regulator_get=
(dev, "mmc_aux");
>=20
> ditto.
>=20
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0hsmmc[i].vcc_aux =3D=
 IS_ERR(reg) ? NULL : reg;
> >
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* UGLY HACK: =A0wor=
karound regulator framework
> bugs.
> > --
> > 1.6.2.4
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-oma=
p" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at =A0http://vger.kernel.org/majordomo-info.htm=
l
> >
>=20
>=20
>=20
> --
> 	Sincerely Yours,
> 		Mike.

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
