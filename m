From: Tony Lindgren <tony@atomide.com>
Subject: Re: [CFT 09/11] mtd: omap2: add DMA engine support
Date: Thu, 7 Jun 2012 10:10:16 -0700
Message-ID: <20120607171015.GK12766@atomide.com>
References: <20120607110610.GB15973@n2100.arm.linux.org.uk>
 <E1Scaaa-0003uB-1l@rmk-PC.arm.linux.org.uk>
 <1339073375.6875.102.camel@sauron.fi.intel.com>
 <20120607131158.GC15973@n2100.arm.linux.org.uk>
 <1339075683.6875.109.camel@sauron.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:21143 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754204Ab2FGRKW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 7 Jun 2012 13:10:22 -0400
Content-Disposition: inline
In-Reply-To: <1339075683.6875.109.camel@sauron.fi.intel.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Artem Bityutskiy <dedekind1@gmail.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-mtd@lists.infradead.org, David Woodhouse <dwmw2@infradead.org>

* Artem Bityutskiy <dedekind1@gmail.com> [120607 06:28]:
> On Thu, 2012-06-07 at 14:11 +0100, Russell King - ARM Linux wrote:
> > No, it makes sense to get this stuff via a single tree all together,
> > because, as you can see from the thread structure, it isn't purely
> > an OMAP thing.
> > 
> > The OMAP stuff depends on a core set, as does a bunch of PL08x and
> > SA11x0 changes.  We can't stuff all that through the OMAP tree, that
> > wouldn't make any sense.
> > 
> > What probably should happen is that the tip of the OMAP stuff gets
> > pulled by Tony into his tree, and we share those commits between my
> > tree and his - and then it doesn't matter what goes in when and by
> > whom.
> 
> Oh, sure, sorry, I actually wanted to say that these to patches should
> _not_ got via the MTD tree.

What Russell is suggesting works good for me.

Regards,

Tony
