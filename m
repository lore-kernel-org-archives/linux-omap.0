From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [linux-pm] [RFC PATCH] PM: Introduce generic DVFS framework with
 device-specific OPPs
Date: Wed, 27 Apr 2011 21:00:48 +0200 (CEST)
Message-ID: <alpine.LFD.2.02.1104272031320.3323@ionos>
References: <1303807401-16350-1-git-send-email-myungjoo.ham@samsung.com> <201104261309.47629.rjw@sisk.pl> <BANLkTi=tBYT4NpayaoAA1+f1uaj9QyT+Yw@mail.gmail.com> <BANLkTi=GVZnZuXmbK54Swi8Nv9ZZGhZcNw@mail.gmail.com>
 <BANLkTin4rrniJpOheLH=JE0jq7vFpdDbrA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-75676391-1303930850=:3323"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:40056 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751728Ab1D0TBF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 27 Apr 2011 15:01:05 -0400
In-Reply-To: <BANLkTin4rrniJpOheLH=JE0jq7vFpdDbrA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Menon, Nishanth" <nm@ti.com>
Cc: Colin Cross <ccross@google.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, Len Brown <len.brown@intel.com>, Kevin Hilman <khilman@deeprootsystems.com>, Greg Kroah-Hartman <gregkh@suse.de>, Kyungmin Park <kyungmin.park@samsung.com>, linux-pm@lists.linux-foundation.org, linux-omap <linux-omap@vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-75676391-1303930850=:3323
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT

On Wed, 27 Apr 2011, Menon, Nishanth wrote:
> On Wed, Apr 27, 2011 at 12:49, Colin Cross <ccross@google.com> wrote:
> > I proposed in a different thread on LKML that DVFS be handled within
> > the generic clock implementation.  Platforms would register a
> > regulator and a table of voltages for each struct clock that required
> > DVFS, and the voltages would be changed on normal clk_* requests.
> > This maintains compatibility with existing clk_* calls.
> 
> It is upto SoC frameworks to implement the transitions. E.g. lets look
> at scalability: How'd the mechanism proposed work with temperature
> variances: Example: I dont want to hit 1.5GHz if temp >70C - wont it
> be an SoC specific hack I'd need to introduce?

Why is limiting the max core frequency depending on temperature a SoC
specific problem ?

Everyone wants to do that. x86 does it in hardware / SMM, other
architectures want the kernel to take care of it.

So the decision is simple. Something wants to set core freq to 1.5
GHz, so it calls clk_set_rate() and there we consult the DVFS code
first to validate that setting. If it can be set, fine, then DVFS will
set the voltages _before_ we change the frequency or it will simply
veto the change because one of the preliminaries for such a change is
not given.

Please stop thinking that your SoC is sooo special. It's NOT.

The HW concepts are quite similar all over the place, they are just
named differently and use different IP blocks with slightly different
functionality, but the problems are not unique to a particular SoC at
all.

> All OPP framework does is store that maps, and leaves it to users to
> choose regulators, clock framework variances, SoC temperature sensors
> or what ever mechanisms they choose to allow through a transition.

That's how it's implemented, but that does not say that the design is
correct and usable for more than the usecase it was modeled after.
 
We are looking into a common clock framework, which abstracts out the
duplicated functionality of the various implementations and reduces
them to the real thing: hardware drivers. So we really need to look
into that DVFS problem as well, simply because it is tightly coupled
and not a complete separate entity.

And looking at the struct clk disaster we really don't want another
incarnation in terms of DVFS where we end up with the same decision
functions in various SoCs over and over.

Thanks,

	tglx
--8323328-75676391-1303930850=:3323--
