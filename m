From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [linux-pm] calling runtime PM from system PM methods
Date: Fri, 10 Jun 2011 15:36:57 +0100
Message-ID: <20110610143657.GF26441@sirena.org.uk>
References: <87hb80546c.fsf@ti.com> <Pine.LNX.4.44L0.1106090945490.2081-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cassiel.sirena.org.uk ([80.68.93.111]:48308 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752509Ab1FJOhF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 10 Jun 2011 10:37:05 -0400
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1106090945490.2081-100000@iolanthe.rowland.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Kevin Hilman <khilman@ti.com>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, linux-omap@vger.kernel.org

On Thu, Jun 09, 2011 at 09:56:48AM -0400, Alan Stern wrote:
> On Wed, 8 Jun 2011, Kevin Hilman wrote:

> > Runtime suspend
> > 2. activity finishes

> > system suspend [echo mem > /sys/power/state]
> > 2. prevent future activity, halt/wait for current activity

> > The only difference is step 2.

> That _is_ the main difference, and it's a big one.  (As Magnus pointed 
> out, wakeup-enabling is another difference).

...

> They don't have to be decoupled, and indeed they can share code.  The 
> point Rafael and I are making is that they have to use different 
> callback pointers, which gives you a chance to handle the differences 
> as well as the similarities.

It seems like everyone's agreeing with each other here - from the user
side the request seems to be largely for core infastructure like
UNIVERSAL_DEV_PM_OPS() (which I'm not sure is a good idea any more given
that it doesn't do anything to handle the runtime/system interaction?).
Right now this all feels like more work than it should be in simpler
drivers.

> > For many (if not all) devices though, what I suspect we would want is
> > for devices that are runtime suspended to stay runtime suspended across
> > a system suspend *and* resume.  That would mean that the device power
> > domain would not call system PM callbacks on devices that are runtime
> > suspended.

> No, it's generally agreed that _all_ devices should return to full 
> power during system resume -- even if they were runtime suspended 
> before the system sleep.  This also is explained in the Documentation 
> files.

What is the reasoning behind this agreement?  It's not immediately
obvious why this is useful.
