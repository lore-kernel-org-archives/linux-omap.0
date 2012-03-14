From: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Subject: Re: [PATCH v3 11/13] gpio/omap: fix dataout register overwrite in _set_gpio_dataout_*
Date: Wed, 14 Mar 2012 07:23:20 +0530
Message-ID: <CAC83ZvLkPEu5usQsS9-5nVGdhz69vq3XQYaTwFBjo0FSnS8_Ng@mail.gmail.com>
References: <1331118963-26364-1-git-send-email-tarun.kanti@ti.com>
	<1331118963-26364-12-git-send-email-tarun.kanti@ti.com>
	<87y5r5wkmu.fsf@ti.com>
	<CAC83ZvJ5rjNJoSZW=j=DXQWKWGgr_Wqu8ukOubxKd7xuEQ4pzQ@mail.gmail.com>
	<CAC83Zv+CZOGnSpOJgfCgEv-eyWXZzV+_mmd37CBMKM6iMtEksQ@mail.gmail.com>
	<CAC83ZvLmaLOr4_eZZzKyP2=KvkG+LjHjeOwvxdQHhuiB8+2L0w@mail.gmail.com>
	<8762e8v53q.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:37805 "EHLO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S964778Ab2CNBxW convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 13 Mar 2012 21:53:22 -0400
Received: by yhnn12 with SMTP id n12so1294124yhn.10
        for <linux-omap@vger.kernel.org>; Tue, 13 Mar 2012 18:53:20 -0700 (PDT)
In-Reply-To: <8762e8v53q.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, tony@atomide.com, linux-arm-kernel@lists.infradead.org

On Tue, Mar 13, 2012 at 9:57 PM, Kevin Hilman <khilman@ti.com> wrote:
> "DebBarma, Tarun Kanti" <tarun.kanti@ti.com> writes:
>
>> On Tue, Mar 13, 2012 at 12:03 PM, DebBarma, Tarun Kanti
>> <tarun.kanti@ti.com> wrote:
>>> On Tue, Mar 13, 2012 at 11:33 AM, DebBarma, Tarun Kanti
>>> <tarun.kanti@ti.com> wrote:
>>>> On Tue, Mar 13, 2012 at 3:24 AM, Kevin Hilman <khilman@ti.com> wro=
te:
>>>>> Tarun Kanti DebBarma <tarun.kanti@ti.com> writes:
>>>>>
>>>>>> In the existing _set_gpio_dataout_*() implementation, the dataou=
t
>>>>>> register is overwritten every time the function is called. This =
is
>>>>>> not intended behavior because that would end up one user of a GP=
IO
>>>>>> line overwriting what is written by another. Fix this so that pr=
evious
>>>>>> value is always preserved until explicitly changed by respective
>>>>>> user/driver of the GPIO line.
>>>>>>
>>>>>> Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
>>>>>> ---
>>>>>> =A0drivers/gpio/gpio-omap.c | =A0 =A03 +++
>>>>>> =A01 files changed, 3 insertions(+), 0 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
>>>>>> index 04c2677..2e8e476 100644
>>>>>> --- a/drivers/gpio/gpio-omap.c
>>>>>> +++ b/drivers/gpio/gpio-omap.c
>>>>>> @@ -114,6 +114,7 @@ static void _set_gpio_dataout_reg(struct gpi=
o_bank *bank, int gpio, int enable)
>>>>>> =A0 =A0 =A0 else
>>>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg +=3D bank->regs->clr_dataout;
>>>>>>
>>>>>> + =A0 =A0 l |=3D __raw_readl(bank->base + bank->regs->set_dataou=
t);
>>>>>
>>>>> minor: IMO, it's more reader-friendly if this looks like
>>>>>
>>>>> =A0 =A0 =A0 l =3D __raw_read(...)
>>>>> =A0 =A0 =A0 l |=3D GPIO_BIT(...)
>>>>> =A0 =A0 =A0 __raw_write(...)
>>>> Agreed. I will make the change.
>>> Also, the read should be: __raw_readl(bank->base + bank->regs->data=
out);
>>> instead of bank->regs->set_dataout.
>> I see a problem with this implementation. It is not correct to write=
 l
>> |=3D GPIO_BIT(...).
>> For example if we write to clr_dataout register we would end up
>> clearing bits which
>> we are not supposed to. We should just be operating on current GPIO_=
BIT(...).
>> The l |=3D GPIO_BIT(...) is needed just to make sure that we have th=
e
>> right context
>> stored. So the overall sequence should be something like this:
>>
>> =A0 =A0 =A0 =A0 void __iomem *reg =3D bank->base;
>> =A0 =A0 =A0 =A0 u32 l =3D GPIO_BIT(bank, gpio);
>>
>> =A0 =A0 =A0 =A0 if (enable)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg +=3D bank->regs->set_dataout;
>> =A0 =A0 =A0 =A0 else
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg +=3D bank->regs->clr_dataout;
>>
>> =A0 =A0 =A0 =A0 __raw_writel(l, reg);
>> =A0 =A0 =A0 =A0 l |=3D __raw_readl(bank->base + bank->regs->dataout)=
;
>> =A0 =A0 =A0 =A0 bank->context.dataout =3D l;
>
> Again, you don't need the extra read-back here. =A0Just set/clear the=
 bit
> in the context. =A0Untested patch below.
Alright.
--
Tarun
>
> Kevin
>
>
> diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
> index 0b05629..db905c0 100644
> --- a/drivers/gpio/gpio-omap.c
> +++ b/drivers/gpio/gpio-omap.c
> @@ -111,10 +111,13 @@ static void _set_gpio_dataout_reg(struct gpio_b=
ank *bank, int gpio, int enable)
> =A0 =A0 =A0 =A0void __iomem *reg =3D bank->base;
> =A0 =A0 =A0 =A0u32 l =3D GPIO_BIT(bank, gpio);
>
> - =A0 =A0 =A0 if (enable)
> + =A0 =A0 =A0 if (enable) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0reg +=3D bank->regs->set_dataout;
> - =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 bank->context.dataout |=3D l;
> + =A0 =A0 =A0 } else {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0reg +=3D bank->regs->clr_dataout;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 bank->context.dataout &=3D ~l;
> + =A0 =A0 =A0 }
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
