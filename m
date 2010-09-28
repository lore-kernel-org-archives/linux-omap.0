From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [linux-pm] runtime_pm_get_sync() from ISR with IRQs disabled?
Date: Tue, 28 Sep 2010 10:55:32 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1009281033230.17050-100000@iolanthe.rowland.org>
References: <201009272309.22530.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:46407 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1755653Ab0I1Ozf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 28 Sep 2010 10:55:35 -0400
In-Reply-To: <201009272309.22530.rjw@sisk.pl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-pm@lists.linux-foundation.org, Kevin Hilman <khilman@deeprootsystems.com>, Partha Basak <p-basak2@ti.com>, linux-omap@vger.kernel.org

On Mon, 27 Sep 2010, Rafael J. Wysocki wrote:

> On Monday, September 27, 2010, Alan Stern wrote:
> > On Mon, 27 Sep 2010, Rafael J. Wysocki wrote:
> > 
> > > > How about adding another flag to the dev_pm_info structure, to indicate 
> > > > that the runtime callbacks may be called in interrupt context?
> > > > 
> > > > Maybe that will lead to problems I haven't thought of.  But if it seems 
> > > > okay to you, I can code it up easily enough.
> > > 
> > > Hmm.  I was thinking about adding a new RPM_ flag for that, like RPM_FASTPATH,
> > > telling the PM core to assume the callbacks will not sleep and that the call
> > > might be from interrupt handler.
> > 
> > That might appear more flexible, but is there any advantage to it?  
> > That is, would there be a situation where the driver knows that the 
> > next callback won't sleep but in general the callback might sleep 
> > sometimes?  It doesn't seem very likely.
> 
> A flag in dev_pm_info, when set, would always make the PM core behave as
> though the call was made from interrupt context, even if it really wasn't,
> while the RPM_ flag would allow the driver to tell it to do that when it's
> really necessary.  The driver always knows which calls are made from an
> interrupt handler. :-)

On Mon, 27 Sep 2010, Kevin Hilman wrote:

> For flexibility, I like the RPM_FASTPATH approach.
> 
> At least in the drivers I'm currently tinkering with, most of the
> callers can sleep.  It's only the occasional callback triggered from the
> ISR that can't sleep.
> 
> During this "normal" (non-ISR) usage, there might very well be
> concurrent or pending requests, some of which might have to sleep.  So,
> I think it's best to have the fastpath settable on a per-caller basis.

The RPM_FASTPATH approach turns out not to be viable.  It clearly
implies that some calls will be made with the flag and some calls will
be made without.  This can lead to incorrect behavior.

Here's what can happen.  Suppose the device is at low power and CPU 1
calls pm_runtime_resume without using the new flag.  An instant later,
a remote wakeup interrupt arrives and the interrupt handler on CPU 2
calls pm_runtime_resume with the new flag set.

Since CPU 1 has changed the status to RPM_RESUMING, CPU 2 has to wait
until the resume has completed, and since CPU 2 is in_interrupt, it has
to busy-wait.  But the process it's waiting for is running on CPU 1
with interrupts enabled and so can block for an arbitrarily long time.

This example shows that if _any_ resume callbacks are made in_interrupt
then they _all_ have to be made with interrupts disabled.  The same
sort of reasoning applies to suspend callbacks (replace RPM_RESUMING 
above with RPM_SUSPENDING).

Given this, I see no point in adding a special per-call flag.

There's another advantage to using a per-device flag.  Not all resume
calls are initiated by the driver; the PM core has to start a resume on
its own when rpm_resume sees that the device's parent is suspended.  
When this happens, the nested resume can be carried out with interrupts
disabled if the parent's driver supports it -- and the PM core won't
know that unless there's a flag for it in dev_pm_info.

Alan Stern

