From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 7/7] 4460sdp/blaze/panda: hwmod: Prevent gpio1 reset
 during hwmod init
Date: Tue, 5 Jul 2011 03:45:53 -0700
Message-ID: <20110705104553.GF5783@atomide.com>
References: <1309486081-8257-3-git-send-email-rnayak@ti.com>
 <1309486081-8257-4-git-send-email-rnayak@ti.com>
 <1309486081-8257-5-git-send-email-rnayak@ti.com>
 <1309486081-8257-6-git-send-email-rnayak@ti.com>
 <1309486081-8257-7-git-send-email-rnayak@ti.com>
 <1309486081-8257-8-git-send-email-rnayak@ti.com>
 <20110701063241.GX23145@atomide.com>
 <alpine.DEB.2.00.1107022103430.12499@utopia.booyaka.com>
 <20110704085335.GP23145@atomide.com>
 <alpine.DEB.2.00.1107050136120.4217@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:57738 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755433Ab1GEKp5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 5 Jul 2011 06:45:57 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1107050136120.4217@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Rajendra Nayak <rnayak@ti.com>, linux-omap@vger.kernel.org, khilman@ti.com, b-cousson@ti.com, Nishanth Menon <nm@ti.com>, s-sintes@ti.com, Moiz Sonasath <m-sonasath@ti.com>

* Paul Walmsley <paul@pwsan.com> [110705 00:35]:
> Hi Tony
> 
> On Mon, 4 Jul 2011, Tony Lindgren wrote:
> 
> > * Paul Walmsley <paul@pwsan.com> [110702 21:09]:
> > 
> > > Here are some options that come to mind:
> > > 
> > > 1. Wait until the driver runtime PM conversion is finished before doing 
> > >    anything.  In the meantime, boards with IP blocks that can't be reset 
> > >    - N810, TI 4460 boards - will have problems.
> > > 
> > > 2. Merge the lazy/unused hwmod reset code, but prevent IP blocks 
> > >    controlled by non-runtime PM drivers from being reset.  We'd have to
> > >    maintain a list of these somewhere, perhaps in some common code called 
> > >    by board file init_machine code.  Then we'd need to redact that list as 
> > >    new driver runtime PM conversions complete.
> > > 
> > > 3. Merge the lazy/unused hwmod reset code, but disable the unused hwmod 
> > >    reset code until the driver runtime PM conversion is finished.  This
> > >    could cause problems with driverless devices that are left configured
> > >    by bootloaders or ROM code, and that problem would reoccur for each new
> > >    OMAP chip.
> > > 
> > > Do you have a preference as to which approach to take?
> > 
> > I think #3 above is the safest option. How about make it only happen with
> > hwmod_reset=1 cmdline with 0 being the default value?
> 
> With the patch that was posted, that would disable all reset.  Probably we 
> want to reset devices that have drivers with PM runtime support?

Can't we always reset the registered hwmods automatically one at a time when
omap_device_build is called?

> That would allow drivers to assume that they are starting from consistent 
> device state.  It also should prevent some power management problems 
> that are dependent on particular bootloaders.   How about if we add a 
> second parameter, hwmod_reset_unused?  The default could be 'no' and then 
> only devices with PM runtime-enabled drivers would be reset first.

Yes I think hwmod_reset_unsed would be a better name, but do we actually
need any other reset option in addition to that?

TOny
