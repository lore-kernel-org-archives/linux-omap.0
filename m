From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [linux-pm] calling runtime PM from system PM methods
Date: Tue, 7 Jun 2011 23:32:30 +0200
Message-ID: <201106072332.30464.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.1106021010360.1913-100000@iolanthe.rowland.org> <201106062029.36389.rjw@sisk.pl> <87zkluwqab.fsf@ti.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:36177 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932319Ab1FGVbt (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 7 Jun 2011 17:31:49 -0400
In-Reply-To: <87zkluwqab.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Alan Stern <stern@rowland.harvard.edu>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, linux-omap@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Paul Walmsley <paul@pwsan.com>

On Tuesday, June 07, 2011, Kevin Hilman wrote:
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

As Alan said, I'm not sure why that is a problem, because device power
domain can (and most likely should) provide system suspend callbacks as well
as runtime PM callbacks.  Those callbacks can be designed to do whatever is
needed.

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
> 
> If runtime PM has not been disabled from userspace, it should always end
> at step 3, since the last xfer will always trigger a runtime suspend.
> 
> However, if runtime PM has been disabled from
> userspace/pm_runtime_forbid(), we need some way to do step 4.

Well, it looks like my previous message wasn't clear enough. :-)

Whether or not user space has disabled runtime PM _doesn't_ _matter_ for
system suspend, because _you_ _can't_ call pm_runtime_suspend(), or
pm_runtime_put_sunc(), from a driver's .suspend() callback _anyway_.
The reason is that doing that would cause the subsystem's (or power
domain's in this case) .runtime_suspend() callback to be invoked and
that's incorrect.  Namely, it would require the subsystem (power domain)
to expect that its .runtime_suspend() would always be executed indirectly
as a result of calling its .suspend() (through the driver's callback)
and that expectation may or may not be met (depending on the driver's
design).

The appropriate way to handle system suspend is to provide subsystem
(or power domain) .suspend()/.resume() callbacks that will do whatever is
needed at the subsystem level and will call the corresponding driver
callbacks.  There is no need whatsoever to involve runtime PM into this
in any way.

> It's this last 'trigger' step that I'm trying to figure out how a clean way of
> implementing, particularily for drivers with no runtime PM callbacks.
> 
> Unless I'm missing something else, if runtime PM was not prevented via
> userspace/pm_runtime_forbid(), we would not need this last 'trigger'
> step.  That's why a solution where any pending runtime PM transitions
> would be allowed during system PM is the ideal solution (to me.)  It
> avoids having to call runtime PM methods from system PM all together.

Well, again.  There's nothing to avoid, because all the thing you'd like to do
is incorrect in the first place.

> The current OMAP I2C driver in mainline does this extra "trigger" step
> by directly calling the subsystem (bus) callbacks. (It's also missing
> the first two steps, which is a known bug and will be fixed once I
> figure out the rest of this problem.)
> 
> However, now that we have device power domains, I was planning to extend
> that to call device power domain callbacks first if they exist.  Since
> that was starting to duplicate callback precedence assumptions in the
> runtime PM core, I was thinking about ways to avoid that by simply using
> runtime PM directly, that's what got me to start this thread in the
> first place.
> 
> So, I see 2 ways forward
> 
> 1. Having some per-device option/flag that would allow pending runtime
>    PM transitions to happen during system PM, thus removing the need
>    for step 4 above.
> 
> 2. Decide the "right" way to trigger device power domain (or subsytem)
>    transitions from the driver.   Directly calling the subsystem
>    callbacks from the driver?   Any other options?

Yes, see above.

> I have a rather strong preference for the first one, but am realizing
> that I may be in the minority.  So what is the recommended solution for
> 2?

Well, let me repeat: you need to separate the system suspend handling from
runtime PM.  Each of them requires a different approach, because the goal
is really different in both cases (basically, runtime PM triggers when
the device is _known_ to be idle, while system suspend may trigger while
it's actually being used).

> P.S.  I'm glad you got to discuss this with Paul & Magnus at LinuxCon
> Japan.  I wish I could've been there too.

There is a good opportunity to discuss those things during the Linux
Plumbers Conference in September.  We are going to have a Linux PM
miniconference during that event which you are welcome to attend. :-)

> Hope your return trip went well and your internet is back working soon.

Yes, it did and the internet is already working, thanks!

Take care,
Rafael
