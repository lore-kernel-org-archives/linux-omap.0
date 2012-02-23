From: <Madhusudhan.Gowda@elektrobit.com>
Subject: RE: [GIT PULL] OMAP PM EMU fix for v3.3
Date: Thu, 23 Feb 2012 11:49:19 +0200
Message-ID: <AA48DD8077D5D945A49BD1782C1140F10122E640@fioues08.ebgroup.elektrobit.com>
References: <87liw8agk4.fsf@ti.com><AA48DD8077D5D945A49BD1782C1140F1011EBBC7@fioues08.ebgroup.elektrobit.com><20120127190239.GC9339@atomide.com><AA48DD8077D5D945A49BD1782C1140F1011EBBC8@fioues08.ebgroup.elektrobit.com><AA48DD8077D5D945A49BD1782C1140F10122E2B7@fioues08.ebgroup.elektrobit.com> <87linxa5gk.fsf@ti.com> <AA48DD8077D5D945A49BD1782C1140F10122E4FF@fioues08.ebgroup.elektrobit.com> <alpine.DEB.2.00.1202222021460.12198@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtpgw2fi.elektrobit.com ([194.136.18.129]:53425 "EHLO
	smtpgw1fi.elektrobit.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752271Ab2BWJt0 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 23 Feb 2012 04:49:26 -0500
Received: from fioumg02.ebgroup.elektrobit.com (smtpgw2fi.ebgroup.elektrobit.com [127.0.0.1])
	by smtpgw1fi.elektrobit.com (8.13.8/8.13.8) with ESMTP id q1N9nNsx004110
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Thu, 23 Feb 2012 11:49:24 +0200
Received: (from defang@localhost)
	by fioumg02.ebgroup.elektrobit.com (8.13.8/8.13.8/Submit) id q1N9nMFn004106
	for <linux-omap@vger.kernel.org>; Thu, 23 Feb 2012 11:49:22 +0200
Content-class: urn:content-classes:message
In-Reply-To: <alpine.DEB.2.00.1202222021460.12198@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: paul@pwsan.com
Cc: khilman@ti.com, tony@atomide.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Paul,

Please find my comments inlined.

Thanks
Gowda

-----Original Message-----
From: linux-arm-kernel-bounces@lists.infradead.org
[mailto:linux-arm-kernel-bounces@lists.infradead.org] On Behalf Of Paul
Walmsley
Sent: 23 February 2012 06:09
To: Gowda Madhusudhan
Cc: khilman@ti.com; tony@atomide.com; linux-omap@vger.kernel.org;
linux-arm-kernel@lists.infradead.org
Subject: RE: [GIT PULL] OMAP PM EMU fix for v3.3

Hello Gowda,

A few questions...

On Wed, 22 Feb 2012, Madhusudhan.Gowda@elektrobit.com wrote:

> I have tested this on beagle board as well as on OMAP3630 based 
> propriatory phone using SDTI serial trace interface.

What driver are you using for SDTI?  Does it use pm_runtime* or call
clk_enable() on some clock when it is in use?  Are you defining a hwmod
for it?  I don't see an SDTI driver in mainline, but maybe I am just
missing it.  If it's not there, could you please post it or post a link
to it so we can take a look at what it's doing?

> Also you can test it by just observing the CM_EMU (48005100) clkstctrl

> register
>  48 => 00000001
> Across MPU OFF alone
> 
> [root@beagleboard /]# echo 0 >
> /sys/kernel/debug/pm_debug/neon_pwrdm/suspend
> [root@beagleboard /]# echo 0 >
> /sys/kernel/debug/pm_debug/mpu_pwrdm/suspend
> [root@beagleboard /]# echo 1 >
> /sys/kernel/debug/pm_debug/core_pwrdm/suspend
> [root@beagleboard /]# echo 1 >
> /sys/kernel/debug/pm_debug/per_pwrdm/suspend
> [root@beagleboard /]# echo mem >/sys/power/state
> [   59.694671] PM: Syncing filesystems ... done.
> [   59.758209] Freezing user space processes ... (elapsed 0.02
seconds)
> done.
> [   59.789947] Freezing remaining freezable tasks ... (elapsed 0.02
> seconds) done.
> [   59.820709] Suspending console(s) (use no_console_suspend to debug)
> [   60.055816] PM: suspend of devices complete after 212.493 msecs
> [   60.059661] PM: late suspend of devices complete after 3.784 msecs
> [   60.059753] Disabling non-boot CPUs ...
> [   64.299865] Successfully put all powerdomains to target state
> [   64.302551] PM: early resume of devices complete after 2.319 msecs
> [   64.636444] PM: resume of devices complete after 332.336 msecs
> [   64.688446] Restarting tasks ... done.
> [root@beagleboard /]#
> 
> And then print again the CM_EMU (48005100) clkstctrl register offset 
> 48 this will have the reset value and PRM_EMU (48307100) offset e4 => 
> 00000100 register confirms the domain wakeup reset from OFF.
> 
> At this moment the SDTI serial trace interface looses connection.
> 
> With my patch applied the CM_EMU (48005100) clkstctrl register 
> restores it initial setting across MPU OFF.

Maybe you can walk through these thoughts with me and see if it makes
sense to you.

When the PM code initializes, it will put the EMU clockdomain to
software-supervised sleep.  (Ideally it would put it to
hardware-supervised idle, but Jouni turned this off a long time ago,
apparently due to some PRCM usecounting problem with it -- which may
simply have been some software problem on our part?)

That accounts for CM_CLKSTCTRL_EMU being set to 0x1 before MPU OFF.
Does the SDTI work for you when CM_CLKSTCTRL_EMU is set to 0x1? There's
no FCLKEN/ICLKEN bit for the PRCM to use-count, it seems :-( Although
maybe this is done through the SDTI_WINCTRL register?

I observe the same phenomenon that you do, that when MPU comes back from
OFF, CM_CLKSTCTRL_EMU is set to 0x2.  From reading the TRM, it's not
clear to me what is causing that, although I'd agree with your
conclusion that it's related to the MPU's reset line.

But here's the part that's unclear to me about your description:
according to the TRM, 0x2 means software-supervised wakeup.  So the EMU
clockdomain should be awake at that point.  That shouldn't prevent the
SDTI from working; in fact quite the opposite.  So I don't really
understand how your patch would fix anything in this regard.  Any
thoughts?

My suspicion, by the way, is that the underlying problem may be with the
SDTI driver that you're using.  My guess would be that it's not
integrated with the OMAP power management infrastructure (via
pm_runtime* calls), and that's what's causing the problem.

[Gowda] I found this BUG in the CM code while trying to use both SDTI as
well as requirement of enabling Hardware supervised transition
CLKTRCTRL_EMU to 0x3.

SDTI requires the softwre supervised transition to keep connected, by
enabling Hardware supervised transition SDTI does not like it so Jouni
had commented out the HW supervised transtion. Which I agree it is fine
on SDTI part.
.flags          = /* CLKDM_CAN_ENABLE_AUTO |  */CLKDM_CAN_SWSUP,

But my point here is when I set the HW supervised transition, across MPU
OFF the register loses its previous value and changes to reset value 0x2
(SW supervised) is not correct. So I submitted this patch for fixing
this general CM code bug.

Please let me know if my comments answers your question.


- Paul
