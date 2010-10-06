From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH] PM: add synchronous runtime interface for interrupt
 handlers
Date: Wed, 6 Oct 2010 11:58:35 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1010061156460.2047-100000@iolanthe.rowland.org>
References: <878w2cnwky.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:34134 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1758946Ab0JFP6f (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 6 Oct 2010 11:58:35 -0400
In-Reply-To: <878w2cnwky.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Partha Basak <p-basak2@ti.com>, linux-omap@vger.kernel.org

On Tue, 5 Oct 2010, Kevin Hilman wrote:

> Alan Stern <stern@rowland.harvard.edu> writes:
> 
> > On Fri, 1 Oct 2010, Rafael J. Wysocki wrote:
> >
> >> > > In my opinion the _irq operations should really be one-shot, without
> >> > > any looping, waking up parents etc.  I mean, if the parent is not RPM_ACTIVE,
> >> > > the _irq resume should immediately fail and analogously for the _irq
> >> > > suspend.  And so on.  As simple as reasonably possible.
> >> > 
> >> > But what if the device's own status is currently SUSPENDING or
> >> > RESUMING?  Do you want to fail when that happens, instead of waiting
> >> > for the concurrent operation to finish?
> >> 
> >> Yes.  IMO an _irq() suspend should only be allowed if the status is RPM_ACTIVE
> >> and an _irq() resume should fail if the status is not RPM_SUSPENDED.  The
> >> error code returned should depend on the situation, though.
> >> 
> >> > There's no way to prevent this
> >> > on SMP systems, because a wakeup request can arrive while a
> >> > software-initiated resume is in progress.
> >> 
> >> I know that. :-)
> >
> > I suspect Kevin will not want to live with this restriction, but I'd
> > like to hear from him.  Kevin?
> 
> [ Apologies for the delays... I've been running around preparing OMAP PM
>   stuff for the upcoming merge window. ]
> 
> I think I can live with the above restrictions (the _irq methods failing
> unless they can immediately run.)  For the rare corner cases I've
> currently run into, this will work fine as they happen because of a
> wakeup IRQ, where we know the device is RPM_SUSPENDED.

Then what will the driver do if it gets a wakeup IRQ but it can't
resume the device because some other thread is in the middle of a
suspend or resume?

Alan Stern

