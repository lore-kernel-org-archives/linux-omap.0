From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: oprofile and ARM A9 hardware counter
Date: Wed, 9 May 2012 13:04:19 -0500
Message-ID: <4FAAB1A3.9040806@ti.com>
References: <20120403092524.GD17741@mudshark.cambridge.arm.com> <CAMQu2gxE2STYxUGinzstX6W8jyofH829A__NQBjwLqZd9cqy=w@mail.gmail.com> <20120403094749.GH17741@mudshark.cambridge.arm.com> <CAMQu2gyFirtVTWpMu4G_qG5sq33J-_s_o2JhVAdrUf7P3qJ3AA@mail.gmail.com> <20120403123444.GL17741@mudshark.cambridge.arm.com> <878vicsxef.fsf@ti.com> <20120403160706.GP17741@mudshark.cambridge.arm.com> <87ehs4pfw4.fsf@ti.com> <alpine.DEB.2.00.1204031727380.8000@utopia.booyaka.com> <20120404111524.GF32505@mudshark.cambridge.arm.com> <20120426180719.GC20186@mudshark.cambridge.arm.com> <4FA45580.8070802@ti.com> <87ipg76hfm.fsf@ti.com> <4FA8284C.7080803@ti.com> <87k40nzi3i.fsf@ti.com> <4FA8FCFF.40105@ti.com> <4FA9588E.9020906@ti.com> <87sjfal65t.fsf@ti.com> <4FAA4DB9.8060504@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:36055 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751494Ab2EISEj (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 9 May 2012 14:04:39 -0400
In-Reply-To: <4FAA4DB9.8060504@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: Kevin Hilman <khilman@ti.com>, Will Deacon <will.deacon@arm.com>, Paul Walmsley <paul@pwsan.com>, Ming Lei <ming.lei@canonical.com>, Maynard Johnson <maynardj@us.ibm.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "oprofile-list@lists.sourceforge.net" <oprofile-list@lists.sourceforge.net>, Lik Lik <lik88888@gmail.com>, "eranian@gmail.com" <eranian@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hi Benoit,

On 05/09/2012 05:58 AM, Cousson, Benoit wrote:
> Hi Kevin and Jon,
> 
> On 5/8/2012 11:22 PM, Kevin Hilman wrote:
>> Jon Hunter<jon-hunter@ti.com>  writes:
>>
>>> Hi Benoit,
>>>
>>> On 05/08/2012 06:01 AM, Cousson, Benoit wrote:
>>>
>>> [...]
>>>
>>>>>>> P.S. Please note there is also already a different fix in mainline for
>>>>>>> the EMU clkdm data from Paul which adds the force wakeup flag and
>>>>>>> removes the DISABLE_AUTO flag[1] (but leaves the ENABLE_AUTO flag,
>>>>>>> because the hardware is capable.)
>>>>>>
>>>>>> Hmmm ... yes saw this, and you will have to excuse me as I don't fully
>>>>>> follow the logic here. In fact, I am thinking we want the opposite ;-)
>>>>>>
>>>>>>   From looking, into this it seems to me that when PMU is running we want
>>>>>> the EMU clock domain in software-wakeup state and when PMU is not
>>>>>> running we want in the hardware auto state.
>>>>>
>>>>> So far, I'm with you.
>>>>>
>>>>>> By keeping the ENABLE_AUTO flag set, as soon as we enable the clock
>>>>>> domain it is put right back into the HW_AUTO state
>>>>>
>>>>> This is only because it was in the HWSUP state when _enable was called.
>>>>> If clkdm_deny_idle() is used, that behavior will change.
>>>>>
>>>>>> and hence PMU is
>>>>>> not working (see _enable() function in
>>>>>> arch/arm/mach-omap2/omap_hwmod.c)
>>>>>>
>>>>>> So really what I think we want is to remove the ENABLE_AUTO flag to keep
>>>>>> the clock domain in software wake-up and use the DISABLE_AUTO flag to
>>>>>> put the clock domain back in HW_AUTO (note this requires a patch to
>>>>>> perform this 2nd part).
>>>>>
>>>>> Well, Paul will have to comment here for the final word, but IIUC, the
>>>>> hwmod flags are supposed to indicate only what the HW is capable of.  If
>>>>> we want to change the runtime behavior, we nee to use (or add) APIs to
>>>>> change the beahvior.  In this case, clkdm_allow_idle(),
>>>>> clkdm_deny_idle() are probably what is needed here.
>>>>
>>>> Yes, indeed, we should not hack the flags to fix that kind of issue. The
>>>> flags describe what the HW is capable of, and the EMU CD can support
>>>> HW_AUTO and SW_WAKEUP. AFAIK, the issue with that EMU CD is that the
>>>> only valid next power state is OFF, meaning that no retention mode is
>>>> supported. So any transition to idle will go to OFF and lead to a reset
>>>> upon wakeup.
>>>
>>> No hacking intended here, just getting the flags correct ;-)
>>>
>>> So let me start from the beginning ...
>>>
>>> 1. I agree that for the EMU CD that the valid HW states are HW_AUTO and
>>> SW_WKUP.
>>>
>>> 2. When the EMU CD is active (due to something like PMU), we want to
>>> keep the CD in the SW_WKUP state, otherwise we can automatically
>>> transition to idle and reset the IP (at least for omap4430).
>>
>>> 3. When the EMU CD is inactive, we want to keep the CD in the HW_AUTO
>>> state because SW_SLEEP is NOT supported.
>>>
>>> In the current code, we have the CLKDM_CAN_DISABLE_AUTO flag disabled
>>> and the CLKDM_CAN_ENABLE_AUTO flag enabled. If CLKDM_CAN_ENABLE_AUTO is
>>> set then the omap_pm_clkdms_setup() function will place the CD into
>>> HW_AUTO regardless of CLKDM_CAN_DISABLE_AUTO, and the next time the
>>> hwmod _enable() is called it is in the HW_AUTO state and so it is
>>> allowed to idle. This is not what we want. Do you agree?
>>>
>>> If I set CLKDM_CAN_DISABLE_AUTO flag and disable CLKDM_CAN_ENABLE_AUTO,
>>> then I do not have the above problem.
>>>
>>> To be honest, with you the more I look and test the code, the more
>>> confused I am by the definition of the CLKDM_CAN_HWSUP ...
>>>
>>> #define CLKDM_CAN_HWSUP	(CLKDM_CAN_ENABLE_AUTO | CLKDM_CAN_DISABLE_AUTO)
>>>
>>> When I look at where these flags are used, I see that
>>> CLKDM_CAN_ENABLE_AUTO is used in clkdm_allow_idle and
>>> CLKDM_CAN_DISABLE_AUTO is used in clkdm_deny_idle. So this implies that ...
>>>
>>> CLKDM_CAN_ENABLE_AUTO = Supports HW_AUTO state when CD is active
>>> CLKDM_CAN_DISABLE_AUTO = Does NOT supports HW_AUTO state when CD is active
>>>
>>> Are the above the correct definitions?
>>
>> Not quite.
>>
>> These flags describe the capabilities as defined in CLKTRCTRL field of
>> the CLKSTCTRL register (e.g. CM_EMU_CLKSTCTRL)
>>
>> CLKDM_CAN_ENABLE_AUTO: IP supports HW_AUTO state (and it can be enabled)
>> CLKDM_CAN_DISABLE_AUTO: HW_AUTO feature can be disabled (a.k.a. NO_SLEEP)
>>
>> Note that in OMAP4, the latter called NO_SLEEP in the TRM, but in OMAP3
>> it's described as "The automatic hardware-supervised mode is disabled"
> 
> Yeah, in fact this is the source of the current confusion for my point of view.
> 
> We chat about that with Paul some time back.
>  
> EMU CD does support HW_AUTO and SW_WKUP, so it means that if you want to disable the AUTO mode you can use the SW_WKUP.
> Assuming that CLKDM_CAN_DISABLE_AUTO is equivalent to NO_SLEEP is thus not correct. In fact any state != HW_AUTO should be considered a non-automatic mode.
> So EMU does support CLKDM_CAN_ENABLE_AUTO, CLKDM_CAN_DISABLE_AUTO and CLKDM_CAN_FORCE_WAKEUP.
> 
> But the way it is implemented does not really allow that, because disable hwsup imply setting state to OMAP34XX_CLKSTCTRL_DISABLE_AUTO.
> 
> void omap4_cminst_clkdm_disable_hwsup(u8 part, s16 inst, u16 cdoffs)
> {
>         _clktrctrl_write(OMAP34XX_CLKSTCTRL_DISABLE_AUTO, part, inst, cdoffs);
> }
> 
> So if we want to allow that, some code change are needed in order to set the clkdm mode to OMAP34XX_CLKSTCTRL_FORCE_WAKEUP if OMAP34XX_CLKSTCTRL_DISABLE_AUTO is not supported.
> 
>> What is confusing to me is that the OMAP4 TRM doesn't list the NO_SLEEP
>> mode as supported by the EMU.   It seems to me that if the IP supports
>> HW_AUTO, it should be able to be enabled *and* disabled.
> 
> No, not really, this is mostly OMAP3 legacy, and we do have plan to remove these useless modes going forward. We can effectively disable AUTO mode by going to FORCE_WAKEUP.
> 
> - 0x0 NO_SLEEP A clock domain sleep transition is never initiated, irrespective of the hardware conditions.
> - 0x1 SW_SLEEP A software-forced sleep transition. The transition is initiated when the associated hardware conditions are satisfied
> - 0x2 SW_WKUP A software-forced clock domain wake-up transition is initiated, irrespective of the hardware conditions.
> - 0x3 HW_AUTO Hardware-controlled automatic sleep and wake-up transition is initiated by the PRCM module when the associated hardware conditions are satisfied
> 
> 
> On OMAP4, SW_SLEEP is equivalent to ENABLE_AUTO and 
> NO_SLEEP is equivalent to SW_WKUP. There are some slight differences inside the HW, but in term of functionality this is mostly equivalent.
> 
> 
> Bottom-line, if we fix the omap4_cminst_clkdm_disable_hwsup, we can consider that the EMU CD does support CLKDM_CAN_ENABLE_AUTO, CLKDM_CAN_DISABLE_AUTO and CLKDM_CAN_FORCE_WAKEUP, which is equivalent to CLKDM_CAN_HWSUP | CLKDM_CAN_FORCE_WAKEUP.

Per our discussion and just to re-iterate here for OMAP4+ devices, we
should have ...

CAN_DISABLE_AUTO 	--> SW_WKUP
CAN_ENABLE_AUTO		--> HW_AUTO
CAN_FORCE_WAKEUP	--> SW_WKUP
CAN_FORCE_SLEEP		--> HW_AUTO

Hence, the NO_SLEEP and SW_SLEEP should not be used for OMAP4+ (per the
equivalents highlighted above). At least that is the current theory :-)

Please note that for the EMU power domain, although HW_AUTO and SW_WKUP
are the supported modes, even with the above definitions we still do not
want to enable CAN_ENABLE_AUTO for this CD as the _enable() will place
the CD in HW_AUTO after it has been woken up. So for the EMU CD we would
just want CAN_SWSUP (based on the above). This works so far.

By the way, given this new proposed mapping of flags to modes, I am
still wondering if we should take this a step further and change the
flag names completely :-o

For example, for CDs I see there being (at least) 3 states that we care
about and these are ...

1. The wake-up mode - CDs should be placed in SW_WKUP mode for all
   OMAP devices.
2. The on mode - CDs could be placed in NO_SLEEP (OMAP2/3 only)
   SW_WKUP (eg. OMAP4 EMU CD) or HW_AUTO mode
3. The off mode - CDs could be place in the HW_AUTO or SW_SLEEP
   (OMAP2/3 only) mode.

Note that it is possible for on and off modes to be the same (ie.
HW_AUTO). Given the above states, we should only care about how the CD
is programmed for each state versus what modes the CD actually supports.
Therefore, we could create the following flags ...

CLKDM_WAKEUP_MODE
CLKDM_ON_MODE_NO_SLEEP
CLKDM_ON_MODE_SW_WAKEUP
CLKDM_ON_MODE_HW_AUTO
CLKDM_OFF_MODE_SW_SLEEP
CLKDM_OFF_MODE_HW_AUTO

This would obviously be a bigger change, but I am wondering if this
could simplify the logic and be less confusing? Just a thought ...

Cheers
Jon




