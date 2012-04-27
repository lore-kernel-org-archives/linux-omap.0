From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH-V4 4/4] ARM: OMAP3+: am33xx: Add powerdomain & PRM support
Date: Thu, 26 Apr 2012 17:49:02 -0700
Message-ID: <87bome579d.fsf@ti.com>
References: <1333123435-27186-1-git-send-email-hvaibhav@ti.com>
	<1333123435-27186-5-git-send-email-hvaibhav@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog118.obsmtp.com ([74.125.149.244]:36272 "EHLO
	na3sys009aog118.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759644Ab2D0AtE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 26 Apr 2012 20:49:04 -0400
Received: by dadz9 with SMTP id z9so258485dad.33
        for <linux-omap@vger.kernel.org>; Thu, 26 Apr 2012 17:49:02 -0700 (PDT)
In-Reply-To: <1333123435-27186-5-git-send-email-hvaibhav@ti.com> (Vaibhav
	Hiremath's message of "Fri, 30 Mar 2012 21:33:55 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vaibhav Hiremath <hvaibhav@ti.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, b-cousson@ti.com, tony@atomide.com, rnayak@ti.com, Afzal Mohammed <afzal@ti.com>, linux-arm-kernel@lists.infradead.org

Vaibhav Hiremath <hvaibhav@ti.com> writes:

> As far as PRM/CM/PRCM modules are concerned, AM33XX device is
> different than OMAP3 and OMAP4 architectures; so we need to
> handle it separately.
> This patch adds support for, Powerdomain, Powerdomain data,
> PRM api's required for AM33XX device.
>
> And also, hooks up AM33XX powerdomain to existing OMAP framework.

[...]

> @@ -1288,7 +1289,15 @@ static int _assert_hardreset(struct omap_hwmod *oh, const char *name)
>  	if (IS_ERR_VALUE(ret))
>  		return ret;
>
> -	if (cpu_is_omap24xx() || cpu_is_omap34xx())
> +	/*
> +	 * cpu_is_omap34xx() is true for am33xx device as well, so
> +	 * fist check for cpu_is_am33xx().
> +	 */
> +	if (cpu_is_am33xx())
> +		return am33xx_prm_assert_hardreset(ohri.rst_shift,
> +				oh->clkdm->pwrdm.ptr->prcm_offs,
> +				oh->prcm.omap4.rstctrl_offs);

This still troubles me.  I *really* don't like that we have a dependence
on cpu_is* call ordering.  This is very fragile and error prone.

I also don't like all the cpu_is* checking currently in omap_hwmod.c
(which is here before you added this) and have an idea on how to clean
it up, I should have a patch by tomorrow for this.  That should help
adding am33xx support here without needing all the cpu_is* checking.

That being said, I just did a simple experiment[1] to see why
cpu_is_omap34xx() needs to be true for AM33xx in the first place.  Based
on my quick experiment, it does not appear to be needed.  I think our
lives will be much simpler if cpu_is_omap34xx() is not true for the
AM335x family. 

Can you have a look at my test branch[1] and see what you think?  I
changed the omap_revision for AM335x so that cpu_is_omap34xx() is no
longer true on this platform.  Then, I only needed to fixup the SRAM
init, and it boots just fine on my BeagleBone.

I really think we need to go this route, because having
cpu_is_omap34xx() true on AM335x is causing more headaches than it is
solving problems.  This will require you to rework a little bit these
clock/power/voltage domain patches, but I belive it will greatly
simplify the maintainability of the end result.

Kevin

[1] git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm.git tmp/am335x-cpu-is-hacking

