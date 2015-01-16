From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: Regression with legacy IRQ numbers caused by 9a1091ef0017
Date: Fri, 16 Jan 2015 16:30:19 +0000
Message-ID: <20150116163019.GW11502@n2100.arm.linux.org.uk>
References: <20150114221407.GS2419@atomide.com>
 <20150115105035.GU11502@n2100.arm.linux.org.uk>
 <20150115152838.GB18552@atomide.com>
 <20150115171924.GV11502@n2100.arm.linux.org.uk>
 <20150116162119.GK18552@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from gw-1.arm.linux.org.uk ([78.32.30.217]:45121 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754901AbbAPQab (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 16 Jan 2015 11:30:31 -0500
Content-Disposition: inline
In-Reply-To: <20150116162119.GK18552@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Yingjoe Chen <yingjoe.chen@mediatek.com>, Marc Zyngier <marc.zyngier@arm.com>, Jason Cooper <jason@lakedaemon.net>, Felipe Balbi <balbi@ti.com>, Thomas Gleixner <tglx@linutronix.de>

On Fri, Jan 16, 2015 at 08:21:20AM -0800, Tony Lindgren wrote:
> * Russell King - ARM Linux <linux@arm.linux.org.uk> [150115 09:22]:
> > On Thu, Jan 15, 2015 at 07:28:39AM -0800, Tony Lindgren wrote:
> > > * Russell King - ARM Linux <linux@arm.linux.org.uk> [150115 02:53]:
> > > > I don't think we've proven a link there.  While you're right that it
> > > > causes the wrong interrupt to be claimed, I have two kernels here,
> > > > both claim the same interrupt, one which is multi-platform and issues
> > > > that strange warning, and one which targets only OMAP4 which doesn't.
> > > > 
> > > > There's something else going on which causes the bus errors which we
> > > > haven't found.
> > > 
> > > I think it gets triggered if you enable PREEMPT.
> > 
> > That's something which we can try to prove... build running now with
> > CONFIG_PREEMPT=y
> 
> Looks like you now have the omap_l3_noc error appear for sdp4430 in
> your logs after enabling PREEMPT.
> 
> I guess that means case closed for this one?

I would still like to understand /why/ enabling preempt causes the error.
Changing the preempt configuration really should not change what happens
on the bus.  (Think about it.)  It's an indication that there is some
other error present.

Unfortunately, the OMAP hardware appears to make it impossible to
determine what the access that caused the error was, so it looks like
it's pretty much undebuggable.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
