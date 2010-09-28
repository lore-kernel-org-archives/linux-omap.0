From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL] omap2 sparse fixes
Date: Tue, 28 Sep 2010 11:31:59 -0700
Message-ID: <20100928183157.GH3117@atomide.com>
References: <E0D41E29EB0DAC4E9F3FF173962E9E9402785A390E@dbde02.ent.ti.com>
 <20100923225851.GR4211@atomide.com>
 <E0D41E29EB0DAC4E9F3FF173962E9E9402DB3F859E@dbde02.ent.ti.com>
 <20100925001914.GO4211@atomide.com>
 <E0D41E29EB0DAC4E9F3FF173962E9E9402DB3F917C@dbde02.ent.ti.com>
 <20100928152139.GB3117@atomide.com>
 <E0D41E29EB0DAC4E9F3FF173962E9E9402DB3F94C9@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:64917 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755385Ab0I1ScJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 28 Sep 2010 14:32:09 -0400
Content-Disposition: inline
In-Reply-To: <E0D41E29EB0DAC4E9F3FF173962E9E9402DB3F94C9@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "G, Manjunath Kondaiah" <manjugk@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Samuel Ortiz <sameo@linux.intel.com>, Dmitry Torokhov <dtor@mail.ru>, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>

* G, Manjunath Kondaiah <manjugk@ti.com> [100928 08:26]:
> 
> 
> > -----Original Message-----
> > From: Tony Lindgren [mailto:tony@atomide.com] 
> > Sent: Tuesday, September 28, 2010 8:52 PM
> > To: G, Manjunath Kondaiah
> > Cc: linux-omap@vger.kernel.org; 
> > linux-arm-kernel@lists.infradead.org; Samuel Ortiz; Dmitry 
> > Torokhov; linux-mtd@lists.infradead.org; Russell King - ARM Linux
> > Subject: Re: [GIT PULL] omap2 sparse fixes
> > 
> > * G, Manjunath Kondaiah <manjugk@ti.com> [100928 01:04]:
> > > 
> > > Three patches are fixed using above method which are:
> > > OMAP: mach-omap2: Fix static function warnings
> > > OMAP: plat-omap: Fix static function warnings TWL IRQ: Fix fucntion 
> > > declaration warnings
> > 
> > OK thanks.
> >  
> > > are available in the git repository at:
> > > 
> > >   git://dev.omapzoom.org/pub/scm/manju/kernel-omap3-dev.git 
> > > sparse_fixes_v3
> > > 
> > > G, Manjunath Kondaiah (10):
> > >       OMAP: mach-omap2: Fix incorrect assignment warnings
> > >       OMAP: mach-omap2: Fix static declaration warnings
> > >       OMAP2plus: Fix static function warnings
> > >       OMAP: mach-omap2: Fix miscellaneous sparse warnings
> > >       OMAP: plat-omap: Fix static function warnings
> > >       OMAP: NAND: Fix static declaration warning
> > >       TWL CORE: Fix sparse warning
> > >       TWL IRQ: Fix fucntion declaration warnings
> > 
> > Didn't Samuel just reply that he has applied these two TWL fixes?
> 
> Samuel applied only one patch and other patch is yet to be applied.
> Do you want me to pull out these two twl patches from the series?

Yes please take out all patches that are not in arch/arm/*omap*/ path.
The others really should go to the driver maintainers.

Tony
