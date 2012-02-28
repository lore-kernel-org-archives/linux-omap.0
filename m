From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: OMAP gpio handling
Date: Tue, 28 Feb 2012 21:29:08 +0100
Message-ID: <4F4D3914.90401@ti.com>
References: <20120225130444.GJ22675@n2100.arm.linux.org.uk> <CAC83ZvL7w5tL7q1zqaPWk3df2XXVGEpm+_TH5_OFD4pNDxXpZQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:57532 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965025Ab2B1U3W (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 28 Feb 2012 15:29:22 -0500
In-Reply-To: <CAC83ZvL7w5tL7q1zqaPWk3df2XXVGEpm+_TH5_OFD4pNDxXpZQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, "Hilman, Kevin" <khilman@ti.com>

+ Kevin

Hi Tarun,

On 2/27/2012 8:11 AM, DebBarma, Tarun Kanti wrote:
> On Sat, Feb 25, 2012 at 6:34 PM, Russell King - ARM Linux
> <linux@arm.linux.org.uk>  wrote:
>> Can someone explain to me this:
>>
>> #define GPIO_INDEX(bank, gpio) (gpio % bank->width)
>> #define GPIO_BIT(bank, gpio) (1<<  GPIO_INDEX(bank, gpio))
>>
>> static int _get_gpio_datain(struct gpio_bank *bank, int gpio)
>> {
>>         void __iomem *reg = bank->base + bank->regs->datain;
>>
>>         return (__raw_readl(reg)&  GPIO_BIT(bank, gpio)) != 0;
>> }
>>
>> static int gpio_get(struct gpio_chip *chip, unsigned offset)
>> {
>>         struct gpio_bank *bank = container_of(chip, struct gpio_bank, chip);
>>         void __iomem *reg = bank->base;
>>         int gpio = chip->base + offset;
>>         u32 mask = GPIO_BIT(bank, gpio);
>>
>>         if (gpio_is_input(bank, mask))
>>                 return _get_gpio_datain(bank, gpio);
>>         else
>>                 return _get_gpio_dataout(bank, gpio);
>> }
>>
>> Given that bank->width on OMAP is either 32 or 16, and GPIO numbers for
>> any GPIO chip are always aligned to 32 or 16, why does this code bother
>> adding the chips base gpio number and then modulo the width?
> As far as I understand we could very well use offset directly.
> The macro is used to derive the same offset value in this case.
> Therefore, _get_gpio_datain(bank, gpio) and _get_gpio_dataout(bank, gpio)
> can be passed offset instead of (bank->base + offset) as suggested by you below.
> And of course, offset can be used to derive mask both here and in the
> called functions.
>
>>
>> Surely this means if - for argument sake - you registered a GPIO chip
>> with 8 lines followed by one with 16 lines, GPIO0..7 would be chip 0
>> bit 0..7, GPIO8..15 would be chip 1 bit 8..15, GPIO16..23 would be
>> chip 1 bit 0..7.
>>
>> However, if you registered a GPIO chip with 16 lines first, it would
>> mean GPIO0..15 would be chip 0 bit 0..15, and GPIO16..31 would be
>> chip 1 bit 0..15.
>>
>> Surely this kind of behaviour is not intended?
>>
>> Is there a reason why the bitmask can't just be (1<<  offset) where
>> offset is passed into these functions as GPIO number - chip->base ?
> Yes, I have made the following changes and tested on OMAP4 and OMAP1(bootup).
>
> [PATCH] gpio/omap: remove redundant decoding of gpio offset
> ---
>   drivers/gpio/gpio-omap.c |   18 +++++++-----------
>   1 files changed, 7 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
> index 5953ece..2196747 100644
> --- a/drivers/gpio/gpio-omap.c
> +++ b/drivers/gpio/gpio-omap.c
> @@ -133,18 +133,18 @@ static void _set_gpio_dataout_mask(struct
> gpio_bank *bank, int gpio, int enable)
>          bank->context.dataout = l;
>   }
>
> -static int _get_gpio_datain(struct gpio_bank *bank, int gpio)
> +static int _get_gpio_datain(struct gpio_bank *bank, int offset)
>   {
>          void __iomem *reg = bank->base + bank->regs->datain;
>
> -       return (__raw_readl(reg)&  GPIO_BIT(bank, gpio)) != 0;
> +       return (__raw_readl(reg)&  (1<<  offset)) != 0;
>   }
>
> -static int _get_gpio_dataout(struct gpio_bank *bank, int gpio)
> +static int _get_gpio_dataout(struct gpio_bank *bank, int offset)
>   {
>          void __iomem *reg = bank->base + bank->regs->dataout;
>
> -       return (__raw_readl(reg)&  GPIO_BIT(bank, gpio)) != 0;
> +       return (__raw_readl(reg)&  (1<<  offset)) != 0;
>   }
>
>   static inline void _gpio_rmw(void __iomem *base, u32 reg, u32 mask, bool set)
> @@ -849,19 +849,15 @@ static int gpio_is_input(struct gpio_bank *bank, int mask)
>   static int gpio_get(struct gpio_chip *chip, unsigned offset)
>   {
>          struct gpio_bank *bank;
> -       void __iomem *reg;
> -       int gpio;
>          u32 mask;
>
> -       gpio = chip->base + offset;
>          bank = container_of(chip, struct gpio_bank, chip);
> -       reg = bank->base;

That one seems to be a leftover from before the cleanup and was already 
not needed but it is not related to the offset fix.

You should just add that in the changelog or include it in previous 
cleanup if applicable.

> -       mask = GPIO_BIT(bank, gpio);
> +       mask = (1<<  offset);
>
>          if (gpio_is_input(bank, mask))
> -               return _get_gpio_datain(bank, gpio);
> +               return _get_gpio_datain(bank, offset);
>          else
> -               return _get_gpio_dataout(bank, gpio);
> +               return _get_gpio_dataout(bank, offset);
>   }
>
>   static int gpio_output(struct gpio_chip *chip, unsigned offset, int value)
> --
> 1.7.0.4

That patch seems good to me and should definitively be part of your 
cleanup series.
Could you repost to a wider audience including lakml and Grant?

I guess you can do that in the v2 of the previous series including 
Kevin's comments.

Thanks,
Benoit
