From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [PATCH-V4 4/4] ARM: OMAP3+: am33xx: Add powerdomain & PRM
 support
Date: Fri, 27 Apr 2012 06:37:09 +0000
Message-ID: <79CD15C6BA57404B839C016229A409A83EA00381@DBDE01.ent.ti.com>
References: <1333123435-27186-1-git-send-email-hvaibhav@ti.com>
	<1333123435-27186-5-git-send-email-hvaibhav@ti.com> <87bome579d.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:59195 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750864Ab2D0GhT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 27 Apr 2012 02:37:19 -0400
In-Reply-To: <87bome579d.fsf@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hilman, Kevin" <khilman@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "paul@pwsan.com" <paul@pwsan.com>, "Cousson, Benoit" <b-cousson@ti.com>, "tony@atomide.com" <tony@atomide.com>, "Nayak, Rajendra" <rnayak@ti.com>, "Mohammed, Afzal" <afzal@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Fri, Apr 27, 2012 at 06:19:02, Hilman, Kevin wrote:
> Vaibhav Hiremath <hvaibhav@ti.com> writes:
> 
> > As far as PRM/CM/PRCM modules are concerned, AM33XX device is
> > different than OMAP3 and OMAP4 architectures; so we need to
> > handle it separately.
> > This patch adds support for, Powerdomain, Powerdomain data,
> > PRM api's required for AM33XX device.
> >
> > And also, hooks up AM33XX powerdomain to existing OMAP framework.
> 
> [...]
> 
> > @@ -1288,7 +1289,15 @@ static int _assert_hardreset(struct omap_hwmod *oh, const char *name)
> >  	if (IS_ERR_VALUE(ret))
> >  		return ret;
> >
> > -	if (cpu_is_omap24xx() || cpu_is_omap34xx())
> > +	/*
> > +	 * cpu_is_omap34xx() is true for am33xx device as well, so
> > +	 * fist check for cpu_is_am33xx().
> > +	 */
> > +	if (cpu_is_am33xx())
> > +		return am33xx_prm_assert_hardreset(ohri.rst_shift,
> > +				oh->clkdm->pwrdm.ptr->prcm_offs,
> > +				oh->prcm.omap4.rstctrl_offs);
> 
> This still troubles me.  I *really* don't like that we have a dependence
> on cpu_is* call ordering.  This is very fragile and error prone.
> 
> I also don't like all the cpu_is* checking currently in omap_hwmod.c
> (which is here before you added this) and have an idea on how to clean
> it up, I should have a patch by tomorrow for this.  That should help
> adding am33xx support here without needing all the cpu_is* checking.
> 
> That being said, I just did a simple experiment[1] to see why
> cpu_is_omap34xx() needs to be true for AM33xx in the first place.  Based
> on my quick experiment, it does not appear to be needed.  I think our
> lives will be much simpler if cpu_is_omap34xx() is not true for the
> AM335x family. 
> 
> Can you have a look at my test branch[1] and see what you think?  I
> changed the omap_revision for AM335x so that cpu_is_omap34xx() is no
> longer true on this platform.  Then, I only needed to fixup the SRAM
> init, and it boots just fine on my BeagleBone.
> 
> I really think we need to go this route, because having
> cpu_is_omap34xx() true on AM335x is causing more headaches than it is
> solving problems.  This will require you to rework a little bit these
> clock/power/voltage domain patches, but I belive it will greatly
> simplify the maintainability of the end result.
> 

Let me spend some time, and explore your changes; I think getting system to boot should not be only criteria here.
But honestly, I fully agree with you that, we are creating more issue, 
adding more cpu_is_xxx() checks, with cpu_is_34xx() true for AM33xx. 

As I have done in the past initially, I recommend and vote for,

 1. Creating separate family cpu_is_am33xx() for AM33xx device.
OR
 2. Bring it to omap44xx family, since prcm block is closer to omap4
    and not with omap3. Also, 


Tony,
I will let tony make a decision on this. By the time, Tony makes his 
decision, I will spend time to explore your (Kevin's below) branch.

Thanks,
Vaibhav

> Kevin
> 
> [1] git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm.git tmp/am335x-cpu-is-hacking
> 
> 

