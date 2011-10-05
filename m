From: Tony Lindgren <tony@atomide.com>
Subject: Re: Please help with the OMAP static mapping mess
Date: Tue, 4 Oct 2011 18:35:46 -0700
Message-ID: <20111005013546.GY6324@atomide.com>
References: <alpine.LFD.2.02.1110031312480.9106@xanadu.home>
 <20111003205658.GJ6324@atomide.com>
 <alpine.LFD.2.02.1110031744100.9106@xanadu.home>
 <20111003224411.GA19897@n2100.arm.linux.org.uk>
 <alpine.LFD.2.02.1110041528050.9106@xanadu.home>
 <20111004225424.GA32102@n2100.arm.linux.org.uk>
 <alpine.LFD.2.02.1110041900590.9106@xanadu.home>
 <20111005004208.GW6324@atomide.com>
 <alpine.LFD.2.02.1110042048320.9106@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:30061 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757445Ab1JEBfu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 4 Oct 2011 21:35:50 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.02.1110042048320.9106@xanadu.home>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Nicolas Pitre <nico@fluxnic.net> [111004 17:23]:
> On Tue, 4 Oct 2011, Tony Lindgren wrote:
> 
> > In any case, I suggest we add the following __arm_ioremap_exec patch
> > and then sort out issues with it as they show up.
> > 
> > This allows further work on the common SRAM genalloc patches and generic
> > map_io patches.
> > 
> > Nico, I already have a series converting omap2+ to use the the patch
> > below, and it seems to be working just fine for SRAM. I'll post that
> > series separately shortly. Maybe take a look and see if that allows
> > you to do the generic map_io changes?
> 
> Yes, that looks fine.  Maybe you could avoid exporting the symbol until 
> it is actually needed though.

OK good, will drop the export.
 
> The other thing I need is for the code using ioremap() such as in 
> omap2_set_globals_control() to be called only after the corresponding 
> static mappings are already installed.  Then everything should go 
> smoothly.

Ah, set_globals inits can now move to init_early as well. That happens
after map_io so sounds like that should do for what you need.

Will reply with a patch for that to the series. BTW, these patches
depends on the various cleanup related branches that we have queued,
I think there may be few more patches missing from Arnd's tree still.
I also need to do a bit more testing on it tomorrow.

Regards,

Tony
