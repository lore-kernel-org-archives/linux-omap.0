From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: oprofile and ARM A9 hardware counter
Date: Tue, 8 May 2012 13:01:19 +0200
Message-ID: <4FA8FCFF.40105@ti.com>
References: <20120403092524.GD17741@mudshark.cambridge.arm.com> <CAMQu2gxE2STYxUGinzstX6W8jyofH829A__NQBjwLqZd9cqy=w@mail.gmail.com> <20120403094749.GH17741@mudshark.cambridge.arm.com> <CAMQu2gyFirtVTWpMu4G_qG5sq33J-_s_o2JhVAdrUf7P3qJ3AA@mail.gmail.com> <20120403123444.GL17741@mudshark.cambridge.arm.com> <878vicsxef.fsf@ti.com> <20120403160706.GP17741@mudshark.cambridge.arm.com> <87ehs4pfw4.fsf@ti.com> <alpine.DEB.2.00.1204031727380.8000@utopia.booyaka.com> <20120404111524.GF32505@mudshark.cambridge.arm.com> <20120426180719.GC20186@mudshark.cambridge.arm.com> <4FA45580.8070802@ti.com> <87ipg76hfm.fsf@ti.com> <4FA8284C.7080803@ti.com> <87k40nzi3i.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:59069 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752874Ab2EHLCB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 May 2012 07:02:01 -0400
In-Reply-To: <87k40nzi3i.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>, Jon Hunter <jon-hunter@ti.com>
Cc: Will Deacon <will.deacon@arm.com>, Paul Walmsley <paul@pwsan.com>, Ming Lei <ming.lei@canonical.com>, Maynard Johnson <maynardj@us.ibm.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "oprofile-list@lists.sourceforge.net" <oprofile-list@lists.sourceforge.net>, Lik Lik <lik88888@gmail.com>, "eranian@gmail.com" <eranian@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hi Kevin & Jon,

On 5/8/2012 1:28 AM, Kevin Hilman wrote:
> Jon Hunter<jon-hunter@ti.com>  writes:
>
>> Hi Kevin,
>>
>> On 05/07/2012 12:15 PM, Kevin Hilman wrote:
>>> Jon Hunter<jon-hunter@ti.com>  writes:
>>>
>>>> Hi Will,
>>>>
>>>> On 04/26/2012 01:07 PM, Will Deacon wrote:
>>>>> On Wed, Apr 04, 2012 at 12:15:24PM +0100, Will Deacon wrote:
>>>>>> On Wed, Apr 04, 2012 at 12:29:49AM +0100, Paul Walmsley wrote:
>>>>>>>
>>>>>>> Part of the problem is that the clockdomain data for the emu_sys
>>>>>>> clockdomain is wrong.  Here's something to try to fix it.  It might just
>>>>>>> be enough to get it to work.
>>>>>>
>>>>>> Hmm, doesn't seem to work but I do see the following in dmesg when I try to
>>>>>> use perf:
>>>>>>
>>>>>>   powerdomain: waited too long for powerdomain emu_pwrdm to complete transition
>>>>>>
>>>>>> which is new with your patch.
>>>>>
>>>>> Sorry to nag, but does anybody have a clue where to go from here? I can
>>>>> start digging in the OMAP PM code, but it's all new territory for me.
>>>>
>>>> I did a little playing around with this today and I think that I have figured out why this was not working (see below). Please can you try the following patch? I tried this on top of your series for perf/omap4.
>>>>
>>>> Paul, FYI. If this works for Will then I can re-base on top of the latest linux-omap and submit to the mailing list.
>>>>
>>>> Also, the above error about the emu_pwrdm is odd too. I noticed that the emu_pwrdm is always in the transitioning state. And when I say always, I mean that even if I check the power domain state while u-boot is running it is in the transitioning state. So even before the kernel starts.
>>>>
>>>> Cheers
>>>> Jon
>>>>
>>>>  From 9137ff9c1b382232de7443db0b51b7555846fb62 Mon Sep 17 00:00:00 2001
>>>> From: Jon Hunter<jon-hunter@ti.com>
>>>> Date: Fri, 4 May 2012 16:48:45 -0500
>>>> Subject: [PATCH] ARM: OMAP4: Disable auto enable for EMU CLKDM
>>>>
>>>> The flag CLKDM_CAN_HWSUP allows the clock-domain to automatically transition
>>>> to the enabled and disabled state. This means that as soon as we force a
>>>> software wake-up on the clock domain, the clock domain will be allowed to idle
>>>> and put back into the hardware auto state. For the EMU clock domain this is not
>>>> what we want. We want to keep the clock domain in the software wakeup state
>>>> while the clock domain is being used and put it back in to the hardware auto
>>>> state when we have finished using the clock domain.
>>>>
>>>> Signed-off-by: Jon Hunter<jon-hunter@ti.com>
>>>
>>> With this patch, how is the clkdm ever idled?
>>
>> It does not! Sorry, I was so engrossed with figuring out why the EMU
>> clkdm was being idled as soon as it was enabled, I forgot to check if is
>> ever disabled once we terminated perf :-(
>>
>>> IIUC, your patch will get PMU interrupts working, but similarily to
>>> previous patches in this thread, it works because it *never* allows the
>>> EMU clkdm to idle.  This is not a mergeable solution because it will not
>>> allow CORE retention (and thus full-chip retention.)
>>
>> Right!
>>
>>> What we need is a solution that allows the clkdm to idle, and then to be
>>> reinitialzed when it wakes up.  Due to the way (I understand) resets in
>>> the debugss, allowing the clkdm to idle will cause a reset, so the
>>> PMU/CTI interrupts need to be reinitialzied after wakeup.
>>
>> Yes exactly I see that now. I have prototyped the 3 patches and this is
>> working AND the EMU clkdm does go back to idle. I can send out to the
>> list for review.
>
> Perfect, thanks.
>
>>> Kevin
>>>
>>> P.S. Please note there is also already a different fix in mainline for
>>> the EMU clkdm data from Paul which adds the force wakeup flag and
>>> removes the DISABLE_AUTO flag[1] (but leaves the ENABLE_AUTO flag,
>>> because the hardware is capable.)
>>
>> Hmmm ... yes saw this, and you will have to excuse me as I don't fully
>> follow the logic here. In fact, I am thinking we want the opposite ;-)
>>
>>  From looking, into this it seems to me that when PMU is running we want
>> the EMU clock domain in software-wakeup state and when PMU is not
>> running we want in the hardware auto state.
>
> So far, I'm with you.
>
>> By keeping the ENABLE_AUTO flag set, as soon as we enable the clock
>> domain it is put right back into the HW_AUTO state
>
> This is only because it was in the HWSUP state when _enable was called.
> If clkdm_deny_idle() is used, that behavior will change.
>
>> and hence PMU is
>> not working (see _enable() function in
>> arch/arm/mach-omap2/omap_hwmod.c)
>>
>> So really what I think we want is to remove the ENABLE_AUTO flag to keep
>> the clock domain in software wake-up and use the DISABLE_AUTO flag to
>> put the clock domain back in HW_AUTO (note this requires a patch to
>> perform this 2nd part).
>
> Well, Paul will have to comment here for the final word, but IIUC, the
> hwmod flags are supposed to indicate only what the HW is capable of.  If
> we want to change the runtime behavior, we nee to use (or add) APIs to
> change the beahvior.  In this case, clkdm_allow_idle(),
> clkdm_deny_idle() are probably what is needed here.

Yes, indeed, we should not hack the flags to fix that kind of issue. The 
flags describe what the HW is capable of, and the EMU CD can support 
HW_AUTO and SW_WAKEUP. AFAIK, the issue with that EMU CD is that the 
only valid next power state is OFF, meaning that no retention mode is 
supported. So any transition to idle will go to OFF and lead to a reset 
upon wakeup.

That being said, being able to transition to OFF during idle is a 
perfectly valid state for most powerdomain in OMAP anyway, so we should 
be able to restore from OFF mode smoothly.

It looks to me that what is missing here is *just* a restore path in the 
PMU/CTI code. But I'm probably missing some nasty details in this issue :-)

Regards,
Benoit

