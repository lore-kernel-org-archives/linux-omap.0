From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v3] ARM: OMAP3: gpmc: add BCH ecc api and modes
Date: Wed, 9 May 2012 08:31:42 -0700
Message-ID: <20120509153141.GI5088@atomide.com>
References: <1335442669-13474-1-git-send-email-ivan.djelic@parrot.com>
 <20120509002927.GF5088@atomide.com>
 <20120509081047.GC17333@parrot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:61934 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755219Ab2EIPbp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 May 2012 11:31:45 -0400
Content-Disposition: inline
In-Reply-To: <20120509081047.GC17333@parrot.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ivan Djelic <ivan.djelic@parrot.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, afzal@ti.com

* Ivan Djelic <ivan.djelic@parrot.com> [120509 01:15]:
> On Wed, May 09, 2012 at 01:29:28AM +0100, Tony Lindgren wrote:
> > * Ivan Djelic <ivan.djelic@parrot.com> [120426 05:23]:
> > > Hello,
> > > 
> > > Here is version 3 of this patch after review from Tony Lindgren.
> > > This version adds a separate initialization function mostly to check CPU
> > > compatibility. This check cannot be done in gpmc_enable_hwecc_bch() (which
> > > is meant to be called from mtd function ecc.hwctl) because ecc.hwctl is
> > > not called before the first NAND read access, and it cannot return an error
> > > status.
> > 
> > Thanks applying into devel-gpmc branch.
> 
> OK thanks!
> 
> I still have a question though: there are recent patches from
> Afzal Mohammed that seem to go into the opposite direction, that is
> giving back GPMC register access to the omap2 NAND driver.
> In particular, [PATCH v4 17/39] [1] commit message says:
> 
>   GPMC driver has been modified to fill NAND platform data with GPMC
>   NAND register details. As these registers are accessible in NAND
>   driver itself, configure NAND in GPMC by itself.
> 
> This also includes ecc configuration. My original mtd driver patch indeed had
> ecc handling code inside the driver (not in arch/arm/mach-omap2/gpmc.c).
> 
> So, my question is: which direction are we going to with respect to this
> OMAP GPMC/NAND code separation ?

What Afzal is doing is where we're heading. However, I'm afraid that
may not be quite ready for v3.5 merge window as it needs proper testing
on quite a few platforms to avoid issues with various devices connected
to GPMC.
 
> Note that I could prepare a new MTD patch with BCH ecc code included,
> allowing to drop the GPMC BCH ecc api.

OK, let's do that then. I'll drop this patch and you can coordinate
your patch with Afzal.

Regards,

Tony

 
> [1] http://lists.infradead.org/pipermail/linux-mtd/2012-May/041105.html
