From: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Subject: Re: [PATCH v4 04/12] gpio/omap: remove saved_wakeup field from struct gpio_bank
Date: Thu, 26 Jul 2012 11:50:21 +0530
Message-ID: <CAC83ZvJ7DW-u+Q_DJB8TRX9=F+ucESBNRQ0T8qkFdt0W4c=o4A@mail.gmail.com>
References: <1331906760-5259-1-git-send-email-tarun.kanti@ti.com>
	<1331906760-5259-5-git-send-email-tarun.kanti@ti.com>
	<4FFAA7B3.6020009@ti.com>
	<CAC83ZvLo3X_-EarrMFNM0B196FaMLrP5SNh5OA7aE7wMZ9VJUQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:44170 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750789Ab2GZGUW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 26 Jul 2012 02:20:22 -0400
Received: by qabj40 with SMTP id j40so947166qab.15
        for <linux-omap@vger.kernel.org>; Wed, 25 Jul 2012 23:20:21 -0700 (PDT)
In-Reply-To: <CAC83ZvLo3X_-EarrMFNM0B196FaMLrP5SNh5OA7aE7wMZ9VJUQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@ti.com, tony@atomide.com, b-cousson@ti.com, grant.likely@secretlab.ca, linux-arm-kernel@lists.infradead.org

Hi Roger,

On Mon, Jul 9, 2012 at 4:46 PM, DebBarma, Tarun Kanti
<tarun.kanti@ti.com> wrote:
> Hi Roger,
>
> On Mon, Jul 9, 2012 at 3:13 PM, Roger Quadros <rogerq@ti.com> wrote:
>> Hi,
>>
>> Just bumped across this patch and have a query.
>>
>> On 03/16/2012 04:05 PM, Tarun Kanti DebBarma wrote:
>>> There is no more need to have saved_wakeup because bank->context.wake_en
>>> already holds that value. So getting rid of read/write operation associated
>>> with this field.
>>>
>>> Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
>>> Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
>>> Acked-by: Felipe Balbi <balbi@ti.com>
>>> ---
>>>  drivers/gpio/gpio-omap.c |   12 +++---------
>>>  1 files changed, 3 insertions(+), 9 deletions(-)
>>>
>>> diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
>>> index 3a4f151..3b91ade 100644
>>> --- a/drivers/gpio/gpio-omap.c
>>> +++ b/drivers/gpio/gpio-omap.c
>>> @@ -57,7 +57,6 @@ struct gpio_bank {
>>>       u16 irq;
>>>       int irq_base;
>>>       struct irq_domain *domain;
>>> -     u32 saved_wakeup;
>>>       u32 non_wakeup_gpios;
>>>       u32 enabled_non_wakeup_gpios;
>>>       struct gpio_regs context;
>>> @@ -777,7 +776,6 @@ static int omap_mpuio_suspend_noirq(struct device *dev)
>>>       unsigned long           flags;
>>>
>>>       spin_lock_irqsave(&bank->lock, flags);
>>> -     bank->saved_wakeup = __raw_readl(mask_reg);
>>>       __raw_writel(0xffff & ~bank->context.wake_en, mask_reg);
>>
>> OK, here you are overwriting the mask_reg with the wakeup bitmask
>> without saving the mask_reg's original content.
> This is based upon understanding that set_gpio_trigger() is the common
> function where update of wake_en register takes place. Unless, mask_reg
> in this case refers to something else, effectively we would be saving the
> same value to saved_wakeup what is already present in wake_en.
> I will verify this specific to this function.
I had a look at this change and it appears for OMAP1 we have to explicitly
save the register here. This is because set_gpio_trigger() refers to wake_en
register for OMAP2+ platforms, whereas here on OMAP1 it is referring to
irqenable register. In other words we need to have:
bank->context.wake_en = __raw_readl(mask_reg);
--
Tarun

>
>>
>>>       spin_unlock_irqrestore(&bank->lock, flags);
>>>
>>> @@ -793,7 +791,7 @@ static int omap_mpuio_resume_noirq(struct device *dev)
>>>       unsigned long           flags;
>>>
>>>       spin_lock_irqsave(&bank->lock, flags);
>>> -     __raw_writel(bank->saved_wakeup, mask_reg);
>>> +     __raw_writel(bank->context.wake_en, mask_reg);
>>
>> Now you are restoring nothing but the same content that you stored
>> during suspend. This will cause the non-wakeup gpio interrupts to get
>> masked between a suspend/resume. So isn't this a bug?
> That's right, the same value is restored back which was last updated in
> set_gpio_trigger() that got stored in wake_en register. Let me know if
> I am missing your points here.
>
>>
>> Proper solution would be to save the mask_reg context into another
>> register than context.wake_en during suspend.
> As I said, this would make sense if mask_reg is referring to different
> register than what is used in set_gpio_trigger(). I will have a look.
>
> BTW, did you observe anything unusual during some testing?
>
> Thanks.
> --
> Tarun
>>
>>>       spin_unlock_irqrestore(&bank->lock, flags);
>>>
>>>       return 0;
>>
>>
>> cheers,
>> -roger
