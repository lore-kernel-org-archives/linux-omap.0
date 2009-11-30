From: Tony Lindgren <tony@atomide.com>
Subject: Re: Preventing OMAP3 serial driver to take control of all UARTs
Date: Mon, 30 Nov 2009 12:52:00 -0800
Message-ID: <20091130205159.GX4348@atomide.com>
References: <20091130084651.GA17675@esdhcp04058.research.nokia.com>
 <1259599010.4649.51.camel@thunk>
 <fa686aa40911300901nd47259ar2e1beae7be447937@mail.gmail.com>
 <20091130194031.GV4348@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:62076 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752055AbZK3UwC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 30 Nov 2009 15:52:02 -0500
Content-Disposition: inline
In-Reply-To: <20091130194031.GV4348@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: Peter Barada <peterb@logicpd.com>, Mika Westerberg <ext-mika.1.westerberg@nokia.com>, linux-omap@vger.kernel.org, Olof Johansson <olof@lixom.net>

* Tony Lindgren <tony@atomide.com> [091130 11:40]:
> * Grant Likely <grant.likely@secretlab.ca> [091130 09:01]:
>  
> > Not in mainlined yet, but I'm working on porting flattened device tree
> > support to OMAP to solve exactly this sort of problem.  Basically,
> > instead of hard coding or #ifdeffing things, a data blob gets handed
> > to the kernel at boot time telling it exactly what hardware is present
> > in a consistent, parsable format.  Device drivers then get probed
> > based on data in the device tree.  Here's some info on the approach:
> > 
> > http://www.elinux.org/Device_Trees
> > 
> > I expect to have my prototype ready for review mid-January, and most
> > of the common code should be either merged or queued up in linux-next
> > by that time.
> 
> While device tree is a nice solution to some of the problems, it still
> leaves all the issues we already have with buggy and and outdated
> bootloaders. So we still need to properly initialize the devices in
> the kernel.
> 
> Just for reference, most of the omap bootloader bugs seem to be
> related to not muxing the pins right or using wrong timings for GPMC.
> 
> And then things that mostly change during the board development are
> the GPIO pins, but those can be easily rewritten in the board-*.c
> files based on the omap_rev.
> 
> But at least the device tree is a standard model, while the earlier
> omap tag approach was non-standard.
> 
> Peter, maybe you've already thought through all this.. But would it be
> possible to do lightweight device tree that we just use to populate
> the platform data?

Sorry, I meant to ask Grant this question as Grant (and not Peter)
is working on the device tree.

Tony
