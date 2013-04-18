From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [PATCH 2/8] ARM: OMAP2+: hwmod: Cleanup sidle/mstandby programming
Date: Thu, 18 Apr 2013 16:23:07 +0530
Message-ID: <516FD093.1020607@ti.com>
References: <1361354272-18089-1-git-send-email-santosh.shilimkar@ti.com> <1361354272-18089-3-git-send-email-santosh.shilimkar@ti.com> <alpine.DEB.2.00.1303310053351.6436@utopia.booyaka.com> <515947D3.50904@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:57367 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S967253Ab3DRKx2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Apr 2013 06:53:28 -0400
In-Reply-To: <515947D3.50904@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-omap@vger.kernel.org, linux@arm.linux.org.uk, khilman@deeprootsystems.com, tony@atomide.com, sourav.poddar@ti.com, vaibhav.bedia@ti.com, linux-arm-kernel@lists.infradead.org

Hi Paul,

>>> _enable_wakeup() and _disable_wakeup() are expected to program the
>>> OCP_SYSCONFIG.ENAWAKEUP bit.
>>
>> These functions were originally intended to take care of everything needed 
>> for the IP block to wake up the chip, including the PRCM WKEN programming.  
>> ENAWAKEUP is simply one part of that.
>>
>>> Get rid of the additional sidle/mstandby programming in them, as its 
>>> confusing (this is expected to be handled elsewhere as part of 
>>> _enable_sysc()/__idle_sysc())
>>
>> Sorry, why does the expectation exist for the code to enable and disable 
>> device wakeup to be part of _enable_sysc()/_idle_sysc(), rather than in 
>> functions called by _enable_sysc()/_idle_sysc()?
> 
> It all comes down to if SIDLE_SMART_WKUP/MSTANDBY_SMART_WKUP programming
> be considered as 'idlemode' programming or 'enwakeup' programming.
> If you consider these are being part of 'enwakeup' progrmming, these should
> certainly be handled as part of _enable_wakeup() and _disable_wakeup().
> 
> Today, in some cases, these are *also* handled as part of _enable_sysc()
> and _idle_sysc(). The way _enable_wakeup() is invoked from _enable_sysc()
> is also very inconsistent. For instance, for any IP which supports
> SYSC_HAS_MIDLEMODE and SYSC_HAS_ENAWAKEUP, we invoke _enable_wakeup()
> regardless of the MIDLEMODE programmmed.
> While in case of the IP supporting SYSC_HAS_SIDLEMODE, _enable_wakeup() is
> invoked only when the SIDLEMODE programmed is SMART or SMART_WKUP.
> 
> I understand the cleanups you are suggesting below as part of the movement
> of some of these things outside of mach-omap2.
> I was more looking at fixing the existing piece so its readable and does
> things more consistently.

Do you have any further thoughts on how we should do about this?

regards,
Rajendra

> 
> regards,
> Rajendra
> 
>>
>>> and unnecessary.
>>
>> So here's part of the reason why the module wakeup control functions 
>> should remain separate.  When the kernel boots, all the PM features should 
>> be disabled.  Then mach-omap2/pm*.c should enables PM features where 
>> they're needed.
>>
>> Right now, mach-omap2/pm34xx.c sets module WKEN bits.  (These direct 
>> register accesses need to be moved as part of the cleanup work, of moving 
>> the PM/PRM/CM code into drivers.)  But the list of IP blocks that 
>> should be allowed to wake the system is board-dependent.
>>
>> So really, what mach-omap2/pm34xx.c should do is to call into the hwmod 
>> enable-wakeups code to enable MPU wakeups for all the IP blocks that have 
>> some DT property set, something like 'enable-wakeups'.  Then the hwmod 
>> code should ensure that the PRM wakeup-enable and GRPSEL bits are 
>> programmed (by calling into the PRM driver code) and should then either 
>> set the ENAWAKEUP bits or put the module into smart_wkup MSTANDBY/MIDLE.
>>
>> Similarly, when the PM driver is unloaded, it should set no-idle on all 
>> the IP blocks that were marked as wakeup-capable and disable the PRCM 
>> wakeup control bits, by calling some hwmod disable-wakeups code.
>>
>>> Well, the _enable_sysc()/_idle_sysc() handled only the mstandby modes
>>> correctly. So fix them so they also handle the midle modes correctly
>>
>> If there's a fix here, please split that out into a separate patch.
>>
>>
>> - Paul
>>
> 

