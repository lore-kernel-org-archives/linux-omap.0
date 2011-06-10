From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [linux-pm] calling runtime PM from system PM methods
Date: Fri, 10 Jun 2011 16:21:51 +0100
Message-ID: <20110610152151.GG26441@sirena.org.uk>
References: <20110610143657.GF26441@sirena.org.uk> <Pine.LNX.4.44L0.1106101050140.1921-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cassiel.sirena.org.uk ([80.68.93.111]:46466 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757600Ab1FJPVx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 10 Jun 2011 11:21:53 -0400
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1106101050140.1921-100000@iolanthe.rowland.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, linux-omap@vger.kernel.org

On Fri, Jun 10, 2011 at 10:51:02AM -0400, Alan Stern wrote:
> On Fri, 10 Jun 2011, Mark Brown wrote:

> > > No, it's generally agreed that _all_ devices should return to full 
> > > power during system resume -- even if they were runtime suspended 
> > > before the system sleep.  This also is explained in the Documentation 
> > > files.

> > What is the reasoning behind this agreement?  It's not immediately
> > obvious why this is useful.

> See section 6 of Documentation/power/runtime_pm.txt.

It's not massively clear to me how much sense that makes for the
embedded case where we've got a much better idea of what happened to the
hardware over suspend.  Note that I'm thinking here mostly of the case
where we've runtime suspended the device, if the kernel thought the
device was powered then it's much clearer that we should do this on
resume.

  * The device's children may need the device to be at full power in
    order to resume themselves.

Right, this does need to be handled - I'd expect that in most situations
we'd have sorted through it before we ever enter suspend.

  * The device might need to switch power levels, wake-up settings, etc.
  * Remote wake-up events might have been lost by the firmware.
  * The driver's idea of the device state may not agree with the device's
    physical state.  This can happen during resume from hibernation.
  * The device might need to be reset.

This is all much more under control in the embedded case, and of course
the device does know if it's coming back from suspend or hibernation
IIRC which seems to be the only difficult case.

  * Even though the device was suspended, if its usage counter was > 0 then most
    likely it would need a run-time resume in the near future anyway.

Presumably in that case it wouldn't be runtime suspended anyway, or we'd
otherwise be able to cope with the situation without actually fully
powering the device?

  * Always going back to full power is simplest.

It's simple, but spending time and power rewriting large numbers of
registers over a slow bus (which is the sort of thing you end up doing
with some devices) or fiddling about with analogue bringup for devices
affected by that only to immediately power it off again isn't terribly
useful either - it's at best slow.

What I'd have expected resume to do is to bring the system back to the
state it was in before we entered suspend.  I've probably got a fairly
odd view of the world here in that I mostly care about big devices
connected over slow buses where power up can be user visible, and mostly
work on subsystems where the concept of "full power" isn't terribly
meaningful.
