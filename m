From: Jason Cooper <jason@lakedaemon.net>
Subject: Re: [PATCH V2 03/19] irqchip: crossbar: Skip some irqs from
 getting mapped to crossbar
Date: Thu, 12 Jun 2014 10:05:08 -0400
Message-ID: <20140612140508.GC8664@titan.lakedaemon.net>
References: <1402574007-13987-1-git-send-email-r.sricharan@ti.com>
 <1402574007-13987-4-git-send-email-r.sricharan@ti.com>
 <20140612125134.GS8664@titan.lakedaemon.net>
 <20140612135715.GE17845@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:16818 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752823AbaFLOFX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Jun 2014 10:05:23 -0400
Content-Disposition: inline
In-Reply-To: <20140612135715.GE17845@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Sricharan R <r.sricharan@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, santosh.shilimkar@ti.com, nm@ti.com, rnayak@ti.com, linux@arm.linux.org.uk, tglx@linutronix.de

On Thu, Jun 12, 2014 at 06:57:15AM -0700, Tony Lindgren wrote:
> * Jason Cooper <jason@lakedaemon.net> [140612 05:52]:
> > On Thu, Jun 12, 2014 at 05:23:11PM +0530, Sricharan R wrote:
> > > From: Nishanth Menon <nm@ti.com>
> > > 
> > > When, in the system due to varied reasons, interrupts might be unusable
> > > due to hardware behavior, but register maps do exist, then those interrupts
> > > should be skipped while mapping irq to crossbars.
> > > 
> > > Signed-off-by: Nishanth Menon <nm@ti.com>
> > > Signed-off-by: Sricharan R <r.sricharan@ti.com>
> > > Signed-off-by: Tony Lindgren <tony@atomide.com>
> > 
> > Tony, have you applied these somewhere already?
> 
> I think some of these I had applied into a branch ready for
> merging but then it was discovered that further changes
> were needed and the branch was dropped.

Ok.

> Sricharan, please remove my Signed-off-by from this series.
> If I end up applying it for merging my scripts will add it
> automatically.

Do you have other changes outside of irqchip depending on this series?
If so, I can set up a topic branch for you guys to base off of.
Otherwise, I'll just apply them to irqchip/core when they're ready.

Also, Sricharan, when you respin this, please clearly identify (in the
comment section) those patches that need to be flagged for stable.  It
would be helpful if they were the first patches in the series as well.

thx,

Jason.
