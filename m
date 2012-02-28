From: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Subject: Re: [PATCH 3/6] gpio/omap: remove suspend_wakeup field from struct gpio_bank
Date: Tue, 28 Feb 2012 15:09:05 +0530
Message-ID: <CAC83ZvJ97uRSLU-JmO2mnaOuziU=SotghASSJjPvESWL+eATuQ@mail.gmail.com>
References: <1329999031-6914-1-git-send-email-tarun.kanti@ti.com>
	<1329999031-6914-4-git-send-email-tarun.kanti@ti.com>
	<87ty2bu91e.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog116.obsmtp.com ([74.125.149.240]:55758 "EHLO
	na3sys009aog116.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752474Ab2B1JjG convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 28 Feb 2012 04:39:06 -0500
Received: by mail-qy0-f177.google.com with SMTP id u28so1072478qcs.22
        for <linux-omap@vger.kernel.org>; Tue, 28 Feb 2012 01:39:06 -0800 (PST)
In-Reply-To: <87ty2bu91e.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, grant.likely@secretlab.ca, tony@atomide.com, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Tue, Feb 28, 2012 at 5:24 AM, Kevin Hilman <khilman@ti.com> wrote:
> Tarun Kanti DebBarma <tarun.kanti@ti.com> writes:
>
>> Since we already have bank->context.wake_en to keep track
>> of gpios which are wakeup enabled, there is no need to have
>> this field any more.
>>
>> Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
>
> I'm not crazy about this change...
>
>> ---
>> =A0drivers/gpio/gpio-omap.c | =A0 11 +++++------
>> =A01 files changed, 5 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
>> index 64f15d5..b62e861 100644
>> --- a/drivers/gpio/gpio-omap.c
>> +++ b/drivers/gpio/gpio-omap.c
>> @@ -53,7 +53,6 @@ struct gpio_bank {
>> =A0 =A0 =A0 void __iomem *base;
>> =A0 =A0 =A0 u16 irq;
>> =A0 =A0 =A0 u16 virtual_irq_start;
>> - =A0 =A0 u32 suspend_wakeup;
>> =A0 =A0 =A0 u32 non_wakeup_gpios;
>> =A0 =A0 =A0 u32 enabled_non_wakeup_gpios;
>> =A0 =A0 =A0 struct gpio_regs context;
>> @@ -497,9 +496,9 @@ static int _set_gpio_wakeup(struct gpio_bank *ba=
nk, int gpio, int enable)
>>
>> =A0 =A0 =A0 spin_lock_irqsave(&bank->lock, flags);
>> =A0 =A0 =A0 if (enable)
>> - =A0 =A0 =A0 =A0 =A0 =A0 bank->suspend_wakeup |=3D gpio_bit;
>> + =A0 =A0 =A0 =A0 =A0 =A0 bank->context.wake_en |=3D gpio_bit;
>> =A0 =A0 =A0 else
>> - =A0 =A0 =A0 =A0 =A0 =A0 bank->suspend_wakeup &=3D ~gpio_bit;
>> + =A0 =A0 =A0 =A0 =A0 =A0 bank->context.wake_en &=3D ~gpio_bit;
>
> The bank->context values are expected to be copies of the actual
> register contents, and here that is clearly not the case.
Right, it should have been this:

        if (enable)
-               bank->suspend_wakeup |=3D gpio_bit;
+               bank->context.wake_en |=3D gpio_bit;
        else
-               bank->suspend_wakeup &=3D ~gpio_bit;
+               bank->context.wake_en &=3D ~gpio_bit;
+
+       __raw_writel(bank->context.wake_en, bank->base + bank->regs->wk=
up_en);

>
> With this change, you're using the context register to track changes
> that you *might* eventually write to the register.
The above change ensures that bank->context.wake_en reflects the
latest register value.
There are two distinct paths through which bank->context.wake_en is
updated now, viz:
Path1:-
chip.irq_set_type() --> gpio_irq_type() --> _set_gpio_triggering() -->
set_gpio_trigger()

Path2:-
chip.irq_set_wake() --> gpio_wake_enable() --> irq_set_wake()

>
> IMO, this is more confusing than having a separate field to track thi=
s.
So, there is no need have a separate field to keep track of this.
I hope my understanding is right.
--
Tarun

>
> Kevin
>
>> =A0 =A0 =A0 spin_unlock_irqrestore(&bank->lock, flags);
>>
>> @@ -772,7 +771,7 @@ static int omap_mpuio_suspend_noirq(struct devic=
e *dev)
>>
>> =A0 =A0 =A0 spin_lock_irqsave(&bank->lock, flags);
>> =A0 =A0 =A0 bank->context.wake_en =3D __raw_readl(mask_reg);
>> - =A0 =A0 __raw_writel(0xffff & ~bank->suspend_wakeup, mask_reg);
>> + =A0 =A0 __raw_writel(0xffff & ~bank->context.wake_en, mask_reg);
>> =A0 =A0 =A0 spin_unlock_irqrestore(&bank->lock, flags);
>>
>> =A0 =A0 =A0 return 0;
>> @@ -1137,12 +1136,12 @@ static int omap_gpio_suspend(struct device *=
dev)
>> =A0 =A0 =A0 if (!bank->mod_usage || !bank->loses_context)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
>>
>> - =A0 =A0 if (!bank->regs->wkup_en || !bank->suspend_wakeup)
>> + =A0 =A0 if (!bank->regs->wkup_en || !bank->context.wake_en)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
>>
>> =A0 =A0 =A0 spin_lock_irqsave(&bank->lock, flags);
>> =A0 =A0 =A0 _gpio_rmw(base, bank->regs->wkup_en, 0xffffffff, 0);
>> - =A0 =A0 _gpio_rmw(base, bank->regs->wkup_en, bank->suspend_wakeup,=
 1);
>> + =A0 =A0 _gpio_rmw(base, bank->regs->wkup_en, bank->context.wake_en=
, 1);
>> =A0 =A0 =A0 spin_unlock_irqrestore(&bank->lock, flags);
>>
>> =A0 =A0 =A0 return 0;
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
