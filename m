From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Subject: Re: [PATCH 4/5] mtd: nand: omap2: Use devm_kzalloc
Date: Thu, 24 Oct 2013 19:50:50 -0300
Message-ID: <20131024225049.GB20462@localhost>
References: <1382652737-20239-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1382652737-20239-5-git-send-email-ezequiel.garcia@free-electrons.com>
 <CAAfyv37SL94Ohwqqs6u5AMvdj4aAgQMGRe_9zze=TcS5An_U0w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:52720 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753857Ab3JXWu4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 24 Oct 2013 18:50:56 -0400
Content-Disposition: inline
In-Reply-To: <CAAfyv37SL94Ohwqqs6u5AMvdj4aAgQMGRe_9zze=TcS5An_U0w@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Belisko Marek <marek.belisko@gmail.com>
Cc: "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Brian Norris <computersforpeace@gmail.com>, Pekon Gupta <pekon@ti.com>, Felipe Balbi <balbi@ti.com>

On Fri, Oct 25, 2013 at 12:24:38AM +0200, Belisko Marek wrote:
> Hi,
>=20
> On Fri, Oct 25, 2013 at 12:12 AM, Ezequiel Garcia
> <ezequiel.garcia@free-electrons.com> wrote:
> > This simplifies the error path and makes the code less error-prone.
> >
> > Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> > ---
> >  drivers/mtd/nand/omap2.c | 6 +-----
> >  1 file changed, 1 insertion(+), 5 deletions(-)
> >
> > diff --git a/drivers/mtd/nand/omap2.c b/drivers/mtd/nand/omap2.c
> > index e01a936..d4cafb0 100644
> > --- a/drivers/mtd/nand/omap2.c
> > +++ b/drivers/mtd/nand/omap2.c
> > @@ -1837,7 +1837,7 @@ static int omap_nand_probe(struct platform_de=
vice *pdev)
> >                 return -ENODEV;
> >         }
> >
> > -       info =3D kzalloc(sizeof(struct omap_nand_info), GFP_KERNEL)=
;
> > +       info =3D devm_kzalloc(&pdev->dev, sizeof(*info), GFP_KERNEL=
);
> >         if (!info)
> >                 return -ENOMEM;
> >
> > @@ -2066,9 +2066,6 @@ out_release_mem_region:
> >         if (info->gpmc_irq_fifo > 0)
> >                 free_irq(info->gpmc_irq_fifo, info);
> >         release_mem_region(info->phys_base, info->mem_size);
> > -out_free_info:
> You remove ^^^^ statement but it's still used in line ~1868 as return=
 when
> cannot get resource.

Right, I missed that. This happens when you do two cleanups at once and=
 then
try to commit them separatedly!

Thanks!
--=20
Ezequiel Garc=C3=ADa, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
