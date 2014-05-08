From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [PATCH 1/2] gpio: omap: prepare and unprepare the debounce clock
Date: Thu, 8 May 2014 16:40:03 +0530
Message-ID: <536B660B.7080200@ti.com>
References: <1398233465-8845-1-git-send-email-rnayak@ti.com> <1398233465-8845-2-git-send-email-rnayak@ti.com> <536B2CEE.4010809@ti.com> <CABxcv==5cwnk4aiZ+AVuAoMf9YnZJsfiJKRkZTYHFuP2-DmnnQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <CABxcv==5cwnk4aiZ+AVuAoMf9YnZJsfiJKRkZTYHFuP2-DmnnQ@mail.gmail.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Javier Martinez Canillas <javier@dowhile0.org>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>, Linux GPIO List <linux-gpio@vger.kernel.org>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>
List-Id: linux-omap@vger.kernel.org

On Thursday 08 May 2014 02:56 PM, Javier Martinez Canillas wrote:
> Hello Rajendra,
> 
> On Thu, May 8, 2014 at 9:06 AM, Rajendra Nayak <rnayak@ti.com> wrote:
>> On Wednesday 23 April 2014 11:41 AM, Rajendra Nayak wrote:
>>> Replace the clk_enable()s with a clk_prepare_enable() and
>>> the clk_disables()s with a clk_disable_unprepare()
>>>
>>> This never showed issues due to the OMAP platform code (hwmod)
>>> leaving these clocks in clk_prepare()ed state by default.
>>>
>>> Reported-by: Kishon Vijay Abraham I <kishon@ti.com>
>>> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
>>> Cc: linux-gpio@vger.kernel.org
>>> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
>>> Cc: Kevin Hilman <khilman@deeprootsystems.com>
>>
>> Linus,
>>
>> Do you mind picking this fix up via the GPIO tree? Alternatively you could
>> Ack this if you are fine and we can take both Patch 1/2 and Patch 2/2 from this
>> series via the OMAP tree.
>>
>> Patch 2/2 has a dependency on Patch 1/2 and they need to go in in that order else
>> gpio would break. More discussions are here [1].
>> Let us know what you think. Thanks.
>>
> 
> I wonder if that is really the case. Your Patch 2/2 removes the call
> to clk_prepare on _init_opt_clks() but it also replaces
> clk_{enable,disable} with clk_prepare_enable()/clk_disable_unprepare()
> on _enable_optional_clocks() and _disable_optional_clocks()
> respectively.

Right, the difference being, by the time hwmod is done enabling/disabling
the opt clocks, without patch 2/2, the prepare count is 1, with patch 2/2
prepare count is 0.

> 
> And GPIO banks are reset by hwmod on init which as far as I know
> happen very early before the GPIO OMAP driver is even probed so by the
> time clk_enable() is called on the GPIO driver the clock will already
> be prepared by _enable_optional_clocks(). I tested linux-gpio/devel

and unprepared by _disable_optional_clocks()?

> branch + only your Patch 2/2 and the GPIOs were working correctly on a
> OMAP3 board.

Did gpio_debounce() ever get called for any of the gpios?

> 
> So I think that there isn't a strict dependency between these two
> patches or am I missing something?
> 
> In fact now that I think about it I wonder what's the functional
> change of your Patch 2/2 since hwmod is still calling clk_prepare()
> before the driver. If the clocks should actually be controlled by the

I don't understand why you say 'before the driver'. Hwmod needs to control
optional clocks for some devices in order to do a ocp reset. So it does
touch these optional clocks, but if you look at the code it subsequently
also disables (and unprepares with patch 2/2) these clocks before returning
the control to the driver.

> drivers like you said then I think that we should remove
> _{enable,disable}_optional_clocks() completely and let the drivers do
> the clock prepare and enable like is made on your Patch 1/2 for the
> GPIO driver.
> 
> What do you think about it?
> 
> Best regards,
> Javier
> 
>> regards,
>> Rajendra
>>
>> [1] http://www.mail-archive.com/linux-gpio@vger.kernel.org/msg02801.html
>>
>>> ---
>>>  drivers/gpio/gpio-omap.c |   10 +++++-----
>>>  1 file changed, 5 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
>>> index 19b886c..78bc5a4 100644
>>> --- a/drivers/gpio/gpio-omap.c
>>> +++ b/drivers/gpio/gpio-omap.c
>>> @@ -180,7 +180,7 @@ static inline void _gpio_rmw(void __iomem *base, u32 reg, u32 mask, bool set)
>>>  static inline void _gpio_dbck_enable(struct gpio_bank *bank)
>>>  {
>>>       if (bank->dbck_enable_mask && !bank->dbck_enabled) {
>>> -             clk_enable(bank->dbck);
>>> +             clk_prepare_enable(bank->dbck);
>>>               bank->dbck_enabled = true;
>>>
>>>               writel_relaxed(bank->dbck_enable_mask,
>>> @@ -198,7 +198,7 @@ static inline void _gpio_dbck_disable(struct gpio_bank *bank)
>>>                */
>>>               writel_relaxed(0, bank->base + bank->regs->debounce_en);
>>>
>>> -             clk_disable(bank->dbck);
>>> +             clk_disable_unprepare(bank->dbck);
>>>               bank->dbck_enabled = false;
>>>       }
>>>  }
>>> @@ -231,7 +231,7 @@ static void _set_gpio_debounce(struct gpio_bank *bank, unsigned gpio,
>>>
>>>       l = GPIO_BIT(bank, gpio);
>>>
>>> -     clk_enable(bank->dbck);
>>> +     clk_prepare_enable(bank->dbck);
>>>       reg = bank->base + bank->regs->debounce;
>>>       writel_relaxed(debounce, reg);
>>>
>>> @@ -245,7 +245,7 @@ static void _set_gpio_debounce(struct gpio_bank *bank, unsigned gpio,
>>>       bank->dbck_enable_mask = val;
>>>
>>>       writel_relaxed(val, reg);
>>> -     clk_disable(bank->dbck);
>>> +     clk_disable_unprepare(bank->dbck);
>>>       /*
>>>        * Enable debounce clock per module.
>>>        * This call is mandatory because in omap_gpio_request() when
>>> @@ -290,7 +290,7 @@ static void _clear_gpio_debounce(struct gpio_bank *bank, unsigned gpio)
>>>               bank->context.debounce = 0;
>>>               writel_relaxed(bank->context.debounce, bank->base +
>>>                            bank->regs->debounce);
>>> -             clk_disable(bank->dbck);
>>> +             clk_disable_unprepare(bank->dbck);
>>>               bank->dbck_enabled = false;
>>>       }
>>>  }
>>>
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-gpio" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html

