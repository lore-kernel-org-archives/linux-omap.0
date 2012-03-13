From: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Subject: Re: [PATCH v3 11/13] gpio/omap: fix dataout register overwrite in _set_gpio_dataout_*
Date: Tue, 13 Mar 2012 11:33:17 +0530
Message-ID: <CAC83ZvJ5rjNJoSZW=j=DXQWKWGgr_Wqu8ukOubxKd7xuEQ4pzQ@mail.gmail.com>
References: <1331118963-26364-1-git-send-email-tarun.kanti@ti.com>
	<1331118963-26364-12-git-send-email-tarun.kanti@ti.com>
	<87y5r5wkmu.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog120.obsmtp.com ([74.125.149.140]:44076 "EHLO
	na3sys009aog120.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759694Ab2CMGDS convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 13 Mar 2012 02:03:18 -0400
Received: by ggnk1 with SMTP id k1so249250ggn.22
        for <linux-omap@vger.kernel.org>; Mon, 12 Mar 2012 23:03:17 -0700 (PDT)
In-Reply-To: <87y5r5wkmu.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, tony@atomide.com, linux-arm-kernel@lists.infradead.org

On Tue, Mar 13, 2012 at 3:24 AM, Kevin Hilman <khilman@ti.com> wrote:
> Tarun Kanti DebBarma <tarun.kanti@ti.com> writes:
>
>> In the existing _set_gpio_dataout_*() implementation, the dataout
>> register is overwritten every time the function is called. This is
>> not intended behavior because that would end up one user of a GPIO
>> line overwriting what is written by another. Fix this so that previo=
us
>> value is always preserved until explicitly changed by respective
>> user/driver of the GPIO line.
>>
>> Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
>> ---
>> =A0drivers/gpio/gpio-omap.c | =A0 =A03 +++
>> =A01 files changed, 3 insertions(+), 0 deletions(-)
>>
>> diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
>> index 04c2677..2e8e476 100644
>> --- a/drivers/gpio/gpio-omap.c
>> +++ b/drivers/gpio/gpio-omap.c
>> @@ -114,6 +114,7 @@ static void _set_gpio_dataout_reg(struct gpio_ba=
nk *bank, int gpio, int enable)
>> =A0 =A0 =A0 else
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg +=3D bank->regs->clr_dataout;
>>
>> + =A0 =A0 l |=3D __raw_readl(bank->base + bank->regs->set_dataout);
>
> minor: IMO, it's more reader-friendly if this looks like
>
> =A0 =A0 =A0 l =3D __raw_read(...)
> =A0 =A0 =A0 l |=3D GPIO_BIT(...)
> =A0 =A0 =A0 __raw_write(...)
Agreed. I will make the change.

>
>> =A0 =A0 =A0 __raw_writel(l, reg);
>> =A0 =A0 =A0 bank->context.dataout =3D l;
>> =A0}
>> @@ -130,6 +131,8 @@ static void _set_gpio_dataout_mask(struct gpio_b=
ank *bank, int gpio, int enable)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 l |=3D gpio_bit;
>> =A0 =A0 =A0 else
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 l &=3D ~gpio_bit;
>> +
>> + =A0 =A0 l |=3D __raw_readl(bank->base + bank->regs->set_dataout);
>
> There's already a __raw_read() in this function just above.
Right. Thanks.
--
Tarun
>
>> =A0 =A0 =A0 __raw_writel(l, reg);
>> =A0 =A0 =A0 bank->context.dataout =3D l;
>> =A0}
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
