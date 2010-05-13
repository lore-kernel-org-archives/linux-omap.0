From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [linux-pm] [PATCH 0/8] Suspend block api (version 6)
Date: Fri, 14 May 2010 00:07:34 +0200
Message-ID: <201005140007.34129.rjw@sisk.pl>
References: <20100513194205.GC3428@atomide.com> <Pine.LNX.4.44L0.1005131740370.1731-100000@iolanthe.rowland.org> <20100513215404.GN3428@atomide.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:54763 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754733Ab0EMWGl (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 13 May 2010 18:06:41 -0400
In-Reply-To: <20100513215404.GN3428@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Alan Stern <stern@rowland.harvard.edu>, Matthew Garrett <mjg@redhat.com>, Paul Walmsley <paul@pwsan.com>, Arve =?iso-8859-1?q?Hj=F8nnev=E5g?= <arve@android.com>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Kernel development list <linux-kernel@vger.kernel.org>, Tejun Heo <tj@kernel.org>, Oleg Nesterov <oleg@redhat.com>, Kevin Hilman <khilman@deeprootsystems.com>, magnus.damm@gmail.com, Theodore Ts'o <tytso@mit.edu>, mark gross <mgross@linux.intel.com>, Arjan van de Ven <arjan@infradead.org>, Geoff Smith <geoffx.smith@intel.com>, Brian Swetland <swetland@google.com>, =?iso-8859-1?q?Beno=EEt_Cousson?= <b-cousson@ti.com>, linux-omap@vger.kernel.org, Vitaly Wool <vitalywool@gmail.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>

On Thursday 13 May 2010, Tony Lindgren wrote:
> * Alan Stern <stern@rowland.harvard.edu> [100513 14:36]:
> > On Thu, 13 May 2010, Tony Lindgren wrote:
> > 
> > > Well this is an interesting problem, and once solved will be handy
> > > for all kind of things. My worry is that if it's integrated in it's
> > > current form it will be totally out of control all over the place :(
> > > 
> > > Still hoping we can come up with some clean way that avoid the patching
> > > all over the place part.. How about the following, can you please check
> > > if it would help with your example of guaranteed handling of event:
> > > 
> > > 1. In the kernel, we add one more timer queue for critical timers.
> > >    The current timer queue(s) stay as it is.
> > > 
> > > 2. We allow selecting the timer based on some flag, the default
> > >    behaviour being the current default timer queue.
> > > 
> > > 3. Then we add next_timer_interupt_critical() to only query the
> > >    critical timers along the lines of the current next_timer_interrupt().
> > > 
> > > 4. We implement a custom pm_idle that suspends the system based on
> > >    some logic and checking if next_timer_interrupt_critical() is
> > >    empty. If the next_timer_interrupt_critical() does not return
> > >    anything, we assume it's OK to suspend the system.
> > > 
> > > Now to me it sounds if your the input layer and userspace handle
> > > both grab the timers with the critical flags, it should be guaranteed
> > > that the events get handled before the system is suspended.
> > 
> > Why do you want this to be tied to timers?  Many of the events in 
> > question are asynchronous with no specific timing relations.
> 
> To me it seems that the non-timer related events can be dealt
> with toggling the opportunistic suspend idle flag in sysfs.
> That should depend on the device and use specific policy.

OK, that's all hand waving.  Do you have any patches, please?

Rafael
