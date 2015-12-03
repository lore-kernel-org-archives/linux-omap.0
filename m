From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH 2/2] pinctrl: single: remove misuse of IRQF_NO_SUSPEND
 flag
Date: Thu, 3 Dec 2015 18:59:08 +0000
Message-ID: <566090FC.1020502@arm.com>
References: <1448644860-29323-1-git-send-email-sudeep.holla@arm.com>
 <1448644860-29323-2-git-send-email-sudeep.holla@arm.com>
 <CACRpkdYy1fPAm5r0GxXxzgZA7RsqJ6ZtPtNzd1bzrfkME_j09g@mail.gmail.com>
 <20151203181337.GV23396@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20151203181337.GV23396@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Linus Walleij <linus.walleij@linaro.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>, Grygorii Strashko <grygorii.strashko@ti.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org



On 03/12/15 18:13, Tony Lindgren wrote:
> * Linus Walleij <linus.walleij@linaro.org> [151201 06:07]:
>> On Fri, Nov 27, 2015 at 6:21 PM, Sudeep Holla <sudeep.holla@arm.com> wrote:
>>
>>> From: Sudeep Holla <Sudeep.Holla@arm.com>
>>>
>>> The IRQF_NO_SUSPEND flag is used to identify the interrupts that should
>>> be left enabled so as to allow them to work as expected during the
>>> suspend-resume cycle, but doesn't guarantee that it will wake the system
>>> from a suspended state, enable_irq_wake is recommended to be used for
>>> the wakeup.
>>>
>>> This patch removes the use of IRQF_NO_SUSPEND flags replacing it with
>>> irq_set_irq_wake instead.
>>>
>>> Cc: Linus Walleij <linus.walleij@linaro.org>
>>> Cc: linux-gpio@vger.kernel.org
>>> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
>>
>> I need Tony's ACK on this as well.
>
> At least on omaps, this controller is always powered and we never want to
> suspend it as it handles wake-up events for all the IO pins. And that
> usecase sounds exactly like what you're describing above.
>

Understood, but I assume this is a generic driver that can be used by
any pinmux.

> I don't quite follow what your suggested alternative for an interrupt
> controller is?
>

Why can't we use enable_irq_wake even for parent/interrupt controller as
they can be considered as parent wakeup irq. I agree the interrupt
controller may not be powered down, but still it's part of wakeup and
the irq core needs to identify that. By just marking IRQF_NO_SUSPEND,
you are saying that you can handle interrupt in the suspend path but not
informing that it's a wakeup interrupt.

With this change, the wakeup handler (including the parent handler) is
called when it's safe as the irq core maintains the state machine.

> At least we need to have the alternative patched in with this chage before
> just removing IRQF_NO_SUSPEND.
>

I have added irq_set_irq_wake(pcs_soc->irq, state) in pcs_irq_set_wake
which ensures it's marked for wakeup.

> The enable_irq_wake is naturally used for the consumer drivers of this
> interrupt controller and actually mostly done automatically now with the
> dev_pm_set_dedicated_wake_irq.
>

Agreed, no doubt on that.

-- 
Regards,
Sudeep
