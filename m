From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [linux-pm] calling runtime PM from system PM methods
Date: Fri, 10 Jun 2011 19:54:58 +0100
Message-ID: <20110610185458.GU26436@opensource.wolfsonmicro.com>
References: <87hb80546c.fsf@ti.com>
 <Pine.LNX.4.44L0.1106090945490.2081-100000@iolanthe.rowland.org>
 <20110610143657.GF26441@sirena.org.uk>
 <201106102049.03777.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:45028 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S932086Ab1FJSzB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 10 Jun 2011 14:55:01 -0400
Content-Disposition: inline
In-Reply-To: <201106102049.03777.rjw@sisk.pl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-pm@lists.linux-foundation.org, Alan Stern <stern@rowland.harvard.edu>, linux-omap@vger.kernel.org

On Fri, Jun 10, 2011 at 08:49:03PM +0200, Rafael J. Wysocki wrote:
> On Friday, June 10, 2011, Mark Brown wrote:

> > It seems like everyone's agreeing with each other here - from the user
> > side the request seems to be largely for core infastructure like
> > UNIVERSAL_DEV_PM_OPS() (which I'm not sure is a good idea any more given
> > that it doesn't do anything to handle the runtime/system interaction?).

> I'm not sure what you mean here.  First, UNIVERSAL_DEV_PM_OPS() actually
> does what it says, defines a set of operations to use for system suspend,
> hibernation and runtime PM all the same.

Right, but in the light of what you guys are saying about the
interactions between runtime suspend and resume I'm no longer clear that
that is actually sane for something which does use runtime PM, and of
course if a driver wants to support the wake configuration interface
then this might also fall out of the window.

> The Kevin's point originally was that it might be desirable to do things
> like calling pm_runtime_suspend() from a driver's (system) .suspend()
> callback, if I understood it correctly, and the answer was that it wasn't
> the right thing to do (for reasons given elsewhere in the thread).

Yeah, I think it is too.

> Your point seems to be that simple drivers should not be required to
> define separate callback routines, for example, for system suspend and
> runtime PM.  However, they aren't required to do so, they can point
> all of their "suspend" callback pointers to the same routine, which is
> what the UNIVERSAL_DEV_PM_OPS() macro does.

So that's definitely safe?  I guess this partly comes back to the thing
I'm saying about how I'm finding all this stuff difficult to reason
about, every time I see such discussion I get confused about needing to
worry about it or not.
