From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/5] ARM: OMAP2/3: Remove OMAP2_32KSYNCT_BASE
Date: Thu, 28 May 2009 08:54:31 -0700
Message-ID: <20090528155431.GC32453@atomide.com>
References: <20090514231820.19331.65419.stgit@localhost> <20090514232306.19331.92192.stgit@localhost> <20090528152517.GB20736@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:60663 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754554AbZE1Pyl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 28 May 2009 11:54:41 -0400
Content-Disposition: inline
In-Reply-To: <20090528152517.GB20736@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org

* Russell King - ARM Linux <linux@arm.linux.org.uk> [090528 08:25]:
> On Thu, May 14, 2009 at 04:23:06PM -0700, Tony Lindgren wrote:
> > Use processor specific defines instead.
> > 
> > As an extra bonus, this patch fixes the problem of CONFIG_DEBUG_SPINLOCK
> > calling sched_clock before we have things initialized:
> 
> Hmm.  I don't think sched_clock peculiarities should be handed by the
> clock source implementation.
> 
> This is really a generic kernel bug: lots of ARM architecture sched_clock
> implementations can not be called before things like IO memory has been
> setup - and that's something that mainline people have been made aware
> of repeatedly, and they've fixed the problems when they've come up.

Yeah agreed.
 
> Moreover, the issue of using clocksources for sched_clock is being
> discussed on the main ARM lists, with the possibility of the generic
> kernel-wide sched_clock implementation being based upon clock sources.
> 
> Whether that changes anything with this patch, I'm not entirely sure.

The clocksource and sched_clock thing is a separate issue, this patch
is still needed to remove the conflicting defines.

Tony
