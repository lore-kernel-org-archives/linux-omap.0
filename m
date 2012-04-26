From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/3] ARM: omap2+: set IRQCHIP_SKIP_SET_WAKE for INTC
 interrupts.
Date: Thu, 26 Apr 2012 13:25:40 -0700
Message-ID: <20120426202539.GA3739@atomide.com>
References: <20120425025637.7832.14013.stgit@notabene.brown>
 <20120425030524.7832.52047.stgit@notabene.brown>
 <87sjfq9ryv.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:34007 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751439Ab2DZUZz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 26 Apr 2012 16:25:55 -0400
Content-Disposition: inline
In-Reply-To: <87sjfq9ryv.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: NeilBrown <neilb@suse.de>, Russell King <linux@arm.linux.org.uk>, Samuel Ortiz <sameo@linux.intel.com>, Thomas Gleixner <tglx@linutronix.de>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org

* Kevin Hilman <khilman@ti.com> [120426 13:11]:
> NeilBrown <neilb@suse.de> writes:
> 
> > All interrupts can wake-from-sleep (I think) so it should be
> > permissible to call enable_irq_wake().  Setting this flag allows that.
> >
> > It is needed because without this, an interrupt which is delivered
> > during late suspend will get ignored but will not cause suspend to
> > abort.
> > If enable_irq_wake() is called and succeeds, check_wakuep_irqs()
> > will abort the suspend if the interrupt has fired.
> >
> > Signed-off-by: NeilBrown <neilb@suse.de>
> 
> Acked-by: Kevin Hilman <khilman@ti.com>
> 
> Tony, should I queue this one in my OMAP PM features for v3.5 branch?
> or do you want to take it?

You can take it since is's PM related.

Tony
