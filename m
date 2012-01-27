From: Paul Walmsley <paul@pwsan.com>
Subject: Re: OMAP HDQ: was Re: DSS2/PM on 3.2 broken?
Date: Fri, 27 Jan 2012 15:58:40 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1201271541110.13783@utopia.booyaka.com>
References: <WC20120109124643.880164@terrafix.co.uk> <20120110080849.5a242adf@notabene.brown> <alpine.DEB.2.00.1201110632100.31702@utopia.booyaka.com> <20120112095940.0a54413e@notabene.brown> <alpine.DEB.2.00.1201130253070.3659@utopia.booyaka.com>
 <20120113222045.37f9b4ec@notabene.brown> <alpine.DEB.2.00.1201130423280.3659@utopia.booyaka.com> <20120114100915.01c96727@notabene.brown> <20120118082410.48262777@notabene.brown> <alpine.DEB.2.00.1201211704430.26641@utopia.booyaka.com>
 <20120124213705.49f042bf@notabene.brown> <alpine.DEB.2.00.1201260647570.11174@utopia.booyaka.com> <20120128093530.0a0a370a@notabene.brown>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:45255 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750865Ab2A0W6m (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 27 Jan 2012 17:58:42 -0500
In-Reply-To: <20120128093530.0a0a370a@notabene.brown>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: NeilBrown <neilb@suse.de>
Cc: Joe Woodward <jw@terrafix.co.uk>, khilman@ti.com, t-kristo@ti.com, govindraj.raja@ti.com, linux-omap@vger.kernel.org

On Sat, 28 Jan 2012, NeilBrown wrote:

> On Thu, 26 Jan 2012 07:19:19 -0700 (MST) Paul Walmsley <paul@pwsan.com> wrote:
>
> > Thanks.  Should I add a Tested-by: from you on those patches?
> 
> Well... I only tested them after backporting to 3.2, and Linus is a big
> proponent of the idea that once you rebase patches you invalidate any
> testing....
> However I don't think there difference between 3.2 and 3.3-rc1 is big enough
> in the area, so yes:
> 
>    Tested-by: NeilBrown <neilb@suse.de>

Okay, thanks.

> > Here's a theory: perhaps the MPU powerdomain is hitting a low-power state 
> > while waiting for an HDQ interrupt.  When the MPU powerdomain is in a low 
> > power state, so is the MPU interrupt controller, so the only way that the 
> > MPU can wake up is if the HDQ can issue a wakeup event to the PRCM.  And I 
> > don't see any evidence that the HDQ is capable of doing this, based on the 
> > HDQ sections of the TRM.  What a huge energy waste, if true.
> 
> In the config I am testing MPU only goes to RET, never OFF. Same for CORE.

That qualifies as a low-power state for the MPU :-)

In MPU RET, at least in theory, the MPU INTC will not be operational, and 
thus unable to respond to interrupts.

> > Maybe try something like the following patch -- compile-tested only here.
> > 
> > If this works, you might want to try dropping this patch and using the pad 
> > mux to set a wakeup event on the 1-wire pad when the signal goes low.  
> > That might be a more power-efficient approach.  You may still have to use 
> > some PM QoS request there to ensure that the HDQ can wake up fast enough 
> > to see the pulse, but the constraint shouldn't need to be as ludicrously 
> > low as it is in the following patch.
> 
> Doesn't work - crashes :-(
> 
> pm_qos_power_init is defined as a late_initcall, so you cannot call
> pm_qos_update_request until after all the initcalls have run.
> But with your patch, the probe of the bq27000 triggers a read of the registers
> which tries to update_request - and it goes 'bang'.

Hmm, okay.  Could you please remove the register read from the HDQ probe 
and see if that makes a difference?

> I really think the problem is the CORE pwrdm gating a clock because no module
> says it needs it - i.e. nothing to do with MPU at all.

Until pm_runtime_put*() is called, the usecount of hdq_fck will still be 
non-zero.  So the CORE shouldn't be able to gate it or hdq_ick at that 
time, and thus should not be able to enter idle. Hence the question about 
where the problems occur: whether they occur in the middle of the 
transaction or when the HDQ clocks are disabled.

> We want to keep CORE active when an HDQ transaction is happening, but MPU is
> welcome to go to sleep.  I don't think you can express that with 'qos'.  I
> think it needs some omap-specific machinery.

The OMAP PRCM hardware should keep the CORE* clkdms active when the 
hdq_fck is enabled.  So it's possible there could be a PRCM silicon bug 
that doesn't take hdq_fck into account when determining whether the CORE_* 
clkdms are inactive.

> I can 'fix' the problem simply by making sure
> 
> 		pwrdm_for_each_clkdm(core_pd, _cpuidle_deny_idle);
> 
> runs in omap3_enter_idle whenever HDQ is active.

Hmm, that does suggest that it's not wakeup related.

> One of the reasons that I think it is a clock problem rather than just 
> missing a wakeup event is that once the problem starts happening I 
> cannot recovery without rebooting. i.e. even if I tell the UARTs to keep 
> the clocks on permanently and keep the CPUIDLE state at 0, the HDQ 
> doesn't start working again.  It has clearly become confused. The HDQ 
> doco makes a point of saying that you shouldn't issue any commands 
> (except 'enable clock') when the clock is disabled.  I think we end up 
> doing that and it gets confused and cannot recover.
> 
> I note that there is an ad-hoc dependency between the camera and various 
> power states as well.  Maybe we need a little bit of infrastructure so 
> that camera can say "Keep CORE and MPU on" (or whatever it needs) and 
> HDQ can say "Keep CORE on".  ???

I'm not familiar with the camera problems, but in the HDQ case, this 
should only be needed if a silicon bug exists.  Which is certainly 
possible; we've seen this problem with one other IP block in the past. 
Based on a quick glance at the errata, I don't see anything related to the 
HDQ, but that doesn't really mean anything.

In any case, we should be able to work around this via the hwmod layer and 
a special flag, if the problem really is a PRCM bug.  This will depend on 
the functional powerstate conversion.  

Thanks for the detailed test reports.

- Paul
