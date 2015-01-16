From: Tony Lindgren <tony@atomide.com>
Subject: Re: Regression with legacy IRQ numbers caused by 9a1091ef0017
Date: Fri, 16 Jan 2015 08:41:06 -0800
Message-ID: <20150116164105.GL18552@atomide.com>
References: <20150114221407.GS2419@atomide.com>
 <20150115105035.GU11502@n2100.arm.linux.org.uk>
 <20150115152838.GB18552@atomide.com>
 <20150115171924.GV11502@n2100.arm.linux.org.uk>
 <20150116162119.GK18552@atomide.com>
 <20150116163019.GW11502@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:16205 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752810AbbAPQov (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 Jan 2015 11:44:51 -0500
Content-Disposition: inline
In-Reply-To: <20150116163019.GW11502@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Yingjoe Chen <yingjoe.chen@mediatek.com>, Marc Zyngier <marc.zyngier@arm.com>, Jason Cooper <jason@lakedaemon.net>, Felipe Balbi <balbi@ti.com>, Thomas Gleixner <tglx@linutronix.de>

* Russell King - ARM Linux <linux@arm.linux.org.uk> [150116 08:33]:
> On Fri, Jan 16, 2015 at 08:21:20AM -0800, Tony Lindgren wrote:
> > * Russell King - ARM Linux <linux@arm.linux.org.uk> [150115 09:22]:
> > > On Thu, Jan 15, 2015 at 07:28:39AM -0800, Tony Lindgren wrote:
> > > > * Russell King - ARM Linux <linux@arm.linux.org.uk> [150115 02:53]:
> > > > > I don't think we've proven a link there.  While you're right that it
> > > > > causes the wrong interrupt to be claimed, I have two kernels here,
> > > > > both claim the same interrupt, one which is multi-platform and issues
> > > > > that strange warning, and one which targets only OMAP4 which doesn't.
> > > > > 
> > > > > There's something else going on which causes the bus errors which we
> > > > > haven't found.
> > > > 
> > > > I think it gets triggered if you enable PREEMPT.
> > > 
> > > That's something which we can try to prove... build running now with
> > > CONFIG_PREEMPT=y
> > 
> > Looks like you now have the omap_l3_noc error appear for sdp4430 in
> > your logs after enabling PREEMPT.
> > 
> > I guess that means case closed for this one?
> 
> I would still like to understand /why/ enabling preempt causes the error.
> Changing the preempt configuration really should not change what happens
> on the bus.  (Think about it.)  It's an indication that there is some
> other error present.

We have a wrong irq number caused by $subject. And the wrong irq
gets triggered before the dma hardware is configured during dma
init. And then we get the invalid access error from omap_l3_noc.

> Unfortunately, the OMAP hardware appears to make it impossible to
> determine what the access that caused the error was, so it looks like
> it's pretty much undebuggable.

Yeah would be nice to have more info from omap_l3_noc.

Regards,

Tony
