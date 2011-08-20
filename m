From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [linux-pm] [PATCH 02/11] PM: extend PM QoS with per-device wake-up constraints
Date: Sat, 20 Aug 2011 11:35:58 +0200
Message-ID: <201108201135.58886.rjw@sisk.pl>
References: <1309446685-17502-1-git-send-email-j-pihet@ti.com> <201108192242.20471.rjw@sisk.pl> <20110819231419.GA3981@sirena.org.uk>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:54288 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751761Ab1HTJeP (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 20 Aug 2011 05:34:15 -0400
In-Reply-To: <20110819231419.GA3981@sirena.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Linux PM mailing list <linux-pm@lists.linux-foundation.org>, linux-omap@vger.kernel.org, Jean Pihet <j-pihet@ti.com>, markgross@thegnar.org

On Saturday, August 20, 2011, Mark Brown wrote:
> On Fri, Aug 19, 2011 at 10:42:20PM +0200, Rafael J. Wysocki wrote:
> 
> > I really wouldn't like the discussion to go in circles.
> 
> > First, please tell me what in particular you are objecting to,
> > because I don't think that's any of the patches that have been
> > sent to the linux-pm list to date.
> 
> The original issue that Kevin raised and CCed me in on was the idea of
> exposing raw per-device wakeup latency constraints to userspace; it
> seems much better to expose user level requirements via subsystem
> interfaces and let the subsystem and driver translate these into actual
> wakeup latency constraints:
> 
>   https://lists.linux-foundation.org/pipermail/linux-pm/2011-August/032422.html
>   https://lists.linux-foundation.org/pipermail/linux-pm/2011-August/032428.html

OK, so let's clarify things.

I'm not sure what you mean by "exposing per-device wakeup latency constraints
to user space".  I simply thought it might be useful to allow user space to
add and remove those, in analogy to what it can do with the currently available
PM QoS constraints.

My point is that this won't prevent kernel subsystems from adding their
own PM QoS constraints to devices and the constraints added by user space
will only have effect if they make the devices stay active for longer
times.  In consequence, they may only increase the energy usage of the system
and shouldn't affect functionality.

The reason why I think this may be useful is that I can readily imagine
scenarios in which user space (think a distribution or system vendor) will
want to do something that hasn't been anticipated by kernel developers
and the ability to add per-device PM QoS constraints will allow it to do that
without modifying the kernel.  Also, it will help to test and debug new drivers
and subsystems.

I don't want to prevent kernel subsystems from using their own interfaces to
acquire user-level input that translates into PM QoS constraints.  I simply
think it won't _hurt_ to provide user space with an additional level of
control over per-device PM QoS constraints.

> This is much easier for users as it translates into something they're
> actually doing (and in most cases the driver can make it Just Work) and
> it means that off the shelf applications will end up tuning the system
> appropriately by themselves.

The _end_ users really don't care.  They'll use whatever settings the user
interface exposes to them.  Moreover, even if there is an interface for
user space to add per-device PM QoS constraints, that doesn't mean the
user space is _required_ to use it.  If it doesn't, everything will work
as you describe.

> I'm additionally concerned that if we expose this stuff directly to userspace
> that's an open invitation to driver authors to not even bother trying to make
> the kernel figure this stuff out by itself and to instead tie the system
> together with magic userspace.

As I said, I don't think we can prevent that from happening anyway.
Worst case people will add strange interfaces to drivers making them
incompatible with anything except for their crazy user space.

Thanks,
Rafael
