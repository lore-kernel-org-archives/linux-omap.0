From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [linux-pm] [PATCH 02/11] PM: extend PM QoS with per-device wake-up constraints
Date: Sat, 20 Aug 2011 18:51:42 +0200
Message-ID: <201108201851.42839.rjw@sisk.pl>
References: <1309446685-17502-1-git-send-email-j-pihet@ti.com> <201108201135.58886.rjw@sisk.pl> <20110820103121.GA21457@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:54615 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753368Ab1HTQt6 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 20 Aug 2011 12:49:58 -0400
In-Reply-To: <20110820103121.GA21457@opensource.wolfsonmicro.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Linux PM mailing list <linux-pm@lists.linux-foundation.org>, linux-omap@vger.kernel.org, Jean Pihet <j-pihet@ti.com>, markgross@thegnar.org

On Saturday, August 20, 2011, Mark Brown wrote:
> On Sat, Aug 20, 2011 at 11:35:58AM +0200, Rafael J. Wysocki wrote:
> 
> > I'm not sure what you mean by "exposing per-device wakeup latency constraints
> > to user space".  I simply thought it might be useful to allow user space to
> > add and remove those, in analogy to what it can do with the currently available
> > PM QoS constraints.
> 
> I linked to the mails from Kevin...  To be honest I'm rather surprised
> this stuff is getting exposed directly to userspace with write support.
> 
> > My point is that this won't prevent kernel subsystems from adding their
> > own PM QoS constraints to devices and the constraints added by user space
> > will only have effect if they make the devices stay active for longer
> > times.  In consequence, they may only increase the energy usage of the system
> > and shouldn't affect functionality.
> 
> Well, clearly that's not the only use - demand for increased energy
> consumption by itself from users is generally quite low :)
> 
> > The reason why I think this may be useful is that I can readily imagine
> > scenarios in which user space (think a distribution or system vendor) will
> > want to do something that hasn't been anticipated by kernel developers
> > and the ability to add per-device PM QoS constraints will allow it to do that
> 
> Coming at this from the embedded perspective modifying the kernel just
> isn't an issue.  It's quite depressing in other cases too but some of
> the circumstances you mentioned in previous messages are sensible do
> make sense to me.  It does seem like this is a system specific problem
> which we should be able to enable as part of the support for those
> systems.

I don't think that's platform-specific in general.  For example, there are
devices that don't really belong to any media-streaming-alike framework
and we may (and probably will) want to use PM QoS with them, because they
may be included in PM domains and influence power management of other
devices.  Think of a serial console.

> > without modifying the kernel.  Also, it will help to test and debug new drivers
> > and subsystems.
> 
> If it were a debugfs facility I'd not be concerned.

If that's going to be per-device, it really is much easier to put it into
sysfs (we already have per-device PM debug interfaces in there).  It may
depend on CONFIG_PM_ADVANCED_DEBUG or something like this, though, at least
to start with.

> > I don't want to prevent kernel subsystems from using their own interfaces to
> > acquire user-level input that translates into PM QoS constraints.  I simply
> > think it won't _hurt_ to provide user space with an additional level of
> > control over per-device PM QoS constraints.
> 
> My experience has been that once you start providing an interface people
> will find it, start using it and it takes a lot of work to convince them
> that they ought to do something better.  This is totally reasonable from
> when you look at things from their point of view, especially people who
> aren't used to being able to improve anything except their own driver.

There are ways to make people do right things. :-)

Anyway, if an interface is provided, people are free to use it and it
kind of is their problem if they do that for unreasonable things.  That
might be an issue for us if we were to remove that interface going forward,
but I'm not sure if that's going to ever happen.

> > > I'm additionally concerned that if we expose this stuff directly to userspace
> > > that's an open invitation to driver authors to not even bother trying to make
> > > the kernel figure this stuff out by itself and to instead tie the system
> > > together with magic userspace.
> 
> > As I said, I don't think we can prevent that from happening anyway.
> > Worst case people will add strange interfaces to drivers making them
> > incompatible with anything except for their crazy user space.
> 
> That's not really a problem - if people are adding their own crazy
> interfaces it's clear that they've done that.  It'll show up as a red
> flag to anyone looking at their stuff and this will create pressure on
> them to fix their code or at least do a better job for the next thing.
> 
> The goal isn't to tie people's hands to stop them doing silly things,
> it's to make it clear that that is what they're doing.

The same applies to using kernel interfaces.  If someone uses a sane
interface for doing crazy stuff, that's their problem and should show
up as a red flag just as well.

Thanks,
Rafael
