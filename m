From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH v4 04/12] gpio/omap: remove saved_wakeup field from struct
 gpio_bank
Date: Mon, 9 Jul 2012 14:51:50 +0300
Message-ID: <4FFAC5D6.4090306@ti.com>
References: <1331906760-5259-1-git-send-email-tarun.kanti@ti.com> <1331906760-5259-5-git-send-email-tarun.kanti@ti.com> <4FFAA7B3.6020009@ti.com> <CAC83ZvLo3X_-EarrMFNM0B196FaMLrP5SNh5OA7aE7wMZ9VJUQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:51761 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753239Ab2GILwC (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 9 Jul 2012 07:52:02 -0400
In-Reply-To: <CAC83ZvLo3X_-EarrMFNM0B196FaMLrP5SNh5OA7aE7wMZ9VJUQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@ti.com, tony@atomide.com, b-cousson@ti.com, grant.likely@secretlab.ca, linux-arm-kernel@lists.infradead.org

Tarun,

On 07/09/2012 02:16 PM, DebBarma, Tarun Kanti wrote:
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

If it is writing the same thing then isn't this write redundant?

> 
>>
>> Proper solution would be to save the mask_reg context into another
>> register than context.wake_en during suspend.
> As I said, this would make sense if mask_reg is referring to different
> register than what is used in set_gpio_trigger(). I will have a look.

OK thanks.

> 
> BTW, did you observe anything unusual during some testing?

No, I haven't done any tests.

cheers,
-roger
