From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH] OMAP3: PM: Add the wakeup source driver, v2
Date: Fri, 03 Apr 2009 09:12:54 -0700
Message-ID: <87y6uh1zsp.fsf@deeprootsystems.com>
References: <4d34a0a70903182125l77b0adc3rc0c672f0aa348ab@mail.gmail.com>
	<87ocvhtesx.fsf@deeprootsystems.com>
	<4d34a0a70904030320g197f836cld9c94b113a9fdffd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.170]:12384 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936350AbZDCQNF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 3 Apr 2009 12:13:05 -0400
Received: by wf-out-1314.google.com with SMTP id 29so1260553wff.4
        for <linux-omap@vger.kernel.org>; Fri, 03 Apr 2009 09:13:02 -0700 (PDT)
In-Reply-To: <4d34a0a70904030320g197f836cld9c94b113a9fdffd@mail.gmail.com> (Kim Kyuwon's message of "Fri\, 3 Apr 2009 19\:20\:19 +0900")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kim Kyuwon <chammoru@gmail.com>
Cc: OMAP <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, =?utf-8?B?67CV6rK966+8?= <kyungmin.park@samsung.com>

Kim Kyuwon <chammoru@gmail.com> writes:

>>> +
>>> +void omap3_get_wakeup_status(struct pm_wakeup_status **pm_wkst)
>>> +{
>>> +     *pm_wkst = &omap3_pm_wkst;
>>> +}
>>> +
>>
>> Can you rename this to omap3_get_last_wake_state()
>
> Actually, I removed this function and I didn't get the WKST registers
> from the last PRCM interrupt in the new patch. Sorry that I don't
> address your suggestion. But I found that the PRCM interrupt is being
> generated in normal state on the latest PM branch and, from OMAP34XX
> TRM (4.9 PRCM Interrupts), PRCM Interrupts can be generated in many
> cases in addition to wake-up from suspend. So if my wakeup code gets
> the WSKT values from PRCM interrupt, I think it could show the wrong
> information.
>

What type of wrong information do you think you would get?

After looking again, you are probably querying the WKST registers
too late.  This version was not querying until someone dumped
the sysfs regs.  In that case, some other idle event could have
changed the WKST regs.

What you should do is query the WKST regs in your early_resume hook
(the same place you query the pending IRQs.)  This way you know
exactly when the WKST regs are taken.

Kevin




