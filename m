From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [linux-pm] calling runtime PM from system PM methods
Date: Fri, 10 Jun 2011 16:57:07 +0100
Message-ID: <20110610155707.GN26436@opensource.wolfsonmicro.com>
References: <20110610152151.GG26441@sirena.org.uk>
 <Pine.LNX.4.44L0.1106101131110.1921-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:33497 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753319Ab1FJP5L (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 10 Jun 2011 11:57:11 -0400
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1106101131110.1921-100000@iolanthe.rowland.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, linux-omap@vger.kernel.org

On Fri, Jun 10, 2011 at 11:45:30AM -0400, Alan Stern wrote:
> On Fri, 10 Jun 2011, Mark Brown wrote:

> > It's not massively clear to me how much sense that makes for the
> > embedded case where we've got a much better idea of what happened to the
> > hardware over suspend.  Note that I'm thinking here mostly of the case
> > where we've runtime suspended the device, if the kernel thought the
> > device was powered then it's much clearer that we should do this on
> > resume.

> Well, this is a SHOULD, not a MUST.  If you want your driver to leave a
> device in a low-power state, it can do so.  Just bear in mind that the
> PM core's idea of the device's runtime power state may end up not
> matching reality unless you're careful.

This is part of the trouble, it all feels like a lot more work than it
should be for relatively common cases.  In the audio case we're fine as
the subsystem implements a completely independent PM infrastructure
which ignores the PM core except for system suspend (and sometimes
ignores that), it's noticably harder to reason about what's going on
when I go outside there and when I think about what I'm doing it always
feels like it should be possible to factor it out of the drivers.

> Of course, even if all devices do get turned on during resume, one 
> would expect the normal runtime PM mechanism to power them down again 
> very shortly after the resume is finished.

Yeah, though of course if you're only going to be resumed for a very
brief time anyway the amount of time you spend powering up and down
suddenly gets a lot more interesting.  Things like responding to a
keepalive from the network can be done quickly enough that people get
annoyed if you burn 10ms or whatever powering up some irrelevant bit of
hardware.

> >  I've probably got a fairly
> > odd view of the world here in that I mostly care about big devices
> > connected over slow buses where power up can be user visible, and mostly
> > work on subsystems where the concept of "full power" isn't terribly
> > meaningful.
> 
> The PM core tries to be flexible, but there are limitations.  In
> particular, it's not very well suited for handling devices with
> multiple power levels.  Drivers simply have to do the best they can to
> fit in with the PM core's power model.  For example, all functional
> states might be considered "full power" and all others might be
> considered "low power".  Coordinating all the extra details would then
> be the driver's responsibility.

Right, I mostly agree - like I say I think the main thing that would be
useful here is to extend the helpers for the common case unified suspend
situation.  This may be totally separate to what Kevin needs, though.
