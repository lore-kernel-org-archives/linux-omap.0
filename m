From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH-V4 4/4] ARM: OMAP3+: am33xx: Add powerdomain & PRM
 support
Date: Fri, 4 May 2012 11:43:13 -0700
Message-ID: <20120504184313.GN5613@atomide.com>
References: <1333123435-27186-1-git-send-email-hvaibhav@ti.com>
 <1333123435-27186-5-git-send-email-hvaibhav@ti.com>
 <87bome579d.fsf@ti.com>
 <79CD15C6BA57404B839C016229A409A83EA00381@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:10496 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752129Ab2EDSnQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 4 May 2012 14:43:16 -0400
Content-Disposition: inline
In-Reply-To: <79CD15C6BA57404B839C016229A409A83EA00381@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Cc: "Hilman, Kevin" <khilman@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "paul@pwsan.com" <paul@pwsan.com>, "Cousson, Benoit" <b-cousson@ti.com>, "Nayak, Rajendra" <rnayak@ti.com>, "Mohammed, Afzal" <afzal@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

* Hiremath, Vaibhav <hvaibhav@ti.com> [120426 23:40]:
> On Fri, Apr 27, 2012 at 06:19:02, Hilman, Kevin wrote:
> > Vaibhav Hiremath <hvaibhav@ti.com> writes:
> > 
> > > As far as PRM/CM/PRCM modules are concerned, AM33XX device is
> > > different than OMAP3 and OMAP4 architectures; so we need to
> > > handle it separately.
> > > This patch adds support for, Powerdomain, Powerdomain data,
> > > PRM api's required for AM33XX device.
> > >
> > > And also, hooks up AM33XX powerdomain to existing OMAP framework.
> > 
> > [...]
> > 
> > > @@ -1288,7 +1289,15 @@ static int _assert_hardreset(struct omap_hwmod *oh, const char *name)
> > >  	if (IS_ERR_VALUE(ret))
> > >  		return ret;
> > >
> > > -	if (cpu_is_omap24xx() || cpu_is_omap34xx())
> > > +	/*
> > > +	 * cpu_is_omap34xx() is true for am33xx device as well, so
> > > +	 * fist check for cpu_is_am33xx().
> > > +	 */
> > > +	if (cpu_is_am33xx())
> > > +		return am33xx_prm_assert_hardreset(ohri.rst_shift,
> > > +				oh->clkdm->pwrdm.ptr->prcm_offs,
> > > +				oh->prcm.omap4.rstctrl_offs);
> > 
> > This still troubles me.  I *really* don't like that we have a dependence
> > on cpu_is* call ordering.  This is very fragile and error prone.
> > 
> > I also don't like all the cpu_is* checking currently in omap_hwmod.c
> > (which is here before you added this) and have an idea on how to clean
> > it up, I should have a patch by tomorrow for this.  That should help
> > adding am33xx support here without needing all the cpu_is* checking.
> > 
> > That being said, I just did a simple experiment[1] to see why
> > cpu_is_omap34xx() needs to be true for AM33xx in the first place.  Based
> > on my quick experiment, it does not appear to be needed.  I think our
> > lives will be much simpler if cpu_is_omap34xx() is not true for the
> > AM335x family. 
> > 
> > Can you have a look at my test branch[1] and see what you think?  I
> > changed the omap_revision for AM335x so that cpu_is_omap34xx() is no
> > longer true on this platform.  Then, I only needed to fixup the SRAM
> > init, and it boots just fine on my BeagleBone.
> > 
> > I really think we need to go this route, because having
> > cpu_is_omap34xx() true on AM335x is causing more headaches than it is
> > solving problems.  This will require you to rework a little bit these
> > clock/power/voltage domain patches, but I belive it will greatly
> > simplify the maintainability of the end result.
> > 
> 
> Let me spend some time, and explore your changes; I think getting system to boot should not be only criteria here.
> But honestly, I fully agree with you that, we are creating more issue, 
> adding more cpu_is_xxx() checks, with cpu_is_34xx() true for AM33xx. 
> 
> As I have done in the past initially, I recommend and vote for,
> 
>  1. Creating separate family cpu_is_am33xx() for AM33xx device.
> OR
>  2. Bring it to omap44xx family, since prcm block is closer to omap4
>     and not with omap3. Also, 
> 
> 
> Tony,
> I will let tony make a decision on this. By the time, Tony makes his 
> decision, I will spend time to explore your (Kevin's below) branch.

Just to summarize, I guess it's pretty obvious that we need cpu_is_am33xx
here. In general work on getting rid of the cpu_is_xxxx checks as they
are not safe to use with single zImage in initcalls.

Tony
