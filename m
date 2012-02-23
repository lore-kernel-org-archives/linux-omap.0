From: Paul Walmsley <paul@pwsan.com>
Subject: RE: [GIT PULL] OMAP PM EMU fix for v3.3
Date: Wed, 22 Feb 2012 21:09:16 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1202222021460.12198@utopia.booyaka.com>
References: <87liw8agk4.fsf@ti.com><AA48DD8077D5D945A49BD1782C1140F1011EBBC7@fioues08.ebgroup.elektrobit.com><20120127190239.GC9339@atomide.com><AA48DD8077D5D945A49BD1782C1140F1011EBBC8@fioues08.ebgroup.elektrobit.com><AA48DD8077D5D945A49BD1782C1140F10122E2B7@fioues08.ebgroup.elektrobit.com>
 <87linxa5gk.fsf@ti.com> <AA48DD8077D5D945A49BD1782C1140F10122E4FF@fioues08.ebgroup.elektrobit.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:53111 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753626Ab2BWEJR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 22 Feb 2012 23:09:17 -0500
In-Reply-To: <AA48DD8077D5D945A49BD1782C1140F10122E4FF@fioues08.ebgroup.elektrobit.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Madhusudhan.Gowda@elektrobit.com
Cc: khilman@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com

Hello Gowda,

A few questions...

On Wed, 22 Feb 2012, Madhusudhan.Gowda@elektrobit.com wrote:

> I have tested this on beagle board as well as on OMAP3630 based
> propriatory phone using SDTI serial trace interface.

What driver are you using for SDTI?  Does it use pm_runtime* or call 
clk_enable() on some clock when it is in use?  Are you defining a hwmod 
for it?  I don't see an SDTI driver in mainline, but maybe I am just 
missing it.  If it's not there, could you please post it or post a link to 
it so we can take a look at what it's doing?

> Also you can test it by just observing the 
> CM_EMU (48005100) clkstctrl register
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
> [   59.758209] Freezing user space processes ... (elapsed 0.02 seconds)
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
> And then print again the CM_EMU (48005100) clkstctrl register offset 48
> this will have the reset value and PRM_EMU (48307100) offset e4 =>
> 00000100 register confirms the domain wakeup reset from OFF.
> 
> At this moment the SDTI serial trace interface looses connection.
> 
> With my patch applied the CM_EMU (48005100) clkstctrl register restores
> it initial setting across MPU OFF.

Maybe you can walk through these thoughts with me and see if it makes 
sense to you.

When the PM code initializes, it will put the EMU clockdomain to 
software-supervised sleep.  (Ideally it would put it to 
hardware-supervised idle, but Jouni turned this off a long time ago, 
apparently due to some PRCM usecounting problem with it -- which may 
simply have been some software problem on our part?)

That accounts for CM_CLKSTCTRL_EMU being set to 0x1 before MPU OFF.  Does 
the SDTI work for you when CM_CLKSTCTRL_EMU is set to 0x1? There's no 
FCLKEN/ICLKEN bit for the PRCM to use-count, it seems :-( Although maybe 
this is done through the SDTI_WINCTRL register?

I observe the same phenomenon that you do, that when MPU comes back from 
OFF, CM_CLKSTCTRL_EMU is set to 0x2.  From reading the TRM, it's not clear 
to me what is causing that, although I'd agree with your conclusion that 
it's related to the MPU's reset line.

But here's the part that's unclear to me about your description: according 
to the TRM, 0x2 means software-supervised wakeup.  So the EMU clockdomain 
should be awake at that point.  That shouldn't prevent the SDTI from 
working; in fact quite the opposite.  So I don't really understand how 
your patch would fix anything in this regard.  Any thoughts?

My suspicion, by the way, is that the underlying problem may be with the 
SDTI driver that you're using.  My guess would be that it's not integrated 
with the OMAP power management infrastructure (via pm_runtime* calls), 
and that's what's causing the problem.


- Paul
