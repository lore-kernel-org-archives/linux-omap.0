From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/2]: Introducing 'gpmc-nand.c' for GPMC specific NAND
 init
Date: Tue, 8 Dec 2009 15:57:25 -0800
Message-ID: <20091208235725.GA24013@atomide.com>
References: <64662.192.168.10.89.1259933932.squirrel@dbdmail.itg.ti.com>
 <20091204220138.GJ24013@atomide.com>
 <ce9ab5790912062229xae89bb3m6965b4f4465f11c3@mail.gmail.com>
 <ce9ab5790912070529h1143355du691ce6a23f5ddb56@mail.gmail.com>
 <20091207175644.GA24013@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:50506 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966728AbZLHX5V (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 Dec 2009 18:57:21 -0500
Content-Disposition: inline
In-Reply-To: <20091207175644.GA24013@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vimal Singh <vimal.newwork@gmail.com>
Cc: "Govindraj.R" <govindraj.raja@ti.com>, linux-omap@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [091207 09:56]:
> * Vimal Singh <vimal.newwork@gmail.com> [091207 05:28]:
> > On Mon, Dec 7, 2009 at 11:59 AM, Vimal Singh <vimal.newwork@gmail.c=
om> wrote:
> > > On Sat, Dec 5, 2009 at 3:31 AM, Tony Lindgren <tony@atomide.com> =
wrote:
> > >> Hi,
> > >>
> > >> Looks good, just one comment below.
> > >>
> > >> * Govindraj.R <govindraj.raja@ti.com> [091204 05:37]:
> > >>> From: Vimal Singh <vimalsingh@ti.com>
> > >>> Date: Wed, 25 Nov 2009 18:23:15 +0530
> > >>> Subject: [PATCH] Introducing 'gpmc-nand.c' for GPMC specific NA=
ND init
> > >>>
> > >>> Introducing 'gpmc-nand.c' for GPMC specific NAND init.
> > >>> For example: GPMC timing parameters and all.
> > >>> This patch also migrates gpmc related calls from 'nand/omap2.c'
> > >>> to 'gpmc-nand.c'.
> > >>>
> > >>> Signed-off-by: Vimal Singh <vimalsingh@ti.com>
> > >>> ---
> > >>> =A0arch/arm/mach-omap2/Makefile =A0 =A0 =A0 =A0 =A0 | =A0 =A03 =
+
> > >>> =A0arch/arm/mach-omap2/gpmc-nand.c =A0 =A0 =A0 =A0| =A0141 ++++=
++++++++++++++++++++++++++++
> > >>> =A0arch/arm/plat-omap/include/plat/nand.h | =A0 =A06 ++
> > >>> =A0drivers/mtd/nand/omap2.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 2=
6 +-----
> > >>> =A04 files changed, 153 insertions(+), 23 deletions(-)
> > >>> =A0create mode 100644 arch/arm/mach-omap2/gpmc-nand.c
> > >>
> > >> <snip>
> > >>
> > >>> --- /dev/null
> > >>> +++ b/arch/arm/mach-omap2/gpmc-nand.c
> > >>
> > >> <snip>
> > >>
> > >>> +int __init gpmc_nand_init(struct omap_nand_platform_data *_nan=
d_data)
> > >>> +{
> > >>> + =A0 =A0 unsigned int val;
> > >>> + =A0 =A0 int err =3D 0;
> > >>> + =A0 =A0 struct device *dev =3D &gpmc_nand_device.dev;
> > >>> +
> > >>> + =A0 =A0 gpmc_nand_data =3D _nand_data;
> > >>> + =A0 =A0 gpmc_nand_data->nand_setup =3D gpmc_nand_setup;
> > >>> + =A0 =A0 gpmc_nand_device.dev.platform_data =3D gpmc_nand_data=
;
> > >>> +
> > >>> + =A0 =A0 err =3D gpmc_nand_setup(gpmc_nand_data->gpmc_cs_basea=
ddr);
> > >>> + =A0 =A0 if (err < 0) {
> > >>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "NAND platform setup fai=
led: %d\n", err);
> > >>> + =A0 =A0 =A0 =A0 =A0 =A0 return err;
> > >>> + =A0 =A0 }
> > >>> +
> > >>> + =A0 =A0 /* Enable RD PIN Monitoring Reg */
> > >>> + =A0 =A0 if (gpmc_nand_data->dev_ready) {
> > >>> + =A0 =A0 =A0 =A0 =A0 =A0 val =A0=3D gpmc_cs_read_reg(gpmc_nand=
_data->cs,
> > >>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0GPMC_CS_CONFIG1);
> > >>> + =A0 =A0 =A0 =A0 =A0 =A0 val |=3D WR_RD_PIN_MONITORING;
> > >>> + =A0 =A0 =A0 =A0 =A0 =A0 gpmc_cs_write_reg(gpmc_nand_data->cs,
> > >>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 GPMC_CS_CONFIG1, val);
> > >>> + =A0 =A0 }
> > >>
> > >> Above looks OK..
> > >>
> > >>> + =A0 =A0 val =A0=3D gpmc_cs_read_reg(gpmc_nand_data->cs, GPMC_=
CS_CONFIG7);
> > >>> + =A0 =A0 val &=3D ~(0xf << 8);
> > >>> + =A0 =A0 val |=3D =A0(0xc & 0xf) << 8;
> > >>> + =A0 =A0 gpmc_cs_write_reg(gpmc_nand_data->cs, GPMC_CS_CONFIG7=
, val);
> > >>
> > >> ..but this looks messy. Maybe use some GPMC defines for the
> > >> 0xf << 8 mask?
> > >>
> > >> Then the 0xc & 0xf part looks a bit redundant, what's the 0xf
> > >> there for?
> > >>
> > >> I know it's all from the old code, but might as well clean it up
> > >> while at it :)
> > >
> > > Ok, I'll drop next version of this patch for this.
> > >
> >=20
> > In fact this peace of code is not required too. This will be taken
> > care in 'gpmc_cs_request'.
> > I will remove it.
>=20
> OK, cool.

Any news on posting the updated version of this? Would be nice to
get it in this merge window, so time's running out :)

When re-posting, please also cc linux-arm-kernel@lists.infradead.org
in addition to linux-omap list. That way we can have it quickly
reviewed there too.

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
