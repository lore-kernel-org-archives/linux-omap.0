From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v3 10/10] mtd: nand: omap2: use gpmc provided irqs
Date: Mon, 10 Sep 2012 17:17:10 -0700
Message-ID: <20120911001710.GD1303@atomide.com>
References: <cover.1344609341.git.afzal@ti.com>
 <c5a608a70a875191e1323958c74fb2ac8dfa34b3.1344609341.git.afzal@ti.com>
 <1345895326.1815.4.camel@kyv>
 <20120830195349.GW1303@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:49766 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750886Ab2IKARQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 10 Sep 2012 20:17:16 -0400
Content-Disposition: inline
In-Reply-To: <20120830195349.GW1303@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Artem Bityutskiy <dedekind1@gmail.com>
Cc: Afzal Mohammed <afzal@ti.com>, artem.bityutskiy@linux.intel.com, linux-omap@vger.kernel.org, linux-mtd@lists.infradead.org, ivan.djelic@parrot.com

* Tony Lindgren <tony@atomide.com> [120830 12:54]:
> * Artem Bityutskiy <dedekind1@gmail.com> [120825 04:49]:
> > On Tue, 2012-08-21 at 15:14 +0530, Afzal Mohammed wrote:
> > > GPMC platform initialization provides it's clients
> > > with interrupts that can be used through struct
> > > resource. Make use of it for irq mode functionality.
> > >=20
> > > Also now write protect disable is done by GPMC,
> > > hence remove it.
> > >=20
> > > Signed-off-by: Afzal Mohammed <afzal@ti.com>
> >=20
> > Acked-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
>=20
> Thanks I'll apply these into omap devel-gpmc branch.

=46YI, looks like a new warning got introduced, so I've
committed the following trivial patch on top of this series.

Regards,

Tony

=46rom: Tony Lindgren <tony@atomide.com>
Date: Mon, 10 Sep 2012 17:14:13 -0700
Subject: [PATCH] mtd: nand omap2: Fix uninitialized err warning

Commit bd4156fd (mtd: nand: omap2: use gpmc provided irqs)
introduced a new warning:

drivers/mtd/nand/omap2.c: In function =E2=80=98omap_nand_probe=E2=80=99=
:
drivers/mtd/nand/omap2.c:1267: warning: =E2=80=98err=E2=80=99 may be us=
ed uninitialized in this function

Signed-off-by: Tony Lindgren <tony@atomide.com>

--- a/drivers/mtd/nand/omap2.c
+++ b/drivers/mtd/nand/omap2.c
@@ -1389,6 +1389,7 @@ static int __devinit omap_nand_probe(struct platf=
orm_device *pdev)
 		info->gpmc_irq_fifo =3D platform_get_irq(pdev, 0);
 		if (info->gpmc_irq_fifo <=3D 0) {
 			dev_err(&pdev->dev, "error getting fifo irq\n");
+			err =3D -ENODEV;
 			goto out_release_mem_region;
 		}
 		err =3D request_irq(info->gpmc_irq_fifo,	omap_nand_irq,
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
