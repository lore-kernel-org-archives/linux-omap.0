From: "Philip, Avinash" <avinashphilip@ti.com>
Subject: RE: [PATCH v3 4/4] ARM: OMAP: gpmc: add DT bindings for GPMC
 timings and NAND
Date: Thu, 6 Dec 2012 13:12:06 +0000
Message-ID: <518397C60809E147AF5323E0420B992E3EA1281E@DBDE01.ent.ti.com>
References: <509A2E75.5060307@gmail.com>
 <518397C60809E147AF5323E0420B992E3E9DE420@DBDE01.ent.ti.com>
 <509EA360.2050504@gmail.com> <87mwycjmdn.fsf@dell.be.48ers.dk>
 <50ACA9BB.7090106@gmail.com>
 <518397C60809E147AF5323E0420B992E3E9EEA09@DBDE01.ent.ti.com>
 <50B4C796.4010403@gmail.com>
 <518397C60809E147AF5323E0420B992E3E9F25CB@DBDE01.ent.ti.com>
 <20121201215014.GA11236@parrot.com>
 <518397C60809E147AF5323E0420B992E3EA1100E@DBDE01.ent.ti.com>
 <20121206101541.GA4089@parrot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:37586 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752917Ab2LFNNi convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 6 Dec 2012 08:13:38 -0500
In-Reply-To: <20121206101541.GA4089@parrot.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ivan Djelic <ivan.djelic@parrot.com>
Cc: Daniel Mack <zonque@gmail.com>, Peter Korsgaard <jacmet@sunsite.dk>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "paul@pwsan.com" <paul@pwsan.com>, "Mohammed, Afzal" <afzal@ti.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "Nori, Sekhar" <nsekhar@ti.com>, "tony@atomide.com" <tony@atomide.com>, "Hunter, Jon" <jon-hunter@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Thu, Dec 06, 2012 at 15:45:41, Ivan Djelic wrote:
> On Wed, Dec 05, 2012 at 05:15:52AM +0000, Philip, Avinash wrote:
> (...)
> > > First a short reminder of pros and cons of the "constant polynomial addition"
> > > (let's just call it "CPA") feature:
> > > 
> > > pros:
> > > - it elegantly solves all problems related to reading an erased page (no clumsy hack needed)
> > > - better performance: when a bitflip appears on an erased page (often this is a "sticky" bitflip),
> > >   there is no need to perform a full scan+cleanup of the page each time it is read
> > 
> > No need for scan + cleanup on each read, as the chances of encountering bit flips in erased page
> > is less. Also to find bit flips in erased page, compare ecc vector for read erased page against
> > a standard ecc vector. Presence of bit flips can find by checking the compare results. In case of
> > mismatch, should go for correction of bit flips in erased page with full scan.
> 
> Hi Avinash,
> 
> I explicitly mentioned the condition "when a bitflip appears on an erased page", in which case you
> _do_ have to do a full scan upon each read, until you erase the block; and then, the bitflip may still
> be there (this is what I called a "sticky" bitflip).

Bit flips in erased page require full scan.

> My experience with recent devices (4-bit/8-bit) is that erased pages with a 
> single bitflip are not uncommon.

What about erased page without bit flips? If we take the probability of bit flips 
and non-bit flips in erased page, erased pages with bit flips will be very less.

So probability of scanning erased page is less.

> For those pages, there is undeniably a performance penalty compared to CPA.

Pages with bit flips would have better performance with CPA as no explicit scan present.
Pages without bit flips, would have better performance if we compare against standard ecc
vector than with present implementation of software BCH.

The same can be achieved with software BCH also.


> Benchmarks would be needed to quantify the overall performance impact, but I suspect it is small.

So overall performance would be better with checking with standard ecc vector for finding erased page
and handling bit flip in erased page with full scan due to probability that bit flips in erased page 
is very less than pages without bit flips.
But with performance improvement for bit flipped erased page with CPA, we have to sacrifice RBL compatibility.
So a common layout across all components would be missing.

> 
> > 
> > So with this approach, we can nullify the effect of CPA for erased page bit flip handling.
> 
> Well, not completely. I would happily drop CPA is that were the case.

So the choices can be 

1. Performance drop in case of bit flip in erased page with full scan of page if bit flip in
   erased page. But can achieve RBL compatibility, simplification of ecc calculation.
2. Sacrifice RBL compatibility with CPA, but still performance can be improved for 
   erased pages without bit flips.

But initial discussion in this direction told RBL compatibility would be a better option
https://lkml.org/lkml/2012/10/11/240


>  
> > > 
> > > cons:
> > > - the ecc vector is not compatible with RBL
> > > 
> > > RBL compatibility is not necessary in my case, because I'm using the OMAP MLC ROM boot mode.
> > > Rather than completely removing the CPA feature, I'd like to keep it as an option; it could
> > > even be used with the ELM module.
> > 
> > I agree RBL compatibility depends on the user. But with RBL compatibility, there is no sacrifice
> > of any existing feature. Is it right?
> > 
> > Also nand driver get simplified with removal of CPA, so that both HW & SW error correction
> > can go for same ecc calculation.
> 
> Indeed that would be a simplification.
> 
> > > 
> > > I'm OK to submit a patch in this direction, but first I'd like to wait for the dust to settle
> > > on arch/arm/mach-omap2 and mtd/nand/omap2.c with Afzal patches and everything; things have become
> > > a bit complicated to follow recently :-)
> > 
> > Afzal's changes are in & are settled now.
> 
> What about this set: http://lists.infradead.org/pipermail/linux-mtd/2012-October/044337.html
> I cannot see it in l2-mtd-2.6 ? Or did I miss something ?

Yes, Afzal's changes are present in linux-next. I think it will get in next merge window.

http://git.kernel.org/?p=linux/kernel/git/next/linux-next.git;a=history;f=drivers/mtd/nand/omap2.c;h=0002d5e94f0d0e3b84f36d2ccb505c95a30b4cdb;hb=cfc4410f5d3de0f68139ddffe065b9889a41d3c0

These changes not present in l2-mtd-2.6

Thanks
Avinash

> 
> Thanks,
> --
> Ivan
> 

