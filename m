From: Paul Walmsley <paul@pwsan.com>
Subject: RE: [PATCH-V3 3/3] ARM: OMAP3+: clock33xx: Add AM33XX clock tree
 data
Date: Thu, 24 May 2012 15:30:10 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1205241525510.25520@utopia.booyaka.com>
References: <1333458578-23073-1-git-send-email-hvaibhav@ti.com> <1333458578-23073-4-git-send-email-hvaibhav@ti.com> <alpine.DEB.2.00.1204241857260.24864@utopia.booyaka.com> <79CD15C6BA57404B839C016229A409A83E9FD175@DBDE01.ent.ti.com> <4F97B891.1020601@ti.com>
 <79CD15C6BA57404B839C016229A409A83E9FD707@DBDE01.ent.ti.com> <4F97E243.6000500@ti.com> <79CD15C6BA57404B839C016229A409A83E9FDA47@DBDE01.ent.ti.com> <4F97EF11.4020300@ti.com> <79CD15C6BA57404B839C016229A409A83E9FDAE7@DBDE01.ent.ti.com>
 <alpine.DEB.2.00.1204250755020.29696@utopia.booyaka.com> <4F9816D1.3000102@ti.com> <alpine.DEB.2.00.1204250934130.29696@utopia.booyaka.com> <79CD15C6BA57404B839C016229A409A83EA31E77@DBDE01.ent.ti.com> <alpine.DEB.2.00.1205230854430.3085@utopia.booyaka.com>
 <79CD15C6BA57404B839C016229A409A83EA33611@DBDE01.ent.ti.com> <alpine.DEB.2.00.1205240120580.2572@utopia.booyaka.com> <79CD15C6BA57404B839C016229A409A83EA3609D@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:33350 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965457Ab2EXVaM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 24 May 2012 17:30:12 -0400
In-Reply-To: <79CD15C6BA57404B839C016229A409A83EA3609D@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Cc: "Cousson, Benoit" <b-cousson@ti.com>, "Mohammed, Afzal" <afzal@ti.com>, "Bedia, Vaibhav" <vaibhav.bedia@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>, "Hilman, Kevin" <khilman@ti.com>, "Nayak, Rajendra" <rnayak@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Thu, 24 May 2012, Hiremath, Vaibhav wrote:

> On Thu, May 24, 2012 at 13:01:11, Paul Walmsley wrote:
> > On Wed, 23 May 2012, Hiremath, Vaibhav wrote:
> > 
> > > I came across situation where, two modules fall into different clock 
> > > domains but their functional clock is happened to be coming from same 
> > > source/dpll-divider. So in order to satisfy clkdm match between them, I 
> > > have kept nodes without enable_regs.
> > 
> > Could you please provide an example?
> 
> In case of AM33xx, clock architecture is,
> 
> sysclk1 -> L4_wakeup - wakeup domain modules
> 
> sysclk1 -> L4 HS - L4 HS domain modules
> 
> sysclk1 -> L4 LS - L4 LS domain modules
> 
> and so on...
> 
> 
> Now with leaf node cleanup, we are moving upward in the clocktree, more 
> close to dpll output, and is the issue related to clockdomain.

I don't really understand.  Perhaps you could provide an example from one 
of the modules?

Are you saying that you have a module that should be in a different 
clockdomain than the clockdomain of the module's main functional clock?

> > > > >    So currently, I have mentioned same entry in both the places (especially 
> > > > >    for Peripherals/modules).
> > > > >    I am planning to remove ocp_if/clk entry data for all modules..
> > > > 
> > > > Hmmm, could you explain this further?
> > > 
> > > what if, module only has interface clock? Should it be present as 
> > > main_clk or ocp_if.clk or both?? Example would be, TPCC, TPTC, 
> > > smartreflex, etc...
> > 
> > Well it definitely should be present as the ocp_if.clk.  I personally 
> > think it would be good to list the same clock as the hwmod's main_clk too, 
> > but it's currently not strictly necessary.  There are some examples in the 
> > omap_hwmod_44xx_data.c file, like omap44xx_mailbox_hwmod.
> 
> omap44xx_mailbox_hwmod doesn't have main_clk exported in the hwmod_data,
> so I think I should also follow same thing, right?

Well please start with specifying the main_clk for all IP blocks.  It is 
potentially ambiguous not to specify it, so unless there is some problem 
with specifying it, I'd prefer to have them.

> You can access the code at - 
> https://github.com/hvaibhav/am335x-linux   am335x-upstream-staging

I'll wait until it's posted to the lists.


- Paul
