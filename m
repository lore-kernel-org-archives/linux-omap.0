From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [linux-pm] calling runtime PM from system PM methods
Date: Mon, 6 Jun 2011 15:16:23 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1106061502270.1953-100000@iolanthe.rowland.org>
References: <201106062029.36389.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:37672 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1757815Ab1FFTQY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 6 Jun 2011 15:16:24 -0400
In-Reply-To: <201106062029.36389.rjw@sisk.pl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Kevin Hilman <khilman@ti.com>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, linux-omap@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Paul Walmsley <paul@pwsan.com>

On Mon, 6 Jun 2011, Rafael J. Wysocki wrote:

> > In a nutshell, what I'm after is for any pm_runtime_forbid() calls to be
> > cancelled during system PM, thus allowing pending runtime PM events to
> > occur during system PM.
> > 
> > Basically, what I have is several drivers who don't really need suspend
> > hooks if runtime PM is enabled, because they use runtime PM on a per
> > transaction basis, handle all the HW stuff in the runtime PM callbacks,
> > and from a HW perspective, there is no difference in power state between
> > runtime and static suspend.  These devices are already runtime suspended
> > when the system PM callbacks run, so there is nothing for the system PM
> > callbacks to do.
> 
> Well, I'm not quite sure this is the case.  You have to remember that
> system suspend can happen at any time, so even if your runtime PM is used
> around transactions, it theoretically is possible for system suspend to
> happen while one of the transactions is in progress (unless you can guarantee
> that the transactions can't be preempted).

That's right.  For example, there may be a queue of pending I/O 
transactions.  Runtime PM would leave the device active as long as the 
queue was non-empty.  System sleep should force the driver to stop 
processing the queue as well as suspending the device. 

> While it is tempting to try to get away with only two PM callbacks per
> driver instead of four (or even more), it generally is not doable, simply
> because driver callbacks are not executed directly by the core.
> 
> The only way to address the problem of code duplication between .suspend()
> and .runtime_suspend() callbacks (and analogously for resume) I see at the
> moment is to make those callbacks execute common routines.

For example, the power state might be protected by a device-specific
spinlock.  The suspend callback could acquire the spinlock, check to
see if the device is already in a low-power state and if not, put it in
one.  Then the same callback could be used for runtime suspend and
system suspend -- apart from issues like stopping the I/O request
queue.

Alan Stern

