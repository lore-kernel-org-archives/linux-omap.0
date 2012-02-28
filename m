From: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Subject: Re: [PATCH 2/6] gpio/omap: remove saved_wakeup field from struct gpio_bank
Date: Tue, 28 Feb 2012 10:38:35 +0530
Message-ID: <CAC83Zv+3mBqwCy6Aj0pF70w_rsQXpChDojGUWBuuwLd=6TVdGA@mail.gmail.com>
References: <1329999031-6914-1-git-send-email-tarun.kanti@ti.com>
	<1329999031-6914-3-git-send-email-tarun.kanti@ti.com>
	<87aa43vnsv.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog122.obsmtp.com ([74.125.149.147]:46036 "HELO
	na3sys009aog122.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751304Ab2B1FIg convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 28 Feb 2012 00:08:36 -0500
Received: by mail-qw0-f45.google.com with SMTP id i31so1981447qaf.11
        for <linux-omap@vger.kernel.org>; Mon, 27 Feb 2012 21:08:35 -0800 (PST)
In-Reply-To: <87aa43vnsv.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, grant.likely@secretlab.ca, tony@atomide.com, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Tue, Feb 28, 2012 at 5:20 AM, Kevin Hilman <khilman@ti.com> wrote:
> Tarun Kanti DebBarma <tarun.kanti@ti.com> writes:
>
>> There is no more need to have saved_wakeup. Instead we can use
>> context.wake_en which holds the current wakeup enable register
>> context. This also means that the read from wakeup enable register
>> is not needed.
>>
>> Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
>
> Looks right, but one question below...
>
>> ---
>> =A0drivers/gpio/gpio-omap.c | =A0 13 ++++---------
>> =A01 files changed, 4 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
>> index 40a1fb2..64f15d5 100644
>> --- a/drivers/gpio/gpio-omap.c
>> +++ b/drivers/gpio/gpio-omap.c
>> @@ -54,7 +54,6 @@ struct gpio_bank {
>> =A0 =A0 =A0 u16 irq;
>> =A0 =A0 =A0 u16 virtual_irq_start;
>> =A0 =A0 =A0 u32 suspend_wakeup;
>> - =A0 =A0 u32 saved_wakeup;
>> =A0 =A0 =A0 u32 non_wakeup_gpios;
>> =A0 =A0 =A0 u32 enabled_non_wakeup_gpios;
>> =A0 =A0 =A0 struct gpio_regs context;
>> @@ -772,7 +771,7 @@ static int omap_mpuio_suspend_noirq(struct devic=
e *dev)
>> =A0 =A0 =A0 unsigned long =A0 =A0 =A0 =A0 =A0 flags;
>>
>> =A0 =A0 =A0 spin_lock_irqsave(&bank->lock, flags);
>> - =A0 =A0 bank->saved_wakeup =3D __raw_readl(mask_reg);
>> + =A0 =A0 bank->context.wake_en =3D __raw_readl(mask_reg);
>
> Why is this read needed?
Well, we don't really need as we already have context.wake_en updated e=
lsewhere.
I will update this. Thanks.
--
Tarun
>
> Kevin
>
>> =A0 =A0 =A0 __raw_writel(0xffff & ~bank->suspend_wakeup, mask_reg);
>> =A0 =A0 =A0 spin_unlock_irqrestore(&bank->lock, flags);
>>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
