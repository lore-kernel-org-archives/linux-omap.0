From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL] pending DT patches and cleanup for map_io for v3.2
 merge window
Date: Tue, 1 Nov 2011 10:00:37 -0700
Message-ID: <20111101170037.GG31337@atomide.com>
References: <20111024091704.GF31337@atomide.com>
 <201110310039.34717.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:63503 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753602Ab1KARAn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 1 Nov 2011 13:00:43 -0400
Content-Disposition: inline
In-Reply-To: <201110310039.34717.arnd@arndb.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Nicolas Pitre <nico@fluxnic.net>, Russell King <linux@arm.linux.org.uk>, Jon Medhurst <tixy@yxit.co.uk>

* Arnd Bergmann <arnd@arndb.de> [111030 16:05]:
> On Monday 24 October 2011, Tony Lindgren wrote:
> > As discussed in the ARM kernel meeting yesterday, here's are
> > the pending omap things to pull for v3.2 merge window.
> 
> Hi Tony,
> 
> I finally got to pull these.

Great, thanks.
 
> > These would be nice to get still in as other people's work
> > such as Nico's map_io changes need #2 below.
> > 
> > 1. Initial DT support posted few weeks ago
> > 
> >    Please see the earlier pull request at:
> > 
> >    http://lkml.org/lkml/2011/10/4/441
> 
> Looks good. I've missed this initially because I had not yet managed
> to go through that mail thread (randconfig patches) again and pick
> up the patches that got an Ack. The pull request was right in the
> middle of 100 other unread emails...

I guess it's not a good idea to reply with a pull request, have to
remember to keep them separate..
 
> > 2. Cleanup for map_io posted few weeks ago
> > 
> >    This depends on the #1 above, and also requires
> >    the ioremap_exec patch. Russell said he has applied
> >    into devel-stable (But not pushed out yet?).
> > 
> >    When you have the ioremap_exec patch from Russell,
> >    please pull this from:
> > 
> >    git://github.com/tmlind/linux.git sram-map-io
> > 
> >    Pull request against #1 attached below.
> 
> This had systematic but trivial conflicts against the memory.h
> series, which I fixed up. There was also a conflict with 009426a0e
> "ARM: omap: Setup consistent dma size at boot time" from Tixy.
> That patch added a call to omap_init_consistent_dma_size in a function
> that you removed. I have resolved the conflict by adding that call to
> omap1_init_early and omap_common_init_early, but I have no idea if that
> is a correct resolution. Please check.

Thanks, looks good and still boots on the machines I tested.

Regards,

Tony
