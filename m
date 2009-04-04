From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH] OMAP3: PM: Add the wakeup source driver, v2
Date: Fri, 03 Apr 2009 17:20:43 -0700
Message-ID: <877i21w9pg.fsf@deeprootsystems.com>
References: <4d34a0a70903182125l77b0adc3rc0c672f0aa348ab@mail.gmail.com>
	<87ocvhtesx.fsf@deeprootsystems.com>
	<4d34a0a70904030320g197f836cld9c94b113a9fdffd@mail.gmail.com>
	<87y6uh1zsp.fsf@deeprootsystems.com>
	<4d34a0a70904031647n6ae7c175w96b1610bf553ebda@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.238]:14315 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755761AbZDDAU5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 3 Apr 2009 20:20:57 -0400
Received: by rv-out-0506.google.com with SMTP id f9so1401007rvb.1
        for <linux-omap@vger.kernel.org>; Fri, 03 Apr 2009 17:20:55 -0700 (PDT)
In-Reply-To: <4d34a0a70904031647n6ae7c175w96b1610bf553ebda@mail.gmail.com> (Kim Kyuwon's message of "Sat\, 4 Apr 2009 08\:47\:20 +0900")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kim Kyuwon <chammoru@gmail.com>
Cc: OMAP <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, =?utf-8?B?67CV6rK966+8?= <kyungmin.park@samsung.com>

Kim Kyuwon <chammoru@gmail.com> writes:

> Hi Kevin,
> Thanks for your prompt answer.
>
> On Sat, Apr 4, 2009 at 1:12 AM, Kevin Hilman
> <khilman@deeprootsystems.com> wrote:
>> Kim Kyuwon <chammoru@gmail.com> writes:
>>
>>>>> +
>>>>> +void omap3_get_wakeup_status(struct pm_wakeup_status **pm_wkst)
>>>>> +{
>>>>> + =A0 =A0 *pm_wkst =3D &omap3_pm_wkst;
>>>>> +}
>>>>> +
>>>>
>>>> Can you rename this to omap3_get_last_wake_state()
>>>
>>> Actually, I removed this function and I didn't get the WKST registe=
rs
>>> from the last PRCM interrupt in the new patch. Sorry that I don't
>>> address your suggestion. But I found that the PRCM interrupt is bei=
ng
>>> generated in normal state on the latest PM branch and, from OMAP34X=
X
>>> TRM (4.9 PRCM Interrupts), PRCM Interrupts can be generated in many
>>> cases in addition to wake-up from suspend. So if my wakeup code get=
s
>>> the WSKT values from PRCM interrupt, I think it could show the wron=
g
>>> information.
>>>
>>
>> What type of wrong information do you think you would get?
>
> On our custom OMAP3430 ES3.1 board on which the latest PM branch
> kernel is running, the PRCM interrupt is being generated about every
> 0.5 sec.(not exact) and 'OMAP3430_ST_GPT12_MASK' is set in the
> PM_WKST_WKUP register.

Hmm, have you configured GPTIMER12 as the system timer?

> FYI: When I wrongly configured the d2d_mstdby and d2d_swakeup pads,
> PRCM interrupts was also generated (Refer to
> http://markmail.org/thread/juardvjdvsrrqwuj)
>
>> After looking again, you are probably querying the WKST registers
>> too late. =A0This version was not querying until someone dumped
>> the sysfs regs. =A0In that case, some other idle event could have
>> changed the WKST regs.
>>
>> What you should do is query the WKST regs in your early_resume hook
>> (the same place you query the pending IRQs.) =A0This way you know
>> exactly when the WKST regs are taken.
>
> However, my 'early_resume' hook is invoked before generating any
> interrupt including PRCM interrupts, because IRQs are disabled by
> arch_suspend_disablel_irqs() in that context.

Ah, yes.  You're right.

> But if I query the WKST regs in the 'resume' hook, I think another
> PRCM interrupts can be generated.

OK, I haven't yet looked closely at your latest version, but reading
the regs directly in the early_resume hook looks OK.

Kevin
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
