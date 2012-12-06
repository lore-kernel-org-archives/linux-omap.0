From: Ivan Djelic <ivan.djelic@parrot.com>
Subject: Re: [PATCH v3 4/4] ARM: OMAP: gpmc: add DT bindings for GPMC timings
 and NAND
Date: Thu, 6 Dec 2012 11:15:41 +0100
Message-ID: <20121206101541.GA4089@parrot.com>
References: <509A2E75.5060307@gmail.com>
 <518397C60809E147AF5323E0420B992E3E9DE420@DBDE01.ent.ti.com>
 <509EA360.2050504@gmail.com>
 <87mwycjmdn.fsf@dell.be.48ers.dk>
 <50ACA9BB.7090106@gmail.com>
 <518397C60809E147AF5323E0420B992E3E9EEA09@DBDE01.ent.ti.com>
 <50B4C796.4010403@gmail.com>
 <518397C60809E147AF5323E0420B992E3E9F25CB@DBDE01.ent.ti.com>
 <20121201215014.GA11236@parrot.com>
 <518397C60809E147AF5323E0420B992E3EA1100E@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from co202.xi-lite.net ([149.6.83.202]:52249 "EHLO co202.xi-lite.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1423015Ab2LFKPp (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 6 Dec 2012 05:15:45 -0500
Content-Disposition: inline
In-Reply-To: <518397C60809E147AF5323E0420B992E3EA1100E@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Philip, Avinash" <avinashphilip@ti.com>
Cc: Daniel Mack <zonque@gmail.com>, Peter Korsgaard <jacmet@sunsite.dk>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "paul@pwsan.com" <paul@pwsan.com>, "Mohammed, Afzal" <afzal@ti.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "Nori, Sekhar" <nsekhar@ti.com>, "tony@atomide.com" <tony@atomide.com>, "Hunter, Jon" <jon-hunter@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Wed, Dec 05, 2012 at 05:15:52AM +0000, Philip, Avinash wrote:
(...)
> > First a short reminder of pros and cons of the "constant polynomial addition"
> > (let's just call it "CPA") feature:
> > 
> > pros:
> > - it elegantly solves all problems related to reading an erased page (no clumsy hack needed)
> > - better performance: when a bitflip appears on an erased page (often this is a "sticky" bitflip),
> >   there is no need to perform a full scan+cleanup of the page each time it is read
> 
> No need for scan + cleanup on each read, as the chances of encountering bit flips in erased page
> is less. Also to find bit flips in erased page, compare ecc vector for read erased page against
> a standard ecc vector. Presence of bit flips can find by checking the compare results. In case of
> mismatch, should go for correction of bit flips in erased page with full scan.

Hi Avinash,

I explicitly mentioned the condition "when a bitflip appears on an erased page", in which case you
_do_ have to do a full scan upon each read, until you erase the block; and then, the bitflip may still be there
(this is what I called a "sticky" bitflip).
My experience with recent devices (4-bit/8-bit) is that erased pages with a single bitflip are not uncommon.
For those pages, there is undeniably a performance penalty compared to CPA.
Benchmarks would be needed to quantify the overall performance impact, but I suspect it is small.

> 
> So with this approach, we can nullify the effect of CPA for erased page bit flip handling.

Well, not completely. I would happily drop CPA is that were the case.
 
> > 
> > cons:
> > - the ecc vector is not compatible with RBL
> > 
> > RBL compatibility is not necessary in my case, because I'm using the OMAP MLC ROM boot mode.
> > Rather than completely removing the CPA feature, I'd like to keep it as an option; it could
> > even be used with the ELM module.
> 
> I agree RBL compatibility depends on the user. But with RBL compatibility, there is no sacrifice
> of any existing feature. Is it right?
> 
> Also nand driver get simplified with removal of CPA, so that both HW & SW error correction
> can go for same ecc calculation.

Indeed that would be a simplification.

> > 
> > I'm OK to submit a patch in this direction, but first I'd like to wait for the dust to settle
> > on arch/arm/mach-omap2 and mtd/nand/omap2.c with Afzal patches and everything; things have become
> > a bit complicated to follow recently :-)
> 
> Afzal's changes are in & are settled now.

What about this set: http://lists.infradead.org/pipermail/linux-mtd/2012-October/044337.html
I cannot see it in l2-mtd-2.6 ? Or did I miss something ?

Thanks,
--
Ivan
