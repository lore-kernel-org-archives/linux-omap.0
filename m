From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH] ARM: OMAP2+: watchdog: fix !PM boot crash, disarm timer after hwmod reset
Date: Mon, 23 Apr 2012 10:42:13 -0700
Message-ID: <87zka2jqfe.fsf@ti.com>
References: <1334353873-15972-1-git-send-email-khilman@ti.com>
	<alpine.DEB.2.00.1204201451510.11306@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog133.obsmtp.com ([74.125.149.82]:36118 "EHLO
	na3sys009aog133.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752698Ab2DWRmL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 23 Apr 2012 13:42:11 -0400
Received: by daev18 with SMTP id v18so4400904dae.6
        for <linux-omap@vger.kernel.org>; Mon, 23 Apr 2012 10:42:07 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1204201451510.11306@utopia.booyaka.com> (Paul
	Walmsley's message of "Fri, 20 Apr 2012 14:59:59 -0600 (MDT)")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, santosh.shilimkar@ti.com, linux-arm-kernel@lists.infradead.org

Paul Walmsley <paul@pwsan.com> writes:

> cc Santosh
>
> Hi Kevin,
>
> Nice changelog!
>
> On Fri, 13 Apr 2012, Kevin Hilman wrote:
>
>> Without runtime PM enabled, hwmod needs to leave all IP blocks in an
>> enabled state by default so any driver access to the HW will succeed.
>> This is accomplished by seting the postsetup_state to enabled for all
>> hwmods during init when runtime PM is disabled.
>> 
>> Currently, we have a special case for WDT in that its postsetup_state
>> is always set to disabled.  This is done so that the WDT is disabled
>> and the timer is disarmed at boot in case there is no WDT driver.
>> This also means that when runtime PM is disabled, if a WDT driver *is*
>> built in the kernel, the kernel will crash on the first access to the
>> WDT hardware.
>> 
>> We can't simply leave the WDT module enabled, because the timer is
>> armed by default after reset. That means that if there is no WDT
>> driver initialzed or loaded before the timer expires, the kernel will
>> reboot.
>> 
>> To fix this, a custom reset method is added to the watchdog class of
>> omap_hwmod.  This method will *always* disarm the timer after hwmod
>> reset.  The WDT timer then will only be rearmed when/if the driver is
>> loaded for the WDT.  With the timer disarmed by default, we no longer
>> need a special-case for the postsetup_state of WDT during init, so it
>> is removed.
>> 
>> Any platforms wishing to ensure the watchdog remains armed across the
>> entire boot boot can simply disable the reset-on-init feature of the
>> watchdog hwmod using omap_hwmod_no_setup_reset().
>> 
>> Tested on 3530/Overo, 4430/Panda.
>> 
>> NOTE: on 4430, the hwmod OCP reset does not seem to rearm the timer as
>> documented in the TRM (and what happens on OMAP3.)  I noticed this
>> because testing the HWMOD_INIT_NO_RESET feature with no driver loaded,
>> I expected a reboot part way through the boot, but did not see a
>> reboot.  Adding some debug to read the counter, I verified that right
>> after OCP softreset, the counter is not firing.  After writing the
>> magic start sequence, the timer starts counting.  This means that the
>> timer disarm sequence added here does not seem to be needed for 4430,
>> but is technically the correct way to ensure the timer is disarmed, so
>> it is left in for OMAP4.
>> 
>> Special thanks to Paul Walmsley for helping brainstorm ideas to fix
>> this problem.
>> 
>> Cc: Paul Walmsley <paul@pwsan.com>
>> Signed-off-by: Kevin Hilman <khilman@ti.com>
>
> This looks great, looks like it will finally fix this longstanding bug.  I 
> think Santosh hit it too a long time ago, so I suspect he will be happy 
> too.
>
> One comment: I think that omap2_wd_timer_reset() needs to be updated in 
> light of commit 3c55c1baffa5f719eb2ae9729088bc867f972f53 ("ARM: OMAP2+: 
> hwmod: Revert "ARM: OMAP2+: hwmod: Make omap_hwmod_softreset wait for 
> reset status"").  I did this here.  It's passed basic build testing but 
> haven't tried booting it yet.  Care to take a look and see if you have any 
> comments?  It's also available in the 'hwmod_devel_a_3.5' branch of 
> git://git.pwsan.com/linux-2.6

I did some testing on OMAP3530/Overo and it still works fine with your
change.

> Also, am thinking about queuing this for 3.5 rather than 3.4-rc fixes due 
> to the massive hwmod data changes queued for 3.5, and since we've 
> suffered with this bug for at least a year, but wanted to run it by you 
> first.  That should save Tony some rebase hassle.  Any opinions on this?

I'm fine with waiting for 3.5 since it's a long-standing bug and not
really a regresstion.

Thanks for updating it,

Kevin
