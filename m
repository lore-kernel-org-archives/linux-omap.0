From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [PATCH-V3 3/3] ARM: OMAP3+: clock33xx: Add AM33XX clock tree
 data
Date: Wed, 23 May 2012 15:59:06 +0000
Message-ID: <79CD15C6BA57404B839C016229A409A83EA33611@DBDE01.ent.ti.com>
References: <1333458578-23073-1-git-send-email-hvaibhav@ti.com>
 <1333458578-23073-4-git-send-email-hvaibhav@ti.com>
 <alpine.DEB.2.00.1204241857260.24864@utopia.booyaka.com>
 <79CD15C6BA57404B839C016229A409A83E9FD175@DBDE01.ent.ti.com>
 <4F97B891.1020601@ti.com>
 <79CD15C6BA57404B839C016229A409A83E9FD707@DBDE01.ent.ti.com>
 <4F97E243.6000500@ti.com>
 <79CD15C6BA57404B839C016229A409A83E9FDA47@DBDE01.ent.ti.com>
 <4F97EF11.4020300@ti.com>
 <79CD15C6BA57404B839C016229A409A83E9FDAE7@DBDE01.ent.ti.com>
 <alpine.DEB.2.00.1204250755020.29696@utopia.booyaka.com>
 <4F9816D1.3000102@ti.com>
 <alpine.DEB.2.00.1204250934130.29696@utopia.booyaka.com>
 <79CD15C6BA57404B839C016229A409A83EA31E77@DBDE01.ent.ti.com>
 <alpine.DEB.2.00.1205230854430.3085@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:38705 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932345Ab2EWP7Q convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 23 May 2012 11:59:16 -0400
In-Reply-To: <alpine.DEB.2.00.1205230854430.3085@utopia.booyaka.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: "Cousson, Benoit" <b-cousson@ti.com>, "Mohammed, Afzal" <afzal@ti.com>, "Bedia, Vaibhav" <vaibhav.bedia@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>, "Hilman, Kevin" <khilman@ti.com>, "Nayak, Rajendra" <rnayak@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Wed, May 23, 2012 at 20:38:27, Paul Walmsley wrote:
> Hi Vaibhav
> 
> On Wed, 23 May 2012, Hiremath, Vaibhav wrote:
> 
> > I used your cleaned version of clocktree data, where you have removed all 
> > leaf-nodes and merged multiple clocks nodes into one; but it did not work. I 
> > attempted to review the cleanup and tried to debug, but found it bit hard to 
> > come back to working clocktree from stripped version. So moved back to my 
> > submitted clocktree and started stripping the clock leaf-nodes, same way you 
> > had done it. Now I reached to the stage where I have working clocktree 
> > without peripheral leaf-nodes and booting on BeagleBone.
> 
> Okay great, please post that to the list so we can diff it against the 
> version that I did, and also so we can queue it for merging in 3.6?
> 

Just doing final round of review and cleanup...may be by tomorrow, I should 
be able to submit it (without common-clock framework).


> > Just FYI (may need your help), I got into some issues (still open) during 
> > this cleanup -
> > 
> > 1. In cases where we have clock selection option for node-leafs, like, 
> >    Timers, I removed enable_reg entry from the node, which results into a 
> >    kernel error message from function omap2_dflt_clk_disable()
> > 
> > clock: clk_disable called on independent clock %s which has no enable_reg
> 
> Shouldn't those clocks use clkops_null then?
> 
> > 2. clkdm_name entry: 
> >    The issue is, two entries available for clockdomain associated for 
> >    module/clock 
> >         - hwmod_data.main_clk and 
> >         - clk.clkdm_name
> > 
> >    They must match, right? The parent/root clocks flows from one domain to 
> >    another domain, so I have to keep the nodes just for sake of matching 
> >    clockdomain entry present in associated main_clk data.
> > 
> >    I am still reviewing the code from Rajendra, but one of Rajendra's patch 
> >    actually will help here, made it to use hwmod_data.clkdm (if available) 
> >    always, instead of directly using clk.clkdm.
> 
> Well because of this CLKDIV32K snafu, we'll need to keep the clock 
> framework-based clockdomain control for AM33xx, at the very least for 
> the CLKDIV32K clock.
> 
> I'd suggest starting with specifying a clockdomain name for each clock.  
> If nothing else, this should help think through the power management 
> behavior for each clock.  Then those can be easily removed later with a 
> simple grep.
> 
> > 3. If I understand correctly, hwmod_data.main_clk is functional clock and    
> >    hwmod_ocp_if.clk is interface clock, right?
> 
> Basically, yes.  To be more precise, in cases where 
> modules have multiple functional clocks, hwmod_data.main_clk is the 
> functional clock that is needed in order for register reads and writes to 
> the IP block to succeed.
> 

I believe register read/write to IP block is depends on only interface 
Clocks? Atleast in case of OMAP3, it was like that, right??


Another issues is, 

I came across situation where, two modules fall into different clock domains but their functional clock is happened to be coming from same source/dpll-divider. So in order to satisfy clkdm match between them, I have
kept nodes without enable_regs.



> >    So currently, I have mentioned same entry in both the places (especially 
> >    for Peripherals/modules).
> >    I am planning to remove ocp_if/clk entry data for all modules..
> 
> Hmmm, could you explain this further?
> 

what if, module only has interface clock? Should it be present as main_clk or ocp_if.clk or both??
Example would be, TPCC, TPTC, smartreflex, etc...

Thanks,
Vaibhav

> Every ocp_if structure that you create should have an interface clock 
> specified.  And almost all of your hwmods should have a main_clk 
> specified.
> 
> 
> - Paul
> 

