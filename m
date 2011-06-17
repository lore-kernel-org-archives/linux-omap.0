From: Kevin Hilman <khilman@ti.com>
Subject: Re: [RFC/PATCH] OMAP3: run the ASM sleep code from DDR
Date: Fri, 17 Jun 2011 08:59:28 -0700
Message-ID: <87aadgcuu7.fsf@ti.com>
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
	<BANLkTik=1SGUjK2bj2BUPJwmkeUCuBipkA@mail.gmail.com>
	<4DFB1AAB.3090000@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog112.obsmtp.com ([74.125.149.207]:40612 "EHLO
	na3sys009aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751673Ab1FQP7c (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 17 Jun 2011 11:59:32 -0400
Received: by mail-iy0-f170.google.com with SMTP id 1so495504iym.29
        for <linux-omap@vger.kernel.org>; Fri, 17 Jun 2011 08:59:31 -0700 (PDT)
In-Reply-To: <4DFB1AAB.3090000@ti.com> (Santosh Shilimkar's message of "Fri,
	17 Jun 2011 14:43:15 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Jean Pihet <jean.pihet@newoldbits.com>, "Cousson, Benoit" <b-cousson@ti.com>, linux-omap@vger.kernel.org

Hi Santosh,

Santosh Shilimkar <santosh.shilimkar@ti.com> writes:

> On 6/17/2011 2:28 PM, Jean Pihet wrote:
>> Hi Santosh,
>>
>
> [....]
>
>
>>>>> -omap3_do_wfi:
>>>>> +do_WFI:
>>>>> +       ldr     r4, cm_clkstctrl_core   @ read the CLKSTCTRL_CORE
>>>>> +       ldr     r5, [r4]                @ read the contents of
>>>>> CLKSTCTRL_CORE
>>>>> +       and     r5, r5, #0x3
>>>>> +       cmp     r5, #0x3
>>>>> +       beq     omap3_do_wfi            @ Jumpt to SRAM function
>>>>> +       mov     r1, #0
>>>>> +       mcr     p15, 0, r1, c7, c10, 4
>>>>> +       mcr     p15, 0, r1, c7, c10, 5
>>>>> +
>>>>> +       wfi                             @ wait for interrupt
>>>>> +
>>>>> +       ldmfd   sp!, {r0-r12, pc}       @ restore regs and return
>>>>
>
> [....]
>
>>>> Furthermore the main point of discussion to me is: is it advised to go
>>>> into wfi without self refresh requested? Can anyone confirm this?
>>>>
>>> You can provided you ensure that CORE and SDRC can't idle.
>>>
>>> I suggest you to create a patch against mainline and then we
>>> take it from there.
>>
>> Re-pushed an updated patch on l-o ML: '[PATCH] OMAP3: run the ASM
>> sleep code from DDR'.
>>
> Thanks. We needed this to be in mainline.
>
>> I deliberately omitted the code for WFI transition without
>> self-refresh because of the reasons mentioned here above and repeated
>> here (quoting myself):
>> "The DDR self refresh is enabled at each WFI but not necessarily hit.
>> It is actually triggered by the CORE idle request which depends on the
>> settings, the dependencies, the HW states... For example the CORE
>> state depends on the MPU state so if the MPU stays ON running
>> instructions the CORE will stay ON as well.
>>
>> Also the code in wait_sdrc_ok will exit quicker if the CORE DPLL is
>> already locked, e.g. if the CORE did not hit a low power state. Since
>> the actual CORE hit state is unknow after wake-up from WFI the
>> wait_sdrc_ok code always run at wake-up from MPU RET.
>> "
>>
> What is written here is completely right and I never said
> anything against it. What I mentioned is if the CORE
> clock-domain is under HW supervision, SDRC can idle
> and hence the DDR can enter into self refresh.
>
> Ofocurse on OMAP3 all clock-domain has static deps set
> and hence above assumption is ok. The update I mentioned
> in the code will make it complete even without auto-dep
> assumption.
>
> Anyways if that is the only point we are contesting, I
> am OK to not have that change part of the patch because
> it would work becasuse of auto-deps.

Sorry I haven't followed the whole thread...

Can you please clarify what would need to be updated if auto-deps were
removed?  We are hoping to remove them when we have full hwmod
conversion.

Kevin
