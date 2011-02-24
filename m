From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] OMAP2+: clocksource: fix crash on boot when
 !CONFIG_OMAP_32K_TIMER
Date: Thu, 24 Feb 2011 13:13:29 -0800
Message-ID: <20110224211328.GK20560@atomide.com>
References: <alpine.DEB.2.00.1102221958190.22636@utopia.booyaka.com>
 <20110224202157.GG20560@atomide.com>
 <alpine.DEB.2.00.1102241330500.6198@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:13399 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755511Ab1BXVNd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 24 Feb 2011 16:13:33 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1102241330500.6198@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Paul Walmsley <paul@pwsan.com> [110224 12:29]:
> On Thu, 24 Feb 2011, Tony Lindgren wrote:
> 
> > * Paul Walmsley <paul@pwsan.com> [110222 18:58]:
> > > 
> > > OMAP2+ kernels built without CONFIG_OMAP_32K_TIMER crash on boot after the
> > > 2.6.38 sched_clock changes:
> > > 
> > > [    0.000000] OMAP clockevent source: GPTIMER1 at 13000000 Hz
> > > [    0.000000] Unable to handle kernel NULL pointer dereference at virtual address 00000000
> > > [    0.000000] pgd = c0004000
> > > [    0.000000] [00000000] *pgd=00000000
> > > [    0.000000] Internal error: Oops: 80000005 [#1] SMP
> > > [    0.000000] last sysfs file:
> > > [    0.000000] Modules linked in:
> > > [    0.000000] CPU: 0    Not tainted  (2.6.38-rc5-00057-g04aa67d #152)
> > > [    0.000000] PC is at 0x0
> > > [    0.000000] LR is at sched_clock_poll+0x2c/0x3c
> > > 
> > > Without CONFIG_OMAP_32K_TIMER, the kernel has an clockevent and
> > > clocksource resolution about three orders of magnitude higher than
> > > with CONFIG_OMAP_32K_TIMER set.  The tradeoff is that the lowest
> > > power consumption states are not available.
> > > 
> > > Fix by calling init_sched_clock() from the GPTIMER clocksource init code.
> > 
> > I'll queue this as a fix as it's a regression.
> 
> Sounds good, I've got one or two other -rc candidates.  Want me to build a 
> branch with this and the other two?

Well I already applied this one. But for the two others yes please.

Tony
