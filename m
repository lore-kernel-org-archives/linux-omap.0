From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [linux-pm] [RFC PATCH] PM: Introduce generic DVFS framework with
 device-specific OPPs
Date: Wed, 27 Apr 2011 21:26:11 +0200 (CEST)
Message-ID: <alpine.LFD.2.02.1104272104390.3323@ionos>
References: <1303807401-16350-1-git-send-email-myungjoo.ham@samsung.com> <201104261309.47629.rjw@sisk.pl> <BANLkTi=tBYT4NpayaoAA1+f1uaj9QyT+Yw@mail.gmail.com> <BANLkTi=GVZnZuXmbK54Swi8Nv9ZZGhZcNw@mail.gmail.com> <BANLkTin4rrniJpOheLH=JE0jq7vFpdDbrA@mail.gmail.com>
 <BANLkTi=WWASxk3Fz83324k40Lbq+ccAPeA@mail.gmail.com> <BANLkTikEtTDp3Cpj0D5z34wA0_G_DWwKFg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:54965 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751812Ab1D0T0X (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 27 Apr 2011 15:26:23 -0400
In-Reply-To: <BANLkTikEtTDp3Cpj0D5z34wA0_G_DWwKFg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Menon, Nishanth" <nm@ti.com>
Cc: Colin Cross <ccross@google.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, Len Brown <len.brown@intel.com>, Kevin Hilman <khilman@deeprootsystems.com>, Greg Kroah-Hartman <gregkh@suse.de>, Kyungmin Park <kyungmin.park@samsung.com>, linux-pm@lists.linux-foundation.org, linux-omap <linux-omap@vger.kernel.org>

On Wed, 27 Apr 2011, Menon, Nishanth wrote:

> OPP table is just a storage and retrieval mechanism, it is upto SoC
> frameworks to choose the most adequate of solutions - e.g. OMAP has
> omap_device, hwmod and a clock framework for more intricate control to
> work in conjunction with cpuidle frameworks as well.

Can you please stop thinking about OMAP for a minute?

A clock framework is nothing SoC specific. A framework is an
abstraction of common HW functionality, which implements general
functionality and relies on the HW specific part to configure it and
to provide access to the hardware itself.

clocks are ordered as trees in HW, simply because you cannot have a
clock consumer be driven by more than one active clock at the same
time. A clock consumer may select a different clock producer, but that
merily changes the tree structure nothing else. So why should every
SoC implement it's own (different buggy) version of tree handling and
call it framework?

Yes, I know you might argue that some devices need two clocks enabled
to be functional. That's correct, but coupling those clocks at the
framework level is the wrong thing to do. If a device needs both an
interface clock and a separate interconnect clock to work, then it
needs to enable both clocks and become a consumer of them.
 
> There is cross domain dependency which OMAP (yet to be pushed to
> mainline) has - example: when OMAP4's MPUs are at a certain OPP, L3
> (OMAP's SoC bus) needs to be at least a certain OPP - these are
> framework which may be very custom to OMAP itself.

Wrong again. That's not a framework when you hack SoC specific
decision functions into it. It's the OMAP internal hackery to make
stuff work, but that's far from a framework.

What you are describing is a restriction which can be expressed in
tables or rules which are fed into a general framework.

Look at generic irqs, generic timekeeping, generic clockevents and
tons of other real frameworks in the kernel. They abstract out
concepts and provide generic interfaces rather than claiming that the
problem is unique to a particular piece of silicon.

Forget OMAP implementation details for a while, sit back and look at
the big picture.

Thanks,

	tglx


