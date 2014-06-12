From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH V2 03/19] irqchip: crossbar: Skip some irqs from getting
 mapped to crossbar
Date: Thu, 12 Jun 2014 06:57:15 -0700
Message-ID: <20140612135715.GE17845@atomide.com>
References: <1402574007-13987-1-git-send-email-r.sricharan@ti.com>
 <1402574007-13987-4-git-send-email-r.sricharan@ti.com>
 <20140612125134.GS8664@titan.lakedaemon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:57540 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755855AbaFLN5U (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Jun 2014 09:57:20 -0400
Content-Disposition: inline
In-Reply-To: <20140612125134.GS8664@titan.lakedaemon.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jason Cooper <jason@lakedaemon.net>
Cc: Sricharan R <r.sricharan@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, santosh.shilimkar@ti.com, nm@ti.com, rnayak@ti.com, linux@arm.linux.org.uk, tglx@linutronix.de

* Jason Cooper <jason@lakedaemon.net> [140612 05:52]:
> On Thu, Jun 12, 2014 at 05:23:11PM +0530, Sricharan R wrote:
> > From: Nishanth Menon <nm@ti.com>
> > 
> > When, in the system due to varied reasons, interrupts might be unusable
> > due to hardware behavior, but register maps do exist, then those interrupts
> > should be skipped while mapping irq to crossbars.
> > 
> > Signed-off-by: Nishanth Menon <nm@ti.com>
> > Signed-off-by: Sricharan R <r.sricharan@ti.com>
> > Signed-off-by: Tony Lindgren <tony@atomide.com>
> 
> Tony, have you applied these somewhere already?

I think some of these I had applied into a branch ready for
merging but then it was discovered that further changes
were needed and the branch was dropped.

Sricharan, please remove my Signed-off-by from this series.
If I end up applying it for merging my scripts will add it
automatically.

Regards,

Tony
