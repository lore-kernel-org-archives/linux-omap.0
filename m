From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Subject: Re: [PATCH v11 04/10] mtd: nand: omap: use DT specified bus-width
 only for scanning NAND device
Date: Thu, 24 Oct 2013 19:49:24 -0300
Message-ID: <20131024224923.GA20462@localhost>
References: <1382619026-4182-1-git-send-email-pekon@ti.com>
 <1382619026-4182-5-git-send-email-pekon@ti.com>
 <20131024212714.GB2520@localhost>
 <20131024224300.GG20061@ld-irv-0074.broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:52708 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753902Ab3JXWtf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 24 Oct 2013 18:49:35 -0400
Content-Disposition: inline
In-Reply-To: <20131024224300.GG20061@ld-irv-0074.broadcom.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Brian Norris <computersforpeace@gmail.com>
Cc: Pekon Gupta <pekon@ti.com>, mark.rutland@arm.com, olof@lixom.net, dedekind1@gmail.com, devicetree@vger.kernel.org, Pawel.Moll@arm.com, arnd@arndb.de, swarren@wwwdotorg.org, tony@atomide.com, jp.francois@cynove.com, ijc+devicetree@hellion.org.uk, avinashphilipk@gmail.com, balbi@ti.com, robherring2@gmail.com, bcousson@baylibre.com, linux-mtd@lists.infradead.org, ivan.djelic@parrot.com, linux-omap@vger.kernel.org, dwmw2@infradead.org, Alexander Shiyan <shc_work@mail.ru>, Matthieu Castet <matthieu.castet@parrot.com>, Jon Hunter <jon-hunter@ti.com>

On Thu, Oct 24, 2013 at 03:43:00PM -0700, Brian Norris wrote:
> On Thu, Oct 24, 2013 at 06:27:15PM -0300, Ezequiel Garcia wrote:
> > On Thu, Oct 24, 2013 at 06:20:20PM +0530, Pekon Gupta wrote:
> > > This patch:
> > > - calls nand_scan_ident() using bus-width as passed by DT
> > > - removes double calls to nand_scan_ident(), incase first call fa=
ils
> > >   then omap_nand_probe just returns error.
> > >=20
> > > Signed-off-by: Pekon Gupta <pekon@ti.com>
> > > ---
> > >  drivers/mtd/nand/omap2.c | 21 +++++++++------------
> > >  1 file changed, 9 insertions(+), 12 deletions(-)
> > >=20
> > > diff --git a/drivers/mtd/nand/omap2.c b/drivers/mtd/nand/omap2.c
> > > index 5596368..f464321 100644
> > > --- a/drivers/mtd/nand/omap2.c
> > > +++ b/drivers/mtd/nand/omap2.c
> > > @@ -1856,7 +1856,6 @@ static int omap_nand_probe(struct platform_=
device *pdev)
> > >  	mtd->name		=3D dev_name(&pdev->dev);
> > >  	mtd->owner		=3D THIS_MODULE;
> > >  	nand_chip		=3D &info->nand;
> > > -	nand_chip->options	=3D pdata->devsize;
> > >  	nand_chip->options	|=3D NAND_SKIP_BBTSCAN;
> > >  #ifdef CONFIG_MTD_NAND_OMAP_BCH
> > >  	info->of_node		=3D pdata->of_node;
> > > @@ -1904,6 +1903,15 @@ static int omap_nand_probe(struct platform=
_device *pdev)
> > >  		nand_chip->chip_delay =3D 50;
> > >  	}
> > > =20
> > > +	/* scan NAND device connected to chip controller */
> > > +	nand_chip->options |=3D pdata->devsize & NAND_BUSWIDTH_16;
> >=20
> > Hm.. this only works if the device is listed in nand_flash_ids[] ar=
ray,
> > so that ONFI detection is not used.
>=20
> But this is no more broken than it used to be, no? I mean, you would
> never properly detect an x16 ONFI flash with the old
> double-nand_scan_ident() method, right?
>=20

That's right. But the issue is not really fixed either.

> > To make ONFI detection work I think you
> > need to do as Brian suggested and use NAND_BUSWIDTH_AUTO.
>=20
> I think that is the correct way forward. But Pekon seems to think tha=
t
> will require more invasive changes to the GPMC code. But I'm not sure
> why.
>=20

Hm... not sure. AFAIK, the GPMC should be *already* configured prior to=
 the
NAND driver being probed.

> > (Odd: why is there no current user of that auto-width option?)
>=20
> Hmm, I could have sworn somebody was using that... I know there was s=
ome
> pending work on using it for GPIO NAND, but Alexander Shiyan never
> followed up on the latest comments. It also seems like the original
> author (Matthieu Castet) was working on OMAP support about a year ago=
,
> but things stalled when there wasn't proper mainline support for much=
 of
> it:
>=20
>   http://thread.gmane.org/gmane.linux.ports.arm.omap/88550/focus=3D44=
770
>=20
> Personally, I've only ever used x8 NAND, so I don't have much to go o=
n
> here.
>=20
> > Anyway, I really think we should fix this now and independently
> > of the evolution of this ECC DT binding discussion.
> > That way you can keep sending a smaller ECC DT binding patchset and
> > make reviewers focus on what's really important in each case.
>=20
> AFAIK, the ECC DT bindings were all approved, and the code looked OK =
to
> my knowledge, except for this single patch. I had recommended either =
its
> total removal or its simplification (i.e., this current patch).
>=20

=46WIW, I'm in favor of *completely* dropping whatever doesn't belong
to the ECC DT binding.

> I will be taking a last look and queueing this series up soon, I
> believe.
>=20
> > I have a few fixes (based on your work) and I'll send them now, aft=
er
> > I complete the tests. We can continue our discussion there.
>=20
> I'll take a look at those soon.
>=20

Ok, cool.

> So am I to understand you have hardware for testing Pekon's work now,
> Ezequiel? That will be great if we can have better Reviewed-by/Tested=
-by
> results.
>=20

Yup, I gave it quick test actually, but nothing deep. Let me test some
more maybe later today/tomorrow. I just wanted to sort this out first.
--=20
Ezequiel Garc=C3=ADa, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
