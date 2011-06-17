From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [linux-pm] calling runtime PM from system PM methods
Date: Fri, 17 Jun 2011 21:47:13 +0200
Message-ID: <201106172147.13189.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.1106161017310.2204-100000@iolanthe.rowland.org> <201106170048.37072.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:37786 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752339Ab1FQTqg (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 17 Jun 2011 15:46:36 -0400
In-Reply-To: <201106170048.37072.rjw@sisk.pl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-pm@lists.linux-foundation.org, linux-omap@vger.kernel.org, Kevin Hilman <khilman@ti.com>, Magnus Damm <magnus.damm@gmail.com>, Paul Walmsley <paul@pwsan.com>

On Friday, June 17, 2011, Rafael J. Wysocki wrote:
> On Thursday, June 16, 2011, Alan Stern wrote:
> > On Wed, 15 Jun 2011, Kevin Hilman wrote:
> > 
> > > "Rafael J. Wysocki" <rjw@sisk.pl> writes:
> > > 
> > > > On Wednesday, June 15, 2011, Kevin Hilman wrote:
> > > 
> > > [...]
> > > 
> > > >>
> > > >> From a device driver perspective, system PM is just runtime
> > > >> PM where the "idleness" was forced and only a subset of possible wakeup
> > > >> sources are enabled.
> > > >
> > > > Oh well, I wonder how much of a difference would make you think those things
> > > > are really different. ;-)
> > > 
> > > Seeing a description of the differences would help.  So far the list is
> > > rather short: wakeups and forcibly quieting the hardware.
> > 
> > Another difference is that the user can forbid runtime power management 
> > of any device through the power/control attribute, independently of 
> > system sleeps.
> > 
> > Yet another difference arises because during system PM, the PM
> > workqueue is frozen.  If a driver relies on asynchronous runtime PM
> > then nothing will happen.  This may not apply to you, but it applies to
> > plenty of other drivers.
> > 
> > > I guess I still don't see why system PM cannot be viewed as a special
> > > case of runtime PM, so how about a specific question: From a device
> > > driver perspective, how is system PM anything other than
> > > manually/forcibly creating the right conditions for a runtime PM
> > > transition to happen?
> > 
> > What you're missing is that runtime PM has two separate aspects: a 
> > hardware/power aspect and an administrative aspect.  In terms of 
> > hardware/power it is very similar to system PM, but in administrative 
> > terms it is quite different.
> > 
> > Another thing you need to realize: Rafael is open to the idea that
> > subsystems may be designed specifically to allow drivers to use runtime
> > PM during their ->suspend and ->resume callbacks.  However in the
> > period between ->suspend returning and ->resume being called, runtime
> > PM should _not_ be used.  In particular, this includes the times when
> > ->suspend_noirq and ->resume_noirq are called -- and these are the
> > routines which are often expected to do the real work of setting the
> > device's power state.
> 
> To be precise, my opinion is that calling pm_runtime_suspend() or
> pm_runtime_put_sync() from a driver's .suspend() callback always is a bad
> idea, because it leads to unnecessary complications and doesn't guarantee
> that the desired action will take place at all.  That said I don't really
> think that the PM core should actively prevent that from being done,
> because it's not a direct correctness issue.  Using the runtime PM framework
> after suspend_device_irqs() has run is a different problem, though, and
> in my opinion the PM core should prevent that from being done, this way or
> another.

Having considered that a bit more I see that, in fact, commit
e8665002477f0278f84f898145b1f141ba26ee26 (PM: Allow pm_runtime_suspend() to
succeed during system suspend) has introduced at least one regression.
Namely, the PCI bus type runs pm_runtime_resume() in its .prepare()
callback to guarantee that devices will be in a well known state before
the PCI .suspend() and .suspend_noirq() callbacks are executed.
Unfortunately, after commit e8665002477f0278f84f898145b1f141ba26ee26 this
isn't valid any more, because devices can be runtime-suspend after the
pm_runtime_resume() in .prepare() has run.

USB seems to do something similar in choose_wakeup().

So, either the both of these subsystems should be modified to use
pm_runtime_get_sync() and then pm_runtime_put_<something>() some time
during resume, or we should revert commit e8665002477f0278f84f898145b1f141ba26ee26.

Quite frankly, which shouldn't be a surprise to anyone at this point, I'd
prefer to revert that commit for 3.0.

Thanks,
Rafael
