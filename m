From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 03/13] ARM: omap1: delete useless interrupt handler
Date: Thu, 12 May 2011 00:25:31 -0700
Message-ID: <20110512072531.GD31483@atomide.com>
References: <20110510072700.GA29869@n2100.arm.linux.org.uk>
 <E1QJhMf-0000yV-78@rmk-PC.arm.linux.org.uk>
 <87boza4t5n.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:51643 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750911Ab1ELHZt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 May 2011 03:25:49 -0400
Content-Disposition: inline
In-Reply-To: <87boza4t5n.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-arm-kernel@lists.infradead.org, John Stultz <johnstul@us.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, linux-omap@vger.kernel.org

* Kevin Hilman <khilman@ti.com> [110510 05:46]:
> Russell King - ARM Linux <linux@arm.linux.org.uk> writes:
> 
> > The OMAP1 clocksource interrupt handler just increments a variable
> > which otherwise isn't used, so this seems to be unnecessary.  Tony
> > Lindgren confirms, so lets remove it.
> >
> > Cc: Tony Lindgren <tony@atomide.com>
> > Cc: linux-omap@vger.kernel.org
> > Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> 
> Yes, this is left over legacy code from an earlier implementation.
> 
> Acked-by: Kevin Hilman <khilman@ti.com>

Acked-by: Tony Lindgren <tony@atomide.com>
