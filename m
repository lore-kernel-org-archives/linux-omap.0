From: Kevin Hilman <khilman@ti.com>
Subject: Re: oprofile and ARM A9 hardware counter
Date: Tue, 08 May 2012 14:22:22 -0700
Message-ID: <87sjfal65t.fsf@ti.com>
References: <20120403092524.GD17741@mudshark.cambridge.arm.com>
	<CAMQu2gxE2STYxUGinzstX6W8jyofH829A__NQBjwLqZd9cqy=w@mail.gmail.com>
	<20120403094749.GH17741@mudshark.cambridge.arm.com>
	<CAMQu2gyFirtVTWpMu4G_qG5sq33J-_s_o2JhVAdrUf7P3qJ3AA@mail.gmail.com>
	<20120403123444.GL17741@mudshark.cambridge.arm.com>
	<878vicsxef.fsf@ti.com>
	<20120403160706.GP17741@mudshark.cambridge.arm.com>
	<87ehs4pfw4.fsf@ti.com>
	<alpine.DEB.2.00.1204031727380.8000@utopia.booyaka.com>
	<20120404111524.GF32505@mudshark.cambridge.arm.com>
	<20120426180719.GC20186@mudshark.cambridge.arm.com>
	<4FA45580.8070802@ti.com> <87ipg76hfm.fsf@ti.com>
	<4FA8284C.7080803@ti.com> <87k40nzi3i.fsf@ti.com>
	<4FA8FCFF.40105@ti.com> <4FA9588E.9020906@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:56612 "EHLO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753064Ab2EHVWM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 May 2012 17:22:12 -0400
Received: by dacx6 with SMTP id x6so541837dac.17
        for <linux-omap@vger.kernel.org>; Tue, 08 May 2012 14:22:10 -0700 (PDT)
In-Reply-To: <4FA9588E.9020906@ti.com> (Jon Hunter's message of "Tue, 8 May
	2012 12:31:58 -0500")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: "Cousson, Benoit" <b-cousson@ti.com>, Will Deacon <will.deacon@arm.com>, Paul Walmsley <paul@pwsan.com>, Ming Lei <ming.lei@canonical.com>, Maynard Johnson <maynardj@us.ibm.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "oprofile-list@lists.sourceforge.net" <oprofile-list@lists.sourceforge.net>, Lik Lik <lik88888@gmail.com>, "eranian@gmail.com" <eranian@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Jon Hunter <jon-hunter@ti.com> writes:

> Hi Benoit,
>
> On 05/08/2012 06:01 AM, Cousson, Benoit wrote:
>
> [...]
>
>>>>> P.S. Please note there is also already a different fix in mainline for
>>>>> the EMU clkdm data from Paul which adds the force wakeup flag and
>>>>> removes the DISABLE_AUTO flag[1] (but leaves the ENABLE_AUTO flag,
>>>>> because the hardware is capable.)
>>>>
>>>> Hmmm ... yes saw this, and you will have to excuse me as I don't fully
>>>> follow the logic here. In fact, I am thinking we want the opposite ;-)
>>>>
>>>>  From looking, into this it seems to me that when PMU is running we want
>>>> the EMU clock domain in software-wakeup state and when PMU is not
>>>> running we want in the hardware auto state.
>>>
>>> So far, I'm with you.
>>>
>>>> By keeping the ENABLE_AUTO flag set, as soon as we enable the clock
>>>> domain it is put right back into the HW_AUTO state
>>>
>>> This is only because it was in the HWSUP state when _enable was called.
>>> If clkdm_deny_idle() is used, that behavior will change.
>>>
>>>> and hence PMU is
>>>> not working (see _enable() function in
>>>> arch/arm/mach-omap2/omap_hwmod.c)
>>>>
>>>> So really what I think we want is to remove the ENABLE_AUTO flag to keep
>>>> the clock domain in software wake-up and use the DISABLE_AUTO flag to
>>>> put the clock domain back in HW_AUTO (note this requires a patch to
>>>> perform this 2nd part).
>>>
>>> Well, Paul will have to comment here for the final word, but IIUC, the
>>> hwmod flags are supposed to indicate only what the HW is capable of.  If
>>> we want to change the runtime behavior, we nee to use (or add) APIs to
>>> change the beahvior.  In this case, clkdm_allow_idle(),
>>> clkdm_deny_idle() are probably what is needed here.
>> 
>> Yes, indeed, we should not hack the flags to fix that kind of issue. The
>> flags describe what the HW is capable of, and the EMU CD can support
>> HW_AUTO and SW_WAKEUP. AFAIK, the issue with that EMU CD is that the
>> only valid next power state is OFF, meaning that no retention mode is
>> supported. So any transition to idle will go to OFF and lead to a reset
>> upon wakeup.
>
> No hacking intended here, just getting the flags correct ;-)
>
> So let me start from the beginning ...
>
> 1. I agree that for the EMU CD that the valid HW states are HW_AUTO and
> SW_WKUP.
>
> 2. When the EMU CD is active (due to something like PMU), we want to
> keep the CD in the SW_WKUP state, otherwise we can automatically
> transition to idle and reset the IP (at least for omap4430).

> 3. When the EMU CD is inactive, we want to keep the CD in the HW_AUTO
> state because SW_SLEEP is NOT supported.
>
> In the current code, we have the CLKDM_CAN_DISABLE_AUTO flag disabled
> and the CLKDM_CAN_ENABLE_AUTO flag enabled. If CLKDM_CAN_ENABLE_AUTO is
> set then the omap_pm_clkdms_setup() function will place the CD into
> HW_AUTO regardless of CLKDM_CAN_DISABLE_AUTO, and the next time the
> hwmod _enable() is called it is in the HW_AUTO state and so it is
> allowed to idle. This is not what we want. Do you agree?
>
> If I set CLKDM_CAN_DISABLE_AUTO flag and disable CLKDM_CAN_ENABLE_AUTO,
> then I do not have the above problem.
>
> To be honest, with you the more I look and test the code, the more
> confused I am by the definition of the CLKDM_CAN_HWSUP ...
>
> #define CLKDM_CAN_HWSUP	(CLKDM_CAN_ENABLE_AUTO | CLKDM_CAN_DISABLE_AUTO)
>
> When I look at where these flags are used, I see that
> CLKDM_CAN_ENABLE_AUTO is used in clkdm_allow_idle and
> CLKDM_CAN_DISABLE_AUTO is used in clkdm_deny_idle. So this implies that ...
>
> CLKDM_CAN_ENABLE_AUTO = Supports HW_AUTO state when CD is active
> CLKDM_CAN_DISABLE_AUTO = Does NOT supports HW_AUTO state when CD is active
>
> Are the above the correct definitions? 

Not quite. 

These flags describe the capabilities as defined in CLKTRCTRL field of
the CLKSTCTRL register (e.g. CM_EMU_CLKSTCTRL)

CLKDM_CAN_ENABLE_AUTO: IP supports HW_AUTO state (and it can be enabled)
CLKDM_CAN_DISABLE_AUTO: HW_AUTO feature can be disabled (a.k.a. NO_SLEEP)

Note that in OMAP4, the latter called NO_SLEEP in the TRM, but in OMAP3
it's described as "The automatic hardware-supervised mode is disabled"

What is confusing to me is that the OMAP4 TRM doesn't list the NO_SLEEP
mode as supported by the EMU.   It seems to me that if the IP supports
HW_AUTO, it should be able to be enabled *and* disabled. 

Maybe Paul/Benoit can clarify.

Kevin


