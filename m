From: "Gupta, Pekon" <pekon@ti.com>
Subject: RE: [PATCH v9 3/9] mtd: nand: omap: cleanup: replace local
 references with generic framework names
Date: Sat, 19 Oct 2013 05:10:51 +0000
Message-ID: <20980858CB6D3A4BAE95CA194937D5E73EA28C91@DBDE04.ent.ti.com>
References: <1381816197-20477-1-git-send-email-pekon@ti.com>
 <1381816197-20477-4-git-send-email-pekon@ti.com>
 <20131016213024.GY23337@ld-irv-0074.broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:46414 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750934Ab3JSFMB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 19 Oct 2013 01:12:01 -0400
In-Reply-To: <20131016213024.GY23337@ld-irv-0074.broadcom.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Brian Norris <computersforpeace@gmail.com>
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>, "olof@lixom.net" <olof@lixom.net>, "dedekind1@gmail.com" <dedekind1@gmail.com>, "tony@atomide.com" <tony@atomide.com>, "bcousson@baylibre.com" <bcousson@baylibre.com>, "robherring2@gmail.com" <robherring2@gmail.com>, "Pawel.Moll@arm.com" <Pawel.Moll@arm.com>, "ijc+devicetree@hellion.org.uk" <ijc+devicetree@hellion.org.uk>, "swarren@wwwdotorg.org" <swarren@wwwdotorg.org>, "dwmw2@infradead.org" <dwmw2@infradead.org>, "arnd@arndb.de" <arnd@arndb.de>, "avinashphilipk@gmail.com" <avinashphilipk@gmail.com>, "Balbi, Felipe" <balbi@ti.com>, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

> From: Brian Norris [mailto:computersforpeace@gmail.com]
> > On Tue, Oct 15, 2013 at 11:19:51AM +0530, Pekon Gupta wrote:
> > This patch updates following in omap_nand_probe() and
> omap_nand_remove()
> > - replaces "info->nand" with "nand_chip" (struct nand_chip *nand_chip)
> > - replaces "info->mtd" with "mtd" (struct mtd_info *mtd)
> > - white-space and formatting cleanup
> >
> > Signed-off-by: Pekon Gupta <pekon@ti.com>
> 
> This patch looks good. Thanks for being consistent.
> 

> > diff --git a/drivers/mtd/nand/omap2.c b/drivers/mtd/nand/omap2.c
> > index 8d521aa..5596368 100644
> > --- a/drivers/mtd/nand/omap2.c
> > +++ b/drivers/mtd/nand/omap2.c
> 
> ...
> 
> > @@ -1846,17 +1848,16 @@ static int omap_nand_probe(struct
> > -
> > -	info->nand.options	= pdata->devsize;
> > -	info->nand.options	|= NAND_SKIP_BBTSCAN;
> > +	mtd			= &info->mtd;
> > +	mtd->priv		= &info->nand;
> > +	mtd->name		= dev_name(&pdev->dev);
> > +	mtd->owner		= THIS_MODULE;
> > +	nand_chip		= &info->nand;
> > +	nand_chip->options	= pdata->devsize;
> 
> Trivial side comment: the 'devsize' field is not named very
> informatively. It is apparently just a way to specify nand_chip.options,
> and it is only actually used for setting a buswidth. (It is also badly
> named nand_type in other places.) Not sure if it's worth improving, or
> even dropping at some later point in time.
> 
For now I'm keeping this name consistent for now, as this would require
touching GPMC driver also, where 'devsize' is used to configure
GPMC controller registers.

I'll keep this feedback as pending for independent patch where I probe
driver with "NAND_BUSWIDTH_AUTO".


with regards, pekon
