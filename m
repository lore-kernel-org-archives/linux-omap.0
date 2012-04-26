From: Paul Walmsley <paul@pwsan.com>
Subject: RE: [PATCH-V3 3/3] ARM: OMAP3+: clock33xx: Add AM33XX clock tree
 data
Date: Thu, 26 Apr 2012 02:11:56 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1204260140530.30642@utopia.booyaka.com>
References: <1333458578-23073-1-git-send-email-hvaibhav@ti.com> <1333458578-23073-4-git-send-email-hvaibhav@ti.com> <alpine.DEB.2.00.1204252335190.30642@utopia.booyaka.com> <79CD15C6BA57404B839C016229A409A83E9FE7EA@DBDE01.ent.ti.com>
 <alpine.DEB.2.00.1204260025140.30642@utopia.booyaka.com> <79CD15C6BA57404B839C016229A409A83E9FEB50@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:37521 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754573Ab2DZIL5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 26 Apr 2012 04:11:57 -0400
In-Reply-To: <79CD15C6BA57404B839C016229A409A83E9FEB50@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hiremath, Vaibhav" <hvaibhav@ti.com>, "Mohammed, Afzal" <afzal@ti.com>, "Bedia, Vaibhav" <vaibhav.bedia@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>, "Hilman, Kevin" <khilman@ti.com>, "Nayak, Rajendra" <rnayak@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Thu, 26 Apr 2012, Hiremath, Vaibhav wrote:

> On Thu, Apr 26, 2012 at 12:06:00, Paul Walmsley wrote:
> > On Thu, 26 Apr 2012, Hiremath, Vaibhav wrote:
> > 
> > > Unfortunately, this is fractional divider, assuming input clock of 24MHz.
> > > 
> > > 24MHz / 732.4219 = 32KHz (Normal OPP100)
> > > 24MHz / 366.2109 = 32KHz (OPP50)
> > 
> > Yes, I already saw that in the TRM.  The question is, how is the 
> > fractional divider implemented in the hardware?  Is it implemented as an 
> > M,N counter?  It's rather unlikely to be dividing by 732.4219 directly -- 
> > in fact that value isn't even accurate.
> 
> Not sure how it is implemented in HW, in any case we do not have control 
> over it. The control is only provided using,
> 	- MODULEMODE (module enable/disable)
> 	- CONTROL_CLK32K_DIVRATIO_CTRL (divisor selection)

Right, but the goal is to make the clock tree rate computation independent 
of the assumptions of the OPP settings.

So placing a fixed clock rate -- one that supposedly does not depend on a 
parent rate -- in the middle of a clock tree is something we wish to 
avoid, if possible.  It is a hack.  Especially considering that the 
clock's input rate does appear to depend on its parent's rate.

So, could you please double-check to find out if the appropriate 
abstraction is as an M,N counter?  If the public forum is an issue, then 
if you prefer, you can E-mail me privately with the results.

> > > > - This clock is feeding downstream clocks, but it's using the MODULEMODE 
> > > > control interface, as if it were a standalone IP block.  Do you know why 
> > > > it's using the MODULEMODE control method rather than some optional clock 
> > > > control bits, like OMAP4 does?
> > > 
> > > Yes, this clock is feeding to timers, gpio debounce clocks, etc...
> > > Honestly, I do not know the answer to why part of it.
> > > (May be another integration/design issue)
> > 
> > Could you please check with the AM335x PRCM designers about this to find 
> > out what that MODULEMODE bit is actually doing (i.e., is it actually 
> > enabling the clock, and if so, why did they not use the OPTFCLKEN bits) ?  
> > The AM335x TRM has almost no documentation on what those MODULEMODE bits 
> > are doing in this case.
> 
> I can check, I am certain that, the answer would be to consider this as a 
> separate independent module.

Yes, please check with the hardware team.  The questions would be:

- What does changing the CLKDIV32K_CLKCTRL.MODULEMODE bits do?

- Is it necessary for the MODULEMODE bits to be set to 2 (ENABLE) to 
generate a clock to the clock nodes downstream of CLKDIV32K, or does the 
MODULEMODE just affect some other register access by the MPU?

- Will setting the CLKDIV32K_CLKCTRL.MODULEMODE bits to 0 disable the 
clock from being provided to downstream nodes of the CLKDIV32K, or does it 
simply affect register access?

- Is it necessary to follow the clockdomain enable sequence before 
enabling the CLKDIV32K MODULEMODE?

- What clockdomain does the CLKDIV32K module belong to?

> And same as other modules, control is provided to the SW.

The problem is that CLKDIV32K does not appear to be a distinct, leaf IP 
block from a clocking perspective, unlike the other uses of the 
*_CLKCTRL.MODULEMODE bits in the AM335x and OMAP4 clock trees.  So 
something is very unusual here.

If one of our core framework assumptions for OMAP4+ devices is incorrect, 
it would be useful for us to know as soon as possible, to avoid churn and 
broken code.


- Paul
