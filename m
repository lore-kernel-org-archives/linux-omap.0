From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [linux-pm] Runtime PM discussion notes
Date: Fri, 24 Jun 2011 12:36:02 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1106240935450.18931@utopia.booyaka.com>
References: <Pine.LNX.4.44L0.1106231113170.2033-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:51717 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753130Ab1FXSgD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 24 Jun 2011 14:36:03 -0400
In-Reply-To: <Pine.LNX.4.44L0.1106231113170.2033-100000@iolanthe.rowland.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, linux-pm@lists.linux-foundation.org, linux-omap@vger.kernel.org

Hi Alan,

On Thu, 23 Jun 2011, Alan Stern wrote:

> On Thu, 23 Jun 2011, Paul Walmsley wrote:
> > 
> > On Wed, 15 Jun 2011, Rafael J. Wysocki wrote:
>
> At the moment, isn't it possible for the userspace ioctl PM interface to 
> freeze processes without going all the way through to a system sleep?

Something like cgroup_freezer is probably more useful, since it can freeze 
a configurable subset of processes.  Consider the common mobile use-case 
of audio playback while the display, touchscreen, etc. are disabled.  
In such a case, large portions of userspace can be frozen or paused, but 
not all.

> > But suspend users don't know this either, since they can't predict when 
> > the next external wakeup can happen.
> 
> But they do know (or should know) that they don't intend to use the 
> system in the near future.  It might be good to have a separate way to 
> express that idea to the kernel.

Are you thinking of the current userspace interfaces to suspend, or 
something else?

> > > and (2) that it is supposed to ignore wakeup signals from certain
> > > sources. 
> > 
> > Isn't this configurable now without system suspend with the wakeup sources 
> > code?
> 
> The wakeup code does two things: It tells the system which devices 
> should be enabled for wakeup when the system sleeps (as opposed to 
> cpuidle, when all devices should be able to generate interrupts),

Perhaps the same interface would be useful for CPUIdle-based approaches.

> > The individual components of system suspend are definitely useful:
> > 
> > 1. preventing userspace processes from keeping the system from entering 
> >    idle
> > 2. preventing userspace processes from waking the system back up
> 
> It's not clear what this means.  How can a user process wake the system 
> up?  Are you referring to user timers?

Yes.

> > 3. preventing kernel code from keeping the system from entering idle
> 
> Relatively few kernel threads are freezable.  The ones that are tend to 
> be involved in device management.  Did you have something specific in 
> mind?

No, nothing specific.

> > 4. preventing kernel code from waking the system back up
> > 5. requesting that drivers abort what they are currently doing
> 
> Not exactly "abort".  More like "stop processing their I/O queues".

Yes, that's a better way of putting it; hopefully most drivers are doing 
that.


- Paul
