From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/2] OMAP3 PM: move omap3 sleep to ddr
Date: Fri, 19 Nov 2010 08:09:24 -0800
Message-ID: <20101119160924.GR9264@atomide.com>
References: <1290091906-32539-1-git-send-email-j-pihet@ti.com>
 <1290091906-32539-2-git-send-email-j-pihet@ti.com>
 <d2e0f972ca73d80e4929b605a9c2475f@mail.gmail.com>
 <87tyjey6h3.fsf@deeprootsystems.com>
 <4CE55A88.6010300@ti.com>
 <20101118175215.GE9264@atomide.com>
 <AANLkTi=bhULQsXhnN9ugDm7k=2P4E7-SvXEnx06pBwmu@mail.gmail.com>
 <20101118182752.GI9264@atomide.com>
 <AANLkTi=m1MXATmUzXNxbggoUS01AbyeGZm9WMgWUqdNo@mail.gmail.com>
 <AANLkTikztB6aSir83P4odPznmvXGvq0uzYhRN2UWC1Dr@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:46309 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753925Ab0KSQJj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 19 Nov 2010 11:09:39 -0500
Content-Disposition: inline
In-Reply-To: <AANLkTikztB6aSir83P4odPznmvXGvq0uzYhRN2UWC1Dr@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jean Pihet <jean.pihet@newoldbits.com>
Cc: Nishanth Menon <nm@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, linux-omap@vger.kernel.org, Vishwanath Sripathy <vishwanath.bs@ti.com>, Jean Pihet-XID <j-pihet@ti.com>

* Jean Pihet <jean.pihet@newoldbits.com> [101119 07:27]:
> HI Tony,
> 
> On Thu, Nov 18, 2010 at 7:34 PM, Jean Pihet <jean.pihet@newoldbits.com> wrote:
> > On Thu, Nov 18, 2010 at 7:27 PM, Tony Lindgren <tony@atomide.com> wrote:
> >> * Jean Pihet <jean.pihet@newoldbits.com> [101118 10:06]:
> >>> On Thu, Nov 18, 2010 at 6:52 PM, Tony Lindgren <tony@atomide.com> wrote:
> >>>
> >>> About the DPLL lock:
> >>> 1) wait_sdrc_ok is only called when back from the non-OFF modes,
> >>> 2) I checked that when running wait_sdrc_ok the CORE is already out of
> >>> idle and the DPLL is already locked. Note: l-o code has no support for
> >>> the voltages OFF and the external clocks OFF.
> >>>
> >>> What to conclude from 1) and 2)? In my test setup ot looks like
> >>> wait_sdrc_ok is of no use, but I agree this a premature conclusion.
> >>
> >> Yeah we should figure out in which cases wait_sdrc_ok is needed.
> >>
> >> BTW, are you sure you're hitting core idle in your tests?
> > Yes it is OK from the console messages and the counters values in
> > /debug/pm_debug/count.
> >
> > Let me confirm asap with the PRCM registers dump.
> 
> Here is what I experimented:
> 1) added a cache flush (v7_flush_kern_cache_all) just before WFI, in all cases,
> 2) checked the real state entered in low power mode from the console
> messages, the output of /debug/pm_debug/count and PRCM registers dump
> 
> 2) is OK, which means that the RET and OFF modes are correctly hit.
> 
> Can I conclude from 1) that the wake-up code is not running from the
> cache in RETention?

Sounds pretty safe to me then, thanks for testing. Now we just have
to find out in which cases wait_sdrc_ok is needed..

Tony
