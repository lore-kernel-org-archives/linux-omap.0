From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] ARM: omap: clock: Get rid of unwanted clkdm assocations
 within clks
Date: Fri, 8 Jun 2012 08:24:16 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1206080734350.14977@utopia.booyaka.com>
References: <1337250245-29274-1-git-send-email-rnayak@ti.com> <4FD04A2A.4080207@ti.com> <alpine.DEB.2.00.1206070104060.6684@utopia.booyaka.com> <4FD087FD.9040401@ti.com> <alpine.DEB.2.00.1206080130570.14977@utopia.booyaka.com> <4FD1B2F9.7050400@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:33578 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932086Ab2FHOYR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 8 Jun 2012 10:24:17 -0400
In-Reply-To: <4FD1B2F9.7050400@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Fri, 8 Jun 2012, Rajendra Nayak wrote:

> This patch only gets rid of clkdm assocation from *non gate* clocks.
> And what I am trying to say is that, this information in not
> used at all (for non gate clocks) in any of the frameworks today
> including clock framework.
> So why should getting rid of some *unused* data have any testing
> overhead?

Your definition of 'unused' seems to be different than mine:

$ egrep -rn 'c(lk|)->clkdm' arch/arm/
arch/arm/mach-omap2/omap_hwmod.c:560:	if (oh->_clk->clkdm && oh->_clk->clkdm->flags & CLKDM_NO_AUTODEPS)
arch/arm/mach-omap2/omap_hwmod.c:563:	return clkdm_add_sleepdep(oh->_clk->clkdm, init_oh->_clk->clkdm);
arch/arm/mach-omap2/omap_hwmod.c:584:	if (oh->_clk->clkdm && oh->_clk->clkdm->flags & CLKDM_NO_AUTODEPS)
arch/arm/mach-omap2/omap_hwmod.c:587:	return clkdm_del_sleepdep(oh->_clk->clkdm, init_oh->_clk->clkdm);
arch/arm/mach-omap2/omap_hwmod.c:612:	if (!oh->_clk->clkdm)
arch/arm/mach-omap2/omap_hwmod.c:2998:	if (!c->clkdm)
arch/arm/mach-omap2/omap_hwmod.c:3001:	return c->clkdm->pwrdm.ptr;
arch/arm/mach-omap2/clock.c:96:	if (!clk->clkdm_name)
arch/arm/mach-omap2/clock.c:99:	clkdm = clkdm_lookup(clk->clkdm_name);
arch/arm/mach-omap2/clock.c:102:			 clk->name, clk->clkdm_name);
arch/arm/mach-omap2/clock.c:103:		clk->clkdm = clkdm;
arch/arm/mach-omap2/clock.c:106:			 "clkdm %s\n", clk->name, clk->clkdm_name);
arch/arm/mach-omap2/clock.c:292:	if (clkdm_control && clk->clkdm)
arch/arm/mach-omap2/clock.c:293:		clkdm_clk_disable(clk->clkdm, clk);
arch/arm/mach-omap2/clock.c:332:	if (clkdm_control && clk->clkdm) {
arch/arm/mach-omap2/clock.c:333:		ret = clkdm_clk_enable(clk->clkdm, clk);
arch/arm/mach-omap2/clock.c:336:			     "%d\n", clk->name, clk->clkdm->name, ret);
arch/arm/mach-omap2/clock.c:354:	if (clkdm_control && clk->clkdm)
arch/arm/mach-omap2/clock.c:355:		clkdm_clk_disable(clk->clkdm, clk);
arch/arm/mach-omap2/clock.c:441:	if (clk->clkdm != NULL)
arch/arm/mach-omap2/clock.c:442:		pwrdm_state_switch(clk->clkdm->pwrdm.ptr);

That is just the result of a casual grep, not even a code analysis.

Removing this data is not like removing some macros where one can get a 
compiler error if they turn out to be needed.  Problems with this ares 
only likely to show up at runtime.

By the way, I hope you're testing the patches that you send to the lists, 
at the very least to the minimal PM testing that I do that is documented 
e.g. here:

http://www.pwsan.com/omap/bootlogs/20120508/prcm_devel_a_3.5__0135f6a04642c192bdf4b36e06937d3387e174ff/

Otherwise the testing burden is just getting pushed to other people who 
already have too much to do.

...

So to repeat myself on this:

1. The patch that removes some of the struct clk clkdm_name strings should 
   be part of or otherwise grouped with the CCF conversion patch series

2. The CCF conversion patch series needs to be fully PM-tested


- Paul
