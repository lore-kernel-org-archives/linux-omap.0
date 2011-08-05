From: mark gross <markgross@thegnar.org>
Subject: Re: [linux-pm] [PATCH 02/11] PM: extend PM QoS with per-device
 wake-up constraints
Date: Fri, 5 Aug 2011 08:29:42 -0700
Message-ID: <20110805152942.GB27632@gvim.org>
References: <1309446685-17502-1-git-send-email-j-pihet@ti.com>
 <201108030016.18174.rjw@sisk.pl>
 <20110804132426.GB14921@sirena.org.uk>
 <201108042115.30983.rjw@sisk.pl>
Reply-To: markgross@thegnar.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:51865 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753643Ab1HEP3s (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Aug 2011 11:29:48 -0400
Received: by gya6 with SMTP id 6so228954gya.19
        for <linux-omap@vger.kernel.org>; Fri, 05 Aug 2011 08:29:48 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <201108042115.30983.rjw@sisk.pl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, linux-omap@vger.kernel.org, Jean Pihet <j-pihet@ti.com>, markgross@thegnar.org

On Thu, Aug 04, 2011 at 09:15:30PM +0200, Rafael J. Wysocki wrote:
> On Thursday, August 04, 2011, Mark Brown wrote:
> > On Wed, Aug 03, 2011 at 12:16:17AM +0200, Rafael J. Wysocki wrote:
> > > On Tuesday, August 02, 2011, Kevin Hilman wrote:
> > 
> > > > I disagree and think that both are quite realistic (mainly because they
> > > > exist today, albiet mostly out of tree because no generic QoS framework
> > > > exist.  e.g. on OMAP, we have OMAP-specific *kernel* APIs for requesting
> > > > per-device wakeup latencies, and drivers and frameworks are using them.)
> > > 
> > > I'm sure there are frameworks using such things.  I'm also sure there
> > > are frameworks that don't.  BTW, the "we have it out of the tree" argument is
> > > not very useful, so I'd appreciate it if you didn't use it.
> > 
> > It's useful to know if people have tried things; it doesn't mean it's
> > going to be OK for mainline but it is a data point.
> > 
> > > > In this case, the video framework (V4L2) might not want any knobs
> > > > exposed to userspace because userspace simply doesn't have the knowledge
> > > > to set appropriate constraints.  I'm less familiar with audio, but I
> > > > believe audio would be similar (sample rate, number of channels, mixing
> > > > with other concurrent audio streams, etc. etc. are all known by the
> > > > kernel-side code.)
> > 
> > Yeah, that sort of stuff and also data like wakeup latencies required to
> > service interrupts.
> > 
> > > I still don't understand what's wrong with allowing user space to _add_
> > > requirements.  The will only override the drivers' or frameworks' requirements
> > > if they are stronger, so the functionality shouldn't be hurt.  They may cause
> > > some more energy to be used, but if user space wants that, it's pretty much
> > > fine by me.
> > 
> > On the one hand that's true.  On the other hand that just seems like
> > going down a bad road where we have drivers that only work when run with
> > a magic userspace that may or may not be published which is just going
> > to make people miserable.  I'm not sure there are many people who would
> > choose to use more power without wanting some functional change so
> > presumably any users would be seeking to work around some kernel problem
> > and adding the user interface seems to be saying that this is OK,
> > expected and a natural part of power optimization.
> 
> First off, we're doing this already (user space can block runtime PM, for
> one example, because there are systems where runtime PM doesn't work
> although it works on other systems with analogous hardware and pretty
> much the same set of drivers).
> 
> Second, I think there are valid use cases in which user space _really_ knows
> better than the kernel.  I'm opposed to the idea that users shouldn't be given
> control of their systems, because they may not know what they're doing.
>
Ok, I can see the point.  The challenge is how do we expose ABI's and
abstractions that result in drivers and PM implementations that are
somewhat portable between ISA's and platforms?  Simply exporting the low
level knobs of whatever drivers are loaded into memory, if used in user
mode, could result in a tight coupling or even a reverse dependency on a
proper user mode for the kernel to do the right things.

I'm sensitive to becoming blocked on doing kernel a update just because
we can't update the user mode code at the same time.  Its quite
annoying.

IMO to make it easy reuse TI SoC drivers in Intel SoC's (and
visa-versa) I would rather have these low level PM-QoS constraint
details abstracted in some sane and consistent way.  Through subsystem
API's if possible or, at a bus level if we must. 


--mark
Ps I also am worried I'm over thinking about this an Rafael may be right
and we would be better off just exposing the abstractions of "latency"
and "throughput" uniformly and focus more on the missing bus and
subsystem level governors that need to interpret and coordinate the qos
requests.
