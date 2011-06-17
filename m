From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [RFC/PATCH] OMAP3: run the ASM sleep code from DDR
Date: Fri, 17 Jun 2011 10:58:35 +0200
Message-ID: <BANLkTik=1SGUjK2bj2BUPJwmkeUCuBipkA@mail.gmail.com>
References: <1294935563-14426-1-git-send-email-j-pihet@ti.com>
	<b52b65db02da68b3febc0c9cf1e99040@mail.gmail.com>
	<9215f5d7252a4b60f58c3e14a9d46f59@mail.gmail.com>
	<AANLkTinRZyVBu=c3cHBQ7OmJv3U8717_w8Haig4R=ZQh@mail.gmail.com>
	<86b8aab234e1451170c0937e2ab786e5@mail.gmail.com>
	<AANLkTinPxJigu8Nc5J04ciQ_c_Kw9R2xS7s1jaiqeM+F@mail.gmail.com>
	<782caeeca19758b50d370c17db11c78a@mail.gmail.com>
	<6bbd9e73b48eeb3f9f7615b19949f405@mail.gmail.com>
	<BANLkTimF4Wd7Kgg6a=wL_6b6Rj7uzvkxeg@mail.gmail.com>
	<4DFA2B2A.7060904@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:64471 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757425Ab1FQI6g convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 17 Jun 2011 04:58:36 -0400
Received: by qwk3 with SMTP id 3so1042841qwk.19
        for <linux-omap@vger.kernel.org>; Fri, 17 Jun 2011 01:58:36 -0700 (PDT)
In-Reply-To: <4DFA2B2A.7060904@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>, Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org

Hi Santosh,

On Thu, Jun 16, 2011 at 6:11 PM, Santosh Shilimkar
<santosh.shilimkar@ti.com> wrote:
> On 6/16/2011 9:00 PM, Pihet-XID, Jean wrote:
>>
>> Hi Santosh, Benoit, Kevin,
>>
>> I would like to revive this discussion. Can you give some feedback o=
n
>> the self-refresh problem that is proposed in the latest patch from
>> Santosh? Cf. below for more details.
>>
> Comments below.
>
>> On Fri, Feb 4, 2011 at 12:39 PM, Santosh Shilimkar
>> <santosh.shilimkar@ti.com> =A0wrote:
>>>
>>> Jean,
>>>>
>>>> -----Original Message-----
>>>> From: Santosh Shilimkar [mailto:santosh.shilimkar@ti.com]
>>>> Sent: Tuesday, February 01, 2011 5:01 PM
>>>> To: Jean Pihet
>>>> Cc: linux-omap@vger.kernel.org; Jean Pihet-XID
>>>> Subject: RE: [RFC/PATCH] OMAP3: run the ASM sleep code from DDR
>>>>
>>>>> -----Original Message-----
>>>>> From: Jean Pihet [mailto:jean.pihet@newoldbits.com]
>>>>> Sent: Tuesday, February 01, 2011 4:53 PM
>>>>> To: Santosh Shilimkar
>>>>> Cc: linux-omap@vger.kernel.org; Jean Pihet-XID
>>>>> Subject: Re: [RFC/PATCH] OMAP3: run the ASM sleep code from DDR
>>>>>
>>>>
>>>> [...]
>>>>>>>
>>>>>>> Does that makes sense?
>>>>>>>
>>>>>> Actually not. Rather I will separate only the scenario's
>>>>>> where CORE low power targets are attempted and only have
>>>>>> that code run from SRAM.
>>>>>>
>>>>>> There are scenario's where CORE can be active because MODEM,
>>>>>> DSP and MPU can still hit RET, OFF. And here, the errata
>>>>>> isn't applicable.
>>>>>>
>>>>>> Unless I missed something here, I think in the code we check
>>>>>> the the CORE attempted state and based on that we can do a
>>>>>> normal WFI from DDR (no self rfersh) or WFI from
>>>>>> SRAM with self refresh enabled.
>>>>>
>>>>> No. Only the MPU attempted state is checked (this actually is the
>>>>> 'save_state' parameter passed to omap_cpu_suspend).
>>>>> So it makes sense to check the CORE attempted state in order to
>>>>> decide
>>>>> to run the WFI from internal SRAM or DDR.
>>>>>
>>>>> The MPU attempted state is used to decide whether to save the
>>>>> MPU/L1/L2 context.
>>>>>
>>>> Looks like you miss-understood my point. As I understand from
>>>> errata, as long as core clock domain can idle with core
>>>> dpll divider auto idle enabled, the errata is applicable.
>>>>
>>>> So the only check needed is to see if the core clockdomain
>>>> hw_auto or sw sleep is enabled.
>>>>
>>>> If it is suppose to be not idle(we force few C-states
>>>> where CORE inactive is avoided for faster response),
>>>> we can execute WFI from DDR with not enabling
>>>> self refresh.
>>
>> Is this the way to go?
>>
> I think so considering we need C-states for
> faster responses as well.
>
>>>>
>>>> Rest of the scenario can follow the SRAM path.
>>>>
>>>> Hope this is clear to you.
>>>
>>> As per further discussion, I have updated your
>>> patch to address above by using core clockdomain
>>> state.
>>>
>>> Have tested OFF and RET with this new update and they
>>> work as expected. Feel free to update further if needed.
>>>
>>> ------
>>> =A0From 49fe8164a40431807495638ec23639cc9bc53cb9 Mon Sep 17 00:00:0=
0 2001
>>> From: Jean Pihet<j-pihet@ti.com>
>>> Date: Sat, 29 Jan 2011 20:51:19 +0530
>>> Subject: [PATCH] OMAP3: run the ASM sleep code from DDR
>>
>> ...
>>
>>>
>>> -omap3_do_wfi:
>>> +do_WFI:
>>> + =A0 =A0 =A0 ldr =A0 =A0 r4, cm_clkstctrl_core =A0 @ read the CLKS=
TCTRL_CORE
>>> + =A0 =A0 =A0 ldr =A0 =A0 r5, [r4] =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0@=
 read the contents of
>>> CLKSTCTRL_CORE
>>> + =A0 =A0 =A0 and =A0 =A0 r5, r5, #0x3
>>> + =A0 =A0 =A0 cmp =A0 =A0 r5, #0x3
>>> + =A0 =A0 =A0 beq =A0 =A0 omap3_do_wfi =A0 =A0 =A0 =A0 =A0 =A0@ Jum=
pt to SRAM function
>>> + =A0 =A0 =A0 mov =A0 =A0 r1, #0
>>> + =A0 =A0 =A0 mcr =A0 =A0 p15, 0, r1, c7, c10, 4
>>> + =A0 =A0 =A0 mcr =A0 =A0 p15, 0, r1, c7, c10, 5
>>> +
>>> + =A0 =A0 =A0 wfi =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 @ wait for interrupt
>>> +
>>> + =A0 =A0 =A0 ldmfd =A0 sp!, {r0-r12, pc} =A0 =A0 =A0 @ restore reg=
s and return
>>
>> This code has a few problems:
>> - there now are 2 wfi instructions, which I would like to avoid for
>> readability and maintainability,
>> - are the mcr instructions needed here? From
>> arch/arm/include/asm/system.h it seems those are not needed for
>> __LINUX_ARM_ARCH__>=3D 7
>
> The are barriers and in my clean-up I have already fixed them.
> Your patch is bit old so has those things. Once you
> refresh your patch against mainline, this can be simply
> converted to DSB and DMB.
>
>>
>> Furthermore the main point of discussion to me is: is it advised to =
go
>> into wfi without self refresh requested? Can anyone confirm this?
>>
> You can provided you ensure that CORE and SDRC can't idle.
>
> I suggest you to create a patch against mainline and then we
> take it from there.

Re-pushed an updated patch on l-o ML: '[PATCH] OMAP3: run the ASM
sleep code from DDR'.

I deliberately omitted the code for WFI transition without
self-refresh because of the reasons mentioned here above and repeated
here (quoting myself):
"The DDR self refresh is enabled at each WFI but not necessarily hit.
It is actually triggered by the CORE idle request which depends on the
settings, the dependencies, the HW states... For example the CORE
state depends on the MPU state so if the MPU stays ON running
instructions the CORE will stay ON as well.

Also the code in wait_sdrc_ok will exit quicker if the CORE DPLL is
already locked, e.g. if the CORE did not hit a low power state. Since
the actual CORE hit state is unknow after wake-up from WFI the
wait_sdrc_ok code always run at wake-up from MPU RET.
"

>
> Regards
> Santosh
>

Regards,
Jean
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
