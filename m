From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [linux-pm] calling runtime PM from system PM methods
Date: Fri, 10 Jun 2011 22:27:25 +0200
Message-ID: <201106102227.25391.rjw@sisk.pl>
References: <20110610155707.GN26436@opensource.wolfsonmicro.com> <201106102038.22725.rjw@sisk.pl> <20110610184222.GT26436@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:47358 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758006Ab1FJU1A (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 10 Jun 2011 16:27:00 -0400
In-Reply-To: <20110610184222.GT26436@opensource.wolfsonmicro.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: linux-pm@lists.linux-foundation.org, Alan Stern <stern@rowland.harvard.edu>, linux-omap@vger.kernel.org

On Friday, June 10, 2011, Mark Brown wrote:
> On Fri, Jun 10, 2011 at 08:38:22PM +0200, Rafael J. Wysocki wrote:
> > On Friday, June 10, 2011, Mark Brown wrote:
> 
> > > I think from an interface point of view it's something like
> > > UNIVERSAL_DEV_PM_OPS() and friends, probably with some additional ops
> > > that can do the glue bits like enabling wakeup and quiescing activity.
> > > I'd need to think harder about what exactly that'd look like - for my
> > > cases the fundamental thing I want to say is that there's one suspend
> > > routine and one resume routine and I'd like some framework code to work
> > > out when they're called.
> 
> > Can your device generate wakeup signals?
> 
> I am interested in a fairly large selection of devices but broadly
> speaking any off-SoC device can generate wakeups if it can generate
> interrupts.

So, there are a few things to consider:

* Can the device do things like DMA?
* Does the driver use a workqueue?
* Does it use timers?

In all of the above cases your system suspend handling will require extra
care to make sure those things won't get in the way of the suspend process.

Next, what subsystem (e.g. bus type) is the driver going to work with?

If the subsystem is "smart" enough, it can take care of many things, like
"powering off", wakeup preparations and so on.

Now, there are a few combinations possible.  First, if the subsystem is
"smart" and the driver need not take care of the things listed above, then
very likely .runtime_suspend() and .suspend() can do the same and
UNIVERSAL_DEV_PM_OPS() can be used.  Next, if the subsystem is "smart",
but the driver needs to take care of those things, then .suspend() has
more to do, but very likely .runtime_suspend() and .suspend_noirq() can
do the same, while .suspend() may simply prepare the device for the next
stage.  And so on.

It's probably fair to say that everithing depends on the subsystem, what it
does and what it expects from the driver.  In the extreme case, when the
subsystem is like the platform bus type, the driver unfortunately is on its
own and has to deal with the whole complexity.

Thanks,
Rafael
