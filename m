From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [linux-pm] calling runtime PM from system PM methods
Date: Fri, 10 Jun 2011 20:49:03 +0200
Message-ID: <201106102049.03777.rjw@sisk.pl>
References: <87hb80546c.fsf@ti.com> <Pine.LNX.4.44L0.1106090945490.2081-100000@iolanthe.rowland.org> <20110610143657.GF26441@sirena.org.uk>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:47247 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757705Ab1FJSsa (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 10 Jun 2011 14:48:30 -0400
In-Reply-To: <20110610143657.GF26441@sirena.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: linux-pm@lists.linux-foundation.org, Alan Stern <stern@rowland.harvard.edu>, linux-omap@vger.kernel.org

On Friday, June 10, 2011, Mark Brown wrote:
> On Thu, Jun 09, 2011 at 09:56:48AM -0400, Alan Stern wrote:
> > On Wed, 8 Jun 2011, Kevin Hilman wrote:
> 
> > > Runtime suspend
> > > 2. activity finishes
> 
> > > system suspend [echo mem > /sys/power/state]
> > > 2. prevent future activity, halt/wait for current activity
> 
> > > The only difference is step 2.
> 
> > That _is_ the main difference, and it's a big one.  (As Magnus pointed 
> > out, wakeup-enabling is another difference).
> 
> ...
> 
> > They don't have to be decoupled, and indeed they can share code.  The 
> > point Rafael and I are making is that they have to use different 
> > callback pointers, which gives you a chance to handle the differences 
> > as well as the similarities.
> 
> It seems like everyone's agreeing with each other here - from the user
> side the request seems to be largely for core infastructure like
> UNIVERSAL_DEV_PM_OPS() (which I'm not sure is a good idea any more given
> that it doesn't do anything to handle the runtime/system interaction?).

I'm not sure what you mean here.  First, UNIVERSAL_DEV_PM_OPS() actually
does what it says, defines a set of operations to use for system suspend,
hibernation and runtime PM all the same.

> Right now this all feels like more work than it should be in simpler
> drivers.

My impression is that you and Kevin are talking of different things.

The Kevin's point originally was that it might be desirable to do things
like calling pm_runtime_suspend() from a driver's (system) .suspend()
callback, if I understood it correctly, and the answer was that it wasn't
the right thing to do (for reasons given elsewhere in the thread).

Your point seems to be that simple drivers should not be required to
define separate callback routines, for example, for system suspend and
runtime PM.  However, they aren't required to do so, they can point
all of their "suspend" callback pointers to the same routine, which is
what the UNIVERSAL_DEV_PM_OPS() macro does.

Thanks,
Rafael
