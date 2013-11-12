From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Subject: Re: [PATCH v2 3/5] mtd: nand: omap2: Fix OMAP_BCH option dependency
Date: Tue, 12 Nov 2013 20:10:38 -0300
Message-ID: <20131112231037.GA26497@localhost>
References: <1382696277-9063-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1382696277-9063-4-git-send-email-ezequiel.garcia@free-electrons.com>
 <20980858CB6D3A4BAE95CA194937D5E73EA2AE93@DBDE04.ent.ti.com>
 <20131112204555.GA20260@localhost>
 <20131112225647.GM20061@ld-irv-0074.broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:45057 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755239Ab3KLXKn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 12 Nov 2013 18:10:43 -0500
Content-Disposition: inline
In-Reply-To: <20131112225647.GM20061@ld-irv-0074.broadcom.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Brian Norris <computersforpeace@gmail.com>
Cc: "Balbi, Felipe" <balbi@ti.com>, "marek.belisko@gmail.com" <marek.belisko@gmail.com>, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Pekon Gupta <pekon@ti.com>

On Tue, Nov 12, 2013 at 02:56:47PM -0800, Brian Norris wrote:
> On Tue, Nov 12, 2013 at 05:45:56PM -0300, Ezequiel Garcia wrote:
> > On Fri, Oct 25, 2013 at 11:26:06AM +0000, Gupta, Pekon wrote:
> > > > From: Ezequiel Garcia [mailto:ezequiel.garcia@free-electrons.co=
m]
> > > > Subject: [PATCH v2 3/5] mtd: nand: omap2: Fix OMAP_BCH option
> > > > dependency
> > > >=20
> > > > This option does not need to depend in MTD_NAND, for it's enclo=
sed
> > > > under it. Also, it's wrong to make it depend in ARCH_OMAP3 only
> > > > since the controller is used in a wider range of SoCs.
> > > >=20
> > > > Instead, just leave the dependency on the OMAP2 driver option.
> > > >=20
> > > > Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.=
com>
> > > > ---
> > > >  drivers/mtd/nand/Kconfig | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >=20
> > > > diff --git a/drivers/mtd/nand/Kconfig b/drivers/mtd/nand/Kconfi=
g
> > > > index d885298..8187466 100644
> > > > --- a/drivers/mtd/nand/Kconfig
> > > > +++ b/drivers/mtd/nand/Kconfig
> > > > @@ -95,7 +95,7 @@ config MTD_NAND_OMAP2
> > > >  	  platforms.
> > > >=20
> > > >  config MTD_NAND_OMAP_BCH
> > > > -	depends on MTD_NAND && MTD_NAND_OMAP2 && ARCH_OMAP3
> > > > +	depends on MTD_NAND_OMAP2
> > > >  	tristate "Enable support for hardware BCH error correction"
> > > >  	default n
> > > >  	select BCH
> > > > --
> > > > 1.8.1.5
> > >=20
> > > Acked-by: Pekon Gupta <pekon@ti.com>
> >=20
> > Brian,
> >=20
> > I almost forgot about this one, and I just came across the issue
> > while configuring my board.
> >=20
> > I believe this one is simple enough to be pulled in for v3.14
> > (it could be in v3.13, but it's already too late).
> >=20
> > Or maybe you're not taking stuff for v3.14 yet...
>=20
> Thanks for the reminder. The rest of the series has been discussed
> separately or is otherwise superceded by other patch series, right?
>=20

The rest of the series can be divided in two groups:

1. Trivial stuff: I'll sent re-based patches on top of v3.13-rc1
or maybe Pekon will take care of it. It's not a big deal.

2. The ONFI detection stuff: it's not trivial and it's still under
discussion in separate threads. The last work was suggested by Pekon
in his last mail, and I guess he'll post a separate patch soon.

> Applied this one patch to l2-mtd.git, branch 'next'. Thanks.

Great, thanks.
--=20
Ezequiel Garc=C3=ADa, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
