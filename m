From: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 00/16] gpio: Tight IRQ chip integration and banked
 infrastructure
Date: Fri, 15 Sep 2017 17:26:22 -0500
Message-ID: <edfcb6bd-18bb-175d-e917-e3ce32ba6611@ti.com>
References: <20170901185736.28051-1-thierry.reding@gmail.com>
 <CACRpkdaRsG-9YU2ufb+FxGOO38+x=AAfVUqxH5s56NH2iLw7oA@mail.gmail.com>
 <20170914185233.GA6410@aiwendil> <20170915165750.GW5024@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170915165750.GW5024-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Content-Language: en-US
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Jonathan Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org



On 09/15/2017 11:57 AM, Tony Lindgren wrote:
> * Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> [170915 08:10]:
>> On Thu, Sep 14, 2017 at 03:54:56PM +0200, Linus Walleij wrote:
>>> Sorry about that. Let's move ahead with this now, it is neat and
>>> clean.
>>>
>>> What I want (as maintainer) is a bit of fingerpointing at the drivers
>>> that need to be converted to use the new banking infrastructure
>>> so they don't stay with their old crappy design pattern. OMAP is
>>> a clear candidate right? (Added Tony to CC...)
>>
>> OMAP should be able to use this infrastructure, but it may not want to
>> because the semantics would change slightly. Currently OMAP registers a
>> GPIO chip for each bank, whereas this infrastructure exposes multiple
>> banks via a single chip.
> 
> Oh so you don't have separate interrupts for the instances?
> Thanks for clarifying that.
> 
>> There might be some userspace that relies on the existence of multiple
>> chips, but Tony can probably knows that better than I.
> 
> On omaps, each bank is a separate driver instance with it's own
> interrupt. Maybe really all we need to do is get rid of the "bank"
> naming, I think that's left over from 15 years ago when we did not
> have separate driver instances. It seems we should s/bank/ddata/
> on the driver to avoid confusion.
> 
> Grygorii, any comments?

Sry, for delayed reply - I've saw this series, but, honestly, it's very big 
change for review :(

So, can it be split? I think, patches which reorganize gpio irqchip specific fields placement 
and move them in gpio_irq_chip can be considered separately if they will not introduce
functional changes. Also, omap changes can be considered separately.
(Pay attention that new fields introduced in patch 1).  

Regarding OMAP GPIO - right now I do not see how it can be applied for OMAP :(
Each OMAP GPIO bank is standalone device which can be enabled/disabled, 
powered on/off in Linux. There are no contiguous MMIO space and each GPIO
bank have separate MMIO space.

I really, need more time to review this idea and I think that it can be done
more easily if series size will be reduced.

Few more notes:
- pay attention on commit dc749a0 "gpiolib: allow gpio irqchip to map irqs dynamically"
- good to see binding and DT examples
- not sure if I've got idea of encoding bank&pin in spec[0] :(

+	bank = (spec[0] >> gc->of_gpio_bank_mask) & gc->of_gpio_bank_shift;
+	pin = (spec[0] >> gc->of_gpio_pin_mask) & gc->of_gpio_pin_shift;

- irq "mapping" inside gpio_irq_chip is not clear :( does it static?
does it require one array item/per pin - sry, this is waste of memory?

irq->map[offset + j] = irq->parents[parent];

Potentially, this feature can be applied to Davinci GPIO driver, which
is GPIO controller divided in multiple logical banks and which also have
set of common registers for all logical banks. But, again, not sure how
effective this implementation is - need more time. As of now, we perfectly 
handle this in Davinci GPIO driver by creating only ONE gpio_chip which hides
HW details in driver and still uses standard irq DT mappings:
 <&gpio0 140 GPIO_ACTIVE_LOW>;

By the way Patch 14 adds 300 lines, while patch changes 200 lines, so
in terms of code lines this feature seems is not very efficient.
(same for Patch 15, 16)

-- 
regards,
-grygorii
