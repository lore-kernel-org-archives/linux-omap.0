From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [linux-pm] [PATCH 02/11] PM: extend PM QoS with per-device wake-up constraints
Date: Thu, 4 Aug 2011 21:15:30 +0200
Message-ID: <201108042115.30983.rjw@sisk.pl>
References: <1309446685-17502-1-git-send-email-j-pihet@ti.com> <201108030016.18174.rjw@sisk.pl> <20110804132426.GB14921@sirena.org.uk>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:48250 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753912Ab1HDTOJ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 4 Aug 2011 15:14:09 -0400
In-Reply-To: <20110804132426.GB14921@sirena.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Kevin Hilman <khilman@ti.com>, markgross@thegnar.org, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, linux-omap@vger.kernel.org, Jean Pihet <j-pihet@ti.com>

On Thursday, August 04, 2011, Mark Brown wrote:
> On Wed, Aug 03, 2011 at 12:16:17AM +0200, Rafael J. Wysocki wrote:
> > On Tuesday, August 02, 2011, Kevin Hilman wrote:
> 
> > > I disagree and think that both are quite realistic (mainly because they
> > > exist today, albiet mostly out of tree because no generic QoS framework
> > > exist.  e.g. on OMAP, we have OMAP-specific *kernel* APIs for requesting
> > > per-device wakeup latencies, and drivers and frameworks are using them.)
> > 
> > I'm sure there are frameworks using such things.  I'm also sure there
> > are frameworks that don't.  BTW, the "we have it out of the tree" argument is
> > not very useful, so I'd appreciate it if you didn't use it.
> 
> It's useful to know if people have tried things; it doesn't mean it's
> going to be OK for mainline but it is a data point.
> 
> > > In this case, the video framework (V4L2) might not want any knobs
> > > exposed to userspace because userspace simply doesn't have the knowledge
> > > to set appropriate constraints.  I'm less familiar with audio, but I
> > > believe audio would be similar (sample rate, number of channels, mixing
> > > with other concurrent audio streams, etc. etc. are all known by the
> > > kernel-side code.)
> 
> Yeah, that sort of stuff and also data like wakeup latencies required to
> service interrupts.
> 
> > I still don't understand what's wrong with allowing user space to _add_
> > requirements.  The will only override the drivers' or frameworks' requirements
> > if they are stronger, so the functionality shouldn't be hurt.  They may cause
> > some more energy to be used, but if user space wants that, it's pretty much
> > fine by me.
> 
> On the one hand that's true.  On the other hand that just seems like
> going down a bad road where we have drivers that only work when run with
> a magic userspace that may or may not be published which is just going
> to make people miserable.  I'm not sure there are many people who would
> choose to use more power without wanting some functional change so
> presumably any users would be seeking to work around some kernel problem
> and adding the user interface seems to be saying that this is OK,
> expected and a natural part of power optimization.

First off, we're doing this already (user space can block runtime PM, for
one example, because there are systems where runtime PM doesn't work
although it works on other systems with analogous hardware and pretty
much the same set of drivers).

Second, I think there are valid use cases in which user space _really_ knows
better than the kernel.  I'm opposed to the idea that users shouldn't be given
control of their systems, because they may not know what they're doing.

Thanks,
Rafael
