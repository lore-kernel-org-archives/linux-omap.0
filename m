From: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Subject: Re: OMAP gpio handling
Date: Wed, 29 Feb 2012 09:02:17 +0530
Message-ID: <CAC83ZvLG8rnbGLjDSo9EH14HS5w9k=KHQ8CSgOzdQ=uD0Sfsig@mail.gmail.com>
References: <20120225130444.GJ22675@n2100.arm.linux.org.uk>
	<CAC83ZvL7w5tL7q1zqaPWk3df2XXVGEpm+_TH5_OFD4pNDxXpZQ@mail.gmail.com>
	<4F4D3914.90401@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog126.obsmtp.com ([74.125.149.155]:44153 "EHLO
	na3sys009aog126.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757032Ab2B2DcT convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 28 Feb 2012 22:32:19 -0500
Received: by qcmt36 with SMTP id t36so1573709qcm.15
        for <linux-omap@vger.kernel.org>; Tue, 28 Feb 2012 19:32:17 -0800 (PST)
In-Reply-To: <4F4D3914.90401@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, "Hilman, Kevin" <khilman@ti.com>

On Wed, Feb 29, 2012 at 1:59 AM, Cousson, Benoit <b-cousson@ti.com> wro=
te:
> + Kevin
>
> Hi Tarun,
>
>
> On 2/27/2012 8:11 AM, DebBarma, Tarun Kanti wrote:
>>
>> On Sat, Feb 25, 2012 at 6:34 PM, Russell King - ARM Linux
>> <linux@arm.linux.org.uk> =A0wrote:
>>>
>>> Can someone explain to me this:
>>>
>>> #define GPIO_INDEX(bank, gpio) (gpio % bank->width)
>>> #define GPIO_BIT(bank, gpio) (1<< =A0GPIO_INDEX(bank, gpio))
>>>
>>> static int _get_gpio_datain(struct gpio_bank *bank, int gpio)
>>> {
>>> =A0 =A0 =A0 =A0void __iomem *reg =3D bank->base + bank->regs->datai=
n;
>>>
>>> =A0 =A0 =A0 =A0return (__raw_readl(reg)& =A0GPIO_BIT(bank, gpio)) !=
=3D 0;
>>>
>>> }
>>>
>>> static int gpio_get(struct gpio_chip *chip, unsigned offset)
>>> {
>>> =A0 =A0 =A0 =A0struct gpio_bank *bank =3D container_of(chip, struct=
 gpio_bank,
>>> chip);
>>> =A0 =A0 =A0 =A0void __iomem *reg =3D bank->base;
>>> =A0 =A0 =A0 =A0int gpio =3D chip->base + offset;
>>> =A0 =A0 =A0 =A0u32 mask =3D GPIO_BIT(bank, gpio);
>>>
>>> =A0 =A0 =A0 =A0if (gpio_is_input(bank, mask))
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return _get_gpio_datain(bank, gpio);
>>> =A0 =A0 =A0 =A0else
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return _get_gpio_dataout(bank, gpio)=
;
>>> }
>>>
>>> Given that bank->width on OMAP is either 32 or 16, and GPIO numbers=
 for
>>> any GPIO chip are always aligned to 32 or 16, why does this code bo=
ther
>>> adding the chips base gpio number and then modulo the width?
>>
>> As far as I understand we could very well use offset directly.
>> The macro is used to derive the same offset value in this case.
>> Therefore, _get_gpio_datain(bank, gpio) and _get_gpio_dataout(bank, =
gpio)
>> can be passed offset instead of (bank->base + offset) as suggested b=
y you
>> below.
>> And of course, offset can be used to derive mask both here and in th=
e
>> called functions.
>>
>>>
>>> Surely this means if - for argument sake - you registered a GPIO ch=
ip
>>> with 8 lines followed by one with 16 lines, GPIO0..7 would be chip =
0
>>> bit 0..7, GPIO8..15 would be chip 1 bit 8..15, GPIO16..23 would be
>>> chip 1 bit 0..7.
>>>
>>> However, if you registered a GPIO chip with 16 lines first, it woul=
d
>>> mean GPIO0..15 would be chip 0 bit 0..15, and GPIO16..31 would be
>>> chip 1 bit 0..15.
>>>
>>> Surely this kind of behaviour is not intended?
>>>
>>> Is there a reason why the bitmask can't just be (1<< =A0offset) whe=
re
>>> offset is passed into these functions as GPIO number - chip->base ?
>>
>> Yes, I have made the following changes and tested on OMAP4 and
>> OMAP1(bootup).
>>
>> [PATCH] gpio/omap: remove redundant decoding of gpio offset
>> ---
>> =A0drivers/gpio/gpio-omap.c | =A0 18 +++++++-----------
>> =A01 files changed, 7 insertions(+), 11 deletions(-)
>>
>> diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
>> index 5953ece..2196747 100644
>> --- a/drivers/gpio/gpio-omap.c
>> +++ b/drivers/gpio/gpio-omap.c
>> @@ -133,18 +133,18 @@ static void _set_gpio_dataout_mask(struct
>> gpio_bank *bank, int gpio, int enable)
>> =A0 =A0 =A0 =A0 bank->context.dataout =3D l;
>> =A0}
>>
>> -static int _get_gpio_datain(struct gpio_bank *bank, int gpio)
>> +static int _get_gpio_datain(struct gpio_bank *bank, int offset)
>> =A0{
>> =A0 =A0 =A0 =A0 void __iomem *reg =3D bank->base + bank->regs->datai=
n;
>>
>> - =A0 =A0 =A0 return (__raw_readl(reg)& =A0GPIO_BIT(bank, gpio)) !=3D=
 0;
>> + =A0 =A0 =A0 return (__raw_readl(reg)& =A0(1<< =A0offset)) !=3D 0;
>>
>> =A0}
>>
>> -static int _get_gpio_dataout(struct gpio_bank *bank, int gpio)
>> +static int _get_gpio_dataout(struct gpio_bank *bank, int offset)
>> =A0{
>> =A0 =A0 =A0 =A0 void __iomem *reg =3D bank->base + bank->regs->datao=
ut;
>>
>> - =A0 =A0 =A0 return (__raw_readl(reg)& =A0GPIO_BIT(bank, gpio)) !=3D=
 0;
>> + =A0 =A0 =A0 return (__raw_readl(reg)& =A0(1<< =A0offset)) !=3D 0;
>>
>> =A0}
>>
>> =A0static inline void _gpio_rmw(void __iomem *base, u32 reg, u32 mas=
k, bool
>> set)
>> @@ -849,19 +849,15 @@ static int gpio_is_input(struct gpio_bank *ban=
k, int
>> mask)
>> =A0static int gpio_get(struct gpio_chip *chip, unsigned offset)
>> =A0{
>> =A0 =A0 =A0 =A0 struct gpio_bank *bank;
>> - =A0 =A0 =A0 void __iomem *reg;
>> - =A0 =A0 =A0 int gpio;
>> =A0 =A0 =A0 =A0 u32 mask;
>>
>> - =A0 =A0 =A0 gpio =3D chip->base + offset;
>> =A0 =A0 =A0 =A0 bank =3D container_of(chip, struct gpio_bank, chip);
>> - =A0 =A0 =A0 reg =3D bank->base;
>
>
> That one seems to be a leftover from before the cleanup and was alrea=
dy not
> needed but it is not related to the offset fix.
>
> You should just add that in the changelog or include it in previous c=
leanup
> if applicable.
>
>
>> - =A0 =A0 =A0 mask =3D GPIO_BIT(bank, gpio);
>> + =A0 =A0 =A0 mask =3D (1<< =A0offset);
>>
>> =A0 =A0 =A0 =A0 if (gpio_is_input(bank, mask))
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return _get_gpio_datain(bank, gpio);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return _get_gpio_datain(bank, offset);
>> =A0 =A0 =A0 =A0 else
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return _get_gpio_dataout(bank, gpio);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return _get_gpio_dataout(bank, offset)=
;
>> =A0}
>>
>> =A0static int gpio_output(struct gpio_chip *chip, unsigned offset, i=
nt
>> value)
>> --
>> 1.7.0.4
>
>
> That patch seems good to me and should definitively be part of your c=
leanup
> series.
> Could you repost to a wider audience including lakml and Grant?
>
> I guess you can do that in the v2 of the previous series including Ke=
vin's
> comments.
Yes, I have created a patch already as part of v2.
I was waiting for any further comment from the community.
Anyways, thanks.
--
Tarun
>
> Thanks,
> Benoit
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
