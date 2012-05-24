From: Paul Walmsley <paul@pwsan.com>
Subject: RE: [PATCH-V3 3/3] ARM: OMAP3+: clock33xx: Add AM33XX clock tree
 data
Date: Thu, 24 May 2012 01:31:11 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1205240120580.2572@utopia.booyaka.com>
References: <1333458578-23073-1-git-send-email-hvaibhav@ti.com> <1333458578-23073-4-git-send-email-hvaibhav@ti.com> <alpine.DEB.2.00.1204241857260.24864@utopia.booyaka.com> <79CD15C6BA57404B839C016229A409A83E9FD175@DBDE01.ent.ti.com> <4F97B891.1020601@ti.com>
 <79CD15C6BA57404B839C016229A409A83E9FD707@DBDE01.ent.ti.com> <4F97E243.6000500@ti.com> <79CD15C6BA57404B839C016229A409A83E9FDA47@DBDE01.ent.ti.com> <4F97EF11.4020300@ti.com> <79CD15C6BA57404B839C016229A409A83E9FDAE7@DBDE01.ent.ti.com>
 <alpine.DEB.2.00.1204250755020.29696@utopia.booyaka.com> <4F9816D1.3000102@ti.com> <alpine.DEB.2.00.1204250934130.29696@utopia.booyaka.com> <79CD15C6BA57404B839C016229A409A83EA31E77@DBDE01.ent.ti.com> <alpine.DEB.2.00.1205230854430.3085@utopia.booyaka.com>
 <79CD15C6BA57404B839C016229A409A83EA33611@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:32870 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751647Ab2EXHbM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 24 May 2012 03:31:12 -0400
In-Reply-To: <79CD15C6BA57404B839C016229A409A83EA33611@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Cc: "Cousson, Benoit" <b-cousson@ti.com>, "Mohammed, Afzal" <afzal@ti.com>, "Bedia, Vaibhav" <vaibhav.bedia@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>, "Hilman, Kevin" <khilman@ti.com>, "Nayak, Rajendra" <rnayak@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hi

On Wed, 23 May 2012, Hiremath, Vaibhav wrote:

> I believe register read/write to IP block is depends on only interface 
> Clocks? Atleast in case of OMAP3, it was like that, right??

No, on OMAP3, most modules need both the interface clock enabled, and at 
least one of their functional clocks.  For modules with multiple 
functional clocks like the OMAP3 USBHOST, we had to use trial 
and error to determine which functional clock was the main clock, since it 
wasn't documented.  If we got it wrong, then register accesses to the 
module would result in an abort.

The AM33xx/OMAP4 behavior should be a little easier in this regard, 
though, since the MODULEMODE bits should just control everything for a 
given module, and that should be handled by the hwmod code.  Nevertheless 
it is still good to specify a main_clk so we know how fast the module's 
registers are clocked and to locate the module in the power management 
hierarchy.

> Another issues is, 
> 
> I came across situation where, two modules fall into different clock 
> domains but their functional clock is happened to be coming from same 
> source/dpll-divider. So in order to satisfy clkdm match between them, I 
> have kept nodes without enable_regs.

Could you please provide an example?

> > >    So currently, I have mentioned same entry in both the places (especially 
> > >    for Peripherals/modules).
> > >    I am planning to remove ocp_if/clk entry data for all modules..
> > 
> > Hmmm, could you explain this further?
> 
> what if, module only has interface clock? Should it be present as 
> main_clk or ocp_if.clk or both?? Example would be, TPCC, TPTC, 
> smartreflex, etc...

Well it definitely should be present as the ocp_if.clk.  I personally 
think it would be good to list the same clock as the hwmod's main_clk too, 
but it's currently not strictly necessary.  There are some examples in the 
omap_hwmod_44xx_data.c file, like omap44xx_mailbox_hwmod.


- Paul
