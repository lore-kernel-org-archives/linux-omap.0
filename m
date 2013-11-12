From: Brian Norris <computersforpeace@gmail.com>
Subject: Re: [PATCH v2 3/5] mtd: nand: omap2: Fix OMAP_BCH option dependency
Date: Tue, 12 Nov 2013 14:56:47 -0800
Message-ID: <20131112225647.GM20061@ld-irv-0074.broadcom.com>
References: <1382696277-9063-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1382696277-9063-4-git-send-email-ezequiel.garcia@free-electrons.com>
 <20980858CB6D3A4BAE95CA194937D5E73EA2AE93@DBDE04.ent.ti.com>
 <20131112204555.GA20260@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ie0-f175.google.com ([209.85.223.175]:52809 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753864Ab3KLW4v (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 12 Nov 2013 17:56:51 -0500
Received: by mail-ie0-f175.google.com with SMTP id u16so7262444iet.6
        for <linux-omap@vger.kernel.org>; Tue, 12 Nov 2013 14:56:51 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20131112204555.GA20260@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Cc: "Balbi, Felipe" <balbi@ti.com>, "marek.belisko@gmail.com" <marek.belisko@gmail.com>, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Pekon Gupta <pekon@ti.com>

On Tue, Nov 12, 2013 at 05:45:56PM -0300, Ezequiel Garcia wrote:
> On Fri, Oct 25, 2013 at 11:26:06AM +0000, Gupta, Pekon wrote:
> > > From: Ezequiel Garcia [mailto:ezequiel.garcia@free-electrons.com]
> > > Subject: [PATCH v2 3/5] mtd: nand: omap2: Fix OMAP_BCH option
> > > dependency
> > > 
> > > This option does not need to depend in MTD_NAND, for it's enclosed
> > > under it. Also, it's wrong to make it depend in ARCH_OMAP3 only
> > > since the controller is used in a wider range of SoCs.
> > > 
> > > Instead, just leave the dependency on the OMAP2 driver option.
> > > 
> > > Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> > > ---
> > >  drivers/mtd/nand/Kconfig | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/mtd/nand/Kconfig b/drivers/mtd/nand/Kconfig
> > > index d885298..8187466 100644
> > > --- a/drivers/mtd/nand/Kconfig
> > > +++ b/drivers/mtd/nand/Kconfig
> > > @@ -95,7 +95,7 @@ config MTD_NAND_OMAP2
> > >  	  platforms.
> > > 
> > >  config MTD_NAND_OMAP_BCH
> > > -	depends on MTD_NAND && MTD_NAND_OMAP2 && ARCH_OMAP3
> > > +	depends on MTD_NAND_OMAP2
> > >  	tristate "Enable support for hardware BCH error correction"
> > >  	default n
> > >  	select BCH
> > > --
> > > 1.8.1.5
> > 
> > Acked-by: Pekon Gupta <pekon@ti.com>
> 
> Brian,
> 
> I almost forgot about this one, and I just came across the issue
> while configuring my board.
> 
> I believe this one is simple enough to be pulled in for v3.14
> (it could be in v3.13, but it's already too late).
> 
> Or maybe you're not taking stuff for v3.14 yet...

Thanks for the reminder. The rest of the series has been discussed
separately or is otherwise superceded by other patch series, right?

Applied this one patch to l2-mtd.git, branch 'next'. Thanks.

Brian
