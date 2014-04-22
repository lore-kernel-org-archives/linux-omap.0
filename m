From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 0/5] GPIO OMAP driver changes for v3.16
Date: Tue, 22 Apr 2014 15:00:35 +0200
Message-ID: <CACRpkdYSDe=EfJxhC2Fx3AJZdY66BPr_t6ATcvSW9qaAA=ZJEw@mail.gmail.com>
References: <1396796297-13002-1-git-send-email-javier.martinez@collabora.co.uk>
	<CACRpkdarYt4tAD9WMDu6Me+dhipVyDHMpgF-AQ8SDNKMmhSjsA@mail.gmail.com>
	<20140410193048.GE15736@drone.musicnaut.iki.fi>
	<CABxcv=miFY3gE6HOU5ovWwCzgC6Un3ANh_Weh_bPCb7OoYQ+pA@mail.gmail.com>
	<20140410212202.GF15736@drone.musicnaut.iki.fi>
	<CABxcv=k9fNauvoF6No_GGhfVVgOvyd-Dgw2YLkGGfPoXfMd=FQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ob0-f181.google.com ([209.85.214.181]:36826 "EHLO
	mail-ob0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751383AbaDVNAg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 22 Apr 2014 09:00:36 -0400
Received: by mail-ob0-f181.google.com with SMTP id gq1so5705590obb.12
        for <linux-omap@vger.kernel.org>; Tue, 22 Apr 2014 06:00:35 -0700 (PDT)
In-Reply-To: <CABxcv=k9fNauvoF6No_GGhfVVgOvyd-Dgw2YLkGGfPoXfMd=FQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Javier Martinez Canillas <javier@dowhile0.org>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, Javier Martinez Canillas <javier.martinez@collabora.co.uk>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Kevin Hilman <khilman@linaro.org>, Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>, Nishanth Menon <nm@ti.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Linux-OMAP <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Fri, Apr 11, 2014 at 5:03 PM, Javier Martinez Canillas
<javier@dowhile0.org> wrote:
> Hello Aaro,
>
> On Thu, Apr 10, 2014 at 11:22 PM, Aaro Koskinen <aaro.koskinen@iki.fi> wrote:
>> Hi,
>>
>> On Thu, Apr 10, 2014 at 10:17:44PM +0200, Javier Martinez Canillas wrote:
>>> > The same happens also on Nokia 770:
>>> >
>>> > [    0.118896] genirq: Setting trigger mode 0 for irq 128 failed (gpio_irq_type+0x0/0x220)
>>>
>>> I don't have those errors when booting on my DM3730 IGEPv2 board but
>>> it seems that for some reason on omap1  __irq_set_trigger() complains
>>> when IRQ_TYPE_NONE is used as a default flag when calling
>>> gpiochip_irqchip_add()
>>>
>>> Could you please test the following patch and tell me if your board
>>> still works and makes the errors go away?
>>
>> Now it complains about mode 8...
>>
>> [    0.118835] genirq: Setting trigger mode 8 for irq 128 failed (gpio_irq_type
>> +0x0/0x220)
>>
>> A.
>>
>>> diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
>>> index 8cc9e91..5bc8aec 100644
>>> --- a/drivers/gpio/gpio-omap.c
>>> +++ b/drivers/gpio/gpio-omap.c
>>> @@ -1122,7 +1122,7 @@ static int omap_gpio_chip_init(struct gpio_bank *bank)
>>>
>>>         ret = gpiochip_irqchip_add(&bank->chip, &gpio_irq_chip,
>>>                                    irq_base, gpio_irq_handler,
>>> -                                  IRQ_TYPE_NONE);
>>> +                                  IRQ_TYPE_LEVEL_LOW);
>>>
>>>         if (ret) {
>>>                 dev_err(bank->dev, "Couldn't add irqchip to gpiochip
>>> %d\n", ret);
>>>
>>> Best regards,
>>> Javier
>
> Thanks for testing. Unfortunately I'm out of ideas on why that error
> could be shown and I don't have a way to further debug it without an
> omap1 board. I wonder why that pr_err() message is shown or why it is
> still working when an error happens.
>
> Maybe Linus or Santosh could give us a hint on what is happening here.

Isn't an edge IRQ more apropriate as default then?

The code contains this:

    if (!bank->regs->leveldetect0 &&
        (type & (IRQ_TYPE_LEVEL_LOW|IRQ_TYPE_LEVEL_HIGH)))
        return -EINVAL;

Meaning sometimes the banks don't support level IRQs.

Yours,
Linus Walleij
