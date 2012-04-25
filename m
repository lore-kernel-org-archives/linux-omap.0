From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP3: gpmc: add BCH ecc api and modes
Date: Wed, 25 Apr 2012 08:58:01 -0700
Message-ID: <20120425155759.GS3739@atomide.com>
References: <1334652536-4442-1-git-send-email-ivan.djelic@parrot.com>
 <1335365341.6356.5.camel@koala>
 <20120425152310.GR3739@atomide.com>
 <1335368681.6356.16.camel@koala>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:23243 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755117Ab2DYP6G (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 25 Apr 2012 11:58:06 -0400
Content-Disposition: inline
In-Reply-To: <1335368681.6356.16.camel@koala>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Artem Bityutskiy <dedekind1@gmail.com>
Cc: linux-omap@vger.kernel.org, linux-mtd@lists.infradead.org, Ivan Djelic <ivan.djelic@parrot.com>

* Artem Bityutskiy <dedekind1@gmail.com> [120425 08:48]:
> On Wed, 2012-04-25 at 08:23 -0700, Tony Lindgren wrote:
> > Hi,
> > 
> > * Artem Bityutskiy <dedekind1@gmail.com> [120425 07:52]:
> > > On Tue, 2012-04-17 at 10:48 +0200, Ivan Djelic wrote:
> > > > This patch adds a simple BCH ecc computation api, similar to the
> > > > existing Hamming ecc api. It is intended to be used by the MTD layer.
> > > > It implements the following features:
> > > > 
> > > > - support 4-bit and 8-bit ecc computation
> > > > - do not protect user bytes in spare area, only data area is protected
> > > > - ecc for an erased NAND page (0xFFs) is also a sequence of 0xFFs
> > > > 
> > > > This last feature is obtained by adding a constant polynomial to
> > > > the hardware computed ecc. It allows to correct bitflips in blank pages
> > > > and is extremely useful to support filesystems such as UBIFS, which expect
> > > > erased pages to contain only 0xFFs.
> > > > 
> > > > This api has been tested on an OMAP3630 board.
> > > > 
> > > > Signed-off-by: Ivan Djelic <ivan.djelic@parrot.com>
> > > 
> > > Hi Tony,
> > > 
> > > what do you think about merging this patch? This is the enabler for
> > > making UBIFS actually usable on OMAP platforms which use BCH ECC. There
> > > are 2 other MTD patches which depend on this - so I wonder if it is
> > > easier to merge this one via the MTD tree, providing it has your/others'
> > > ack(s).
> > 
> > Looks OK to me, however there are other pending GPMC patches to convert
> > it to a platform device device driver. Need to look those closer though.
> > Anyways, it's best that I queue them to avoid merge conflicts.
> 
> Sure.
> 
> > Do you these for other changes for UBIFS?
> 
> Not in UBIFS, but in drivers/mtd/nand/omap2.c - Ivan sent another patch
> which adds BCH support to to omap2.c, was sent to linux-omap, subject
> "[PATCH] mtd: nand: omap: add support for hardware BCH ecc"
> 
> >  If so, I can set up an immutable
> > branch for GPMC that you can merge in as well.
> 
> I guess this would be a good idea, but probably it is better to do this
> when you believe you merged most gpmc patches, so probably closer to the
> final -rc?

Yes let's wait a week or so as there are also the dmaengine patch for
drivers/mtd/nand/omap2.c that might conflict. So let's get the dmaengine
patches to some branch first.

Regards,

Tony
