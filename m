From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [linux-pm] [PATCH] PM: add synchronous runtime interface for interrupt handlers
Date: Tue, 12 Oct 2010 00:30:36 +0200
Message-ID: <201010120030.36393.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.1010111254430.2339-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:36385 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756737Ab0JKWbd (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 11 Oct 2010 18:31:33 -0400
In-Reply-To: <Pine.LNX.4.44L0.1010111254430.2339-100000@netrider.rowland.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-pm@lists.linux-foundation.org, linux-omap@vger.kernel.org, Kevin Hilman <khilman@deeprootsystems.com>

On Monday, October 11, 2010, Alan Stern wrote:
> On Sat, 9 Oct 2010, Rafael J. Wysocki wrote:
> 
> > I wonder if we can do the "fast suspend" and "fast resume" under the
> > power.lock spinlock.  That would allow us to avoid some complications
> > related to RPM_RESUMING and RPM_SUSPENDING.  Namely,
> > if the device is flagged as "power.irq_safe", it will always suspend and
> > resume "atomically" under its power.lock spinlock.  Then, the status will
> > always be either RPM_ACTIVE or RPM_SUSPENDED (or RPM_ERROR,
> > which is uninteresting).
> 
> We could do this.  It has some disadvantages but they aren't terrible.
> 
> >  Also, if "fast suspend" doesn't change the device
> > parent's power.child_count, we won't need to worry about parents any more.
> 
> I don't know about that.  If the parent's child_count doesn't change 
> then the parent can never suspend.  Of course, if there is no parent or 
> the parent is disabled for runtime PM then this doesn't matter.

I think the recursive resuming of the parents is inherently nonatomic and
it shouldn't be done in the "fast suspend/resume" case.  So, I think it might
make sense to prevent the parent from ever suspending if children are supposed
to use the "fast" ops.

> > I'm still not sure what to do with _idle() in that case.
> 
> Clearly we should not hold the spinlock while running the runtime_idle
> callback.  That would make it impossible for the callback to ask for a
> suspend.

That's correct.

Thanks,
Rafael
