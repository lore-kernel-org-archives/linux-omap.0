From: Brian Norris <computersforpeace@gmail.com>
Subject: Re: [PATCH v11 04/10] mtd: nand: omap: use DT specified bus-width
 only for scanning NAND device
Date: Thu, 24 Oct 2013 15:43:00 -0700
Message-ID: <20131024224300.GG20061@ld-irv-0074.broadcom.com>
References: <1382619026-4182-1-git-send-email-pekon@ti.com>
 <1382619026-4182-5-git-send-email-pekon@ti.com>
 <20131024212714.GB2520@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-oa0-f46.google.com ([209.85.219.46]:58881 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753236Ab3JXWnH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 24 Oct 2013 18:43:07 -0400
Content-Disposition: inline
In-Reply-To: <20131024212714.GB2520@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Cc: Pekon Gupta <pekon@ti.com>, mark.rutland@arm.com, olof@lixom.net, dedekind1@gmail.com, devicetree@vger.kernel.org, Pawel.Moll@arm.com, arnd@arndb.de, swarren@wwwdotorg.org, tony@atomide.com, jp.francois@cynove.com, ijc+devicetree@hellion.org.uk, avinashphilipk@gmail.com, balbi@ti.com, robherring2@gmail.com, bcousson@baylibre.com, linux-mtd@lists.infradead.org, ivan.djelic@parrot.com, linux-omap@vger.kernel.org, dwmw2@infradead.org, Alexander Shiyan <shc_work@mail.ru>, Matthieu Castet <matthieu.castet@parrot.com>, Jon Hunter <jon-hunter@ti.com>

On Thu, Oct 24, 2013 at 06:27:15PM -0300, Ezequiel Garcia wrote:
> On Thu, Oct 24, 2013 at 06:20:20PM +0530, Pekon Gupta wrote:
> > This patch:
> > - calls nand_scan_ident() using bus-width as passed by DT
> > - removes double calls to nand_scan_ident(), incase first call fails
> >   then omap_nand_probe just returns error.
> > 
> > Signed-off-by: Pekon Gupta <pekon@ti.com>
> > ---
> >  drivers/mtd/nand/omap2.c | 21 +++++++++------------
> >  1 file changed, 9 insertions(+), 12 deletions(-)
> > 
> > diff --git a/drivers/mtd/nand/omap2.c b/drivers/mtd/nand/omap2.c
> > index 5596368..f464321 100644
> > --- a/drivers/mtd/nand/omap2.c
> > +++ b/drivers/mtd/nand/omap2.c
> > @@ -1856,7 +1856,6 @@ static int omap_nand_probe(struct platform_device *pdev)
> >  	mtd->name		= dev_name(&pdev->dev);
> >  	mtd->owner		= THIS_MODULE;
> >  	nand_chip		= &info->nand;
> > -	nand_chip->options	= pdata->devsize;
> >  	nand_chip->options	|= NAND_SKIP_BBTSCAN;
> >  #ifdef CONFIG_MTD_NAND_OMAP_BCH
> >  	info->of_node		= pdata->of_node;
> > @@ -1904,6 +1903,15 @@ static int omap_nand_probe(struct platform_device *pdev)
> >  		nand_chip->chip_delay = 50;
> >  	}
> >  
> > +	/* scan NAND device connected to chip controller */
> > +	nand_chip->options |= pdata->devsize & NAND_BUSWIDTH_16;
> 
> Hm.. this only works if the device is listed in nand_flash_ids[] array,
> so that ONFI detection is not used.

But this is no more broken than it used to be, no? I mean, you would
never properly detect an x16 ONFI flash with the old
double-nand_scan_ident() method, right?

> To make ONFI detection work I think you
> need to do as Brian suggested and use NAND_BUSWIDTH_AUTO.

I think that is the correct way forward. But Pekon seems to think that
will require more invasive changes to the GPMC code. But I'm not sure
why.

> (Odd: why is there no current user of that auto-width option?)

Hmm, I could have sworn somebody was using that... I know there was some
pending work on using it for GPIO NAND, but Alexander Shiyan never
followed up on the latest comments. It also seems like the original
author (Matthieu Castet) was working on OMAP support about a year ago,
but things stalled when there wasn't proper mainline support for much of
it:

  http://thread.gmane.org/gmane.linux.ports.arm.omap/88550/focus=44770

Personally, I've only ever used x8 NAND, so I don't have much to go on
here.

> Anyway, I really think we should fix this now and independently
> of the evolution of this ECC DT binding discussion.
> That way you can keep sending a smaller ECC DT binding patchset and
> make reviewers focus on what's really important in each case.

AFAIK, the ECC DT bindings were all approved, and the code looked OK to
my knowledge, except for this single patch. I had recommended either its
total removal or its simplification (i.e., this current patch).

I will be taking a last look and queueing this series up soon, I
believe.

> I have a few fixes (based on your work) and I'll send them now, after
> I complete the tests. We can continue our discussion there.

I'll take a look at those soon.

So am I to understand you have hardware for testing Pekon's work now,
Ezequiel? That will be great if we can have better Reviewed-by/Tested-by
results.

Brian
