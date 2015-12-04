From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH 2/2] pinctrl: single: remove misuse of IRQF_NO_SUSPEND
 flag
Date: Fri, 4 Dec 2015 16:26:39 +0000
Message-ID: <5661BEBF.9000106@arm.com>
References: <1448644860-29323-1-git-send-email-sudeep.holla@arm.com>
 <1448644860-29323-2-git-send-email-sudeep.holla@arm.com>
 <CACRpkdYy1fPAm5r0GxXxzgZA7RsqJ6ZtPtNzd1bzrfkME_j09g@mail.gmail.com>
 <20151203181337.GV23396@atomide.com> <566090FC.1020502@arm.com>
 <20151203214013.GB23396@atomide.com> <20151204154031.GG23396@atomide.com>
 <5661B4E7.2040405@arm.com> <5661BD22.7080600@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <5661BD22.7080600@ti.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@ti.com>, Tony Lindgren <tony@atomide.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>, Linus Walleij <linus.walleij@linaro.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org



On 04/12/15 16:19, Grygorii Strashko wrote:
> On 12/04/2015 05:44 PM, Sudeep Holla wrote:
>>
>>
>> On 04/12/15 15:40, Tony Lindgren wrote:
>>> * Tony Lindgren <tony@atomide.com> [151203 13:41]:
>>>> * Sudeep Holla <sudeep.holla@arm.com> [151203 11:00]:
>>>>>
>>>>> I have added irq_set_irq_wake(pcs_soc->irq, state) in pcs_irq_set_wake
>>>>> which ensures it's marked for wakeup.
>>>>
>>>> Hmm well see the error I pasted in this thread, maybe that provides
>>>> more clues.
>>>
>>> The irq_set_irq_wake(pcs_soc->irq, state) in pcs_irq_set_wake does not
>>> look right to me as pcs_irq_set_wake toggles the irq_wake for each pin
>>> separately, not for the whole controller.
>>>
>>
>> OK, my understanding was that this driver supports multiple single
>> pinmux with one main irq `pcs_soc->irq`. Hence I added the wakeup on
>> that irq. I now think that understand is wrong.
>>
>
> With this change, PCS parent IRQ will be marked as wake up source as many
> times as many pins were requested as wake up IRQs (protected by counter).
> Most of all GPIO IRQ chips work this way.
> Of course, if we will look on pinctrl-single.c from only OMAP point of view
> then Prent IRQ can be marked as wake up source from probe only once.
> But, since this driver expected to be generic - this patch is more correct,
> because other HW may require to perform some real HW re-configuration to
> enable/disable wake up capabilities for Parent IRQ in Parent IRQ controller.
>

Thanks for the detailed explanation. I was bit confused if my
understanding is correct or not.

> Any way, in my opinion, it's right and more safe to manage all wakeup IRQs
> through IRQ PM core and Device wakeirq framework. And this patch should just
> go together with platform changes and not alone.
>

Agreed, since I don't have platform to test, I will leave it you guys to
pick up these patches when ready and with any changes if required.

-- 
Regards,
Sudeep
