From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [CFT 09/11] mtd: omap2: add DMA engine support
Date: Thu, 7 Jun 2012 14:11:58 +0100
Message-ID: <20120607131158.GC15973@n2100.arm.linux.org.uk>
References: <20120607110610.GB15973@n2100.arm.linux.org.uk> <E1Scaaa-0003uB-1l@rmk-PC.arm.linux.org.uk> <1339073375.6875.102.camel@sauron.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:54423 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755957Ab2FGNMN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 7 Jun 2012 09:12:13 -0400
Content-Disposition: inline
In-Reply-To: <1339073375.6875.102.camel@sauron.fi.intel.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Artem Bityutskiy <dedekind1@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-mtd@lists.infradead.org, David Woodhouse <dwmw2@infradead.org>

On Thu, Jun 07, 2012 at 03:49:35PM +0300, Artem Bityutskiy wrote:
> On Thu, 2012-06-07 at 12:09 +0100, Russell King wrote:
> > Add DMA engine support to the OMAP2 NAND driver.  This supplements the
> > private DMA API implementation contained within this driver, and the
> > driver can be independently switched at build time between using DMA
> > engine and the private DMA API.
> > 
> > Tested-by: Grazvydas Ignotas <notasas@gmail.com>
> > Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> 
> I guess it is makes sense to make this stuff to go in via the OMAP tree.

No, it makes sense to get this stuff via a single tree all together,
because, as you can see from the thread structure, it isn't purely
an OMAP thing.

The OMAP stuff depends on a core set, as does a bunch of PL08x and
SA11x0 changes.  We can't stuff all that through the OMAP tree, that
wouldn't make any sense.

What probably should happen is that the tip of the OMAP stuff gets
pulled by Tony into his tree, and we share those commits between my
tree and his - and then it doesn't matter what goes in when and by
whom.
