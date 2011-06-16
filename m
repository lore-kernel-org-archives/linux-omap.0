From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [RFC/PATCH] OMAP3: run the ASM sleep code from DDR
Date: Thu, 16 Jun 2011 21:41:22 +0530
Message-ID: <4DFA2B2A.7060904@ti.com>
References: <1294935563-14426-1-git-send-email-j-pihet@ti.com>	<b52b65db02da68b3febc0c9cf1e99040@mail.gmail.com>	<9215f5d7252a4b60f58c3e14a9d46f59@mail.gmail.com>	<AANLkTinRZyVBu=c3cHBQ7OmJv3U8717_w8Haig4R=ZQh@mail.gmail.com>	<86b8aab234e1451170c0937e2ab786e5@mail.gmail.com>	<AANLkTinPxJigu8Nc5J04ciQ_c_Kw9R2xS7s1jaiqeM+F@mail.gmail.com>	<782caeeca19758b50d370c17db11c78a@mail.gmail.com>	<6bbd9e73b48eeb3f9f7615b19949f405@mail.gmail.com> <BANLkTimF4Wd7Kgg6a=wL_6b6Rj7uzvkxeg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:34582 "EHLO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754908Ab1FPQLc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 16 Jun 2011 12:11:32 -0400
Received: by mail-gy0-f177.google.com with SMTP id 20so555702gyh.8
        for <linux-omap@vger.kernel.org>; Thu, 16 Jun 2011 09:11:31 -0700 (PDT)
In-Reply-To: <BANLkTimF4Wd7Kgg6a=wL_6b6Rj7uzvkxeg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Pihet-XID, Jean" <j-pihet@ti.com>
Cc: "Cousson, Benoit" <b-cousson@ti.com>, Kevin Hilman <khilman@ti.com>, Jean Pihet <jean.pihet@newoldbits.com>, linux-omap@vger.kernel.org

On 6/16/2011 9:00 PM, Pihet-XID, Jean wrote:
> Hi Santosh, Benoit, Kevin,
>
> I would like to revive this discussion. Can you give some feedback on
> the self-refresh problem that is proposed in the latest patch from
> Santosh? Cf. below for more details.
>
Comments below.

> On Fri, Feb 4, 2011 at 12:39 PM, Santosh Shilimkar
> <santosh.shilimkar@ti.com>  wrote:
>> Jean,
>>> -----Original Message-----
>>> From: Santosh Shilimkar [mailto:santosh.shilimkar@ti.com]
>>> Sent: Tuesday, February 01, 2011 5:01 PM
>>> To: Jean Pihet
>>> Cc: linux-omap@vger.kernel.org; Jean Pihet-XID
>>> Subject: RE: [RFC/PATCH] OMAP3: run the ASM sleep code from DDR
>>>
>>>> -----Original Message-----
>>>> From: Jean Pihet [mailto:jean.pihet@newoldbits.com]
>>>> Sent: Tuesday, February 01, 2011 4:53 PM
>>>> To: Santosh Shilimkar
>>>> Cc: linux-omap@vger.kernel.org; Jean Pihet-XID
>>>> Subject: Re: [RFC/PATCH] OMAP3: run the ASM sleep code from DDR
>>>>
>>>
>>> [...]
>>>>>> Does that makes sense?
>>>>>>
>>>>> Actually not. Rather I will separate only the scenario's
>>>>> where CORE low power targets are attempted and only have
>>>>> that code run from SRAM.
>>>>>
>>>>> There are scenario's where CORE can be active because MODEM,
>>>>> DSP and MPU can still hit RET, OFF. And here, the errata
>>>>> isn't applicable.
>>>>>
>>>>> Unless I missed something here, I think in the code we check
>>>>> the the CORE attempted state and based on that we can do a
>>>>> normal WFI from DDR (no self rfersh) or WFI from
>>>>> SRAM with self refresh enabled.
>>>> No. Only the MPU attempted state is checked (this actually is the
>>>> 'save_state' parameter passed to omap_cpu_suspend).
>>>> So it makes sense to check the CORE attempted state in order to
>>>> decide
>>>> to run the WFI from internal SRAM or DDR.
>>>>
>>>> The MPU attempted state is used to decide whether to save the
>>>> MPU/L1/L2 context.
>>>>
>>> Looks like you miss-understood my point. As I understand from
>>> errata, as long as core clock domain can idle with core
>>> dpll divider auto idle enabled, the errata is applicable.
>>>
>>> So the only check needed is to see if the core clockdomain
>>> hw_auto or sw sleep is enabled.
>>>
>>> If it is suppose to be not idle(we force few C-states
>>> where CORE inactive is avoided for faster response),
>>> we can execute WFI from DDR with not enabling
>>> self refresh.
> Is this the way to go?
>
I think so considering we need C-states for
faster responses as well.

>>>
>>> Rest of the scenario can follow the SRAM path.
>>>
>>> Hope this is clear to you.
>>
>> As per further discussion, I have updated your
>> patch to address above by using core clockdomain
>> state.
>>
>> Have tested OFF and RET with this new update and they
>> work as expected. Feel free to update further if needed.
>>
>> ------
>>  From 49fe8164a40431807495638ec23639cc9bc53cb9 Mon Sep 17 00:00:00 2001
>> From: Jean Pihet<j-pihet@ti.com>
>> Date: Sat, 29 Jan 2011 20:51:19 +0530
>> Subject: [PATCH] OMAP3: run the ASM sleep code from DDR
> ...
>
>>
>> -omap3_do_wfi:
>> +do_WFI:
>> +       ldr     r4, cm_clkstctrl_core   @ read the CLKSTCTRL_CORE
>> +       ldr     r5, [r4]                @ read the contents of
>> CLKSTCTRL_CORE
>> +       and     r5, r5, #0x3
>> +       cmp     r5, #0x3
>> +       beq     omap3_do_wfi            @ Jumpt to SRAM function
>> +       mov     r1, #0
>> +       mcr     p15, 0, r1, c7, c10, 4
>> +       mcr     p15, 0, r1, c7, c10, 5
>> +
>> +       wfi                             @ wait for interrupt
>> +
>> +       ldmfd   sp!, {r0-r12, pc}       @ restore regs and return
>
> This code has a few problems:
> - there now are 2 wfi instructions, which I would like to avoid for
> readability and maintainability,
> - are the mcr instructions needed here? From
> arch/arm/include/asm/system.h it seems those are not needed for
> __LINUX_ARM_ARCH__>= 7
The are barriers and in my clean-up I have already fixed them.
Your patch is bit old so has those things. Once you
refresh your patch against mainline, this can be simply
converted to DSB and DMB.

>
> Furthermore the main point of discussion to me is: is it advised to go
> into wfi without self refresh requested? Can anyone confirm this?
>
You can provided you ensure that CORE and SDRC can't idle.

I suggest you to create a patch against mainline and then we
take it from there.

Regards
Santosh
