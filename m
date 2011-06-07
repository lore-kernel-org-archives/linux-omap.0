From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [linux-pm] calling runtime PM from system PM methods
Date: Tue, 7 Jun 2011 09:55:11 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1106070951210.1972-100000@iolanthe.rowland.org>
References: <87zkluwqab.fsf@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:46259 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753767Ab1FGNzL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 7 Jun 2011 09:55:11 -0400
In-Reply-To: <87zkluwqab.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, linux-omap@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Paul Walmsley <paul@pwsan.com>

On Mon, 6 Jun 2011, Kevin Hilman wrote:

> "Rafael J. Wysocki" <rjw@sisk.pl> writes:
> 
> [..]
> 
> > While it is tempting to try to get away with only two PM callbacks per
> > driver instead of four (or even more), it generally is not doable, simply
> > because driver callbacks are not executed directly by the core.
> >
> > The only way to address the problem of code duplication between .suspend()
> > and .runtime_suspend() callbacks (and analogously for resume) I see at the
> > moment is to make those callbacks execute common routines.
> 
> Makes sense if the "common routines" are in the driver.  The problem
> arises when the common routines are not actually in the driver, but are
> instead at the subsystem (or in this case, device power domain) level.

Why should that be a problem?  System suspend also invokes the 
subsystem and power domain methods.

> Considering the OMAP I2C driver, it doesn't have (or need) runtime PM
> callbacks.  It does runtime PM get/put per-xfer, and has no context to
> save/restore, so it needs no runtime PM callbacks, or no special PM code
> other than runtime PM get/put calls.  The device power domain level code
> is managing the device clocks, power states, etc..
> 
> So what the system suspend needs to do is something like:
> 
> 1. block any new xfers from starting
> 2. wait for any outstanding xfers
> 3. if device is already runtime suspended
>     - nothing to do
> 4. trigger idle transition (at device power domain level)

1 - 2 should be handled at the device level, whereas 3 - 4 are handled
at the power domain level.  Those are separate callbacks during system
suspend.

> If runtime PM has not been disabled from userspace, it should always end
> at step 3, since the last xfer will always trigger a runtime suspend.
> 
> However, if runtime PM has been disabled from
> userspace/pm_runtime_forbid(), we need some way to do step 4.  It's this
> last 'trigger' step that I'm trying to figure out how a clean way of
> implementing, particularily for drivers with no runtime PM callbacks.

You're too hung-up on runtime PM.  Forget about that and concentrate on
system PM instead.  Power domains have system-PM callbacks as well as
runtime-PM callbacks; use them to do what you want.

Alan Stern

