From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [PATCH] ARM: omap: clock: Get rid of unwanted clkdm assocations
 within clks
Date: Mon, 11 Jun 2012 14:31:57 +0530
Message-ID: <4FD5B405.7040309@ti.com>
References: <1337250245-29274-1-git-send-email-rnayak@ti.com> <4FD04A2A.4080207@ti.com> <alpine.DEB.2.00.1206070104060.6684@utopia.booyaka.com> <4FD087FD.9040401@ti.com> <alpine.DEB.2.00.1206080130570.14977@utopia.booyaka.com> <4FD1B2F9.7050400@ti.com> <alpine.DEB.2.00.1206080734350.14977@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na6sys009bog021.obsmtp.com ([74.125.150.82]:54681 "EHLO
	na6sys009bog021.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752000Ab2FKJIP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 11 Jun 2012 05:08:15 -0400
Received: by obbuo19 with SMTP id uo19so7165489obb.12
        for <linux-omap@vger.kernel.org>; Mon, 11 Jun 2012 02:08:14 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1206080734350.14977@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Paul,

>> So why should getting rid of some *unused* data have any testing
>> overhead?
>
> Your definition of 'unused' seems to be different than mine:
>
> $ egrep -rn 'c(lk|)->clkdm' arch/arm/
> arch/arm/mach-omap2/omap_hwmod.c:560:	if (oh->_clk->clkdm&&  oh->_clk->clkdm->flags&  CLKDM_NO_AUTODEPS)
> arch/arm/mach-omap2/omap_hwmod.c:563:	return clkdm_add_sleepdep(oh->_clk->clkdm, init_oh->_clk->clkdm);
> arch/arm/mach-omap2/omap_hwmod.c:584:	if (oh->_clk->clkdm&&  oh->_clk->clkdm->flags&  CLKDM_NO_AUTODEPS)
> arch/arm/mach-omap2/omap_hwmod.c:587:	return clkdm_del_sleepdep(oh->_clk->clkdm, init_oh->_clk->clkdm);

I did have a look at these (which are part of _add/_del_initiator_dep()
functions) while I was working on $SUBJECT patch, and was not very sure
of what these functions are expected to do.
They check for a CLKDM_NO_AUTODEPS flag which is not defined across any
clockdomain data files across any OMAP2+ platform.
What it then means is they add a sleep/static dependency for the
modules/hwmods clkdm with mpu on *all* platforms.
The AUTODEPS on the other hand are needed only on OMAP3 I guess, and
AUTODEPS need a sleep/wakeup (Not just a sleep dependency that
the above functions add) dependency not just with MPU but also with
DSP, besides AUTODEPS are already handled very well in the clockdomain
framework for OMAP3.

> arch/arm/mach-omap2/omap_hwmod.c:612:	if (!oh->_clk->clkdm)
> arch/arm/mach-omap2/omap_hwmod.c:2998:	if (!c->clkdm)
> arch/arm/mach-omap2/omap_hwmod.c:3001:	return c->clkdm->pwrdm.ptr;

I have fixed some of these dereferencing in hwmod to derive a clkdm/
pwrdm for a given hwmod by giving a precedence to a clkdm directly
associated with the hwmod and if missing only then looking for
something through the clk route. What I did miss is to update the
OMAP2/3 hwmod data file for some of the clks from where I was removing
the clkdm assocaitions (There are about ~10 clocks from $SUBJECT patch
which figure in hwmod data files out of the 75 from which I get rid of
the clkdms pointers)

> arch/arm/mach-omap2/clock.c:96:	if (!clk->clkdm_name)
> arch/arm/mach-omap2/clock.c:99:	clkdm = clkdm_lookup(clk->clkdm_name);
> arch/arm/mach-omap2/clock.c:102:			 clk->name, clk->clkdm_name);
> arch/arm/mach-omap2/clock.c:103:		clk->clkdm = clkdm;
> arch/arm/mach-omap2/clock.c:106:			 "clkdm %s\n", clk->name, clk->clkdm_name);

These are part of the init code to resolve clkdm_name into a clkdm
pointer.

> arch/arm/mach-omap2/clock.c:292:	if (clkdm_control&&  clk->clkdm)
> arch/arm/mach-omap2/clock.c:293:		clkdm_clk_disable(clk->clkdm, clk);
> arch/arm/mach-omap2/clock.c:332:	if (clkdm_control&&  clk->clkdm) {
> arch/arm/mach-omap2/clock.c:333:		ret = clkdm_clk_enable(clk->clkdm, clk);
> arch/arm/mach-omap2/clock.c:336:			     "%d\n", clk->name, clk->clkdm->name, ret);
> arch/arm/mach-omap2/clock.c:354:	if (clkdm_control&&  clk->clkdm)
> arch/arm/mach-omap2/clock.c:355:		clkdm_clk_disable(clk->clkdm, clk);

These are only applicable for gate clocks.

> arch/arm/mach-omap2/clock.c:441:	if (clk->clkdm != NULL)
> arch/arm/mach-omap2/clock.c:442:		pwrdm_state_switch(clk->clkdm->pwrdm.ptr);

This again part of disable unused clocks should also matter only for
gate clocks.

>
> That is just the result of a casual grep, not even a code analysis.
>
> Removing this data is not like removing some macros where one can get a
> compiler error if they turn out to be needed.  Problems with this ares
> only likely to show up at runtime.
>
> By the way, I hope you're testing the patches that you send to the lists,
> at the very least to the minimal PM testing that I do that is documented
> e.g. here:
>
> http://www.pwsan.com/omap/bootlogs/20120508/prcm_devel_a_3.5__0135f6a04642c192bdf4b36e06937d3387e174ff/

yes, I am, atleast with the platforms that I have access to,
2430sdp/N800/3430sdp/3630beagle-xm/4430panda/4460panda.

I don't have any 35xxevm/3517evm/5912osk or cmt3517 platforms.

regards,
Rajendra

>
> Otherwise the testing burden is just getting pushed to other people who
> already have too much to do.
>
> ...
>
> So to repeat myself on this:
>
> 1. The patch that removes some of the struct clk clkdm_name strings should
>     be part of or otherwise grouped with the CCF conversion patch series
>
> 2. The CCF conversion patch series needs to be fully PM-tested
>
>
> - Paul

