From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [linux-pm] calling runtime PM from system PM methods
Date: Fri, 10 Jun 2011 11:45:30 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1106101131110.1921-100000@iolanthe.rowland.org>
References: <20110610152151.GG26441@sirena.org.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:49789 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752166Ab1FJPpb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 10 Jun 2011 11:45:31 -0400
In-Reply-To: <20110610152151.GG26441@sirena.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, linux-omap@vger.kernel.org

On Fri, 10 Jun 2011, Mark Brown wrote:

> On Fri, Jun 10, 2011 at 10:51:02AM -0400, Alan Stern wrote:
> > On Fri, 10 Jun 2011, Mark Brown wrote:
> 
> > > > No, it's generally agreed that _all_ devices should return to full 
> > > > power during system resume -- even if they were runtime suspended 
> > > > before the system sleep.  This also is explained in the Documentation 
> > > > files.
> 
> > > What is the reasoning behind this agreement?  It's not immediately
> > > obvious why this is useful.
> 
> > See section 6 of Documentation/power/runtime_pm.txt.
> 
> It's not massively clear to me how much sense that makes for the
> embedded case where we've got a much better idea of what happened to the
> hardware over suspend.  Note that I'm thinking here mostly of the case
> where we've runtime suspended the device, if the kernel thought the
> device was powered then it's much clearer that we should do this on
> resume.

Well, this is a SHOULD, not a MUST.  If you want your driver to leave a
device in a low-power state, it can do so.  Just bear in mind that the
PM core's idea of the device's runtime power state may end up not
matching reality unless you're careful.

>   * The device's children may need the device to be at full power in
>     order to resume themselves.
> 
> Right, this does need to be handled - I'd expect that in most situations
> we'd have sorted through it before we ever enter suspend.

Maybe; it depends on the situation.  In the embedded world you're 
likely to have this under better control than in the desktop world.

>   * The device might need to switch power levels, wake-up settings, etc.
>   * Remote wake-up events might have been lost by the firmware.
>   * The driver's idea of the device state may not agree with the device's
>     physical state.  This can happen during resume from hibernation.
>   * The device might need to be reset.
> 
> This is all much more under control in the embedded case, and of course
> the device does know if it's coming back from suspend or hibernation
> IIRC which seems to be the only difficult case.

Yes; you could bring the device to full power during resume from 
hibernation and leave it at low power during resume from system 
suspend.

>   * Even though the device was suspended, if its usage counter was > 0 then most
>     likely it would need a run-time resume in the near future anyway.
> 
> Presumably in that case it wouldn't be runtime suspended anyway, or we'd
> otherwise be able to cope with the situation without actually fully
> powering the device?

Again, this depends on the situation.  It probably won't come up in 
your case.

>   * Always going back to full power is simplest.
> 
> It's simple, but spending time and power rewriting large numbers of
> registers over a slow bus (which is the sort of thing you end up doing
> with some devices) or fiddling about with analogue bringup for devices
> affected by that only to immediately power it off again isn't terribly
> useful either - it's at best slow.
> 
> What I'd have expected resume to do is to bring the system back to the
> state it was in before we entered suspend.

That would indeed be the most logical approach.  But it turns out not 
to be entirely feasible for various odd reasons, which I don't remember 
at the moment.

Of course, even if all devices do get turned on during resume, one 
would expect the normal runtime PM mechanism to power them down again 
very shortly after the resume is finished.

>  I've probably got a fairly
> odd view of the world here in that I mostly care about big devices
> connected over slow buses where power up can be user visible, and mostly
> work on subsystems where the concept of "full power" isn't terribly
> meaningful.

The PM core tries to be flexible, but there are limitations.  In
particular, it's not very well suited for handling devices with
multiple power levels.  Drivers simply have to do the best they can to
fit in with the PM core's power model.  For example, all functional
states might be considered "full power" and all others might be
considered "low power".  Coordinating all the extra details would then
be the driver's responsibility.

Alan Stern

