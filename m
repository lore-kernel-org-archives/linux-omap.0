From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: [PATCH v2] clocksource: arm_global_timer: fix suspend resume
Date: Fri, 20 Nov 2015 22:42:14 +0200
Message-ID: <564F85A6.9000605@ti.com>
References: <1448027861-21472-1-git-send-email-grygorii.strashko@ti.com>
 <564F570C.7030409@oracle.com> <564F67ED.9000905@ti.com>
 <CALAqxLVLQLaAq7fPwJnyOWP_dXV39Dh+QreecxSVY35wi=N0Og@mail.gmail.com>
 <564F7447.8000504@ti.com>
 <CALAqxLVjKaRUYFTXkC2s_ViHTt=bpXyFCYkt9+AW-PSwYnOM8A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CALAqxLVjKaRUYFTXkC2s_ViHTt=bpXyFCYkt9+AW-PSwYnOM8A@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: John Stultz <john.stultz@linaro.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Will Deacon <will.deacon@arm.com>, Catalin Marinas <catalin.marinas@arm.com>
Cc: santosh shilimkar <santosh.shilimkar@oracle.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Srinivas Kandagatla <srinivas.kandagatla@gmail.com>, Maxime Coquelin <maxime.coquelin@st.com>, lkml <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, kernel@stlinux.com, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Felipe Balbi <balbi@ti.com>, Tony Lindgren <tony@atomide.com>, Santosh Shilimkar <ssantosh@kernel.org>, Marc Zyngier <marc.zyngier@arm.com>, Sudeep Holla <sudeep.holla@arm.com>linux-arm <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On 11/20/2015 09:32 PM, John Stultz wrote:
> On Fri, Nov 20, 2015 at 11:28 AM, Grygorii Strashko
> <grygorii.strashko@ti.com> wrote:
>> On 11/20/2015 09:09 PM, John Stultz wrote:
>>> On Fri, Nov 20, 2015 at 10:35 AM, Grygorii Strashko
>>> <grygorii.strashko@ti.com> wrote:
>>>> Hi Santosh,
>>>>
>>>> On 11/20/2015 07:23 PM, santosh shilimkar wrote:
>>>>> + Thomas, Marc
>>>>>
>>>>> On 11/20/2015 5:57 AM, Grygorii Strashko wrote:
>>>>>> Now the System stall is observed on TI AM437x based board
>>>>>> (am437x-gp-evm) during resuming from System suspend when ARM Global
>>>>>> timer is selected as clocksource device - SysRq are working, but
>>>>>> nothing else. The reason of stall is that ARM Global timer loses its
>>>>>> contexts.
>>>>>>
>>>>>> The reason of stall is that ARM Global timer loses its contexts during
>>>>>> System suspend:
>>>>>>       GT_CONTROL.TIMER_ENABLE = 0 (unbanked)
>>>>>>       GT_COUNTERx = 0
>>>>>>
>>>>>> Hence, update ARM Global timer driver to reflect above behaviour
>>>>>> - re-enable ARM Global timer on resume GT_CONTROL.TIMER_ENABLE = 1
>>>>>> - ensure clocksource and clockevent devices have coresponding flags
>>>>>>      (CLOCK_SOURCE_SUSPEND_NONSTOP and CLOCK_EVT_FEAT_C3STOP) set
>>>>>>      depending on presence of "always-on" DT property.
>>>>>>
>>>>> Something which loses context in low power states can't be
>>>>> called "always-on"
>>>>
>>>> Sry, it's kinda new area for me and I could make mistakes.
>>>>
>>>> While working on this patch I've:
>>>>    - re-used implementation from ARM arch timer
>>>> commit 82a5619410d4c4df65c04272db198eca5a867c18
>>>> Author: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
>>>> Date:   Tue Apr 8 10:04:32 2014 +0100
>>>>
>>>>       clocksource: arch_arm_timer: Fix age-old arch timer C3STOP detection issue
>>>>
>>>>
>>>> - and followed timekeeping.txt:
>>>> "Typically the clock source is a monotonic, atomic counter which will provide
>>>>    n bits which count from 0 to 2^(n-1) and then wraps around to 0 and start over.
>>>> It will ideally NEVER stop ticking as long as the system is running. It
>>>> may stop during system suspend."
>>>> ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>>>>
>>>> And that exactly my use-case: I'd like to use ARM GT as clocksource
>>>> and with CPUIdle = n. But System suspend has to be allowed.
>>>>
>>>>
>>>>>
>>>>> Also if the clock-soucre can't tick in the low power states
>>>>> then that device shouldn't be used as a clock-source.
>>>>
>>>> Agree. clocksource can't (except with suspend). Have I missed something?
>>>
>>> I think the point Stantosh is making is that if the clocksource stops
>>> in suspend (which is allowed) you should not be setting
>>> CLOCK_SOURCE_SUSPEND_NONSTOP (which promises the clocksource doesn't
>>> stop in suspend, so it can be used for suspend timing as well).
>>>
>>
>> Ok. Thanks. I got it now. Adding CLOCK_SOURCE_SUSPEND_NONSTOP is mistake.
>>
>>> The contradictory part in your patch is that you're also setting the
>>> clockevent logic as  CLOCK_EVT_FEAT_C3STOP, which flags that the
>>> clockevent hardware might stop in low-power idle states (ie: not
>>> suspend, but while the system is running).  Usually hardware that
>>> halts in low-power mode (like the apic on some x86 machines) is not
>>> also used for timekeeping (instead we use the hpet/acpi there).
>>
>> Sry, I've set CLOCK_EVT_FEAT_C3STOP if "always-on" = *false*
> 
> You might also consider renaming that value from always_on to
> something more descriptive, given the subtlety of the different states
> here. Maybe instead use a flag called halts_in_idle or something?
> 

I'd better just drop it for now hence I'm still not sure what is more reasonable
continue with DT property or just add this flag always.

-- 
regards,
-grygorii
