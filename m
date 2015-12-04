From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH 2/2] pinctrl: single: remove misuse of IRQF_NO_SUSPEND
 flag
Date: Fri, 4 Dec 2015 16:15:29 +0000
Message-ID: <5661BC21.2050802@arm.com>
References: <1448644860-29323-1-git-send-email-sudeep.holla@arm.com>
 <1448644860-29323-2-git-send-email-sudeep.holla@arm.com>
 <CACRpkdYy1fPAm5r0GxXxzgZA7RsqJ6ZtPtNzd1bzrfkME_j09g@mail.gmail.com>
 <20151203181337.GV23396@atomide.com> <566090FC.1020502@arm.com>
 <20151203214013.GB23396@atomide.com> <20151204154031.GG23396@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <20151204154031.GG23396@atomide.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>, Linus Walleij <linus.walleij@linaro.org>, Grygorii Strashko <grygorii.strashko@ti.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi Tony,

On 04/12/15 15:40, Tony Lindgren wrote:
> * Tony Lindgren <tony@atomide.com> [151203 13:41]:
>> * Sudeep Holla <sudeep.holla@arm.com> [151203 11:00]:
>>>
>>> I have added irq_set_irq_wake(pcs_soc->irq, state) in pcs_irq_set_wake
>>> which ensures it's marked for wakeup.
>>
>> Hmm well see the error I pasted in this thread, maybe that provides
>> more clues.
>
> The irq_set_irq_wake(pcs_soc->irq, state) in pcs_irq_set_wake does not
> look right to me as pcs_irq_set_wake toggles the irq_wake for each pin
> separately, not for the whole controller.
>

After thinking more about it we need some way to tell IRQ core that
pcs_soc->irq is wakeup capable. Is that going to happen automatically
via dev_pm_set_dedicated_wake_irq as you mentioned earlier ?

> I think all that can be left out with the snipped from Grygorii, and maybe
> also the lock_class_key changes.
>

If we not calling irq_set_irq_wake(pcs_soc->irq) in pcs_irq_set_wake, do
you see possibility of lockdep recursion in any other paths.

Otherwise we don't need this if we remove irq_set_irq_wake(pcs_soc->irq)
from pcs_irq_set_wake

-- 
Regards,
Sudeep
