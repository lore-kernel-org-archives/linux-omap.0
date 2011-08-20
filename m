From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [linux-pm] [PATCH 02/11] PM: extend PM QoS with per-device
 wake-up constraints
Date: Sat, 20 Aug 2011 18:22:38 +0100
Message-ID: <20110820172237.GB27040@opensource.wolfsonmicro.com>
References: <1309446685-17502-1-git-send-email-j-pihet@ti.com>
 <201108201135.58886.rjw@sisk.pl>
 <20110820103121.GA21457@opensource.wolfsonmicro.com>
 <201108201851.42839.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:53201 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754093Ab1HTRWl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Sat, 20 Aug 2011 13:22:41 -0400
Content-Disposition: inline
In-Reply-To: <201108201851.42839.rjw@sisk.pl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Linux PM mailing list <linux-pm@lists.linux-foundation.org>, linux-omap@vger.kernel.org, Jean Pihet <j-pihet@ti.com>, markgross@thegnar.org

On Sat, Aug 20, 2011 at 06:51:42PM +0200, Rafael J. Wysocki wrote:
> On Saturday, August 20, 2011, Mark Brown wrote:

> > Coming at this from the embedded perspective modifying the kernel just
> > isn't an issue.  It's quite depressing in other cases too but some of
> > the circumstances you mentioned in previous messages are sensible do
> > make sense to me.  It does seem like this is a system specific problem
> > which we should be able to enable as part of the support for those
> > systems.

> I don't think that's platform-specific in general.  For example, there are
> devices that don't really belong to any media-streaming-alike framework
> and we may (and probably will) want to use PM QoS with them, because they
> may be included in PM domains and influence power management of other
> devices.  Think of a serial console.

Using PM QoS doesn't seem platform specific of course.  Having userspace
need to go in and do per-device overrides in order to get things working
does.

> > > without modifying the kernel.  Also, it will help to test and debug new drivers
> > > and subsystems.

> > If it were a debugfs facility I'd not be concerned.

> If that's going to be per-device, it really is much easier to put it into
> sysfs (we already have per-device PM debug interfaces in there).  It may
> depend on CONFIG_PM_ADVANCED_DEBUG or something like this, though, at least
> to start with.

Yeah, the debugfs device attachment stuff is slightly annoying but it's
fairly straightforward to create an appropriate heirachy - there's
several subsystems doing that sort of stuff by using dev_name().

> > That's not really a problem - if people are adding their own crazy
> > interfaces it's clear that they've done that.  It'll show up as a red
> > flag to anyone looking at their stuff and this will create pressure on
> > them to fix their code or at least do a better job for the next thing.

> > The goal isn't to tie people's hands to stop them doing silly things,
> > it's to make it clear that that is what they're doing.

> The same applies to using kernel interfaces.  If someone uses a sane
> interface for doing crazy stuff, that's their problem and should show
> up as a red flag just as well.

The big problem I'm seeing here is that there's nothing about having
userspace do all the knob twiddling that looks crazy just from looking
at the system.  The controls are there and in the standard kernel
interface, it's not like there's any ABIs or large piles of in kernel
code that need to be added (if anything the in kernel code should look
simpler as there's less going on).
