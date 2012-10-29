From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH] gpio: omap-gpio: add support for pm_runtime autosuspend
Date: Mon, 29 Oct 2012 13:53:37 +0530
Message-ID: <508E3D09.9090802@ti.com>
References: <20121026114250.GA26342@arwen.pp.htv.fi> <1351257553-7896-1-git-send-email-tim.niemeyer@corscience.de> <508E266C.6090901@ti.com> <20121029080523.GC13657@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:50938 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755432Ab2J2IXo (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 29 Oct 2012 04:23:44 -0400
In-Reply-To: <20121029080523.GC13657@arwen.pp.htv.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: Tim Niemeyer <tim.niemeyer@corscience.de>, Jon Hunter <jon-hunter@ti.com>, Linux OMAP List <linux-omap@vger.kernel.org>

On Monday 29 October 2012 01:35 PM, Felipe Balbi wrote:
> On Mon, Oct 29, 2012 at 12:17:08PM +0530, Santosh Shilimkar wrote:
>> + Jon,
>>
>> On Friday 26 October 2012 06:49 PM, Tim Niemeyer wrote:
>>> Adds support for configuring the omap-gpio driver use autosuspend f=
or
>>> runtime power management. This can reduce the latency in using it b=
y
>>> not suspending the device immediately on idle. If another access ta=
kes
>>> place before the autosuspend timeout (2 secs), the call to resume t=
he
>>> device can return immediately saving some save/ restore cycles.
>>>
>>> This removes also the bank->mod_usage counter, because this is alre=
ady
>>> handled in pm_runtime.
>>>
>>> I use a gpio to monitor a spi transfer which occurs every 250=B5s. =
The
>>> suspend overhead is to high, so almost every second transfer is los=
t.
>>> This patch fixes that.
>>>
>>> Signed-off-by: Tim Niemeyer <tim.niemeyer@corscience.de>
>>> ---
>>>   drivers/gpio/gpio-omap.c |   81 ++++++++++++++++++++++++---------=
------------
>>>   1 files changed, 43 insertions(+), 38 deletions(-)
>>>
>>  From patch it appears your main motive is to delay the idle kicking=
 in
>> with a timeout to avoid GPIO on cpuidle path. Some comments
>>
>>> diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
>>> index 94cbc84..708d5a9 100644
>>> --- a/drivers/gpio/gpio-omap.c
>>> +++ b/drivers/gpio/gpio-omap.c
>>> @@ -31,6 +31,7 @@
>>>   #include <asm/mach/irq.h>
>>>
>>>   #define OFF_MODE	1
>>> +#define GPIO_AUTOSUSPEND_TIMEOUT                2000
>>>
>>>   static LIST_HEAD(omap_gpio_list);
>>>
>>> @@ -64,7 +65,6 @@ struct gpio_bank {
>>>   	spinlock_t lock;
>>>   	struct gpio_chip chip;
>>>   	struct clk *dbck;
>>> -	u32 mod_usage;
>> How have you tested 'mod_suage' change ?
>>
>>>   	u32 dbck_enable_mask;
>>>   	bool dbck_enabled;
>>>   	struct device *dev;
>>> @@ -557,10 +557,9 @@ static int omap_gpio_request(struct gpio_chip =
*chip, unsigned offset)
>>>
>>>   	/*
>>>   	 * If this is the first gpio_request for the bank,
>>> -	 * enable the bank module.
>>> +	 * resume the bank module.
>> Since you removing bank notion, "If this is the first gpio_request
>> for the bank," becomes irrelevant from code perspective.
>>
>> [..]
>>
>>> @@ -608,28 +594,15 @@ static void omap_gpio_free(struct gpio_chip *=
chip, unsigned offset)
>>>   			__raw_readl(bank->base + bank->regs->wkup_en);
>>>   	}
>>>
>>> -	bank->mod_usage &=3D ~(1 << offset);
>>> -
>>> -	if (bank->regs->ctrl && !bank->mod_usage) {
>>> -		void __iomem *reg =3D bank->base + bank->regs->ctrl;
>>> -		u32 ctrl;
>>> -
>>> -		ctrl =3D __raw_readl(reg);
>>> -		/* Module is disabled, clocks are gated */
>>> -		ctrl |=3D GPIO_MOD_CTRL_BIT;
>>> -		__raw_writel(ctrl, reg);
>>> -		bank->context.ctrl =3D ctrl;
>>> -	}
>>> -
>>>   	_reset_gpio(bank, bank->chip.base + offset);
>>>   	spin_unlock_irqrestore(&bank->lock, flags);
>>>
>>>   	/*
>>>   	 * If this is the last gpio to be freed in the bank,
>>> -	 * disable the bank module.
>>> +	 * put the bank module into suspend.
>>>   	 */
>>> -	if (!bank->mod_usage)
>>> -		pm_runtime_put(bank->dev);
>>> +	pm_runtime_mark_last_busy(bank->dev);
>>> +	pm_runtime_put_autosuspend(bank->dev);
>> Waiting for 2 seconds timeout even on GPIO free
>> seems to be wrong.
>>
>>>   }
>>>
>>>   /*
>>> @@ -715,7 +688,8 @@ static void gpio_irq_handler(unsigned int irq, =
struct irq_desc *desc)
>>>   exit:
>>>   	if (!unmasked)
>>>   		chained_irq_exit(chip, desc);
>>> -	pm_runtime_put(bank->dev);
>>> +	pm_runtime_mark_last_busy(bank->dev);
>>> +	pm_runtime_put_autosuspend(bank->dev);
>> This is what is the main change from this patch which helps your
>> case.
>>>   }
>>>
>>>   static void gpio_irq_shutdown(struct irq_data *d)
>>> @@ -1132,6 +1106,8 @@ static int __devinit omap_gpio_probe(struct p=
latform_device *pdev)
>>>
>>>   	platform_set_drvdata(pdev, bank);
>>>
>>> +	pm_runtime_use_autosuspend(bank->dev);
>>> +	pm_runtime_set_autosuspend_delay(bank->dev, GPIO_AUTOSUSPEND_TIME=
OUT);
>>
>> Can you please report how have you tested this change ? What other P=
M
>> tests you have done?
>>
>> Removing mod usage might just break this driver because now individu=
al
>> banks which can idle before, can no longer idle.
>
> why's that ?
>
>> Just to expand a bit, Out of 6 GPIO banks, GPIO1 bank is in always O=
N
>> domain where as remaing 5 are in peripheral domain. Letting individu=
al
>> banks idle allowed you let the clock domain idle than keeping all th=
e
>> 6 banks and hence respective clock/power domain in ON state.
>>
>> So the adding timeout might be reasonable but I am not sure about
>> the mod_usage change here.
>
> IMHO that whole mod_usage is broken. I remember sending a big series =
of
> patches getting rid of that long ago. I _did_ break a few things but
> just because of omap_gpio_prepare_for_idle() /
> omap_gpio_resume_from_idle() hackery to get GPIO suspended early enou=
gh.
>
Well so far I haven't seen/come across a patch/proposal which fixes it.

> I still think mod_usage needs to go, so does
> omap_gpio_prepare_for_idle() and omap_gpio_resume_from_idle(). To me,=
 it
> looks like that needs to be done on ->prepare()/->complete() callback=
s
> of system suspend and the gpio driver needs to learn proper runtime
> suspend.
>
I am not saying it shouldn't go :-)
The $subject patch isn't fixing it correctly is what I said.

Don't get hung up on suspend case because thats the easiest
way to address it. The issue is with idle where GPIO can prevent
SOC idle if it isn't taken care. And since its just an IO, its not
easy to implement something like inactivity timer towards
autosupend.

Co-processor also makes use of GPIO via syslink proxy and thats
make things even harder.

Regards
Santosh


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
