From: Tony Lindgren <tony@atomide.com>
Subject: Re: [linux-pm] [PATCH 0/8] Suspend block api (version 6)
Date: Thu, 13 May 2010 12:42:05 -0700
Message-ID: <20100513194205.GC3428@atomide.com>
References: <alpine.DEB.2.00.1005122118530.7624@utopia.booyaka.com>
 <Pine.LNX.4.44L0.1005131002380.1695-100000@iolanthe.rowland.org>
 <20100513191717.GA3428@atomide.com>
 <20100513192522.GA19256@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:53000 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752780Ab0EMTmY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 13 May 2010 15:42:24 -0400
Content-Disposition: inline
In-Reply-To: <20100513192522.GA19256@srcf.ucam.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Matthew Garrett <mjg@redhat.com>
Cc: Alan Stern <stern@rowland.harvard.edu>, Paul Walmsley <paul@pwsan.com>, Arve =?utf-8?B?SGrDuG5uZXbDpWc=?= <arve@android.com>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Kernel development list <linux-kernel@vger.kernel.org>, Tejun Heo <tj@kernel.org>, Oleg Nesterov <oleg@redhat.com>, Kevin Hilman <khilman@deeprootsystems.com>, magnus.damm@gmail.com, Theodore Ts'o <tytso@mit.edu>, mark gross <mgross@linux.intel.com>, Arjan van de Ven <arjan@infradead.org>, Geoff Smith <geoffx.smith@intel.com>, Brian Swetland <swetland@google.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, =?utf-8?Q?Beno=C3=AEt?= Cousson <b-cousson@ti.com>, linux-omap@vger.kernel.org, Vitaly Wool <vitalywool@gmail.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>

* Matthew Garrett <mjg@redhat.com> [100513 12:20]:
> On Thu, May 13, 2010 at 12:17:17PM -0700, Tony Lindgren wrote:
> > The suspend blocks seems like a hack to spam filter good and bad
> > apps from timer usage point of view. Applications are categorized
> > as good or bad depending if they grab a susped blocker or not.
> > 
> > I believe categorizing the apps should be instead done with some
> > timer flags or cgroups instead.
> 
> I agree, but we have no mechanism for implementing that in a race-free 
> way. We don't even have a realistical proposal for what that mechanism 
> would look like. Should we refuse bread today for the promise of cake 
> tomorrow?

Well this is an interesting problem, and once solved will be handy
for all kind of things. My worry is that if it's integrated in it's
current form it will be totally out of control all over the place :(

Still hoping we can come up with some clean way that avoid the patching
all over the place part.. How about the following, can you please check
if it would help with your example of guaranteed handling of event:

1. In the kernel, we add one more timer queue for critical timers.
   The current timer queue(s) stay as it is.

2. We allow selecting the timer based on some flag, the default
   behaviour being the current default timer queue.

3. Then we add next_timer_interupt_critical() to only query the
   critical timers along the lines of the current next_timer_interrupt().

4. We implement a custom pm_idle that suspends the system based on
   some logic and checking if next_timer_interrupt_critical() is
   empty. If the next_timer_interrupt_critical() does not return
   anything, we assume it's OK to suspend the system.

Now to me it sounds if your the input layer and userspace handle
both grab the timers with the critical flags, it should be guaranteed
that the events get handled before the system is suspended.

Regards,

Tony
