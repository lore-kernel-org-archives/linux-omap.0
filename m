From: Ivan Djelic <ivan.djelic@parrot.com>
Subject: Re: [PATCH v3] ARM: OMAP3: gpmc: add BCH ecc api and modes
Date: Wed, 9 May 2012 10:07:47 +0200
Message-ID: <20120509080747.GB17333@parrot.com>
References: <1335442669-13474-1-git-send-email-ivan.djelic@parrot.com>
 <20120509002927.GF5088@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from co202.xi-lite.net ([149.6.83.202]:33885 "EHLO co202.xi-lite.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756858Ab2EIIId (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 9 May 2012 04:08:33 -0400
Content-Disposition: inline
In-Reply-To: <20120509002927.GF5088@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, afzal@ti.com

On Wed, May 09, 2012 at 01:29:28AM +0100, Tony Lindgren wrote:
> * Ivan Djelic <ivan.djelic@parrot.com> [120426 05:23]:
> > Hello,
> > 
> > Here is version 3 of this patch after review from Tony Lindgren.
> > This version adds a separate initialization function mostly to check CPU
> > compatibility. This check cannot be done in gpmc_enable_hwecc_bch() (which
> > is meant to be called from mtd function ecc.hwctl) because ecc.hwctl is
> > not called before the first NAND read access, and it cannot return an error
> > status.
> 
> Thanks applying into devel-gpmc branch.

OK thanks!

I still have a question though: there are recent patches from
Afzal Mohammed that seem to go into the opposite direction, that is 
giving back GPMC register access to the omap2 NAND driver.
In particular, [PATCH v4 17/39] [1] commit message says:

  GPMC driver has been modified to fill NAND platform data with GPMC
  NAND register details. As these registers are accessible in NAND
  driver itself, configure NAND in GPMC by itself.

This also includes ecc configuration. My original mtd driver patch indeed had
ecc handling code inside the driver (not in arch/arm/mach-omap2/gpmc.c).

So, my question is: which direction are we going to with respect to this
OMAP GPMC/NAND code separation ?

Note that I could prepare a new MTD patch with BCH ecc code included,
allowing to drop the GPMC BCH ecc api.

BR,
--
Ivan

[1] http://lists.infradead.org/pipermail/linux-mtd/2012-May/041105.html
