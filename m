From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [linux-pm] [PATCH 02/11] PM: extend PM QoS with per-device wake-up constraints
Date: Fri, 5 Aug 2011 21:37:36 +0200
Message-ID: <201108052137.37011.rjw@sisk.pl>
References: <1309446685-17502-1-git-send-email-j-pihet@ti.com> <201108042115.30983.rjw@sisk.pl> <20110805161147.GA3438@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:50319 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755440Ab1HETgJ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 5 Aug 2011 15:36:09 -0400
In-Reply-To: <20110805161147.GA3438@opensource.wolfsonmicro.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Kevin Hilman <khilman@ti.com>, markgross@thegnar.org, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, linux-omap@vger.kernel.org, Jean Pihet <j-pihet@ti.com>

On Friday, August 05, 2011, Mark Brown wrote:
> On Thu, Aug 04, 2011 at 09:15:30PM +0200, Rafael J. Wysocki wrote:
> > On Thursday, August 04, 2011, Mark Brown wrote:
> 
> > > On the one hand that's true.  On the other hand that just seems like
> > > going down a bad road where we have drivers that only work when run with
> > > a magic userspace that may or may not be published which is just going
> 
> > First off, we're doing this already (user space can block runtime PM, for
> > one example, because there are systems where runtime PM doesn't work
> > although it works on other systems with analogous hardware and pretty
> > much the same set of drivers).
> 
> Yeah, I've never been terribly convinced about that and for the things
> that drivers need to manualy implement (like wake configuration) it's
> widely ignored.
> 
> > Second, I think there are valid use cases in which user space _really_ knows
> > better than the kernel.  I'm opposed to the idea that users shouldn't be given
> > control of their systems, because they may not know what they're doing.
> 
> Do you have any examples of this that aren't better expressed in device
> specific terms?

I'm not sure what you mean exactly, but if you take two PC-like systems
with similar hardware configurations, but different BIOS-es and motherboard
layouts, it's very likely that on one of them PCI PME won't be routed
correctly, for example.  In that case the kernel has no way to figure out
that that system is broken, the problem can only be worked around from user
space by diabling runtime PM on the affected PCI devices.  I expect similar
problems to appear for the PM QoS settings.

> It's not that users don't know what they're doing, it's
> that working around system integration and stability issues in userspace
> isn't really progressing things well or helping with maintainability.

No, it's not, but sometimes we simply don't have the choice.  Besides,
in the particular case of PM QoS, the constraints set by user space will
simply be added to the constraints set by kernel subsystems.  Thus they
won't prevent any kernel subsystem from specifying its own constraints,
but they will give user space the option to override the constraints
originating from the kernel.

> Generally if the user has sufficient access to be able to do anything
> with this stuff they've got just as much access to the kernel as to
> userspace.

Do you mean they may rebuild the kernel?  That isn't always possible.

Thanks,
Rafael
