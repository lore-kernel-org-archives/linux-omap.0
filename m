From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Subject: Re: [PATCH v2 4/5] mtd: nand: omap2: Use devm_kzalloc
Date: Fri, 25 Oct 2013 07:42:47 -0300
Message-ID: <20131025104246.GA2489@localhost>
References: <1382696277-9063-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1382696277-9063-5-git-send-email-ezequiel.garcia@free-electrons.com>
 <20980858CB6D3A4BAE95CA194937D5E73EA2AD60@DBDE04.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:54264 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752511Ab3JYKmx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 25 Oct 2013 06:42:53 -0400
Content-Disposition: inline
In-Reply-To: <20980858CB6D3A4BAE95CA194937D5E73EA2AD60@DBDE04.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gupta, Pekon" <pekon@ti.com>
Cc: Brian Norris <computersforpeace@gmail.com>, "Balbi, Felipe" <balbi@ti.com>, "marek.belisko@gmail.com" <marek.belisko@gmail.com>, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Fri, Oct 25, 2013 at 10:25:02AM +0000, Gupta, Pekon wrote:
> Hi,
>=20
> >=20
> > This simplifies the error path and makes the code less error-prone.
> >=20
> > Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> > ---
> >  drivers/mtd/nand/omap2.c | 5 +----
> >  1 file changed, 1 insertion(+), 4 deletions(-)
> >=20
> > diff --git a/drivers/mtd/nand/omap2.c b/drivers/mtd/nand/omap2.c
> > index e01a936..d3155b2 100644
> > --- a/drivers/mtd/nand/omap2.c
> > +++ b/drivers/mtd/nand/omap2.c
> > @@ -1837,7 +1837,7 @@ static int omap_nand_probe(struct
> > platform_device *pdev)
> >  		return -ENODEV;
> >  	}
> >=20
> > -	info =3D kzalloc(sizeof(struct omap_nand_info), GFP_KERNEL);
> > +	info =3D devm_kzalloc(&pdev->dev, sizeof(*info), GFP_KERNEL);
> >  	if (!info)
> >  		return -ENOMEM;
> >=20
> > @@ -2067,8 +2067,6 @@ out_release_mem_region:
> >  		free_irq(info->gpmc_irq_fifo, info);
> >  	release_mem_region(info->phys_base, info->mem_size);
> >  out_free_info:
> > -	kfree(info);
> > -
> >  	return err;
> >  }
> >=20
> > @@ -2091,7 +2089,6 @@ static int omap_nand_remove(struct
> > platform_device *pdev)
> >  	nand_release(&info->mtd);
> >  	iounmap(info->nand.IO_ADDR_R);
> >  	release_mem_region(info->phys_base, info->mem_size);
> > -	kfree(info);
> >  	return 0;
> >  }
> >=20
> > --
> > 1.8.1.5
>=20
> I think these changes are already done as part of following patch..
> http://lists.infradead.org/pipermail/linux-mtd/2013-October/049418.ht=
ml
>=20
> Did your rebase on my patch-set ?
>=20

Hm.. well the problem with that patch is that it's in the middle of an
unrelated series. As I already told you, I think you should have pushed
that as a one-patch fix. Have you seen that suggestion?

On the other side, you're fixing too many things in that single patch,
for my taste. Maybe I'm not the smarter developer, but going through
that patch is not easy to catch if there's no mistake done.

Usually if it's possible to split a patch (maintaining consistency) it =
makes
the reviewing process easier.
If you'd rather send this devm_xxx change yourself that's fine by me,
but *please* split the patch in two and write proper commit messages.

Anyway: this is just a silly change, the important one is the other
nand_scan_ident() fix. Could you help me review that?

I'm interested in knowing how will that work with 8-bit and 16-bit devi=
ces.
--=20
Ezequiel Garc=C3=ADa, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
