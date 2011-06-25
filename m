From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [linux-pm] Runtime PM discussion notes
Date: Sat, 25 Jun 2011 14:59:02 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1106251444340.5999-100000@netrider.rowland.org>
References: <alpine.DEB.2.00.1106240935450.18931@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from netrider.rowland.org ([192.131.102.5]:36700 "HELO
	netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751630Ab1FYS7E (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 25 Jun 2011 14:59:04 -0400
In-Reply-To: <alpine.DEB.2.00.1106240935450.18931@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, linux-pm@lists.linux-foundation.org, linux-omap@vger.kernel.org

On Fri, 24 Jun 2011, Paul Walmsley wrote:

> > > But suspend users don't know this either, since they can't predict when 
> > > the next external wakeup can happen.
> > 
> > But they do know (or should know) that they don't intend to use the 
> > system in the near future.  It might be good to have a separate way to 
> > express that idea to the kernel.
> 
> Are you thinking of the current userspace interfaces to suspend, or 
> something else?

I'm not thinking of anything in particular.  Just brainstorming...

If somebody decides to freeze userspace without putting the entire 
system to sleep, how will they know when to unfreeze?  A certain amount 
of specialized kernel/userspace interaction would be needed.

> > > 1. preventing userspace processes from keeping the system from entering 
> > >    idle
> > > 2. preventing userspace processes from waking the system back up
> > 
> > It's not clear what this means.  How can a user process wake the system 
> > up?  Are you referring to user timers?
> 
> Yes.

Then those two are almost the same thing.  It doesn't seem to make much 
sense to say "I want to stop these processes from running now, but 
allow them to run if one of them gets a timer or I/O signal".

> > > 3. preventing kernel code from keeping the system from entering idle
> > 
> > Relatively few kernel threads are freezable.  The ones that are tend to 
> > be involved in device management.  Did you have something specific in 
> > mind?
> 
> No, nothing specific.
> 
> > > 4. preventing kernel code from waking the system back up

Once userspace is inactive, the kernel probably doesn't have very much
to do.  Responding to some network packets, maybe, if the network
interfaces are left running (like a router but without support for
dynamic routing protocols).  In general, I don't think a system could
do a whole lot of useful work in such a state.

> > > 5. requesting that drivers abort what they are currently doing
> > 
> > Not exactly "abort".  More like "stop processing their I/O queues".
> 
> Yes, that's a better way of putting it; hopefully most drivers are doing 
> that.

This is more of a "transition" issue than a "steady-state" concern.  
When userspace is frozen, it can't generate new I/O requests.  If the 
old ones were left to terminate normally, pretty soon the I/O queues 
would drain by themselves.

In short, I'm not sure how these ideas would yield anything new and 
worthwhile.  Maybe I'm just slow today...

Alan Stern

