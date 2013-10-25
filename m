From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Subject: Re: [PATCH v2 3/5] mtd: nand: omap2: Fix OMAP_BCH option dependency
Date: Fri, 25 Oct 2013 08:49:55 -0300
Message-ID: <20131025114954.GE2489@localhost>
References: <1382696277-9063-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1382696277-9063-4-git-send-email-ezequiel.garcia@free-electrons.com>
 <20980858CB6D3A4BAE95CA194937D5E73EA2AE93@DBDE04.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:54696 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751568Ab3JYLuA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 25 Oct 2013 07:50:00 -0400
Content-Disposition: inline
In-Reply-To: <20980858CB6D3A4BAE95CA194937D5E73EA2AE93@DBDE04.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gupta, Pekon" <pekon@ti.com>
Cc: Brian Norris <computersforpeace@gmail.com>, "Balbi, Felipe" <balbi@ti.com>, "marek.belisko@gmail.com" <marek.belisko@gmail.com>, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Fri, Oct 25, 2013 at 11:26:06AM +0000, Gupta, Pekon wrote:
> > From: Ezequiel Garcia [mailto:ezequiel.garcia@free-electrons.com]
> > Subject: [PATCH v2 3/5] mtd: nand: omap2: Fix OMAP_BCH option
> > dependency
> >=20
> > This option does not need to depend in MTD_NAND, for it's enclosed
> > under it. Also, it's wrong to make it depend in ARCH_OMAP3 only
> > since the controller is used in a wider range of SoCs.
> >=20
> > Instead, just leave the dependency on the OMAP2 driver option.
> >=20
> > Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> > ---
> >  drivers/mtd/nand/Kconfig | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/mtd/nand/Kconfig b/drivers/mtd/nand/Kconfig
> > index d885298..8187466 100644
> > --- a/drivers/mtd/nand/Kconfig
> > +++ b/drivers/mtd/nand/Kconfig
> > @@ -95,7 +95,7 @@ config MTD_NAND_OMAP2
> >  	  platforms.
> >=20
> >  config MTD_NAND_OMAP_BCH
> > -	depends on MTD_NAND && MTD_NAND_OMAP2 && ARCH_OMAP3
> > +	depends on MTD_NAND_OMAP2
> >  	tristate "Enable support for hardware BCH error correction"
> >  	default n
> >  	select BCH
> > --
> > 1.8.1.5
>=20
> Acked-by: Pekon Gupta <pekon@ti.com>

Thanks!

> Reported-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
>=20

=46WIW, If I'm signing-off this commit, it's implicit that I'm the
reporter.
--=20
Ezequiel Garc=C3=ADa, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
