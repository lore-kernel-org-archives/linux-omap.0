From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [linux-pm] [PATCH 02/11] PM: extend PM QoS with per-device wake-up constraints
Date: Sat, 20 Aug 2011 21:18:33 +0200
Message-ID: <201108202118.33433.rjw@sisk.pl>
References: <1309446685-17502-1-git-send-email-j-pihet@ti.com> <201108201851.42839.rjw@sisk.pl> <20110820172237.GB27040@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:54763 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754718Ab1HTTQs (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 20 Aug 2011 15:16:48 -0400
In-Reply-To: <20110820172237.GB27040@opensource.wolfsonmicro.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Linux PM mailing list <linux-pm@lists.linux-foundation.org>, linux-omap@vger.kernel.org, Jean Pihet <j-pihet@ti.com>, markgross@thegnar.org

On Saturday, August 20, 2011, Mark Brown wrote:
> On Sat, Aug 20, 2011 at 06:51:42PM +0200, Rafael J. Wysocki wrote:
> > On Saturday, August 20, 2011, Mark Brown wrote:
> 
> > > Coming at this from the embedded perspective modifying the kernel just
> > > isn't an issue.  It's quite depressing in other cases too but some of
> > > the circumstances you mentioned in previous messages are sensible do
> > > make sense to me.  It does seem like this is a system specific problem
> > > which we should be able to enable as part of the support for those
> > > systems.
> 
> > I don't think that's platform-specific in general.  For example, there are
> > devices that don't really belong to any media-streaming-alike framework
> > and we may (and probably will) want to use PM QoS with them, because they
> > may be included in PM domains and influence power management of other
> > devices.  Think of a serial console.
> 
> Using PM QoS doesn't seem platform specific of course.  Having userspace
> need to go in and do per-device overrides in order to get things working
> does.
> 
> > > > without modifying the kernel.  Also, it will help to test and debug new drivers
> > > > and subsystems.
> 
> > > If it were a debugfs facility I'd not be concerned.
> 
> > If that's going to be per-device, it really is much easier to put it into
> > sysfs (we already have per-device PM debug interfaces in there).  It may
> > depend on CONFIG_PM_ADVANCED_DEBUG or something like this, though, at least
> > to start with.
> 
> Yeah, the debugfs device attachment stuff is slightly annoying but it's
> fairly straightforward to create an appropriate heirachy - there's
> several subsystems doing that sort of stuff by using dev_name().

I'm not a big fan of that, sorry.  Besides, as I said, we already have
debug PM interfaces in sysfs, so I don't see the reason not to add
another one.

> > > That's not really a problem - if people are adding their own crazy
> > > interfaces it's clear that they've done that.  It'll show up as a red
> > > flag to anyone looking at their stuff and this will create pressure on
> > > them to fix their code or at least do a better job for the next thing.
> 
> > > The goal isn't to tie people's hands to stop them doing silly things,
> > > it's to make it clear that that is what they're doing.
> 
> > The same applies to using kernel interfaces.  If someone uses a sane
> > interface for doing crazy stuff, that's their problem and should show
> > up as a red flag just as well.
> 
> The big problem I'm seeing here is that there's nothing about having
> userspace do all the knob twiddling that looks crazy just from looking
> at the system.  The controls are there and in the standard kernel
> interface, it's not like there's any ABIs or large piles of in kernel
> code that need to be added (if anything the in kernel code should look
> simpler as there's less going on).

Well, I'm kind of not seeing that as a big problem.  At least, this is not
a technical issue, but a social one.

Thanks,
Rafael
