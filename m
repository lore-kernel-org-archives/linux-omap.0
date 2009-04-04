From: Kim Kyuwon <chammoru@gmail.com>
Subject: Re: [PATCH] OMAP3: PM: Add the wakeup source driver, v2
Date: Sat, 4 Apr 2009 09:26:20 +0900
Message-ID: <4d34a0a70904031726h504d2722xb8032c8573fb1c15@mail.gmail.com>
References: <4d34a0a70903182125l77b0adc3rc0c672f0aa348ab@mail.gmail.com>
	<87ocvhtesx.fsf@deeprootsystems.com> <4d34a0a70904030320g197f836cld9c94b113a9fdffd@mail.gmail.com>
	<87y6uh1zsp.fsf@deeprootsystems.com> <4d34a0a70904031647n6ae7c175w96b1610bf553ebda@mail.gmail.com>
	<877i21w9pg.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.172]:17051 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760033AbZDDA0h convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 3 Apr 2009 20:26:37 -0400
Received: by wf-out-1314.google.com with SMTP id 29so1434141wff.4
        for <linux-omap@vger.kernel.org>; Fri, 03 Apr 2009 17:26:35 -0700 (PDT)
In-Reply-To: <877i21w9pg.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: OMAP <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, =?EUC-KR?B?udqw5rnO?= <kyungmin.park@samsung.com>

On Sat, Apr 4, 2009 at 9:20 AM, Kevin Hilman
<khilman@deeprootsystems.com> wrote:
> Kim Kyuwon <chammoru@gmail.com> writes:
>
>> Hi Kevin,
>> Thanks for your prompt answer.
>>
>> On Sat, Apr 4, 2009 at 1:12 AM, Kevin Hilman
>> <khilman@deeprootsystems.com> wrote:
>>> Kim Kyuwon <chammoru@gmail.com> writes:
>>>
>>>>>> +
>>>>>> +void omap3_get_wakeup_status(struct pm_wakeup_status **pm_wkst)
>>>>>> +{
>>>>>> + =A0 =A0 *pm_wkst =3D &omap3_pm_wkst;
>>>>>> +}
>>>>>> +
>>>>>
>>>>> Can you rename this to omap3_get_last_wake_state()
>>>>
>>>> Actually, I removed this function and I didn't get the WKST regist=
ers
>>>> from the last PRCM interrupt in the new patch. Sorry that I don't
>>>> address your suggestion. But I found that the PRCM interrupt is be=
ing
>>>> generated in normal state on the latest PM branch and, from OMAP34=
XX
>>>> TRM (4.9 PRCM Interrupts), PRCM Interrupts can be generated in man=
y
>>>> cases in addition to wake-up from suspend. So if my wakeup code ge=
ts
>>>> the WSKT values from PRCM interrupt, I think it could show the wro=
ng
>>>> information.
>>>>
>>>
>>> What type of wrong information do you think you would get?
>>
>> On our custom OMAP3430 ES3.1 board on which the latest PM branch
>> kernel is running, the PRCM interrupt is being generated about every
>> 0.5 sec.(not exact) and 'OMAP3430_ST_GPT12_MASK' is set in the
>> PM_WKST_WKUP register.
>
> Hmm, have you configured GPTIMER12 as the system timer?

No, I haven't configured GPTIMER12. And actually
OMAP3430_ST_GPT12_MASK bit is reserved on OMAP3430 ES.1.
This is another problem that I have to fix.....

>> FYI: When I wrongly configured the d2d_mstdby and d2d_swakeup pads,
>> PRCM interrupts was also generated (Refer to
>> http://markmail.org/thread/juardvjdvsrrqwuj)
>>
>>> After looking again, you are probably querying the WKST registers
>>> too late. =A0This version was not querying until someone dumped
>>> the sysfs regs. =A0In that case, some other idle event could have
>>> changed the WKST regs.
>>>
>>> What you should do is query the WKST regs in your early_resume hook
>>> (the same place you query the pending IRQs.) =A0This way you know
>>> exactly when the WKST regs are taken.
>>
>> However, my 'early_resume' hook is invoked before generating any
>> interrupt including PRCM interrupts, because IRQs are disabled by
>> arch_suspend_disablel_irqs() in that context.
>
> Ah, yes. =A0You're right.
>
>> But if I query the WKST regs in the 'resume' hook, I think another
>> PRCM interrupts can be generated.
>
> OK, I haven't yet looked closely at your latest version, but reading
> the regs directly in the early_resume hook looks OK.

Thanks!

> Kevin
>



--=20
Kyuwon
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
