From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: pm_runtime_suspended() can be false if RPM_SUSPENDED
Date: Mon, 11 Jul 2011 22:22:18 +0200
Message-ID: <201107112222.18917.rjw@sisk.pl>
References: <871uy0733n.fsf@ti.com> <201107112202.48280.rjw@sisk.pl> <874o2sy3p9.fsf@ti.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:46718 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750785Ab1GKUVY (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 11 Jul 2011 16:21:24 -0400
In-Reply-To: <874o2sy3p9.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-pm@lists.linux-foundation.org, Linux OMAP <linux-omap@vger.kernel.org>

On Monday, July 11, 2011, Kevin Hilman wrote:
> "Rafael J. Wysocki" <rjw@sisk.pl> writes:
> 
> [...]
> 
> >> 
> >> However, based on the pm_runtime_set_active() problem you mentioned
> >> above, I'm not sure this will help either, since what the PM domain's
> >> noirq callback will want to do will be based on the actual device
> >> hardware state, not on the PM core's view of the device state.
> >
> > Yes.  For devices whose runtime PM is never enabled, this is quite clear
> > (we must assume they are operational).  For devices whose runtime PM is
> > temporarily disabled and the reenabled, it's not that clear, but at
> > least for the system suspend case we may require drivers not to use
> > pm_runtime_set_active/suspended() in their callbacks, so that we may
> > assume that the status hasn't changed between .suspend() and .resume().
> >
> > So, I think your approach (to check power.runtime_status) is correct in this
> > respect.
> 
> OK, I'll just directly check power.runtime_status in the noirq methods,
> since at that point I always know that disable_depth > 0.

That's what I wanted to say. :-)  The only problem with that is if
CONFIG_PM_RUNTIME is unset, power.runtime_status is not present, so I think
we'll need a static inline to work around that.

Thanks,
Rafael
